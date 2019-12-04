Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE46C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFFC20656
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AfND8L1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFFC20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJ43-0000CE-M9
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icItq-0005YT-EV
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIgK-000351-A4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:18 -0500
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com
 ([40.107.94.60]:29852 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIgE-00031y-KX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evgmAKOTiUB7A9ac1zMAfqMiDdPu1L5NONlS0XVgGg2gJRfgH2fyjoQGchmLMcckz2aFE6BaAttX07UhEUsKcKphUkJWt/zvSiIcTvGvahKpSMQM4Xe9+2mfD5026xlN9tiUpRVxED19LhBgfoa5TQJSrA8m0qHMiBd+taTlFJUwRIzssge6zhAK/mNSI+BQB5nN/0nkpYLZ+Bm3I+fR2DVa4JUZ6jXpuvoXXkqVkyiB4LXhKZjMoect7m0dJnqF4DIAVNmT9eH9d377P3ysRvUi7ORzxg8o+U/OK42xkXyAmd2gIff14JKQPcrUFV2JYpEmgIDtyemoar6FFmUiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYPvnLEwNx4wh/5bDTbClI2XFhzNfeRgUD1gV0xieeE=;
 b=ZL0hIthHhNrh1Y4MC4tx/y4u/IjdvgiunqJGvY/yzdS25LvTxd1Z+Lxv2eS28iN0uoYSki1fA3fhl5EdPWVtWFwM5zOohD6jd3DJZNF9yFPbJwOXspOo6Eu+Z7A2qMHnJ5V7pI+NULhw6Ij8n3dqPJ0WIsIFQd0frvOzDU6LDH9TQBjz+0HmIGZkYAeMvmmhCHMgY5tWZP1gQAdaYahk+sc0AH9Oi2eVevM5p1zY0SQdpwcfioFNr9sMc1IeCyqgCD1BRyCZqtTH4gKRLSnOq5LBfzEAf0TghTTyCUpOxfXRoQkc7NUluF8qrgeiwCAhoQ0MXvye5WG99/vTTc7OOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYPvnLEwNx4wh/5bDTbClI2XFhzNfeRgUD1gV0xieeE=;
 b=AfND8L1r91UhmBMS6p5pCkPh4AqNJvn26hcGZjEBGwJrCN/3NlUzDPXMdXK6Kj5wNUwJcvxxXjFmGGBiVCBXuMOORkTyX/Wws/e1futQd3Jh2hP3GzTEHQii/GirwD0s+1nDAJTdB7zExMr/t4g93znX4RCnIWZ9PFVEG3fiHAI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:38:06 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:38:06 +0000
Subject: [PATCH v3 10/18] hw/386: Add EPYC mode topology decoding functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:38:04 -0600
Message-ID: <157541988471.46157.6587693720990965800.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0078.prod.exchangelabs.com (2603:10b6:800::46) To
 DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa4fd403-23e8-44cb-d9cc-08d778523a9f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13695C8C61691EE2746EB016955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(478600001)(7736002)(3846002)(66476007)(230700001)(66556008)(44832011)(4326008)(11346002)(966005)(99286004)(14454004)(446003)(6512007)(23676004)(316002)(58126008)(81166006)(76176011)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003)(6306002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoYmhzj5QRLOrwhFc41Mr2Oh1liGlBR7EzjC1cUJ5Dz5uPZZd/YAaGMKD6709NCS7LU2wah9Ya7qHl5LqtwyKLtc0dTdc539RO6RDrphGmjRsDZdABVwxRgC8TC6JUhw0F7dATRzh40tDsVOOLtDCPIGDw1uyJHrPa6j2kezJ1ILE+lL8QvkuPwvEDWDS7x4qO67sQGE5PUJ0jONZPxCX6PYGb/KepZ8DJk1zdvqsPrQSFkhKEX67Ln1P0IDPoXTdIz9z9hRVQ7q7NaG5FC9bxk8BxLNDN45qPI5t47L80qdQsTP+MqrJUWrIIQv/AxVtRNcez0r8m9nGopbB3LS+sf51ZD2EbtN/0rWGXB13mb/mZlQWtlbJEfqnO3TPILnCrjvhrpvtGOZblHPiTxz02g5d1HEfJ5NoyYBmDmFDFwHptKHBqFzxkqgrNtr39Xqt4eDzCF+l+YGDERSsRqKyrPlDy+Mmqfiaw8vqC7xkNE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4fd403-23e8-44cb-d9cc-08d778523a9f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:38:06.4909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3JG/HH9b96vaSsqKrr5FO37DUzEPLH2znydyyNY0epBvZeuYOQsWKikHL//Tlfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.60
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions add support for building EPYC mode topology given the smp
details like numa nodes, cores, threads and sockets.

The new apic id decoding is mostly similar to current apic id decoding
except that it adds a new field llc_id when numa configured. Removes all
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
for AMD Family 17h Model 01h, Revision B1 Processors.
https://www.amd.com/system/files/TechDocs/55570-B1_PUB.zip

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/i386/topology.h |   93 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index cfb09312fe..adb92fe9ce 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -89,6 +89,11 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
     return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
 }
 
+/* Bit width of the llc_ID field per socket */
+static inline unsigned apicid_llc_width_epyc(X86CPUTopoInfo *topo_info)
+{
+    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
+}
 /* Bit offset of the Core_ID field
  */
 static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
@@ -109,6 +114,94 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
     return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
 
+#define LLC_OFFSET 3 /* Minimum LLC offset if numa configured */
+
+/* Bit offset of the llc_ID field */
+static inline unsigned apicid_llc_offset_epyc(X86CPUTopoInfo *topo_info)
+{
+    unsigned offset = apicid_die_offset(topo_info) +
+                      apicid_die_width(topo_info);
+
+    if (topo_info->nodes_per_pkg) {
+        return MAX(LLC_OFFSET, offset);
+    } else {
+        return offset;
+    }
+}
+
+/* Bit offset of the Pkg_ID (socket ID) field */
+static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
+{
+    return apicid_llc_offset_epyc(topo_info) + apicid_llc_width_epyc(topo_info);
+}
+
+/*
+ * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
+ *
+ * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
+ */
+static inline apic_id_t apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
+                                                  const X86CPUTopoIDs *topo_ids)
+{
+    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
+           (topo_ids->llc_id << apicid_llc_offset_epyc(topo_info)) |
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
+    topo_ids->llc_id = (cpu_index / cores_per_node) % nr_nodes;
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
+    topo_ids->llc_id =
+            (apicid >> apicid_llc_offset_epyc(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_llc_width_epyc(topo_info));
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
+    return apicid_from_topo_ids_epyc(topo_info, &topo_ids);
+}
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.


