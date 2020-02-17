Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F269BC3B185
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC26E20725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC26E20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3e72-0006rt-TZ
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3e60-0005kl-2Z
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3e5z-0006Ub-1l
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:57:48 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3e5y-0006UE-UI; Mon, 17 Feb 2020 05:57:47 -0500
Received: by mail-yb1-f196.google.com with SMTP id b141so8462424ybg.10;
 Mon, 17 Feb 2020 02:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yYpkn/2TVQDh4ObMqxU7c30vZhqnoqsvQjqU/wbS55A=;
 b=klLN+toibcO0/KFZ9g3m1emFhS0ZpI7kJVRAm6+PKd8mOKKdPcPeU2V9MqWIxkwbjX
 scBPq+C5ROWfY9r9RsUeJa+h9KH/kJenSDcnIbnhrxOCyJcadmPCEUHL7oziAd+1gM9i
 FGe+YsmiGSf+brsenCuoXd5T8yp5EDikdkE5QHUWOM4ighZIooQhaRNRiAEvLq81sq3g
 EQDKgNUa9ixD/UtJ99Ux84gCWGdUlyg9alJbvxN3RRAxF21YOZLi8tkFCuuRXCJFABTj
 b6S16438Ptf0biPLne9MVZMh6ObFB1j/gRkWMl5/FKG7x+GurHqVux0aBYvIzdkDnTEZ
 gYzg==
X-Gm-Message-State: APjAAAUBN7CDoBmYSJUz9B1Dvjg+d/KhgTkFQkjUDbcmjQefQco9dtBJ
 kdHjqWdG8ZpWOojQ8Lid3oJx96CEIhibJzifG9o=
X-Google-Smtp-Source: APXvYqznB51vEv7IJQPBHpWVVWBUkltN9LGcB9bY+DDvl09ExR5JZBrGKeLNaQU7TbuQpUHdd+QLeZafD26j1P5mdL4=
X-Received: by 2002:a25:5f4d:: with SMTP id h13mr9583313ybm.312.1581937066295; 
 Mon, 17 Feb 2020 02:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20200215161923.4741-1-f4bug@amsat.org>
 <CAFEAcA8SLR5YXWYiS_GXOBhHAxR2QKut_BGVzNeamw_1xtifLA@mail.gmail.com>
In-Reply-To: <CAFEAcA8SLR5YXWYiS_GXOBhHAxR2QKut_BGVzNeamw_1xtifLA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Feb 2020 11:57:35 +0100
Message-ID: <CAAdtpL7iSY4oxg964WxzXvrpNUKy5ApTMq0Lq_MU6dW1v61DGA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt
 Clear' register
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.196
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 17, 2020 at 11:22 AM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>
> On Sat, 15 Feb 2020 at 16:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> >
> > Fix warning reported by Clang static code analyzer:
> >
> >     CC      hw/misc/iotkit-secctl.o
> >   hw/misc/iotkit-secctl.c:343:9: warning: Value stored to 'value' is ne=
ver read
> >           value &=3D 0x00f000f3;
> >           ^        ~~~~~~~~~~
> >
> > Fixes: b3717c23e1c
> > Reported-by: Clang Static Analyzer
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  hw/misc/iotkit-secctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
> > index 609869821a..0d5556dd17 100644
> > --- a/hw/misc/iotkit-secctl.c
> > +++ b/hw/misc/iotkit-secctl.c
> > @@ -340,7 +340,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaq=
ue, hwaddr addr,
> >          qemu_set_irq(s->sec_resp_cfg, s->secrespcfg);
> >          break;
> >      case A_SECPPCINTCLR:
> > -        value &=3D 0x00f000f3;
> > +        s->secppcintstat =3D ~value & 0x00f000f3;
>
> This is (obviously) a bug, but I don't think your fix is right.
> This register has bits which are write-one-to-clear,
> (plus some other bits that are reserved and RAZ/WI)
> so we want:
>   s->secppcintstat &=3D ~(value & 0x00f000f3);
>
> (In particular bitwise-not has higher precedence than
> bitwise-and, so your expression will end up writing zero
> to s->specppcintstat for any valid guest write.)

Oops indeed :)

> My guess is that when I originally wrote the code I meant
> to write something like
>    value &=3D 0x00f000f3;
>    s->secppcintstat &=3D ~value;
> and forgot the second line.
>
> thanks
> -- PMM

