Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF73CC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C309F206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C309F206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJzko-0001oY-3S
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 08:14:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJzcL-0002gM-AV
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJzcK-0001BA-5j
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJzcJ-00015C-W2
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:06:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DB80883B8;
	Fri, 26 Apr 2019 12:06:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 39BDF6607D;
	Fri, 26 Apr 2019 12:05:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 7399011AAA; Fri, 26 Apr 2019 14:05:58 +0200 (CEST)
Date: Fri, 26 Apr 2019 14:05:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190426120558.vh66gugqtvcc6tm5@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
	<20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
	<CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 26 Apr 2019 12:06:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 05/11] vhost-user: add
 vhost_user_gpu_set_socket()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426120558.4G8re9N29s7I7u11_eGxy29EmpFCTBWfen_YBs-U_Uk@z>

  Hi,

> > > +Wire format
> > > +===========
> > > +
> > > +Unless specified differently, numbers are in the machine native byte
> > > +order.
> > > +
> > > +A vhost-user-gpu request consists of 2 header fields and a payload.
> > > +
> > > ++---------+------+---------+
> > > +| request | size | payload |
> > > ++---------+------+---------+
> > > +
> > > +Header
> > > +------
> > > +
> > > +:request: ``u32``, type of the request
> > > +
> > > +:size: ``u32``, size of the payload
> > > +
> > > +A reply consists only of a payload, whose content depends on the request.
> >
> > I'd suggest to use the same format for replies, only with "request"
> > meaning "status" in replies.  Allows for OK/ERROR status in replies,
> > and having a size field in replies too should make things more robust.
> > Also allows for an empty reply (status=ok,size=0).
> 
> 
> That brings more questions and ambiguity imho.

What questions for example?

> Can we leave that for future protocol extensions negotiated with
> GET/SET_PROTOCOL_FEATURES ?

I don't think negotiating such a basic protocol change is a good idea.

cheers,
  Gerd


