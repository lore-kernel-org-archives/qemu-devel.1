Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A59EC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DC62080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GttU4Pd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DC62080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydLt-0004mn-D1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iydKy-0004Ak-F1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iydKv-0001ir-T5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:08:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iydKv-0001gp-NB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580742508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3/QazwFPDpxIG60f1ladefd7hp2FQwousRv1fw7Kuo=;
 b=GttU4Pd0pIg3YGefpCvcdyZ4MKF5p23Lb6zYVadeo26BBdamIOzenfXqgZVv2fkfrvg6Rc
 qrLJTZ9titIR/mLAnQ1pF1dr4hFDr84bwpnrs89AYf6l5N3H5Sov3YxvuUnuX79WBt5gi0
 e5ea1xRXsk/KdLwxy36D9rEFM7pmAik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-UMjZMGRMORmF-YLCSbn8IA-1; Mon, 03 Feb 2020 10:08:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DF0610A8615;
 Mon,  3 Feb 2020 15:08:23 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7DD60BF4;
 Mon,  3 Feb 2020 15:08:18 +0000 (UTC)
Date: Mon, 3 Feb 2020 16:08:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 01/18] hw/i386: Rename X86CPUTopoInfo structure to
 X86CPUTopoIDs
Message-ID: <20200203160816.50d0409c@redhat.com>
In-Reply-To: <157541982144.46157.2428083754645928332.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541982144.46157.2428083754645928332.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: UMjZMGRMORmF-YLCSbn8IA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Tue, 03 Dec 2019 18:37:01 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Rename few data structures related to X86 topology.  X86CPUTopoIDs will
> have individual arch ids. Next patch introduces X86CPUTopoInfo which will
> have all topology information(like cores, threads etc..).

On what commit series was based on?
(it doesn't apply to master anymore)


> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/i386/pc.c               |   60 ++++++++++++++++++++++----------------------
>  include/hw/i386/topology.h |   40 +++++++++++++++--------------
>  2 files changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 51b72439b4..5bd2ffccb7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2212,7 +2212,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      int idx;
>      CPUState *cs;
>      CPUArchId *cpu_slot;
> -    X86CPUTopoInfo topo;
> +    X86CPUTopoIDs topo_ids;
>      X86CPU *cpu = X86_CPU(dev);
>      CPUX86State *env = &cpu->env;
>      MachineState *ms = MACHINE(hotplug_dev);
> @@ -2277,12 +2277,12 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>              return;
>          }
>  
> -        topo.pkg_id = cpu->socket_id;
> -        topo.die_id = cpu->die_id;
> -        topo.core_id = cpu->core_id;
> -        topo.smt_id = cpu->thread_id;
> +        topo_ids.pkg_id = cpu->socket_id;
> +        topo_ids.die_id = cpu->die_id;
> +        topo_ids.core_id = cpu->core_id;
> +        topo_ids.smt_id = cpu->thread_id;
>          cpu->apic_id = apicid_from_topo_ids(pcms->smp_dies, smp_cores,
> -                                            smp_threads, &topo);
> +                                            smp_threads, &topo_ids);
>      }
>  
>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> @@ -2290,11 +2290,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          MachineState *ms = MACHINE(pcms);
>  
>          x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> -                                 smp_cores, smp_threads, &topo);
> +                                 smp_cores, smp_threads, &topo_ids);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>              " APIC ID %" PRIu32 ", valid index range 0:%d",
> -            topo.pkg_id, topo.die_id, topo.core_id, topo.smt_id,
> +            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
>              cpu->apic_id, ms->possible_cpus->len - 1);
>          return;
>      }
> @@ -2312,34 +2312,34 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>       * once -smp refactoring is complete and there will be CPU private
>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
>      x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> -                             smp_cores, smp_threads, &topo);
> -    if (cpu->socket_id != -1 && cpu->socket_id != topo.pkg_id) {
> +                             smp_cores, smp_threads, &topo_ids);
> +    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
> -            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo.pkg_id);
> +            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
>          return;
>      }
> -    cpu->socket_id = topo.pkg_id;
> +    cpu->socket_id = topo_ids.pkg_id;
>  
> -    if (cpu->die_id != -1 && cpu->die_id != topo.die_id) {
> +    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
>          error_setg(errp, "property die-id: %u doesn't match set apic-id:"
> -            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo.die_id);
> +            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
>          return;
>      }
> -    cpu->die_id = topo.die_id;
> +    cpu->die_id = topo_ids.die_id;
>  
> -    if (cpu->core_id != -1 && cpu->core_id != topo.core_id) {
> +    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
>          error_setg(errp, "property core-id: %u doesn't match set apic-id:"
> -            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo.core_id);
> +            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo_ids.core_id);
>          return;
>      }
> -    cpu->core_id = topo.core_id;
> +    cpu->core_id = topo_ids.core_id;
>  
> -    if (cpu->thread_id != -1 && cpu->thread_id != topo.smt_id) {
> +    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
>          error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
> -            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id, topo.smt_id);
> +            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id, topo_ids.smt_id);
>          return;
>      }
> -    cpu->thread_id = topo.smt_id;
> +    cpu->thread_id = topo_ids.smt_id;
>  
>      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
>          !kvm_hv_vpindex_settable()) {
> @@ -2692,14 +2692,14 @@ pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  
>  static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
>  {
> -   X86CPUTopoInfo topo;
> +   X86CPUTopoIDs topo_ids;
>     PCMachineState *pcms = PC_MACHINE(ms);
>  
>     assert(idx < ms->possible_cpus->len);
>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>                              pcms->smp_dies, ms->smp.cores,
> -                            ms->smp.threads, &topo);
> -   return topo.pkg_id % ms->numa_state->num_nodes;
> +                            ms->smp.threads, &topo_ids);
> +   return topo_ids.pkg_id % ms->numa_state->num_nodes;
>  }
>  
>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
> @@ -2721,24 +2721,24 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>                                    sizeof(CPUArchId) * max_cpus);
>      ms->possible_cpus->len = max_cpus;
>      for (i = 0; i < ms->possible_cpus->len; i++) {
> -        X86CPUTopoInfo topo;
> +        X86CPUTopoIDs topo_ids;
>  
>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>          ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
>          x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>                                   pcms->smp_dies, ms->smp.cores,
> -                                 ms->smp.threads, &topo);
> +                                 ms->smp.threads, &topo_ids);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
> -        ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
> +        ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>          if (pcms->smp_dies > 1) {
>              ms->possible_cpus->cpus[i].props.has_die_id = true;
> -            ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
> +            ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
>          }
>          ms->possible_cpus->cpus[i].props.has_core_id = true;
> -        ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
> +        ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
>          ms->possible_cpus->cpus[i].props.has_thread_id = true;
> -        ms->possible_cpus->cpus[i].props.thread_id = topo.smt_id;
> +        ms->possible_cpus->cpus[i].props.thread_id = topo_ids.smt_id;
>      }
>      return ms->possible_cpus;
>  }
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 4ff5b2da6c..6c184f3115 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -45,12 +45,12 @@
>   */
>  typedef uint32_t apic_id_t;
>  
> -typedef struct X86CPUTopoInfo {
> +typedef struct X86CPUTopoIDs {
>      unsigned pkg_id;
>      unsigned die_id;
>      unsigned core_id;
>      unsigned smt_id;
> -} X86CPUTopoInfo;
> +} X86CPUTopoIDs;
>  
>  /* Return the bit width needed for 'count' IDs
>   */
> @@ -122,12 +122,12 @@ static inline unsigned apicid_pkg_offset(unsigned nr_dies,
>  static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
>                                               unsigned nr_cores,
>                                               unsigned nr_threads,
> -                                             const X86CPUTopoInfo *topo)
> +                                             const X86CPUTopoIDs *topo_ids)
>  {
> -    return (topo->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
> -           (topo->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
> -          (topo->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
> -           topo->smt_id;
> +    return (topo_ids->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
> +           (topo_ids->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
> +           (topo_ids->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
> +           topo_ids->smt_id;
>  }
>  
>  /* Calculate thread/core/package IDs for a specific topology,
> @@ -137,12 +137,12 @@ static inline void x86_topo_ids_from_idx(unsigned nr_dies,
>                                           unsigned nr_cores,
>                                           unsigned nr_threads,
>                                           unsigned cpu_index,
> -                                         X86CPUTopoInfo *topo)
> +                                         X86CPUTopoIDs *topo_ids)
>  {
> -    topo->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> -    topo->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
> -    topo->core_id = cpu_index / nr_threads % nr_cores;
> -    topo->smt_id = cpu_index % nr_threads;
> +    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> +    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
> +    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
> +    topo_ids->smt_id = cpu_index % nr_threads;
>  }
>  
>  /* Calculate thread/core/package IDs for a specific topology,
> @@ -152,17 +152,17 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>                                              unsigned nr_dies,
>                                              unsigned nr_cores,
>                                              unsigned nr_threads,
> -                                            X86CPUTopoInfo *topo)
> +                                            X86CPUTopoIDs *topo_ids)
>  {
> -    topo->smt_id = apicid &
> +    topo_ids->smt_id = apicid &
>              ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threads));
> -    topo->core_id =
> +    topo_ids->core_id =
>              (apicid >> apicid_core_offset(nr_dies, nr_cores, nr_threads)) &
>              ~(0xFFFFFFFFUL << apicid_core_width(nr_dies, nr_cores, nr_threads));
> -    topo->die_id =
> +    topo_ids->die_id =
>              (apicid >> apicid_die_offset(nr_dies, nr_cores, nr_threads)) &
>              ~(0xFFFFFFFFUL << apicid_die_width(nr_dies, nr_cores, nr_threads));
> -    topo->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
> +    topo_ids->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
>  }
>  
>  /* Make APIC ID for the CPU 'cpu_index'
> @@ -174,9 +174,9 @@ static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
>                                                  unsigned nr_threads,
>                                                  unsigned cpu_index)
>  {
> -    X86CPUTopoInfo topo;
> -    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo);
> -    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo);
> +    X86CPUTopoIDs topo_ids;
> +    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo_ids);
> +    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo_ids);
>  }
>  
>  #endif /* HW_I386_TOPOLOGY_H */
> 
> 


