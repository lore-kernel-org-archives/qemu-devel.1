Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA9AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210BD20767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFATEdgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210BD20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5Ed-0001mN-3O
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5Cu-0008Ih-T9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:16:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36334
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5Cr-0006Gg-Kz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598962568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=no2gyjwIIgVVt0avG/6pTrXZuo6fvw0FPiFN3tYnKT4=;
 b=NFATEdgjTMtX70HWTp4ubDcNLqi7BckTDaDUJVmSs8W+OBM4s1WqkihUmUxu6r0TFcPLXA
 W3NfmAp3U5agYQ16lUovq4m5mXjyxrLMVNOXMPSfM7Dkmcuwg7RH+K1r1mQhBPTHztpRWf
 Ni3iOIBa+hP1nlox1MJMoWNI1ojQtps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-rht7NDo7Ma6xFGfZwTi8Yg-1; Tue, 01 Sep 2020 08:16:04 -0400
X-MC-Unique: rht7NDo7Ma6xFGfZwTi8Yg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D25501005E62;
 Tue,  1 Sep 2020 12:16:03 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7563460BE2;
 Tue,  1 Sep 2020 12:15:59 +0000 (UTC)
Date: Tue, 1 Sep 2020 14:15:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 07/10] Revert "hw/386: Add EPYC mode topology
 decoding functions"
Message-ID: <20200901141557.07f584ab@imammedo-mac>
In-Reply-To: <159889936871.21294.1454526726636639780.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889936871.21294.1454526726636639780.stgit@naples-babu.amd.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 13:42:48 -0500
Babu Moger <babu.moger@amd.com> wrote:

> This reverts commit 7568b205555a6405042f62c64af3268f4330aed5.
> 
> Remove the EPYC specific apicid decoding and use the generic
> default decoding.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/topology.h |  100 --------------------------------------------
>  1 file changed, 100 deletions(-)
> 
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 07239f95f4..b9593b9905 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -47,7 +47,6 @@ typedef uint32_t apic_id_t;
>  
>  typedef struct X86CPUTopoIDs {
>      unsigned pkg_id;
> -    unsigned node_id;
>      unsigned die_id;
>      unsigned core_id;
>      unsigned smt_id;
> @@ -89,11 +88,6 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
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
> @@ -114,100 +108,6 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>      return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
>  }
>  
> -#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
> -
> -/*
> - * Bit offset of the node_id field
> - *
> - * Make sure nodes_per_pkg >  0 if numa configured else zero.
> - */
> -static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
> -{
> -    unsigned offset = apicid_die_offset(topo_info) +
> -                      apicid_die_width(topo_info);
> -
> -    if (topo_info->nodes_per_pkg) {
> -        return MAX(NODE_ID_OFFSET, offset);
> -    } else {
> -        return offset;
> -    }
> -}
> -
> -/* Bit offset of the Pkg_ID (socket ID) field */
> -static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
> -{
> -    return apicid_node_offset_epyc(topo_info) +
> -           apicid_node_width_epyc(topo_info);
> -}
> -
> -/*
> - * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> - *
> - * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
> - */
> -static inline apic_id_t
> -x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
> -                              const X86CPUTopoIDs *topo_ids)
> -{
> -    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> -           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
> -           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> -           (topo_ids->core_id << apicid_core_offset(topo_info)) |
> -           topo_ids->smt_id;
> -}
> -
> -static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
> -                                              unsigned cpu_index,
> -                                              X86CPUTopoIDs *topo_ids)
> -{
> -    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
> -    unsigned nr_dies = topo_info->dies_per_pkg;
> -    unsigned nr_cores = topo_info->cores_per_die;
> -    unsigned nr_threads = topo_info->threads_per_core;
> -    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
> -                                            nr_nodes);
> -
> -    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> -    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
> -    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
> -    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
> -    topo_ids->smt_id = cpu_index % nr_threads;
> -}
> -
> -/*
> - * Calculate thread/core/package IDs for a specific topology,
> - * based on APIC ID
> - */
> -static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
> -                                            X86CPUTopoInfo *topo_info,
> -                                            X86CPUTopoIDs *topo_ids)
> -{
> -    topo_ids->smt_id = apicid &
> -            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
> -    topo_ids->core_id =
> -            (apicid >> apicid_core_offset(topo_info)) &
> -            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
> -    topo_ids->die_id =
> -            (apicid >> apicid_die_offset(topo_info)) &
> -            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
> -    topo_ids->node_id =
> -            (apicid >> apicid_node_offset_epyc(topo_info)) &
> -            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
> -    topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
> -}
> -
> -/*
> - * Make APIC ID for the CPU 'cpu_index'
> - *
> - * 'cpu_index' is a sequential, contiguous ID for the CPU.
> - */
> -static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
> -                                                     unsigned cpu_index)
> -{
> -    X86CPUTopoIDs topo_ids;
> -    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
> -    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
> -}
>  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>   *
>   * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
> 


