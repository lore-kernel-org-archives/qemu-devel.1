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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6BEC48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941792080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu5wGeRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941792080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34542 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfq2J-0004us-Uo
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 14:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48348)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfq0P-0003w1-CY
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfq0L-0007M1-QO
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:17:19 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hfq0J-0007I8-Mc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:17:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id l15so18239762otn.9
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=aWJmttSRlJsPa4EGIopet8NzVUeONC4+1Cajku0uBHc=;
 b=Pu5wGeRTG2OVwchqrrMttyXl11HSfRKjSIG+A9YZALg65FQNEDfBIFT0lOYp7r5KRH
 mdWzi/xVOE4j1/WZWs2NQROM2jwKxH4jYvFJF3g+OoHlmsrdQVOr+EN4m+OTvNIChI0e
 BLDI+J6uFE6orH+Kzv4M9SVkU+7N2UsjCheurudCQ+IcZHVudn1Tkwu52P3HsKSw50mS
 BTRf+Z6ZVgIi3sT4BMOCBAf8W92yoCDR7jKnedYC/CY/J7SjeaPVFsDrjbre7WQdoBcM
 AvmHsQIa+YxbjNLQSzn/+tRXDi+/ZOM64nWk+kG5Vyjr1A9heKUDMw1v+5UgJZqImPF4
 nckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=aWJmttSRlJsPa4EGIopet8NzVUeONC4+1Cajku0uBHc=;
 b=jhDm7RLx6fuCQRRtbsqdHfLs9cb6mpo2BHkujReUYbT2WiiQoMbHJUEjyQ92nboZHr
 QX6A7ILC1FD4RNEyJ38dd7VVqMxnh0zp40nBOrVQZ1kASL8o53zBxwQgMA+3rs3H6gIB
 baTd2rdR5ERb12Xj1D2EArh21SfdvMXwMeowjyFcxgdB2r7KZ8uMTXJpne/vFRl0zcsK
 wwwsTnTihAYQXjHQ50jxqwrYTQbiM6n0bnIGJ9Pge94h2g3yenva/S+TSn9gYATNyJeQ
 gfspWuSTV2EwYb7JV8Esw6hDJzr82zXAIRN5nXNYcLTwzZx1laIvsaX2D5F28EAc7Omc
 J5+A==
X-Gm-Message-State: APjAAAWtrybWNU2N0JUIwpoclXuRHin9iLvk7Isfeg0i5wDgs7i73bDW
 vPG3U8L4sLp8lujp95aQOp4Xwsd0oAN7Vf5SFdQ=
X-Google-Smtp-Source: APXvYqw5ySD0TdQHhDioGlyYJ+e7T7YCHcbl5fovvDoojxNjU/uPFi2v2SZile+IjzgEr3VzOWFohBKu7LuQn9TEjzE=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr16521405otr.295.1561486634843; 
 Tue, 25 Jun 2019 11:17:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Tue, 25 Jun 2019 11:17:14
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Tue, 25 Jun 2019 11:17:14
 -0700 (PDT)
In-Reply-To: <20190624222844.26584-7-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-7-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 25 Jun 2019 20:17:14 +0200
Message-ID: <CAL1e-=giXst=2SuaqLF=gB4SJy-Q7QnT8PVztDighsc323Xg_A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 06/10] hw/mips/gt64xxx_pci: Convert debug
 printf()s to trace events
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

On Jun 25, 2019 12:46 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  Makefile.objs         |  1 +
>  hw/mips/gt64xxx_pci.c | 29 ++++++++++-------------------
>  hw/mips/trace-events  |  4 ++++
>  3 files changed, 15 insertions(+), 19 deletions(-)
>  create mode 100644 hw/mips/trace-events
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 658cfc9d9f..3b83621f32 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -163,6 +163,7 @@ trace-events-subdirs +=3D hw/input
>  trace-events-subdirs +=3D hw/intc
>  trace-events-subdirs +=3D hw/isa
>  trace-events-subdirs +=3D hw/mem
> +trace-events-subdirs +=3D hw/mips
>  trace-events-subdirs +=3D hw/misc
>  trace-events-subdirs +=3D hw/misc/macio
>  trace-events-subdirs +=3D hw/net
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index f44326f14f..815ef0711d 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -30,14 +30,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/i386/pc.h"
>  #include "exec/address-spaces.h"
> -
> -//#define DEBUG
> -
> -#ifdef DEBUG
> -#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__,
##__VA_ARGS__)
> -#else
> -#define DPRINTF(fmt, ...)
> -#endif
> +#include "trace.h"
>
>  #define GT_REGS                 (0x1000 >> 2)
>
> @@ -294,9 +287,7 @@ static void gt64120_isd_mapping(GT64120State *s)
>      check_reserved_space(&start, &length);
>      length =3D 0x1000;
>      /* Map new address */
> -    DPRINTF("ISD: "TARGET_FMT_plx"@"TARGET_FMT_plx
> -        " -> "TARGET_FMT_plx"@"TARGET_FMT_plx"\n",
> -        s->ISD_length, s->ISD_start, length, start);
> +    trace_gt64120_isd_remap(s->ISD_length, s->ISD_start, length, start);
>      s->ISD_start =3D start;
>      s->ISD_length =3D length;
>      memory_region_add_subregion(get_system_memory(), s->ISD_start,
&s->ISD_mem);
> @@ -648,19 +639,19 @@ static void gt64120_writel(void *opaque, hwaddr
addr,
>          /* not really implemented */
>          s->regs[saddr] =3D ~(~(s->regs[saddr]) | ~(val & 0xfffffffe));
>          s->regs[saddr] |=3D !!(s->regs[saddr] & 0xfffffffe);
> -        DPRINTF("INTRCAUSE %" PRIx64 "\n", val);
> +        trace_gt64120_write("INTRCAUSE", size << 1, val);
>          break;
>      case GT_INTRMASK:
>          s->regs[saddr] =3D val & 0x3c3ffffe;
> -        DPRINTF("INTRMASK %" PRIx64 "\n", val);
> +        trace_gt64120_write("INTRMASK", size << 1, val);
>          break;
>      case GT_PCI0_ICMASK:
>          s->regs[saddr] =3D val & 0x03fffffe;
> -        DPRINTF("ICMASK %" PRIx64 "\n", val);
> +        trace_gt64120_write("ICMASK", size << 1, val);
>          break;
>      case GT_PCI0_SERR0MASK:
>          s->regs[saddr] =3D val & 0x0000003f;
> -        DPRINTF("SERR0MASK %" PRIx64 "\n", val);
> +        trace_gt64120_write("SERR0MASK", size << 1, val);
>          break;
>
>      /* Reserved when only PCI_0 is configured. */
> @@ -936,19 +927,19 @@ static uint64_t gt64120_readl(void *opaque,
>      /* Interrupts */
>      case GT_INTRCAUSE:
>          val =3D s->regs[saddr];
> -        DPRINTF("INTRCAUSE %x\n", val);
> +        trace_gt64120_read("INTRCAUSE", size << 1, val);
>          break;
>      case GT_INTRMASK:
>          val =3D s->regs[saddr];
> -        DPRINTF("INTRMASK %x\n", val);
> +        trace_gt64120_read("INTRMASK", size << 1, val);
>          break;
>      case GT_PCI0_ICMASK:
>          val =3D s->regs[saddr];
> -        DPRINTF("ICMASK %x\n", val);
> +        trace_gt64120_read("ICMASK", size << 1, val);
>          break;
>      case GT_PCI0_SERR0MASK:
>          val =3D s->regs[saddr];
> -        DPRINTF("SERR0MASK %x\n", val);
> +        trace_gt64120_read("SERR0MASK", size << 1, val);
>          break;
>
>      /* Reserved when only PCI_0 is configured. */
> diff --git a/hw/mips/trace-events b/hw/mips/trace-events
> new file mode 100644
> index 0000000000..75d4c73f2e
> --- /dev/null
> +++ b/hw/mips/trace-events
> @@ -0,0 +1,4 @@
> +# gt64xxx.c
> +gt64120_read(const char *regname, int width, uint64_t value) "gt64120
read %s value:0x%0*" PRIx64
> +gt64120_write(const char *regname, int width, uint64_t value) "gt64120
write %s value:0x%0*" PRIx64
> +gt64120_isd_remap(uint64_t from_length, uint64_t from_addr, uint64_t
to_length, uint64_t to_addr) "ISD: 0x%08" PRIx64 "@0x%08" PRIx64 " ->
0x%08" PRIx64 "@0x%08" PRIx64
> --
> 2.19.1
>
>
