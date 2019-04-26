Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7374BC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C563208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+ZltTOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C563208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46351 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJznh-00041Z-G4
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 08:17:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJzm0-000307-P3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJzlz-0008Vz-T0
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:16:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJzlz-0008V6-KH
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:16:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id y197so4132137wmd.0
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=5l+cgD5CBGk+exOyIhulFk38XQaDlB3fD3+hXuzegT0=;
	b=X+ZltTOO0Qw2l+NVJo8FmPc9h5oRoOPltJE8XBBQepGv7zdH2orOpQogVMXovYP13V
	/0yUOv10gKKotlFlAmqpCPZ4pb+5tNO9Lrvi57hwgmdHBN+ldNRMIoWWgDbKq0zGekkZ
	jiGwcaR0j+8W10nCXTyhVTxoGX5NSGz9zVngTYiKHyB7HpPvC4x+60nHZr+KT8hKzDNa
	/Bfk5H4r7aEpON97S/1t0skS0sXyv4ZAdXqwGvhUqgWSMQ5JkZzinVhMjhn09otl3S0m
	8gSWLXQttOr8EmB+q9uj7L5z/rMKfjXot1ZjgfARQ161Gf9G8ISNKYcGYS/c7z1zYyrW
	LOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=5l+cgD5CBGk+exOyIhulFk38XQaDlB3fD3+hXuzegT0=;
	b=aIwizq8EHvFp+jifQ7sR/g3+FdGbK6DAwRsgPb18P5pLYFZnYzc6vvFQP0eXiducjt
	xzR6lxLg3PLzYoVNktc/aQrp6bJtsu5Cl0GfrL+KaXbeYxCxmZuqh47esOyc+h4kHaVR
	4Q0BAh8IvuCwwa2eUFmJnW/1OS0+T2UkBSog4YINrD+2XqBwSNsld9UcAR+jxAMTBEq7
	vZnqi8/eTd+xTVdCWPZvMZ9YzUyg1qSNbsoeJZMLkQE3D1nGX9qwPP6TnvmfPaZTYLKK
	37gFdnrnYAPn+TVnpXjLzWe8Vv9RQWJJAY9bgiH+QE0fohWCqHopppXbHLNMzTutxN2s
	304Q==
X-Gm-Message-State: APjAAAXIjF6rvqJJeqoox3MvQfbmVpxhEVeA/yc+Y4yf8q06K9NoKLKt
	m1aGXjWumqZW/F2VoZCu8zi2cc0gVgxVaWthevU=
X-Google-Smtp-Source: APXvYqyFS8BFq+a+qj64Nq3Xz1NnNLo+r24+obUsxBI1mqTHTeN+oLDe3VePmFJDtjxsD3PdalRMa3PD5wR9aGp5cyc=
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr7552635wme.16.1556280970336; 
	Fri, 26 Apr 2019 05:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
	<20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
	<CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
	<20190426120558.vh66gugqtvcc6tm5@sirius.home.kraxel.org>
In-Reply-To: <20190426120558.vh66gugqtvcc6tm5@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 Apr 2019 14:15:58 +0200
Message-ID:
 <CAJ+F1CLE-iwZu4oX69P3r0v_94L+gJEhZH0-U0iYag=oYNN4pg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Message-ID: <20190426121558.m_GP1SRCo6oHXVCTsUZ2V8gcAfem4HsQUGzYXGwuWOI@z>

Hi

On Fri, Apr 26, 2019 at 2:06 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > +Wire format
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +Unless specified differently, numbers are in the machine native by=
te
> > > > +order.
> > > > +
> > > > +A vhost-user-gpu request consists of 2 header fields and a payload=
.
> > > > +
> > > > ++---------+------+---------+
> > > > +| request | size | payload |
> > > > ++---------+------+---------+
> > > > +
> > > > +Header
> > > > +------
> > > > +
> > > > +:request: ``u32``, type of the request
> > > > +
> > > > +:size: ``u32``, size of the payload
> > > > +
> > > > +A reply consists only of a payload, whose content depends on the r=
equest.
> > >
> > > I'd suggest to use the same format for replies, only with "request"
> > > meaning "status" in replies.  Allows for OK/ERROR status in replies,
> > > and having a size field in replies too should make things more robust=
.
> > > Also allows for an empty reply (status=3Dok,size=3D0).
> >
> >
> > That brings more questions and ambiguity imho.
>
> What questions for example?

This opens up different kind of possible replies, and error handling.

With current proposal and needs, the reply (or absence of reply) is
entirely driven by the request.

With your proposal, should all request have a reply? which makes a lot
more code synchronous, and complicates both sides unnecessarily.

>
> > Can we leave that for future protocol extensions negotiated with
> > GET/SET_PROTOCOL_FEATURES ?
>
> I don't think negotiating such a basic protocol change is a good idea.

Well, then I would rather focus on improving protocol negociation,
rather than adding unnecessary protocol changes.

Given that GET/SET_PROTOCOL_FEATURES is the first messages being sent,
why couldn't it have flags indicating new protocol revision?

--=20
Marc-Andr=C3=A9 Lureau

