Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1F5C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BBE206E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dNMbJ+7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BBE206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJLj-0007Gj-Qy
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuA-0005YT-6l
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIgw-0004Zk-Bx
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:57 -0500
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com
 ([40.107.94.77]:6183 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIgs-0004QT-3j
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqYUHQ+w17Tqzlg47AqR4qy/oBCr9n9lnVWN2WzGmvDoOZQACDWAicTtVMzWfr27ghkCCZFUZd+a6LExV3jU1Dj+xVtzRGd7efkJGQm32PSN/kDF7LR2FmI/OWu7eV6Uz4X9DiKNJEBZMV4ltYRs9TO5HECDOHxNOEPntNWv0PvU8fetCX5MgE9LkSLS4Km3p5LT4+OYQ4aBXC/OT1uo86jguyoi9HyQtWfSbe7XjKZ2dXWM9zIs2QZIwjvXhulEb4acZ396sY5l5HQFgEfS50Dvg/Gw5IS4UkxNi+YD4SMGgrAHECg9tAtX1o7ZwjVQjeHylQE+C/Vr/ZEwxRoM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98Hz0gr/xnLJMSDjeOO3mVGNQCMbhOl9L15bYMb2YuI=;
 b=DPRhBjKQQMyWCyJKgA3RlGlutZ5WSzi8qgakZpQ4ndpaqH7Ppfq+AEVL/j2hG9Zgqf6vSGBZybOr0FC68m2rj1vWMK6OnpGGPbfUd5n++7bV7RS+QCPmauv9AR3lK9UiChm266phjBgOicIL0qL6saGinmUN8Mm7GHEu2g0S5JZIQYsW1tui6BeSpfpE+bYHTSCS1dz3xluq29cYmyh2mHKNtNDmN3nFlygdtpt0LBTd/qrcdbmF0hznGWAwEpAh/rMB8MO3Sd/KqqnF6f4lKWVQ8/DWYNBvY8YEocrcD9/hCrDBIQ/PIctA6hfsf630huA9bLUkPcuTIpft+igEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98Hz0gr/xnLJMSDjeOO3mVGNQCMbhOl9L15bYMb2YuI=;
 b=dNMbJ+7LUSOBmvPKPQ1s80JisMJDrCx8eAJeD1zByGp5EImj4JkYcPvQU9XVW2hRjYuSxd9tjDzi37riiZJU0uLarZfFSuFSf56CRHLnUtvS5K+QG44cu/iwpp2hvtCggu/hAoOCR/X7jBJCGCKCPsJ5Y490MO1NhPpUgiVnMq8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:38:41 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:38:41 +0000
Subject: [PATCH v3 15/18] hw/i386: Introduce apic_id_from_topo_ids handler
 in PCMachineState
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:38:39 -0600
Message-ID: <157541991943.46157.2185735998555897830.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:805:de::29) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbbd3145-a896-44b4-7fbe-08d778524f69
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB136944C37DCF2776E5391422955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(478600001)(7736002)(3846002)(66476007)(230700001)(66556008)(44832011)(4326008)(11346002)(99286004)(14454004)(446003)(6512007)(23676004)(316002)(58126008)(81166006)(76176011)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VW6rlc3EAZkhfm8QMEZCote6ayUo+NHsxSWz9zPUgon0p0ebLoBePbJwwRYaKMGy1ZyS2JAnoRl+E6RDwdvFtfOcRyQKGU4zPxeEM/RrF7Kr6fbj6e4Zv3mxivEMANvih+1r6L1UG/lVAtyvLi/Stc9TD3V4n3xVs+F6uN9Nyo7nTG5sU6ffCYQf3QF5vn1UXjJ0W9OqkBXvbYFfFHhYzMqE42vDyjF4/dMcIcE+7eLfzQ8k07Qp8Y8X1hkz5TBGjhzNSFnpr5JS4x7EaGTHK0Z34GQrqZ5qBJ469BhDDHun8MmVTZYsJ/v+dP5hucdropMvfMln26VlWsO8TAo9jCe2h6N7qtI/GPDpJxuQHT+tko09N9RVE4/ilCM2gkFWI2LlLS0xCxPoDU/7JdJiqshZUmUGUhbDNTCkvU92R0NL8qdKzrtt3pKiRhCbSNqB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbd3145-a896-44b4-7fbe-08d778524f69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:38:41.3088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28YOZNPx9R1ZkjxPQjBu2Gkq2vjwPtx0LliwoGAr+LZPPDpyLiKRp/sGjm5P9MzZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.77
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

Add function pointer apic_id_from_topo_ids in PCMachineState.
Initialize with correct handler based on the mode selected.
Also rename the handler apicid_from_topo_ids to x86_apicid_from_topo_ids
for consistency. x86_apicid_from_topo_ids will be the default handler.

Signed-off-by: Babu Moger <babu.moger@amd.com
---
 hw/i386/pc.c               |    3 ++-
 include/hw/i386/pc.h       |    2 ++
 include/hw/i386/topology.h |    4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b0d58515dd..e6c8a458e7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2305,7 +2305,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.llc_id = cpu->llc_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id = pcms->apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
@@ -2682,6 +2682,7 @@ static void pc_machine_initfn(Object *obj)
     /* Initialize the apic id related handlers */
     pcms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
     pcms->topo_ids_from_apicid = x86_topo_ids_from_apicid;
+    pcms->apicid_from_topo_ids = x86_apicid_from_topo_ids;
 
     pc_system_flash_create(pcms);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ffc5c78164..0789f8b5ea 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -73,6 +73,8 @@ struct PCMachineState {
                                     unsigned cpu_index);
     void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
                                  X86CPUTopoIDs *topo_ids);
+    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
+                                      const X86CPUTopoIDs *topo_ids);
 
     /* Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space. */
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index adb92fe9ce..b2b9e93a06 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -206,7 +206,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
+static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
                                              const X86CPUTopoIDs *topo_ids)
 {
     return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
@@ -259,7 +259,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
 {
     X86CPUTopoIDs topo_ids;
     x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
-    return apicid_from_topo_ids(topo_info, &topo_ids);
+    return x86_apicid_from_topo_ids(topo_info, &topo_ids);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */


