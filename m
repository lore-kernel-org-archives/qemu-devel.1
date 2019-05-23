Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F163C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86FF20868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86FF20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTo7p-0007Dy-21
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:51:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTo4o-00052m-5u
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTo4m-00027y-Ah
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:48:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hTo4m-00026Y-1c; Thu, 23 May 2019 09:48:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32D7CC065135;
	Thu, 23 May 2019 13:47:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BCAE68404;
	Thu, 23 May 2019 13:47:48 +0000 (UTC)
Date: Thu, 23 May 2019 15:47:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190523154743.5fdd4b81@redhat.com>
In-Reply-To: <20190508061726.27631-4-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-4-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 23 May 2019 13:48:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 03/11] numa: move numa global variable
 numa_info into MachineState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com, qemu-ppc@nongnu.org,
	pbonzini@redhat.com, david@gibson.dropbear.id.au, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 May 2019 14:17:18 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> The aim of this patch is to move existing numa global numa_info
> (renamed as "nodes") into NumaState.

s/The aim of this patch is to //

there is repeated pattern you use in patches

  ms->numa_state ? ms->numa_state->FOO : NULL

which might be not justified and plain use of

  ms->numa_state->FOO

would be sufficient.
The places where NULL could be used probably are broken
and should be fixed by not dereferencing
ms->numa_state in the first place.
   

> 
> Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Changes in v4 -> v3:
>     - send the patch together with HMAT patches
> 
> Changes in v3 -> v2:
>     - rename the "NumaState::numa_info" as "NumaState::nodes" (Eduardo)
> ---
>  exec.c                   |  2 +-
>  hw/acpi/aml-build.c      |  6 ++++--
>  hw/arm/boot.c            |  2 +-
>  hw/arm/virt-acpi-build.c |  7 ++++---
>  hw/arm/virt.c            |  1 +
>  hw/i386/pc.c             |  4 ++--
>  hw/ppc/spapr.c           |  8 +++++++-
>  hw/ppc/spapr_pci.c       |  2 ++
>  include/hw/boards.h      | 10 ++++++++++
>  include/sysemu/numa.h    |  8 --------
>  numa.c                   | 15 +++++++++------
>  11 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index c7eb4af42d..0e30926588 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1763,7 +1763,7 @@ long qemu_minrampagesize(void)
>      if (hpsize > mainrampagesize &&
>          (ms->numa_state == NULL ||
>           ms->numa_state->num_nodes == 0 ||
> -         numa_info[0].node_memdev == NULL)) {
> +         ms->numa_state->nodes[0].node_memdev == NULL)) {
>          static bool warned;
>          if (!warned) {
>              error_report("Huge page support disabled (n/a for main memory).");
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index c67f4561a4..b53a55cb56 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1737,8 +1737,10 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
>      build_append_int_noprefix(table_data, nb_numa_nodes, 8);
>      for (i = 0; i < nb_numa_nodes; i++) {
>          for (j = 0; j < nb_numa_nodes; j++) {
> -            assert(numa_info[i].distance[j]);
> -            build_append_int_noprefix(table_data, numa_info[i].distance[j], 1);
> +            assert(ms->numa_state->nodes[i].distance[j]);
> +            build_append_int_noprefix(table_data,
> +                                      ms->numa_state->nodes[i].distance[j],
> +                                      1);
>          }
>      }
>  
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 8ff08814fd..845b737ab9 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -602,7 +602,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>      if (nb_numa_nodes > 0) {
>          mem_base = binfo->loader_start;
>          for (i = 0; i < nb_numa_nodes; i++) {
> -            mem_len = numa_info[i].node_mem;
> +            mem_len = ms->numa_state->nodes[i].node_mem;
in 1/11 I've suggested to add nb_numa_nodes, but it might be to add
a pointer to MachineState there.
It would also help to simplify arm_load_dtb later as there are other 
bits that we copy to arm_boot_info from MachineState.

>              rc = fdt_add_memory_node(fdt, acells, mem_base,
>                                       scells, mem_len, i);
>              if (rc < 0) {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 65f070843c..b22c3d27ad 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -535,11 +535,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>      mem_base = vms->memmap[VIRT_MEM].base;
>      for (i = 0; i < nb_numa_nodes; ++i) {
> -        if (numa_info[i].node_mem > 0) {
> +        if (ms->numa_state->nodes[i].node_mem > 0) {
>              numamem = acpi_data_push(table_data, sizeof(*numamem));
> -            build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
> +            build_srat_memory(numamem, mem_base,
> +                              ms->numa_state->nodes[i].node_mem, i,
>                                MEM_AFFINITY_ENABLED);
> -            mem_base += numa_info[i].node_mem;
> +            mem_base += ms->numa_state->nodes[i].node_mem;
>          }
>      }
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f0818ef597..853caf606f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -232,6 +232,7 @@ static void create_fdt(VirtMachineState *vms)
>          int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
>          uint32_t *matrix = g_malloc0(size);
>          int idx, i, j;
> +        NodeInfo *numa_info = ms->numa_state->nodes;
>  
>          for (i = 0; i < nb_numa_nodes; i++) {
>              for (j = 0; j < nb_numa_nodes; j++) {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 6404ae508e..1c7b2a97bc 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1043,7 +1043,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
>      }
>      for (i = 0; i < nb_numa_nodes; i++) {
>          numa_fw_cfg[pcms->apic_id_limit + 1 + i] =
> -            cpu_to_le64(numa_info[i].node_mem);
> +            cpu_to_le64(ms->numa_state->nodes[i].node_mem);
>      }
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
>                       (1 + pcms->apic_id_limit + nb_numa_nodes) *
> @@ -1685,7 +1685,7 @@ void pc_guest_info_init(PCMachineState *pcms)
>      pcms->node_mem = g_malloc0(pcms->numa_nodes *
>                                      sizeof *pcms->node_mem);
>      for (i = 0; i < nb_numa_nodes; i++) {
> -        pcms->node_mem[i] = numa_info[i].node_mem;
> +        pcms->node_mem[i] = ms->numa_state->nodes[i].node_mem;
>      }
>  
>      pcms->machine_done.notify = pc_machine_done;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4f0a8d4e2e..d577c2025e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -349,6 +349,7 @@ static hwaddr spapr_node0_size(MachineState *machine)
>      int nb_numa_nodes = machine_num_numa_nodes(machine);
>      if (nb_numa_nodes) {
>          int i;
> +        NodeInfo *numa_info = machine->numa_state->nodes;
>          for (i = 0; i < nb_numa_nodes; ++i) {
>              if (numa_info[i].node_mem) {
>                  return MIN(pow2floor(numa_info[i].node_mem),
> @@ -396,7 +397,9 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>      int nb_numa_nodes = machine_num_numa_nodes(machine);
>      hwaddr mem_start, node_size;
>      int i, nb_nodes = nb_numa_nodes;
> -    NodeInfo *nodes = numa_info;
> +    NodeInfo *nodes = machine->numa_state ?

can machine->numa_state actually be NULL?

> +                      machine->numa_state->nodes :
> +                      NULL;
>      NodeInfo ramnode;
>  
>      /* No NUMA nodes, assume there is just one node with whole RAM */
> @@ -2518,6 +2521,9 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
>  {
>      int i;
>      int nb_numa_nodes = machine_num_numa_nodes(machine);
> +    NodeInfo *numa_info = machine->numa_state ?
ditto

> +                          machine->numa_state->nodes :
> +                          NULL;

Also question to PPC folks,
  spapr_validate_node_memory()
seems to be 'broken' in 1 implicit node case since
spapr_populate_memory() 'creates' implicit node info
temporarily but then spapr_validate_node_memory() would use
global nb_numa_nodes which is 0 and skip check.

>  
>      if (machine->ram_size % SPAPR_MEMORY_BLOCK_SIZE) {
>          error_setg(errp, "Memory size 0x" RAM_ADDR_FMT
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 97961b0128..f4e5c0f5b2 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1660,6 +1660,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>      SysBusDevice *s = SYS_BUS_DEVICE(dev);
>      SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
>      PCIHostState *phb = PCI_HOST_BRIDGE(s);
> +    MachineState *ms = MACHINE(spapr);
> +    NodeInfo *numa_info = ms->numa_state ? ms->numa_state->nodes : NULL;
>      char *namebuf;
>      int i;
>      PCIBus *bus;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index c3c678b7ff..777eed4dd9 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -233,12 +233,22 @@ typedef struct DeviceMemoryState {
>      MemoryRegion mr;
>  } DeviceMemoryState;
>  
> +struct NodeInfo {
> +    uint64_t node_mem;
> +    struct HostMemoryBackend *node_memdev;
> +    bool present;
> +    uint8_t distance[MAX_NODES];
> +};
> +
>  typedef struct NumaState {
>      /* Number of NUMA nodes */
>      int num_nodes;
>  
>      /* Allow setting NUMA distance for different NUMA nodes */
>      bool have_numa_distance;
> +
> +    /* NUMA nodes information */
> +    NodeInfo nodes[MAX_NODES];
>  } NumaState;
>  
>  /**
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 1a29408db9..7b8011f9ea 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -6,19 +6,11 @@
>  #include "sysemu/hostmem.h"
>  #include "hw/boards.h"
>  
> -struct NodeInfo {
> -    uint64_t node_mem;
> -    struct HostMemoryBackend *node_memdev;
> -    bool present;
> -    uint8_t distance[MAX_NODES];
> -};
> -
>  struct NumaNodeMem {
>      uint64_t node_mem;
>      uint64_t node_plugged_mem;
>  };
>  
> -extern NodeInfo numa_info[MAX_NODES];
>  void parse_numa_opts(MachineState *ms);
>  void numa_complete_configuration(MachineState *ms);
>  void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
> diff --git a/numa.c b/numa.c
> index d4f5ff5193..ddea376d72 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -52,8 +52,6 @@ static int have_memdevs = -1;
>  static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
>                               * For all nodes, nodeid < max_numa_nodeid
>                               */
> -NodeInfo numa_info[MAX_NODES];
> -
>  
>  static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>                              Error **errp)
> @@ -62,6 +60,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>      uint16_t nodenr;
>      uint16List *cpus = NULL;
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    NodeInfo *numa_info = ms->numa_state->nodes;
>  
>      if (node->has_nodeid) {
>          nodenr = node->nodeid;
> @@ -143,6 +142,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
>      uint16_t src = dist->src;
>      uint16_t dst = dist->dst;
>      uint8_t val = dist->val;
> +    NodeInfo *numa_info = ms->numa_state->nodes;
>  
>      if (src >= MAX_NODES || dst >= MAX_NODES) {
>          error_setg(errp, "Parameter '%s' expects an integer between 0 and %d",
> @@ -201,7 +201,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>              error_setg(&err, "Missing mandatory node-id property");
>              goto end;
>          }
> -        if (!numa_info[object->u.cpu.node_id].present) {
> +        if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
>              error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
>                  "defined with -numa node,nodeid=ID before it's used with "
>                  "-numa cpu,node-id=ID", object->u.cpu.node_id);
> @@ -261,6 +261,7 @@ static void validate_numa_distance(MachineState *ms)
>      int src, dst;
>      bool is_asymmetrical = false;
>      int nb_numa_nodes = machine_num_numa_nodes(ms);
> +    NodeInfo *numa_info = ms->numa_state->nodes;
>  
>      for (src = 0; src < nb_numa_nodes; src++) {
>          for (dst = src; dst < nb_numa_nodes; dst++) {
> @@ -302,6 +303,7 @@ static void complete_init_numa_distance(MachineState *ms)
>  {
>      int src, dst;
>      int nb_numa_nodes = machine_num_numa_nodes(ms);
> +    NodeInfo *numa_info = ms->numa_state->nodes;
>  
>      /* Fixup NUMA distance by symmetric policy because if it is an
>       * asymmetric distance table, it should be a complete table and
> @@ -361,6 +363,7 @@ void numa_complete_configuration(MachineState *ms)
>  {
>      int i;
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    NodeInfo *numa_info = ms->numa_state->nodes;
>  
>      /*
>       * If memory hotplug is enabled (slots > 0) but without '-numa'
> @@ -532,8 +535,8 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
>  
>      memory_region_init(mr, owner, name, ram_size);
>      for (i = 0; i < nb_numa_nodes; i++) {
> -        uint64_t size = numa_info[i].node_mem;
> -        HostMemoryBackend *backend = numa_info[i].node_memdev;
> +        uint64_t size = ms->numa_state->nodes[i].node_mem;
> +        HostMemoryBackend *backend = ms->numa_state->nodes[i].node_memdev;
>          if (!backend) {
>              continue;
>          }
> @@ -599,7 +602,7 @@ void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms)
>  
>      numa_stat_memory_devices(node_mem);
>      for (i = 0; i < ms->numa_state->num_nodes; i++) {
> -        node_mem[i].node_mem += numa_info[i].node_mem;
> +        node_mem[i].node_mem += ms->numa_state->nodes[i].node_mem;
>      }
>  }
>  


