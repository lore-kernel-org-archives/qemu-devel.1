Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA34C35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC6820661
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecYq8veE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC6820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j69SN-0002XD-Vo
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 03:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j69Rl-000241-Dq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j69Rj-0002xe-VH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:50:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37472
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j69Rj-0002xO-PH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582534235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMdA/nzarkMT/w4zy0pSVBVlx1fVxdaZjeR+3bCJxb8=;
 b=ecYq8veEklSQCrRrEjD3D6NFb7KVp3Kx5ZpAjtxUZsQTDsk5mM49u86ztZgLUq6JnpsQ2g
 qI0FcGAPXy99NlJKQTCxkfwCv2vj4C7QFF8t6ajqAGJ4B7jucja8FeHYCSP/e6VGbfX1Jj
 RhVsChWMByb0XPUoXhylU1uv2BKQi7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Q2lw-z3RO3i0Vu04HQT8Gg-1; Mon, 24 Feb 2020 03:50:29 -0500
X-MC-Unique: Q2lw-z3RO3i0Vu04HQT8Gg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C11D118A5505;
 Mon, 24 Feb 2020 08:50:27 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71EDF5D9CD;
 Mon, 24 Feb 2020 08:50:23 +0000 (UTC)
Date: Mon, 24 Feb 2020 09:50:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 08/16] hw/386: Add EPYC mode topology decoding functions
Message-ID: <20200224095021.78472314@redhat.com>
In-Reply-To: <158161783872.48948.1827981450074223928.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161783872.48948.1827981450074223928.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Thu, 13 Feb 2020 12:17:18 -0600
Babu Moger <babu.moger@amd.com> wrote:

> These functions add support for building EPYC mode topology given the smp
> details like numa nodes, cores, threads and sockets.
> 
> The new apic id decoding is mostly similar to current apic id decoding
> except that it adds a new field llc_id when numa configured. Removes all

llc_id/nodes_per_pkg

> the hardcoded values. Subsequent patches will use these functions to build
> the topology.
> 
> Following functions are added.
> apicid_llc_width_epyc
> apicid_llc_offset_epyc
> apicid_pkg_offset_epyc
> apicid_from_topo_ids_epyc
> x86_topo_ids_from_idx_epyc
> x86_topo_ids_from_apicid_epyc
> x86_apicid_from_cpu_idx_epyc
> 
> The topology details are available in Processor Programming Reference (PPR)
> for AMD Family 17h Model 01h, Revision B1 Processors.
> https://www.amd.com/system/files/TechDocs/55570-B1_PUB.zip

also checkpatch doesn't like this patch for too long strings.
with that fixed
  Acked-by: Igor Mammedov <imammedo@redhat.com>


PS:
similar checkpatch warnings should be fixed in preceding patches


> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  include/hw/i386/topology.h |   93 ++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/i386/x86.h      |    1 
>  2 files changed, 94 insertions(+)
> 
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 3158157430..d9319dc2ac 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -83,6 +83,11 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
>      return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
>  }
>  
> +/* Bit width of the node_id field per socket */
> +static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
> +{
> +    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
> +}
>  /* Bit offset of the Core_ID field
>   */
>  static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
> @@ -103,6 +108,94 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>      return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
>  }
>  
> +#define LLC_OFFSET 3 /* Minimum LLC offset if numa configured */
> +
> +/* Bit offset of the node_id field */
> +static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
> +{
> +    unsigned offset = apicid_die_offset(topo_info) +
> +                      apicid_die_width(topo_info);
> +
> +    if (topo_info->nodes_per_pkg) {
> +        return MAX(LLC_OFFSET, offset);
> +    } else {
> +        return offset;
> +    }
> +}
> +
> +/* Bit offset of the Pkg_ID (socket ID) field */
> +static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
> +{
> +    return apicid_node_offset_epyc(topo_info) + apicid_node_width_epyc(topo_info);
> +}
> +
> +/*
> + * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> + *
> + * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
> + */
> +static inline apic_id_t x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
> +                                                      const X86CPUTopoIDs *topo_ids)
> +{
> +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> +           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
> +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
> +           topo_ids->smt_id;
> +}
> +
> +static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
> +                                              unsigned cpu_index,
> +                                              X86CPUTopoIDs *topo_ids)
> +{
> +    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
> +    unsigned nr_dies = topo_info->dies_per_pkg;
> +    unsigned nr_cores = topo_info->cores_per_die;
> +    unsigned nr_threads = topo_info->threads_per_core;
> +    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
> +                                            nr_nodes);
> +
> +    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> +    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
> +    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
> +    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
> +    topo_ids->smt_id = cpu_index % nr_threads;
> +}
> +
> +/*
> + * Calculate thread/core/package IDs for a specific topology,
> + * based on APIC ID
> + */
> +static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
> +                                            X86CPUTopoInfo *topo_info,
> +                                            X86CPUTopoIDs *topo_ids)
> +{
> +    topo_ids->smt_id = apicid &
> +            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
> +    topo_ids->core_id =
> +            (apicid >> apicid_core_offset(topo_info)) &
> +            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
> +    topo_ids->die_id =
> +            (apicid >> apicid_die_offset(topo_info)) &
> +            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
> +    topo_ids->node_id =
> +            (apicid >> apicid_node_offset_epyc(topo_info)) &
> +            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
> +    topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
> +}
> +
> +/*
> + * Make APIC ID for the CPU 'cpu_index'
> + *
> + * 'cpu_index' is a sequential, contiguous ID for the CPU.
> + */
> +static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
> +                                                     unsigned cpu_index)
> +{
> +    X86CPUTopoIDs topo_ids;
> +    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
> +    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
> +}
>  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>   *
>   * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index d76fd0bbb1..38c2d27910 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -42,6 +42,7 @@ typedef uint32_t apic_id_t;
>  
>  typedef struct X86CPUTopoIDs {
>      unsigned pkg_id;
> +    unsigned node_id;
>      unsigned die_id;
>      unsigned core_id;
>      unsigned smt_id;
> 


