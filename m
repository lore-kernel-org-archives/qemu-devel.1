Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55305C48BD3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B3D20663
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vcdg3tcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B3D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfZGf-0007TC-E1
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 20:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZFZ-0006lL-1Q
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZFX-0002en-JA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:23:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hfZFX-0002dd-Dn
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:23:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id i8so8287919oth.10
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 17:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=A1gv9Olyje1aIsFfGB14FT92wQwesYuAWIMjbm+5Zag=;
 b=Vcdg3tcqScynMy3+ddWMOIEAFTyzOHU96stE/XCpim0HDasEnQaDluQ65EloYFwfZJ
 NTD4lx3KmgCcWVxgAertDFkNH0LyLXEpRdVXoG7+4Gb2+eZeDPa4hwTLQTDzysD7nw9t
 GubJ0ICKOaS8L05pBfXprwLBYTnAmFWcaxbxtq8fi18y/27/TUbWnf24UOoISrq5MCs9
 Ts56yVLiFWqGnieA3Gi42gzxZonPA4CbSNZyP34mdy7M46CWMfUtttArFFBY7qHqanL9
 yamcenqsXWaz89sZX4f/tqhaB3Gyr/8sC/YJ0H7nxBBcewZEJ/y4Agy10LYYti+D96Mj
 Xi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=A1gv9Olyje1aIsFfGB14FT92wQwesYuAWIMjbm+5Zag=;
 b=He25JW1qQTJ760rVQ06n3tMrvOWx7kK1g/MJtZjKotqdqWcL+KhfqS3vSLRTOKUkDY
 2vXhSwqo/rKmBLCbfJD/l0ieWkfFiuQESgS4r1llX/wMRFqyhqHoKgR7HCmWFrvoP2ct
 anRU4SD9L1M1jyJgANSW7cnOzBAFQ16rpD1XBsgTJQ2GzUEjFesWRywoDJalJRRPMHX+
 QmvvISIfG6u8D0obbVzgtGYQDh6rZUXuilxc1ZfNAGun8pJOa4kNP3cdRXfjDojZ2hX2
 2UcYQLK7VyjXrBuVh1Twu4iKO2LPaemjyg7a6B5EyqdZPv8Kqsvyf6LYVlPyP76YYAUT
 v4pw==
X-Gm-Message-State: APjAAAW4n3U7kKOKIs5xWPagEmuH8GbYXgVajcHESuo4El3SDZ438DG6
 rOvWrhpcCu8++MGtCeKq9O9lpjY5nRM8HdCI2qk=
X-Google-Smtp-Source: APXvYqzQm/aOnRJJgJcYQ5ruvECaIklku7rXNzkcgkPOEnjSF3s6zsmkPZcSKJI/IbHv7Cl/FDyeNFkSun2az1qa+1s=
X-Received: by 2002:a05:6830:11d4:: with SMTP id
 v20mr16826665otq.121.1561422230478; 
 Mon, 24 Jun 2019 17:23:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:23:50
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:23:50
 -0700 (PDT)
In-Reply-To: <20190624222844.26584-5-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-5-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 25 Jun 2019 02:23:50 +0200
Message-ID: <CAL1e-=iqP_JFR17LLo2TdFBP-h2_3mcDwmy-FGxuKs2qv-puKA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 04/10] hw/mips/gt64xxx_pci: Fix 'spaces'
 coding style issues
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 25, 2019 12:29 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> Since we'll move this code around, fix its style first:
>
>   ERROR: space prohibited between function name and open parenthesis
>   ERROR: line over 90 characters
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  hw/mips/gt64xxx_pci.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index cfd497960c..0b9fb02475 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -384,8 +384,8 @@ static const VMStateDescription vmstate_gt64120 =3D {
>      }
>  };
>
> -static void gt64120_writel (void *opaque, hwaddr addr,
> -                            uint64_t val, unsigned size)
> +static void gt64120_writel(void *opaque, hwaddr addr,
> +                           uint64_t val, unsigned size)
>  {
>      GT64120State *s =3D opaque;
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> @@ -671,8 +671,8 @@ static void gt64120_writel (void *opaque, hwaddr addr=
,
>      }
>  }
>
> -static uint64_t gt64120_readl (void *opaque,
> -                               hwaddr addr, unsigned size)
> +static uint64_t gt64120_readl(void *opaque,
> +                              hwaddr addr, unsigned size)
>  {
>      GT64120State *s =3D opaque;
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> @@ -1193,7 +1193,8 @@ PCIBus *gt64120_register(qemu_irq *pic)
>                                       get_system_io(),
>                                       PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS);
>      qdev_init_nofail(dev);
> -    memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d,
"isd-mem", 0x1000);
> +    memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d,
> +                          "isd-mem", 0x1000);
>
>      pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "gt64120_pci");
>      return phb->bus;
> --
> 2.19.1
>
>
