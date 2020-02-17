Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC5EC761A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FEB82070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEB82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gS6-0004d8-N7
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3gR9-0003KN-4A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3gR8-0000XE-3A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:27:47 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3gR7-0000Wq-VO; Mon, 17 Feb 2020 08:27:46 -0500
Received: by mail-yw1-f65.google.com with SMTP id b186so7809565ywc.1;
 Mon, 17 Feb 2020 05:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KeuzRvKcV/TyT35UKKsAZfo1CEvKSpxdk9zX5qslx4g=;
 b=XjneHai3iHcBgfP9bINbg2hEZ4WH6CS1TN4bxR0sdmEo4an9kJgbOUOacgdGkSNSy4
 pMX/aX6dVPsXKokeZT5uHsT/eB+NfcCP7mkyaBoS5CuWjVbPrCxcYr8TVW1wcvo5dRiQ
 TqN+joU6XnykYE3jzNKPu4mQ5e1U25L21S30VKD0aPiKJbMySzg6Hb7yDSLdviXxMEQZ
 8s9SEPZFIkgQVI/xhwV4RhgCi/2xXrmVL50ni+dt5a0gHnmt8Rj4BaUSfjgeXdey4yYV
 uuTtJvf1DTIGCnKJvsfnh6aNMwI5DqLNlcFKKLMYD2HHLsu9ffNbSXf90V3xJUf2bl+U
 /fhA==
X-Gm-Message-State: APjAAAW0DJFA5hd+i/ifAmRydfE/4C0M/9SrwkwTinm31bdtIuJ5u8A9
 cSKSMVmwjP33SY4vltCrG7klQw4M78skQG7y3X4=
X-Google-Smtp-Source: APXvYqwMChAnHgQxVmAdvM87F65xNZLKsRyFEBYBiaX7PsJ9oF83Z+XAF5RJXgof37DXiajv8e1vlO32mkFkKF13nCg=
X-Received: by 2002:a81:8443:: with SMTP id u64mr12329941ywf.443.1581946063828; 
 Mon, 17 Feb 2020 05:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20200217105657.31506-1-f4bug@amsat.org>
 <CAFEAcA8AT2YE0kzWjRmR1ZsSFxH7bs1t_G8Bs+J-QsCzMXPg3w@mail.gmail.com>
In-Reply-To: <CAFEAcA8AT2YE0kzWjRmR1ZsSFxH7bs1t_G8Bs+J-QsCzMXPg3w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Feb 2020 14:27:32 +0100
Message-ID: <CAAdtpL7riRLot1zyTF3KaHMw2wAWaBzk_vOQqxukwfMfCTNb2Q@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt
 Clear' register
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.65
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

On Mon, Feb 17, 2020 at 12:28 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On Mon, 17 Feb 2020 at 10:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
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
> > v2: Corrected bitwise-not precedence (pm215)
> > ---
> >  hw/misc/iotkit-secctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
> > index 609869821a..43cf0f9970 100644
> > --- a/hw/misc/iotkit-secctl.c
> > +++ b/hw/misc/iotkit-secctl.c
> > @@ -340,7 +340,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaq=
ue, hwaddr addr,
> >          qemu_set_irq(s->sec_resp_cfg, s->secrespcfg);
> >          break;
> >      case A_SECPPCINTCLR:
> > -        value &=3D 0x00f000f3;
> > +        s->secppcintstat =3D ~(value & 0x00f000f3);
>
> Should be &=3D, not =3D. Otherwise you set all the other
> bits in the register.

Yes, I'm sorry.

