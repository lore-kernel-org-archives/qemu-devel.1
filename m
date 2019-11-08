Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A41FFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4B0214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4B0214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5PW-0003s5-AA
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT5Nk-00023a-1Z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT5Nh-0006zo-Gg
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:36:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT5Nh-0006zW-7X
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:36:57 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E370981F18
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 14:36:55 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id t203so2425630wmt.7
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 06:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bGyB2l+L2J9XVFlSRDA/99x5ihQsi7V4IA5ViDSS1/M=;
 b=lGxidcYYRu3FZTKQFaVU8eG0YgJqibOye6J/lyGg+oHCdVvM4839ackjz8Lb4NA1ap
 flCIQpUKIkFjS5x3HyoFC45WGMpSxkBsMy9Tctl/SLvhAY7zE7QMauFnR5+0B3sb4poJ
 Sm/KMhz3nK1WkSrDQKgZ/eVBlESmjsafS+L5lnXPNRXrm/HPETmqQMdEn4I8J5iSyG8I
 D/bfydikoxEMNuJTNm+WBdDEWZSTjOidOL+F3a5L6udK6FzAF8FmUJy4s9TZ7QPjmEIB
 UJAHvmi8NaxyASo+t3YR9R+8e6WTqKfvlKaRm7AzVE/CagDVylWIzerXHH7wiPFl4m1I
 BcjA==
X-Gm-Message-State: APjAAAXwo38HVVr+f06iS4KpTD65RafwUPqx1hxDHvL45Exz/nysJOLZ
 fS52dNoBgden+WuCOKQGvh3Jaa6vBE7hYhzHILeOBqfMUpekPQ+ZS7VOBfDqUUeOFaVI2dadSxH
 Wd4guI3bU6pHn2+Y=
X-Received: by 2002:a1c:f210:: with SMTP id s16mr7711160wmc.24.1573223814567; 
 Fri, 08 Nov 2019 06:36:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqylGsiiouBvVH8sNAuYRaNOjQoGmpS8uUF9dqdi/Ytq9M3qoHY2zxiJulrTGGc2i/9N1JRIxg==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr7711134wmc.24.1573223814307; 
 Fri, 08 Nov 2019 06:36:54 -0800 (PST)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id g5sm7538266wmf.37.2019.11.08.06.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 06:36:53 -0800 (PST)
Subject: Re: [PATCH 2/3] hw/mips/gt64xxx: Remove dynamic field width from
 trace event
To: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20191108142613.26649-1-philmd@redhat.com>
 <20191108142613.26649-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5cffe2ac-634e-5ede-8c2a-b54ee7900464@redhat.com>
Date: Fri, 8 Nov 2019 15:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108142613.26649-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 3:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since not all trace backends support dynamic field width in
> format (dtrace via stap does not), replace by a static field
> width instead.
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/mips/gt64xxx_pci.c | 34 +++++++++++++++++-----------------
>   hw/mips/trace-events  |  4 ++--
>   2 files changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index 5cab9c1ee1..f427793360 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -464,7 +464,7 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "gt64120: Read-only register write "
>                         "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> -                      saddr << 2, size, size << 1, val);
> +                      saddr << 2, size, size << 3, val);

Wrong replacement :( I'll respin.

>           break;
>  =20
>       /* CPU Sync Barrier */
> @@ -474,7 +474,7 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "gt64120: Read-only register write "
>                         "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> -                      saddr << 2, size, size << 1, val);
> +                      saddr << 2, size, size << 3, val);
>           break;
>  =20
>       /* SDRAM and Device Address Decode */
> @@ -516,7 +516,7 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
>           qemu_log_mask(LOG_UNIMP,
>                         "gt64120: Unimplemented device register write "
>                         "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> -                      saddr << 2, size, size << 1, val);
> +                      saddr << 2, size, size << 3, val);
>           break;
>  =20
>       /* ECC */
> @@ -529,7 +529,7 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "gt64120: Read-only register write "
>                         "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> -                      saddr << 2, size, size << 1, val);
> +                      saddr << 2, size, size << 3, val);
>           break;
>  =20
>       /* DMA Record */
> @@ -566,7 +566,7 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
>           qemu_log_mask(LOG_UNIMP,
>                         "gt64120: Unimplemented DMA register write "
>                         "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> -                      saddr << 2, size, size << 1, val);
> +                      saddr << 2, size, size << 3, val);
>           break;
>  =20
>       /* Timer/Counter */
> @@ -579,7 +579,7 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
>           qemu_log_mask(LOG_UNIMP,
>                         "gt64120: Unimplemented timer register write "
>                         "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> -                      saddr << 2, size, size << 1, val);
> +                      saddr << 2, size, size << 3, val);
>           break;
>  =20
>       /* PCI Internal */
> @@ -623,7 +623,7 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
>           qemu_log_mask(LOG_UNIMP,
>                         "gt64120: Unimplemented timer register write "
>                         "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> -                      saddr << 2, size, size << 1, val);
> +                      saddr << 2, size, size << 3, val);
>           break;
>       case GT_PCI0_CFGADDR:
>           phb->config_reg =3D val & 0x80fffffc;
> @@ -642,19 +642,19 @@ static void gt64120_writel(void *opaque, hwaddr a=
ddr,
>           /* not really implemented */
>           s->regs[saddr] =3D ~(~(s->regs[saddr]) | ~(val & 0xfffffffe))=
;
>           s->regs[saddr] |=3D !!(s->regs[saddr] & 0xfffffffe);
> -        trace_gt64120_write("INTRCAUSE", size << 1, val);
> +        trace_gt64120_write("INTRCAUSE", size << 3, val);
>           break;
>       case GT_INTRMASK:
>           s->regs[saddr] =3D val & 0x3c3ffffe;
> -        trace_gt64120_write("INTRMASK", size << 1, val);
> +        trace_gt64120_write("INTRMASK", size << 3, val);
>           break;
>       case GT_PCI0_ICMASK:
>           s->regs[saddr] =3D val & 0x03fffffe;
> -        trace_gt64120_write("ICMASK", size << 1, val);
> +        trace_gt64120_write("ICMASK", size << 3, val);
>           break;
>       case GT_PCI0_SERR0MASK:
>           s->regs[saddr] =3D val & 0x0000003f;
> -        trace_gt64120_write("SERR0MASK", size << 1, val);
> +        trace_gt64120_write("SERR0MASK", size << 3, val);
>           break;
>  =20
>       /* Reserved when only PCI_0 is configured. */
> @@ -683,7 +683,7 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "gt64120: Illegal register write "
>                         "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
> -                      saddr << 2, size, size << 1, val);
> +                      saddr << 2, size, size << 3, val);
>           break;
>       }
>   }
> @@ -930,19 +930,19 @@ static uint64_t gt64120_readl(void *opaque,
>       /* Interrupts */
>       case GT_INTRCAUSE:
>           val =3D s->regs[saddr];
> -        trace_gt64120_read("INTRCAUSE", size << 1, val);
> +        trace_gt64120_read("INTRCAUSE", size << 3, val);
>           break;
>       case GT_INTRMASK:
>           val =3D s->regs[saddr];
> -        trace_gt64120_read("INTRMASK", size << 1, val);
> +        trace_gt64120_read("INTRMASK", size << 3, val);
>           break;
>       case GT_PCI0_ICMASK:
>           val =3D s->regs[saddr];
> -        trace_gt64120_read("ICMASK", size << 1, val);
> +        trace_gt64120_read("ICMASK", size << 3, val);
>           break;
>       case GT_PCI0_SERR0MASK:
>           val =3D s->regs[saddr];
> -        trace_gt64120_read("SERR0MASK", size << 1, val);
> +        trace_gt64120_read("SERR0MASK", size << 3, val);
>           break;
>  =20
>       /* Reserved when only PCI_0 is configured. */
> @@ -960,7 +960,7 @@ static uint64_t gt64120_readl(void *opaque,
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "gt64120: Illegal register read "
>                         "reg:0x03%x size:%u value:0x%0*x\n",
> -                      saddr << 2, size, size << 1, val);
> +                      saddr << 2, size, size << 3, val);
>           break;
>       }
>  =20
> diff --git a/hw/mips/trace-events b/hw/mips/trace-events
> index 75d4c73f2e..86a0213c77 100644
> --- a/hw/mips/trace-events
> +++ b/hw/mips/trace-events
> @@ -1,4 +1,4 @@
>   # gt64xxx.c
> -gt64120_read(const char *regname, int width, uint64_t value) "gt64120 =
read %s value:0x%0*" PRIx64
> -gt64120_write(const char *regname, int width, uint64_t value) "gt64120=
 write %s value:0x%0*" PRIx64
> +gt64120_read(const char *regname, int width, uint64_t value) "gt64120 =
read %s width:%d value:0x%08" PRIx64
> +gt64120_write(const char *regname, int width, uint64_t value) "gt64120=
 write %s width:%d value:0x%08" PRIx64
>   gt64120_isd_remap(uint64_t from_length, uint64_t from_addr, uint64_t =
to_length, uint64_t to_addr) "ISD: 0x%08" PRIx64 "@0x%08" PRIx64 " -> 0x%=
08" PRIx64 "@0x%08" PRIx64
>=20

