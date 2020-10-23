Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4730C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 23:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007C82070E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 23:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls7UUtCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007C82070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW6r0-0007o5-Kl
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 19:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW6qD-0007Ej-MV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 19:51:25 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW6qB-0004q1-Rg
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 19:51:25 -0400
Received: by mail-io1-xd41.google.com with SMTP id h21so3953862iob.10
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 16:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9aDyIkPNs9iyfadfR5q0oj+5pUFMynmwv/FOtbusPGo=;
 b=Ls7UUtCnbWGv1HxIMYeRcJX31ruWrgJwBOK6tq7oGJpyeHP8rJSz+8AfqP/59oATvW
 GuqM0p021mnjzbqxgfS2sgcWoJW4aneNsdC/3D4Hd4Y70kYDeC4weHRHnH7LeSK+M/8N
 cufuYiV39x8OZh2tufTpVvwKh17y2I6NXD0OVug0op7SNfuvQ7fLsqQWS1S5p237S4ZD
 0Vo8G0k9H74gq66zO+cuO88lJ+qzvHuoHZjGmNFPNW7/uPGjBBZeKPC+unw3HErEt82q
 f9xsosKaaCxgnxAV6o29cygvCwN5zmTWLCO1AVYvyfVsEvs+WK1ApqYip8wWWdwOTSdh
 CzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9aDyIkPNs9iyfadfR5q0oj+5pUFMynmwv/FOtbusPGo=;
 b=HEOkVt+lW8D8LA+o/Z1ofkGnzgJz5Z7K7uYUiV2JpjR1RQ9FTOzGX7/Y3hTvIGMdSz
 hlpBck8Fsf4YzSeHwHiWR+1Ar/XY14ipFOSrKFkEGOIylrBYfR4abqCeEO6rROrU/uG8
 3+VmylpN/hrijSj/9O6xPcxEFhYzehqG/06JuIqmyz3EoH7iumYWewqrZMm24XD0n9zK
 BRHB3OcR7kop4ldD+p6K9wi5qa1McQa5HS6bWgBYkD6j9eN8mLvn2GEAbN1UWATcu1q8
 pmXR5JWnrmJwWQTS1HqHOI0nypEKr01TV/Fh+KZno5OI4xPgLeBRMM/fi3kUV7z2yiUp
 FTfg==
X-Gm-Message-State: AOAM533p+AdEnVHFAiYmjwFH5kf5maW84+pDqcayCrU+74hHCxpAOYyq
 rvoqNq3wjfSZKu4NGClp7MzLvxUqDolrSrJGW6M=
X-Google-Smtp-Source: ABdhPJwjQy/IheCZieM0pr51unvh9NmZwTlWRHl1vChQOUx48bDBJEW+1pvtYpPOLKbYEythP+IgS5zqDoXFUoa08VY=
X-Received: by 2002:a6b:b80a:: with SMTP id i10mr3644600iof.118.1603497081956; 
 Fri, 23 Oct 2020 16:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201023214506.917601-1-keithp@keithp.com>
 <20201023214506.917601-3-keithp@keithp.com>
In-Reply-To: <20201023214506.917601-3-keithp@keithp.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 16:39:34 -0700
Message-ID: <CAKmqyKPtV4fsKhaaiSTwsOgi=w-B3oUP=_93ftLgpqBY6874iA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add sifive test device to sifive_u target
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 2:48 PM Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> The SiFive test device provides a mechanism for terminating the qemu
> instance from the emulated system. This patch adds that device to the
> sifive_u target, including constructing a suitable FDT node.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  hw/riscv/sifive_u.c         | 15 +++++++++++++++
>  include/hw/riscv/sifive_u.h |  1 +
>  2 files changed, 16 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 6ad975d692..8d803fe7c0 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -15,6 +15,7 @@
>   * 5) OTP (One-Time Programmable) memory with stored serial number
>   * 6) GEM (Gigabit Ethernet Controller) and management block
>   * 7) DMA (Direct Memory Access Controller)
> + * 8) TEST (Test device)
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -44,6 +45,7 @@
>  #include "hw/char/serial.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/misc/unimp.h"
> +#include "hw/misc/sifive_test.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_u.h"
> @@ -72,6 +74,7 @@ static const struct MemmapEntry {
>  } sifive_u_memmap[] = {
>      [SIFIVE_U_DEV_DEBUG] =    {        0x0,      0x100 },
>      [SIFIVE_U_DEV_MROM] =     {     0x1000,     0xf000 },
> +    [SIFIVE_U_DEV_TEST] =     {   0x100000,     0x1000 },

I also don't see this in the FU540 memory map.

Alistair

>      [SIFIVE_U_DEV_CLINT] =    {  0x2000000,    0x10000 },
>      [SIFIVE_U_DEV_L2CC] =     {  0x2010000,     0x1000 },
>      [SIFIVE_U_DEV_PDMA] =     {  0x3000000,   0x100000 },
> @@ -397,6 +400,16 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
>
>      g_free(nodename);
> +
> +    nodename = g_strdup_printf("/soc/test@%lx",
> +                               (long)memmap[SIFIVE_U_DEV_TEST].base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +                           0x0, memmap[SIFIVE_U_DEV_TEST].base,
> +                           0x0, memmap[SIFIVE_U_DEV_TEST].size);
> +
> +    g_free(nodename);
>  }
>
>  static void sifive_u_machine_reset(void *opaque, int n, int level)
> @@ -780,6 +793,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
>                         qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_GEM_IRQ));
>
> +    sifive_test_create(memmap[SIFIVE_U_DEV_TEST].base);
> +
>      create_unimplemented_device("riscv.sifive.u.gem-mgmt",
>          memmap[SIFIVE_U_DEV_GEM_MGMT].base, memmap[SIFIVE_U_DEV_GEM_MGMT].size);
>
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 22e7e6efa1..4b3ebc3fc6 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -72,6 +72,7 @@ typedef struct SiFiveUState {
>  enum {
>      SIFIVE_U_DEV_DEBUG,
>      SIFIVE_U_DEV_MROM,
> +    SIFIVE_U_DEV_TEST,
>      SIFIVE_U_DEV_CLINT,
>      SIFIVE_U_DEV_L2CC,
>      SIFIVE_U_DEV_PDMA,
> --
> 2.28.0
>
>

