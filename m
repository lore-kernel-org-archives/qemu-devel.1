Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3167C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CBB2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="g4KQZD6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CBB2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3pZI-00068K-Jt
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 19:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pX4-0005XD-5j; Thu, 06 Aug 2020 19:42:46 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pX1-00042R-RY; Thu, 06 Aug 2020 19:42:45 -0400
Received: by mail-ed1-x542.google.com with SMTP id a14so19423783edx.7;
 Thu, 06 Aug 2020 16:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=thvcS0wbIyIhj6Kw63JRbFWup4f2P2gSCodJj2WyeyA=;
 b=g4KQZD6UOLFYlIuTE019C+OSN7G+ThOLn4TbrfXGquF2ZlSVY4rKHb2Rbwc5xrgIfK
 kP4nk/J++tZbikQD2/NUH9oflwBKabFCF/Kuk+VIQ6ktPet7gk73fxnKU5HNvsNY1eXf
 358/F9Nd5konMuMtfLdef0h5K2bA2x4JH/GzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=thvcS0wbIyIhj6Kw63JRbFWup4f2P2gSCodJj2WyeyA=;
 b=OfB24+Q4eX3bbGS7Y/P1mIM0S0tNdkrexWj23I8BZIUm9lZImO6hJ1v6UgnjsL19lI
 KOwo9LfNQ1M2Hbhjxdgnbz7n6Frl+0I05jzAyj4pxuwv8Iu1OH6nUyt0PQ73jHIXUAL3
 6OB+oUi8cWwP8vhjU/C+sVJqttLJEnSI3pa9duURByli7BcHpx/CVq4E1sWw2Y8H/AnE
 ZzFtVAj3Q14ugBlSUIG9VLkEHUzdy270TC/A/fWkz/zTdwqVJy1p2MulI1K97am4QY0H
 aVWDyfxUJcq7DcLLTqFBQ9WgjKgsgySbha1J/qSdKLM/chEXCJNj12C1T0KgBKKPjGzP
 xscQ==
X-Gm-Message-State: AOAM5338mnhJ4x5TPzInTVxm532X3W1TaI0Ea//1W7brEReu50pUOmH/
 bcNlzqSqgnNC6IQawphAt67psA9wt0COy9Lf6U0=
X-Google-Smtp-Source: ABdhPJywx5znlv2WmOCHlnFCptGfLRINIdGWFs+uI2mV7Z6dyyTxDRNLWdHkh/ebNW80EcEmQiFBhwotqc/oG1Ofky0=
X-Received: by 2002:aa7:dc02:: with SMTP id b2mr6251637edu.260.1596757360998; 
 Thu, 06 Aug 2020 16:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-9-clg@kaod.org>
In-Reply-To: <20200806132106.747414-9-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 23:42:28 +0000
Message-ID: <CACPK8Xcy-OzbQ4oiLaq96VzROSsmnmSAa0dytRcCVp2ot+mQnw@mail.gmail.com>
Subject: Re: [PATCH for-5.2 08/19] aspeed/sdhci: Fix reset sequence
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Eddie James <eajames@linux.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> BIT(0) of the ASPEED_SDHCI_INFO register is set by SW and polled until
> the bit is cleared by HW. Add definitions for the default value of
> this register and fix the reset sequence by clearing the RESET bit.

This is mentioned in the datasheet but I couldn't find if software
depends on the behaviour. Were you just trying to make the model more
accurate?

>  #define ASPEED_SDHCI_INFO            0x00
> -#define  ASPEED_SDHCI_INFO_RESET     0x00030000
> +#define  ASPEED_SDHCI_INFO_SLOT1     (1 << 17)
> +#define  ASPEED_SDHCI_INFO_SLOT0     (1 << 16)
> +#define  ASPEED_SDHCI_INFO_RESET     (1 << 0)
>  #define ASPEED_SDHCI_DEBOUNCE        0x04
>  #define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
>  #define ASPEED_SDHCI_BUS             0x08
> @@ -67,6 +69,9 @@ static void aspeed_sdhci_write(void *opaque, hwaddr add=
r, uint64_t val,
>      AspeedSDHCIState *sdhci =3D opaque;
>
>      switch (addr) {
> +    case ASPEED_SDHCI_INFO:
> +        sdhci->regs[TO_REG(addr)] =3D (uint32_t)val & ~ASPEED_SDHCI_INFO=
_RESET;

I think bits 24 and 25 should be writable too?

        sdhci->regs[TO_REG(addr)] =3D (uint32_t)val &
~(ASPEED_SDHCI_INFO_RESET | ASPEED_SDHCI_INFO_SLOT10 |
ASPEED_SDHCI_INFO_SLOT1);

> +
>      case ASPEED_SDHCI_SDIO_140:
>          sdhci->slots[0].capareg =3D (uint64_t)(uint32_t)val;
>          break;
> @@ -155,7 +160,8 @@ static void aspeed_sdhci_reset(DeviceState *dev)
>      AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
>
>      memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
> -    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D ASPEED_SDHCI_INFO_RESET;
> +    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D
> +        ASPEED_SDHCI_INFO_SLOT1 | ASPEED_SDHCI_INFO_SLOT0;

If we want to be super strict this is true for the "sd" devices, but
the "emmc" device in the ast2600 only sets slot0. I don't think this
distinction is important to model though.

>      sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] =3D ASPEED_SDHCI_DEBOUNCE=
_RESET;
>  }
>
> --
> 2.25.4
>

