Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5327C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774462087B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs5QErqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774462087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwrGF-0002WX-Ms
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 13:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57766)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwrFl-00024O-0b
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwrFi-0007oO-OB
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:03:32 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwrFi-0007nU-JD; Sun, 11 Aug 2019 13:03:30 -0400
Received: by mail-ot1-x343.google.com with SMTP id b7so100706621otl.11;
 Sun, 11 Aug 2019 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NOpsI5Z57b8x4z2wks+rml0y4Oc401sAgA2x/KI56LI=;
 b=gs5QErqa/x+DnPwx/fPPDh//HdNapexdWKdrouTb4Z6GIHVL9+zmiESUuLUI09ziea
 nH9ejJ/q5Gd4mEWBpuz0u8wPS8NZ012UXyc/3UUWwqgdgUMIo55ttceVt7+0x+x0Z4U+
 WrOA5826LfmVokhX9e+D6LjxxQGFNojle0HpxDVtZWYDmGfEt5cnp+7H43QGUjB+SkLd
 yu9ONM3r9rXnrQGr14vnt5gtso7O8q2Z8drJh6cL7SLq74IS2rw9ZSF4QQdXF32QIyyS
 V15B4haA0AjaupgaXZhp57fuOnb7EJdluNWy9bF95u40pJ+pmDD2Xv3sC5/ANp7HZSFa
 PaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NOpsI5Z57b8x4z2wks+rml0y4Oc401sAgA2x/KI56LI=;
 b=EFXsPxR6yz5NCJ1UIcOhc+w8Pn4ydxkTa6aDFjZwuDJLWOdmQy39UsaW6ghSUSUQgS
 CMRBZ5ZW61IOBrxU+iY5cJh+HwgV5rtg3188sviYhJOfOTm2Q9s+Onj4j273lr8QESwf
 cV2onYpfRToTsov0kFFQW9q+YI/aR9FOT10XfcsmHAmVnOP/LHqxlf5sZRQjd8IClWCK
 cAQoJijZX5/WsLHVx008OYbsJ10g3JD61HOPOp5uLdEhZwcolJGifpbjo3nrJ5yUiyHJ
 tAPEkraJIa9lkJoDu/V2RL0qKw2RSBf278+gqi/UPe7oWoLafwSf5LLFlwkDd95Ejgb1
 M1aw==
X-Gm-Message-State: APjAAAVxqA+GnyArh4nRXjbAYnIG75XmhQdcegzr1bmlpxiFY4KCy6Sn
 6oTDV4KHFcWtParre0CoSNYAxsg91nuESpKZ/f4=
X-Google-Smtp-Source: APXvYqz7YLVFWg0mw8UHRbxjZ92qzqb2nuUKz9rc5wLjLKPFcJqWlUUSzcX+SoGnV8DS5tD3n9Xwbt9sI2PFX3dQSk4=
X-Received: by 2002:a02:242a:: with SMTP id f42mr33257504jaa.42.1565543009797; 
 Sun, 11 Aug 2019 10:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
 <1565510821-3927-7-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565510821-3927-7-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 11 Aug 2019 10:03:02 -0700
Message-ID: <CAKmqyKNti+X7mSUjw7q-ovmDLWXYcxZxhWC1phWW1CBhDjqy_A@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 06/28] riscv: sifive_u: Update hart
 configuration to reflect the real FU540 SoC
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 11, 2019 at 1:10 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> The FU540-C000 includes a 64-bit E51 RISC-V core and four 64-bit U54
> RISC-V cores. Currently the sifive_u machine only populates 4 U54
> cores. Update the max cpu number to 5 to reflect the real hardware,
> and pass "cpu-type" to populate heterogeneous harts.
>
> The cpu nodes in the generated DTS have been updated as well.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v3:
> - changed to use macros for management and compute cpu count
>
> Changes in v2:
> - fixed the "interrupts-extended" property size
>
>  hw/riscv/sifive_u.c         | 40 +++++++++++++++++++++++++++-------------
>  include/hw/riscv/sifive_u.h |  3 +++
>  2 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 623ee64..295ca77 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -10,7 +10,8 @@
>   * 1) CLINT (Core Level Interruptor)
>   * 2) PLIC (Platform Level Interrupt Controller)
>   *
> - * This board currently uses a hardcoded devicetree that indicates one hart.
> + * This board currently generates devicetree dynamically that indicates at most
> + * five harts.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> @@ -26,6 +27,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -117,7 +119,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_add_subnode(fdt, nodename);
>          qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
>                                SIFIVE_U_CLOCK_FREQ);
> -        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
> +        /* cpu 0 is the management hart that does not have mmu */
> +        if (cpu != 0) {
> +            qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
> +        }
>          qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
>          qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
>          qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
> @@ -157,15 +162,21 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      g_free(nodename);
>
>      plic_phandle = phandle++;
> -    cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4);
> +    cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4 - 2);
>      for (cpu = 0; cpu < s->soc.cpus.num_harts; cpu++) {
>          nodename =
>              g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
>          uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
> -        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> -        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
> -        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
> -        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
> +        /* cpu 0 is the management hart that does not have S-mode */
> +        if (cpu == 0) {
> +            cells[0] = cpu_to_be32(intc_phandle);
> +            cells[1] = cpu_to_be32(IRQ_M_EXT);
> +        } else {
> +            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandle);
> +            cells[cpu * 4 - 1] = cpu_to_be32(IRQ_M_EXT);
> +            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> +            cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
> +        }
>          g_free(nodename);
>      }
>      nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
> @@ -175,7 +186,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
>      qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
>      qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
> -        cells, s->soc.cpus.num_harts * sizeof(uint32_t) * 4);
> +        cells, (s->soc.cpus.num_harts * 4 - 2) * sizeof(uint32_t));
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[SIFIVE_U_PLIC].base,
>          0x0, memmap[SIFIVE_U_PLIC].size);
> @@ -315,10 +326,16 @@ static void riscv_sifive_u_soc_init(Object *obj)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>      SiFiveUSoCState *s = RISCV_U_SOC(obj);
> +    char cpu_type[64];
> +
> +    /* create cpu type representing SiFive FU540 SoC */
> +    pstrcpy(cpu_type, sizeof(cpu_type), SIFIVE_E_CPU);
> +    pstrcat(cpu_type, sizeof(cpu_type), ",");
> +    pstrcat(cpu_type, sizeof(cpu_type), SIFIVE_U_CPU);
>
>      object_initialize_child(obj, "cpus", &s->cpus, sizeof(s->cpus),
>                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->cpus), SIFIVE_U_CPU, "cpu-type",
> +    object_property_set_str(OBJECT(&s->cpus), cpu_type, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
>                              &error_abort);
> @@ -407,10 +424,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>  {
>      mc->desc = "RISC-V Board compatible with SiFive U SDK";
>      mc->init = riscv_sifive_u_init;
> -    /* The real hardware has 5 CPUs, but one of them is a small embedded power
> -     * management CPU.
> -     */
> -    mc->max_cpus = 4;
> +    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
>  }
>
>  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 4abc621..650bc4c 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -68,6 +68,9 @@ enum {
>      SIFIVE_U_GEM_CLOCK_FREQ = 125000000
>  };
>
> +#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
> +#define SIFIVE_U_COMPUTE_CPU_COUNT      4
> +
>  #define SIFIVE_U_PLIC_HART_CONFIG "MS"
>  #define SIFIVE_U_PLIC_NUM_SOURCES 54
>  #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
> --
> 2.7.4
>
>

