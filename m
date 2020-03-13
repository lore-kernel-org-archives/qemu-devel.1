Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E99CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F535206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F535206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCiuk-0002pz-HN
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 07:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jCitx-0002GU-MA
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jCits-0006y6-K6
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:54:53 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:49405)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jCits-0006fs-8S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:54:48 -0400
Received: from player772.ha.ovh.net (unknown [10.110.115.5])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id C29EB15F8C7
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:54:44 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id E5CC510723C15;
 Fri, 13 Mar 2020 11:54:39 +0000 (UTC)
Date: Fri, 13 Mar 2020 12:54:37 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/4] spapr: Rename DT functions to newer naming convention
Message-ID: <20200313125437.42314421@bahia.home>
In-Reply-To: <20200313040539.819138-4-david@gibson.dropbear.id.au>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
 <20200313040539.819138-4-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8395835608846014950
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvjedgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejfedtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.63.100
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

On Fri, 13 Mar 2020 15:05:38 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> In the spapr code we've been gradually moving towards a convention that
> functions which create pieces of the device tree are called spapr_dt_*().
> This patch speeds that along by renaming most of the things that don't yet
> match that so that they do.
> 
> For now we leave the *_dt_populate() functions which are actual methods
> used in the DRCClass::dt_populate method.
> 
> While we're there we remove a few comments that don't really say anything
> useful.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

$ git grep _populate hw/ppc/spapr* | grep -v drc
hw/ppc/spapr_ovec.c:            trace_spapr_ovec_populate_dt(i, vec_len, vec[i]);

This one needs fixing since spapr_ovec_populate_dt() is renamed.

hw/ppc/spapr_pci.c:    spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
hw/ppc/spapr_pci.c:    spapr_phb_nvgpu_populate_dt(phb, fdt, bus_off, &err);
hw/ppc/spapr_pci.c:    spapr_phb_nvgpu_ram_populate_dt(phb, fdt);
hw/ppc/spapr_pci_nvlink2.c:void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb, void *fdt, int bus_off,
hw/ppc/spapr_pci_nvlink2.c:void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
hw/ppc/spapr_pci_nvlink2.c:void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int offset,

These look like good candidates since they are not DRC methods.

>  hw/ppc/spapr.c              | 62 +++++++++++++++++--------------------
>  hw/ppc/spapr_ovec.c         |  4 +--
>  include/hw/ppc/spapr_ovec.h |  4 +--
>  3 files changed, 33 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index fc28d9df25..6c32ec3c0a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -217,10 +217,9 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
>                            sizeof(associativity));
>  }
>  
> -/* Populate the "ibm,pa-features" property */
> -static void spapr_populate_pa_features(SpaprMachineState *spapr,
> -                                       PowerPCCPU *cpu,
> -                                       void *fdt, int offset)
> +static void spapr_dt_pa_features(SpaprMachineState *spapr,
> +                                 PowerPCCPU *cpu,
> +                                 void *fdt, int offset)
>  {
>      uint8_t pa_features_206[] = { 6, 0,
>          0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> @@ -315,8 +314,8 @@ static void add_str(GString *s, const gchar *s1)
>      g_string_append_len(s, s1, strlen(s1) + 1);
>  }
>  
> -static int spapr_populate_memory_node(void *fdt, int nodeid, hwaddr start,
> -                                       hwaddr size)
> +static int spapr_dt_memory_node(void *fdt, int nodeid, hwaddr start,
> +                                hwaddr size)
>  {
>      uint32_t associativity[] = {
>          cpu_to_be32(0x4), /* length */
> @@ -391,9 +390,8 @@ spapr_get_drconf_cell(uint32_t seq_lmbs, uint64_t base_addr,
>      return elem;
>  }
>  
> -/* ibm,dynamic-memory-v2 */
> -static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
> -                                   int offset, MemoryDeviceInfoList *dimms)
> +static int spapr_dt_dynamic_memory_v2(SpaprMachineState *spapr, void *fdt,
> +                                      int offset, MemoryDeviceInfoList *dimms)
>  {
>      MachineState *machine = MACHINE(spapr);
>      uint8_t *int_buf, *cur_index;
> @@ -484,8 +482,7 @@ static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
>      return 0;
>  }
>  
> -/* ibm,dynamic-memory */
> -static int spapr_populate_drmem_v1(SpaprMachineState *spapr, void *fdt,
> +static int spapr_dt_dynamic_memory(SpaprMachineState *spapr, void *fdt,
>                                     int offset, MemoryDeviceInfoList *dimms)
>  {
>      MachineState *machine = MACHINE(spapr);
> @@ -554,7 +551,8 @@ static int spapr_populate_drmem_v1(SpaprMachineState *spapr, void *fdt,
>   * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
>   * of this device tree node.
>   */
> -static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *fdt)
> +static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
> +                                                   void *fdt)
>  {
>      MachineState *machine = MACHINE(spapr);
>      int nb_numa_nodes = machine->numa_state->num_nodes;
> @@ -593,9 +591,9 @@ static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *fdt)
>      /* ibm,dynamic-memory or ibm,dynamic-memory-v2 */
>      dimms = qmp_memory_device_list();
>      if (spapr_ovec_test(spapr->ov5_cas, OV5_DRMEM_V2)) {
> -        ret = spapr_populate_drmem_v2(spapr, fdt, offset, dimms);
> +        ret = spapr_dt_dynamic_memory_v2(spapr, fdt, offset, dimms);
>      } else {
> -        ret = spapr_populate_drmem_v1(spapr, fdt, offset, dimms);
> +        ret = spapr_dt_dynamic_memory(spapr, fdt, offset, dimms);
>      }
>      qapi_free_MemoryDeviceInfoList(dimms);
>  
> @@ -626,7 +624,7 @@ static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *fdt)
>      return ret;
>  }
>  
> -static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
> +static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *machine = MACHINE(spapr);
>      SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> @@ -649,7 +647,7 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>          if (!mem_start) {
>              /* spapr_machine_init() checks for rma_size <= node0_size
>               * already */
> -            spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
> +            spapr_dt_memory_node(fdt, i, 0, spapr->rma_size);
>              mem_start += spapr->rma_size;
>              node_size -= spapr->rma_size;
>          }
> @@ -661,7 +659,7 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>                  sizetmp = 1ULL << ctzl(mem_start);
>              }
>  
> -            spapr_populate_memory_node(fdt, i, mem_start, sizetmp);
> +            spapr_dt_memory_node(fdt, i, mem_start, sizetmp);
>              node_size -= sizetmp;
>              mem_start += sizetmp;
>          }
> @@ -672,7 +670,7 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>          int ret;
>  
>          g_assert(smc->dr_lmb_enabled);
> -        ret = spapr_populate_drconf_memory(spapr, fdt);
> +        ret = spapr_dt_dynamic_reconfiguration_memory(spapr, fdt);
>          if (ret) {
>              return ret;
>          }
> @@ -681,8 +679,8 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>      return 0;
>  }
>  
> -static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
> -                                  SpaprMachineState *spapr)
> +static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
> +                         SpaprMachineState *spapr)
>  {
>      MachineState *ms = MACHINE(spapr);
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
> @@ -782,7 +780,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>                            page_sizes_prop, page_sizes_prop_size)));
>      }
>  
> -    spapr_populate_pa_features(spapr, cpu, fdt, offset);
> +    spapr_dt_pa_features(spapr, cpu, fdt, offset);
>  
>      _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
>                             cs->cpu_index / vcpus_per_socket)));
> @@ -816,7 +814,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>                                pcc->lrg_decr_bits)));
>  }
>  
> -static void spapr_populate_cpus_dt_node(void *fdt, SpaprMachineState *spapr)
> +static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
>  {
>      CPUState **rev;
>      CPUState *cs;
> @@ -860,13 +858,13 @@ static void spapr_populate_cpus_dt_node(void *fdt, SpaprMachineState *spapr)
>          offset = fdt_add_subnode(fdt, cpus_offset, nodename);
>          g_free(nodename);
>          _FDT(offset);
> -        spapr_populate_cpu_dt(cs, fdt, offset, spapr);
> +        spapr_dt_cpu(cs, fdt, offset, spapr);
>      }
>  
>      g_free(rev);
>  }
>  
> -static int spapr_rng_populate_dt(void *fdt)
> +static int spapr_dt_rng(void *fdt)
>  {
>      int node;
>      int ret;
> @@ -1099,8 +1097,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>  
>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>  
> -    _FDT(spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
> -                                "ibm,architecture-vec-5"));
> +    _FDT(spapr_dt_ovec(fdt, chosen, spapr->ov5_cas, "ibm,architecture-vec-5"));
>  
>      g_free(stdout_path);
>      g_free(bootlist);
> @@ -1181,7 +1178,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>      /* /interrupt controller */
>      spapr_irq_dt(spapr, spapr_max_server_number(spapr), fdt, PHANDLE_INTC);
>  
> -    ret = spapr_populate_memory(spapr, fdt);
> +    ret = spapr_dt_memory(spapr, fdt);
>      if (ret < 0) {
>          error_report("couldn't setup memory nodes in fdt");
>          exit(1);
> @@ -1191,7 +1188,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>      spapr_dt_vdevice(spapr->vio_bus, fdt);
>  
>      if (object_resolve_path_type("", TYPE_SPAPR_RNG, NULL)) {
> -        ret = spapr_rng_populate_dt(fdt);
> +        ret = spapr_dt_rng(fdt);
>          if (ret < 0) {
>              error_report("could not set up rng device in the fdt");
>              exit(1);
> @@ -1206,8 +1203,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>          }
>      }
>  
> -    /* cpus */
> -    spapr_populate_cpus_dt_node(fdt, spapr);
> +    spapr_dt_cpus(fdt, spapr);
>  
>      if (smc->dr_lmb_enabled) {
>          _FDT(spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_LMB));
> @@ -3400,8 +3396,8 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>      addr = spapr_drc_index(drc) * SPAPR_MEMORY_BLOCK_SIZE;
>      node = object_property_get_uint(OBJECT(drc->dev), PC_DIMM_NODE_PROP,
>                                      &error_abort);
> -    *fdt_start_offset = spapr_populate_memory_node(fdt, node, addr,
> -                                                   SPAPR_MEMORY_BLOCK_SIZE);
> +    *fdt_start_offset = spapr_dt_memory_node(fdt, node, addr,
> +                                             SPAPR_MEMORY_BLOCK_SIZE);
>      return 0;
>  }
>  
> @@ -3802,7 +3798,7 @@ int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>      offset = fdt_add_subnode(fdt, 0, nodename);
>      g_free(nodename);
>  
> -    spapr_populate_cpu_dt(cs, fdt, offset, spapr);
> +    spapr_dt_cpu(cs, fdt, offset, spapr);
>  
>      *fdt_start_offset = offset;
>      return 0;
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 0ff6d1aeae..dd003f1763 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -200,8 +200,8 @@ SpaprOptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector)
>      return ov;
>  }
>  
> -int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
> -                           SpaprOptionVector *ov, const char *name)
> +int spapr_dt_ovec(void *fdt, int fdt_offset,
> +                  SpaprOptionVector *ov, const char *name)
>  {
>      uint8_t vec[OV_MAXBYTES + 1];
>      uint16_t vec_len;
> diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
> index 2bed517a2b..d4dee9e06a 100644
> --- a/include/hw/ppc/spapr_ovec.h
> +++ b/include/hw/ppc/spapr_ovec.h
> @@ -72,8 +72,8 @@ void spapr_ovec_set(SpaprOptionVector *ov, long bitnr);
>  void spapr_ovec_clear(SpaprOptionVector *ov, long bitnr);
>  bool spapr_ovec_test(SpaprOptionVector *ov, long bitnr);
>  SpaprOptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector);
> -int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
> -                           SpaprOptionVector *ov, const char *name);
> +int spapr_dt_ovec(void *fdt, int fdt_offset,
> +                  SpaprOptionVector *ov, const char *name);
>  
>  /* migration */
>  extern const VMStateDescription vmstate_spapr_ovec;


