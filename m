Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84709C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FAF2064C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEY/f4Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FAF2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQ0P-0006iU-Gx
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iwPzk-0006DF-Tb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iwPzj-0003MS-Lj
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:29:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33227
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iwPzj-0003L5-HZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580214566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTSd/YSpeVwAOtsH5fVWVTow8aFKm1mQW5R7Kz5ioGw=;
 b=HEY/f4RewKbC1cmjSRVa3VMVIOfGvY0R4nr4alRHGXPj/tGEskLZH2nXrxIWn2yaAUBlp7
 2p73hDsBCJhO7XqtwhQD9GwreG+b6sIpZn8tmXTcETSXz2a0zpV0moIcuk8qrOcCwGywo9
 7A7PaTPZyf6zNVyjKeNwjfe/zKFRHAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-AW4d0mQHN5uIuxB0Wv5UWg-1; Tue, 28 Jan 2020 07:29:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 569DE800D48;
 Tue, 28 Jan 2020 12:29:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A05975C54A;
 Tue, 28 Jan 2020 12:29:17 +0000 (UTC)
Date: Tue, 28 Jan 2020 13:29:15 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [question] hw/arm/virt: about the default gic-version in
 accelerated mode
Message-ID: <20200128122915.ehzgj5kpmsw5azap@kamzik.brq.redhat.com>
References: <df1d6ae5-b734-ef64-4ef9-c661e8f797e8@redhat.com>
 <CAFEAcA8hib-3YWuS-MajjvokOFCGKUHeuz+XQTBYf8LBz+PuFQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8hib-3YWuS-MajjvokOFCGKUHeuz+XQTBYf8LBz+PuFQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: AW4d0mQHN5uIuxB0Wv5UWg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Auger Eric <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu list <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 10:52:50AM +0000, Peter Maydell wrote:
> On Tue, 28 Jan 2020 at 10:47, Auger Eric <eric.auger@redhat.com> wrote:
> > When arm virt machine is run in accelerated mode with "-cpu host
> > -machine virt", the default gic version is 2.
> >
> > I understand the rationale with TCG where we don't have MSI ITS
> > emulation along with GICv3 so we need to choose GICv2 to get GICv2M
> > functionality.
> >
> > However in KVM mode, I would have expected to see the host GIC probed t=
o
> > set the same version on guest. Indeed most of our HW now have GICv3
> > without GICv2 compat mode so our default values lead to weird traces:
> >
> > "
> > qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
> > qemu-system-aarch64: failed to set irq for PMU
> > "
> >
> > I would like to propose a patch to improve those errors and also sugges=
t
> > a hint. But I also wanted to know whether you would accept to change th=
e
> > default value with KVM and choose the host version instead of 2. For TC=
G
> > we would keep v2.
>=20
> As with the -cpu option, the default is there for command
> line backward compatibility primarily. Even if we had
> better support for MSI ITS emulation we'd still leave
> the default at GICv2.
>=20
> If you want "do the best you can, regardless of accelerator"
> that is "-cpu max -machine gic-version=3Dmax".
>

There is a case where we can probe without breaking backward
compatibility. That case is kvm-enabled and no gic-version
specified. The reason it would be safe to probe the GIC version
is because unless the host was a gicv2 host, then that command
line wouldn't have worked anyway. And, if it is a gicv2 host,
then the probing will come to the same conclusion as the
default and nothing will have changed.

Thanks,
drew


