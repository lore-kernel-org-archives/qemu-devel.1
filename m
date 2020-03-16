Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E834EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C68206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSL3mAoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C68206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuhH-0000Xa-UE
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jDufZ-0006sL-1U
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jDufX-0007BP-LI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:40:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jDufX-00073P-FP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqHgS89AZ1SPQDmaOHC1A7LpUQeQAuzHOsd8kEroIZ8=;
 b=fSL3mAoc4kpa00tDF9kyfIySithQv8LCPPS1c703giy6LPs4O12CGgkKVbW8YzyMY/e+Qa
 OEWxD2PdCYf9ORDXz7war0fclnMkvc5SfR8NhY6ApUUYpG42asGJNcf0eaQ/vW7QP8hMI0
 XzHdLVaxCCTnPWyJpC9uqFElSJ0+ra4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-bBWD0BAIO2q1CIUYNP_M3Q-1; Mon, 16 Mar 2020 14:40:52 -0400
X-MC-Unique: bBWD0BAIO2q1CIUYNP_M3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E11DC8EF18;
 Mon, 16 Mar 2020 18:40:51 +0000 (UTC)
Received: from localhost (ovpn-119-85.phx2.redhat.com [10.3.119.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D3C4166A9;
 Mon, 16 Mar 2020 18:40:47 +0000 (UTC)
Date: Mon, 16 Mar 2020 14:40:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
Message-ID: <20200316184046.GD1817047@habkost.net>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-3-ehabkost@redhat.com>
 <20200315154559.GW1187748@habkost.net>
 <20200315170229-mutt-send-email-mst@kernel.org>
 <20200316173039.GB1817047@habkost.net>
 <CAFEAcA9CYeTjmUSbMtGjDazrh1p=5vLAd3bq7JBtLd0RfnruDw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9CYeTjmUSbMtGjDazrh1p=5vLAd3bq7JBtLd0RfnruDw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 06:08:54PM +0000, Peter Maydell wrote:
> On Mon, 16 Mar 2020 at 17:51, Eduardo Habkost <ehabkost@redhat.com> wrote=
:
> > Yes, but both MAP_SYNC and MAP_SHARED_VALIDATE aren't available
> > if the host is not Linux.
> >
> > Defining MAP_SYNC to 0 on MIPS would restore the existing
> > behavior, so it seems like a reasonable step to fix the build
> > failure.  But not even printing a warning when the host doesn't
> > have MAP_SYNC (the existing behavior on MIPS and non-Linux) seems
> > wrong.
>=20
> The usual approach is that if you don't have the Linux-specific
> feature available you quietly fall back to whatever the sensible
> behaviour is for when the feature isn't present. We definitely
> don't want to be printing warnings on non-Linux systems that
> are effectively just saying "you're not running Linux". Same goes
> for "host happens not to be running a bleeding-edge Linux kernel
> and this feature isn't available yet".

I don't think using pmem=3Don without MAP_SYNC is expected to be a
supported use case, is it?  If a use case is not supported, the
sensible behavior is to tell the user it is not supported.

--=20
Eduardo


