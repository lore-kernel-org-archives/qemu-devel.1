Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850ADC76190
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B6C22CB8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swc64e6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B6C22CB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr24E-0008CL-Lw
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44932)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fintelia@gmail.com>) id 1hr244-0007l4-2Y
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1hr242-0004P2-R8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:23:23 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129]:33680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1hr242-0004Lu-GT; Fri, 26 Jul 2019 11:23:22 -0400
Received: by mail-lf1-x129.google.com with SMTP id x3so37434168lfc.0;
 Fri, 26 Jul 2019 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=48g5/7fKLZokJoEmGyyof2Zp4/C/yydyG0e3Yc9fcuA=;
 b=Swc64e6x+XhoTldaLhU1jyVCF1jmhm3Yu6gyLKXASK9WRRXoe+K7DRvH2yrPl9T+ie
 Bvlx194uOkxnXQkgogKKbkbL6iwIhFct5bDgHxG81Mxk2Dwqbd0mhRYOyqoptFO6WEHK
 7iHLu7OcdomqMd6b7Ilq4hzojoFu85NnhunzWUsE8sObfBtRh44u2w7fAVaNQ6hSlyG4
 NGptsOHtGeYHPEoziOuY6aovT7o3aItdMQ1EBsiEjjFSm16kh/ZZn9IHpiM4dCOUtDV5
 FmT5jRZRj9s0YwS81vwnj9TlgHkXV3WUFxi2a+uLbfmjbPp/mrE+jX/yuijBRVo5mJ3j
 9vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=48g5/7fKLZokJoEmGyyof2Zp4/C/yydyG0e3Yc9fcuA=;
 b=UVu9fSItFIPbByPUIo7jTjK3bvncKvowHqd5g+sM4Ws0iCF4gnrdtKPLPpciovnHXh
 fYBVrlvwNW37yp9DmiIQzmhk7GpZsa8+ZmiESbBtqYEjbADrm5f9eeC3Z/la0Iw4BEwc
 VXcfftehexE6+meyJYmcqn1R0XHQsp1qgJHB5XFgRwyMbFWWmK8c5F6FeULjFXHrt6eM
 skYNhUk5/ngsW0LRb9fSUfpSbKynbJvLO8VxYnLDBi+yp8QMoVxPu8TFD0OqeVxShLe8
 MIZ90dqMPazfBAk43eYJ1fc60lQTmJqnH1WXDGeHr2UhxYM5HcTrl8rWv153prMJq/vl
 yDjw==
X-Gm-Message-State: APjAAAWypfChw9jbT6F32ID7eUTw1tZP+E2YaP5NFrxdGHV3rrQeyZ+O
 dvAbTBBJEWnAnyH9/AI4ePHwWck8P85ium6C97Y=
X-Google-Smtp-Source: APXvYqzl1TcV7VtTYE7+O55ONyS8jJEKE4npjKOJ2toPzCag+yuva3NcFYRFqloV63GDZLsI6BcJmjVAPf8tq93/yH8=
X-Received: by 2002:a19:7006:: with SMTP id h6mr44012172lfc.5.1564154600975;
 Fri, 26 Jul 2019 08:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <50c1c6a3ace8b40f7b9d5395a2c3457cf1852721.1564080680.git.alistair.francis@wdc.com>
In-Reply-To: <50c1c6a3ace8b40f7b9d5395a2c3457cf1852721.1564080680.git.alistair.francis@wdc.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Fri, 26 Jul 2019 11:22:37 -0400
Message-ID: <CANnJOVFLUqNoxbQbyTGTPw+BRedBEEZ_Hm9jGGPLEoe7TbpAtQ@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::129
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH-4.2 v1 3/6] riscv: plic:
 Remove unused interrupt functions
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Jonathan Behrens <fintelia@gmail.com>

On Thu, Jul 25, 2019 at 2:56 PM Alistair Francis <alistair.francis@wdc.com>
wrote:

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_plic.c         | 12 ------------
>  include/hw/riscv/sifive_plic.h |  3 ---
>  2 files changed, 15 deletions(-)
>
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index 0950e89e15..864a1bed42 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -161,18 +161,6 @@ static void sifive_plic_update(SiFivePLICState *plic)
>      }
>  }
>
> -void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq)
> -{
> -    sifive_plic_set_pending(plic, irq, true);
> -    sifive_plic_update(plic);
> -}
> -
> -void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq)
> -{
> -    sifive_plic_set_pending(plic, irq, false);
> -    sifive_plic_update(plic);
> -}
> -
>  static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
>  {
>      int i, j;
> diff --git a/include/hw/riscv/sifive_plic.h
> b/include/hw/riscv/sifive_plic.h
> index ce8907f6aa..3b8a623919 100644
> --- a/include/hw/riscv/sifive_plic.h
> +++ b/include/hw/riscv/sifive_plic.h
> @@ -69,9 +69,6 @@ typedef struct SiFivePLICState {
>      uint32_t aperture_size;
>  } SiFivePLICState;
>
> -void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq);
> -void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq);
> -
>  DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
>      uint32_t num_sources, uint32_t num_priorities,
>      uint32_t priority_base, uint32_t pending_base,
> --
> 2.22.0
>
>
>
