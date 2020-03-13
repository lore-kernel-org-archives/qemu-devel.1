Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C858C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2507920724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2507920724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57331 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCiY0-0001Wx-8x
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 07:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jCiX0-0000bZ-AI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jCiWw-0002wY-CU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:31:10 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:44288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jCiWw-0002qG-1z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:31:06 -0400
Received: from player728.ha.ovh.net (unknown [10.110.115.246])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 4790F88B18
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:31:03 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id 3C824104DD7EF;
 Fri, 13 Mar 2020 11:30:53 +0000 (UTC)
Date: Fri, 13 Mar 2020 12:30:51 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/4] spapr: Move creation of ibm,
 dynamic-reconfiguration-memory dt node
Message-ID: <20200313123051.7ebe1eca@bahia.home>
In-Reply-To: <20200313040539.819138-2-david@gibson.dropbear.id.au>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
 <20200313040539.819138-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7995578191517620710
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvjedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.105
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 15:05:36 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently this node with information about hotpluggable memory is created
> from spapr_dt_cas_updates().  But that's just a hangover from when we
> created it only as a diff to the device tree at CAS time.  Now that we
> fully rebuild the DT as CAS time, it makes more sense to create this along
> with the rest of the memory information in the device tree.
> 
> So, move it to spapr_populate_memory().  The patch is huge, but it's nearly
> all just code motion.
> 

The change looks good but it may be possible to improve the diffstat,
see some comments below.

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 512 +++++++++++++++++++++++++------------------------
>  1 file changed, 257 insertions(+), 255 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 64bc8b83e9..66289ffef5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -341,257 +341,6 @@ static int spapr_populate_memory_node(void *fdt, int nodeid, hwaddr start,
>      return off;
>  }
>  
> -static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
> -{
> -    MachineState *machine = MACHINE(spapr);
> -    hwaddr mem_start, node_size;
> -    int i, nb_nodes = machine->numa_state->num_nodes;
> -    NodeInfo *nodes = machine->numa_state->nodes;
> -
> -    for (i = 0, mem_start = 0; i < nb_nodes; ++i) {
> -        if (!nodes[i].node_mem) {
> -            continue;
> -        }
> -        if (mem_start >= machine->ram_size) {
> -            node_size = 0;
> -        } else {
> -            node_size = nodes[i].node_mem;
> -            if (node_size > machine->ram_size - mem_start) {
> -                node_size = machine->ram_size - mem_start;
> -            }
> -        }
> -        if (!mem_start) {
> -            /* spapr_machine_init() checks for rma_size <= node0_size
> -             * already */
> -            spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
> -            mem_start += spapr->rma_size;
> -            node_size -= spapr->rma_size;
> -        }
> -        for ( ; node_size; ) {
> -            hwaddr sizetmp = pow2floor(node_size);
> -
> -            /* mem_start != 0 here */
> -            if (ctzl(mem_start) < ctzl(sizetmp)) {
> -                sizetmp = 1ULL << ctzl(mem_start);
> -            }
> -
> -            spapr_populate_memory_node(fdt, i, mem_start, sizetmp);
> -            node_size -= sizetmp;
> -            mem_start += sizetmp;
> -        }
> -    }
> -
> -    return 0;
> -}
> -
> -static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
> -                                  SpaprMachineState *spapr)
> -{
> -    MachineState *ms = MACHINE(spapr);
> -    PowerPCCPU *cpu = POWERPC_CPU(cs);
> -    CPUPPCState *env = &cpu->env;
> -    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
> -    int index = spapr_get_vcpu_id(cpu);
> -    uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
> -                       0xffffffff, 0xffffffff};
> -    uint32_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq()
> -        : SPAPR_TIMEBASE_FREQ;
> -    uint32_t cpufreq = kvm_enabled() ? kvmppc_get_clockfreq() : 1000000000;
> -    uint32_t page_sizes_prop[64];
> -    size_t page_sizes_prop_size;
> -    unsigned int smp_threads = ms->smp.threads;
> -    uint32_t vcpus_per_socket = smp_threads * ms->smp.cores;
> -    uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
> -    int compat_smt = MIN(smp_threads, ppc_compat_max_vthreads(cpu));
> -    SpaprDrc *drc;
> -    int drc_index;
> -    uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
> -    int i;
> -
> -    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
> -    if (drc) {
> -        drc_index = spapr_drc_index(drc);
> -        _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index)));
> -    }
> -
> -    _FDT((fdt_setprop_cell(fdt, offset, "reg", index)));
> -    _FDT((fdt_setprop_string(fdt, offset, "device_type", "cpu")));
> -
> -    _FDT((fdt_setprop_cell(fdt, offset, "cpu-version", env->spr[SPR_PVR])));
> -    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-block-size",
> -                           env->dcache_line_size)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-line-size",
> -                           env->dcache_line_size)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-block-size",
> -                           env->icache_line_size)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-line-size",
> -                           env->icache_line_size)));
> -
> -    if (pcc->l1_dcache_size) {
> -        _FDT((fdt_setprop_cell(fdt, offset, "d-cache-size",
> -                               pcc->l1_dcache_size)));
> -    } else {
> -        warn_report("Unknown L1 dcache size for cpu");
> -    }
> -    if (pcc->l1_icache_size) {
> -        _FDT((fdt_setprop_cell(fdt, offset, "i-cache-size",
> -                               pcc->l1_icache_size)));
> -    } else {
> -        warn_report("Unknown L1 icache size for cpu");
> -    }
> -
> -    _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "slb-size", cpu->hash64_opts->slb_size)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts->slb_size)));
> -    _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
> -    _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> -
> -    if (env->spr_cb[SPR_PURR].oea_read) {
> -        _FDT((fdt_setprop_cell(fdt, offset, "ibm,purr", 1)));
> -    }
> -    if (env->spr_cb[SPR_SPURR].oea_read) {
> -        _FDT((fdt_setprop_cell(fdt, offset, "ibm,spurr", 1)));
> -    }
> -
> -    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
> -        _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
> -                          segs, sizeof(segs))));
> -    }
> -
> -    /* Advertise VSX (vector extensions) if available
> -     *   1               == VMX / Altivec available
> -     *   2               == VSX available
> -     *
> -     * Only CPUs for which we create core types in spapr_cpu_core.c
> -     * are possible, and all of those have VMX */
> -    if (spapr_get_cap(spapr, SPAPR_CAP_VSX) != 0) {
> -        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 2)));
> -    } else {
> -        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 1)));
> -    }
> -
> -    /* Advertise DFP (Decimal Floating Point) if available
> -     *   0 / no property == no DFP
> -     *   1               == DFP available */
> -    if (spapr_get_cap(spapr, SPAPR_CAP_DFP) != 0) {
> -        _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
> -    }
> -
> -    page_sizes_prop_size = ppc_create_page_sizes_prop(cpu, page_sizes_prop,
> -                                                      sizeof(page_sizes_prop));
> -    if (page_sizes_prop_size) {
> -        _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
> -                          page_sizes_prop, page_sizes_prop_size)));
> -    }
> -
> -    spapr_populate_pa_features(spapr, cpu, fdt, offset);
> -
> -    _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
> -                           cs->cpu_index / vcpus_per_socket)));
> -
> -    _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
> -                      pft_size_prop, sizeof(pft_size_prop))));
> -
> -    if (ms->numa_state->num_nodes > 1) {
> -        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
> -    }
> -
> -    _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
> -
> -    if (pcc->radix_page_info) {
> -        for (i = 0; i < pcc->radix_page_info->count; i++) {
> -            radix_AP_encodings[i] =
> -                cpu_to_be32(pcc->radix_page_info->entries[i]);
> -        }
> -        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings",
> -                          radix_AP_encodings,
> -                          pcc->radix_page_info->count *
> -                          sizeof(radix_AP_encodings[0]))));
> -    }
> -
> -    /*
> -     * We set this property to let the guest know that it can use the large
> -     * decrementer and its width in bits.
> -     */
> -    if (spapr_get_cap(spapr, SPAPR_CAP_LARGE_DECREMENTER) != SPAPR_CAP_OFF)
> -        _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
> -                              pcc->lrg_decr_bits)));
> -}
> -
> -static void spapr_populate_cpus_dt_node(void *fdt, SpaprMachineState *spapr)
> -{
> -    CPUState **rev;
> -    CPUState *cs;
> -    int n_cpus;
> -    int cpus_offset;
> -    char *nodename;
> -    int i;
> -
> -    cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
> -    _FDT(cpus_offset);
> -    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
> -    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
> -
> -    /*
> -     * We walk the CPUs in reverse order to ensure that CPU DT nodes
> -     * created by fdt_add_subnode() end up in the right order in FDT
> -     * for the guest kernel the enumerate the CPUs correctly.
> -     *
> -     * The CPU list cannot be traversed in reverse order, so we need
> -     * to do extra work.
> -     */
> -    n_cpus = 0;
> -    rev = NULL;
> -    CPU_FOREACH(cs) {
> -        rev = g_renew(CPUState *, rev, n_cpus + 1);
> -        rev[n_cpus++] = cs;
> -    }
> -
> -    for (i = n_cpus - 1; i >= 0; i--) {
> -        CPUState *cs = rev[i];
> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
> -        int index = spapr_get_vcpu_id(cpu);
> -        DeviceClass *dc = DEVICE_GET_CLASS(cs);
> -        int offset;
> -
> -        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
> -            continue;
> -        }
> -
> -        nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
> -        offset = fdt_add_subnode(fdt, cpus_offset, nodename);
> -        g_free(nodename);
> -        _FDT(offset);
> -        spapr_populate_cpu_dt(cs, fdt, offset, spapr);
> -    }
> -
> -    g_free(rev);
> -}
> -
> -static int spapr_rng_populate_dt(void *fdt)

I'm not quite sure why this function needs to move...

> -{
> -    int node;
> -    int ret;
> -
> -    node = qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
> -    if (node <= 0) {
> -        return -1;
> -    }
> -    ret = fdt_setprop_string(fdt, node, "device_type",
> -                             "ibm,platform-facilities");
> -    ret |= fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
> -    ret |= fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
> -
> -    node = fdt_add_subnode(fdt, node, "ibm,random-v1");
> -    if (node <= 0) {
> -        return -1;
> -    }
> -    ret |= fdt_setprop_string(fdt, node, "compatible", "ibm,random");
> -
> -    return ret ? -1 : 0;
> -}
> -
>  static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_t addr)
>  {
>      MemoryDeviceInfoList *info;
> @@ -877,14 +626,51 @@ static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *fdt)
>      return ret;
>  }
>  
> -static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
> -                                SpaprOptionVector *ov5_updates)
> +static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>  {
> +    MachineState *machine = MACHINE(spapr);
>      SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> -    int ret = 0, offset;
> +    hwaddr mem_start, node_size;
> +    int i, nb_nodes = machine->numa_state->num_nodes;
> +    NodeInfo *nodes = machine->numa_state->nodes;
> +
> +    for (i = 0, mem_start = 0; i < nb_nodes; ++i) {
> +        if (!nodes[i].node_mem) {
> +            continue;
> +        }
> +        if (mem_start >= machine->ram_size) {
> +            node_size = 0;
> +        } else {
> +            node_size = nodes[i].node_mem;
> +            if (node_size > machine->ram_size - mem_start) {
> +                node_size = machine->ram_size - mem_start;
> +            }
> +        }
> +        if (!mem_start) {
> +            /* spapr_machine_init() checks for rma_size <= node0_size
> +             * already */
> +            spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
> +            mem_start += spapr->rma_size;
> +            node_size -= spapr->rma_size;
> +        }
> +        for ( ; node_size; ) {
> +            hwaddr sizetmp = pow2floor(node_size);
> +
> +            /* mem_start != 0 here */
> +            if (ctzl(mem_start) < ctzl(sizetmp)) {
> +                sizetmp = 1ULL << ctzl(mem_start);
> +            }
> +
> +            spapr_populate_memory_node(fdt, i, mem_start, sizetmp);
> +            node_size -= sizetmp;
> +            mem_start += sizetmp;
> +        }
> +    }
>  
>      /* Generate ibm,dynamic-reconfiguration-memory node if required */
> -    if (spapr_ovec_test(ov5_updates, OV5_DRCONF_MEMORY)) {
> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_DRCONF_MEMORY)) {
> +        int ret;
> +
>          g_assert(smc->dr_lmb_enabled);
>          ret = spapr_populate_drconf_memory(spapr, fdt);
>          if (ret) {
> @@ -892,6 +678,222 @@ static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
>          }
>      }
>  
> +    return 0;
> +}
> +
> +static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
> +                                  SpaprMachineState *spapr)
> +{
> +    MachineState *ms = MACHINE(spapr);
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
> +    int index = spapr_get_vcpu_id(cpu);
> +    uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
> +                       0xffffffff, 0xffffffff};
> +    uint32_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq()
> +        : SPAPR_TIMEBASE_FREQ;
> +    uint32_t cpufreq = kvm_enabled() ? kvmppc_get_clockfreq() : 1000000000;
> +    uint32_t page_sizes_prop[64];
> +    size_t page_sizes_prop_size;
> +    unsigned int smp_threads = ms->smp.threads;
> +    uint32_t vcpus_per_socket = smp_threads * ms->smp.cores;
> +    uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
> +    int compat_smt = MIN(smp_threads, ppc_compat_max_vthreads(cpu));
> +    SpaprDrc *drc;
> +    int drc_index;
> +    uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
> +    int i;
> +
> +    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
> +    if (drc) {
> +        drc_index = spapr_drc_index(drc);
> +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index)));
> +    }
> +
> +    _FDT((fdt_setprop_cell(fdt, offset, "reg", index)));
> +    _FDT((fdt_setprop_string(fdt, offset, "device_type", "cpu")));
> +
> +    _FDT((fdt_setprop_cell(fdt, offset, "cpu-version", env->spr[SPR_PVR])));
> +    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-block-size",
> +                           env->dcache_line_size)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-line-size",
> +                           env->dcache_line_size)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-block-size",
> +                           env->icache_line_size)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-line-size",
> +                           env->icache_line_size)));
> +
> +    if (pcc->l1_dcache_size) {
> +        _FDT((fdt_setprop_cell(fdt, offset, "d-cache-size",
> +                               pcc->l1_dcache_size)));
> +    } else {
> +        warn_report("Unknown L1 dcache size for cpu");
> +    }
> +    if (pcc->l1_icache_size) {
> +        _FDT((fdt_setprop_cell(fdt, offset, "i-cache-size",
> +                               pcc->l1_icache_size)));
> +    } else {
> +        warn_report("Unknown L1 icache size for cpu");
> +    }
> +
> +    _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "slb-size", cpu->hash64_opts->slb_size)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts->slb_size)));
> +    _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
> +    _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> +
> +    if (env->spr_cb[SPR_PURR].oea_read) {
> +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,purr", 1)));
> +    }
> +    if (env->spr_cb[SPR_SPURR].oea_read) {
> +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,spurr", 1)));
> +    }
> +
> +    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
> +        _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
> +                          segs, sizeof(segs))));
> +    }
> +
> +    /* Advertise VSX (vector extensions) if available
> +     *   1               == VMX / Altivec available
> +     *   2               == VSX available
> +     *
> +     * Only CPUs for which we create core types in spapr_cpu_core.c
> +     * are possible, and all of those have VMX */
> +    if (spapr_get_cap(spapr, SPAPR_CAP_VSX) != 0) {
> +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 2)));
> +    } else {
> +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 1)));
> +    }
> +
> +    /* Advertise DFP (Decimal Floating Point) if available
> +     *   0 / no property == no DFP
> +     *   1               == DFP available */
> +    if (spapr_get_cap(spapr, SPAPR_CAP_DFP) != 0) {
> +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
> +    }
> +
> +    page_sizes_prop_size = ppc_create_page_sizes_prop(cpu, page_sizes_prop,
> +                                                      sizeof(page_sizes_prop));
> +    if (page_sizes_prop_size) {
> +        _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
> +                          page_sizes_prop, page_sizes_prop_size)));
> +    }
> +
> +    spapr_populate_pa_features(spapr, cpu, fdt, offset);
> +
> +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
> +                           cs->cpu_index / vcpus_per_socket)));
> +
> +    _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
> +                      pft_size_prop, sizeof(pft_size_prop))));
> +
> +    if (ms->numa_state->num_nodes > 1) {
> +        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
> +    }
> +
> +    _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
> +
> +    if (pcc->radix_page_info) {
> +        for (i = 0; i < pcc->radix_page_info->count; i++) {
> +            radix_AP_encodings[i] =
> +                cpu_to_be32(pcc->radix_page_info->entries[i]);
> +        }
> +        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings",
> +                          radix_AP_encodings,
> +                          pcc->radix_page_info->count *
> +                          sizeof(radix_AP_encodings[0]))));
> +    }
> +
> +    /*
> +     * We set this property to let the guest know that it can use the large
> +     * decrementer and its width in bits.
> +     */
> +    if (spapr_get_cap(spapr, SPAPR_CAP_LARGE_DECREMENTER) != SPAPR_CAP_OFF)
> +        _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
> +                              pcc->lrg_decr_bits)));
> +}
> +
> +static void spapr_populate_cpus_dt_node(void *fdt, SpaprMachineState *spapr)
> +{
> +    CPUState **rev;
> +    CPUState *cs;
> +    int n_cpus;
> +    int cpus_offset;
> +    char *nodename;
> +    int i;
> +
> +    cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
> +    _FDT(cpus_offset);
> +    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
> +    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
> +
> +    /*
> +     * We walk the CPUs in reverse order to ensure that CPU DT nodes
> +     * created by fdt_add_subnode() end up in the right order in FDT
> +     * for the guest kernel the enumerate the CPUs correctly.
> +     *
> +     * The CPU list cannot be traversed in reverse order, so we need
> +     * to do extra work.
> +     */
> +    n_cpus = 0;
> +    rev = NULL;
> +    CPU_FOREACH(cs) {
> +        rev = g_renew(CPUState *, rev, n_cpus + 1);
> +        rev[n_cpus++] = cs;
> +    }
> +
> +    for (i = n_cpus - 1; i >= 0; i--) {
> +        CPUState *cs = rev[i];
> +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> +        int index = spapr_get_vcpu_id(cpu);
> +        DeviceClass *dc = DEVICE_GET_CLASS(cs);
> +        int offset;
> +
> +        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
> +            continue;
> +        }
> +
> +        nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
> +        offset = fdt_add_subnode(fdt, cpus_offset, nodename);
> +        g_free(nodename);
> +        _FDT(offset);
> +        spapr_populate_cpu_dt(cs, fdt, offset, spapr);
> +    }
> +
> +    g_free(rev);
> +}
> +
> +static int spapr_rng_populate_dt(void *fdt)
> +{
> +    int node;
> +    int ret;
> +
> +    node = qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
> +    if (node <= 0) {
> +        return -1;
> +    }
> +    ret = fdt_setprop_string(fdt, node, "device_type",
> +                             "ibm,platform-facilities");
> +    ret |= fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
> +    ret |= fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
> +
> +    node = fdt_add_subnode(fdt, node, "ibm,random-v1");
> +    if (node <= 0) {
> +        return -1;
> +    }
> +    ret |= fdt_setprop_string(fdt, node, "compatible", "ibm,random");
> +
> +    return ret ? -1 : 0;
> +}
> +
> +static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
> +                                SpaprOptionVector *ov5_updates)
> +{
> +    int offset;
> +
>      offset = fdt_path_offset(fdt, "/chosen");
>      if (offset < 0) {
>          offset = fdt_add_subnode(fdt, 0, "chosen");

The final code is thus:

static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
                                SpaprOptionVector *ov5_updates)
{
    int offset;

    offset = fdt_path_offset(fdt, "/chosen");
    if (offset < 0) {
        offset = fdt_add_subnode(fdt, 0, "chosen");
        if (offset < 0) {
            return offset;
        }
    }
    return spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
                                  "ibm,architecture-vec-5");
}

ie. ov5_updates has no more users. It wasn't very useful BTW
since the unique caller of spapr_dt_cas_updates() already
passes spapr->ov5_cas. Maybe kill it ?

Anyway, in case you prefer to fix this up later:

Reviewed-by: Greg Kurz <groug@kaod.org>

