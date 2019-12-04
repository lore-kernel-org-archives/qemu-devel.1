Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B3B2073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dbwsC8yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B3B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJTR-00023A-9O
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuI-0005YD-Ef
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIfX-0001DH-LJ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:29 -0500
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com
 ([40.107.223.61]:6222 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIfW-0001AY-7F
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wl/xAjS/wniMjRPAFmsK6O5YQf7c0z4vMipkcaXROkrgGuwGpus+pWo+nwczVH5KXWPRWjIOTm7EgzIPHYpZmDnzjNPjZW3VXVWJ3SfLDAcCRKWLTX/axYFqSXaAQrw0bsQdD7hN3U5IajOF1XSt/ZoncV/Key9bcrWk6rl2fCnfw4qT69MnzHwwiDzJ7b4xoEZUxlA9Vj91sUy/XOEOnBVn/4gSz9vM7HC7+UPbra0hULuQVzw1oWjj8dLj5IOMWgo5rRC3/15xGxRDaY6j01m+8j49fH5/dMsnm2bdFL4DzLgECKxgXN9WEyLHekVbx5DkMz7A2TQXgJ1Yqgj4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua9A1tRz+0vUqQy2lFi7dWTDkEQ2fItwHy7U291g3LE=;
 b=RTZK6oTzoUEJr3RDakm2aE/7MqF7GRLgmJypTkx3HM1HHHUrSRxHf3IgbchrMNW0AwoWmfSrfFQfNoTWacPnPkvZJ0WT2UAzOT0XFjDDlwlIHnjSvymlT7IqL6jaXPJ/jvPERniQVObYm4CN76woKzqs7//2JZ39iHDqBt8rAa7e2C+ZTT3Dnbxr8/u0MjiRFnPaBiX8ZhU/wbu5HmfbRD5ZJbB7KUKSVaM+wLNcv5GAzW5vp0uTlIFbjoAwvUoBxGcdnvfq4N9DLQUCA4fltzZbRJiLpf8+UVFECCYqglHfoIQJHGKmEaxG/Y6MlsRChan/D4Sl4xa3Blk1Xcsa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua9A1tRz+0vUqQy2lFi7dWTDkEQ2fItwHy7U291g3LE=;
 b=dbwsC8yzgAGRVy8QcBH1BLUMerIA1RGdiWHaxv6Fdq9A5LIc5W3VGPd6nS7Aiak8f+Ahaorci0xCCafLJSjXdMuFAV34GAT3fCE4dPyGHQG99y2u9vALAQyzHoZzatuuL9FwcONZ6eWnteeKDCtNe8fHO/QxtDclrdeyonFjanY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:37:23 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:37:23 +0000
Subject: [PATCH v3 04/18] hw/i386: Introduce initialize_topo_info to
 initialize X86CPUTopoInfo
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:37:21 -0600
Message-ID: <157541984181.46157.12341489595513709747.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0084.namprd12.prod.outlook.com
 (2603:10b6:802:21::19) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5900a764-c3e1-4e59-cdd1-08d7785220f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369B89B42907566045C6321955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
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
X-Microsoft-Antispam-Message-Info: MYsQ8mvGNP5VEfXVnnwb6tPEhNui1RU/DUEshq/VCmWINkai7PDguSFwL4Yca9WvyA0rwEf1jNt3vRToXUGSSj0qVZhLG53GpwG5PxT+sO+kSWQEsPcXVN2J/WuV1eKotsfWMDkAp9zh96x4asrMSLIcabGIGbxZh0/vhRi3TYoePYDGSs1iW3gII8rSrBWmeZStTJuTbx6gNckC/bI2X8pLFmpXv/7+7d4xOA+o+GSzp6F1CBwxSQf2u1LB2Jw+qSilbgfrEW4jx+ef4JGmGDakrUSiNzfnyDH7OREuJDM4+sfubmZzavT5ncH/BZkcjlNfZnfGh8IzpS3+yxYzmSC3YiRmQQ9EkaALEAup23XxHrAZa8wYVtvjxlwbPwvCxPnmk5GBISfPY8nbxAnhJlDTFgUCRgM58hrCMFW/AEzmEFw1ljDGFtBqi+HWRPJc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5900a764-c3e1-4e59-cdd1-08d7785220f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:37:23.3277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJoop35C7leur2UtDgO758PnHmQFFBr38amw5KwsNP2kUlAu1t/eSgMqLM0bBEAp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.61
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

Initialize all the parameters in one function initialize_topo_info.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8c23b1e8c9..cafbdafa76 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -866,6 +866,15 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
     x86_cpu_set_a20(cpu, level);
 }
 
+static inline void initialize_topo_info(X86CPUTopoInfo *topo_info,
+                                        PCMachineState *pcms,
+                                        const MachineState *ms)
+{
+    topo_info->dies_per_pkg = pcms->smp_dies;
+    topo_info->cores_per_die = ms->smp.cores;
+    topo_info->threads_per_core = ms->smp.threads;
+}
+
 /* Calculates initial APIC ID for a specific CPU index
  *
  * Currently we need to be able to calculate the APIC ID from the CPU index
@@ -882,9 +891,7 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
     uint32_t correct_id;
     static bool warned;
 
-    topo_info.dies_per_pkg = pcms->smp_dies;
-    topo_info.cores_per_die = ms->smp.cores;
-    topo_info.threads_per_core = ms->smp.threads;
+    initialize_topo_info(&topo_info, pcms, ms);
 
     correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
     if (pcmc->compat_apic_id_mode) {
@@ -2231,9 +2238,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
-    topo_info.dies_per_pkg = pcms->smp_dies;
-    topo_info.cores_per_die = smp_cores;
-    topo_info.threads_per_core = smp_threads;
+    initialize_topo_info(&topo_info, pcms, ms);
 
     env->nr_dies = pcms->smp_dies;
 
@@ -2702,9 +2707,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
    PCMachineState *pcms = PC_MACHINE(ms);
    X86CPUTopoInfo topo_info;
 
-   topo_info.dies_per_pkg = pcms->smp_dies;
-   topo_info.cores_per_die = ms->smp.cores;
-   topo_info.threads_per_core = ms->smp.threads;
+   initialize_topo_info(&topo_info, pcms, ms);
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
@@ -2719,10 +2722,6 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
     X86CPUTopoInfo topo_info;
     int i;
 
-    topo_info.dies_per_pkg = pcms->smp_dies;
-    topo_info.cores_per_die = ms->smp.cores;
-    topo_info.threads_per_core = ms->smp.threads;
-
     if (ms->possible_cpus) {
         /*
          * make sure that max_cpus hasn't changed since the first use, i.e.
@@ -2734,6 +2733,9 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 
     ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
+
+    initialize_topo_info(&topo_info, pcms, ms);
+
     ms->possible_cpus->len = max_cpus;
     for (i = 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoIDs topo_ids;


