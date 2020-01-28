Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A85EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569C92051A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoOIc0XA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569C92051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwT47-0001xl-Ia
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iwT2X-0000Ch-Uo
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iwT2V-0005vG-Aw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:44:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iwT2V-0005rt-2y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580226270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75KgJJlIfahhwx16iC8LV9y3+7Kb8UW5A6Fi28VvdCo=;
 b=LoOIc0XA384qqssTcKNSCh0/ii1Grl8P9Vr2jyALRcA3XZ7w17ZC4PY+ajlYUyyNW/VY7J
 IjnoLD/T/Vz1gTgynZAhc3RG0xW3lA15w+SajWM5flVzKI2ATE/YlqRixpFWH+kP4s1fCY
 RUVUjPUr6EQMlViTIUMeRAKRf3z4E78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-kfEQIoBsMyKTYCvcrFqbrg-1; Tue, 28 Jan 2020 10:44:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15A34869ECA;
 Tue, 28 Jan 2020 15:44:25 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB64990F4A;
 Tue, 28 Jan 2020 15:44:17 +0000 (UTC)
Date: Tue, 28 Jan 2020 16:44:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 02/18] hw/i386: Introduce X86CPUTopoInfo to contain
 topology info
Message-ID: <20200128164416.39eb2db2@redhat.com>
In-Reply-To: <157541982831.46157.16635542688144831181.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541982831.46157.16635542688144831181.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: kfEQIoBsMyKTYCvcrFqbrg-1
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

On Tue, 03 Dec 2019 18:37:08 -0600
Babu Moger <babu.moger@amd.com> wrote:

> This is an effort to re-arrange few data structure for better readability.
> Add X86CPUTopoInfo which will have all the topology informations required
> to build the cpu topology. There is no functional changes.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c               |   40 +++++++++++++++++++++++++++-------------
>  include/hw/i386/topology.h |   38 ++++++++++++++++++++++++--------------
>  2 files changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5bd2ffccb7..8c23b1e8c9 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -878,11 +878,15 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
>  {
>      MachineState *ms = MACHINE(pcms);
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    X86CPUTopoInfo topo_info;
>      uint32_t correct_id;
>      static bool warned;
>  
> -    correct_id = x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cores,
> -                                         ms->smp.threads, cpu_index);
> +    topo_info.dies_per_pkg = pcms->smp_dies;
> +    topo_info.cores_per_die = ms->smp.cores;
> +    topo_info.threads_per_core = ms->smp.threads;
> +
> +    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
>      if (pcmc->compat_apic_id_mode) {
>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>              error_report("APIC IDs set in compatibility mode, "
> @@ -2219,6 +2223,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>      unsigned int smp_cores = ms->smp.cores;
>      unsigned int smp_threads = ms->smp.threads;
> +    X86CPUTopoInfo topo_info;
>  
>      if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
>          error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> @@ -2226,6 +2231,10 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> +    topo_info.dies_per_pkg = pcms->smp_dies;
> +    topo_info.cores_per_die = smp_cores;
> +    topo_info.threads_per_core = smp_threads;
> +
>      env->nr_dies = pcms->smp_dies;
>  
>      /*
> @@ -2281,16 +2290,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          topo_ids.die_id = cpu->die_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
> -        cpu->apic_id = apicid_from_topo_ids(pcms->smp_dies, smp_cores,
> -                                            smp_threads, &topo_ids);
> +        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
>      }
>  
>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
>          MachineState *ms = MACHINE(pcms);
>  
> -        x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> -                                 smp_cores, smp_threads, &topo_ids);
> +        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>              " APIC ID %" PRIu32 ", valid index range 0:%d",
> @@ -2311,8 +2318,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
>       * once -smp refactoring is complete and there will be CPU private
>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
> -    x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> -                             smp_cores, smp_threads, &topo_ids);
> +    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>      if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
>              " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
> @@ -2694,19 +2700,28 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
>  {
>     X86CPUTopoIDs topo_ids;
>     PCMachineState *pcms = PC_MACHINE(ms);
> +   X86CPUTopoInfo topo_info;
> +
> +   topo_info.dies_per_pkg = pcms->smp_dies;
> +   topo_info.cores_per_die = ms->smp.cores;
> +   topo_info.threads_per_core = ms->smp.threads;
>  
>     assert(idx < ms->possible_cpus->len);
>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> -                            pcms->smp_dies, ms->smp.cores,
> -                            ms->smp.threads, &topo_ids);
> +                            &topo_info, &topo_ids);
>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>  }
>  
>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>  {
>      PCMachineState *pcms = PC_MACHINE(ms);
> -    int i;
>      unsigned int max_cpus = ms->smp.max_cpus;
> +    X86CPUTopoInfo topo_info;
> +    int i;
> +
> +    topo_info.dies_per_pkg = pcms->smp_dies;
> +    topo_info.cores_per_die = ms->smp.cores;
> +    topo_info.threads_per_core = ms->smp.threads;
>  
>      if (ms->possible_cpus) {
>          /*
> @@ -2727,8 +2742,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>          ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
>          x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> -                                 pcms->smp_dies, ms->smp.cores,
> -                                 ms->smp.threads, &topo_ids);
> +                                 &topo_info, &topo_ids);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>          if (pcms->smp_dies > 1) {
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 6c184f3115..cf1935d548 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -52,6 +52,12 @@ typedef struct X86CPUTopoIDs {
>      unsigned smt_id;
>  } X86CPUTopoIDs;
>  
> +typedef struct X86CPUTopoInfo {
> +    unsigned dies_per_pkg;
> +    unsigned cores_per_die;
> +    unsigned threads_per_core;
> +} X86CPUTopoInfo;
> +
>  /* Return the bit width needed for 'count' IDs
>   */
>  static unsigned apicid_bitwidth_for_count(unsigned count)
> @@ -119,11 +125,13 @@ static inline unsigned apicid_pkg_offset(unsigned nr_dies,
>   *
>   * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
>   */
> -static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
> -                                             unsigned nr_cores,
> -                                             unsigned nr_threads,
> +static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
>                                               const X86CPUTopoIDs *topo_ids)
>  {
> +    unsigned nr_dies = topo_info->dies_per_pkg;
> +    unsigned nr_cores = topo_info->cores_per_die;
> +    unsigned nr_threads = topo_info->threads_per_core;
> +
>      return (topo_ids->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
>             (topo_ids->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
>             (topo_ids->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
> @@ -133,12 +141,14 @@ static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
>  /* Calculate thread/core/package IDs for a specific topology,
>   * based on (contiguous) CPU index
>   */
> -static inline void x86_topo_ids_from_idx(unsigned nr_dies,
> -                                         unsigned nr_cores,
> -                                         unsigned nr_threads,
> +static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
>                                           unsigned cpu_index,
>                                           X86CPUTopoIDs *topo_ids)
>  {
> +    unsigned nr_dies = topo_info->dies_per_pkg;
> +    unsigned nr_cores = topo_info->cores_per_die;
> +    unsigned nr_threads = topo_info->threads_per_core;
> +
>      topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
>      topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
>      topo_ids->core_id = cpu_index / nr_threads % nr_cores;
> @@ -149,11 +159,13 @@ static inline void x86_topo_ids_from_idx(unsigned nr_dies,
>   * based on APIC ID
>   */
>  static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
> -                                            unsigned nr_dies,
> -                                            unsigned nr_cores,
> -                                            unsigned nr_threads,
> +                                            X86CPUTopoInfo *topo_info,
>                                              X86CPUTopoIDs *topo_ids)
>  {
> +    unsigned nr_dies = topo_info->dies_per_pkg;
> +    unsigned nr_cores = topo_info->cores_per_die;
> +    unsigned nr_threads = topo_info->threads_per_core;
> +
>      topo_ids->smt_id = apicid &
>              ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threads));
>      topo_ids->core_id =
> @@ -169,14 +181,12 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>   *
>   * 'cpu_index' is a sequential, contiguous ID for the CPU.
>   */
> -static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
> -                                                unsigned nr_cores,
> -                                                unsigned nr_threads,
> +static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
>                                                  unsigned cpu_index)
>  {
>      X86CPUTopoIDs topo_ids;
> -    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo_ids);
> -    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo_ids);
> +    x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
> +    return apicid_from_topo_ids(topo_info, &topo_ids);
>  }
>  
>  #endif /* HW_I386_TOPOLOGY_H */
> 
> 


