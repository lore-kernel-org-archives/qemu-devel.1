Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE63C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0DA0206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghrJu7Xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DA0206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5BG-0006O3-2I
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5Ad-0005je-8x
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5Ab-0005vV-DI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598962428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yON8vrNOTzQQsKz7IxrDhhmMj7dlNZ++rj4oRJPkwrE=;
 b=ghrJu7XcGyMzCSy1ufoKzOGbosjsB4hqHRAcsLiC5GwMX0IFn4rNygZmw+Z7fhBuNcltC4
 msdiysetj/OV44JggGKbJuXPS5WHLNp6R6/DBax0yIRjlZf7MAQEbZK7K0xA4qxt/T5/Lf
 6IcENoVpadopURMsgKm3a+SdoAmcnlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-J9uOFC5GMsaMKJl1R9eWsQ-1; Tue, 01 Sep 2020 08:13:45 -0400
X-MC-Unique: J9uOFC5GMsaMKJl1R9eWsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E255802B51;
 Tue,  1 Sep 2020 12:13:44 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF10A10013C4;
 Tue,  1 Sep 2020 12:13:39 +0000 (UTC)
Date: Tue, 1 Sep 2020 14:13:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 03/10] Revert "hw/i386: Move arch_id decode inside
 x86_cpus_init"
Message-ID: <20200901141338.1d975ea1@imammedo-mac>
In-Reply-To: <159889934379.21294.15323080164340490855.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889934379.21294.15323080164340490855.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Mon, 31 Aug 2020 13:42:23 -0500
Babu Moger <babu.moger@amd.com> wrote:

> This reverts commit 2e26f4ab3bf8390a2677d3afd9b1a04f015d7721.
> 
> Remove the EPYC specific apicid decoding and use the generic
> default decoding.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c  |    6 +++---
>  hw/i386/x86.c |   37 +++++++------------------------------
>  2 files changed, 10 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 6b708f4341..0677d6a272 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1556,14 +1556,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          topo_ids.die_id = cpu->die_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
> -        cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
> +        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
>      }
>  
>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
>          MachineState *ms = MACHINE(pcms);
>  
> -        x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> +        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>              " APIC ID %" PRIu32 ", valid index range 0:%d",
> @@ -1584,7 +1584,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
>       * once -smp refactoring is complete and there will be CPU private
>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
> -    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> +    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>      if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
>              " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index cf384b9743..3cc2318212 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -68,22 +68,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
>      topo_info->threads_per_core = ms->smp.threads;
>  }
>  
> -/*
> - * Set up with the new EPYC topology handlers
> - *
> - * AMD uses different apic id encoding for EPYC based cpus. Override
> - * the default topo handlers with EPYC encoding handlers.
> - */
> -static void x86_set_epyc_topo_handlers(MachineState *machine)
> -{
> -    X86MachineState *x86ms = X86_MACHINE(machine);
> -
> -    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
> -    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
> -    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
> -    x86ms->apicid_pkg_offset = apicid_pkg_offset_epyc;
> -}
> -
>  /*
>   * Calculates initial APIC ID for a specific CPU index
>   *
> @@ -102,7 +86,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>  
>      init_topo_info(&topo_info, x86ms);
>  
> -    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
> +    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
>      if (x86mc->compat_apic_id_mode) {
>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>              error_report("APIC IDs set in compatibility mode, "
> @@ -136,11 +120,6 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>      MachineState *ms = MACHINE(x86ms);
>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>  
> -    /* Check for apicid encoding */
> -    if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> -        x86_set_epyc_topo_handlers(ms);
> -    }
> -
>      x86_cpu_set_default_version(default_cpu_version);
>  
>      /*
> @@ -154,12 +133,6 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>      x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
>                                                        ms->smp.max_cpus - 1) + 1;
>      possible_cpus = mc->possible_cpu_arch_ids(ms);
> -
> -    for (i = 0; i < ms->possible_cpus->len; i++) {
> -        ms->possible_cpus->cpus[i].arch_id =
> -            x86_cpu_apic_id_from_index(x86ms, i);
> -    }
> -
>      for (i = 0; i < ms->smp.cpus; i++) {
>          x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
>      }
> @@ -184,7 +157,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>     init_topo_info(&topo_info, x86ms);
>  
>     assert(idx < ms->possible_cpus->len);
> -   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);
> +   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> +                            &topo_info, &topo_ids);
>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>  }
>  
> @@ -215,7 +189,10 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>  
>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>          ms->possible_cpus->cpus[i].vcpus_count = 1;
> -        x86_topo_ids_from_idx(&topo_info, i, &topo_ids);
> +        ms->possible_cpus->cpus[i].arch_id =
> +            x86_cpu_apic_id_from_index(x86ms, i);
> +        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> +                                 &topo_info, &topo_ids);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>          if (x86ms->smp_dies > 1) {
> 


