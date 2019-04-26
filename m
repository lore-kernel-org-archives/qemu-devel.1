Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9594C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3511206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjC5J+up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3511206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJzcB-0001vN-Rj
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 08:06:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJzZz-0008W0-Az
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJzMd-0001kN-Pe
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:50:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJzMd-0001jU-E2
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:49:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id y5so3000151wma.2
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=101OBzHxvO53GOSETCH8ned8FQ5vmAHL5a2J5kLkOsE=;
	b=sjC5J+up6z14RG0D2uO9mJsaLYYa2R3vgsC4DXfJ5x+T4QmIOvsNvve/KewQq2lWIX
	4DBEvY/VMfxxVeqTBZ8Q+rYMrlR8KQ6SQs9QUyKUEJw9N6tsH0d6Vl/ovH42v6PAQ7eu
	RRnDDJ5N30U7bKcVT96rGQWxxNUcZ33sCtgm8HbbK2BRAbqz4v0w2lLlZuiNC+hJ6Ym9
	vGU47CZ9uic4YFKlXaJ4KrA+lcmWjELCACxBCc1npg2S/hUukgiLowapnjMPPleg5OTr
	hRVzhh6xC2yGxjQJtRV1NajE7tdA//OomDcuc9YSTrOpioL5vwwFWH/DBYSKCjKntvv9
	JHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=101OBzHxvO53GOSETCH8ned8FQ5vmAHL5a2J5kLkOsE=;
	b=al5ezbQgwVBbBLEg14bqnQ+hGfQ8clnY9dWwVdov+hiTO4ADDcaxejtZHAwZgHvL2i
	WNJrXo0o8bXXO/IXpkqQjyyXr2U1Db8p9wy6LuwtUrMY2mzvvH3imwlTZ6pVKoFfIhni
	XNjKqWcpUiaLlFkT2udrEA0BaBxPSlfal153rkynJofdS5fkioMjspJ7PieTb4mQEWpj
	YYONjHznQ5FPh829tmWPf8nlL19M32Tlm7E0qPQyxZTxtI36BGaKuJWWAvQ26XPeag7z
	HPOE4dicArB8Jk8abHq/CFqogmQb3LClpDEsyRW+WFJbOwyYWA//sWf3wI3a2BfoZap6
	cuzA==
X-Gm-Message-State: APjAAAUg7dTAZMHrgYKP10sGbhrt5p2V9bMd6Pqdc2rw3Jc6q49/6BC4
	1qai76lOTASO1TgDwS5aRSXJSlc7kQP8P2n1Fi4=
X-Google-Smtp-Source: APXvYqwtPl55MR64c367GBoQUqhdyIcZbkmE4STHM0k0Ck+44u+hfvyFv2x7Dacq0uZiou553eAibvMo58TD3MzEbjI=
X-Received: by 2002:a1c:be13:: with SMTP id o19mr7348556wmf.19.1556279398050; 
	Fri, 26 Apr 2019 04:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
	<20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
In-Reply-To: <20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 Apr 2019 13:49:46 +0200
Message-ID:
 <CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Message-ID: <20190426114946._aoOUlKABcQXsy3hm3YJaN8T7MAPRTJmFL_hkhhrbRA@z>

Hi

On Fri, Apr 26, 2019 at 9:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Apr 23, 2019 at 03:19:58PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Add a new vhost-user message to give a unix socket to a vhost-user
> > backend for GPU display updates.
>
> Can you split input/gpu into two patch series?
>
> > +Wire format
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Unless specified differently, numbers are in the machine native byte
> > +order.
> > +
> > +A vhost-user-gpu request consists of 2 header fields and a payload.
> > +
> > ++---------+------+---------+
> > +| request | size | payload |
> > ++---------+------+---------+
> > +
> > +Header
> > +------
> > +
> > +:request: ``u32``, type of the request
> > +
> > +:size: ``u32``, size of the payload
> > +
> > +A reply consists only of a payload, whose content depends on the reque=
st.
>
> I'd suggest to use the same format for replies, only with "request"
> meaning "status" in replies.  Allows for OK/ERROR status in replies,
> and having a size field in replies too should make things more robust.
> Also allows for an empty reply (status=3Dok,size=3D0).


That brings more questions and ambiguity imho.

Can we leave that for future protocol extensions negotiated with
GET/SET_PROTOCOL_FEATURES ?



--
Marc-Andr=C3=A9 Lureau

