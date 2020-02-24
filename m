Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E4FC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A5920836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhJGPXxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A5920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HOw-0003FR-AY
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6HO4-0002d3-GV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6HO3-0004Ti-4Z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:19:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6HO2-0004TH-WD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582564758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nhtRJY6il+zG1glAHnNWwdGIl5h679rWNsy8y6QiDo8=;
 b=dhJGPXxRUCZhkROjNltNi6UODLy+vxtGCHdjoSErQUJMX/OPw6p/iV2Agi6eAW6jgKZDfg
 Z6USTuODdPhUKps47q2bYjFefvCjxLeffKkxUM/NXyYz0RRWrNRkggFFtPz10Y/eJV5lKs
 0r4CpAcZyRyOIjAS7hjA7XZBY/BwmoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-KIcqbwQoMmG1nu-GD3IXDA-1; Mon, 24 Feb 2020 12:19:10 -0500
X-MC-Unique: KIcqbwQoMmG1nu-GD3IXDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74450801E53;
 Mon, 24 Feb 2020 17:19:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2700491856;
 Mon, 24 Feb 2020 17:19:04 +0000 (UTC)
Date: Mon, 24 Feb 2020 18:19:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 12/16] hw/i386: Use the apicid handlers from
 X86MachineState
Message-ID: <20200224181903.19790bad@redhat.com>
In-Reply-To: <158161786628.48948.1813866541108702762.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161786628.48948.1813866541108702762.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Thu, 13 Feb 2020 12:17:46 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Check and Load the apicid handlers from X86CPUDefinition if available.
> Update the calling convention for the apicid handlers.

Previous and this patch look too complicated for the task at the hand.
In particular, cpu_x86_init_apicid_fns() from previous patch adds 1 more
reference to Machine into i386/cpu.c (even though it's just a helper function)
and I think un-necessary hooks to X86CPUDefinition (it's not really CPU's
businesses to make up APIC-IDs).

I'd rather do opposite and get rid of the last explicit dependency to
ms->smp.cpus from cpu.c. But well, it's out of scope of this series,
so for this series I'd just try to avoid adding more Machine dependencies.

All 11/16 does is basically using hooks as a switch "I'm EPYC" to
set epyc specific encoding topo routines.

It could be accomplished by a simple Boolean flag like
 X86CPUDefinition::use_epyc_apic_id_encoding

and then cpu_x86_init_apicid_fns() could be replaced with trivial
helper like:

  x86_use_epyc_apic_id_encoding(char *cpu_type)
  {
      X86CPUClass *xcc = ... cpu_type ...
      return xcc->model->cpudef->use_epyc_apic_id_encoding
  }

then machine could override default[1] hooks using this helper
as the trigger
  x86_cpus_init()
  {
      // no need in dedicated function as it's the only instance it's going to be called ever
      if (x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
            x86ms->apicid_from_cpu_idx = ...epyc...
            x86ms->topo_ids_from_apicid = ...epyc...
            x86ms->apicid_from_topo_ids = ...epyc...
            x86ms->apicid_pkg_offset = ...epyc...
      }
  }

That would be less invasive and won't create non necessary dependencies.

---
1) defaults should be set in x86_machine_class_init()

Eduardo, what's your take on this?

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/i386/pc.c  |    6 +++---
>  hw/i386/x86.c |   27 +++++++++++++++++++++++----
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index be72a49716..93063af6a8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1808,14 +1808,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          topo_ids.die_id = cpu->die_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
> -        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
> +        cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
>      }
>  
>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
>          MachineState *ms = MACHINE(pcms);
>  
> -        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> +        x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>              " APIC ID %" PRIu32 ", valid index range 0:%d",
> @@ -1836,7 +1836,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
>       * once -smp refactoring is complete and there will be CPU private
>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
> -    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> +    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>      if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
>              " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 3d944f68e6..b825861b85 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -52,6 +52,22 @@
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>  static size_t pvh_start_addr;
>  
> +/*
> + * Check for apicid handlers in X86MachineState. Load them if
> + * not loaded already. These handlers are loaded from X86CPUDefinition.
> + */
> +static void x86_check_apicid_handlers(MachineState *ms)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(ms);
> +
> +    if (!x86ms->apicid_from_cpu_idx ||
> +        !x86ms->topo_ids_from_apicid ||
> +        !x86ms->apicid_from_topo_ids ||
> +        !x86ms->apicid_pkg_offset) {
> +        cpu_x86_init_apicid_fns(ms);
> +    }
> +}
> +
>  /*
>   * Calculates initial APIC ID for a specific CPU index
>   *
> @@ -70,7 +86,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>  
>      init_topo_info(&topo_info, x86ms);
>  
> -    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
> +    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
>      if (x86mc->compat_apic_id_mode) {
>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>              error_report("APIC IDs set in compatibility mode, "
> @@ -148,8 +164,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>     init_topo_info(&topo_info, x86ms);
>  
>     assert(idx < ms->possible_cpus->len);
> -   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> -                            &topo_info, &topo_ids);
> +   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> +                               &topo_info, &topo_ids);
>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>  }
>  
> @@ -169,6 +185,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>          return ms->possible_cpus;
>      }
>  
> +    /* Initialize apicid handlers */
> +    x86_check_apicid_handlers(ms);
> +
>      ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
>                                    sizeof(CPUArchId) * max_cpus);
>      ms->possible_cpus->len = max_cpus;
> @@ -182,7 +201,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>          ms->possible_cpus->cpus[i].arch_id =
>              x86_cpu_apic_id_from_index(x86ms, i);
> -        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> +        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>                                   &topo_info, &topo_ids);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
> 
> 


