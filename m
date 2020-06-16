Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD1C207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu8+PXi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD1C207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFtj-0006Yg-1P
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 14:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlFrr-0005Lv-Ss; Tue, 16 Jun 2020 13:59:27 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:43919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlFrp-0008Ot-LE; Tue, 16 Jun 2020 13:59:27 -0400
Received: by mail-il1-x143.google.com with SMTP id g3so4551020ilq.10;
 Tue, 16 Jun 2020 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VONlzrICbNcGvivN/cPDivhkPJNBiMoJ8pEhmNssn7g=;
 b=Xu8+PXi4JyDC+Ger5TkE/OclARWzr34dFk1r7L7W22lkmaJ3Q1LZ1d4yH34MzMUJZL
 gsyStZZov7KIzh07CDhykzqivY82nJgEBk5MbeoHpgYj5wUjA++V8iH/y9wsTANiiV5A
 9cnJhroIJuAORnlnFV9SwJTUovL5LnmPPgOfZ122PvJpEVRNpmktkivCkaECXGFM79XH
 SFdIfNiRHwuP2XcBqGS+UI0hnYUx9B+JeX+PoRYIrwVo/bTyNDjFdRL9tq3LTyMD0/M2
 fCl9Sx5DVjcaKKkCCc5jyjKKXIWgutTepPEF5xOIWpCeKwb/mB/4QlLde2g9cdLAHD2N
 b2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VONlzrICbNcGvivN/cPDivhkPJNBiMoJ8pEhmNssn7g=;
 b=eWGj19YMrJmJFRTOHSRhp8LtBpW584oFmexJKdNHq5k7lktYuea6DclR7JrGo5sEhU
 IVjfWMqFIuH7hG6+kh3m9vmielfk5JlY88icuHnWLVPBXnD8ggHt7vF7UFTmEs/Xdj/i
 +VzUO0+nRSajNbm7ghchSW9CsKhLqx6flZ8BUfnV1/XG2sf2qTaGC0N9fpgVMMZXMUPd
 3G6v3oRSFEOU9gPCcDUv3p02hRvxsU+UyVzma4+iNVhO9q1BvWDBQdYufY/KpzhW0kDJ
 Q6iXaszktC0nwlEkcVJ66i/KZIjNd0hVFhb7WehrbhWjXmVkNaVEOrEmclBQw9/c9zKu
 caNA==
X-Gm-Message-State: AOAM532ac/hL4vhrQZb5JVh0Mgxfkw5k2boc7NLxIK4TlvuWYTA442iv
 5N2WizEgP64JzEtcNfInFkHR7ltvNTz/TjfmbnI=
X-Google-Smtp-Source: ABdhPJxhyaz88ccLKxsrAkdggzOfF1dosUt5ZWrx7kTw8IKhiaFNzmiThqK2mfoHghMTyBReL8we9CFrmcZreTeNSzg=
X-Received: by 2002:a05:6e02:4d:: with SMTP id
 i13mr4615414ilr.227.1592330363708; 
 Tue, 16 Jun 2020 10:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200616032229.766089-1-anup.patel@wdc.com>
 <20200616032229.766089-5-anup.patel@wdc.com>
In-Reply-To: <20200616032229.766089-5-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2020 10:49:58 -0700
Message-ID: <CAKmqyKNtH-eRkkW=jwHCnjf08y3sagjQZvbCAm=rfSW0-=FRnA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] hw/riscv: spike: Allow creating multiple NUMA
 sockets
To: Anup Patel <anup.patel@wdc.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 8:23 PM Anup Patel <anup.patel@wdc.com> wrote:
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
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/spike.c         | 237 ++++++++++++++++++++++++++-------------
>  include/hw/riscv/spike.h |  11 +-
>  2 files changed, 169 insertions(+), 79 deletions(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index a3db885ffa..29e7270035 100644
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
> +
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
> -
> -    /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> -                            &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> -                            &error_abort);
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> -                            &error_abort);
> +    char *soc_name;
> +    int i, base_hartid, hart_count;
> +
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
> @@ -249,21 +313,40 @@ static void spike_board_init(MachineState *machine)
>                            &address_space_memory);
>
>      /* initialize HTIF using symbols found in load_kernel */
> -    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> +    htif_mm_init(system_memory, mask_rom,
> +                 &s->soc[0].harts[0].env, serial_hd(0));
> +}
>
> -    /* Core Local Interruptor (timer and IPI) */
> -    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> -        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> -        false);
> +static void spike_machine_instance_init(Object *obj)
> +{
>  }
>
> -static void spike_machine_init(MachineClass *mc)
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
> +}
> +
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
>  }
>
> -DEFINE_MACHINE("spike", spike_machine_init)
> +type_init(spike_machine_init_register_types)
> diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
> index 1cd72b85d6..b0a18a9c94 100644
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

