Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED54C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C2020691
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QVEmiM+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C2020691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAKm-0005P8-MD
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 19:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEO-0007j1-EK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEM-0005Tn-Qg
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:40 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com
 ([40.107.94.54]:6114 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCAEM-0005QV-KN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4049yoiEmVqnHtmdp3fbIfQUnv2tjrScOF+493F9ChlG1tLsk5uZmJLVbnyf239ZyiBCPKJQ8zFX7ICf1Cz2xXkpURznJhJtipc1UpdVYpoTX3aaCA6n0oxdMhXQmBk2CveE1WwiTEAPboHHhGcr7fLPDwxzKYpY30XwFyBNuy+CVxy8df95blP5U0w949tsxjicUIrw24HCVqqTkaUwyFisbaC6Sf+9YYbxLwEPEkFkghyxV5hh4hlPOEq5UOHJWhzJadL8RMFp3QiD9UYRazfyYkoQ1yGXSLJdkudHwLcUiro/TX5G1gPSut8LHtJztQCjidz1lpP/AzpEy6NTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AG5OeKZNJ1qUCB6C+Kjzms0jEFjZ2iys33sUKi9JSg=;
 b=cX+Kb1PfEWDv7FhOWc6rNGZSP56VTWWaxIj9beS4rlAPEwhRZAPXYJ/fdWjILuZRngAjaZKelmmOv+bChLSI8n2eGXSKaHqDNCtxrLqDH7Tl2RaCdKkunmFe4ijWbgBA/B4VlyHpqhoFSDLiL5SxPlA/828i6vou0R/XftGcl+KL7diU9PBRYOaqJWFkeF52w2ckQRsg26Sb/RGWi4uUVBcj3G+aRXJTvccyRUmVZ0mh1pcz4Cgnb01M6XXX6dldY2XmbpOdr/8KmcH/qM7tHEyHkGNSFBPhIeZRe+G6LpQy/6MUS+FPxlHGu5pRBXwzzQu2em5Ys+yiHP5ChrnbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AG5OeKZNJ1qUCB6C+Kjzms0jEFjZ2iys33sUKi9JSg=;
 b=QVEmiM+JXeUnBXTBLr33lz2dFCPh9VClUPZViL2nycuRgEClZrpxiCyHZBEZcsBI/oTAASIErN8cn8byZEYjr6p6U/JYstZm4e3grb8IGT0Ky3DTGzXdjjVYCEr+mQ/1vrea4T+WMIvw0qCyJCegc0EU3J+eVkP5Z5GGp4WaK3c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 22:53:36 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:53:36 +0000
Subject: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:53:34 -0500
Message-ID: <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:5:14c::31) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR11CA0054.namprd11.prod.outlook.com (2603:10b6:5:14c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 22:53:35 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a85797ee-75c8-4801-e596-08d7c60f083b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:|SN1PR12MB2349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23492764FD5AF8DAABD2E7EC95FC0@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(44832011)(478600001)(55016002)(5660300002)(956004)(966005)(81166006)(8676002)(7696005)(81156014)(86362001)(103116003)(4326008)(52116002)(16526019)(186003)(66556008)(66946007)(316002)(8936002)(2906002)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2349;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbNSatE0mXiaTkEs+a8P/5idcNZtcU8Y2+Dz8MnGveHCJ52JCccqAAG1B1NtabMGUX9ZoN2ONxvnWujJUUhUtBF7EM4CX3HxHVvD3BUT9ZiJ5VGwzEIFS5pwL1ZCVGw93O43oaaX+tG9Zn/qKanOGvNR7/imtd6S11DI2+PeQn8eL9aLBZpv+39pQvUYnQ3CIwy7WBuf1Ujj62Yd+Phfi2HNrxqnn9+zyX5elhaKsqxO0offlriHbustCm1LQl0MBCjCzJNkYaJslCoHtlSJ5y1iWQAAlNvYHCRliv7xPvXXhOL+qqCIbbAVCvky/BTfbBXaUVASRVzxZIElmXnmQ1Wo/WtQxsDr2Bzwymu9FjXEb50GmKh4jwkJ4gVhwvNa3cAyhi7AN92qRFFwMtoBiTvyNkkhrldlYuP1zWM0RiMoxYBLKv8Phrtrq6H95P50mhjNN7cHsw097bJyweDXjCXgisN9ZFOQDsMnDTDpWzGhBfIqCM5uvwsfIsrEfNYS/01WDW+AlIo1iqkAKyiWDA==
X-MS-Exchange-AntiSpam-MessageData: j0Ql73q9voL9mnUK0MpRw/bJYaQsJ8LXsCzpdv6CGhgEOhOUMEqC/f6Cv1oPXzviAiPdgwciYbgRjjXfZR/9Qc1fLXMuoT7waAQHGOfxGByTTu9QRbO1meLnKyeBppHICRnYbpH+e0lFLTU+bpDdBw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85797ee-75c8-4801-e596-08d7c60f083b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:53:36.2745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIF1eQs2PBDl399QFca4ynLgcWeEJFxsQroGI/ECHpD7I9fsKd3sCk33sdfxFVWi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.54
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


