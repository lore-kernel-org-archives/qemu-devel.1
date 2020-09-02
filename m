Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A053020758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jeu3jhst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A053020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRPT-0003jl-Op
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKr-0002ZF-A0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37955
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKp-0006x5-0a
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599047630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fm97JsftiCaFYSxPLJTeVMrVEud70XBqnUaWgNYjrvg=;
 b=Jeu3jhstQogeEQ1PiEyrCR++RWKCy91JYETxxTeuu6yn1fQJFR2cBAZm7KadZZYOdiKrcT
 wcbuk09wqcJTpaIZEfN4j15FCWlZyKmOvcJwH/w4Ebb+Q5yLxJLDYklVO22OWpQ1jSfKIo
 x49F8JwdJbn4i3Rs8NrpU4LSXYxhod0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-ccYpq73SN-qjB1lS5q2THA-1; Wed, 02 Sep 2020 07:53:48 -0400
X-MC-Unique: ccYpq73SN-qjB1lS5q2THA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56BEC1DDFE;
 Wed,  2 Sep 2020 11:53:47 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 208395D9CC;
 Wed,  2 Sep 2020 11:53:47 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/20] Revert "hw/386: Add EPYC mode topology decoding
 functions"
Date: Wed,  2 Sep 2020 07:53:19 -0400
Message-Id: <20200902115323.850385-17-ehabkost@redhat.com>
In-Reply-To: <20200902115323.850385-1-ehabkost@redhat.com>
References: <20200902115323.850385-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

This reverts commit 7568b205555a6405042f62c64af3268f4330aed5.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <159889936871.21294.1454526726636639780.stgit@naples-babu.amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/topology.h | 100 -------------------------------------
 1 file changed, 100 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 07239f95f4..b9593b9905 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -47,7 +47,6 @@ typedef uint32_t apic_id_t;
 
 typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
-    unsigned node_id;
     unsigned die_id;
     unsigned core_id;
     unsigned smt_id;
@@ -89,11 +88,6 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
     return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
 }
 
-/* Bit width of the node_id field per socket */
-static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
-{
-    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
-}
 /* Bit offset of the Core_ID field
  */
 static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
@@ -114,100 +108,6 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
     return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
 
-#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
-
-/*
- * Bit offset of the node_id field
- *
- * Make sure nodes_per_pkg >  0 if numa configured else zero.
- */
-static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
-{
-    unsigned offset = apicid_die_offset(topo_info) +
-                      apicid_die_width(topo_info);
-
-    if (topo_info->nodes_per_pkg) {
-        return MAX(NODE_ID_OFFSET, offset);
-    } else {
-        return offset;
-    }
-}
-
-/* Bit offset of the Pkg_ID (socket ID) field */
-static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
-{
-    return apicid_node_offset_epyc(topo_info) +
-           apicid_node_width_epyc(topo_info);
-}
-
-/*
- * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
- *
- * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
- */
-static inline apic_id_t
-x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
-                              const X86CPUTopoIDs *topo_ids)
-{
-    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
-           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
-           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
-           (topo_ids->core_id << apicid_core_offset(topo_info)) |
-           topo_ids->smt_id;
-}
-
-static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
-                                              unsigned cpu_index,
-                                              X86CPUTopoIDs *topo_ids)
-{
-    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
-    unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_die;
-    unsigned nr_threads = topo_info->threads_per_core;
-    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
-                                            nr_nodes);
-
-    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
-    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
-    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
-    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
-    topo_ids->smt_id = cpu_index % nr_threads;
-}
-
-/*
- * Calculate thread/core/package IDs for a specific topology,
- * based on APIC ID
- */
-static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
-                                            X86CPUTopoInfo *topo_info,
-                                            X86CPUTopoIDs *topo_ids)
-{
-    topo_ids->smt_id = apicid &
-            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
-    topo_ids->core_id =
-            (apicid >> apicid_core_offset(topo_info)) &
-            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
-    topo_ids->die_id =
-            (apicid >> apicid_die_offset(topo_info)) &
-            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
-    topo_ids->node_id =
-            (apicid >> apicid_node_offset_epyc(topo_info)) &
-            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
-    topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
-}
-
-/*
- * Make APIC ID for the CPU 'cpu_index'
- *
- * 'cpu_index' is a sequential, contiguous ID for the CPU.
- */
-static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
-                                                     unsigned cpu_index)
-{
-    X86CPUTopoIDs topo_ids;
-    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
-    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
-}
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
-- 
2.26.2


