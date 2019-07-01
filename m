Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B16C06508
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 02:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFCF208CA
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 02:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFCF208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhleS-0006WW-2w
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 22:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36134)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hhldG-00062J-PT
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 22:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hhldE-0004Ey-RC
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 22:01:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:5159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hhldE-0004EL-GR
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 22:01:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jun 2019 19:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,437,1557212400"; d="scan'208";a="174072299"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.241])
 ([10.239.196.241])
 by orsmga002.jf.intel.com with ESMTP; 30 Jun 2019 19:01:21 -0700
To: Igor Mammedov <imammedo@redhat.com>
References: <20190614155626.27932-1-tao3.xu@intel.com>
 <20190614155626.27932-5-tao3.xu@intel.com>
 <20190628132032.49c3ddb8@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <fa1100ea-d35b-2360-8076-2c0c12307fa9@intel.com>
Date: Mon, 1 Jul 2019 10:01:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628132032.49c3ddb8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH v5 4/8] numa: move numa global variable
 numa_info into MachineState
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

On 6/28/2019 7:20 PM, Igor Mammedov wrote:
> On Fri, 14 Jun 2019 23:56:22 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> Move existing numa global numa_info (renamed as "nodes") into NumaState.
>>
>> Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v5 -> v4:
>>      - Directly use ms->numa_state->nodes and not dereferencing
>>      ms->numa_state in the first place when ms->numa_state is possible
>>      NULL (Igor)
> 
> the sa,e like in previous patch,
> use ms->numa_state->nodes directly whenever possible without using
> intermediate local variable
> 
>> ---
>>   exec.c                   |  2 +-
>>   hw/acpi/aml-build.c      |  6 ++++--
>>   hw/arm/boot.c            |  2 +-
>>   hw/arm/virt-acpi-build.c |  7 ++++---
>>   hw/arm/virt.c            |  1 +
>>   hw/i386/pc.c             |  4 ++--
>>   hw/ppc/spapr.c           |  4 +++-
>>   hw/ppc/spapr_pci.c       |  1 +
>>   include/sysemu/numa.h    |  3 +++
>>   numa.c                   | 15 +++++++++------
>>   10 files changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/exec.c b/exec.c
>> index c7eb4af42d..0e30926588 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1763,7 +1763,7 @@ long qemu_minrampagesize(void)
>>       if (hpsize > mainrampagesize &&
>>           (ms->numa_state == NULL ||
>>            ms->numa_state->num_nodes == 0 ||
>> -         numa_info[0].node_memdev == NULL)) {
>> +         ms->numa_state->nodes[0].node_memdev == NULL)) {
>>           static bool warned;
>>           if (!warned) {
>>               error_report("Huge page support disabled (n/a for main memory).");
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 63c1cae8c9..26ccc1a3e2 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1737,8 +1737,10 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
>>       build_append_int_noprefix(table_data, nb_numa_nodes, 8);
>>       for (i = 0; i < nb_numa_nodes; i++) {
>>           for (j = 0; j < nb_numa_nodes; j++) {
>> -            assert(numa_info[i].distance[j]);
>> -            build_append_int_noprefix(table_data, numa_info[i].distance[j], 1);
>> +            assert(ms->numa_state->nodes[i].distance[j]);
>> +            build_append_int_noprefix(table_data,
>> +                                      ms->numa_state->nodes[i].distance[j],
>> +                                      1);
>>           }
>>       }
>>   
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index 2af881e0f4..0c1572d118 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -600,7 +600,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>       if (ms->numa_state != NULL && ms->numa_state->num_nodes > 0) {
>>           mem_base = binfo->loader_start;
>>           for (i = 0; i < ms->numa_state->num_nodes; i++) {
>> -            mem_len = numa_info[i].node_mem;
>> +            mem_len = ms->numa_state->nodes[i].node_mem;
>>               rc = fdt_add_memory_node(fdt, acells, mem_base,
>>                                        scells, mem_len, i);
>>               if (rc < 0) {
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 9d2edd8023..422bbed2d3 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -536,11 +536,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>   
>>       mem_base = vms->memmap[VIRT_MEM].base;
>>       for (i = 0; i < nb_numa_nodes; ++i) {
>> -        if (numa_info[i].node_mem > 0) {
>> +        if (ms->numa_state->nodes[i].node_mem > 0) {
>>               numamem = acpi_data_push(table_data, sizeof(*numamem));
>> -            build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
>> +            build_srat_memory(numamem, mem_base,
>> +                              ms->numa_state->nodes[i].node_mem, i,
>>                                 MEM_AFFINITY_ENABLED);
>> -            mem_base += numa_info[i].node_mem;
>> +            mem_base += ms->numa_state->nodes[i].node_mem;
>>           }
>>       }
>>   
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index d147cceab6..d3904d74dc 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -233,6 +233,7 @@ static void create_fdt(VirtMachineState *vms)
>>           int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
>>           uint32_t *matrix = g_malloc0(size);
>>           int idx, i, j;
>> +        NodeInfo *numa_info = ms->numa_state->nodes;
>>
>>           for (i = 0; i < nb_numa_nodes; i++) {
>>               for (j = 0; j < nb_numa_nodes; j++) {
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 5bab78e137..4cc84c5050 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1041,7 +1041,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
>>       }
>>       for (i = 0; i < nb_numa_nodes; i++) {
>>           numa_fw_cfg[pcms->apic_id_limit + 1 + i] =
>> -            cpu_to_le64(numa_info[i].node_mem);
>> +            cpu_to_le64(ms->numa_state->nodes[i].node_mem);
>>       }
>>       fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
>>                        (1 + pcms->apic_id_limit + nb_numa_nodes) *
>> @@ -1683,7 +1683,7 @@ void pc_guest_info_init(PCMachineState *pcms)
>>       pcms->node_mem = g_malloc0(pcms->numa_nodes *
>>                                       sizeof *pcms->node_mem);
>>       for (i = 0; i < nb_numa_nodes; i++) {
>> -        pcms->node_mem[i] = numa_info[i].node_mem;
>> +        pcms->node_mem[i] = ms->numa_state->nodes[i].node_mem;
>>       }
>>   
>>       pcms->machine_done.notify = pc_machine_done;
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 07a02db99e..3f2e6e0f5f 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -349,6 +349,7 @@ static hwaddr spapr_node0_size(MachineState *machine)
>>       int nb_numa_nodes = machine->numa_state->num_nodes;
>>       if (nb_numa_nodes) {
>>           int i;
>> +        NodeInfo *numa_info = machine->numa_state->nodes;
>>           for (i = 0; i < nb_numa_nodes; ++i) {
>>               if (numa_info[i].node_mem) {
>>                   return MIN(pow2floor(numa_info[i].node_mem),
>> @@ -395,7 +396,7 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>>       MachineState *machine = MACHINE(spapr);
>>       hwaddr mem_start, node_size;
>>       int i;
>> -    NodeInfo *nodes = numa_info;
>> +    NodeInfo *nodes = machine->numa_state->nodes;
>>       NodeInfo ramnode;
>>   
>>       /* No NUMA nodes, assume there is just one node with whole RAM */
>> @@ -2521,6 +2522,7 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
>>   {
>>       int i;
>>       int nb_numa_nodes = machine->numa_state->num_nodes;
>> +    NodeInfo *numa_info = machine->numa_state->nodes;
>>   
>>       if (machine->ram_size % SPAPR_MEMORY_BLOCK_SIZE) {
>>           error_setg(errp, "Memory size 0x" RAM_ADDR_FMT
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index d6fd018dd4..9d4ebd60de 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -1639,6 +1639,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>>       SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
>>       PCIHostState *phb = PCI_HOST_BRIDGE(s);
>>       MachineState *ms = MACHINE(spapr);
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>>       char *namebuf;
>>       int i;
>>       PCIBus *bus;
>> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
>> index 08a86080c4..437eb21fef 100644
>> --- a/include/sysemu/numa.h
>> +++ b/include/sysemu/numa.h
>> @@ -26,6 +26,9 @@ struct NumaState {
>>   
>>       /* Allow setting NUMA distance for different NUMA nodes */
>>       bool have_numa_distance;
>> +
>> +    /* NUMA nodes information */
>> +    NodeInfo nodes[MAX_NODES];
>>   };
>>   typedef struct NumaState NumaState;
> 
> Shouldn't you remove global numa_info var from header as well?
> 
>> diff --git a/numa.c b/numa.c
>> index 9432d42ad0..d23e130bce 100644
>> --- a/numa.c
>> +++ b/numa.c
>> @@ -52,9 +52,6 @@ static int have_memdevs = -1;
>>   static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
>>                                * For all nodes, nodeid < max_numa_nodeid
>>                                */
>> -bool have_numa_distance;
>> -NodeInfo numa_info[MAX_NODES];
>> -
>>   
>>   static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>>                               Error **errp)
>> @@ -63,6 +60,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>>       uint16_t nodenr;
>>       uint16List *cpus = NULL;
>>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>>   
>>       if (node->has_nodeid) {
>>           nodenr = node->nodeid;
>> @@ -144,6 +142,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
>>       uint16_t src = dist->src;
>>       uint16_t dst = dist->dst;
>>       uint8_t val = dist->val;
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>>   
>>       if (src >= MAX_NODES || dst >= MAX_NODES) {
>>           error_setg(errp, "Parameter '%s' expects an integer between 0 and %d",
>> @@ -203,7 +202,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>>               error_setg(&err, "Missing mandatory node-id property");
>>               goto end;
>>           }
>> -        if (!numa_info[object->u.cpu.node_id].present) {
>> +        if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
>>               error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
>>                   "defined with -numa node,nodeid=ID before it's used with "
>>                   "-numa cpu,node-id=ID", object->u.cpu.node_id);
>> @@ -263,6 +262,7 @@ static void validate_numa_distance(MachineState *ms)
>>       int src, dst;
>>       bool is_asymmetrical = false;
>>       int nb_numa_nodes = ms->numa_state->num_nodes;
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>>   
>>       for (src = 0; src < nb_numa_nodes; src++) {
>>           for (dst = src; dst < nb_numa_nodes; dst++) {
>> @@ -304,6 +304,7 @@ static void complete_init_numa_distance(MachineState *ms)
>>   {
>>       int src, dst;
>>       int nb_numa_nodes = ms->numa_state->num_nodes;
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>>   
>>       /* Fixup NUMA distance by symmetric policy because if it is an
>>        * asymmetric distance table, it should be a complete table and
>> @@ -363,6 +364,7 @@ void numa_complete_configuration(MachineState *ms)
>>   {
>>       int i;
>>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>>   
>>       /*
>>        * If memory hotplug is enabled (slots > 0) but without '-numa'
>> @@ -534,8 +536,8 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
>>   
>>       memory_region_init(mr, owner, name, ram_size);
>>       for (i = 0; i < ms->numa_state->num_nodes; i++) {
>> -        uint64_t size = numa_info[i].node_mem;
>> -        HostMemoryBackend *backend = numa_info[i].node_memdev;
>> +        uint64_t size = ms->numa_state->nodes[i].node_mem;
>> +        HostMemoryBackend *backend = ms->numa_state->nodes[i].node_memdev;
>>           if (!backend) {
>>               continue;
>>           }
>> @@ -594,6 +596,7 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>>   void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms)
>>   {
>>       int i;
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
> well, look line below where you care about NULL check and suddenly
> you don't care about it being NULL right above that check.
> 

Thanks. I will correct the mistake here.
>>   
>>       if (ms->numa_state == NULL || ms->numa_state->num_nodes <= 0) {
>>           return;
> 


