Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6E3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC9320CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWImcM31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC9320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwT8l-0004Of-87
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iwT80-0003uu-5b
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iwT7y-0003lD-8D
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:50:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iwT7y-0003l8-3m
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580226609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hY05ihfHAmoi0CPELcwj5DvE7gz4gF7F8MHMS7nARcc=;
 b=PWImcM31lPmueexiTs97+kAMd3WMfJTOlBhEXDNlbXmUJbzrrCS5mg2gTCN3uyXD+tcQZo
 FrfhIxmkd0/2uoZrcCVUTnkpP7IrFoPqPCzLOslGRoelC6ecwOPnBjiDTfWCn9WTWX4y93
 AAm21qje2dZi3c1SGIyiD3Z3KwzHGVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-lusBz8dGOUCrgivAkgLxHQ-1; Tue, 28 Jan 2020 10:50:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58E0B18A07CA;
 Tue, 28 Jan 2020 15:50:04 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B58935C290;
 Tue, 28 Jan 2020 15:49:59 +0000 (UTC)
Date: Tue, 28 Jan 2020 16:49:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 04/18] hw/i386: Introduce initialize_topo_info to
 initialize X86CPUTopoInfo
Message-ID: <20200128164958.6e97de19@redhat.com>
In-Reply-To: <157541984181.46157.12341489595513709747.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541984181.46157.12341489595513709747.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: lusBz8dGOUCrgivAkgLxHQ-1
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

On Tue, 03 Dec 2019 18:37:21 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Initialize all the parameters in one function initialize_topo_info.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/i386/pc.c |   28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 8c23b1e8c9..cafbdafa76 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -866,6 +866,15 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
>      x86_cpu_set_a20(cpu, level);
>  }
>  
> +static inline void initialize_topo_info(X86CPUTopoInfo *topo_info,
> +                                        PCMachineState *pcms,

maybe use 'const'

> +                                        const MachineState *ms)
'ms' is the same thing as 'pcms', so why pass it around separately?

you can just do
   MachineState *ms = MACHINE(pcms)
inside of function

> +{
> +    topo_info->dies_per_pkg = pcms->smp_dies;
> +    topo_info->cores_per_die = ms->smp.cores;
> +    topo_info->threads_per_core = ms->smp.threads;
> +}
> +
>  /* Calculates initial APIC ID for a specific CPU index
>   *
>   * Currently we need to be able to calculate the APIC ID from the CPU index
> @@ -882,9 +891,7 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
>      uint32_t correct_id;
>      static bool warned;
>  
> -    topo_info.dies_per_pkg = pcms->smp_dies;
> -    topo_info.cores_per_die = ms->smp.cores;
> -    topo_info.threads_per_core = ms->smp.threads;
> +    initialize_topo_info(&topo_info, pcms, ms);
>  
>      correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
>      if (pcmc->compat_apic_id_mode) {
> @@ -2231,9 +2238,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> -    topo_info.dies_per_pkg = pcms->smp_dies;
> -    topo_info.cores_per_die = smp_cores;
> -    topo_info.threads_per_core = smp_threads;
> +    initialize_topo_info(&topo_info, pcms, ms);
>  
>      env->nr_dies = pcms->smp_dies;
>  
> @@ -2702,9 +2707,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
>     PCMachineState *pcms = PC_MACHINE(ms);
>     X86CPUTopoInfo topo_info;
>  
> -   topo_info.dies_per_pkg = pcms->smp_dies;
> -   topo_info.cores_per_die = ms->smp.cores;
> -   topo_info.threads_per_core = ms->smp.threads;
> +   initialize_topo_info(&topo_info, pcms, ms);
>  
>     assert(idx < ms->possible_cpus->len);
>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> @@ -2719,10 +2722,6 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>      X86CPUTopoInfo topo_info;
>      int i;
>  
> -    topo_info.dies_per_pkg = pcms->smp_dies;
> -    topo_info.cores_per_die = ms->smp.cores;
> -    topo_info.threads_per_core = ms->smp.threads;
> -
>      if (ms->possible_cpus) {
>          /*
>           * make sure that max_cpus hasn't changed since the first use, i.e.
> @@ -2734,6 +2733,9 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>  
>      ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
>                                    sizeof(CPUArchId) * max_cpus);
> +
> +    initialize_topo_info(&topo_info, pcms, ms);
> +
>      ms->possible_cpus->len = max_cpus;
>      for (i = 0; i < ms->possible_cpus->len; i++) {
>          X86CPUTopoIDs topo_ids;
> 


