Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD49BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9748520658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+SAMUJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9748520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8k9v-0005rd-RF
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 08:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8k92-0004y0-7W
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 08:58:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8k8y-0005Uz-RT
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 08:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597928291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBvuVzzJpDr6e764BMURvgpPQeSzD86f3oUWAL3Ulfw=;
 b=b+SAMUJyye0rF/KodshTqxXD0uiju09OyQ7ldGNEfFCIXRSABzItfk13I/Lxn3CPWqmCKC
 eDqTez5InHq/NdznMnQASeyvdgOVnJsZdImrVUj8HN5VtQljtRSyh4xfTVQbJFrPGEb1iH
 +cfDW9PSyZIN65JFc372aLDTZcjdKZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-zBGILVmwOL2xT_VsKKDQAg-1; Thu, 20 Aug 2020 08:58:07 -0400
X-MC-Unique: zBGILVmwOL2xT_VsKKDQAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8375FAEF92;
 Thu, 20 Aug 2020 12:58:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9F9D610F3;
 Thu, 20 Aug 2020 12:58:01 +0000 (UTC)
Date: Thu, 20 Aug 2020 14:57:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 3/3] hw/i386: Remove node_id, nr_nodes and
 nodes_per_pkg from topology
Message-ID: <20200820145757.2aa8752d@redhat.com>
In-Reply-To: <2709427a-33e5-c6ad-7ebe-8af889f39604@amd.com>
References: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
 <159744118012.39197.535122421806420639.stgit@naples-babu.amd.com>
 <20200819141852.22743dff@redhat.com>
 <2709427a-33e5-c6ad-7ebe-8af889f39604@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

On Wed, 19 Aug 2020 17:42:58 -0500
Babu Moger <babu.moger@amd.com> wrote:

> On 8/19/20 7:18 AM, Igor Mammedov wrote:
> > On Fri, 14 Aug 2020 16:39:40 -0500
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> >> Remove node_id, nr_nodes and nodes_per_pkg from topology. Use
> >> die_id, nr_dies and dies_per_pkg which is already available.
> >> Removes the confusion over two variables.
> >>
> >> With node_id removed in topology the uninitialized memory issue
> >> with -device and CPU hotplug will be fixed.
> >>
> >> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1828750&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C466254703c904bd4c86c08d8443a0e91%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637334363427680286&amp;sdata=%2Fr7Mucca8Pr%2BrjvwJ6S9zxiIg3HCKAiPp4PvGP3nvZI%3D&amp;reserved=0
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> >>  hw/i386/pc.c               |    1 -
> >>  hw/i386/x86.c              |    1 -
> >>  include/hw/i386/topology.h |   40 +++++++++-------------------------------
> >>  target/i386/cpu.c          |   11 +++--------
> >>  target/i386/cpu.h          |    1 -
> >>  5 files changed, 12 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index 47c5ca3e34..0ae5cb3af4 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -1498,7 +1498,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >>      init_topo_info(&topo_info, x86ms);
> >>  
> >>      env->nr_dies = x86ms->smp_dies;
> >> -    env->nr_nodes = topo_info.nodes_per_pkg;
> >>      env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
> >>  
> >>      /*
> >> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> >> index e90c42d2fc..4efa1f8b87 100644
> >> --- a/hw/i386/x86.c
> >> +++ b/hw/i386/x86.c
> >> @@ -62,7 +62,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
> >>  {
> >>      MachineState *ms = MACHINE(x86ms);
> >>  
> >> -    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
> >>      topo_info->dies_per_pkg = x86ms->smp_dies;
> >>      topo_info->cores_per_die = ms->smp.cores;
> >>      topo_info->threads_per_core = ms->smp.threads;
> >> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> >> index 07239f95f4..05ddde7ba0 100644
> >> --- a/include/hw/i386/topology.h
> >> +++ b/include/hw/i386/topology.h
> >> @@ -47,14 +47,12 @@ typedef uint32_t apic_id_t;
> >>  
> >>  typedef struct X86CPUTopoIDs {
> >>      unsigned pkg_id;
> >> -    unsigned node_id;
> >>      unsigned die_id;
> >>      unsigned core_id;
> >>      unsigned smt_id;
> >>  } X86CPUTopoIDs;
> >>  
> >>  typedef struct X86CPUTopoInfo {
> >> -    unsigned nodes_per_pkg;
> >>      unsigned dies_per_pkg;
> >>      unsigned cores_per_die;
> >>      unsigned threads_per_core;
> >> @@ -89,11 +87,6 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
> >>      return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
> >>  }
> >>  
> >> -/* Bit width of the node_id field per socket */
> >> -static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
> >> -{
> >> -    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
> >> -}
> >>  /* Bit offset of the Core_ID field
> >>   */
> >>  static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
> >> @@ -114,30 +107,23 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
> >>      return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
> >>  }
> >>  
> >> -#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
> >> +#define EPYC_DIE_OFFSET 3 /* Minimum die_id offset if numa configured */  
> >                                                       ^^
> > 
> > from EPYC's pov NUMA is always configured, there no 'if'
> > 
> > but I have a question, is it possible to drop EPYC_DIE_OFFSET
> > and reuse apicid_die_offset(), will it break something?  
> 
> Yes. I am also thinking about it. We can go back to existing
> apicid_die_width().

Given we are using die_id now, we probably can get rid of all
topo hooks to generate apicid.

> Looking back again, I think all these code changes related to node_id is
> causing more issues than fixes. We have added all these code to handle
> some non- SPECed configurations like
>  https://bugzilla.redhat.com/show_bug.cgi?id=1728166.
> 
> Going forward it might create even more issues. Now, I think we should go
> back and remove all these changes and just use the default decoding. Most
> of the SPECed configuration would work just fine. With some non-SPECed
> user inputs, it will create some sub-optimal configuration. If we can live
> with that we will be just fine. I did not anticipate all these problems
> when I originally started this work. Sorry, my bad.

Topology code is complex and sometimes it's easier to add a new thing,
it's just that not every time it turns out as expected.
We overlooked posiblilty to reuse die-id, which has lead to more
complex and fragile outcome.

But it's fine, as long as it gets fixed in the end.



> > The reason for question is that, we (deviating from spec)
> > do allow for unbound core/threads number so die_id, already could
> > be shifted beyound ApicId[5:4], likewise we do allow for unbound
> > sockets so ApicId[6] is also out of spec.
> > If we are fine with ApicId being encoded in these cases out of
> > spec, then why should we insist on DIE_OFFSET minumum at all?
> > Why not just allow existing apicid_die_width() to encode die_id?
> > 
> > In this case it will produce SPECed ApicId if user has provided
> > -smp that matches currently released EPYC's and in all other cases
> > it will be out of spec ApicId like when we set sockets/cores/trheads
> > to out of spec values.
> >     
> >>  /*
> >> - * Bit offset of the node_id field
> >> - *
> >> - * Make sure nodes_per_pkg >  0 if numa configured else zero.
> >> + * Bit offset of the die_id field
> >>   */
> >> -static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
> >> +static inline unsigned apicid_die_offset_epyc(X86CPUTopoInfo *topo_info)
> >>  {
> >> -    unsigned offset = apicid_die_offset(topo_info) +
> >> -                      apicid_die_width(topo_info);
> >> +    unsigned offset = apicid_core_offset(topo_info) +
> >> +                      apicid_core_width(topo_info);
> >>  
> >> -    if (topo_info->nodes_per_pkg) {
> >> -        return MAX(NODE_ID_OFFSET, offset);
> >> -    } else {
> >> -        return offset;
> >> -    }
> >> +    return MAX(EPYC_DIE_OFFSET, offset);
> >>  }
> >>  
> >>  /* Bit offset of the Pkg_ID (socket ID) field */
> >>  static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
> >>  {
> >> -    return apicid_node_offset_epyc(topo_info) +
> >> -           apicid_node_width_epyc(topo_info);
> >> +    return apicid_die_offset_epyc(topo_info) + apicid_die_width(topo_info);
> >>  }
> >>  
> >>  /*
> >> @@ -150,8 +136,7 @@ x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
> >>                                const X86CPUTopoIDs *topo_ids)
> >>  {
> >>      return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> >> -           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
> >> -           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> >> +           (topo_ids->die_id  << apicid_die_offset_epyc(topo_info)) |
> >>             (topo_ids->core_id << apicid_core_offset(topo_info)) |
> >>             topo_ids->smt_id;
> >>  }
> >> @@ -160,15 +145,11 @@ static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
> >>                                                unsigned cpu_index,
> >>                                                X86CPUTopoIDs *topo_ids)
> >>  {
> >> -    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
> >>      unsigned nr_dies = topo_info->dies_per_pkg;
> >>      unsigned nr_cores = topo_info->cores_per_die;
> >>      unsigned nr_threads = topo_info->threads_per_core;
> >> -    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
> >> -                                            nr_nodes);
> >>  
> >>      topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> >> -    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
> >>      topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
> >>      topo_ids->core_id = cpu_index / nr_threads % nr_cores;
> >>      topo_ids->smt_id = cpu_index % nr_threads;
> >> @@ -188,11 +169,8 @@ static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
> >>              (apicid >> apicid_core_offset(topo_info)) &
> >>              ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
> >>      topo_ids->die_id =
> >> -            (apicid >> apicid_die_offset(topo_info)) &
> >> +            (apicid >> apicid_die_offset_epyc(topo_info)) &
> >>              ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
> >> -    topo_ids->node_id =
> >> -            (apicid >> apicid_node_offset_epyc(topo_info)) &
> >> -            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
> >>      topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
> >>  }
> >>  
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index c892432cae..ba0a24f6b8 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -345,7 +345,6 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >>                                         uint32_t *ecx, uint32_t *edx)
> >>  {
> >>      uint32_t l3_cores;
> >> -    unsigned nodes = MAX(topo_info->nodes_per_pkg, 1);
> >>  
> >>      assert(cache->size == cache->line_size * cache->associativity *
> >>                            cache->partitions * cache->sets);
> >> @@ -355,10 +354,9 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >>  
> >>      /* L3 is shared among multiple cores */
> >>      if (cache->level == 3) {
> >> -        l3_cores = DIV_ROUND_UP((topo_info->dies_per_pkg *
> >> -                                 topo_info->cores_per_die *
> >> +        l3_cores = DIV_ROUND_UP((topo_info->cores_per_die *
> >>                                   topo_info->threads_per_core),
> >> -                                 nodes);
> >> +                                 topo_info->dies_per_pkg);
> >>          *eax |= (l3_cores - 1) << 14;
> >>      } else {
> >>          *eax |= ((topo_info->threads_per_core - 1) << 14);
> >> @@ -387,7 +385,6 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
> >>                                         uint32_t *ecx, uint32_t *edx)
> >>  {
> >>      X86CPUTopoIDs topo_ids = {0};
> >> -    unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
> >>  
> >>      x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
> >>  
> >> @@ -433,7 +430,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
> >>       * NodeId is combination of node and socket_id which is already decoded
> >>       * in apic_id. Just use it by shifting.
> >>       */
> >> -    *ecx = ((nodes - 1) << 8) | cpu->node_id;
> >> +    *ecx = ((topo_info->dies_per_pkg - 1) << 8) | cpu->node_id;
> >>      *edx = 0;
> >>  }
> >>  
> >> @@ -5484,7 +5481,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >>      uint32_t signature[3];
> >>      X86CPUTopoInfo topo_info;
> >>  
> >> -    topo_info.nodes_per_pkg = env->nr_nodes;
> >>      topo_info.dies_per_pkg = env->nr_dies;
> >>      topo_info.cores_per_die = cs->nr_cores;
> >>      topo_info.threads_per_core = cs->nr_threads;
> >> @@ -6944,7 +6940,6 @@ static void x86_cpu_initfn(Object *obj)
> >>      FeatureWord w;
> >>  
> >>      env->nr_dies = 1;
> >> -    env->nr_nodes = 1;
> >>      cpu_set_cpustate_pointers(cpu);
> >>  
> >>      object_property_add(obj, "family", "int",
> >> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> >> index e1a5c174dc..4c89bee8d1 100644
> >> --- a/target/i386/cpu.h
> >> +++ b/target/i386/cpu.h
> >> @@ -1629,7 +1629,6 @@ typedef struct CPUX86State {
> >>      TPRAccess tpr_access_type;
> >>  
> >>      unsigned nr_dies;
> >> -    unsigned nr_nodes;
> >>      unsigned pkg_offset;
> >>  } CPUX86State;
> >>  
> >>
> >>  
> >   
> 


