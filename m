Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC1DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150702073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qmuPCWKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150702073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DlI-00017Y-8J
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dfn-00012X-Ug
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dfm-0003CF-Af
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:47 -0500
Received: from mail-eopbgr750070.outbound.protection.outlook.com
 ([40.107.75.70]:29313 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9Dfm-0003C6-4B
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/jdFCDBxUOar5X37xr/PhMClQ4tEGP1QVibzmf2X63KZEf/S5Wd/edoaK0pKzsnbMet/SNIGwDViXBBHh4GLGMZcbFmwXIuguFiuqJIMGH6hTQjr6cDiqoBu1h7hvXt4sfNtj6ImDu+q5OBh5Z8mXW054QKxqzYRs5j3wGSLmlelFFTr2Op3dd2/4jFKXSA9YPbuPRyOTno5QCT65X3sYyufctMFnijzk+PXll3QqfJrHBPO2fgd/qe5oILAjhmmKcPIZXV27fpIAilAI8OUF2bk2VAlNLi/rp658rqFCobhEdEplQXNLyPqU6ZtnpK9ZWK6V9NzfxkzeanL/EDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aSnt20DaxWCSVFSSP+4YY6umab93oj6bPdSDzbD240=;
 b=lhznvSAdHBmuNR4J+X2solOEb8kCbdLEAioIZAf3ARTYy9+yrOcVd1SIEQjynuM1uEjfl7/ahT5/hYbz63e6kaZsevJZCCF8L7+JJA3W7A++gUxU5MYFNa40LihAuxu5DTysEA2W5k2npe5j8RMyedEe0lYbw5/mJapH/hCAwvVDZhdtryRJIN19HT1ZPbhPKA5SHdsIV825iIRDlLjMwZN2o/5i4kia6pELlTmOQtWGiC0tYlxzgUXzqA48PptAMwtB7khbbKxDpa1I88/SPha1spLf4iVhO+scL9+u5ePvnZe33KlhZHVF8grUd2XePuHuJBkb04dwXdubR7sy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aSnt20DaxWCSVFSSP+4YY6umab93oj6bPdSDzbD240=;
 b=qmuPCWKTJbmszlc+FhIP2azoXQ1glwENa3LAb+4An3w4++qsWLjHPLiJtcDh80QDZRmLN2hMZvh1onovpn5OrRYA5DNGXDTCRLGVaTy9XzA68h/0+rY3+hAh0WHDDenmgsKX5ZqOuct4n3Uy9agcgP3I8oEARgfPCpu/+AabctE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:44 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:44 +0000
Subject: [PATCH v5 08/16] hw/386: Add EPYC mode topology decoding functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:57:42 -0600
Message-ID: <158326546286.40452.13430980772455711494.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:5:74::19) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR07CA0042.namprd07.prod.outlook.com (2603:10b6:5:74::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16 via Frontend Transport; Tue, 3 Mar 2020 19:57:43 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdc7fe52-37e1-4fde-249c-08d7bfad2396
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573E6B63CC409F0FFAB150795E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(4326008)(66476007)(478600001)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kz7PPvKxM9gMe2KT6p5CAzRmzpfA2pv4m5jm94JbgOaggWUrF//1tVTztdkvPg4O0u3zeVOuGBoTl3bCyueW1Y3BZ/towhHPZix8mxDv1VRUzoJkokQVSUCl3tWEjDDjRW+h64xSM7qpR9M878xT17fL3CeJdHe7jc90w1bheVHCVj8gFG6Bi+6moO3flTyQceC9qVzIrDE8pboYakGq69vGUhoJ2OKjy+KCQKKQi+qYLQHShE8GbwisTXphhGmoiEfNZfQUizBmb285Nd5dOOV6CB8I60Jq3sP8DPsQdNsEIlcuFvsuZ1If0gvPJ3ScBtUmJ21Kal0Ez/EbIS8ya4wcVVbFwLj5nGbS4Lt64BAycKypodqiDzZ+8c81wQVBbidTWVFqn8CyFy7TZb1EAYWUKA+se1OgV3bcpk2lJwVoM5/os3DQAh49i9ZOJwe1e5EPVVdK+Dsw23uCxp7Cyxy8Q5qu7WSDgWoir9IS0UbtBhCSiMntTbXdioY+P+DpSxUCYTlzDtXDGOSELgOw5A==
X-MS-Exchange-AntiSpam-MessageData: k4FoLEoOJ++0iIp0YiLO8PQc3XNIA3exhxeXMc+tsm/1JS30lkJo98nHVbl/Umxva00QfJelJxT/s0I5HtRZkewyTDHPF9FKJPrVcxtri7prW4GRl6NvS3maOUj4LracoYyOgunzrrKUjtsgWydveg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc7fe52-37e1-4fde-249c-08d7bfad2396
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:44.5633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilpSAMwqNaOTGML5IYixj/G7cHijPOpyN7ZTChxmPZo4tYY6xNWp+ibaiUk+BhcY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.70
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


