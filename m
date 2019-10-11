Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17341C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 03:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EF62196E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 03:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EF62196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIlyp-0004gp-7Q
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 23:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iIly9-0004ES-GJ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 23:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iIly6-0002he-NW
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 23:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iIly6-0002hO-F1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 23:51:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F7703090FDF;
 Fri, 11 Oct 2019 03:51:53 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A810460BE1;
 Fri, 11 Oct 2019 03:51:50 +0000 (UTC)
Date: Fri, 11 Oct 2019 00:51:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 08/16] i386: Cleanup and use the new
 epyc mode topology functions
Message-ID: <20191011035144.GE29387@habkost.net>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779715031.21957.17374671669134234845.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156779715031.21957.17374671669134234845.stgit@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 11 Oct 2019 03:51:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ssg.sos.staff" <ssg.sos.staff@amd.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 07:12:33PM +0000, Moger, Babu wrote:
> Use the new epyc mode functions and delete the unused code.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c |  171 +++++++++++++++--------------------------------------
>  1 file changed, 48 insertions(+), 123 deletions(-)
> 
[...]
>  /* Encode cache info for CPUID[8000001E] */
> -static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
> -                                       uint32_t *eax, uint32_t *ebx,
> -                                       uint32_t *ecx, uint32_t *edx)
> +static void encode_topo_cpuid8000001e(CPUX86State *env,
> +                                      uint32_t *eax, uint32_t *ebx,
> +                                      uint32_t *ecx, uint32_t *edx)
>  {
> -    struct core_topology topo = {0};
> -    unsigned long nodes;
> -    int shift;
> +    X86CPUTopoIDs topo_ids = { 0 };
> +    unsigned long nodes, shift;
> +    X86CPU *cpu = env_archcpu(env);
> +    CPUState *cs = env_cpu(env);
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    X86CPUTopoInfo topo_info = {
> +        .numa_nodes = nb_numa_nodes,
> +        .nr_sockets = ms->smp.sockets,
> +        .nr_cores = ms->smp.cores,
> +        .nr_threads = ms->smp.threads,
> +    };
> +
> +    nodes = nodes_in_pkg(&topo_info);
> +    x86_topo_ids_from_idx_epyc(&topo_info, cs->cpu_index, &topo_ids);

You probably want to use x86_topo_ids_from_apicid() instead.
cpu_index is a deprecated identifier for a CPU, and may not match
the actual CPU topology if using CPU hotplug.

>  
> -    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
>      *eax = cpu->apic_id;
> +
>      /*
>       * CPUID_Fn8000001E_EBX
>       * 31:16 Reserved
> @@ -496,11 +421,12 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
>       *             3 Core complex id
>       *           1:0 Core id
>       */
> -    if (cs->nr_threads - 1) {
> -        *ebx = ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
> -                (topo.ccx_id << 2) | topo.core_id;
> +    if (topo_info.nr_threads - 1) {
> +        *ebx = ((topo_info.nr_threads - 1) << 8) | (topo_ids.node_id << 3) |
> +                (topo_ids.ccx_id << 2) | topo_ids.core_id;
>      } else {
> -        *ebx = (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_id;
> +        *ebx = (topo_ids.node_id << 4) | (topo_ids.ccx_id << 3) |
> +                topo_ids.core_id;

It's nice to see we are deleting old code and reusing the same
topology functions.  However, I'm worried that the relationship
between the topology IDs in APIC ID (EAX) and the topology IDs in
EBX and ECX isn't clear.

I'm also worried there's no code enforcing a limit for
node_id/ccx_id/core_id to ensure they fit in the fields defined
above.  These hardcoded limits will become painful to maintain
once we have new CPUs with different constraints.  We need to
make the limits explicit in the code, and also be prepared for
them to change in the future depending on the CPU model.

>      }
>      /*
>       * CPUID_Fn8000001E_ECX
> @@ -510,9 +436,8 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
>       *         2  Socket id
>       *       1:0  Node id
>       */
> -    if (topo.num_nodes <= 4) {
> -        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
> -                topo.node_id;
> +    if (nodes <= 4) {
> +        *ecx = ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.node_id;
>      } else {
>          /*
>           * Node id fix up. Actual hardware supports up to 4 nodes. But with
> @@ -527,12 +452,12 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
>           * number of nodes. find_last_bit returns last set bit(0 based). Left
>           * shift(+1) the socket id to represent all the nodes.
>           */
> -        nodes = topo.num_nodes - 1;
> +        nodes = nodes - 1;
>          shift = find_last_bit(&nodes, 8);
> -        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << (shift + 1)) |
> -                topo.node_id;
> +        *ecx = (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) | topo_ids.node_id;

Like above, we also need to ensure pkg_id and node_id are withing
reasonable limits, somewhere in the code, and that the limits can
change in the future depending on the CPU model.

>      }
>      *edx = 0;
> +
>  }
>  
>  /*
> @@ -4580,19 +4505,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          switch (count) {
>          case 0: /* L1 dcache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
>                                         eax, ebx, ecx, edx);
>              break;
>          case 1: /* L1 icache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
>                                         eax, ebx, ecx, edx);
>              break;
>          case 2: /* L2 cache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
>                                         eax, ebx, ecx, edx);
>              break;
>          case 3: /* L3 cache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
>                                         eax, ebx, ecx, edx);
>              break;
>          default: /* end of info */
> @@ -4602,7 +4527,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x8000001E:
>          assert(cpu->core_id <= 255);
> -        encode_topo_cpuid8000001e(cs, cpu,
> +        encode_topo_cpuid8000001e(env,
>                                    eax, ebx, ecx, edx);
>          break;
>      case 0xC0000000:
> 

-- 
Eduardo

