Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0EAC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF22720715
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+cJloUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF22720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2UM-0005xE-5W
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ia2MF-0007VW-0Q
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ia2M8-0004jO-Tr
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:48:07 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a]:34557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ia2M8-0004Zu-O6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:48:04 -0500
Received: by mail-qt1-x82a.google.com with SMTP id i17so26412458qtq.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 10:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uKi3akRP//AwZlAhNzf93VpnSRzldElANwC6vmioccI=;
 b=N+cJloUJxcxuzHDOQb1SXcrTs2DJJS49PhNbgCbmPXCZZvDyD0pUTVANV2OnZx+EwK
 wdyd0inJuyOZXXtAr/xHnGhAY7jw247fWcQZaf+9hRAKB72ug+QGGYNULLXVug2XF2vJ
 NkP/UiAIp6gZ0AGetX/jDltyY0oQLTPZWSPT99PAL/JAG0BkUM7NWQQNfUS0XNj1XRwJ
 t6YMHWaAkBOS26Mg9ZiQaShgI6RvOhvFODTxSXHhvAs/lTxZE2rmv1QHR/EF3a9mJe2n
 xkByU7+qmrvNxhs9EOKhdxUebznxlHpurtRRyHzevJ8HzjtuCbZYfIVLTrR2aRqUfodD
 KYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uKi3akRP//AwZlAhNzf93VpnSRzldElANwC6vmioccI=;
 b=qYJ9L1qI4RmRqrrHyWzOap2gsLvtiFaFjeMgLGyRm5s8HgfYaLRiSHGpDWU7qNZs/7
 r0c8TYrxB2ZDm1njPlA7kjHvde0iQu8aNAeHY5gaWecY/Dz9XXcast1NKuss8t/npFVB
 9lQWRIoKJwjDaNIWt8bJ10/egPTgG1LcO1rI0p/QcbyJ15IH5aqvsaF2ldTOvWP5dX59
 UX4KDNT8mAcMEANyDzAU4+sOM0TbFHs0mNiefkan1FZ3R7cW6UDUT5QvNAZy9ZjiBz78
 yt7mioA3Ra92+Fr0zShzzEJ2xtdYAEuNJ05AQ852BGYE+/PX70qMM7yj43gwSElULsVs
 6C/w==
X-Gm-Message-State: APjAAAVSMQmUxMYhiAU8OI7xoGzyFCISkjqD8gk6rEgJNmRdFVJ6w4lI
 NXe4Jv1mAtK6QlPMJHe85zeyy2cbyy90TNBej3A=
X-Google-Smtp-Source: APXvYqxaJPkUmEBSG7IMJHHy5TNn7VTaV2wpSHcwHbeTEzUFx/vQjBHY+CNS2dGZr/X7QFztos6M4P3PBpVtICJYPvI=
X-Received: by 2002:ac8:4a02:: with SMTP id x2mr30758949qtq.371.1574880480734; 
 Wed, 27 Nov 2019 10:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-12-mrolnik@gmail.com>
 <81b62c00-243e-b76e-f52c-4f681b47b727@redhat.com>
 <CAL1e-=i6tctJ6bKo7mz2fmSzPXpdMY1kV1WrKhL5TCAKd0DkcQ@mail.gmail.com>
In-Reply-To: <CAL1e-=i6tctJ6bKo7mz2fmSzPXpdMY1kV1WrKhL5TCAKd0DkcQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 27 Nov 2019 20:46:53 +0200
Message-ID: <CAK4993hKFzOStiG=A4jybEXQWcdXYZMF-+gF_SHq+7vsB_P03g@mail.gmail.com>
Subject: Re: [PATCH v36 11/17] target/avr: Add limited support for USART and
 16 bit timer peripherals
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009e33a20598586fd5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82a
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009e33a20598586fd5
Content-Type: text/plain; charset="UTF-8"

too late :)

On Wed, Nov 27, 2019 at 8:44 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> > > +/* Offsets of registers. */
> > > +#define USART_DR   0x06
> > > +#define USART_CSRA  0x00
> > > +#define USART_CSRB  0x01
> > > +#define USART_CSRC  0x02
> > > +#define USART_BRRH 0x05
> > > +#define USART_BRRL 0x04
> > > +
> > > +/* Relevant bits in regiters. */
> > > +#define USART_CSRA_RXC    (1 << 7)
> > > +#define USART_CSRA_TXC    (1 << 6)
> > > +#define USART_CSRA_DRE    (1 << 5)
> > > +#define USART_CSRA_MPCM   (1 << 0)
> > > +
> > > +#define USART_CSRB_RXCIE  (1 << 7)
> > > +#define USART_CSRB_TXCIE  (1 << 6)
> > > +#define USART_CSRB_DREIE  (1 << 5)
> > > +#define USART_CSRB_RXEN   (1 << 4)
> > > +#define USART_CSRB_TXEN   (1 << 3)
> > > +#define USART_CSRB_CSZ2   (1 << 2)
> > > +#define USART_CSRB_RXB8   (1 << 1)
> > > +#define USART_CSRB_TXB8   (1 << 0)
> > > +
> > > +#define USART_CSRC_MSEL1  (1 << 7)
> > > +#define USART_CSRC_MSEL0  (1 << 6)
> > > +#define USART_CSRC_PM1    (1 << 5)
> > > +#define USART_CSRC_PM0    (1 << 4)
> > > +#define USART_CSRC_CSZ1   (1 << 2)
> > > +#define USART_CSRC_CSZ0   (1 << 1)
> >
> > The previous definitions can go into hw/char/avr_usart.c.
> >
>
> Why?
>


-- 
Best Regards,
Michael Rolnik

--0000000000009e33a20598586fd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">too late :)</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Nov 27, 2019 at 8:44 PM Aleksandar Ma=
rkovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; &gt; +/* Offsets of registers. */<br>
&gt; &gt; +#define USART_DR=C2=A0 =C2=A00x06<br>
&gt; &gt; +#define USART_CSRA=C2=A0 0x00<br>
&gt; &gt; +#define USART_CSRB=C2=A0 0x01<br>
&gt; &gt; +#define USART_CSRC=C2=A0 0x02<br>
&gt; &gt; +#define USART_BRRH 0x05<br>
&gt; &gt; +#define USART_BRRL 0x04<br>
&gt; &gt; +<br>
&gt; &gt; +/* Relevant bits in regiters. */<br>
&gt; &gt; +#define USART_CSRA_RXC=C2=A0 =C2=A0 (1 &lt;&lt; 7)<br>
&gt; &gt; +#define USART_CSRA_TXC=C2=A0 =C2=A0 (1 &lt;&lt; 6)<br>
&gt; &gt; +#define USART_CSRA_DRE=C2=A0 =C2=A0 (1 &lt;&lt; 5)<br>
&gt; &gt; +#define USART_CSRA_MPCM=C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
&gt; &gt; +<br>
&gt; &gt; +#define USART_CSRB_RXCIE=C2=A0 (1 &lt;&lt; 7)<br>
&gt; &gt; +#define USART_CSRB_TXCIE=C2=A0 (1 &lt;&lt; 6)<br>
&gt; &gt; +#define USART_CSRB_DREIE=C2=A0 (1 &lt;&lt; 5)<br>
&gt; &gt; +#define USART_CSRB_RXEN=C2=A0 =C2=A0(1 &lt;&lt; 4)<br>
&gt; &gt; +#define USART_CSRB_TXEN=C2=A0 =C2=A0(1 &lt;&lt; 3)<br>
&gt; &gt; +#define USART_CSRB_CSZ2=C2=A0 =C2=A0(1 &lt;&lt; 2)<br>
&gt; &gt; +#define USART_CSRB_RXB8=C2=A0 =C2=A0(1 &lt;&lt; 1)<br>
&gt; &gt; +#define USART_CSRB_TXB8=C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
&gt; &gt; +<br>
&gt; &gt; +#define USART_CSRC_MSEL1=C2=A0 (1 &lt;&lt; 7)<br>
&gt; &gt; +#define USART_CSRC_MSEL0=C2=A0 (1 &lt;&lt; 6)<br>
&gt; &gt; +#define USART_CSRC_PM1=C2=A0 =C2=A0 (1 &lt;&lt; 5)<br>
&gt; &gt; +#define USART_CSRC_PM0=C2=A0 =C2=A0 (1 &lt;&lt; 4)<br>
&gt; &gt; +#define USART_CSRC_CSZ1=C2=A0 =C2=A0(1 &lt;&lt; 2)<br>
&gt; &gt; +#define USART_CSRC_CSZ0=C2=A0 =C2=A0(1 &lt;&lt; 1)<br>
&gt;<br>
&gt; The previous definitions can go into hw/char/avr_usart.c.<br>
&gt;<br>
<br>
Why?<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--0000000000009e33a20598586fd5--

