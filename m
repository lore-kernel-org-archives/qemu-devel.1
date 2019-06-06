Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE0FC28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DEE20866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DEE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53747 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYj1j-00086H-JB
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 23:25:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYj0v-0007n8-Ne
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYj0u-0002Jq-4k
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:24:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hYj0s-0002IU-5P
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:24:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E576936893;
	Thu,  6 Jun 2019 03:24:22 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0002E02B;
	Thu,  6 Jun 2019 03:24:20 +0000 (UTC)
Date: Thu, 6 Jun 2019 00:24:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190606032418.GV22416@habkost.net>
References: <20190520165056.175475-1-like.xu@linux.intel.com>
	<20190520165056.175475-2-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520165056.175475-2-like.xu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 06 Jun 2019 03:24:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target/i386: Add cpu die-level
 topology support for X86CPU
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
Cc: Andrew Jones <drjones@redhat.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Peter Crosthwaite <crosthwaite.peter@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Brice Goglin <Brice.Goglin@inria.fr>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 12:50:52AM +0800, Like Xu wrote:
> The die-level as the first PC-specific cpu topology is added to the
> leagcy cpu topology model which only covers sockets/cores/threads.
> 
> In the new model with die-level support, the total number of logical
> processors (including offline) on board will be calculated as:
> 
>      #cpus = #sockets * #dies * #cores * #threads
> 
> and considering compatibility, the default value for #dies is 1.
> 
> A new set of die-related variables are added in smp context and the
> CPUX86State.nr_dies is assigned in x86_cpu_initfn() from PCMachineState.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  hw/i386/pc.c               | 3 +++
>  include/hw/i386/pc.h       | 2 ++
>  include/hw/i386/topology.h | 2 ++
>  qapi/misc.json             | 6 ++++--
>  target/i386/cpu.c          | 9 +++++++++
>  target/i386/cpu.h          | 3 +++
>  6 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 896c22e32e..83ab53c814 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2341,6 +2341,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>          topo.pkg_id = cpu->socket_id;
>          topo.core_id = cpu->core_id;
> +        topo.die_id = cpu->die_id;
>          topo.smt_id = cpu->thread_id;
>          cpu->apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
>      }
> @@ -2692,6 +2693,8 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>                                   ms->smp.cores, ms->smp.threads, &topo);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>          ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
> +        ms->possible_cpus->cpus[i].props.has_die_id = true;
> +        ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
>          ms->possible_cpus->cpus[i].props.has_core_id = true;
>          ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
>          ms->possible_cpus->cpus[i].props.has_thread_id = true;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ce3c22951e..b5faf2ede9 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -24,6 +24,7 @@
>   * PCMachineState:
>   * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
>   * @boot_cpus: number of present VCPUs
> + * @smp_dies: number of dies per one package
>   */
>  struct PCMachineState {
>      /*< private >*/
> @@ -59,6 +60,7 @@ struct PCMachineState {
>      bool apic_xrupt_override;
>      unsigned apic_id_limit;
>      uint16_t boot_cpus;
> +    unsigned smp_dies;
>  
>      /* NUMA information: */
>      uint64_t numa_nodes;
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 1ebaee0f76..7f80498eb3 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -47,6 +47,7 @@ typedef uint32_t apic_id_t;
>  
>  typedef struct X86CPUTopoInfo {
>      unsigned pkg_id;
> +    unsigned die_id;
>      unsigned core_id;
>      unsigned smt_id;
>  } X86CPUTopoInfo;
> @@ -130,6 +131,7 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>      topo->core_id = (apicid >> apicid_core_offset(nr_cores, nr_threads)) &
>                     ~(0xFFFFFFFFUL << apicid_core_width(nr_cores, nr_threads));
>      topo->pkg_id = apicid >> apicid_pkg_offset(nr_cores, nr_threads);
> +    topo->die_id = -1;
>  }
>  
>  /* Make APIC ID for the CPU 'cpu_index'
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..cd236c89b3 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2924,10 +2924,11 @@
>  #
>  # @node-id: NUMA node ID the CPU belongs to
>  # @socket-id: socket number within node/board the CPU belongs to
> -# @core-id: core number within socket the CPU belongs to
> +# @die-id: die number within node/board the CPU belongs to (Since 4.1)
> +# @core-id: core number within die the CPU belongs to
>  # @thread-id: thread number within core the CPU belongs to
>  #
> -# Note: currently there are 4 properties that could be present
> +# Note: currently there are 5 properties that could be present
>  # but management should be prepared to pass through other
>  # properties with device_add command to allow for future
>  # interface extension. This also requires the filed names to be kept in
> @@ -2938,6 +2939,7 @@
>  { 'struct': 'CpuInstanceProperties',
>    'data': { '*node-id': 'int',
>              '*socket-id': 'int',
> +            '*die-id': 'int',
>              '*core-id': 'int',
>              '*thread-id': 'int'
>    }
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9a93dd8be7..9bd35b4965 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -55,6 +55,7 @@
>  #include "hw/xen/xen.h"
>  #include "hw/i386/apic_internal.h"
>  #include "hw/boards.h"
> +#include "hw/i386/pc.h"

Now we have a circular dependency between target/i386/cpu.c and
hw/i386/pc.c.

>  #endif
>  
>  #include "disas/capstone.h"
> @@ -5595,7 +5596,13 @@ static void x86_cpu_initfn(Object *obj)
>      X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
>      CPUX86State *env = &cpu->env;
>      FeatureWord w;
> +#ifndef CONFIG_USER_ONLY
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    PCMachineState *pcms = (PCMachineState *)
> +        object_dynamic_cast(OBJECT(machine), TYPE_PC_MACHINE);
>  
> +    env->nr_dies = pcms ? pcms->smp_dies : 1;

If this is PC-specific, the best place to do it is probably
pc_new_cpu() and pc_cpu_pre_plug().  x86_cpu_initfn() could just
set nr_dies=1 by default.


> +#endif
>      cs->env_ptr = env;
>  
>      object_property_add(obj, "family", "int",
> @@ -5812,11 +5819,13 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, 0),
>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
> +    DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
>  #else
>      DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
> +    DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
>  #endif
>      DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index fce6660bac..d5f2a60ff5 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1361,6 +1361,8 @@ typedef struct CPUX86State {
>      uint64_t xss;
>  
>      TPRAccess tpr_access_type;
> +
> +    unsigned nr_dies;
>  } CPUX86State;
>  
>  struct kvm_msrs;
> @@ -1484,6 +1486,7 @@ struct X86CPU {
>  
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      int32_t socket_id;
> +    int32_t die_id;
>      int32_t core_id;
>      int32_t thread_id;
>  
> -- 
> 2.21.0
> 
> 

-- 
Eduardo

