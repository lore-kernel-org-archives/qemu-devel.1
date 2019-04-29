Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837B4C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D6220675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9mX/Ar7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D6220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL3sQ-0000ay-JN
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 06:51:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL3rc-00006l-CL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL3rb-0003q8-8a
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:50:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hL3rb-0003pX-2i
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:50:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id a9so15321307wrp.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=uPSd818pSqzfEXz0p9PHhagxPmZBZ7lZB5ef4ssA7U4=;
	b=L9mX/Ar7FAUzTZQi3EhpkToozNuKDbkZDxS1vGEJBV6MCMMpqxh5MtqzgDzEtza0RL
	7R1o2bpmyisvL59aae4SLpeSDpHz+t71tz2EhJGLHy7p9ZhRcY8Ra5hj4uApDyrT+G0m
	1wWGcMymnR1vedxsosj6D9P+KV4ybJb7DJbSRLE5MNKVHKftYhGzrq1U9UNMvmV4Fj7a
	iuDs/wplWFJZD+0f0N9Jp+f4z9rWVyIPnXTMSz3C9EImOSjpnCbDre76PODM58FfxWDL
	iW/QPIMY6iaxxEAdrEPDblOWMDM0n1UVEUYrTZ72mEJt22J6Mme8oZQeIHSvVafWli7m
	cPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=uPSd818pSqzfEXz0p9PHhagxPmZBZ7lZB5ef4ssA7U4=;
	b=efMQSBgnksBnf6GdVDbc2MxKXws+bOw9dTkVMPlpe7xepgCTO2yIJAbgQqnItn++CJ
	oUxG1qURyvucctJZszyOw2phwbpU2N3oiM+0S5DpDSN+BUEyA5hv1qWCji4/RJ4s/zA4
	7AnK2P3IvryiL0/GyqeLmJKjF03+N+uUSTgbMm0xakrQUgyym7Dvz9YSHK/od5vLHCQY
	V1AksWqiO3qSHBotsF3D45hhWeZbSkcoci7Yf4cLvWPe3dFLvpruJfOkdqXej0vxJOex
	QcbaKHYsz2jumAXX+MTlwRwhNgEiFOgyY/KhuMBLxOF+njoh+77Yg2QGQnX0YnHU9F7g
	k3YA==
X-Gm-Message-State: APjAAAVadtkA4F5zPabf1xxvOfOXAoeIbxIb3H1gZ9HFM4hmBO48o9FI
	36NIDUzoU30Te6u9EK8vx+xsOmQZK6WvulZGrHI=
X-Google-Smtp-Source: APXvYqxPAZIq10uAuiz4n5/oWmqedv24oj5JHURepiCXeMuBxlCvZWN1EuovhQNU58hI+SCqXvXCdH3nf8YIMObg1Kg=
X-Received: by 2002:adf:9042:: with SMTP id h60mr5175709wrh.248.1556535021008; 
	Mon, 29 Apr 2019 03:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
	<20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
	<CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
	<20190426120558.vh66gugqtvcc6tm5@sirius.home.kraxel.org>
	<CAJ+F1CLE-iwZu4oX69P3r0v_94L+gJEhZH0-U0iYag=oYNN4pg@mail.gmail.com>
	<20190429071243.icqw3qbzcxbcz7ph@sirius.home.kraxel.org>
In-Reply-To: <20190429071243.icqw3qbzcxbcz7ph@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Apr 2019 12:50:09 +0200
Message-ID:
 <CAJ+F1CJx3qTNGL4u+pMHFC-LRhfPtn8WF3O=i2nW25dbgcV7tQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Message-ID: <20190429105009.l6Z36WQ2WtL5kjMftT97ClrczlWUNq3G2gOwKzqOwbE@z>

Hi

On Mon, Apr 29, 2019 at 9:12 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > What questions for example?
> >
> > This opens up different kind of possible replies, and error handling.
> >
> > With current proposal and needs, the reply (or absence of reply) is
> > entirely driven by the request.
> >
> > With your proposal, should all request have a reply?
>
> Yes.
>
> > which makes a lot
> > more code synchronous,
>
> Why?  You don't have to wait for the reply before sending the next
> request.
>
> Adding a request id to the messages might be useful, so it is possible
> to wait for a reply to a specific message without having to keeping
> track of all in-flight messages.
>
> > and complicates both sides unnecessarily.
>
> Having headers in the reply allows it to process them in generic code.
> There is a size header for the reply, so you can parse the stream
> without knowing what replay to expect.  You can use the status field to
> indicate the payload, simliar to virtio-gpu which has response code
> OK_NODATA, some OK_$whatpayload and some ERR_$failure codes.
>
> You can dispatch based on the response/status code and run *fully*
> asynchronous without too much trouble.

It's really a different level of complexity than what I needed so far.

>
> > > > Can we leave that for future protocol extensions negotiated with
> > > > GET/SET_PROTOCOL_FEATURES ?
> > >
> > > I don't think negotiating such a basic protocol change is a good idea=
.
> >
> > Well, then I would rather focus on improving protocol negociation,
> > rather than adding unnecessary protocol changes.
> >
> > Given that GET/SET_PROTOCOL_FEATURES is the first messages being sent,
> > why couldn't it have flags indicating new protocol revision?
>
> A properly structed reply allows a different approach in reply
> processing (see above).  But that only works if it is in the protocol
> right from the start.  As add-on feature it can't provide the benefits
> because the reply parser must be able to handle both protocol variants.

You are asking for a full-blown protocol... could we take DBus as an
alternative instead?

--=20
Marc-Andr=C3=A9 Lureau

