Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A62CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D2A2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAorp29b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D2A2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsCg-0003Ff-3W
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAsC1-0002nd-Mg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:58:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23698
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAsBy-0002Vp-4R
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598435884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwRIESYYkiolV1GNAiXc4HDLxYDJKTNAzKdP43eGpHE=;
 b=gAorp29b0ur2OVXB46FFqIL22LccUdZpA57mOVSf2cEN9/SB02HvWujdm7Bk2lBnuVLhse
 LKKx+BLk9Hdc6I9VpuCevghpA5WJ2JYbZ0mvGfdPCUdkcRaGlr3Rteu5+961eS8VtjdJCh
 waEtP51wEuMxDRgoez1b7Zfy3X6GPTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-4cpdqGbMMFmYTCB1pxta3Q-1; Wed, 26 Aug 2020 05:58:02 -0400
X-MC-Unique: 4cpdqGbMMFmYTCB1pxta3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A0948030B2;
 Wed, 26 Aug 2020 09:58:01 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B15295C1BB;
 Wed, 26 Aug 2020 09:57:56 +0000 (UTC)
Date: Wed, 26 Aug 2020 11:57:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 1/8] hw/i386: Remove node_id, nr_nodes and
 nodes_per_pkg from topology
Message-ID: <20200826115755.558f5ab0@redhat.com>
In-Reply-To: <159804794520.39954.435753698576266461.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <159804794520.39954.435753698576266461.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 17:12:25 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Remove node_id, nr_nodes and nodes_per_pkg from topology. Use
> die_id, nr_dies and dies_per_pkg which is already available.
> Removes the confusion over two variables.
> 
> With node_id removed in topology the uninitialized memory issue
> with -device and CPU hotplug will be fixed.
> 

it would be easier to review if you first put all reverts,
and then this patch on top.

well, to actually avoid that request from others,
I'd suggest just to do that to avoid issue with merging.

other than that patches 2-7/8 look good to me.

> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1828750
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/i386/pc.c               |    1 -
>  hw/i386/x86.c              |    1 -
>  include/hw/i386/topology.h |   40 +++++++++-------------------------------
>  target/i386/cpu.c          |   24 ++++++++++--------------
>  target/i386/cpu.h          |    1 -
>  tests/test-x86-cpuid.c     |   40 ++++++++++++++++++++--------------------
>  6 files changed, 39 insertions(+), 68 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 47c5ca3e34..0ae5cb3af4 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1498,7 +1498,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      init_topo_info(&topo_info, x86ms);
>  
>      env->nr_dies = x86ms->smp_dies;
> -    env->nr_nodes = topo_info.nodes_per_pkg;
>      env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
>  
>      /*
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 67bee1bcb8..f6eab947df 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -62,7 +62,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
>  {
>      MachineState *ms = MACHINE(x86ms);
>  
> -    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
>      topo_info->dies_per_pkg = x86ms->smp_dies;
>      topo_info->cores_per_die = ms->smp.cores;
>      topo_info->threads_per_core = ms->smp.threads;
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 07239f95f4..05ddde7ba0 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -47,14 +47,12 @@ typedef uint32_t apic_id_t;
>  
>  typedef struct X86CPUTopoIDs {
>      unsigned pkg_id;
> -    unsigned node_id;
>      unsigned die_id;
>      unsigned core_id;
>      unsigned smt_id;
>  } X86CPUTopoIDs;
>  
>  typedef struct X86CPUTopoInfo {
> -    unsigned nodes_per_pkg;
>      unsigned dies_per_pkg;
>      unsigned cores_per_die;
>      unsigned threads_per_core;
> @@ -89,11 +87,6 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
>      return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
>  }
>  
> -/* Bit width of the node_id field per socket */
> -static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
> -{
> -    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
> -}
>  /* Bit offset of the Core_ID field
>   */
>  static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
> @@ -114,30 +107,23 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>      return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
>  }
>  
> -#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
> +#define EPYC_DIE_OFFSET 3 /* Minimum die_id offset if numa configured */
>  
>  /*
> - * Bit offset of the node_id field
> - *
> - * Make sure nodes_per_pkg >  0 if numa configured else zero.
> + * Bit offset of the die_id field
>   */
> -static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
> +static inline unsigned apicid_die_offset_epyc(X86CPUTopoInfo *topo_info)
>  {
> -    unsigned offset = apicid_die_offset(topo_info) +
> -                      apicid_die_width(topo_info);
> +    unsigned offset = apicid_core_offset(topo_info) +
> +                      apicid_core_width(topo_info);
>  
> -    if (topo_info->nodes_per_pkg) {
> -        return MAX(NODE_ID_OFFSET, offset);
> -    } else {
> -        return offset;
> -    }
> +    return MAX(EPYC_DIE_OFFSET, offset);
>  }
>  
>  /* Bit offset of the Pkg_ID (socket ID) field */
>  static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
>  {
> -    return apicid_node_offset_epyc(topo_info) +
> -           apicid_node_width_epyc(topo_info);
> +    return apicid_die_offset_epyc(topo_info) + apicid_die_width(topo_info);
>  }
>  
>  /*
> @@ -150,8 +136,7 @@ x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
>                                const X86CPUTopoIDs *topo_ids)
>  {
>      return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> -           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
> -           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> +           (topo_ids->die_id  << apicid_die_offset_epyc(topo_info)) |
>             (topo_ids->core_id << apicid_core_offset(topo_info)) |
>             topo_ids->smt_id;
>  }
> @@ -160,15 +145,11 @@ static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
>                                                unsigned cpu_index,
>                                                X86CPUTopoIDs *topo_ids)
>  {
> -    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
>      unsigned nr_dies = topo_info->dies_per_pkg;
>      unsigned nr_cores = topo_info->cores_per_die;
>      unsigned nr_threads = topo_info->threads_per_core;
> -    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
> -                                            nr_nodes);
>  
>      topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> -    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
>      topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
>      topo_ids->core_id = cpu_index / nr_threads % nr_cores;
>      topo_ids->smt_id = cpu_index % nr_threads;
> @@ -188,11 +169,8 @@ static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
>              (apicid >> apicid_core_offset(topo_info)) &
>              ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
>      topo_ids->die_id =
> -            (apicid >> apicid_die_offset(topo_info)) &
> +            (apicid >> apicid_die_offset_epyc(topo_info)) &
>              ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
> -    topo_ids->node_id =
> -            (apicid >> apicid_node_offset_epyc(topo_info)) &
> -            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
>      topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
>  }
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 588f32e136..3c58af1f43 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -345,7 +345,6 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>                                         uint32_t *ecx, uint32_t *edx)
>  {
>      uint32_t l3_cores;
> -    unsigned nodes = MAX(topo_info->nodes_per_pkg, 1);
>  
>      assert(cache->size == cache->line_size * cache->associativity *
>                            cache->partitions * cache->sets);
> @@ -355,10 +354,9 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>  
>      /* L3 is shared among multiple cores */
>      if (cache->level == 3) {
> -        l3_cores = DIV_ROUND_UP((topo_info->dies_per_pkg *
> -                                 topo_info->cores_per_die *
> +        l3_cores = DIV_ROUND_UP((topo_info->cores_per_die *
>                                   topo_info->threads_per_core),
> -                                 nodes);
> +                                 topo_info->dies_per_pkg);
>          *eax |= (l3_cores - 1) << 14;
>      } else {
>          *eax |= ((topo_info->threads_per_core - 1) << 14);
> @@ -387,7 +385,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>                                         uint32_t *ecx, uint32_t *edx)
>  {
>      X86CPUTopoIDs topo_ids = {0};
> -    unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
> +    unsigned long dies = topo_info->dies_per_pkg;
>      int shift;
>  
>      x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
> @@ -408,7 +406,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>       *             3 Core complex id
>       *           1:0 Core id
>       */
> -    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.node_id << 3) |
> +    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.die_id << 3) |
>              (topo_ids.core_id);
>      /*
>       * CPUID_Fn8000001E_ECX
> @@ -418,8 +416,8 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>       *         2  Socket id
>       *       1:0  Node id
>       */
> -    if (nodes <= 4) {
> -        *ecx = ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.node_id;
> +    if (dies <= 4) {
> +        *ecx = ((dies - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.die_id;
>      } else {
>          /*
>           * Node id fix up. Actual hardware supports up to 4 nodes. But with
> @@ -434,10 +432,10 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>           * number of nodes. find_last_bit returns last set bit(0 based). Left
>           * shift(+1) the socket id to represent all the nodes.
>           */
> -        nodes -= 1;
> -        shift = find_last_bit(&nodes, 8);
> -        *ecx = (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
> -               topo_ids.node_id;
> +        dies -= 1;
> +        shift = find_last_bit(&dies, 8);
> +        *ecx = (dies << 8) | (topo_ids.pkg_id << (shift + 1)) |
> +               topo_ids.die_id;
>      }
>      *edx = 0;
>  }
> @@ -5489,7 +5487,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      uint32_t signature[3];
>      X86CPUTopoInfo topo_info;
>  
> -    topo_info.nodes_per_pkg = env->nr_nodes;
>      topo_info.dies_per_pkg = env->nr_dies;
>      topo_info.cores_per_die = cs->nr_cores;
>      topo_info.threads_per_core = cs->nr_threads;
> @@ -6949,7 +6946,6 @@ static void x86_cpu_initfn(Object *obj)
>      FeatureWord w;
>  
>      env->nr_dies = 1;
> -    env->nr_nodes = 1;
>      cpu_set_cpustate_pointers(cpu);
>  
>      object_property_add(obj, "family", "int",
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e1a5c174dc..4c89bee8d1 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1629,7 +1629,6 @@ typedef struct CPUX86State {
>      TPRAccess tpr_access_type;
>  
>      unsigned nr_dies;
> -    unsigned nr_nodes;
>      unsigned pkg_offset;
>  } CPUX86State;
>  
> diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
> index 049030a50e..bfabc0403a 100644
> --- a/tests/test-x86-cpuid.c
> +++ b/tests/test-x86-cpuid.c
> @@ -31,12 +31,12 @@ static void test_topo_bits(void)
>      X86CPUTopoInfo topo_info = {0};
>  
>      /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1};
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
> @@ -45,39 +45,39 @@ static void test_topo_bits(void)
>  
>      /* Test field width calculation for multiple values
>       */
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 2};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 3};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 4};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 4};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 14};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 14};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 15};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 15};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 16};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 16};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 17};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 17};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
>  
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 30, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 31, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 31, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 32, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 32, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 33, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 33, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
> -    topo_info = (X86CPUTopoInfo) {0, 2, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {2, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
> -    topo_info = (X86CPUTopoInfo) {0, 3, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {3, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
> -    topo_info = (X86CPUTopoInfo) {0, 4, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {4, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
>  
>      /* build a weird topology and see if IDs are calculated correctly
> @@ -85,18 +85,18 @@ static void test_topo_bits(void)
>  
>      /* This will use 2 bits for thread ID and 3 bits for core ID
>       */
> -    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 6, 3};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
>      g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
>      g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
>      g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 6, 3};
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 6, 3};
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
>                       (1 << 2) | 0);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
> 
> 


