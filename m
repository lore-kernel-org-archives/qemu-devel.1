Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7689C34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8417924654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhOsaIL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8417924654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QNv-0007FN-OD
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4QMy-0006my-KN
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4QMx-0006CI-CA
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:30:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4QMx-00069c-88
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582122630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlnAO2+Ylf6GTX4siq6FRAwbBY6lpS7BPiPM6ipEj7A=;
 b=MhOsaIL79uw5oRekcVMmEXlST5uR7ho1XvY/jvICd2J1jlH+gYgWMX7Lvg/O5bcCn3zc23
 809tivGHe1/IqqO6C6RUmoEHoXCYsaOjP+xzQw7pppVJHUhFaaRPn/ZCCmC51OM0WGMFq5
 MfBX9quFOU+mZyvX51mh4YbWNjsfw3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-LT60ei_vO_2HcSSNNEUpJw-1; Wed, 19 Feb 2020 09:30:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B31DB1800D42
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 14:30:27 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08CD648;
 Wed, 19 Feb 2020 14:30:24 +0000 (UTC)
Date: Wed, 19 Feb 2020 15:30:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v5 79/79] tests:numa-test: use explicit memdev to
 specify node RAM
Message-ID: <20200219153022.308689a5@redhat.com>
In-Reply-To: <a384bc9c-44bc-268a-5a0f-63bccea1542a@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-80-imammedo@redhat.com>
 <1da9a872-dd64-dd1d-7858-caf263631484@redhat.com>
 <20200219140030.4e68d053@redhat.com>
 <a384bc9c-44bc-268a-5a0f-63bccea1542a@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: LT60ei_vO_2HcSSNNEUpJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Feb 2020 15:06:24 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/19/20 2:00 PM, Igor Mammedov wrote:
> > On Tue, 18 Feb 2020 18:51:34 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> On 2/17/20 6:34 PM, Igor Mammedov wrote: =20
> >>> Follow up patches will remove automatic RAM distribution
> >>> between nodes and will make default machine types require
> >>> "memdev" option instead of legacy "mem" option. =20
> >>
> >> Can we keep this patch for the follow up? =20
> > memdev for numa was there for along time, just untested.
> > With this all numa tests switch to it instead of using
> > legacy option (+ a test for legacy option).
> > I don't think the patch should delayed along with numa
> > cleanups. =20
>=20
> I guess what confuses me is "Follow up patches *will* remove..."
I'll drop this frase since there aren't immediate "Follow up patches"
to avoid confusion

> >=20
> > It of-cause could be posted as standalone patch as well,
> > I'll leave it upto Paolo whether to merge it or not.
> >    =20
> >>>
> >>> Make tests to follow new rules and add an additional test
> >>> for legacy "mem" option on old machine type, to make sure
> >>> it won't regress in the future.
> >>>
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> Acked-by: Thomas Huth <thuth@redhat.com>
> >>> --- =20
> >> =20
> >  =20
>=20


