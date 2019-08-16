Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47381C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12112206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12112206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hydWx-00057V-7Q
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 10:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1hydW5-0004g7-6U
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hydW3-0002MK-1t
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hydW1-0002JG-4H
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:47:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03562307D931;
 Fri, 16 Aug 2019 14:47:40 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5088B17AB4;
 Fri, 16 Aug 2019 14:47:38 +0000 (UTC)
Date: Fri, 16 Aug 2019 16:47:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190816164736.0b228c06@redhat.com>
In-Reply-To: <24976688-d8f1-4de0-870d-73b96c20c300@intel.com>
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-6-tao3.xu@intel.com>
 <20190813170027.0617b129@redhat.com>
 <24976688-d8f1-4de0-870d-73b96c20c300@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 16 Aug 2019 14:47:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 05/11] numa: Extend CLI to provide
 initiator information for numa nodes
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
 qemu-devel@nongnu.org, daniel@linux.ibm.com, jonathan.cameron@huawei.com,
 dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Aug 2019 10:24:03 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 8/13/2019 11:00 PM, Igor Mammedov wrote:
> > On Fri,  9 Aug 2019 14:57:25 +0800
> > Tao <tao3.xu@intel.com> wrote:
> >   
> >> From: Tao Xu <tao3.xu@intel.com>
> >>
> >> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
> >> The initiator represents processor which access to memory. And in 5.2.27.3
> >> Memory Proximity Domain Attributes Structure, the attached initiator is
> >> defined as where the memory controller responsible for a memory proximity
> >> domain. With attached initiator information, the topology of heterogeneous
> >> memory can be described.
> >>
> >> Extend CLI of "-numa node" option to indicate the initiator numa node-id.
> >> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
> >> the platform's HMAT tables.
> >>
> >> Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
> >> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Tao Xu <tao3.xu@intel.com>

see comments below,

PS:
I'll continue reviewing series in a week when I'm back.

> >> ---
> >>
> >> No changes in v9
> >> ---  
> [...]
> >> +
> >> +    for (i = 0; i < machine->numa_state->num_nodes; i++) {
> >> +        if (numa_info[i].initiator_valid &&
> >> +            !numa_info[numa_info[i].initiator].has_cpu) {  
> >                            ^^^^^^^^^^^^^^^^^^^^^^ possible out of bounds read, see bellow
> >   
> I will add a error "if (numa_info[i].initiator >= MAX_NODES)" when input.

it'd would be better to validate user input instead, at the place pointed below

> >> +            error_report("The initiator-id %"PRIu16 " of NUMA node %d"
> >> +                         " does not exist.", numa_info[i].initiator, i);
> >> +            error_printf("\n");
> >> +
> >> +            exit(1);
> >> +        }  
> > it takes care only about nodes that have cpus or memory-only ones that have
> > initiator explicitly provided on CLI. And leaves possibility to have
> > memory-only nodes without initiator mixed with nodes that have initiator.
> > Is it valid to have mixed configuration?
> > Should we forbid it?
> >   
> Mixed configuration may indeed trigger bug in the future. Because in 
> this patches we default generate HMAT. But mixed configuration situation 
> or without initiator setting will let mem-only node "Flags" field 0, 
> then the Proximity Domain for the Attached Initiator field is not
> valid.
> 
> List are three situations:
> 
> 1) full configuration, just like
> -object memory-backend-ram,size=1G,id=m0 \
> -object memory-backend-ram,size=1G,id=m1 \
> -object memory-backend-ram,size=1G,id=m2 \
> -numa node,nodeid=0,memdev=m0 \
> -numa node,nodeid=1,memdev=m1,initiator=0 \
> -numa node,nodeid=2,memdev=m2,initiator=0
> 
> 2) mixed configuration, just like
> -object memory-backend-ram,size=1G,id=m0 \
> -object memory-backend-ram,size=1G,id=m1 \
> -object memory-backend-ram,size=1G,id=m2 \
> -numa node,nodeid=0,memdev=m0 \
> -numa node,nodeid=1,memdev=m1,initiator=0 \
> -numa node,nodeid=2,memdev=m2
> 
> 3) no configuration, just like
> -object memory-backend-ram,size=1G,id=m0 \
> -object memory-backend-ram,size=1G,id=m1 \
> -object memory-backend-ram,size=1G,id=m2 \
> -numa node,nodeid=0,memdev=m0 \
> -numa node,nodeid=1,memdev=m1 \
> -numa node,nodeid=2,memdev=m2
> 
> I have 3 ideas:
> 
> 1. HMAT option. Add a machine option like "-machine,hmat=yes", then qemu 
> can have HMAT.
I'd go with it. HAMT even if it's broken won't affect anything unless requested by user.
So we could polish impl. and experiment with it with little risk
to break something


> 2. Default setting. The numa without initiator default set numa node 
> which has cpu 0 as initiator.
> 
> 3. Auto setting. intelligent auto configuration like 
> numa_default_auto_assign_ram, auto set initiator of the memory-only 
> nodes averagely.
numa_default_auto_assign_ram is deprecated.
Usually auto_something bites us back long therm
when we need to change related code so we end up with a bunch of
compat code and maintenance burden that introduces.
(the same applies to made up defaults (i.e. non spec dictated)).

> 
> Therefore, there are 2 different solution:
> 
> 1) HMAT option + Default setting
> 
> 2) HMAT option + Auto setting
> 
> >> +    }
> >> +
> >>       if (s->len && !qtest_enabled()) {
> >>           warn_report("CPU(s) not present in any NUMA nodes: %s",
> >>                       s->str);
> >> diff --git a/hw/core/numa.c b/hw/core/numa.c
> >> index 8fcbba05d6..cfb6339810 100644
> >> --- a/hw/core/numa.c
> >> +++ b/hw/core/numa.c
> >> @@ -128,6 +128,19 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
> >>           numa_info[nodenr].node_mem = object_property_get_uint(o, "size", NULL);
> >>           numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
> >>       }
> >> +
> >> +    if (node->has_initiator) {
> >> +        if (numa_info[nodenr].initiator_valid &&
> >> +            (node->initiator != numa_info[nodenr].initiator)) {
> >> +            error_setg(errp, "The initiator of NUMA node %" PRIu16 " has been "
> >> +                       "set to node %" PRIu16, nodenr,
> >> +                       numa_info[nodenr].initiator);
> >> +            return;
> >> +        }
> >> +
> >> +        numa_info[nodenr].initiator_valid = true;
> >> +        numa_info[nodenr].initiator = node->initiator;  
> >                                               ^^^
> > not validated  user input? (which could lead to read beyond numa_info[] boundaries
> > in previous hunk).
> >   
> >> +    }
> >>       numa_info[nodenr].present = true;
> >>       max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
> >>       ms->numa_state->num_nodes++;
> >> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> >> index 76da3016db..46ad06e000 100644
> >> --- a/include/sysemu/numa.h
> >> +++ b/include/sysemu/numa.h
> >> @@ -10,6 +10,9 @@ struct NodeInfo {
> >>       uint64_t node_mem;
> >>       struct HostMemoryBackend *node_memdev;
> >>       bool present;
> >> +    bool has_cpu;
> >> +    bool initiator_valid;
> >> +    uint16_t initiator;
> >>       uint8_t distance[MAX_NODES];
> >>   };
> >>   
> >> diff --git a/qapi/machine.json b/qapi/machine.json
> >> index 6db8a7e2ec..05e367d26a 100644
> >> --- a/qapi/machine.json
> >> +++ b/qapi/machine.json
> >> @@ -414,6 +414,9 @@
> >>   # @memdev: memory backend object.  If specified for one node,
> >>   #          it must be specified for all nodes.
> >>   #
> >> +# @initiator: the initiator numa nodeid that is closest (as in directly
> >> +#             attached) to this numa node (since 4.2)  
> > well, it's pretty unclear what doc comment means (unless reader knows well
> > specific part of ACPI spec)
> > 
> > suggest to rephrase to something more understandable for unaware
> > readers (+ possible reference to spec for those who is interested
> > in spec definition since this doc is meant for developers).
> >   
> >> +#
> >>   # Since: 2.1
> >>   ##
> >>   { 'struct': 'NumaNodeOptions',
> >> @@ -421,7 +424,8 @@
> >>      '*nodeid': 'uint16',
> >>      '*cpus':   ['uint16'],
> >>      '*mem':    'size',
> >> -   '*memdev': 'str' }}
> >> +   '*memdev': 'str',
> >> +   '*initiator': 'uint16' }}
> >>   
> >>   ##
> >>   # @NumaDistOptions:
> >> diff --git a/qemu-options.hx b/qemu-options.hx
> >> index 9621e934c0..c480781992 100644
> >> --- a/qemu-options.hx
> >> +++ b/qemu-options.hx
> >> @@ -161,14 +161,14 @@ If any on the three values is given, the total number of CPUs @var{n} can be omi
> >>   ETEXI
> >>   
> >>   DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> >> -    "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> >> -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> >> +    "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
> >> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
> >>       "-numa dist,src=source,dst=destination,val=distance\n"
> >>       "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
> >>       QEMU_ARCH_ALL)
> >>   STEXI
> >> -@item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> >> -@itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> >> +@item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
> >> +@itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
> >>   @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
> >>   @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
> >>   @findex -numa
> >> @@ -215,6 +215,25 @@ split equally between them.
> >>   @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
> >>   if one node uses @samp{memdev}, all of them have to use it.
> >>   
> >> +@samp{initiator} indicate the initiator NUMA @var{initiator} that is  
> >                                    ^^^^^^^       ^^^^^^^^^^^^^^
> > above will result in "initiator NUMA initiator", was it your intention?
> >   
> >> +closest (as in directly attached) to this NUMA @var{node}.  
> > Again suggest replace spec language with something more user friendly
> > (this time without spec reference as it's geared for end user)
> >   
> >> +For example, the following option assigns 2 NUMA nodes, node 0 has CPU.  
> > Following example creates a machine with 2 NUMA ...
> >   
> >> +node 1 has only memory, and its' initiator is node 0. Note that because
> >> +node 0 has CPU, by default the initiator of node 0 is itself and must be
> >> +itself.
> >> +@example
> >> +-M pc \
> >> +-m 2G,slots=2,maxmem=4G \
> >> +-object memory-backend-ram,size=1G,id=m0 \
> >> +-object memory-backend-ram,size=1G,id=m1 \
> >> +-numa node,nodeid=0,memdev=m0 \
> >> +-numa node,nodeid=1,memdev=m1,initiator=0 \
> >> +-smp 2,sockets=2,maxcpus=2  \
> >> +-numa cpu,node-id=0,socket-id=0 \
> >> +-numa cpu,node-id=0,socket-id=1 \
> >> +@end example
> >> +
> >>   @var{source} and @var{destination} are NUMA node IDs.
> >>   @var{distance} is the NUMA distance from @var{source} to @var{destination}.
> >>   The distance from a node to itself is always 10. If any pair of nodes is  
> >   
> 
> 


