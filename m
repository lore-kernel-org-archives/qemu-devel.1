Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15A2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 01:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DB720888
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 01:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="KOpTixXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DB720888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je7bl-0006Gx-D8
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 21:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1je7aG-0005ps-Rc
 for qemu-devel@nongnu.org; Wed, 27 May 2020 21:43:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1je7aE-0002wv-KC
 for qemu-devel@nongnu.org; Wed, 27 May 2020 21:43:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id x13so11579239wrv.4
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 18:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TPsungpF5Fzlj863c7Z893l6VKlieLOxMj6eVAQEEk4=;
 b=KOpTixXznPXljjZYt1Zj9zZfdEiO/EAfWSfLD3j6qDEbbV168dc2YGLaPDuTKbUfGX
 7gpvx/vhanhWHknlymhuuWSwGXEsHvi7emMG1A6UWc87LnWC9892/QcMM5hSQ6DuVP0K
 XQ5wQG51esgap0G3PpOZ7LyXpImy5BVkOqGd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TPsungpF5Fzlj863c7Z893l6VKlieLOxMj6eVAQEEk4=;
 b=VJniQUEpOePvH9WtXYOJbr70cp+8yDejBKFGjQ//4PnSmi2eVZs93Fei+e5928aOq0
 8486Zr47aXUbenVcq7jBvQgjypCDzT9FetfQLDIsgWaivsiuIm6tJZ/GR4Sy0MgXIiv6
 NBhRBK0KxMThnjcLWL3CUmGxrBUWGLaaPSACvsUMnVn3AoApXt6/H+S0ryPkRqFcAAkB
 +RqD6aD2sJDiyWwbWRmqf9roMe45sC2hY9hBWgnzsI7Qp7VnBvZEoDo2Io1FH6rAw5ZZ
 nSGXQN4x2Ib4szKsBreGrDPACTQugeSOlfBBx5JTn5+A5pPxiU2FVtKWqIdMWMZU3H1K
 vMuw==
X-Gm-Message-State: AOAM533Uy7LcAIuM5wrBpkmNycL4Agz1bx2X1/sK7Q2cCZtX1ans4dNM
 9lCWxq7rN9xRmIPCmw2vdX5Ay0I1CB7SBz5jW/Bb
X-Google-Smtp-Source: ABdhPJxJkySPDIs2+oBaAyYLO21wNwI1pcFjtJVJ8uqSm0McZiy2VdPXdaTBJdtOIdhi3Ve5qEiU3a2XwyyQQu+SW+s=
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr998856wrq.162.1590630223832; 
 Wed, 27 May 2020 18:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200527121131.251007-1-anup.patel@wdc.com>
 <20200527121131.251007-5-anup.patel@wdc.com>
In-Reply-To: <20200527121131.251007-5-anup.patel@wdc.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Wed, 27 May 2020 18:43:32 -0700
Message-ID: <CAOnJCUJ2Bg2++nUoM+TzgxfwxBA8u=G6-teBZ2BR5Fugp25KrA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] hw/riscv: virt: Allow creating multiple sockets
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=atishp@atishpatra.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

On Wed, May 27, 2020 at 5:14 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> We extend RISC-V virt machine to allow creating a multi-socket machine.
> Each RISC-V virt machine socket is a set of HARTs, a CLINT instance,
> and a PLIC instance. Other peripherals are shared between all RISC-V
> virt machine sockets. We also update RISC-V virt machine device tree
> to treat each socket as a NUMA node.
>

But this patch doesn't enable numa options and doesn't allow configuring the
virt machine as a numa machine (with different memory nodes). IIRC, OpenSBI
or the plic patches doesn't require the "numa-node-id" as well.
I think it is better to add the "numa-node-id" along with numa support
for virt machine.

> By default, multi-socket support is disabled for RISC-V virt machine.
> To enable multi-socket support, users can pass "multi-socket=on" option
> in machine name.
>
> The number of sockets in RISC-V virt machine can be specified using
> the "sockets=" sub-option of QEMU "-smp" command-line option.
>
> Currently, we only allow creating upto maximum 4 sockets but this
> limit can be changed in future.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  hw/riscv/virt.c         | 523 +++++++++++++++++++++++-----------------
>  include/hw/riscv/virt.h |  11 +-
>  2 files changed, 311 insertions(+), 223 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 421815081d..40a6185b1c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -60,7 +60,7 @@ static const struct MemmapEntry {
>      [VIRT_TEST] =        {   0x100000,        0x1000 },
>      [VIRT_RTC] =         {   0x101000,        0x1000 },
>      [VIRT_CLINT] =       {  0x2000000,       0x10000 },
> -    [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
> +    [VIRT_PLIC] =        {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
>      [VIRT_UART0] =       { 0x10000000,         0x100 },
>      [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
>      [VIRT_FLASH] =       { 0x20000000,     0x4000000 },
> @@ -182,10 +182,15 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> -    int cpu, i;
> -    uint32_t *cells;
> -    char *nodename;
> -    uint32_t plic_phandle, test_phandle, phandle = 1;
> +    int i, cpu, socket;
> +    uint32_t *clint_cells, *plic_cells;
> +    unsigned long clint_addr, plic_addr;
> +    uint32_t plic_phandle[VIRT_SOCKETS_MAX];
> +    uint32_t cpu_phandle, intc_phandle, test_phandle;
> +    uint32_t phandle = 1, plic_mmio_phandle = 1;
> +    uint32_t plic_pcie_phandle = 1, plic_virtio_phandle = 1;
> +    char *name, *cpu_name, *core_name, *intc_name;
> +    char *clint_name, *plic_name, *clust_name;
>      hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
>
> @@ -206,231 +211,235 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>
> -    nodename = g_strdup_printf("/memory@%lx",
> +    name = g_strdup_printf("/memory@%lx",
>          (long)memmap[VIRT_DRAM].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_cells(fdt, name, "reg",
>          memmap[VIRT_DRAM].base >> 32, memmap[VIRT_DRAM].base,
>          mem_size >> 32, mem_size);
> -    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> -    g_free(nodename);
> +    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
> +    g_free(name);
>

As all other

>      qemu_fdt_add_subnode(fdt, "/cpus");
>      qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
>                            SIFIVE_CLINT_TIMEBASE_FREQ);
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
> +    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
> +
> +    for (socket = (s->num_socs - 1); socket >= 0; socket--) {
> +        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
> +        qemu_fdt_add_subnode(fdt, clust_name);
> +
> +        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
> +        clint_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
>
> -    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
> -        int cpu_phandle = phandle++;
> -        int intc_phandle;
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
> -        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
> -        intc_phandle = phandle++;
> -        qemu_fdt_add_subnode(fdt, intc);
> -        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandle);
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
> +            qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket);
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
> +            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> +            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
> +            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
> +            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
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
> -    /* Add cpu-topology node */
> -    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
> -    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map/cluster0");
> -    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
> -        char *core_nodename = g_strdup_printf("/cpus/cpu-map/cluster0/core%d",
> -                                              cpu);
> -        char *cpu_nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> -        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, cpu_nodename);
> -        qemu_fdt_add_subnode(fdt, core_nodename);
> -        qemu_fdt_setprop_cell(fdt, core_nodename, "cpu", intc_phandle);
> -        g_free(core_nodename);
> -        g_free(cpu_nodename);
> +        clint_addr = memmap[VIRT_CLINT].base +
> +            (memmap[VIRT_CLINT].size * socket);
> +        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
> +        qemu_fdt_add_subnode(fdt, clint_name);
> +        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
> +        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
> +            0x0, clint_addr, 0x0, memmap[VIRT_CLINT].size);
> +        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
> +            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
> +        qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket);
> +        g_free(clint_name);
> +
> +        plic_phandle[socket] = phandle++;
> +        plic_addr = memmap[VIRT_PLIC].base + (memmap[VIRT_PLIC].size * socket);
> +        plic_name = g_strdup_printf("/soc/plic@%lx", plic_addr);
> +        qemu_fdt_add_subnode(fdt, plic_name);
> +        qemu_fdt_setprop_cell(fdt, plic_name,
> +            "#address-cells", FDT_PLIC_ADDR_CELLS);
> +        qemu_fdt_setprop_cell(fdt, plic_name,
> +            "#interrupt-cells", FDT_PLIC_INT_CELLS);
> +        qemu_fdt_setprop_string(fdt, plic_name, "compatible", "riscv,plic0");
> +        qemu_fdt_setprop(fdt, plic_name, "interrupt-controller", NULL, 0);
> +        qemu_fdt_setprop(fdt, plic_name, "interrupts-extended",
> +            plic_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
> +        qemu_fdt_setprop_cells(fdt, plic_name, "reg",
> +            0x0, plic_addr, 0x0, memmap[VIRT_PLIC].size);
> +        qemu_fdt_setprop_cell(fdt, plic_name, "riscv,ndev", VIRTIO_NDEV);
> +        qemu_fdt_setprop_cell(fdt, plic_name, "numa-node-id", socket);
> +        qemu_fdt_setprop_cell(fdt, plic_name, "phandle", plic_phandle[socket]);
> +        g_free(plic_name);
> +
> +        g_free(clint_cells);
> +        g_free(plic_cells);
> +        g_free(clust_name);
>      }
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
> -    }
> -    nodename = g_strdup_printf("/soc/clint@%lx",
> -        (long)memmap[VIRT_CLINT].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[VIRT_CLINT].base,
> -        0x0, memmap[VIRT_CLINT].size);
> -    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
> -        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
> -    g_free(cells);
> -    g_free(nodename);
> -
> -    plic_phandle = phandle++;
> -    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
> -    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
> -        nodename =
> -            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> -        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
> -        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> -        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
> -        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
> -        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
> -        g_free(nodename);
> +    for (socket = 0; socket < s->num_socs; socket++) {
> +        if (socket == 0) {
> +            plic_mmio_phandle = plic_phandle[socket];
> +            plic_virtio_phandle = plic_phandle[socket];
> +            plic_pcie_phandle = plic_phandle[socket];
> +        }
> +        if (socket == 1) {
> +            plic_virtio_phandle = plic_phandle[socket];
> +            plic_pcie_phandle = plic_phandle[socket];
> +        }
> +        if (socket == 2) {
> +            plic_pcie_phandle = plic_phandle[socket];
> +        }
>      }
> -    nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
> -        (long)memmap[VIRT_PLIC].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
> -                          FDT_PLIC_ADDR_CELLS);
> -    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
> -                          FDT_PLIC_INT_CELLS);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
> -    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
> -    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
> -        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[VIRT_PLIC].base,
> -        0x0, memmap[VIRT_PLIC].size);
> -    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
> -    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
> -    plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
> -    g_free(cells);
> -    g_free(nodename);
>
>      for (i = 0; i < VIRTIO_COUNT; i++) {
> -        nodename = g_strdup_printf("/virtio_mmio@%lx",
> +        name = g_strdup_printf("/soc/virtio_mmio@%lx",
>              (long)(memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size));
> -        qemu_fdt_add_subnode(fdt, nodename);
> -        qemu_fdt_setprop_string(fdt, nodename, "compatible", "virtio,mmio");
> -        qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +        qemu_fdt_add_subnode(fdt, name);
> +        qemu_fdt_setprop_string(fdt, name, "compatible", "virtio,mmio");
> +        qemu_fdt_setprop_cells(fdt, name, "reg",
>              0x0, memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
>              0x0, memmap[VIRT_VIRTIO].size);
> -        qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
> -        qemu_fdt_setprop_cell(fdt, nodename, "interrupts", VIRTIO_IRQ + i);
> -        g_free(nodename);
> +        qemu_fdt_setprop_cell(fdt, name, "interrupt-parent",
> +            plic_virtio_phandle);
> +        qemu_fdt_setprop_cell(fdt, name, "interrupts", VIRTIO_IRQ + i);
> +        g_free(name);
>      }
>
> -    nodename = g_strdup_printf("/soc/pci@%lx",
> +    name = g_strdup_printf("/soc/pci@%lx",
>          (long) memmap[VIRT_PCIE_ECAM].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
> -                          FDT_PCI_ADDR_CELLS);
> -    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
> -                          FDT_PCI_INT_CELLS);
> -    qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0x2);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> -                            "pci-host-ecam-generic");
> -    qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
> -    qemu_fdt_setprop_cell(fdt, nodename, "linux,pci-domain", 0);
> -    qemu_fdt_setprop_cells(fdt, nodename, "bus-range", 0,
> -                           memmap[VIRT_PCIE_ECAM].size /
> -                               PCIE_MMCFG_SIZE_MIN - 1);
> -    qemu_fdt_setprop(fdt, nodename, "dma-coherent", NULL, 0);
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg", 0, memmap[VIRT_PCIE_ECAM].base,
> -                           0, memmap[VIRT_PCIE_ECAM].size);
> -    qemu_fdt_setprop_sized_cells(fdt, nodename, "ranges",
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
> +    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
> +    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
> +    qemu_fdt_setprop_cell(fdt, name, "linux,pci-domain", 0);
> +    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
> +        memmap[VIRT_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
> +    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
> +    qemu_fdt_setprop_cells(fdt, name, "reg", 0,
> +        memmap[VIRT_PCIE_ECAM].base, 0, memmap[VIRT_PCIE_ECAM].size);
> +    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
>          1, FDT_PCI_RANGE_IOPORT, 2, 0,
>          2, memmap[VIRT_PCIE_PIO].base, 2, memmap[VIRT_PCIE_PIO].size,
>          1, FDT_PCI_RANGE_MMIO,
>          2, memmap[VIRT_PCIE_MMIO].base,
>          2, memmap[VIRT_PCIE_MMIO].base, 2, memmap[VIRT_PCIE_MMIO].size);
> -    create_pcie_irq_map(fdt, nodename, plic_phandle);
> -    g_free(nodename);
> +    create_pcie_irq_map(fdt, name, plic_pcie_phandle);
> +    g_free(name);
>
>      test_phandle = phandle++;
> -    nodename = g_strdup_printf("/test@%lx",
> +    name = g_strdup_printf("/soc/test@%lx",
>          (long)memmap[VIRT_TEST].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_add_subnode(fdt, name);
>      {
>          const char compat[] = "sifive,test1\0sifive,test0\0syscon";
> -        qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compat));
> +        qemu_fdt_setprop(fdt, name, "compatible", compat, sizeof(compat));
>      }
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +    qemu_fdt_setprop_cells(fdt, name, "reg",
>          0x0, memmap[VIRT_TEST].base,
>          0x0, memmap[VIRT_TEST].size);
> -    qemu_fdt_setprop_cell(fdt, nodename, "phandle", test_phandle);
> -    test_phandle = qemu_fdt_get_phandle(fdt, nodename);
> -    g_free(nodename);
> -
> -    nodename = g_strdup_printf("/reboot");
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-reboot");
> -    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> -    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> -    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_RESET);
> -    g_free(nodename);
> -
> -    nodename = g_strdup_printf("/poweroff");
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-poweroff");
> -    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> -    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> -    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_PASS);
> -    g_free(nodename);
> -
> -    nodename = g_strdup_printf("/uart@%lx",
> -        (long)memmap[VIRT_UART0].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "ns16550a");
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +    qemu_fdt_setprop_cell(fdt, name, "phandle", test_phandle);
> +    test_phandle = qemu_fdt_get_phandle(fdt, name);
> +    g_free(name);
> +
> +    name = g_strdup_printf("/soc/reboot");
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-reboot");
> +    qemu_fdt_setprop_cell(fdt, name, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, name, "value", FINISHER_RESET);
> +    g_free(name);
> +
> +    name = g_strdup_printf("/soc/poweroff");
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-poweroff");
> +    qemu_fdt_setprop_cell(fdt, name, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, name, "value", FINISHER_PASS);
> +    g_free(name);
> +
> +    name = g_strdup_printf("/soc/uart@%lx", (long)memmap[VIRT_UART0].base);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
> +    qemu_fdt_setprop_cells(fdt, name, "reg",
>          0x0, memmap[VIRT_UART0].base,
>          0x0, memmap[VIRT_UART0].size);
> -    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
> -    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
> -    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", UART0_IRQ);
> +    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
> +    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", plic_mmio_phandle);
> +    qemu_fdt_setprop_cell(fdt, name, "interrupts", UART0_IRQ);
>
>      qemu_fdt_add_subnode(fdt, "/chosen");
> -    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> +    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
>      if (cmdline) {
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
> -    g_free(nodename);
> -
> -    nodename = g_strdup_printf("/rtc@%lx",
> -        (long)memmap[VIRT_RTC].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> -        "google,goldfish-rtc");
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +    g_free(name);
> +
> +    name = g_strdup_printf("/soc/rtc@%lx", (long)memmap[VIRT_RTC].base);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "google,goldfish-rtc");
> +    qemu_fdt_setprop_cells(fdt, name, "reg",
>          0x0, memmap[VIRT_RTC].base,
>          0x0, memmap[VIRT_RTC].size);
> -    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
> -    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", RTC_IRQ);
> -    g_free(nodename);
> -
> -    nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
> -    qemu_fdt_add_subnode(s->fdt, nodename);
> -    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "cfi-flash");
> -    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
> +    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", plic_mmio_phandle);
> +    qemu_fdt_setprop_cell(fdt, name, "interrupts", RTC_IRQ);
> +    g_free(name);
> +
> +    name = g_strdup_printf("/soc/flash@%" PRIx64, flashbase);
> +    qemu_fdt_add_subnode(s->fdt, name);
> +    qemu_fdt_setprop_string(s->fdt, name, "compatible", "cfi-flash");
> +    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
>                                   2, flashbase, 2, flashsize,
>                                   2, flashbase + flashsize, 2, flashsize);
> -    qemu_fdt_setprop_cell(s->fdt, nodename, "bank-width", 4);
> -    g_free(nodename);
> +    qemu_fdt_setprop_cell(s->fdt, name, "bank-width", 4);
> +    g_free(name);
>  }
>
> -
>  static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>                                            hwaddr ecam_base, hwaddr ecam_size,
>                                            hwaddr mmio_base, hwaddr mmio_size,
> @@ -478,21 +487,92 @@ static void riscv_virt_board_init(MachineState *machine)
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> -    char *plic_hart_config;
> +    char *plic_hart_config, *soc_name;
>      size_t plic_hart_config_len;
>      target_ulong start_addr = memmap[VIRT_DRAM].base;
> -    int i;
> +    int i, j;
>      unsigned int smp_cpus = machine->smp.cpus;
> +    unsigned int base_hartid, cpus_per_socket;
> +    DeviceState *mmio_plic, *virtio_plic, *pcie_plic;
> +
> +    /* Figure-out number of sockets */
> +    s->num_socs = (s->multi_socket) ? machine->smp.sockets : 1;
> +
> +    /* Limit the number of sockets */
> +    if (VIRT_SOCKETS_MAX < s->num_socs) {
> +        s->num_socs = VIRT_SOCKETS_MAX;
> +    }
>
>      /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> -                            &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> -                            &error_abort);
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> -                            &error_abort);
> +    mmio_plic = virtio_plic = pcie_plic = NULL;
> +    for (i = 0; i < s->num_socs; i++) {
> +        base_hartid = i * (smp_cpus / s->num_socs);
> +        if (i == (s->num_socs - 1)) {
> +            cpus_per_socket = smp_cpus - base_hartid;
> +        } else {
> +            cpus_per_socket = smp_cpus / s->num_socs;
> +        }
> +        soc_name = g_strdup_printf("soc%d", i);
> +        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
> +            sizeof(s->soc[i]), TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> +        g_free(soc_name);
> +        object_property_set_str(OBJECT(&s->soc[i]),
> +            machine->cpu_type, "cpu-type", &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]),
> +            base_hartid, "hartid-base", &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]),
> +            cpus_per_socket, "num-harts", &error_abort);
> +        object_property_set_bool(OBJECT(&s->soc[i]),
> +            true, "realized", &error_abort);
> +
> +        /* Per-socket CLINT */
> +        sifive_clint_create(
> +            memmap[VIRT_CLINT].base + i * memmap[VIRT_CLINT].size,
> +            memmap[VIRT_CLINT].size, base_hartid, cpus_per_socket,
> +            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
> +
> +        /* Per-socket PLIC hart topology configuration string */
> +        plic_hart_config_len =
> +            (strlen(VIRT_PLIC_HART_CONFIG) + 1) * cpus_per_socket;
> +        plic_hart_config = g_malloc0(plic_hart_config_len);
> +        for (j = 0; j < cpus_per_socket; j++) {
> +            if (j != 0) {
> +                strncat(plic_hart_config, ",", plic_hart_config_len);
> +            }
> +            strncat(plic_hart_config, VIRT_PLIC_HART_CONFIG,
> +                plic_hart_config_len);
> +            plic_hart_config_len -= (strlen(VIRT_PLIC_HART_CONFIG) + 1);
> +        }
> +
> +        /* Per-socket PLIC */
> +        s->plic[i] = sifive_plic_create(
> +            memmap[VIRT_PLIC].base + i * memmap[VIRT_PLIC].size,
> +            plic_hart_config, base_hartid,
> +            VIRT_PLIC_NUM_SOURCES,
> +            VIRT_PLIC_NUM_PRIORITIES,
> +            VIRT_PLIC_PRIORITY_BASE,
> +            VIRT_PLIC_PENDING_BASE,
> +            VIRT_PLIC_ENABLE_BASE,
> +            VIRT_PLIC_ENABLE_STRIDE,
> +            VIRT_PLIC_CONTEXT_BASE,
> +            VIRT_PLIC_CONTEXT_STRIDE,
> +            memmap[VIRT_PLIC].size);
> +        g_free(plic_hart_config);
> +
> +        /* Try to use different PLIC instance based device type */
> +        if (i == 0) {
> +            mmio_plic = s->plic[i];
> +            virtio_plic = s->plic[i];
> +            pcie_plic = s->plic[i];
> +        }
> +        if (i == 1) {
> +            virtio_plic = s->plic[i];
> +            pcie_plic = s->plic[i];
> +        }
> +        if (i == 2) {
> +            pcie_plic = s->plic[i];
> +        }
> +    }
>
>      /* register system main memory (actual RAM) */
>      memory_region_init_ram(main_mem, NULL, "riscv_virt_board.ram",
> @@ -571,38 +651,14 @@ static void riscv_virt_board_init(MachineState *machine)
>                            memmap[VIRT_MROM].base + sizeof(reset_vec),
>                            &address_space_memory);
>
> -    /* create PLIC hart topology configuration string */
> -    plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
> -    plic_hart_config = g_malloc0(plic_hart_config_len);
> -    for (i = 0; i < smp_cpus; i++) {
> -        if (i != 0) {
> -            strncat(plic_hart_config, ",", plic_hart_config_len);
> -        }
> -        strncat(plic_hart_config, VIRT_PLIC_HART_CONFIG, plic_hart_config_len);
> -        plic_hart_config_len -= (strlen(VIRT_PLIC_HART_CONFIG) + 1);
> -    }
> -
> -    /* MMIO */
> -    s->plic = sifive_plic_create(memmap[VIRT_PLIC].base,
> -        plic_hart_config, 0,
> -        VIRT_PLIC_NUM_SOURCES,
> -        VIRT_PLIC_NUM_PRIORITIES,
> -        VIRT_PLIC_PRIORITY_BASE,
> -        VIRT_PLIC_PENDING_BASE,
> -        VIRT_PLIC_ENABLE_BASE,
> -        VIRT_PLIC_ENABLE_STRIDE,
> -        VIRT_PLIC_CONTEXT_BASE,
> -        VIRT_PLIC_CONTEXT_STRIDE,
> -        memmap[VIRT_PLIC].size);
> -    sifive_clint_create(memmap[VIRT_CLINT].base,
> -        memmap[VIRT_CLINT].size, 0, smp_cpus,
> -        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
> +    /* SiFive Test MMIO device */
>      sifive_test_create(memmap[VIRT_TEST].base);
>
> +    /* VirtIO MMIO devices */
>      for (i = 0; i < VIRTIO_COUNT; i++) {
>          sysbus_create_simple("virtio-mmio",
>              memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
> -            qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
> +            qdev_get_gpio_in(DEVICE(virtio_plic), VIRTIO_IRQ + i));
>      }
>
>      gpex_pcie_init(system_memory,
> @@ -611,14 +667,14 @@ static void riscv_virt_board_init(MachineState *machine)
>                           memmap[VIRT_PCIE_MMIO].base,
>                           memmap[VIRT_PCIE_MMIO].size,
>                           memmap[VIRT_PCIE_PIO].base,
> -                         DEVICE(s->plic), true);
> +                         DEVICE(pcie_plic), true);
>
>      serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> -        0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
> +        0, qdev_get_gpio_in(DEVICE(mmio_plic), UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
>
>      sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
> -        qdev_get_gpio_in(DEVICE(s->plic), RTC_IRQ));
> +        qdev_get_gpio_in(DEVICE(mmio_plic), RTC_IRQ));
>
>      virt_flash_create(s);
>
> @@ -628,12 +684,37 @@ static void riscv_virt_board_init(MachineState *machine)
>                                    drive_get(IF_PFLASH, 0, i));
>      }
>      virt_flash_map(s, system_memory);
> +}
>
> -    g_free(plic_hart_config);
> +static bool riscv_virt_get_multi_socket(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    return s->multi_socket;
> +}
> +
> +static void riscv_virt_set_multi_socket(Object *obj, bool value, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    s->multi_socket = value;
>  }
>
>  static void riscv_virt_machine_instance_init(Object *obj)
>  {
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    /*
> +     * Multi-socket is disabled by default so users have to
> +     * explicitly enable it from command-line.
> +     */
> +    s->multi_socket = false;
> +    object_property_add_bool(obj, "multi-socket",
> +                             riscv_virt_get_multi_socket,
> +                             riscv_virt_set_multi_socket);
> +    object_property_set_description(obj, "multi-socket",
> +                                    "Set on/off to enable/disable the "
> +                                    "multi-socket support");
>  }
>
>  static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
> @@ -642,7 +723,7 @@ static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
>
>      mc->desc = "RISC-V VirtIO board";
>      mc->init = riscv_virt_board_init;
> -    mc->max_cpus = 8;
> +    mc->max_cpus = VIRT_CPUS_MAX;
>      mc->default_cpu_type = VIRT_CPU;
>      mc->pci_allow_0_address = true;
>  }
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e69355efaf..e5fe10ad48 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -23,6 +23,9 @@
>  #include "hw/sysbus.h"
>  #include "hw/block/flash.h"
>
> +#define VIRT_CPUS_MAX 8
> +#define VIRT_SOCKETS_MAX 4
> +
>  #define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
>  #define RISCV_VIRT_MACHINE(obj) \
>      OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_MACHINE)
> @@ -32,8 +35,10 @@ typedef struct {
>      MachineState parent;
>
>      /*< public >*/
> -    RISCVHartArrayState soc;
> -    DeviceState *plic;
> +    bool multi_socket;
> +    unsigned int num_socs;
> +    RISCVHartArrayState soc[VIRT_SOCKETS_MAX];
> +    DeviceState *plic[VIRT_SOCKETS_MAX];
>      PFlashCFI01 *flash[2];
>
>      void *fdt;
> @@ -74,6 +79,8 @@ enum {
>  #define VIRT_PLIC_ENABLE_STRIDE 0x80
>  #define VIRT_PLIC_CONTEXT_BASE 0x200000
>  #define VIRT_PLIC_CONTEXT_STRIDE 0x1000
> +#define VIRT_PLIC_SIZE(__num_context) \
> +    (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
>
>  #define FDT_PCI_ADDR_CELLS    3
>  #define FDT_PCI_INT_CELLS     1
> --
> 2.25.1
>
>

Otherwise, looks good to me.

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish

