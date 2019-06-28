Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23FDC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A44A205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A44A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrmY-0007yn-Ld
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55198)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hgqwc-0004uE-37
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hgqwU-0006cU-ST
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:29:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hgqwS-0006Zk-PH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:29:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9BAC430BBE97;
 Fri, 28 Jun 2019 11:02:26 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B87E5C644;
 Fri, 28 Jun 2019 11:02:23 +0000 (UTC)
Date: Fri, 28 Jun 2019 13:02:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190628130219.6c98634b@redhat.com>
In-Reply-To: <20190614155626.27932-3-tao3.xu@intel.com>
References: <20190614155626.27932-1-tao3.xu@intel.com>
 <20190614155626.27932-3-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 28 Jun 2019 11:02:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 2/8] numa: move numa global variable
 nb_numa_nodes into MachineState
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
Cc: jingqi.liu@intel.com, fan.du@intel.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 23:56:20 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> Add struct NumaState in MachineState and move existing numa global
> nb_numa_nodes(renamed as "num_nodes") into NumaState. And add variable
> numa_support into MachineClass to decide which submachines support NUMA.
> 
> Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
you are not supposed to keep Reviewed-bys on respin
unless changes that were made are trivial.
(
PS:
 it applies to the whole series
)

> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

In many places you are following pattern: 
  int nb_numa_nodes = ms->numa_state->num_nodes;

even if local variable is only used once or twice within the function.
Pls use ms->numa_state->num_nodes directly instead if it doesn't hurt
readability.

more comments below...
> ---
> 
> Changes in v5 -> v4:
>     - drop the helper machine_num_numa_nodes() and use
>     machine->numa_state->num_nodes directly (Igor)
>     - remove the unnecessary header include (Igor)
> ---
>  exec.c                              |  5 ++-
>  hw/acpi/aml-build.c                 |  3 +-
>  hw/arm/boot.c                       |  4 +-
>  hw/arm/virt-acpi-build.c            |  8 +++-
>  hw/arm/virt.c                       |  5 ++-
>  hw/core/machine.c                   | 14 +++++--
>  hw/i386/acpi-build.c                |  2 +-
>  hw/i386/pc.c                        |  7 +++-
>  hw/mem/pc-dimm.c                    |  2 +
>  hw/pci-bridge/pci_expander_bridge.c |  2 +
>  hw/ppc/spapr.c                      | 19 +++++++---
>  hw/ppc/spapr_pci.c                  |  1 +
>  include/hw/acpi/aml-build.h         |  2 +-
>  include/hw/boards.h                 |  2 +
>  include/sysemu/numa.h               | 13 +++++--
>  monitor.c                           | 11 +++++-
>  numa.c                              | 59 ++++++++++++++++++-----------
>  17 files changed, 112 insertions(+), 47 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 4e734770c2..c7eb4af42d 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1733,6 +1733,7 @@ long qemu_minrampagesize(void)
>      long hpsize = LONG_MAX;
>      long mainrampagesize;
>      Object *memdev_root;
> +    MachineState *ms = MACHINE(qdev_get_machine());
>  
>      mainrampagesize = qemu_mempath_getpagesize(mem_path);
>  
> @@ -1760,7 +1761,9 @@ long qemu_minrampagesize(void)
>       * so if its page size is smaller we have got to report that size instead.
>       */
>      if (hpsize > mainrampagesize &&
> -        (nb_numa_nodes == 0 || numa_info[0].node_memdev == NULL)) {
> +        (ms->numa_state == NULL ||
> +         ms->numa_state->num_nodes == 0 ||
> +         numa_info[0].node_memdev == NULL)) {
>          static bool warned;
>          if (!warned) {
>              error_report("Huge page support disabled (n/a for main memory).");
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 555c24f21d..63c1cae8c9 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1726,10 +1726,11 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>   * ACPI spec 5.2.17 System Locality Distance Information Table
>   * (Revision 2.0 or later)
>   */
> -void build_slit(GArray *table_data, BIOSLinker *linker)
> +void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
>  {
>      int slit_start, i, j;
>      slit_start = table_data->len;
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      acpi_data_push(table_data, sizeof(AcpiTableHeader));
>  
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 30acdbe824..2af881e0f4 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -597,9 +597,9 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>      }
>      g_strfreev(node_path);
>  
> -    if (nb_numa_nodes > 0) {
> +    if (ms->numa_state != NULL && ms->numa_state->num_nodes > 0) {
>          mem_base = binfo->loader_start;
> -        for (i = 0; i < nb_numa_nodes; i++) {
> +        for (i = 0; i < ms->numa_state->num_nodes; i++) {
>              mem_len = numa_info[i].node_mem;
>              rc = fdt_add_memory_node(fdt, acells, mem_base,
>                                       scells, mem_len, i);
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 4a64f9985c..9a22ce679c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -517,7 +517,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      int i, srat_start;
>      uint64_t mem_base;
>      MachineClass *mc = MACHINE_GET_CLASS(vms);
> -    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
> +    MachineState *ms = MACHINE(vms);
> +    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(ms);
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      srat_start = table_data->len;
>      srat = acpi_data_push(table_data, sizeof(*srat));
> @@ -759,6 +761,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      GArray *table_offsets;
>      unsigned dsdt, xsdt;
>      GArray *tables_blob = tables->table_data;
> +    MachineState *ms = MACHINE(vms);
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      table_offsets = g_array_new(false, true /* clear */,
>                                          sizeof(uint32_t));
> @@ -798,7 +802,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          build_srat(tables_blob, tables->linker, vms);
>          if (have_numa_distance) {
>              acpi_add_table(table_offsets, tables_blob);
> -            build_slit(tables_blob, tables->linker);
> +            build_slit(tables_blob, tables->linker, ms);
>          }
>      }
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e2ce7a2841..025ad484c5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -196,6 +196,8 @@ static bool cpu_type_valid(const char *cpu)
>  
>  static void create_fdt(VirtMachineState *vms)
>  {
> +    MachineState *ms = MACHINE(vms);
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>      void *fdt = create_device_tree(&vms->fdt_size);
>  
>      if (!fdt) {
> @@ -1834,7 +1836,7 @@ virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  
>  static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>  {
> -    return idx % nb_numa_nodes;
> +    return idx % ms->numa_state->num_nodes;
>  }
>  
>  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> @@ -1940,6 +1942,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->kvm_type = virt_kvm_type;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
> +    mc->numa_supported = true;
>      hc->plug = virt_machine_device_plug_cb;
>  }
>  
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f1a0f45f9c..14b29de0a9 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -877,6 +877,9 @@ static void machine_initfn(Object *obj)
>                                          NULL);
>      }
>  
> +    if (mc->numa_supported) {
> +        ms->numa_state = g_new0(NumaState, 1);
> +    }
>  
>      /* Register notifier when init is done for sysbus sanity checks */
>      ms->sysbus_notifier.notify = machine_init_notify;
> @@ -897,6 +900,7 @@ static void machine_finalize(Object *obj)
>      g_free(ms->firmware);
>      g_free(ms->device_memory);
>      g_free(ms->nvdimms_state);
> +    g_free(ms->numa_state);
>  }
>  
>  bool machine_usb(MachineState *machine)
> @@ -968,7 +972,7 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
>  
> -    assert(nb_numa_nodes);
> +    assert(machine->numa_state->num_nodes);
>      for (i = 0; i < possible_cpus->len; i++) {
>          if (possible_cpus->cpus[i].props.has_node_id) {
>              break;
> @@ -1014,9 +1018,11 @@ void machine_run_board_init(MachineState *machine)
>  {
>      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>  
> -    numa_complete_configuration(machine);
> -    if (nb_numa_nodes) {
> -        machine_numa_finish_cpu_init(machine);
> +    if (machine_class->numa_supported) {
> +        numa_complete_configuration(machine);
> +        if (machine->numa_state->num_nodes) {
> +            machine_numa_finish_cpu_init(machine);
> +        }
>      }
>  
>      /* If the machine supports the valid_cpu_types check and the user
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 85dc1640bc..0d58335560 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2669,7 +2669,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>          build_srat(tables_blob, tables->linker, machine);
>          if (have_numa_distance) {
>              acpi_add_table(table_offsets, tables_blob);
> -            build_slit(tables_blob, tables->linker);
> +            build_slit(tables_blob, tables->linker, machine);
>          }
>      }
>      if (acpi_get_mcfg(&mcfg)) {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 1b08b56362..5bab78e137 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -997,6 +997,8 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
>      int i;
>      const CPUArchIdList *cpus;
>      MachineClass *mc = MACHINE_GET_CLASS(pcms);
> +    MachineState *ms = MACHINE(pcms);
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
> @@ -1673,6 +1675,8 @@ void pc_machine_done(Notifier *notifier, void *data)
>  void pc_guest_info_init(PCMachineState *pcms)
>  {
>      int i;
> +    MachineState *ms = MACHINE(pcms);
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      pcms->apic_xrupt_override = kvm_allows_irq0_override();
>      pcms->numa_nodes = nb_numa_nodes;
> @@ -2656,7 +2660,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
>     assert(idx < ms->possible_cpus->len);
>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>                              smp_cores, smp_threads, &topo);
> -   return topo.pkg_id % nb_numa_nodes;
> +   return topo.pkg_id % ms->numa_state->num_nodes;
>  }
>  
>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
> @@ -2750,6 +2754,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      nc->nmi_monitor_handler = x86_nmi;
>      mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
>      mc->nvdimm_supported = true;
> +    mc->numa_supported = true;
>  
>      object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
>          pc_machine_get_device_memory_region_size, NULL,
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 152400b1fc..19e7626590 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -160,6 +160,8 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
>  {
>      PCDIMMDevice *dimm = PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      if (!dimm->hostmem) {
>          error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index ca66bc721a..a76a00a6d5 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -211,6 +211,8 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
>      PCIBus *bus;
>      const char *dev_name = NULL;
>      Error *local_err = NULL;
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      if (pxb->numa_node != NUMA_NODE_UNASSIGNED &&
>          pxb->numa_node >= nb_numa_nodes) {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e2b33e5890..07a02db99e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -290,6 +290,8 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
>      CPUState *cs;
>      char cpu_model[32];
>      uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
> +    MachineState *ms = MACHINE(spapr);
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
> @@ -344,6 +346,7 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
>  
>  static hwaddr spapr_node0_size(MachineState *machine)
>  {
> +    int nb_numa_nodes = machine->numa_state->num_nodes;
>      if (nb_numa_nodes) {
>          int i;
>          for (i = 0; i < nb_numa_nodes; ++i) {
> @@ -391,18 +394,18 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *machine = MACHINE(spapr);
>      hwaddr mem_start, node_size;
> -    int i, nb_nodes = nb_numa_nodes;
> +    int i;
>      NodeInfo *nodes = numa_info;
>      NodeInfo ramnode;
>  
>      /* No NUMA nodes, assume there is just one node with whole RAM */
> -    if (!nb_numa_nodes) {
> -        nb_nodes = 1;
> +    if (!machine->numa_state->num_nodes) {
> +        machine->numa_state->num_nodes = 1;
>          ramnode.node_mem = machine->ram_size;
>          nodes = &ramnode;
>      }
>  
> -    for (i = 0, mem_start = 0; i < nb_nodes; ++i) {
> +    for (i = 0, mem_start = 0; i < machine->numa_state->num_nodes; ++i) {
>          if (!nodes[i].node_mem) {
>              continue;
>          }
> @@ -444,6 +447,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>      CPUPPCState *env = &cpu->env;
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
> +    MachineState *ms = MACHINE(spapr);
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>      int index = spapr_get_vcpu_id(cpu);
>      uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
>                         0xffffffff, 0xffffffff};
> @@ -852,6 +857,7 @@ static int spapr_populate_drmem_v1(SpaprMachineState *spapr, void *fdt,
>  static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *machine = MACHINE(spapr);
> +    int nb_numa_nodes = machine->numa_state->num_nodes;
>      int ret, i, offset;
>      uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
>      uint32_t prop_lmb_size[] = {0, cpu_to_be32(lmb_size)};
> @@ -1696,6 +1702,7 @@ static void spapr_machine_reset(void)
>  {
>      MachineState *machine = MACHINE(qdev_get_machine());
>      SpaprMachineState *spapr = SPAPR_MACHINE(machine);
> +    int nb_numa_nodes = machine->numa_state->num_nodes;
>      PowerPCCPU *first_ppc_cpu;
>      uint32_t rtas_limit;
>      hwaddr rtas_addr, fdt_addr;
> @@ -2513,6 +2520,7 @@ static void spapr_create_lmb_dr_connectors(SpaprMachineState *spapr)
>  static void spapr_validate_node_memory(MachineState *machine, Error **errp)
>  {
>      int i;
> +    int nb_numa_nodes = machine->numa_state->num_nodes;
>  
>      if (machine->ram_size % SPAPR_MEMORY_BLOCK_SIZE) {
>          error_setg(errp, "Memory size 0x" RAM_ADDR_FMT
> @@ -4115,7 +4123,7 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
>  
>  static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
>  {
> -    return idx / smp_cores % nb_numa_nodes;
> +    return idx / smp_cores % ms->numa_state->num_nodes;
>  }
>  
>  static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
> @@ -4319,6 +4327,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->update_dt_enabled = true;
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
>      mc->has_hotpluggable_cpus = true;
> +    mc->numa_supported = true;
>      smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path = spapr_get_fw_dev_path;
>      nc->nmi_monitor_handler = spapr_nmi;
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 9cf2c41b8c..d6fd018dd4 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1638,6 +1638,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>      SysBusDevice *s = SYS_BUS_DEVICE(dev);
>      SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
>      PCIHostState *phb = PCI_HOST_BRIDGE(s);
> +    MachineState *ms = MACHINE(spapr);
why do you do it?

>      char *namebuf;
>      int i;
>      PCIBus *bus;
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 1a563ad756..991cf05134 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -414,7 +414,7 @@ build_append_gas_from_struct(GArray *table, const struct AcpiGenericAddress *s)
>  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>                         uint64_t len, int node, MemoryAffinityFlags flags);
>  
> -void build_slit(GArray *table_data, BIOSLinker *linker);
> +void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
>  
>  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>                  const char *oem_id, const char *oem_table_id);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6ff02bf3e4..8375a07940 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -210,6 +210,7 @@ struct MachineClass {
>      bool ignore_boot_device_suffixes;
>      bool smbus_no_migration_support;
>      bool nvdimm_supported;
> +    bool numa_supported;
>  
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                             DeviceState *dev);
> @@ -273,6 +274,7 @@ struct MachineState {
>      AccelState *accelerator;
>      CPUArchIdList *possible_cpus;
>      struct NVDIMMState *nvdimms_state;
> +    struct NumaState *numa_state;
>  };
>  
>  #define DEFINE_MACHINE(namestr, machine_initfn) \
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index b6ac7de43e..3c4b2d2909 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -6,7 +6,6 @@
>  #include "sysemu/hostmem.h"
>  #include "hw/boards.h"
>  
> -extern int nb_numa_nodes;   /* Number of NUMA nodes */
>  extern bool have_numa_distance;
>  
>  struct NodeInfo {
> @@ -16,15 +15,23 @@ struct NodeInfo {
>      uint8_t distance[MAX_NODES];
>  };
>  
> +extern NodeInfo numa_info[MAX_NODES];
> +
random move? 

>  struct NumaNodeMem {
>      uint64_t node_mem;
>      uint64_t node_plugged_mem;
>  };
>  
> -extern NodeInfo numa_info[MAX_NODES];
> +struct NumaState {
> +    /* Number of NUMA nodes */
> +    int num_nodes;
> +
> +};
> +typedef struct NumaState NumaState;
> +
>  void parse_numa_opts(MachineState *ms);
>  void numa_complete_configuration(MachineState *ms);
> -void query_numa_node_mem(NumaNodeMem node_mem[]);
> +void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
>  extern QemuOptsList qemu_numa_opts;
>  void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size);
> diff --git a/monitor.c b/monitor.c
> index 6428eb3b7e..08ef28450e 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1922,14 +1922,21 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
>  
>  static void hmp_info_numa(Monitor *mon, const QDict *qdict)
>  {
> -    int i;
> +    int i, nb_numa_nodes;
>      NumaNodeMem *node_mem;
>      CpuInfoList *cpu_list, *cpu;
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    if (ms->numa_state == NULL) {
> +        monitor_printf(mon, "%d nodes\n", 0);
> +        return;
> +    }
suggest not to duplicate monitor_printf,
something like that:

nb_numa_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
if(!nb_numa_nodes)
  return;


>  
> +    nb_numa_nodes = ms->numa_state->num_nodes;
>      cpu_list = qmp_query_cpus(&error_abort);
>      node_mem = g_new0(NumaNodeMem, nb_numa_nodes);
>  
> -    query_numa_node_mem(node_mem);
> +    query_numa_node_mem(node_mem, ms);
>      monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
>      for (i = 0; i < nb_numa_nodes; i++) {
>          monitor_printf(mon, "node %d cpus:", i);
> diff --git a/numa.c b/numa.c
> index 955ec0c830..d678b71607 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -52,7 +52,6 @@ static int have_memdevs = -1;
>  static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
>                               * For all nodes, nodeid < max_numa_nodeid
>                               */
> -int nb_numa_nodes;
>  bool have_numa_distance;
>  NodeInfo numa_info[MAX_NODES];
>  
> @@ -68,7 +67,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>      if (node->has_nodeid) {
>          nodenr = node->nodeid;
>      } else {
> -        nodenr = nb_numa_nodes;
> +        nodenr = ms->numa_state->num_nodes;
>      }
>  
>      if (nodenr >= MAX_NODES) {
> @@ -136,10 +135,11 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>      }
>      numa_info[nodenr].present = true;
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
> -    nb_numa_nodes++;
> +    ms->numa_state->num_nodes++;
>  }
>  
> -static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
> +static
> +void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
>  {
>      uint16_t src = dist->src;
>      uint16_t dst = dist->dst;
> @@ -178,6 +178,12 @@ static
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>  {
>      Error *err = NULL;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
> +    if (!mc->numa_supported) {
> +        error_setg(errp, "NUMA is not supported by this machine-type");
> +        goto end;
> +    }
>  
>      switch (object->type) {
>      case NUMA_OPTIONS_TYPE_NODE:
> @@ -187,7 +193,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>          }
>          break;
>      case NUMA_OPTIONS_TYPE_DIST:
> -        parse_numa_distance(&object->u.dist, &err);
> +        parse_numa_distance(ms, &object->u.dist, &err);
>          if (err) {
>              goto end;
>          }
> @@ -252,10 +258,11 @@ end:
>   * distance from a node to itself is always NUMA_DISTANCE_MIN,
>   * so providing it is never necessary.
>   */
> -static void validate_numa_distance(void)
> +static void validate_numa_distance(MachineState *ms)
>  {
>      int src, dst;
>      bool is_asymmetrical = false;
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      for (src = 0; src < nb_numa_nodes; src++) {
>          for (dst = src; dst < nb_numa_nodes; dst++) {
> @@ -293,9 +300,10 @@ static void validate_numa_distance(void)
>      }
>  }
>  
> -static void complete_init_numa_distance(void)
> +static void complete_init_numa_distance(MachineState *ms)
>  {
>      int src, dst;
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      /* Fixup NUMA distance by symmetric policy because if it is an
>       * asymmetric distance table, it should be a complete table and
> @@ -369,7 +377,7 @@ void numa_complete_configuration(MachineState *ms)
>       *
>       * Enable NUMA implicitly by adding a new NUMA node automatically.
>       */
> -    if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
> +    if (ms->ram_slots > 0 && ms->numa_state->num_nodes == 0 &&
>          mc->auto_enable_numa_with_memhp) {
>              NumaNodeOptions node = { };
>              parse_numa_node(ms, &node, &error_abort);
> @@ -387,30 +395,33 @@ void numa_complete_configuration(MachineState *ms)
>      }
>  
>      /* This must be always true if all nodes are present: */
> -    assert(nb_numa_nodes == max_numa_nodeid);
> +    assert(ms->numa_state->num_nodes == max_numa_nodeid);
>  
> -    if (nb_numa_nodes > 0) {
> +    if (ms->numa_state->num_nodes > 0) {
>          uint64_t numa_total;
>  
> -        if (nb_numa_nodes > MAX_NODES) {
> -            nb_numa_nodes = MAX_NODES;
> +        if (ms->numa_state->num_nodes > MAX_NODES) {
> +            ms->numa_state->num_nodes = MAX_NODES;
>          }
>  
>          /* If no memory size is given for any node, assume the default case
>           * and distribute the available memory equally across all nodes
>           */
> -        for (i = 0; i < nb_numa_nodes; i++) {
> +        for (i = 0; i < ms->numa_state->num_nodes; i++) {
>              if (numa_info[i].node_mem != 0) {
>                  break;
>              }
>          }
> -        if (i == nb_numa_nodes) {
> +        if (i == ms->numa_state->num_nodes) {
>              assert(mc->numa_auto_assign_ram);
> -            mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
> +            mc->numa_auto_assign_ram(mc,
> +                                     numa_info,
> +                                     ms->numa_state->num_nodes,
> +                                     ram_size);
>          }
>  
>          numa_total = 0;
> -        for (i = 0; i < nb_numa_nodes; i++) {
> +        for (i = 0; i < ms->numa_state->num_nodes; i++) {
>              numa_total += numa_info[i].node_mem;
>          }
>          if (numa_total != ram_size) {
> @@ -434,10 +445,10 @@ void numa_complete_configuration(MachineState *ms)
>           */
>          if (have_numa_distance) {
>              /* Validate enough NUMA distance information was provided. */
> -            validate_numa_distance();
> +            validate_numa_distance(ms);
>  
>              /* Validation succeeded, now fill in any missing distances. */
> -            complete_init_numa_distance();
> +            complete_init_numa_distance(ms);
>          }
>      }
>  }
> @@ -513,14 +524,16 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
>  {
>      uint64_t addr = 0;
>      int i;
> +    MachineState *ms = MACHINE(qdev_get_machine());
>  
> -    if (nb_numa_nodes == 0 || !have_memdevs) {
> +    if (ms->numa_state == NULL ||
> +        ms->numa_state->num_nodes == 0 || !have_memdevs) {
>          allocate_system_memory_nonnuma(mr, owner, name, ram_size);
>          return;
>      }
>  
>      memory_region_init(mr, owner, name, ram_size);
> -    for (i = 0; i < nb_numa_nodes; i++) {
> +    for (i = 0; i < ms->numa_state->num_nodes; i++) {
>          uint64_t size = numa_info[i].node_mem;
>          HostMemoryBackend *backend = numa_info[i].node_memdev;
>          if (!backend) {
> @@ -578,16 +591,16 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>      qapi_free_MemoryDeviceInfoList(info_list);
>  }
>  
> -void query_numa_node_mem(NumaNodeMem node_mem[])
> +void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms)
>  {
>      int i;
>  
> -    if (nb_numa_nodes <= 0) {
> +    if (ms->numa_state == NULL || ms->numa_state->num_nodes <= 0) {
>          return;
>      }
>  
>      numa_stat_memory_devices(node_mem);
> -    for (i = 0; i < nb_numa_nodes; i++) {
> +    for (i = 0; i < ms->numa_state->num_nodes; i++) {
>          node_mem[i].node_mem += numa_info[i].node_mem;
>      }
>  }


