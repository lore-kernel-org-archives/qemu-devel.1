Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0663C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5692465B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdvmLjv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5692465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTlL-0000yy-O7
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iwTin-000768-4P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iwTil-0002rm-Fc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:28:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iwTil-0002rf-BE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580228891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9j6sTfAlZklDFUka2MpmGteiS+iu7ip1gVm0wbZm7c=;
 b=DdvmLjv87j+QtYdQ8YuMAx17gTr+EOz1HEofHDYclynH4M3CXUo1Qm12ZV6duTbBL1Mfwd
 o2G9s3w3Ci/zw5mDSC4sts0SJNxLMi1BWDxKhkZn8J/kqOMpVVBeQxmDRkJzvD7LPy66ue
 HYx7SwkDfNDt14GhFbKpRStUhejP6Yc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-HzMksvi-N4CHweUqHVyCOw-1; Tue, 28 Jan 2020 11:28:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A764E184BBD9;
 Tue, 28 Jan 2020 16:28:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E3598E60C;
 Tue, 28 Jan 2020 16:28:01 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:27:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 06/18] hw/core: Add core complex id in X86CPU topology
Message-ID: <20200128172759.5215414b@redhat.com>
In-Reply-To: <157541985531.46157.16935250205964640126.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541985531.46157.16935250205964640126.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: HzMksvi-N4CHweUqHVyCOw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 03 Dec 2019 18:37:35 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Introduce last level cache id(llc_id) in x86CPU topology.  This information is
> required to build the topology in EPIC mode.
can you add a reference to spec here so one could look for
detailed information about this?

 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/core/machine-hmp-cmds.c |    3 +++
>  hw/core/machine.c          |   13 +++++++++++++
>  hw/i386/pc.c               |   10 ++++++++++
>  include/hw/i386/topology.h |    1 +
>  qapi/machine.json          |    7 +++++--
>  target/i386/cpu.c          |    2 ++
>  target/i386/cpu.h          |    1 +
>  7 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index cd970cc4c5..59c91d1ce1 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -90,6 +90,9 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
>          if (c->has_die_id) {
>              monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
>          }
> +        if (c->has_llc_id) {
> +            monitor_printf(mon, "    llc-id: \"%" PRIu64 "\"\n", c->llc_id);
> +        }
>          if (c->has_core_id) {
>              monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
>          }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index e59b181ead..ff991e6ab5 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -683,6 +683,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
>              return;
>          }
>  
> +        if (props->has_llc_id && !slot->props.has_llc_id) {
> +            error_setg(errp, "llc-id is not supported");
> +            return;
> +        }
> +
>          /* skip slots with explicit mismatch */
>          if (props->has_thread_id && props->thread_id != slot->props.thread_id) {
>                  continue;
> @@ -696,6 +701,10 @@ void machine_set_cpu_numa_node(MachineState *machine,
>                  continue;
>          }
>  
> +        if (props->has_llc_id && props->llc_id != slot->props.llc_id) {
> +                continue;
> +        }
> +
>          if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
>                  continue;
>          }
> @@ -1034,6 +1043,10 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
>      if (cpu->props.has_die_id) {
>          g_string_append_printf(s, "die-id: %"PRId64, cpu->props.die_id);
>      }
> +
> +    if (cpu->props.has_llc_id) {
> +        g_string_append_printf(s, "llc-id: %"PRId64, cpu->props.llc_id);
> +    }
>      if (cpu->props.has_core_id) {
>          if (s->len) {
>              g_string_append_printf(s, ", ");
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 17de152a77..df5339c102 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2294,6 +2294,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>          topo_ids.pkg_id = cpu->socket_id;
>          topo_ids.die_id = cpu->die_id;
> +        topo_ids.llc_id = cpu->llc_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
>          cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
> @@ -2339,6 +2340,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      }
>      cpu->die_id = topo_ids.die_id;
>  
> +    if (cpu->llc_id != -1 && cpu->llc_id != topo_ids.llc_id) {
> +        error_setg(errp, "property llc-id: %u doesn't match set apic-id:"
> +            " 0x%x (llc-id: %u)", cpu->llc_id, cpu->apic_id, topo_ids.llc_id);
> +        return;
> +    }
> +    cpu->llc_id = topo_ids.llc_id;
> +
>      if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
>          error_setg(errp, "property core-id: %u doesn't match set apic-id:"
>              " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo_ids.core_id);
> @@ -2752,6 +2760,8 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>              ms->possible_cpus->cpus[i].props.has_die_id = true;
>              ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
>          }
> +        ms->possible_cpus->cpus[i].props.has_llc_id = true;
> +        ms->possible_cpus->cpus[i].props.llc_id = topo_ids.llc_id;
>          ms->possible_cpus->cpus[i].props.has_core_id = true;
>          ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
>          ms->possible_cpus->cpus[i].props.has_thread_id = true;
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index ba52d49079..1238006208 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -48,6 +48,7 @@ typedef uint32_t apic_id_t;
>  typedef struct X86CPUTopoIDs {
>      unsigned pkg_id;
>      unsigned die_id;
> +    unsigned llc_id;
>      unsigned core_id;
>      unsigned smt_id;
>  } X86CPUTopoIDs;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ca26779f1a..1ca5b73418 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -646,9 +646,11 @@
>  # @node-id: NUMA node ID the CPU belongs to
>  # @socket-id: socket number within node/board the CPU belongs to
>  # @die-id: die number within node/board the CPU belongs to (Since 4.1)
> -# @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to
> +# @llc-id: last level cache number within node/board the CPU belongs to (Since 4.2)
> +# @core-id: core number within die the CPU belongs to
> +# @thread-id: thread number within core the CPU belongs to
>  #
> -# Note: currently there are 5 properties that could be present
> +# Note: currently there are 6 properties that could be present
>  # but management should be prepared to pass through other
>  # properties with device_add command to allow for future
>  # interface extension. This also requires the filed names to be kept in
> @@ -660,6 +662,7 @@
>    'data': { '*node-id': 'int',
>              '*socket-id': 'int',
>              '*die-id': 'int',
> +            '*llc-id': 'int',
>              '*core-id': 'int',
>              '*thread-id': 'int'
>    }
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index bc9b491557..3c81aa3ecd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6222,12 +6222,14 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
>      DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
> +    DEFINE_PROP_INT32("llc-id", X86CPU, llc_id, 0),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
>  #else
>      DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
>      DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
> +    DEFINE_PROP_INT32("llc-id", X86CPU, llc_id, -1),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
>  #endif
>      DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index af57fda8e5..a56d44e405 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1711,6 +1711,7 @@ struct X86CPU {
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      int32_t socket_id;
>      int32_t die_id;
> +    int32_t llc_id;
>      int32_t core_id;
>      int32_t thread_id;
>  
> 
> 


