Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BA8C4646B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEA62077C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwc5RHp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEA62077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55666 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfZEo-0005gw-OC
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 20:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59563)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZDq-0004wb-0e
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZDm-0000xB-9k
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:22:05 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hfZDk-0000uC-2Q
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:22:00 -0400
Received: by mail-ot1-x344.google.com with SMTP id 43so10616119otf.8
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=zP6ytxfCIHppSQK4AAyPQO8ewqAosWDzzkXLfrDdmgQ=;
 b=lwc5RHp+ZBEVU1VWtXCP4DU1I2fedwdqzWCjblUbkjnhVzS0vkcPkz/ZhyE0Te8OFy
 wItg07XQpbuZPtbiMnPxeptokMfmmiib+5ppuekk+IiQOQVLFItCng7Fqf8nK+b8jONe
 /PosB54Z0kF9770niXu3Ci5xW5MbsaLl9QbdXxiFWIhJSfGsTMow3Kl8zpdhNoIUjTDK
 uTECX5F2hFdJ+VhLb5mJNX9mYK+CWFLXsuVACbLGvC6jeBF1+r3wCMQgujW9UDky40Ze
 8ivq2hFM4k9BfIWxiMi9604sMr7zEsdLpDeGXHENwN/GnQdaWvuyJv9/ShhVuEnbomZl
 +eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=zP6ytxfCIHppSQK4AAyPQO8ewqAosWDzzkXLfrDdmgQ=;
 b=oZs4US0f0Fk5U13+4qesBIfdHkaq+v3ncSTisNP+XcxrYHM3HsiNut5Ttl9T3/zxRw
 NUo1Ge0EaUn2AYBTBqbw4T4Y1MXG2NM0nyc3Wpi7+VJzqIKdcoKixrWnka+PIYoc16iG
 CxOmnm6CKrpuyPINsetLtUTzYAbpEvVKpY7aMSuaWlDCNh67eXjzyhCwlHY+ukHazdls
 8uNEhc4df8CnGS94TLjdNHOB06/MOG/sSZA+rARyUMx9V++Y2IOWr8t3phCcsvqSp9D4
 taTDW1I00gdfjNBTcoOYNAFBNDKPm/7IjgKuZTSoXPJ6fCNhuiShHSsEQNYSakUaLe2p
 9apA==
X-Gm-Message-State: APjAAAXgyW2/EKBBpjkorwKLcdV6twWE+SUdWe6kf28fGWMSQRk9dlsS
 s117p0zcROC6hrfnEKx6xTqF2iGYGAzeW3nE+rX55g==
X-Google-Smtp-Source: APXvYqyj609Iu+Gpxk4jU49AV12/J1hC2rvFNT+eYJuEIXJ60NgIzckVsDsRENagRaKZ6M6Go+0W6qr0Ti/B8wlU8Dw=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr12739178otr.295.1561422118644; 
 Mon, 24 Jun 2019 17:21:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:21:58
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:21:58
 -0700 (PDT)
In-Reply-To: <20190624222844.26584-3-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-3-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 25 Jun 2019 02:21:58 +0200
Message-ID: <CAL1e-=juYo93V2LkhPiE6-Ud0sHEx9u-EBMPbQkk4g-wSZeq+Q@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 02/10] hw/mips/gt64xxx_pci: Fix 'tabs'
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

On Jun 25, 2019 12:30 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> Since we'll move this code around, fix its style first:
>
>   ERROR: code indent should never use tabs
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  hw/mips/gt64xxx_pci.c | 312 +++++++++++++++++++++---------------------
>  1 file changed, 156 insertions(+), 156 deletions(-)
>
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index c0924646b5..bbd719f091 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -38,192 +38,192 @@
>  #define DPRINTF(fmt, ...)
>  #endif
>
> -#define GT_REGS                        (0x1000 >> 2)
> +#define GT_REGS                 (0x1000 >> 2)
>
>  /* CPU Configuration */
> -#define GT_CPU                 (0x000 >> 2)
> -#define GT_MULTI               (0x120 >> 2)
> +#define GT_CPU                  (0x000 >> 2)
> +#define GT_MULTI                (0x120 >> 2)
>
>  /* CPU Address Decode */
> -#define GT_SCS10LD             (0x008 >> 2)
> -#define GT_SCS10HD             (0x010 >> 2)
> -#define GT_SCS32LD             (0x018 >> 2)
> -#define GT_SCS32HD             (0x020 >> 2)
> -#define GT_CS20LD              (0x028 >> 2)
> -#define GT_CS20HD              (0x030 >> 2)
> -#define GT_CS3BOOTLD           (0x038 >> 2)
> -#define GT_CS3BOOTHD           (0x040 >> 2)
> -#define GT_PCI0IOLD                    (0x048 >> 2)
> -#define GT_PCI0IOHD                    (0x050 >> 2)
> -#define GT_PCI0M0LD                    (0x058 >> 2)
> -#define GT_PCI0M0HD                    (0x060 >> 2)
> -#define GT_PCI0M1LD                    (0x080 >> 2)
> -#define GT_PCI0M1HD                    (0x088 >> 2)
> -#define GT_PCI1IOLD                    (0x090 >> 2)
> -#define GT_PCI1IOHD                    (0x098 >> 2)
> -#define GT_PCI1M0LD                    (0x0a0 >> 2)
> -#define GT_PCI1M0HD                    (0x0a8 >> 2)
> -#define GT_PCI1M1LD                    (0x0b0 >> 2)
> -#define GT_PCI1M1HD                    (0x0b8 >> 2)
> -#define GT_ISD                 (0x068 >> 2)
> -
> -#define GT_SCS10AR             (0x0d0 >> 2)
> -#define GT_SCS32AR             (0x0d8 >> 2)
> -#define GT_CS20R               (0x0e0 >> 2)
> -#define GT_CS3BOOTR                    (0x0e8 >> 2)
> -
> -#define GT_PCI0IOREMAP         (0x0f0 >> 2)
> -#define GT_PCI0M0REMAP         (0x0f8 >> 2)
> -#define GT_PCI0M1REMAP         (0x100 >> 2)
> -#define GT_PCI1IOREMAP         (0x108 >> 2)
> -#define GT_PCI1M0REMAP         (0x110 >> 2)
> -#define GT_PCI1M1REMAP         (0x118 >> 2)
> +#define GT_SCS10LD              (0x008 >> 2)
> +#define GT_SCS10HD              (0x010 >> 2)
> +#define GT_SCS32LD              (0x018 >> 2)
> +#define GT_SCS32HD              (0x020 >> 2)
> +#define GT_CS20LD               (0x028 >> 2)
> +#define GT_CS20HD               (0x030 >> 2)
> +#define GT_CS3BOOTLD            (0x038 >> 2)
> +#define GT_CS3BOOTHD            (0x040 >> 2)
> +#define GT_PCI0IOLD             (0x048 >> 2)
> +#define GT_PCI0IOHD             (0x050 >> 2)
> +#define GT_PCI0M0LD             (0x058 >> 2)
> +#define GT_PCI0M0HD             (0x060 >> 2)
> +#define GT_PCI0M1LD             (0x080 >> 2)
> +#define GT_PCI0M1HD             (0x088 >> 2)
> +#define GT_PCI1IOLD             (0x090 >> 2)
> +#define GT_PCI1IOHD             (0x098 >> 2)
> +#define GT_PCI1M0LD             (0x0a0 >> 2)
> +#define GT_PCI1M0HD             (0x0a8 >> 2)
> +#define GT_PCI1M1LD             (0x0b0 >> 2)
> +#define GT_PCI1M1HD             (0x0b8 >> 2)
> +#define GT_ISD                  (0x068 >> 2)
> +
> +#define GT_SCS10AR              (0x0d0 >> 2)
> +#define GT_SCS32AR              (0x0d8 >> 2)
> +#define GT_CS20R                (0x0e0 >> 2)
> +#define GT_CS3BOOTR             (0x0e8 >> 2)
> +
> +#define GT_PCI0IOREMAP          (0x0f0 >> 2)
> +#define GT_PCI0M0REMAP          (0x0f8 >> 2)
> +#define GT_PCI0M1REMAP          (0x100 >> 2)
> +#define GT_PCI1IOREMAP          (0x108 >> 2)
> +#define GT_PCI1M0REMAP          (0x110 >> 2)
> +#define GT_PCI1M1REMAP          (0x118 >> 2)
>
>  /* CPU Error Report */
> -#define GT_CPUERR_ADDRLO       (0x070 >> 2)
> -#define GT_CPUERR_ADDRHI       (0x078 >> 2)
> -#define GT_CPUERR_DATALO       (0x128 >> 2)            /* GT-64120A
only  */
> -#define GT_CPUERR_DATAHI       (0x130 >> 2)            /* GT-64120A
only  */
> -#define GT_CPUERR_PARITY       (0x138 >> 2)            /* GT-64120A
only  */
> +#define GT_CPUERR_ADDRLO        (0x070 >> 2)
> +#define GT_CPUERR_ADDRHI        (0x078 >> 2)
> +#define GT_CPUERR_DATALO        (0x128 >> 2)        /* GT-64120A only  *=
/
> +#define GT_CPUERR_DATAHI        (0x130 >> 2)        /* GT-64120A only  *=
/
> +#define GT_CPUERR_PARITY        (0x138 >> 2)        /* GT-64120A only  *=
/
>
>  /* CPU Sync Barrier */
> -#define GT_PCI0SYNC                    (0x0c0 >> 2)
> -#define GT_PCI1SYNC                    (0x0c8 >> 2)
> +#define GT_PCI0SYNC             (0x0c0 >> 2)
> +#define GT_PCI1SYNC             (0x0c8 >> 2)
>
>  /* SDRAM and Device Address Decode */
> -#define GT_SCS0LD              (0x400 >> 2)
> -#define GT_SCS0HD              (0x404 >> 2)
> -#define GT_SCS1LD              (0x408 >> 2)
> -#define GT_SCS1HD              (0x40c >> 2)
> -#define GT_SCS2LD              (0x410 >> 2)
> -#define GT_SCS2HD              (0x414 >> 2)
> -#define GT_SCS3LD              (0x418 >> 2)
> -#define GT_SCS3HD              (0x41c >> 2)
> -#define GT_CS0LD               (0x420 >> 2)
> -#define GT_CS0HD               (0x424 >> 2)
> -#define GT_CS1LD               (0x428 >> 2)
> -#define GT_CS1HD               (0x42c >> 2)
> -#define GT_CS2LD               (0x430 >> 2)
> -#define GT_CS2HD               (0x434 >> 2)
> -#define GT_CS3LD               (0x438 >> 2)
> -#define GT_CS3HD               (0x43c >> 2)
> -#define GT_BOOTLD              (0x440 >> 2)
> -#define GT_BOOTHD              (0x444 >> 2)
> -#define GT_ADERR               (0x470 >> 2)
> +#define GT_SCS0LD               (0x400 >> 2)
> +#define GT_SCS0HD               (0x404 >> 2)
> +#define GT_SCS1LD               (0x408 >> 2)
> +#define GT_SCS1HD               (0x40c >> 2)
> +#define GT_SCS2LD               (0x410 >> 2)
> +#define GT_SCS2HD               (0x414 >> 2)
> +#define GT_SCS3LD               (0x418 >> 2)
> +#define GT_SCS3HD               (0x41c >> 2)
> +#define GT_CS0LD                (0x420 >> 2)
> +#define GT_CS0HD                (0x424 >> 2)
> +#define GT_CS1LD                (0x428 >> 2)
> +#define GT_CS1HD                (0x42c >> 2)
> +#define GT_CS2LD                (0x430 >> 2)
> +#define GT_CS2HD                (0x434 >> 2)
> +#define GT_CS3LD                (0x438 >> 2)
> +#define GT_CS3HD                (0x43c >> 2)
> +#define GT_BOOTLD               (0x440 >> 2)
> +#define GT_BOOTHD               (0x444 >> 2)
> +#define GT_ADERR                (0x470 >> 2)
>
>  /* SDRAM Configuration */
> -#define GT_SDRAM_CFG           (0x448 >> 2)
> -#define GT_SDRAM_OPMODE        (0x474 >> 2)
> -#define GT_SDRAM_BM                    (0x478 >> 2)
> -#define GT_SDRAM_ADDRDECODE            (0x47c >> 2)
> +#define GT_SDRAM_CFG            (0x448 >> 2)
> +#define GT_SDRAM_OPMODE         (0x474 >> 2)
> +#define GT_SDRAM_BM             (0x478 >> 2)
> +#define GT_SDRAM_ADDRDECODE     (0x47c >> 2)
>
>  /* SDRAM Parameters */
> -#define GT_SDRAM_B0                    (0x44c >> 2)
> -#define GT_SDRAM_B1                    (0x450 >> 2)
> -#define GT_SDRAM_B2                    (0x454 >> 2)
> -#define GT_SDRAM_B3                    (0x458 >> 2)
> +#define GT_SDRAM_B0             (0x44c >> 2)
> +#define GT_SDRAM_B1             (0x450 >> 2)
> +#define GT_SDRAM_B2             (0x454 >> 2)
> +#define GT_SDRAM_B3             (0x458 >> 2)
>
>  /* Device Parameters */
> -#define GT_DEV_B0              (0x45c >> 2)
> -#define GT_DEV_B1              (0x460 >> 2)
> -#define GT_DEV_B2              (0x464 >> 2)
> -#define GT_DEV_B3              (0x468 >> 2)
> -#define GT_DEV_BOOT                    (0x46c >> 2)
> +#define GT_DEV_B0               (0x45c >> 2)
> +#define GT_DEV_B1               (0x460 >> 2)
> +#define GT_DEV_B2               (0x464 >> 2)
> +#define GT_DEV_B3               (0x468 >> 2)
> +#define GT_DEV_BOOT             (0x46c >> 2)
>
>  /* ECC */
> -#define GT_ECC_ERRDATALO       (0x480 >> 2)            /* GT-64120A
only  */
> -#define GT_ECC_ERRDATAHI       (0x484 >> 2)            /* GT-64120A
only  */
> -#define GT_ECC_MEM             (0x488 >> 2)            /* GT-64120A
only  */
> -#define GT_ECC_CALC            (0x48c >> 2)            /* GT-64120A
only  */
> -#define GT_ECC_ERRADDR         (0x490 >> 2)            /* GT-64120A
only  */
> +#define GT_ECC_ERRDATALO        (0x480 >> 2)        /* GT-64120A only  *=
/
> +#define GT_ECC_ERRDATAHI        (0x484 >> 2)        /* GT-64120A only  *=
/
> +#define GT_ECC_MEM              (0x488 >> 2)        /* GT-64120A only  *=
/
> +#define GT_ECC_CALC             (0x48c >> 2)        /* GT-64120A only  *=
/
> +#define GT_ECC_ERRADDR          (0x490 >> 2)        /* GT-64120A only  *=
/
>
>  /* DMA Record */
> -#define GT_DMA0_CNT                    (0x800 >> 2)
> -#define GT_DMA1_CNT                    (0x804 >> 2)
> -#define GT_DMA2_CNT                    (0x808 >> 2)
> -#define GT_DMA3_CNT                    (0x80c >> 2)
> -#define GT_DMA0_SA             (0x810 >> 2)
> -#define GT_DMA1_SA             (0x814 >> 2)
> -#define GT_DMA2_SA             (0x818 >> 2)
> -#define GT_DMA3_SA             (0x81c >> 2)
> -#define GT_DMA0_DA             (0x820 >> 2)
> -#define GT_DMA1_DA             (0x824 >> 2)
> -#define GT_DMA2_DA             (0x828 >> 2)
> -#define GT_DMA3_DA             (0x82c >> 2)
> -#define GT_DMA0_NEXT           (0x830 >> 2)
> -#define GT_DMA1_NEXT           (0x834 >> 2)
> -#define GT_DMA2_NEXT           (0x838 >> 2)
> -#define GT_DMA3_NEXT           (0x83c >> 2)
> -#define GT_DMA0_CUR                    (0x870 >> 2)
> -#define GT_DMA1_CUR                    (0x874 >> 2)
> -#define GT_DMA2_CUR                    (0x878 >> 2)
> -#define GT_DMA3_CUR                    (0x87c >> 2)
> +#define GT_DMA0_CNT             (0x800 >> 2)
> +#define GT_DMA1_CNT             (0x804 >> 2)
> +#define GT_DMA2_CNT             (0x808 >> 2)
> +#define GT_DMA3_CNT             (0x80c >> 2)
> +#define GT_DMA0_SA              (0x810 >> 2)
> +#define GT_DMA1_SA              (0x814 >> 2)
> +#define GT_DMA2_SA              (0x818 >> 2)
> +#define GT_DMA3_SA              (0x81c >> 2)
> +#define GT_DMA0_DA              (0x820 >> 2)
> +#define GT_DMA1_DA              (0x824 >> 2)
> +#define GT_DMA2_DA              (0x828 >> 2)
> +#define GT_DMA3_DA              (0x82c >> 2)
> +#define GT_DMA0_NEXT            (0x830 >> 2)
> +#define GT_DMA1_NEXT            (0x834 >> 2)
> +#define GT_DMA2_NEXT            (0x838 >> 2)
> +#define GT_DMA3_NEXT            (0x83c >> 2)
> +#define GT_DMA0_CUR             (0x870 >> 2)
> +#define GT_DMA1_CUR             (0x874 >> 2)
> +#define GT_DMA2_CUR             (0x878 >> 2)
> +#define GT_DMA3_CUR             (0x87c >> 2)
>
>  /* DMA Channel Control */
> -#define GT_DMA0_CTRL           (0x840 >> 2)
> -#define GT_DMA1_CTRL           (0x844 >> 2)
> -#define GT_DMA2_CTRL           (0x848 >> 2)
> -#define GT_DMA3_CTRL           (0x84c >> 2)
> +#define GT_DMA0_CTRL            (0x840 >> 2)
> +#define GT_DMA1_CTRL            (0x844 >> 2)
> +#define GT_DMA2_CTRL            (0x848 >> 2)
> +#define GT_DMA3_CTRL            (0x84c >> 2)
>
>  /* DMA Arbiter */
> -#define GT_DMA_ARB             (0x860 >> 2)
> +#define GT_DMA_ARB              (0x860 >> 2)
>
>  /* Timer/Counter */
> -#define GT_TC0                 (0x850 >> 2)
> -#define GT_TC1                 (0x854 >> 2)
> -#define GT_TC2                 (0x858 >> 2)
> -#define GT_TC3                 (0x85c >> 2)
> -#define GT_TC_CONTROL          (0x864 >> 2)
> +#define GT_TC0                  (0x850 >> 2)
> +#define GT_TC1                  (0x854 >> 2)
> +#define GT_TC2                  (0x858 >> 2)
> +#define GT_TC3                  (0x85c >> 2)
> +#define GT_TC_CONTROL           (0x864 >> 2)
>
>  /* PCI Internal */
> -#define GT_PCI0_CMD                    (0xc00 >> 2)
> -#define GT_PCI0_TOR                    (0xc04 >> 2)
> -#define GT_PCI0_BS_SCS10       (0xc08 >> 2)
> -#define GT_PCI0_BS_SCS32       (0xc0c >> 2)
> -#define GT_PCI0_BS_CS20        (0xc10 >> 2)
> -#define GT_PCI0_BS_CS3BT       (0xc14 >> 2)
> -#define GT_PCI1_IACK           (0xc30 >> 2)
> -#define GT_PCI0_IACK           (0xc34 >> 2)
> -#define GT_PCI0_BARE           (0xc3c >> 2)
> -#define GT_PCI0_PREFMBR        (0xc40 >> 2)
> -#define GT_PCI0_SCS10_BAR      (0xc48 >> 2)
> -#define GT_PCI0_SCS32_BAR      (0xc4c >> 2)
> -#define GT_PCI0_CS20_BAR       (0xc50 >> 2)
> -#define GT_PCI0_CS3BT_BAR      (0xc54 >> 2)
> -#define GT_PCI0_SSCS10_BAR     (0xc58 >> 2)
> -#define GT_PCI0_SSCS32_BAR     (0xc5c >> 2)
> -#define GT_PCI0_SCS3BT_BAR     (0xc64 >> 2)
> -#define GT_PCI1_CMD                    (0xc80 >> 2)
> -#define GT_PCI1_TOR                    (0xc84 >> 2)
> -#define GT_PCI1_BS_SCS10       (0xc88 >> 2)
> -#define GT_PCI1_BS_SCS32       (0xc8c >> 2)
> -#define GT_PCI1_BS_CS20        (0xc90 >> 2)
> -#define GT_PCI1_BS_CS3BT       (0xc94 >> 2)
> -#define GT_PCI1_BARE           (0xcbc >> 2)
> -#define GT_PCI1_PREFMBR        (0xcc0 >> 2)
> -#define GT_PCI1_SCS10_BAR      (0xcc8 >> 2)
> -#define GT_PCI1_SCS32_BAR      (0xccc >> 2)
> -#define GT_PCI1_CS20_BAR       (0xcd0 >> 2)
> -#define GT_PCI1_CS3BT_BAR      (0xcd4 >> 2)
> -#define GT_PCI1_SSCS10_BAR     (0xcd8 >> 2)
> -#define GT_PCI1_SSCS32_BAR     (0xcdc >> 2)
> -#define GT_PCI1_SCS3BT_BAR     (0xce4 >> 2)
> -#define GT_PCI1_CFGADDR        (0xcf0 >> 2)
> -#define GT_PCI1_CFGDATA        (0xcf4 >> 2)
> -#define GT_PCI0_CFGADDR        (0xcf8 >> 2)
> -#define GT_PCI0_CFGDATA        (0xcfc >> 2)
> +#define GT_PCI0_CMD             (0xc00 >> 2)
> +#define GT_PCI0_TOR             (0xc04 >> 2)
> +#define GT_PCI0_BS_SCS10        (0xc08 >> 2)
> +#define GT_PCI0_BS_SCS32        (0xc0c >> 2)
> +#define GT_PCI0_BS_CS20         (0xc10 >> 2)
> +#define GT_PCI0_BS_CS3BT        (0xc14 >> 2)
> +#define GT_PCI1_IACK            (0xc30 >> 2)
> +#define GT_PCI0_IACK            (0xc34 >> 2)
> +#define GT_PCI0_BARE            (0xc3c >> 2)
> +#define GT_PCI0_PREFMBR         (0xc40 >> 2)
> +#define GT_PCI0_SCS10_BAR       (0xc48 >> 2)
> +#define GT_PCI0_SCS32_BAR       (0xc4c >> 2)
> +#define GT_PCI0_CS20_BAR        (0xc50 >> 2)
> +#define GT_PCI0_CS3BT_BAR       (0xc54 >> 2)
> +#define GT_PCI0_SSCS10_BAR      (0xc58 >> 2)
> +#define GT_PCI0_SSCS32_BAR      (0xc5c >> 2)
> +#define GT_PCI0_SCS3BT_BAR      (0xc64 >> 2)
> +#define GT_PCI1_CMD             (0xc80 >> 2)
> +#define GT_PCI1_TOR             (0xc84 >> 2)
> +#define GT_PCI1_BS_SCS10        (0xc88 >> 2)
> +#define GT_PCI1_BS_SCS32        (0xc8c >> 2)
> +#define GT_PCI1_BS_CS20         (0xc90 >> 2)
> +#define GT_PCI1_BS_CS3BT        (0xc94 >> 2)
> +#define GT_PCI1_BARE            (0xcbc >> 2)
> +#define GT_PCI1_PREFMBR         (0xcc0 >> 2)
> +#define GT_PCI1_SCS10_BAR       (0xcc8 >> 2)
> +#define GT_PCI1_SCS32_BAR       (0xccc >> 2)
> +#define GT_PCI1_CS20_BAR        (0xcd0 >> 2)
> +#define GT_PCI1_CS3BT_BAR       (0xcd4 >> 2)
> +#define GT_PCI1_SSCS10_BAR      (0xcd8 >> 2)
> +#define GT_PCI1_SSCS32_BAR      (0xcdc >> 2)
> +#define GT_PCI1_SCS3BT_BAR      (0xce4 >> 2)
> +#define GT_PCI1_CFGADDR         (0xcf0 >> 2)
> +#define GT_PCI1_CFGDATA         (0xcf4 >> 2)
> +#define GT_PCI0_CFGADDR         (0xcf8 >> 2)
> +#define GT_PCI0_CFGDATA         (0xcfc >> 2)
>
>  /* Interrupts */
> -#define GT_INTRCAUSE           (0xc18 >> 2)
> -#define GT_INTRMASK                    (0xc1c >> 2)
> -#define GT_PCI0_ICMASK         (0xc24 >> 2)
> -#define GT_PCI0_SERR0MASK      (0xc28 >> 2)
> -#define GT_CPU_INTSEL          (0xc70 >> 2)
> -#define GT_PCI0_INTSEL         (0xc74 >> 2)
> -#define GT_HINTRCAUSE          (0xc98 >> 2)
> -#define GT_HINTRMASK           (0xc9c >> 2)
> -#define GT_PCI0_HICMASK        (0xca4 >> 2)
> -#define GT_PCI1_SERR1MASK      (0xca8 >> 2)
> +#define GT_INTRCAUSE            (0xc18 >> 2)
> +#define GT_INTRMASK             (0xc1c >> 2)
> +#define GT_PCI0_ICMASK          (0xc24 >> 2)
> +#define GT_PCI0_SERR0MASK       (0xc28 >> 2)
> +#define GT_CPU_INTSEL           (0xc70 >> 2)
> +#define GT_PCI0_INTSEL          (0xc74 >> 2)
> +#define GT_HINTRCAUSE           (0xc98 >> 2)
> +#define GT_HINTRMASK            (0xc9c >> 2)
> +#define GT_PCI0_HICMASK         (0xca4 >> 2)
> +#define GT_PCI1_SERR1MASK       (0xca8 >> 2)
>
>  #define PCI_MAPPING_ENTRY(regname)            \
>      hwaddr regname ##_start;      \
> --
> 2.19.1
>
>
