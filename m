Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933F6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 00:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B022071A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 00:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLxSQrbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B022071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdkEV-0001nZ-DF
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 20:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdkDn-0001Lm-MH; Tue, 26 May 2020 20:47:03 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:39563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdkDm-0007q2-3P; Tue, 26 May 2020 20:47:03 -0400
Received: by mail-il1-x142.google.com with SMTP id c20so22420623ilk.6;
 Tue, 26 May 2020 17:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mj49TKHOvOZ94RSajWxXIK/dI46fqGEbdzqVnsXQMKs=;
 b=JLxSQrbNmz20pG/ruh9UigJEgGy3gJpCC8ZT2dvS68owjZQ/UuRgviGOscjz1+wExC
 BK2h/u+Ijiporo+UiQp4Vz6P2o9uqWV+YrsUWrvEFZBK1gxjJCyIyvsUrwk6GpDdVaQJ
 Gw+depZWvzSo2Bm2VRStTMXHbREdD4dBRwkjbcUS/4sK3SQffRnnPMwbwnKarlLpLieI
 ubTm+vPw7mXSyyfa7IbeXpmB0BAzfT1bV084Fb8MV1+wPPeUbeHoIw2fFlMy0Vtj4oB5
 wsRL/LTjyp8SQawXjHC1P+HJc5jilM28JCCGFZrAQ0vwb/iwT9KcYZWGam1OMTiBIlVR
 XIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mj49TKHOvOZ94RSajWxXIK/dI46fqGEbdzqVnsXQMKs=;
 b=Mm5IHDFxWbG01/zGyN6aL7XSYR2ZnHOmZd321cJybsG4qtb17S+eLRzwQAC9T+ZIep
 KdQQ5zbs8LCb24uZ1luUn1JrNNYRswgNaQkYiuTy6khKSOI5uN/7inAPLb8uRfd1Y+OE
 ceyGlff6FwLVtsT0nbJXoZY4oJPFDJZs2LOwtjXIPkfLdUH9OlcH60oXhe0+XfamCHtt
 OdkMKx28+LrlxX8dFx0iPEZRBNnnTG0Ld9Gzl2DVwS9PEir7KcWNISX5oUB5xRof1mMt
 w/kApOU0fLAG8ogFfJ8srq0t1iLhbBpvdOnj/eZXVgjQwS/QnM9s0q5FEKv0ba/2AORr
 maeQ==
X-Gm-Message-State: AOAM532aeVDZiSPptmw0UT97v17OoLAlpF13lyFnONRE56hAVdVaj9gU
 Ve9FzGWr0vtwxR3Etpy/KtepbLTwHxTJxGXbo9Q=
X-Google-Smtp-Source: ABdhPJx5pAGt/f5AvfXYkTOmpS/0WOID3kls2zYO5hvsdimEfdEXfjPeXeYp3xnJuGGJ7c2JZbeeduLNSS9NNzTCRwE=
X-Received: by 2002:a92:d087:: with SMTP id h7mr3912748ilh.227.1590540420516; 
 Tue, 26 May 2020 17:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200516063746.18296-3-anup.patel@wdc.com>
 <mhng-a9ec47e8-e98a-4c33-83db-ed838eb62404@palmerdabbelt-glaptop1>
 <DM6PR04MB6201841F5FB7E714AD77384F8DB40@DM6PR04MB6201.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6201841F5FB7E714AD77384F8DB40@DM6PR04MB6201.namprd04.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 17:38:01 -0700
Message-ID: <CAKmqyKMBCGiWVVgXkWwmeeEZ5TDRZhHPedXeDN177GgavnWCsA@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/riscv: spike: Allow creating multiple sockets
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>,
 "anup@brainfault.org" <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 3:10 AM Anup Patel <Anup.Patel@wdc.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Palmer Dabbelt <palmer@dabbelt.com>
> > Sent: 22 May 2020 01:46
> > To: Anup Patel <Anup.Patel@wdc.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>; Alistair Francis
> > <Alistair.Francis@wdc.com>; sagark@eecs.berkeley.edu; Atish Patra
> > <Atish.Patra@wdc.com>; anup@brainfault.org; qemu-riscv@nongnu.org;
> > qemu-devel@nongnu.org; Anup Patel <Anup.Patel@wdc.com>
> > Subject: Re: [PATCH 2/4] hw/riscv: spike: Allow creating multiple sockets
> >
> > On Fri, 15 May 2020 23:37:44 PDT (-0700), Anup Patel wrote:
> > > We extend RISC-V spike machine to allow creating a multi-socket machine.
> > > Each RISC-V spike machine socket is a set of HARTs and a CLINT instance.
> > > Other peripherals are shared between all RISC-V spike machine sockets.
> > > We also update RISC-V spike machine device tree to treat each socket
> > > as a NUMA node.
> > >
> > > The number of sockets in RISC-V spike machine can be specified using
> > > the "sockets=" sub-option of QEMU "-smp" command-line option. By
> > > default, only one socket RISC-V spike machine will be created.
> > >
> > > Currently, we only allow creating upto maximum 4 sockets with minimum
> > > 2 HARTs per socket. In future, this limits can be changed.
> > >
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > ---
> > >  hw/riscv/spike.c         | 206 ++++++++++++++++++++++++---------------
> > >  include/hw/riscv/spike.h |   8 +-
> > >  2 files changed, 133 insertions(+), 81 deletions(-)
> > >
> > > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c index
> > > d5e0103d89..f63c57a87c 100644
> > > --- a/hw/riscv/spike.c
> > > +++ b/hw/riscv/spike.c
> > > @@ -64,9 +64,11 @@ static void create_fdt(SpikeState *s, const struct
> > MemmapEntry *memmap,
> > >      uint64_t mem_size, const char *cmdline)  {
> > >      void *fdt;
> > > -    int cpu;
> > > -    uint32_t *cells;
> > > -    char *nodename;
> > > +    int cpu, socket;
> > > +    uint32_t *clint_cells;
> > > +    unsigned long clint_addr;
> > > +    uint32_t cpu_phandle, intc_phandle, phandle = 1;
> > > +    char *name, *clint_name, *clust_name, *core_name, *cpu_name,
> > > + *intc_name;
> > >
> > >      fdt = s->fdt = create_device_tree(&s->fdt_size);
> > >      if (!fdt) {
> > > @@ -88,68 +90,85 @@ static void create_fdt(SpikeState *s, const struct
> > MemmapEntry *memmap,
> > >      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
> > >      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
> > >
> > > -    nodename = g_strdup_printf("/memory@%lx",
> > > -        (long)memmap[SPIKE_DRAM].base);
> > > -    qemu_fdt_add_subnode(fdt, nodename);
> > > -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> > > +    name = g_strdup_printf("/memory@%lx",
> > (long)memmap[SPIKE_DRAM].base);
> > > +    qemu_fdt_add_subnode(fdt, name);
> > > +    qemu_fdt_setprop_cells(fdt, name, "reg",
> > >          memmap[SPIKE_DRAM].base >> 32, memmap[SPIKE_DRAM].base,
> > >          mem_size >> 32, mem_size);
> > > -    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> > > -    g_free(nodename);
> > > +    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
> > > +    g_free(name);
> > >
> > >      qemu_fdt_add_subnode(fdt, "/cpus");
> > >      qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
> > >          SIFIVE_CLINT_TIMEBASE_FREQ);
> > >      qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
> > >      qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
> > > +    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
> > >
> > > -    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
> > > -        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> > > -        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> > > -        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
> > > -        qemu_fdt_add_subnode(fdt, nodename);
> > > +    for (socket = (s->num_socs - 1); socket >= 0; socket--) {
> > > +        clust_name = g_strdup_printf("/cpus/cpu-map/cluster0%d", socket);
> > > +        qemu_fdt_add_subnode(fdt, clust_name);
> > > +
> > > +        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts *
> > > + 4);
> > > +
> > > +        for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
> > > +            cpu_phandle = phandle++;
> > > +
> > > +            cpu_name = g_strdup_printf("/cpus/cpu@%d",
> > > +                s->soc[socket].hartid_base + cpu);
> > > +            qemu_fdt_add_subnode(fdt, cpu_name);
> > >  #if defined(TARGET_RISCV32)
> > > -        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
> > > +            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type",
> > > + "riscv,sv32");
> > >  #else
> > > -        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
> > > +            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type",
> > > + "riscv,sv48");
> > >  #endif
> > > -        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
> > > -        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
> > > -        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
> > > -        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
> > > -        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
> > > -        qemu_fdt_add_subnode(fdt, intc);
> > > -        qemu_fdt_setprop_cell(fdt, intc, "phandle", 1);
> > > -        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
> > > -        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
> > > -        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
> > > -        g_free(isa);
> > > -        g_free(intc);
> > > -        g_free(nodename);
> > > -    }
> > > +            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
> > > +            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
> > > +            g_free(name);
> > > +            qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
> > > +            qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
> > > +            qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> > > +                s->soc[socket].hartid_base + cpu);
> > > +            qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
> > > +            qemu_fdt_setprop_cell(fdt, cpu_name, "phandle",
> > > + cpu_phandle);
> > > +
> > > +            intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
> > > +            qemu_fdt_add_subnode(fdt, intc_name);
> > > +            intc_phandle = phandle++;
> > > +            qemu_fdt_setprop_cell(fdt, intc_name, "phandle", intc_phandle);
> > > +            qemu_fdt_setprop_string(fdt, intc_name, "compatible",
> > > +                "riscv,cpu-intc");
> > > +            qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
> > > +            qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells",
> > > + 1);
> > > +
> > > +            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> > > +            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
> > > +            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
> > > +            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
> > > +
> > > +            core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
> > > +            qemu_fdt_add_subnode(fdt, core_name);
> > > +            qemu_fdt_setprop_cell(fdt, core_name, "cpu",
> > > + cpu_phandle);
> > > +
> > > +            g_free(core_name);
> > > +            g_free(intc_name);
> > > +            g_free(cpu_name);
> > > +        }
> > >
> > > -    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
> > > -    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
> > > -        nodename =
> > > -            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> > > -        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
> > > -        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> > > -        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
> > > -        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
> > > -        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
> > > -        g_free(nodename);
> > > +        clint_addr = memmap[SPIKE_CLINT].base +
> > > +            (memmap[SPIKE_CLINT].size * socket);
> > > +        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
> > > +        qemu_fdt_add_subnode(fdt, clint_name);
> > > +        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
> > > +        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
> > > +            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
> > > +        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
> > > +            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t)
> > > + * 4);
> > > +
> > > +        g_free(clint_name);
> > > +        g_free(clint_cells);
> > > +        g_free(clust_name);
> > >      }
> > > -    nodename = g_strdup_printf("/soc/clint@%lx",
> > > -        (long)memmap[SPIKE_CLINT].base);
> > > -    qemu_fdt_add_subnode(fdt, nodename);
> > > -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
> > > -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> > > -        0x0, memmap[SPIKE_CLINT].base,
> > > -        0x0, memmap[SPIKE_CLINT].size);
> > > -    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
> > > -        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
> > > -    g_free(cells);
> > > -    g_free(nodename);
> > >
> > >      if (cmdline) {
> > >          qemu_fdt_add_subnode(fdt, "/chosen"); @@ -160,23 +179,51 @@
> > > static void create_fdt(SpikeState *s, const struct MemmapEntry
> > > *memmap,  static void spike_board_init(MachineState *machine)  {
> > >      const struct MemmapEntry *memmap = spike_memmap;
> > > -
> > >      SpikeState *s = g_new0(SpikeState, 1);
> > >      MemoryRegion *system_memory = get_system_memory();
> > >      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> > >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> > >      int i;
> > > +    char *soc_name;
> > >      unsigned int smp_cpus = machine->smp.cpus;
> > > -
> > > -    /* Initialize SOC */
> > > -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> > > -                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> > > -    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-
> > type",
> > > -                            &error_abort);
> > > -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> > > -                            &error_abort);
> > > -    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> > > -                            &error_abort);
> > > +    unsigned int base_hartid, cpus_per_socket;
> > > +
> > > +    s->num_socs = machine->smp.sockets;
> > > +
> > > +    /* Ensure minumum required CPUs per socket */
> > > +    if ((smp_cpus / s->num_socs) < SPIKE_CPUS_PER_SOCKET_MIN)
> > > +        s->num_socs = 1;
> >
> > Why?  It seems like creating single-hart sockets would be a good test case, and
> > I'm pretty sure it's a configuration that we had in embedded systems.
>
> Yes, single-hart sockets are sensible for testing software.
>
> When "sockets=" sub-option is not provided in "-smp " command line
> options, the machine->smp.sockets is set same as machine->smp.cpus
> by smp_parse() function in hw/core/machine.c. This means by default
> we will always get single-hart per socket. In other words, "-smp 4" will
> be 4 cpus and 4 sockets. This is counter intuitive for users because when
> "sockets=" is not provided we should default to single socket irrespective
> to number of cpus.
>
> I had added SPIKE_CPUS_PER_SOCKET_MIN to handle the default case
> when no "sockets=" sub-option is provided.
>
> Alternate approach will be:
> 1. Add more members in struct CpuTopology of include/hw/boards.h
>     to help us know whether "sockets=" option was passed or not
> 2. Update smp_parse() for new members in struct CpuTopology
> 3. Assume single-socket machine in QEMU RISC-V virt and QEMU
>     RISC-V spike machines when "sockets=" option was not passed
>
> Suggestions ??
>

I think it makes sense to just stick to what smp_parse() does. That's
what QEMU users are used to so we should follow that.

I agree it is strange that is specifying `-smp x' you will get
max_cpus number of sockets and split the CPUs via them, but that's
what every other board (besides x86) does.

Alistair

