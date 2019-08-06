Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080F2C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7ADC20C01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2XrCZ1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7ADC20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huzyA-0003Fd-Ss
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 09:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35694)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huzxm-0002k2-Gq
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huzxl-0003K1-FA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:57:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huzxl-0003Ji-6k
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:57:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id w196so45354172oie.7
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d5XpGl0H8WVLCpTddTPdD6q88Je9nInZfwRbtRYnlZU=;
 b=H2XrCZ1q8VEn7XzP0IRYelYbwrfNyEAhf+DpZ9QXsMguDuuhlw2yDaxS0ga/idyECG
 5bnsPnzb3KmUvILwjlLum39reWALKXGi7D3WFy6oBA2v0LJDJAqTWva66TJ9rD2fcls4
 4G4l9nXYsMNtcFLImKKdDlpg2k9QEFCCZ5DtaLdxSlQ4/MukMPasGMaHVVr/qd8zIfrF
 VYmYaW/Fnd3oC5Ee/vwlNm0DS2Hva59urrnwa7xlaDlzdkHHsRheEcAqNJxORnq+rv1v
 YR6YqOPo8vVGzYftQ457D7hPd/fcNfZhVYgiOP7gKAMbQPRZWqbzQlNDXTim2n/F8LqR
 Z1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d5XpGl0H8WVLCpTddTPdD6q88Je9nInZfwRbtRYnlZU=;
 b=aEQqSgmcn26d4bFlOWGe3HsLkG7cn2kuUsI0uwdMSts67mkVFj+DK0P/ybJCa8cgUP
 3M/TDGMn7zeuPybMZBJbYPlYcqmf2lhiicOR7qhczf52q1uEFGVMgTT+9a4njsSSP4oX
 alOqihATTKpOAVz150PKe6kcR5x0DetigUAZfdkGP5fm7ZEhLiLOMqz+oKMkQ4LOX4vx
 j8YyI/vgfknTAKxQgtytOu7+R+4ZDuizaRwwW4MEPOAzHliWUkCK+ZE1jJeu115eBQzw
 MENNESdOeigkU9JBaNDkRKgm1dnaVQp++d5MTdV6UWypYUMonfBDtWKYd0A2HWVfIuSU
 z/TA==
X-Gm-Message-State: APjAAAW3SvQRjzS4kljGLKdk93/PDqXktBJBtcWrRSMsUkw0ekmpQy34
 pQWILgS11oyjZVo590DV1I+gyz1iqyz3Inbolm7GLA==
X-Google-Smtp-Source: APXvYqy3PIr11s9n5vpAlvq/OdExxg9l9LGul0xX2oVOZZSy+VhKRKRgaEUn8J6Rs1DlqYn+LfWGPBGYuzmjM23aNys=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr1881000oic.170.1565099836234; 
 Tue, 06 Aug 2019 06:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190730054501.32727-1-rashmica.g@gmail.com>
 <20190730054501.32727-2-rashmica.g@gmail.com>
In-Reply-To: <20190730054501.32727-2-rashmica.g@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 14:57:05 +0100
Message-ID: <CAFEAcA_OBg6s+qu-DG_N882Gy_FxX3_fxHLa=tzpHfRzY5fdWQ@mail.gmail.com>
To: Rashmica Gupta <rashmica.g@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hw/gpio: Add basic Aspeed GPIO
 model for AST2400 and AST2500
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 06:45, Rashmica Gupta <rashmica.g@gmail.com> wrote:
>
> GPIO pins are arranged in groups of 8 pins labeled A,B,..,Y,Z,AA,AB,AC.
> (Note that the ast2400 controller only goes up to group AB).
> A set has four groups (except set AC which only has one) and is
> referred to by the groups it is composed of (eg ABCD,EFGH,...,YZAAAB).
> Each set is accessed and controlled by a bank of 14 registers.
>
> These registers operate on a per pin level where each bit in the register
> corresponds to a pin, except for the command source registers. The command
> source registers operate on a per group level where bits 24, 16, 8 and 0
> correspond to each group in the set.
>
>  eg. registers for set ABCD:
>  |D7...D0|C7...C0|B7...B0|A7...A0| <- GPIOs
>  |31...24|23...16|15....8|7.....0| <- bit position
>
> Note that there are a couple of groups that only have 4 pins.
>
> There are two ways that this model deviates from the behaviour of the
> actual controller:
> (1) The only control source driving the GPIO pins in the model is the ARM
> model (as there currently aren't models for the LPC or Coprocessor).
>
> (2) None of the registers in the model are reset tolerant (needs
> integration with the watchdog).
>

> +typedef struct AspeedGPIOReg {
> +    uint16_t set_idx;
> +    uint32_t (*read)(GPIOSets *regs);
> +    void (*write)(AspeedGPIOState *s, GPIOSets *regs,
> +                const GPIOSetProperties *props, uint32_t val);
> + } AspeedGPIOReg;

Please don't create new abstractions for implementing
registers that are only used in one device model. We
have a couple of basic approaches that we use already:

 * just open coded switch statements in the read and write
   functions for the device's MMIO regions
 * if you'd rather have a data structure defining each
   register with hook functions where they need to do
   particular behaviour on reads and writes, have a look
   at the APIs in include/hw/register.h. Currently these are
   used just by some of the Xilinx devices, but if you
   want an API shaped like that you can use it.

thanks
-- PMM

