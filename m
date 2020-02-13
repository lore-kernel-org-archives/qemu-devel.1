Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE13C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06BE21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RXmCwjO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06BE21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JDM-0007BJ-VZ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3F-0002IO-ON
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3E-00080e-6m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:25 -0500
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com
 ([40.107.236.59]:6154 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J3E-0007yQ-07
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYihzIUEE0aKX2x6sHGWQP9mdWTOiguOyvAlW6sdHm+LwJT/XVs9r8eizl0bc+GgYpCnaUtk4JniGoU/d9BZDbddkLyqPWcvyRZPRI+pzozHaEpwi6RIHXvvdkn52E905c6NKP1g6347m0tNfIP6+e9cGPccC9Q/tNex/jzbxSOZQ3eak6LjJYz8wjmji1S+wQyNi81iaI4J5vP3G0owGQ/oziUQtJLAwVFNIalCn41jhAmThvDhI5tShWCCnlfQcOFMWMxUqZjAHGqzAQK3R3tG54YBvktrTgQ/15dcUmo3kMQdZ9uOIwWOaxT7p1Zvh0F6ri0LkUcRBMbpsZ2glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIYBW2gJhBgSWdcDai4CPkYqkkG7EamfuD4aXmDQjQc=;
 b=jvYzwe53jLZywJuBqcykNWb2JaObzT7sgmQlqbYccoQ8lFVsby0tZHZsN23jMzXxsCRZQ88kxeU24UVJnUrJRfZ0CvLIuXvMCHlSve+vOSzXVTpYQTyxlM5Y8T5GoY8COfijYKrweYdqBGZtZw4xajvLwhwBjCoAPoL1G3/yAJc8SiuHpfGMYGHBAOkKqhFWNoblIiTkKtw6uLify7kyvTXvkiZaaFO6Yca78KvFh8BG4/QZoFaPByZUtMhouOpiT+h61aVbkIwVxs6zMbpFKh1TfzgiE9gClIk5/ELRKYMOF5efrbgWpXa1H7Z2Vhv8IKQ1gy23LRuw4xVfVLD5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIYBW2gJhBgSWdcDai4CPkYqkkG7EamfuD4aXmDQjQc=;
 b=RXmCwjO8zfoPVyJYwTzbaSpcbzxWKGp1AyIf2Cz4f55BtzCtPlbyk46sJThe3/5v7LKsSKDtWu62HWuvfnYGWQPogIsQkIBlqaHhsdKWdqvspjvcCUFpN2wQ0HvHGhdY6bld0doAv5VOhs/PccC9kOx6d9qtKbboyVhcz6aDzTA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:17:20 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:17:20 +0000
Subject: [PATCH v4 08/16] hw/386: Add EPYC mode topology decoding functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:17:18 -0600
Message-ID: <158161783872.48948.1827981450074223928.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0095.namprd12.prod.outlook.com
 (2603:10b6:802:21::30) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 SN1PR12CA0095.namprd12.prod.outlook.com (2603:10b6:802:21::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 18:17:19 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d335fec2-e8e9-46c9-3846-08d7b0b0f710
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB13186FD0274CEDD975C71B42951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(66946007)(81166006)(26005)(186003)(316002)(2906002)(52116002)(8936002)(8676002)(478600001)(103116003)(86362001)(7696005)(5660300002)(81156014)(4326008)(956004)(16526019)(44832011)(966005)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3nXuDyaFbtrD+Bds2qg7qVdzmwLZV/zVDvCWf7+rqKDuMmQcj4H46KxxXnQ9IgSfL4x066J/N/M3fajakvw0vsBhnCSDysVEGGZ0ie9fGGVT6dpP5ALxutxYlqpHUlTa8T3xp4v+IwcOpQe1jtUmHZ5L/caYeQbbqWqnownFkp7S+c3jNmT1i/vH50JH/4+oBo/qZH6fP+FA6kvgAjFECBhU7yRXWufCqcK5R0SEzUVbqiMx6SCFfe7aqsJn/cZum2NY6dQwqEus4InuqZb+3dME8Cs3Vot+6pWg06tpQfScsQIb1RVeMOHFF+czae0hK79FiKBcLXOonFvMNJ4Pim9AtK6ramr3ogLF1f3LVZWviqWKzRBfB8JVpKOR0VdQo4JdTfMa0lCDKZJaBq8aNiHfNBczmsdC5RgvDh5FPA2dCUSQIwwsWdzmsBMpIhmJto5yAI5iMFVM/DtJHo/h+hNj+s4sVcgvM26rWOQOSIWycUNg9L84kWXnThLy+gB1PoHo6wVkOIvgHxfXtxSDg==
X-MS-Exchange-AntiSpam-MessageData: 9kOkYgQkTZsC4u+RL/SaErEiwfpVxjwR1flAuIdGJQfpbKykxDTknPdPNYA54ZPLtQMqKFhS4VPkz3FaKbqYVWKMBiE9BmvZNdyS7Ko61Iz3/+YT3a0lH41MnbEQA2NpGCzXHl+O/aG7UKsVEy353w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d335fec2-e8e9-46c9-3846-08d7b0b0f710
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:17:20.4141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VT5L/qxj0IHA6xKKUGWNRfEvSl7d0FrHb2Fp+IPIUMptvp0ed2GpE5N485h+iokP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.59
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
 include/hw/i386/x86.h      |    1 
 2 files changed, 94 insertions(+)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 3158157430..d9319dc2ac 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -83,6 +83,11 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
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
@@ -103,6 +108,94 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
     return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
 
+#define LLC_OFFSET 3 /* Minimum LLC offset if numa configured */
+
+/* Bit offset of the node_id field */
+static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
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
+    return apicid_node_offset_epyc(topo_info) + apicid_node_width_epyc(topo_info);
+}
+
+/*
+ * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
+ *
+ * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
+ */
+static inline apic_id_t x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
+                                                      const X86CPUTopoIDs *topo_ids)
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
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d76fd0bbb1..38c2d27910 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -42,6 +42,7 @@ typedef uint32_t apic_id_t;
 
 typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
+    unsigned node_id;
     unsigned die_id;
     unsigned core_id;
     unsigned smt_id;


