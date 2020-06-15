Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657A12078A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/hQoYay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657A12078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkroS-0006aT-K4
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkrn2-0005CF-VR; Mon, 15 Jun 2020 12:16:53 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:40083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkrn1-0003pl-4u; Mon, 15 Jun 2020 12:16:52 -0400
Received: by mail-il1-x143.google.com with SMTP id t8so15836237ilm.7;
 Mon, 15 Jun 2020 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9wsHomtj0zeizuyp8OfCHz9BNt87WuGG7N7Wa4Qh+FA=;
 b=M/hQoYayzj+SebOeP45brGd9IkwwMq4VjQCVgbQvpcoE58B4HriwKNho9cGhHZzhs5
 Wu14T9+D8eV9H9JfHklywqjGmm7cxHr9gFYpUT3PTpO5NgjnXGnXIg5gjyatTnMBgbD6
 iXbrjkH7AoUVfKu/nBrRW8RI0T1y5jfjqxq74PU+murBa5WrYl7BDsGK/+JkLYb0rr6f
 nAYHAGx5uwYkgzZUQwBNKE2CsY54clHNMCsejiuHhFrkOkrr5Zi2UKQOTztSuEhOpG/8
 ZkmYqAulRK+lXWKW/yrWluGfBGNff8jQZc8mKXCI4d+m+LdjlBKGHBWKVnfGTs3Sx2gF
 AyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9wsHomtj0zeizuyp8OfCHz9BNt87WuGG7N7Wa4Qh+FA=;
 b=WikoW7pHvpaZV/t4wFj4KzZKg9UnS1l7RYNZWqNU85qBZqyAZBWuQXHXyARPo9QGQR
 6/7lqqD5YFQphOkMj25BCh1sZhllJEsrxH4vobQJpfQ88HXQUktDJQTL43nL0h8iWxTB
 XiohfRlJFuGpWvDorSt2dLV7BcsN9xkTCK80KVOUbeTW+hAednGPEPyzAjgU3uMo/48B
 iUwRkUkXlrtJdisM03hz4MTj83EMR0ajtEhTbezjIYfRFurAerXto6HNb584PeW6m1N8
 skoAjt2NlVwijGF/cDv4n69QJgNhm0Qk2+7uCe+hfQ33nB5D/kCmp8m0LVOGiMPUrPSR
 Lxrg==
X-Gm-Message-State: AOAM533l0Wb2zl8hq0vxEVLeisAhGUe/PDTraN3UH1UyRf0x3gw5D4+J
 eoCDPn0594Q24Khd044+fkoMlEtmR4KNVI4qnTM=
X-Google-Smtp-Source: ABdhPJx5G3TB8uyCAWljlIe7EfiM4SM3uSPn0tcOTyTtHHmaWVHrY+fhjF34xakhGR4xFNKMUb/hrw6aOySZhcjBSlg=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr28183386ilq.177.1592237809664; 
 Mon, 15 Jun 2020 09:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-4-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-4-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 09:07:26 -0700
Message-ID: <CAKmqyKPqVcztg-060inbqcSEM+1BCrKi9W=-8tw4CjGKHkV3zQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] hw/riscv: sifive_u: Simplify the GEM IRQ connect
 code a little bit
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 7:19 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> There is no need to retrieve all PLIC IRQ information in order to
> just connect the GEM IRQ. Use qdev_get_gpio_in() directly like
> what is done for other peripherals.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index f9fef2b..cf7f833 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -528,7 +528,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>      MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
> -    qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
>      char *plic_hart_config;
>      size_t plic_hart_config_len;
>      int i;
> @@ -612,10 +611,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
>
> -    for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
> -        plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
> -    }
> -
>      if (nd->used) {
>          qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
>          qdev_set_nic_properties(DEVICE(&s->gem), nd);
> @@ -629,7 +624,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
> -                       plic_gpios[SIFIVE_U_GEM_IRQ]);
> +                       qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_GEM_IRQ));
>
>      create_unimplemented_device("riscv.sifive.u.gem-mgmt",
>          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
> --
> 2.7.4
>
>

