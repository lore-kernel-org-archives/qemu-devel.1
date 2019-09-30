Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13689C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 11:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0C0206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 11:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0C0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEtpJ-0000dr-SG
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 07:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iEtoD-00008K-I1
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 07:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iEto9-0003h7-Hb
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 07:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iEto9-0003gd-98
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 07:25:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E7F810DCC8A;
 Mon, 30 Sep 2019 11:25:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8AE562A8B;
 Mon, 30 Sep 2019 11:25:31 +0000 (UTC)
Date: Mon, 30 Sep 2019 13:25:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v12 05/11] numa: Extend CLI to provide initiator
 information for numa nodes
Message-ID: <20190930132530.64c40493@redhat.com>
In-Reply-To: <20190920074349.2616-6-tao3.xu@intel.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
 <20190920074349.2616-6-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 30 Sep 2019 11:25:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 15:43:43 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
> The initiator represents processor which access to memory. And in 5.2.27.3
> Memory Proximity Domain Attributes Structure, the attached initiator is
> defined as where the memory controller responsible for a memory proximity
> domain. With attached initiator information, the topology of heterogeneous
> memory can be described.
> 
> Extend CLI of "-numa node" option to indicate the initiator numa node-id.
> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
> the platform's HMAT tables.
> 
> Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Changes in v12:
>     - Fix the bug that a memory-only node without initiator setting
>       doesn't report error. (reported by Danmei Wei)
> 
> No changes in v11.
> 
> Changes in v10:
>     - Add machine oprion properties "-machine hmat=on|off" for enabling
>       or disabling HMAT in QEMU.
>     - Add more description for initiator option.
>     - Report error then HMAT is enable and initiator option is missing.
>       Not allow invaild initiator now. (Igor)
> ---
>  hw/core/machine.c     | 71 +++++++++++++++++++++++++++++++++++++++++++
>  hw/core/numa.c        | 24 +++++++++++++++
>  include/sysemu/numa.h |  6 ++++
>  qapi/machine.json     | 10 +++++-
>  qemu-options.hx       | 35 ++++++++++++++++++---
>  5 files changed, 140 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1689ad3bf8..087baaf571 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -518,6 +518,20 @@ static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
>      ms->nvdimms_state->is_enabled = value;
>  }
>  
> +static bool machine_get_hmat(Object *obj, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    return ms->numa_state->hmat_enabled;
> +}
> +
> +static void machine_set_hmat(Object *obj, bool value, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    ms->numa_state->hmat_enabled = value;
> +}
> +
>  static char *machine_get_nvdimm_persistence(Object *obj, Error **errp)
>  {
>      MachineState *ms = MACHINE(obj);
> @@ -645,6 +659,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
>                                 const CpuInstanceProperties *props, Error **errp)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    NodeInfo *numa_info = machine->numa_state->nodes;
>      bool match = false;
>      int i;
>  
> @@ -714,6 +729,16 @@ void machine_set_cpu_numa_node(MachineState *machine,
>          match = true;
>          slot->props.node_id = props->node_id;
>          slot->props.has_node_id = props->has_node_id;
> +
> +        if (numa_info[props->node_id].initiator_valid &&
> +            (props->node_id != numa_info[props->node_id].initiator)) {
> +            error_setg(errp, "The initiator of CPU NUMA node %" PRId64
> +                       " should be itself.", props->node_id);
> +            return;
> +        }
> +        numa_info[props->node_id].initiator_valid = true;
> +        numa_info[props->node_id].has_cpu = true;
> +        numa_info[props->node_id].initiator = props->node_id;
>      }
>  
>      if (!match) {
> @@ -960,6 +985,13 @@ static void machine_initfn(Object *obj)
>  
>      if (mc->numa_mem_supported) {
>          ms->numa_state = g_new0(NumaState, 1);
> +        object_property_add_bool(obj, "hmat",
> +                                 machine_get_hmat, machine_set_hmat,
> +                                 &error_abort);
> +        object_property_set_description(obj, "hmat",
> +                                        "Set on/off to enable/disable "
> +                                        "ACPI Heterogeneous Memory Attribute "
> +                                        "Table (HMAT)", NULL);
>      }
>  
>      /* Register notifier when init is done for sysbus sanity checks */
> @@ -1048,6 +1080,40 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
>      return g_string_free(s, false);
>  }
>  
> +static void numa_validate_initiator(NumaState *nstat)
> +{
> +    int i;
> +    NodeInfo *numa_info = nstat->nodes;
> +
> +    for (i = 0; i < nstat->num_nodes; i++) {
> +        if (numa_info[i].initiator == MAX_NODES) {
> +            error_report("The initiator of NUMA node %d is missing, use "
> +                         "'-numa node,initiator' option to declare it.", i);
> +            goto err;
> +        }
> +
> +        if (!numa_info[numa_info[i].initiator].present) {
> +            error_report("NUMA node %" PRIu16 " is missing, use "
> +                         "'-numa node' option to declare it first.",
> +                         numa_info[i].initiator);
> +            goto err;
> +        }
> +
> +        if (numa_info[numa_info[i].initiator].has_cpu) {
> +            numa_info[i].initiator_valid = true;
> +        } else {
> +            error_report("The initiator of NUMA node %d is invalid.", i);
> +            goto err;
> +        }
> +    }
> +
> +    return;
> +
> +err:
> +    error_printf("\n");
> +    exit(1);
> +}
> +
>  static void machine_numa_finish_cpu_init(MachineState *machine)
>  {
>      int i;
> @@ -1088,6 +1154,11 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
>              machine_set_cpu_numa_node(machine, &props, &error_fatal);
>          }
>      }
> +
> +    if (machine->numa_state->hmat_enabled) {
> +        numa_validate_initiator(machine->numa_state);
> +    }
> +
>      if (s->len && !qtest_enabled()) {
>          warn_report("CPU(s) not present in any NUMA nodes: %s",
>                      s->str);
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 4dfec5c95b..eff5491f6f 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -133,6 +133,30 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          numa_info[nodenr].node_mem = object_property_get_uint(o, "size", NULL);
>          numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
>      }
> +
I'd put here
   /* ... */
   numa_info[nodenr].initiator = MAX_NODES;

and drop "else if" below, so initiator would be always invalid unless it was set.
If you do that then you probably can get rid of "initiator_valid" field
since "initiator < MAX_NODES" can do to the same


> +    if (node->has_initiator) {
> +        if (!ms->numa_state->hmat_enabled) {
> +            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table "
> +                       "(HMAT) is disabled, use -machine hmat=on before "
> +                       "set initiator of NUMA");
> +            return;
> +        }
> +
> +        if (node->initiator >= MAX_NODES) {
> +            error_report("The initiator id %" PRIu16 " expects an integer "
> +                         "between 0 and %d", node->initiator,
> +                         MAX_NODES - 1);
> +            return;
> +        }
> +
> +        numa_info[nodenr].initiator = node->initiator;
> +    } else if (ms->numa_state->hmat_enabled) {
> +        /*
> +         * If not set the initiator, set it to MAX_NODES. And if
> +         * HMAT is enabled and this node has no cpus, QEMU will raise error.
> +         */
> +        numa_info[nodenr].initiator = MAX_NODES;
> +    }
>      numa_info[nodenr].present = true;
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
>      ms->numa_state->num_nodes++;
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index ae9c41d02b..a788c3b126 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -18,6 +18,9 @@ struct NodeInfo {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
>      bool present;
> +    bool has_cpu;
> +    bool initiator_valid;
> +    uint16_t initiator;
>      uint8_t distance[MAX_NODES];
>  };
>  
> @@ -33,6 +36,9 @@ struct NumaState {
>      /* Allow setting NUMA distance for different NUMA nodes */
>      bool have_numa_distance;
>  
> +    /* Detect if HMAT support is enabled. */
> +    bool hmat_enabled;
> +
>      /* NUMA nodes information */
>      NodeInfo nodes[MAX_NODES];
>  };
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ca26779f1a..3c2914cd1c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -463,6 +463,13 @@
>  # @memdev: memory backend object.  If specified for one node,
>  #          it must be specified for all nodes.
>  #
> +# @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145,
> +#             indicate the nodeid which has the memory controller
s/indicate/indicates/
or even better 'points to'


> +#             responsible for this NUMA node. This field provides
> +#             additional information as to the initiator node that
> +#             is closest (as in directly attached) to this node, and
> +#             therefore has the best performance (since 4.2)
> +#
>  # Since: 2.1
>  ##
>  { 'struct': 'NumaNodeOptions',
> @@ -470,7 +477,8 @@
>     '*nodeid': 'uint16',
>     '*cpus':   ['uint16'],
>     '*mem':    'size',
> -   '*memdev': 'str' }}
> +   '*memdev': 'str',
> +   '*initiator': 'uint16' }}
>  
>  ##
>  # @NumaDistOptions:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index bbfd936d29..74ccc4d782 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
>      "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>      "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
> -    "                memory-encryption=@var{} memory encryption object to use (default=none)\n",
> +    "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
> +    "                hmat=on|off controls ACPI HMAT support (default=off)\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
> @@ -103,6 +104,9 @@ NOTE: this parameter is deprecated. Please use @option{-global}
>  @option{migration.send-configuration}=@var{on|off} instead.
>  @item memory-encryption=@var{}
>  Memory encryption object to use. The default is none.
> +@item hmat=on|off
> +Enables or disables ACPI Heterogeneous Memory Attribute Table (HMAT) support.
> +The default is off.
>  @end table
>  ETEXI
>  
> @@ -161,14 +165,14 @@ If any on the three values is given, the total number of CPUs @var{n} can be omi
>  ETEXI
>  
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> -    "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> +    "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
>      "-numa dist,src=source,dst=destination,val=distance\n"
>      "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
>      QEMU_ARCH_ALL)
>  STEXI
> -@item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> -@itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> +@item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
> +@itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
>  @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
>  @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
>  @findex -numa
> @@ -215,6 +219,27 @@ split equally between them.
>  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
>  if one node uses @samp{memdev}, all of them have to use it.
>  
> +@samp{initiator} is an additional option indicate the @var{initiator}
s/indicate/that point to/

s/the/an/


> +NUMA that has best performance (the lowest latency or largest bandwidth)
s/NUMA/NUMA node/

> +to this NUMA @var{node}. Note that this option can be set only when
> +the machine oprion properties "-machine hmat=on".
I'd write it as:
 the machine property 'hmat' is set to 'on'

> +
> +Following example creates a machine with 2 NUMA nodes, node 0 has CPU.
> +node 1 has only memory, and its' initiator is node 0. Note that because
s/its' initiator/its initiator node/

> +node 0 has CPU, by default the initiator of node 0 is itself and must be
> +itself.
> +@example
> +-machine hmat=on \
> +-m 2G,slots=2,maxmem=4G \
> +-object memory-backend-ram,size=1G,id=m0 \
> +-object memory-backend-ram,size=1G,id=m1 \
> +-numa node,nodeid=0,memdev=m0 \
> +-numa node,nodeid=1,memdev=m1,initiator=0 \
> +-smp 2,sockets=2,maxcpus=2  \
> +-numa cpu,node-id=0,socket-id=0 \
> +-numa cpu,node-id=0,socket-id=1
> +@end example
> +
>  @var{source} and @var{destination} are NUMA node IDs.
>  @var{distance} is the NUMA distance from @var{source} to @var{destination}.
>  The distance from a node to itself is always 10. If any pair of nodes is


