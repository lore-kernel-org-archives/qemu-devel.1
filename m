Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8592FC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D5020727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3APvewB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D5020727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJ8a-0008BO-BQ
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBJ7M-0006w0-TI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBJ7K-0001FR-DZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:10:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBJ7K-0001Eq-62
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583763049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fs8eF/9dh0mwPhDSWKfItuHZLRJUeh4QJntnDmxJHhs=;
 b=a3APvewBvU5IigpZWCnRjcm32t4cC1rYnBWA8qhcFPM8gtm0PBnCNS2828VcaO2bubQyAt
 KvNm4hSXGs0EqKRYQ22lUtcfnkM1jop44qC+16vMxErdU+dk7o77W1ngixtmKV8xEdSMs6
 8GJGXvcksNgToAGTnm5HaFedBs77VDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-3wQf3JSrPNu6vBYl0KI1Aw-1; Mon, 09 Mar 2020 10:10:47 -0400
X-MC-Unique: 3wQf3JSrPNu6vBYl0KI1Aw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09E9E10883A6;
 Mon,  9 Mar 2020 14:10:46 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-206-77.brq.redhat.com [10.40.206.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DB4B5C3FD;
 Mon,  9 Mar 2020 14:10:41 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:10:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 02/16] hw/i386: Introduce X86CPUTopoInfo to contain
 topology info
Message-ID: <20200309151038.0ee0c288@Igors-MacBook-Pro>
In-Reply-To: <158326542572.40452.15331466265190906874.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326542572.40452.15331466265190906874.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 03 Mar 2020 13:57:05 -0600
Babu Moger <babu.moger@amd.com> wrote:

> This is an effort to re-arrange few data structure for better readability.
> 
> 1. Add X86CPUTopoInfo which will have all the topology informations
>    required to build the cpu topology. There is no functional changes.
> 2. Introduce init_topo_info to initialize X86CPUTopoInfo members from
>    X86MachineState.
> 
> There is no functional changes.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c               |   12 ++++++------
>  hw/i386/x86.c              |   32 ++++++++++++++++++++++++--------
>  include/hw/i386/topology.h |   38 ++++++++++++++++++++++++--------------
>  include/hw/i386/x86.h      |    3 +++
>  4 files changed, 57 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 715f79f58c..ef23ae2af5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1514,6 +1514,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      X86MachineState *x86ms = X86_MACHINE(pcms);
>      unsigned int smp_cores = ms->smp.cores;
>      unsigned int smp_threads = ms->smp.threads;
> +    X86CPUTopoInfo topo_info;
>  
>      if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
>          error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> @@ -1521,6 +1522,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> +    init_topo_info(&topo_info, x86ms);
> +
>      env->nr_dies = x86ms->smp_dies;
>  
>      /*
> @@ -1576,16 +1579,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          topo_ids.die_id = cpu->die_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
> -        cpu->apic_id = apicid_from_topo_ids(x86ms->smp_dies, smp_cores,
> -                                            smp_threads, &topo_ids);
> +        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
>      }
>  
>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
>          MachineState *ms = MACHINE(pcms);
>  
> -        x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
> -                                 smp_cores, smp_threads, &topo_ids);
> +        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>              " APIC ID %" PRIu32 ", valid index range 0:%d",
> @@ -1606,8 +1607,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
>       * once -smp refactoring is complete and there will be CPU private
>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
> -    x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
> -                             smp_cores, smp_threads, &topo_ids);
> +    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>      if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
>              " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 322fb6abbc..03b8962c98 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -57,6 +57,16 @@
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>  static size_t pvh_start_addr;
>  
> +inline void init_topo_info(X86CPUTopoInfo *topo_info,
> +                                  const X86MachineState *x86ms)
> +{
> +    MachineState *ms = MACHINE(x86ms);
> +
> +    topo_info->dies_per_pkg = x86ms->smp_dies;
> +    topo_info->cores_per_die = ms->smp.cores;
> +    topo_info->threads_per_core = ms->smp.threads;
> +}
> +
>  /*
>   * Calculates initial APIC ID for a specific CPU index
>   *
> @@ -68,13 +78,14 @@ static size_t pvh_start_addr;
>  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>                                      unsigned int cpu_index)
>  {
> -    MachineState *ms = MACHINE(x86ms);
>      X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
> +    X86CPUTopoInfo topo_info;
>      uint32_t correct_id;
>      static bool warned;
>  
> -    correct_id = x86_apicid_from_cpu_idx(x86ms->smp_dies, ms->smp.cores,
> -                                         ms->smp.threads, cpu_index);
> +    init_topo_info(&topo_info, x86ms);
> +
> +    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
>      if (x86mc->compat_apic_id_mode) {
>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>              error_report("APIC IDs set in compatibility mode, "
> @@ -145,19 +156,22 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>  {
>     X86CPUTopoIDs topo_ids;
>     X86MachineState *x86ms = X86_MACHINE(ms);
> +   X86CPUTopoInfo topo_info;
> +
> +   init_topo_info(&topo_info, x86ms);
>  
>     assert(idx < ms->possible_cpus->len);
>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> -                            x86ms->smp_dies, ms->smp.cores,
> -                            ms->smp.threads, &topo_ids);
> +                            &topo_info, &topo_ids);
>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>  }
>  
>  const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>  {
>      X86MachineState *x86ms = X86_MACHINE(ms);
> -    int i;
>      unsigned int max_cpus = ms->smp.max_cpus;
> +    X86CPUTopoInfo topo_info;
> +    int i;
>  
>      if (ms->possible_cpus) {
>          /*
> @@ -171,6 +185,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>      ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
>                                    sizeof(CPUArchId) * max_cpus);
>      ms->possible_cpus->len = max_cpus;
> +
> +    init_topo_info(&topo_info, x86ms);
> +
>      for (i = 0; i < ms->possible_cpus->len; i++) {
>          X86CPUTopoIDs topo_ids;
>  
> @@ -179,8 +196,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>          ms->possible_cpus->cpus[i].arch_id =
>              x86_cpu_apic_id_from_index(x86ms, i);
>          x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> -                                 x86ms->smp_dies, ms->smp.cores,
> -                                 ms->smp.threads, &topo_ids);
> +                                 &topo_info, &topo_ids);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>          if (x86ms->smp_dies > 1) {
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 52def68610..7ea507f376 100644
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
>      return (topo_ids->pkg_id  <<
>                 apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
>             (topo_ids->die_id  <<
> @@ -136,12 +144,14 @@ static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
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
> @@ -152,11 +162,13 @@ static inline void x86_topo_ids_from_idx(unsigned nr_dies,
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
> @@ -173,14 +185,12 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
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
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 41fe37b8a3..22babcb3bb 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -21,6 +21,7 @@
>  #include "exec/hwaddr.h"
>  #include "qemu/notify.h"
>  
> +#include "hw/i386/topology.h"
>  #include "hw/boards.h"
>  #include "hw/nmi.h"
>  #include "hw/isa/isa.h"
> @@ -82,6 +83,8 @@ typedef struct {
>  #define X86_MACHINE_CLASS(class) \
>      OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
>  
> +void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
> +
>  uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
>                                      unsigned int cpu_index);
>  
> 


