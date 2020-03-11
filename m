Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC763C18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E85208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sEQuhJ+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E85208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrDc-0002Cg-Fh
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCG-0000H8-Vv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCC-0007BM-O0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:12 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com
 ([40.107.220.56]:64080 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrCC-00079S-Fg
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbmWugvs+noH/H6Addvh8GTQ55KlJiSNpGgyWkc9Glhm5n7LGQ2PI8N3mKWfRTXMqPxaijUp/A3Hvd9ghldALqu+Qvivzf91Y+rC8rF9fvJ340mb+BjHVMHNVDhEUBPE9MD4kgqTKg25c4WL78gNd2WQjbNt13Kzp0KIxH34XdrpI68ytBcQm/hyVY159EUQKJyv4DoEay8X4uC2264Mh8UK4+CwgS2N6SX/ajsfRkYVBfDvdiAcQ1DPMyIqOKSEJHuLt0qH5jj57KWXwSLFQdtgiRBek0AhaiD3Wp98QNMmUh/76b3pp/R9OAb+6abEDddP11rdX1S2BNKU5rny/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AG5OeKZNJ1qUCB6C+Kjzms0jEFjZ2iys33sUKi9JSg=;
 b=kVo0PqwhPuuMw1BXAqRSYlNjwlhepXKwHJ3ii6TdxFBTFGUTWq5oOE+oBQV4kdDJXkiyNnhtKCXyHwHdEJ5xCLrpFDstFNT0pzmTko+qi3C6qYTrZfPO1TVfouYMUe9SqgJqcmF4ADYMTunLvfVF3pdf/yFecf9YJzHt4FfgtS+ftrUzqEqEYQR7pOd8uf6T0EShIkWgWKZ+IR+k+kGlSw3lSlAqLMrDs3QoxMqV4api4iMvrVr6sZSzGvXfDRdNoe5how5w3VqJTCsrLqvNJD740XQU0zy3lnbThE42yTnlq9/HzbkaCwr92tocDK6yPhzP7WFXXFwoluuf6/XcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AG5OeKZNJ1qUCB6C+Kjzms0jEFjZ2iys33sUKi9JSg=;
 b=sEQuhJ+g5i0YvKIiIBKCWiQnVRyc937OnfEw1hU+tDM5zbuXE4lI/bmXl1a2wdmrVimeIWjKtsvHRHZzRWOiFKYRNzRHRgegrbnZkBEfaDB4OHnFQ6HldRKoF6LLDY33wa5Rb/28LpuSCFQUZLLHLs4J9StCmXzIb2M5JCNoXUQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 02:34:06 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:34:06 +0000
Subject: [PATCH v6 07/13] hw/386: Add EPYC mode topology decoding functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:34:05 -0500
Message-ID: <158389404513.22020.17449886885246869279.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR12CA0068.namprd12.prod.outlook.com
 (2603:10b6:0:57::12) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM3PR12CA0068.namprd12.prod.outlook.com (2603:10b6:0:57::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 02:34:06 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b44c8d35-670c-4ee0-bd3a-08d7c564abd1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:|SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24937B586B90494320F4FAED95FC0@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(86362001)(44832011)(55016002)(66946007)(956004)(8936002)(316002)(8676002)(5660300002)(966005)(66476007)(52116002)(7696005)(103116003)(66556008)(81166006)(4326008)(478600001)(16526019)(2906002)(186003)(81156014)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2493;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHhilLHj7VYW3FSd447VpNxYEk2DoBEN4Nho5j2tF1g3EIKP7EBtjMLXEFd/qWPOWvH+oUs9qR2KJLR1AEL7u5y0xaeCzHcjXmfhtANTwEehp0i5yTmGUO/I76KyGejQNF/XI/bH3CeVEGljygSWqBaDP+gpRJontM0/Kum7gdQdPgb8iIPPOvSm1YFgR1tk1wNWAc1pH12bIS39QlZl8iv0IFFWFoiZzyx1pGUY+K+ZxX4Dgb2gnIjOvc1m3Wd/tVODmXAkCpimNxKT94UxPtxZNy33hhycRqiRBV1iR4bptNi+6uoMFDh7fS5v/pN9W2Ny9postdAl3EoWsBn9qxIdnqBqFgx5BUAuGXgLO+HY6FVF1jlY5xKXrYmP/sAa8ptStU6dGWJ0/sSz56Bw4MyED+wO0Ubu4qpgTnxyrSaiBoT4MW+F1kMcNmfgLvdC0gkSomi9vvrrXLwfRTY+0/GoQ1NTWbIaVDhgRmWvG38AN7mgIanbH1NupKBi8vaj3PYNpyHsCC5CT66nnXL55g==
X-MS-Exchange-AntiSpam-MessageData: INLEzeUlX2FlOaB61GSkIGsg2Xcy81ExyRyD5GLSs6gZV1PzM4NW5HhGx892ZpXJu8oTpJcsudPpSQPEpYBsLR985qG4pmxnhNkPi7pBEm11XZQ1L65QdlUCX0NzltTuHz+j6vO9YmrP3XsLKHIW1A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44c8d35-670c-4ee0-bd3a-08d7c564abd1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:34:06.7614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQFSSe6Duh0t9/XrNhDaewLA1S+UVujljoe4F1X7qn0YLUd19umDejiHxgA0D9X1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.56
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions add support for building EPYC mode topology given the smp
details like numa nodes, cores, threads and sockets.

The new apic id decoding is mostly similar to current apic id decoding
except that it adds a new field node_id when numa configured. Removes all
the hardcoded values. Subsequent patches will use these functions to build
the topology.

Following functions are added.
apicid_llc_width_epyc
apicid_llc_offset_epyc
apicid_pkg_offset_epyc
apicid_from_topo_ids_epyc
x86_topo_ids_from_idx_epyc
x86_topo_ids_from_apicid_epyc
x86_apicid_from_cpu_idx_epyc

The topology details are available in Processor Programming Reference (PPR)
for AMD Family 17h Model 01h, Revision B1 Processors. The revision guides are
available from the bugzilla Link below.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

Signed-off-by: Babu Moger <babu.moger@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/topology.h |  100 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index b9593b9905..07239f95f4 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -47,6 +47,7 @@ typedef uint32_t apic_id_t;
 
 typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
+    unsigned node_id;
     unsigned die_id;
     unsigned core_id;
     unsigned smt_id;
@@ -88,6 +89,11 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
     return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
 }
 
+/* Bit width of the node_id field per socket */
+static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
+{
+    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
+}
 /* Bit offset of the Core_ID field
  */
 static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
@@ -108,6 +114,100 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
     return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
 
+#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
+
+/*
+ * Bit offset of the node_id field
+ *
+ * Make sure nodes_per_pkg >  0 if numa configured else zero.
+ */
+static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
+{
+    unsigned offset = apicid_die_offset(topo_info) +
+                      apicid_die_width(topo_info);
+
+    if (topo_info->nodes_per_pkg) {
+        return MAX(NODE_ID_OFFSET, offset);
+    } else {
+        return offset;
+    }
+}
+
+/* Bit offset of the Pkg_ID (socket ID) field */
+static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
+{
+    return apicid_node_offset_epyc(topo_info) +
+           apicid_node_width_epyc(topo_info);
+}
+
+/*
+ * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
+ *
+ * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
+ */
+static inline apic_id_t
+x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
+                              const X86CPUTopoIDs *topo_ids)
+{
+    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
+           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
+           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
+           (topo_ids->core_id << apicid_core_offset(topo_info)) |
+           topo_ids->smt_id;
+}
+
+static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
+                                              unsigned cpu_index,
+                                              X86CPUTopoIDs *topo_ids)
+{
+    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
+    unsigned nr_dies = topo_info->dies_per_pkg;
+    unsigned nr_cores = topo_info->cores_per_die;
+    unsigned nr_threads = topo_info->threads_per_core;
+    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
+                                            nr_nodes);
+
+    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
+    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
+    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
+    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
+    topo_ids->smt_id = cpu_index % nr_threads;
+}
+
+/*
+ * Calculate thread/core/package IDs for a specific topology,
+ * based on APIC ID
+ */
+static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
+                                            X86CPUTopoInfo *topo_info,
+                                            X86CPUTopoIDs *topo_ids)
+{
+    topo_ids->smt_id = apicid &
+            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
+    topo_ids->core_id =
+            (apicid >> apicid_core_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
+    topo_ids->die_id =
+            (apicid >> apicid_die_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
+    topo_ids->node_id =
+            (apicid >> apicid_node_offset_epyc(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
+    topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
+}
+
+/*
+ * Make APIC ID for the CPU 'cpu_index'
+ *
+ * 'cpu_index' is a sequential, contiguous ID for the CPU.
+ */
+static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
+                                                     unsigned cpu_index)
+{
+    X86CPUTopoIDs topo_ids;
+    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
+    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
+}
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.


