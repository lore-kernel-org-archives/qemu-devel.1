Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDCDC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D0620838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D0620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htGlb-0003lA-Bu
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1htGkf-0003Bf-Ff
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1htGke-0004Sx-82
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:28:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1htGkd-0004SW-Vv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:28:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09FAB300BEB1;
 Thu,  1 Aug 2019 19:28:35 +0000 (UTC)
Received: from localhost (ovpn-116-22.gru2.redhat.com [10.97.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 072281001947;
 Thu,  1 Aug 2019 19:28:31 +0000 (UTC)
Date: Thu, 1 Aug 2019 16:28:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Message-ID: <20190801192830.GD20035@habkost.net>
References: <20190731232032.51786-1-babu.moger@amd.com>
 <20190731232032.51786-5-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731232032.51786-5-babu.moger@amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 01 Aug 2019 19:28:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 4/5] hw/i386: Generate apicid based on
 cpu_type
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the patches.

I still haven't looked closely at all patches in the series, but
patches 1-3 seem good on the first look.  A few comments on this
one:

On Wed, Jul 31, 2019 at 11:20:50PM +0000, Moger, Babu wrote:
> Check the cpu_type before calling the apicid functions
> from topology.h.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
[...]
> @@ -2437,16 +2478,26 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          topo.die_id = cpu->die_id;
>          topo.core_id = cpu->core_id;
>          topo.smt_id = cpu->thread_id;
> -        cpu->apic_id = apicid_from_topo_ids(pcms->smp_dies, smp_cores,
> -                                            smp_threads, &topo);
> +	if (!strncmp(ms->cpu_type, "EPYC", 4)) {

Please don't add semantics to the CPU type name.  If you want
some behavior to be configurable per CPU type, please do it at
the X86CPUDefinition struct.

In this specific case, maybe the new APIC ID calculation code
could
be conditional on:
  (vendor == AMD) && (env->features[...] & TOPOEXT).

Also, we must keep compatibility with the old APIC ID calculation
code on older machine types.  We need a compatibility flag to
enable the existing APIC ID calculation.


> +            x86_topo_ids_from_idx_epyc(nb_numa_nodes, smp_sockets, smp_cores,
> +                                       smp_threads, idx, &topo);
> +            cpu->apic_id = apicid_from_topo_ids_epyc(smp_cores, smp_threads,
> +                                                     &topo);
> +	} else

There's a tab character here.  Please use spaces instead of tabs.

> +            cpu->apic_id = apicid_from_topo_ids(pcms->smp_dies, smp_cores,
> +                                                smp_threads, &topo);

I see you are duplicating very similar logic in 3 different
places, to call apicid_from_topo_ids() and
x86_topo_ids_from_apicid().

Also, apicid_from_topo_ids() and x86_topo_ids_from_apicid() have very generic
names, and people could call them expecting them to work for every CPU model
(which they don't).  This makes the topology API very easy to misuse.

Why don't we make the existing generic
apicid_from_topo_ids()/x86_topo_ids_from_apicid() functions work
on all cases?  If they need additional input to handle EPYC and
call EPYC-specific functions, we can make them get additional
arguments.  This way we'll be sure that we'll never call the
wrong implementation by accident.

This might make the list of arguments for
x86_topo_ids_from_apicid() and apicid_from_topo_ids() become
large.  We can address this by making them get a CpuTopology
argument.


In other words, the API could look like this:


static inline apic_id_t apicid_from_topo_ids(const X86CPUTopology *topo,
                                             const X86CPUTopologyIds *ids)
{
    if (topo->epyc_mode) {
        return apicid_from_topo_ids_epyc(topo, ids);
    }

    /* existing QEMU 4.1 logic: */
    return (ids->pkg_id  << apicid_pkg_offset(topo)) |
           (ids->die_id  << apicid_die_offset(topo)) |
           (ids->core_id << apicid_core_offset(topo)) |
           ids->smt_id;
}

static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
                                            const X86CPUTopology *topo,
                                            X86CPUTopologyIds *ids)
{
    if (topo->epyc_mode) {
        x86_topo_ids_from_apicid_epyc(apicid, topo, ids);
        return;
    }

    /* existing QEMU 4.1 logic: */
    ids->smt_id =
            apicid &
            ~(0xFFFFFFFFUL << apicid_smt_width(topo));
    ids->core_id =
            (apicid >> apicid_core_offset(topo)) &
            ~(0xFFFFFFFFUL << apicid_core_width(topo));
    ids->die_id =
            (apicid >> apicid_die_offset(topo)) &
            ~(0xFFFFFFFFUL << apicid_die_width(topo));
    ids->pkg_id = apicid >> apicid_pkg_offset(topo);
}

 
>      }
>  
>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
>          MachineState *ms = MACHINE(pcms);
>  
> -        x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> -                                 smp_cores, smp_threads, &topo);
> +        if(!strncmp(ms->cpu_type, "EPYC", 4))
> +            x86_topo_ids_from_apicid_epyc(cpu->apic_id, pcms->smp_dies,
> +                                          smp_cores, smp_threads, &topo);
> +        else
> +            x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> +                                     smp_cores, smp_threads, &topo);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>              " APIC ID %" PRIu32 ", valid index range 0:%d",
> @@ -2874,10 +2925,18 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>  
>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>          ms->possible_cpus->cpus[i].vcpus_count = 1;
> -        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
> -        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> -                                 pcms->smp_dies, ms->smp.cores,
> -                                 ms->smp.threads, &topo);
> +	if(!strncmp(ms->cpu_type, "EPYC", 4)) {
> +            ms->possible_cpus->cpus[i].arch_id =
> +                            x86_cpu_apic_id_from_index_epyc(pcms, i);
> +            x86_topo_ids_from_apicid_epyc(ms->possible_cpus->cpus[i].arch_id,
> +                                          pcms->smp_dies, ms->smp.cores,
> +					  ms->smp.threads, &topo);
> +	} else {
> +            ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
> +            x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> +                                     pcms->smp_dies, ms->smp.cores,
> +                                     ms->smp.threads, &topo);
> +	}
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>          ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
>          ms->possible_cpus->cpus[i].props.has_die_id = true;
> -- 
> 2.20.1
> 

-- 
Eduardo

