Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E247C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FCF205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FCF205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58479 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7L5-0003hM-Gk
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:33:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hL7KD-0003Pw-OI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hL7KC-0001CT-Pv
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:32:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hL7KB-0001B2-Ef
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:32:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C4B330BC66C;
	Mon, 29 Apr 2019 14:32:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE0D717A64;
	Mon, 29 Apr 2019 14:32:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 2713211AA3; Mon, 29 Apr 2019 16:32:02 +0200 (CEST)
Date: Mon, 29 Apr 2019 16:32:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190429143202.bo5kx3p73xim75z2@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
	<20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
	<CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
	<20190426120558.vh66gugqtvcc6tm5@sirius.home.kraxel.org>
	<CAJ+F1CLE-iwZu4oX69P3r0v_94L+gJEhZH0-U0iYag=oYNN4pg@mail.gmail.com>
	<20190429071243.icqw3qbzcxbcz7ph@sirius.home.kraxel.org>
	<CAJ+F1CJx3qTNGL4u+pMHFC-LRhfPtn8WF3O=i2nW25dbgcV7tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJx3qTNGL4u+pMHFC-LRhfPtn8WF3O=i2nW25dbgcV7tQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 29 Apr 2019 14:32:06 +0000 (UTC)
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
Message-ID: <20190429143202.y5cQ6Vso_lA7udxdk4-MY-9ty1TRStbfNUBHpHwTYgY@z>

  Hi,

> > > and complicates both sides unnecessarily.
> >
> > Having headers in the reply allows it to process them in generic code.
> > There is a size header for the reply, so you can parse the stream
> > without knowing what replay to expect.  You can use the status field to
> > indicate the payload, simliar to virtio-gpu which has response code
> > OK_NODATA, some OK_$whatpayload and some ERR_$failure codes.
> >
> > You can dispatch based on the response/status code and run *fully*
> > asynchronous without too much trouble.
> 
> It's really a different level of complexity than what I needed so far.

That is a bit overboard, no?

All I'm asking for is:

  (a) A header field telling what kind of payload has been sent,
      for both requests and replies.
  (b) A header field telling what size the payload has.

That hardly is a different level of complexity.  And that isn't up for
negotiation.

If you absolutely don't want ack all requests, ok.  Not sending a reply
in case there is no payload to send back and no error to report is
something I can live with.

> > A properly structed reply allows a different approach in reply
> > processing (see above).  But that only works if it is in the protocol
> > right from the start.  As add-on feature it can't provide the benefits
> > because the reply parser must be able to handle both protocol variants.
> 
> You are asking for a full-blown protocol... could we take DBus as an
> alternative instead?

May I suggest QMP instead?

Seriously:  If you want reuse something, just use the vhost-user wire
format.  Which is essentially what I'm asking for, plus an additional
flags field in the header.

cheers,
  Gerd


