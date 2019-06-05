Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A904DC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6030E20665
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6030E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXCS-0008T4-HH
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:47:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYX61-0002r5-Ib
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYX5z-0004oF-M7
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:40:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hYX5z-0004mO-D1
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:40:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2226831628FF;
	Wed,  5 Jun 2019 14:40:54 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14A0F601B6;
	Wed,  5 Jun 2019 14:40:49 +0000 (UTC)
Date: Wed, 5 Jun 2019 16:40:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190605164045.12bf194c@redhat.com>
In-Reply-To: <20190508061726.27631-9-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-9-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 05 Jun 2019 14:40:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 08/11] numa: Extend the command-line to
 provide memory latency and bandwidth information
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
	qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 May 2019 14:17:23 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
> 
> Add -numa hmat-lb option to provide System Locality Latency and
> Bandwidth Information. These memory attributes help to build
> System Locality Latency and Bandwidth Information Structure(s)
> in ACPI Heterogeneous Memory Attribute Table (HMAT).
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Changes in v4 -> v3:
>     - update the version tag from 4.0 to 4.1
> ---
>  numa.c          | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json  |  94 ++++++++++++++++++++++++++++++++++-
>  qemu-options.hx |  28 ++++++++++-
>  3 files changed, 246 insertions(+), 3 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 71b0aee02a..1aecb7a2e9 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -40,6 +40,7 @@
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
> +#include "hw/acpi/hmat.h"
>  
>  QemuOptsList qemu_numa_opts = {
>      .name = "numa",
> @@ -179,6 +180,126 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
>      ms->numa_state->have_numa_distance = true;
>  }
>  
> +static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
> +                               Error **errp)
> +{
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
> +    NodeInfo *numa_info = ms->numa_state->nodes;
> +    HMAT_LB_Info *hmat_lb = NULL;
> +
> +    if (node->data_type <= HMATLB_DATA_TYPE_WRITE_LATENCY) {
> +        if (!node->has_latency) {
> +            error_setg(errp, "Missing 'latency' option.");
> +            return;
> +        }
> +        if (node->has_bandwidth) {
> +            error_setg(errp, "Invalid option 'bandwidth' since "
> +                       "the data type is latency.");
> +            return;
> +        }
> +        if (node->has_base_bw) {
> +            error_setg(errp, "Invalid option 'base_bw' since "
> +                       "the data type is latency.");
> +            return;
> +        }
> +    }
> +
> +    if (node->data_type >= HMATLB_DATA_TYPE_ACCESS_BANDWIDTH) {
> +        if (!node->has_bandwidth) {
> +            error_setg(errp, "Missing 'bandwidth' option.");
> +            return;
> +        }
> +        if (node->has_latency) {
> +            error_setg(errp, "Invalid option 'latency' since "
> +                       "the data type is bandwidth.");
> +            return;
> +        }
> +        if (node->has_base_lat) {
> +            error_setg(errp, "Invalid option 'base_lat' since "
> +                       "the data type is bandwidth.");
> +            return;
> +        }
> +    }
> +
> +    if (node->initiator >= nb_numa_nodes) {
> +        error_setg(errp, "Invalid initiator=%"
> +                   PRIu16 ", it should be less than %d.",
> +                   node->initiator, nb_numa_nodes);
> +        return;
> +    }
> +    if (!numa_info[node->initiator].is_initiator) {
> +        error_setg(errp, "Invalid initiator=%"
> +                   PRIu16 ", it isn't an initiator proximity domain.",
> +                   node->initiator);
> +        return;
> +    }
> +
> +    if (node->target >= nb_numa_nodes) {
> +        error_setg(errp, "Invalid initiator=%"
Shouldn't it be 'target' here

> +                   PRIu16 ", it should be less than %d.",
> +                   node->target, nb_numa_nodes);
> +        return;
> +    }
> +    if (!numa_info[node->target].is_target) {
> +        error_setg(errp, "Invalid target=%"
> +                   PRIu16 ", it isn't a target proximity domain.",
> +                   node->target);
> +        return;
> +    }
> +
> +    if (node->has_latency) {
> +        hmat_lb = ms->numa_state->hmat_lb[node->hierarchy][node->data_type];
> +
> +        if (!hmat_lb) {
> +            hmat_lb = g_malloc0(sizeof(*hmat_lb));
> +            ms->numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
> +        } else if (hmat_lb->latency[node->initiator][node->target]) {
> +            error_setg(errp, "Duplicate configuration of the latency for "
> +                       "initiator=%" PRIu16 " and target=%" PRIu16 ".",
> +                       node->initiator, node->target);
> +            return;
> +        }
> +
> +        /* Only the first time of setting the base unit is valid. */
> +        if ((hmat_lb->base_lat == 0) && (node->has_base_lat)) {
> +            hmat_lb->base_lat = node->base_lat;
> +        }
> +
> +        hmat_lb->latency[node->initiator][node->target] = node->latency;
> +    }
> +
> +    if (node->has_bandwidth) {
> +        hmat_lb = ms->numa_state->hmat_lb[node->hierarchy][node->data_type];
> +
> +        if (!hmat_lb) {
> +            hmat_lb = g_malloc0(sizeof(*hmat_lb));
> +            ms->numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
> +        } else if (hmat_lb->bandwidth[node->initiator][node->target]) {
> +            error_setg(errp, "Duplicate configuration of the bandwidth for "
> +                       "initiator=%" PRIu16 " and target=%" PRIu16 ".",
> +                       node->initiator, node->target);
> +            return;
> +        }
> +
> +        /* Only the first time of setting the base unit is valid. */
> +        if (hmat_lb->base_bw == 0) {
> +            if (!node->has_base_bw) {
> +                error_setg(errp, "Missing 'base-bw' option");
> +                return;
> +            } else {
> +                hmat_lb->base_bw = node->base_bw;
> +            }
> +        }
> +
> +        hmat_lb->bandwidth[node->initiator][node->target] = node->bandwidth;
> +    }
> +
> +    if (hmat_lb) {
> +        hmat_lb->hierarchy = node->hierarchy;
> +        hmat_lb->data_type = node->data_type;
> +    }
> +}
> +
>  static
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>  {
> @@ -217,6 +338,12 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>          machine_set_cpu_numa_node(ms, qapi_NumaCpuOptions_base(&object->u.cpu),
>                                    &err);
>          break;
> +    case NUMA_OPTIONS_TYPE_HMAT_LB:
> +        parse_numa_hmat_lb(ms, &object->u.hmat_lb, &err);
> +        if (err) {
> +            goto end;
> +        }
> +        break;
>      default:
>          abort();
>      }
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..d7fce75702 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2539,10 +2539,12 @@
>  #
>  # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>  #
> +# @hmat-lb: memory latency and bandwidth information (Since: 4.1)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu' ] }
> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
>  
>  ##
>  # @NumaOptions:
> @@ -2557,7 +2559,8 @@
>    'data': {
>      'node': 'NumaNodeOptions',
>      'dist': 'NumaDistOptions',
> -    'cpu': 'NumaCpuOptions' }}
> +    'cpu': 'NumaCpuOptions',
> +    'hmat-lb': 'NumaHmatLBOptions' }}
>  
>  ##
>  # @NumaNodeOptions:
> @@ -2620,6 +2623,93 @@
>     'base': 'CpuInstanceProperties',
>     'data' : {} }
>  
> +##
> +# @HmatLBMemoryHierarchy:
> +#
> +# The memory hierarchy in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT (Heterogeneous
> +# Memory Attribute Table)
> +#
> +# @memory: the structure represents the memory performance
> +#
> +# @last-level: last level memory of memory side cached memory
> +#
> +# @first-level: first level memory of memory side cached memory
> +#
> +# @second-level: second level memory of memory side cached memory
> +#
> +# @third-level: third level memory of memory side cached memory
> +#
> +# Since: 4.1
> +##
> +{ 'enum': 'HmatLBMemoryHierarchy',
> +  'data': [ 'memory', 'last-level', 'first-level',
> +            'second-level', 'third-level' ] }
> +
> +##
> +# @HmatLBDataType:
> +#
> +# Data type in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT (Heterogeneous
> +# Memory Attribute Table)
> +#
> +# @access-latency: access latency (nanoseconds)
> +#
> +# @read-latency: read latency (nanoseconds)
> +#
> +# @write-latency: write latency (nanoseconds)
> +#
> +# @access-bandwidth: access bandwidth (MB/s)
> +#
> +# @read-bandwidth: read bandwidth (MB/s)
> +#
> +# @write-bandwidth: write bandwidth (MB/s)
> +#
> +# Since: 4.1
> +##
> +{ 'enum': 'HmatLBDataType',
> +  'data': [ 'access-latency', 'read-latency', 'write-latency',
> +            'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] }
> +
> +##
> +# @NumaHmatLBOptions:
> +#
> +# Set the system locality latency and bandwidth information
> +# between Initiator and Target proximity Domains.
> +#
> +# @initiator: the Initiator Proximity Domain.
> +#
> +# @target: the Target Proximity Domain.
> +#
> +# @hierarchy: the Memory Hierarchy. Indicates the performance
> +#             of memory or side cache.
> +#
> +# @data-type: presents the type of data, access/read/write
> +#             latency or hit latency.
> +#
> +# @base-lat: the base unit for latency in nanoseconds.
> +#
> +# @base-bw: the base unit for bandwidth in megabytes per second(MB/s).
> +#
> +# @latency: the value of latency based on Base Unit from @initiator
> +#           to @target proximity domain.
> +#
> +# @bandwidth: the value of bandwidth based on Base Unit between
> +#             @initiator and @target proximity domain.
> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'NumaHmatLBOptions',
> +  'data': {
> +   'initiator': 'uint16',
> +   'target': 'uint16',
> +   'hierarchy': 'HmatLBMemoryHierarchy',
> +   'data-type': 'HmatLBDataType',
I think union will be better here with data-type used as discriminator,
on top of that you'll be able to drop a bit of error checking above since
QAPI's union will not allow user to mix latency and bandwidth.

> +   '*base-lat': 'uint64',
> +   '*base-bw': 'uint64',
> +   '*latency': 'uint16',
> +   '*bandwidth': 'uint16' }}
> +
>  ##
>  # @HostMemPolicy:
>  #
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 51802cbb26..5351b0e453 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -163,16 +163,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
>      "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
>      "-numa dist,src=source,dst=destination,val=distance\n"
> -    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
> +    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
> +    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|last-level,data-type=access-latency|read-latency|write-latency[,base-lat=blat][,base-bw=bbw][,latency=lat][,bandwidth=bw]\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
>  @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
>  @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
>  @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
> +@itemx -numa hmat-lb,initiator=@var{node},target=@var{node},hierarchy=@var{str},data-type=@var{str}[,base-lat=@var{blat}][,base-bw=@var{bbw}][,latency=@var{lat}][,bandwidth=@var{bw}]
>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
>  Set the NUMA distance from a source node to a destination node.
> +Set the ACPI Heterogeneous Memory Attribute for the given nodes.

s/Attribute/Attributes/

>  
>  Legacy VCPU assignment uses @samp{cpus} option where
>  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
> @@ -230,6 +233,29 @@ specified resources, it just assigns existing resources to NUMA
>  nodes. This means that one still has to use the @option{-m},
>  @option{-smp} options to allocate RAM and VCPUs respectively.
>  
> +Use 'hmat-lb' to set System Locality Latency and Bandwidth Information
> +between initiator NUMA node and target NUMA node to build ACPI Heterogeneous Attribute Memory Table (HMAT).
s/ initiator NUMA node and target NUMA node .*\./
initiator and target NUMA nodes in ACPI Heterogeneous Attribute Memory Table (HMAT)./

Also I don't see any description of possible values/units


> +Initiator NUMA node can create memory requests, usually including one or more processors.
> +Target NUMA node contains addressable memory.
> +
> +For example:
> +@example
> +-m 2G \
> +-smp 3,sockets=2,maxcpus=3 \
> +-numa node,cpus=0-1,nodeid=0 \
> +-numa node,mem=1G,cpus=2,nodeid=1 \
> +-numa node,mem=1G,nodeid=2 \

pls use '-numa cpu' and '-numa memdev' instead of legacy 'cpus/mem' options in examples.

> +-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,base-bw=20,latency=10,bandwidth=10 \
> +-numa hmat-lb,initiator=1,target=2,hierarchy=first-level,data-type=access-latency,base-bw=10,bandwidth=20
> +@end example
> +
> +When the processors in NUMA node 0 access memory in NUMA node 1,
> +the first line containing 'hmat-lb' sets the latency and bandwidth information.
What does it set "FOO information" for?

> +The latency is @var{lat} multiplied by @var{blat} and the bandwidth is @var{bw} multiplied by @var{bbw}.
that's rather cryptic and probably not necessary at all.

> +
> +When the processors in NUMA node 1 access memory in NUMA node 2 that acts as 2nd level memory side cache,
> +the second line containing 'hmat-lb' sets the access hit bandwidth information.
> +
>  ETEXI
>  
>  DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,


