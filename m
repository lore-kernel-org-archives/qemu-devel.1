Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC960C4646B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A089C206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMxwtVol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A089C206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfZTO-0002Rs-So
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 20:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34227)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZSP-00020Q-FT
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZSN-0005p3-N0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:37:09 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hfZSN-0005oN-GC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:37:07 -0400
Received: by mail-oi1-x244.google.com with SMTP id g7so11201469oia.8
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=bWZf79E1vdmlRtIaczMBXqlcqh7tp3J3armsmR1fgpw=;
 b=pMxwtVolRdPJrTIU4tTIZ2Ao3oZRXHnrMzKg3/BssfCItDdSsz4ITBe1hrw9QP+iFu
 8i6udc08q2VsmBtaG+EMT2c3GFZHmmzJxiWRlZVF2PfV8BGu7Ns4Ow40bb+8X+DJnNcD
 c0lKF2qk7nWffbxuXOECuY4libJyEmY1ge4q2bFOmCi81haUzD11eLMeYWvfOd58UUxQ
 uP0aMa1k91Lcsc4q9HTGKBW134sMDBghn6GKdXswaDMo4/0rUF3sb877ouBX/3HSxVK7
 aSCfNMk4TvSH6TDyb4oqFWtEAwV7Tr2Djvdh+LztPd9TLPVQTK3NN6guWl4TgXoStmIc
 4MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=bWZf79E1vdmlRtIaczMBXqlcqh7tp3J3armsmR1fgpw=;
 b=mzg4CxaTO4ruAX/DeUWpBbls2wviwbXz9U8ZspZ43hlbo5esbRzM3sV6ueAX/Wu2A/
 ZeHHKGV2ek+IZoNvxWNU5TkdcGDB8UwHyX5My8xs7DCN990KXgN6RSO6DWxkhENtdpGc
 QfLwzIjZ/dFdF7fjBPlqNsQbK6ozb8UkDVWLteCUu6gHnpXI4C7KIxdxMxscLGG2pdBA
 b6Sizz9QxhSn829GJZlgWYbZVlvcYLrQkSyiPIBiJ4JRqv3WPaurNjm7GuwxATBTbpLo
 puytraFVyjejAcZ1S1j6+jDSsSVlafSmF/H8/ociG2vSzwf6ASURrGOzi3hM8kJIPINF
 MVbg==
X-Gm-Message-State: APjAAAUSWN81zOjEYrqqKlxPqrZ7YfXIKMv0Rgzw/D16aio1SKjLBG8w
 QgDbDSxW80OxB+QL7CHYKzo4uOrfORAJkI1CpzA=
X-Google-Smtp-Source: APXvYqz51MgwaCuqM4IfT8TjnFxZQ2fzSWyR+OlGAqJLoGCDcS5XItXBAhTfh+41csuKa8qeFI2chjjUBTHIQINoM3k=
X-Received: by 2002:aca:abd8:: with SMTP id
 u207mr12706930oie.136.1561423026499; 
 Mon, 24 Jun 2019 17:37:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:37:06
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:37:06
 -0700 (PDT)
In-Reply-To: <20190624222844.26584-6-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-6-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 25 Jun 2019 02:37:06 +0200
Message-ID: <CAL1e-=iToNHH2nFEC-Z3AtqEZakYNv3fULwcnz1f496Yqjxrjw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 05/10] hw/mips/gt64xxx_pci: Use
 qemu_log_mask() instead of debug printf()
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

On Jun 25, 2019 12:42 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

This patch is not only mechanical replacement of printf(), but it also
improves existing log messages, and adds some new ones as well. Reflect
that in both commit message title and body. Perhaps there are more spots
that deserve logging. But, also, please, Philippe, doublecheck in real
scenarios if we don't flood the log with too many messages.

Thank you,
Aleksandar

>  hw/mips/gt64xxx_pci.c | 48 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index 0b9fb02475..f44326f14f 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -23,6 +23,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/mips/mips.h"
>  #include "hw/pci/pci.h"
> @@ -466,12 +467,20 @@ static void gt64120_writel(void *opaque, hwaddr
addr,
>      case GT_CPUERR_DATAHI:
>      case GT_CPUERR_PARITY:
>          /* Read-only registers, do nothing */
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "gt64120: Read-only register write "
> +                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> +                      saddr << 2, size, size << 1, val);
>          break;
>
>      /* CPU Sync Barrier */
>      case GT_PCI0SYNC:
>      case GT_PCI1SYNC:
>          /* Read-only registers, do nothing */
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "gt64120: Read-only register write "
> +                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> +                      saddr << 2, size, size << 1, val);
>          break;
>
>      /* SDRAM and Device Address Decode */
> @@ -510,7 +519,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
>      case GT_DEV_B3:
>      case GT_DEV_BOOT:
>          /* Not implemented */
> -        DPRINTF ("Unimplemented device register offset 0x%x\n", saddr <<
2);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "gt64120: Unimplemented device register write "
> +                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> +                      saddr << 2, size, size << 1, val);
>          break;
>
>      /* ECC */
> @@ -520,6 +532,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
>      case GT_ECC_CALC:
>      case GT_ECC_ERRADDR:
>          /* Read-only registers, do nothing */
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "gt64120: Read-only register write "
> +                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> +                      saddr << 2, size, size << 1, val);
>          break;
>
>      /* DMA Record */
> @@ -543,23 +559,20 @@ static void gt64120_writel(void *opaque, hwaddr
addr,
>      case GT_DMA1_CUR:
>      case GT_DMA2_CUR:
>      case GT_DMA3_CUR:
> -        /* Not implemented */
> -        DPRINTF ("Unimplemented DMA register offset 0x%x\n", saddr << 2)=
;
> -        break;
>
>      /* DMA Channel Control */
>      case GT_DMA0_CTRL:
>      case GT_DMA1_CTRL:
>      case GT_DMA2_CTRL:
>      case GT_DMA3_CTRL:
> -        /* Not implemented */
> -        DPRINTF ("Unimplemented DMA register offset 0x%x\n", saddr << 2)=
;
> -        break;
>
>      /* DMA Arbiter */
>      case GT_DMA_ARB:
>          /* Not implemented */
> -        DPRINTF ("Unimplemented DMA register offset 0x%x\n", saddr << 2)=
;
> +        qemu_log_mask(LOG_UNIMP,
> +                      "gt64120: Unimplemented DMA register write "
> +                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> +                      saddr << 2, size, size << 1, val);
>          break;
>
>      /* Timer/Counter */
> @@ -569,7 +582,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
>      case GT_TC3:
>      case GT_TC_CONTROL:
>          /* Not implemented */
> -        DPRINTF ("Unimplemented timer register offset 0x%x\n", saddr <<
2);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "gt64120: Unimplemented timer register write "
> +                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> +                      saddr << 2, size, size << 1, val);
>          break;
>
>      /* PCI Internal */
> @@ -610,6 +626,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
>      case GT_PCI1_CFGADDR:
>      case GT_PCI1_CFGDATA:
>          /* not implemented */
> +        qemu_log_mask(LOG_UNIMP,
> +                      "gt64120: Unimplemented timer register write "
> +                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> +                      saddr << 2, size, size << 1, val);
>          break;
>      case GT_PCI0_CFGADDR:
>          phb->config_reg =3D val & 0x80fffffc;
> @@ -666,7 +686,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
>          break;
>
>      default:
> -        DPRINTF ("Bad register offset 0x%x\n", (int)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "gt64120: Illegal register write "
> +                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> +                      saddr << 2, size, size << 1, val);
>          break;
>      }
>  }
> @@ -940,7 +963,10 @@ static uint64_t gt64120_readl(void *opaque,
>
>      default:
>          val =3D s->regs[saddr];
> -        DPRINTF ("Bad register offset 0x%x\n", (int)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "gt64120: Illegal register read "
> +                      "reg:0x03%x size:%u value:0x%0*x\n",
> +                      saddr << 2, size, size << 1, val);
>          break;
>      }
>
> --
> 2.19.1
>
>
