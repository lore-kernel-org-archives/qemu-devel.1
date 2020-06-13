Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C60CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 05:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3564920739
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 05:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="MCVy7lbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3564920739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjypc-0004Y3-Bx
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 01:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1jjyoI-0003zE-Pj
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 01:34:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35246)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1jjyoF-0001wD-4u
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 01:34:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id q25so9847071wmj.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 22:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b3AXB7sCbGg9vYgho8NB2sieiuujcN444AJftPz4Je0=;
 b=MCVy7lbJsEg/gFNUVwDDcKEA+zOkFqRnJLwasqyhWOR53zd5Kgl0W8AB0ZOf7Bpfem
 RU3pDYZzHlKT73MlUIkLgIdrCoTPl+HBEPz3m3PuO1WBsgCMbHMdC8wzWCKjGDIVkq/z
 DtqSJlM3Pn2ea5rx0EnSwTIV5/baQscD9MUSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b3AXB7sCbGg9vYgho8NB2sieiuujcN444AJftPz4Je0=;
 b=C5oYR0oRhjY8fzCk4VuVc8cUk9WuBJ4JJShcjNeyfPVHE1RBE+cI4l3FlDaSvdek3R
 q+T4OzA/X4qBMgbwrsUzYRadRCVNtcTHK3Eg0MG7SMyUMoLsw2iKIontv2X8pRocKW8G
 UR28JfSH3eDq5VFqzLhjubjK/5b5xM0LPDDiRUIXIJQa2/9UDtNjXnvn67JPxFQPjFvR
 i4aG8yLwpj2gsCxYBo24WIHeX9dr4D2K/24y4dUN9v1kfLWI7ByEdrbeZ/T5WytBuk+/
 hERGwU3eoEu9r7Q+jG79lPMGa9fAzPNNOcR/xFmkkmfPQHsCO/P5/Tv3JQbkAEE1RkRD
 nF6Q==
X-Gm-Message-State: AOAM531yqIhnSwxqWCSbdyVPA3k93K9NrOUQBZRtkxoqC7QqbClK3CO5
 vxj4RVPPBJ8HoZqZ0s2uLjozH2MtsPlXIfMpJLOM
X-Google-Smtp-Source: ABdhPJwHO03HCGV6nonrzZcJBFA1jiXGSr3mP7qTaBi3bCtLV59bnKNgcW3kKWnzsNCIvg0/QLzd/vjF+ZWiTPrMmuM=
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr2286455wmc.176.1592026460502; 
 Fri, 12 Jun 2020 22:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200529114641.121332-1-anup.patel@wdc.com>
 <20200529114641.121332-5-anup.patel@wdc.com>
In-Reply-To: <20200529114641.121332-5-anup.patel@wdc.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 12 Jun 2020 22:34:09 -0700
Message-ID: <CAOnJCUKtcF_sF3MB2XNnyS11+WG_cwykCKA=-5NTWk44Z8Se3g@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] hw/riscv: spike: Allow creating multiple NUMA
 sockets
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=atishp@atishpatra.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 qemu-devel@nongnu.org, Atish Patra <atish.patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 4:48 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> We extend RISC-V spike machine to allow creating a multi-socket
> machine. Each RISC-V spike machine socket is a NUMA node having
> a set of HARTs, a memory instance, and a CLINT instance. Other
> devices are shared between all sockets. We also update the
> generated device tree accordingly.
>
> By default, NUMA multi-socket support is disabled for RISC-V spike
> machine. To enable it, users can use "-numa" command-line options
> of QEMU.
>
> Example1: For two NUMA nodes with 2 CPUs each, append following
> to command-line options: "-smp 4 -numa node -numa node"
>
> Example2: For two NUMA nodes with 1 and 3 CPUs, append following
> to command-line options:
> "-smp 4 -numa node -numa node -numa cpu,node-id=0,core-id=0 \
> -numa cpu,node-id=1,core-id=1 -numa cpu,node-id=1,core-id=2 \
> -numa cpu,node-id=1,core-id=3"
>
> The maximum number of sockets in a RISC-V spike machine is 8
> but this limit can be changed in future.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  hw/riscv/spike.c         | 268 ++++++++++++++++++++++++++-------------
>  include/hw/riscv/spike.h |  11 +-
>  2 files changed, 187 insertions(+), 92 deletions(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index d5e0103d89..b8373eb1eb 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -36,6 +36,7 @@
>  #include "hw/riscv/sifive_clint.h"
>  #include "hw/riscv/spike.h"
>  #include "hw/riscv/boot.h"
> +#include "hw/riscv/numa.h"
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
> @@ -64,9 +65,14 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> -    int cpu;
> -    uint32_t *cells;
> -    char *nodename;
> +    uint64_t addr, size;
> +    unsigned long clint_addr;
> +    int cpu, socket;
> +    MachineState *mc = MACHINE(s);
> +    uint32_t *clint_cells;
> +    uint32_t cpu_phandle, intc_phandle, phandle = 1;
> +    char *name, *mem_name, *clint_name, *clust_name;
> +    char *core_name, *cpu_name, *intc_name;
>
>      fdt = s->fdt = create_device_tree(&s->fdt_size);
>      if (!fdt) {
> @@ -88,68 +94,91 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>
> -    nodename = g_strdup_printf("/memory@%lx",
> -        (long)memmap[SPIKE_DRAM].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        memmap[SPIKE_DRAM].base >> 32, memmap[SPIKE_DRAM].base,
> -        mem_size >> 32, mem_size);
> -    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> -    g_free(nodename);
> -
>      qemu_fdt_add_subnode(fdt, "/cpus");
>      qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
>          SIFIVE_CLINT_TIMEBASE_FREQ);
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
> +    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
> +
> +    for (socket = (riscv_socket_count(mc) - 1); socket >= 0; socket--) {
> +        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
> +        qemu_fdt_add_subnode(fdt, clust_name);
> +
> +        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
>
> -    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
> -        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> -        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> -        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
> -        qemu_fdt_add_subnode(fdt, nodename);
> +        for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
> +            cpu_phandle = phandle++;
> +
> +            cpu_name = g_strdup_printf("/cpus/cpu@%d",
> +                s->soc[socket].hartid_base + cpu);
> +            qemu_fdt_add_subnode(fdt, cpu_name);
>  #if defined(TARGET_RISCV32)
> -        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
> +            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
>  #else
> -        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
> +            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
>  #endif
> -        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
> -        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
> -        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
> -        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
> -        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
> -        qemu_fdt_add_subnode(fdt, intc);
> -        qemu_fdt_setprop_cell(fdt, intc, "phandle", 1);
> -        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
> -        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
> -        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
> -        g_free(isa);
> -        g_free(intc);
> -        g_free(nodename);
> -    }
> +            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
> +            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
> +            g_free(name);
> +            qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
> +            qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
> +            qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> +                s->soc[socket].hartid_base + cpu);
> +            qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
> +            riscv_socket_fdt_write_id(mc, fdt, cpu_name, socket);
> +            qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
> +
> +            intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
> +            qemu_fdt_add_subnode(fdt, intc_name);
> +            intc_phandle = phandle++;
> +            qemu_fdt_setprop_cell(fdt, intc_name, "phandle", intc_phandle);
> +            qemu_fdt_setprop_string(fdt, intc_name, "compatible",
> +                "riscv,cpu-intc");
> +            qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
> +            qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
> +
> +            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> +            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
> +            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
> +            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
> +
> +            core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
> +            qemu_fdt_add_subnode(fdt, core_name);
> +            qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
> +
> +            g_free(core_name);
> +            g_free(intc_name);
> +            g_free(cpu_name);
> +        }
>
> -    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
> -    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
> -        nodename =
> -            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> -        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
> -        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> -        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
> -        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
> -        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
> -        g_free(nodename);
> +        addr = memmap[SPIKE_DRAM].base + riscv_socket_mem_offset(mc, socket);
> +        size = riscv_socket_mem_size(mc, socket);
> +        mem_name = g_strdup_printf("/memory@%lx", (long)addr);
> +        qemu_fdt_add_subnode(fdt, mem_name);
> +        qemu_fdt_setprop_cells(fdt, mem_name, "reg",
> +            addr >> 32, addr, size >> 32, size);
> +        qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
> +        riscv_socket_fdt_write_id(mc, fdt, mem_name, socket);
> +        g_free(mem_name);
> +
> +        clint_addr = memmap[SPIKE_CLINT].base +
> +            (memmap[SPIKE_CLINT].size * socket);
> +        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
> +        qemu_fdt_add_subnode(fdt, clint_name);
> +        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
> +        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
> +            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
> +        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
> +            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
> +        riscv_socket_fdt_write_id(mc, fdt, clint_name, socket);
> +
> +        g_free(clint_name);
> +        g_free(clint_cells);
> +        g_free(clust_name);
>      }
> -    nodename = g_strdup_printf("/soc/clint@%lx",
> -        (long)memmap[SPIKE_CLINT].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SPIKE_CLINT].base,
> -        0x0, memmap[SPIKE_CLINT].size);
> -    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
> -        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
> -    g_free(cells);
> -    g_free(nodename);
> +
> +    riscv_socket_fdt_write_distance_matrix(mc, fdt);
>
>      if (cmdline) {
>          qemu_fdt_add_subnode(fdt, "/chosen");
> @@ -160,23 +189,58 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>  static void spike_board_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = spike_memmap;
> -
> -    SpikeState *s = g_new0(SpikeState, 1);
> +    SpikeState *s = SPIKE_MACHINE(machine);
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> -    int i;
> -    unsigned int smp_cpus = machine->smp.cpus;
> +    char *soc_name;
> +    int i, base_hartid, hart_count;
>
> -    /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> -                            &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> -                            &error_abort);
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> -                            &error_abort);
> +    /* Check socket count limit */
> +    if (SPIKE_SOCKETS_MAX < riscv_socket_count(machine)) {
> +        error_report("number of sockets/nodes should be less than %d",
> +            SPIKE_SOCKETS_MAX);
> +        exit(1);
> +    }
> +
> +    /* Initialize sockets */
> +    for (i = 0; i < riscv_socket_count(machine); i++) {
> +        if (!riscv_socket_check_hartids(machine, i)) {
> +            error_report("discontinuous hartids in socket%d", i);
> +            exit(1);
> +        }
> +
> +        base_hartid = riscv_socket_first_hartid(machine, i);
> +        if (base_hartid < 0) {
> +            error_report("can't find hartid base for socket%d", i);
> +            exit(1);
> +        }
> +
> +        hart_count = riscv_socket_hart_count(machine, i);
> +        if (hart_count < 0) {
> +            error_report("can't find hart count for socket%d", i);
> +            exit(1);
> +        }
> +
> +        soc_name = g_strdup_printf("soc%d", i);
> +        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
> +            sizeof(s->soc[i]), TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> +        g_free(soc_name);
> +        object_property_set_str(OBJECT(&s->soc[i]),
> +            machine->cpu_type, "cpu-type", &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]),
> +            base_hartid, "hartid-base", &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]),
> +            hart_count, "num-harts", &error_abort);
> +        object_property_set_bool(OBJECT(&s->soc[i]),
> +            true, "realized", &error_abort);
> +
> +        /* Core Local Interruptor (timer and IPI) for each socket */
> +        sifive_clint_create(
> +            memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
> +            memmap[SPIKE_CLINT].size, base_hartid, hart_count,
> +            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
> +    }
>
>      /* register system main memory (actual RAM) */
>      memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
> @@ -249,12 +313,8 @@ static void spike_board_init(MachineState *machine)
>                            &address_space_memory);
>
>      /* initialize HTIF using symbols found in load_kernel */
> -    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> -
> -    /* Core Local Interruptor (timer and IPI) */
> -    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> -        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> -        false);
> +    htif_mm_init(system_memory, mask_rom,
> +                 &s->soc[0].harts[0].env, serial_hd(0));
>  }
>
>  static void spike_v1_10_0_board_init(MachineState *machine)
> @@ -275,13 +335,14 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>      }
>
>      /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> +    object_initialize_child(OBJECT(machine), "soc",
> +                            &s->soc[0], sizeof(s->soc[0]),
>                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU, "cpu-type",
> +    object_property_set_str(OBJECT(&s->soc[0]), SPIKE_V1_10_0_CPU, "cpu-type",
>                              &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> +    object_property_set_int(OBJECT(&s->soc[0]), smp_cpus, "num-harts",
>                              &error_abort);
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> +    object_property_set_bool(OBJECT(&s->soc[0]), true, "realized",
>                              &error_abort);
>
>      /* register system main memory (actual RAM) */
> @@ -339,7 +400,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>                            &address_space_memory);
>
>      /* initialize HTIF using symbols found in load_kernel */
> -    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> +    htif_mm_init(system_memory, mask_rom,
> +                 &s->soc[0].harts[0].env, serial_hd(0));
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> @@ -365,13 +427,14 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>      }
>
>      /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> +    object_initialize_child(OBJECT(machine), "soc",
> +                            &s->soc[0], sizeof(s->soc[0]),
>                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU, "cpu-type",
> +    object_property_set_str(OBJECT(&s->soc[0]), SPIKE_V1_09_1_CPU, "cpu-type",
>                              &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> +    object_property_set_int(OBJECT(&s->soc[0]), smp_cpus, "num-harts",
>                              &error_abort);
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> +    object_property_set_bool(OBJECT(&s->soc[0]), true, "realized",
>                              &error_abort);
>
>      /* register system main memory (actual RAM) */
> @@ -425,7 +488,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>          "};\n";
>
>      /* build config string with supplied memory size */
> -    char *isa = riscv_isa_string(&s->soc.harts[0]);
> +    char *isa = riscv_isa_string(&s->soc[0].harts[0]);
>      char *config_string = g_strdup_printf(config_string_tmpl,
>          (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
>          (uint64_t)memmap[SPIKE_DRAM].base,
> @@ -448,7 +511,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>                            &address_space_memory);
>
>      /* initialize HTIF using symbols found in load_kernel */
> -    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> +    htif_mm_init(system_memory, mask_rom,
> +                 &s->soc[0].harts[0].env, serial_hd(0));
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> @@ -472,15 +536,39 @@ static void spike_v1_10_0_machine_init(MachineClass *mc)
>      mc->max_cpus = 1;
>  }
>
> -static void spike_machine_init(MachineClass *mc)
> +DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
> +DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
> +
> +static void spike_machine_instance_init(Object *obj)
> +{
> +}
> +
> +static void spike_machine_class_init(ObjectClass *oc, void *data)
>  {
> -    mc->desc = "RISC-V Spike Board";
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "RISC-V Spike board";
>      mc->init = spike_board_init;
> -    mc->max_cpus = 8;
> +    mc->max_cpus = SPIKE_CPUS_MAX;
>      mc->is_default = true;
>      mc->default_cpu_type = SPIKE_V1_10_0_CPU;
> +    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
> +    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
> +    mc->numa_mem_supported = true;
>  }
>
> -DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
> -DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
> -DEFINE_MACHINE("spike", spike_machine_init)
> +static const TypeInfo spike_machine_typeinfo = {
> +    .name       = MACHINE_TYPE_NAME("spike"),
> +    .parent     = TYPE_MACHINE,
> +    .class_init = spike_machine_class_init,
> +    .instance_init = spike_machine_instance_init,
> +    .instance_size = sizeof(SpikeState),
> +};
> +
> +static void spike_machine_init_register_types(void)
> +{
> +    type_register_static(&spike_machine_typeinfo);
> +}
> +
> +type_init(spike_machine_init_register_types)
> diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
> index dc770421bc..c55fdf4d24 100644
> --- a/include/hw/riscv/spike.h
> +++ b/include/hw/riscv/spike.h
> @@ -22,12 +22,19 @@
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/sysbus.h"
>
> +#define SPIKE_CPUS_MAX 8
> +#define SPIKE_SOCKETS_MAX 8
> +
> +#define TYPE_SPIKE_MACHINE MACHINE_TYPE_NAME("spike")
> +#define SPIKE_MACHINE(obj) \
> +    OBJECT_CHECK(SpikeState, (obj), TYPE_SPIKE_MACHINE)
> +
>  typedef struct {
>      /*< private >*/
> -    SysBusDevice parent_obj;
> +    MachineState parent;
>
>      /*< public >*/
> -    RISCVHartArrayState soc;
> +    RISCVHartArrayState soc[SPIKE_SOCKETS_MAX];
>      void *fdt;
>      int fdt_size;
>  } SpikeState;
> --
> 2.25.1
>
>

As the upstream version of spike removed the deprecated ISA specific
machines, the rebased patch
will be bit different from this version. But I don't think there will
be any change in functionality.

With that assumption:

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish

