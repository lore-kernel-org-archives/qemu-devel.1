Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78560C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F55020637
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="te+yGfOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F55020637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrIl-00046U-EW
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCn-0000p8-J3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCm-0008OH-CX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:45 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com
 ([40.107.223.50]:30681 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrCm-0008ND-5d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4h01xljUYc34C/iZr7svZZF/e5of5WVxVuKQR6jtZXYAOM+lSn+nsL/rdNqFwZmF+wW1vFa6tJ02tsJbmtJoqxZ/iuwLDp69QCfeelBF3nLOvtqZW9IElpf1nEAOaJxK/g0qnVdctDu5Ca/mxIJK+Hgbx78FIvxRh36oJCB3Eh1jZsO0ryj/McWljsxH52haXyyO4XH4jLJbdSxH7lfS2r8NBTShGuuuxITzY6yFxNKPEAU8QBraCW8W7h2XT2M2Br2XOtKy+OgMivEMNNr8O4SnfTz0J7rRTCIxIASaPkMQ13TeiYDCB2AhgnKMu6HmCYrNNQncoVuSmz5ggAlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kheVtia0FVluOWYg+yvdJxT0y1+9wRaQ7qR5fw59GBQ=;
 b=kqvRFsG2dWHEbpiKlr0mqm6dNek3MF1gE0EqNVj+8CVTiSJqW2R/yZ3ZytVu/oIGAnku8YW7Xmfb2MC6VALhpUjhJRTwXG/E9Cpp/5reowMgWQLIBxIu/+1AKneCx9PLjIp74avOBuE/QPmk5iUTqeeYAeSQ5raqdP8vBG1Z4sO9g0ZtMdaXFPE/SYc54DkXY/EAWe/uUm8bcM+6K87A/hjZLWqzGUl2KE6hJkgNm5rFG0vMbUMiIZ9yWQOB6LAHwR1dbtQ5/dQ9xFmzoV42OtA1f4Qb3XdU+8Kxb0IvwhrD+EjblR8CQrvnM3IVLqSKOVAyFselWCM/kzCTSJ14ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kheVtia0FVluOWYg+yvdJxT0y1+9wRaQ7qR5fw59GBQ=;
 b=te+yGfOnf7XIlguIg8c1tckS51cebLab6Xi1eNqMPpDErThKwgL9UU3LiKMCHBoM4b5UCWQ20H2LjLBNyDl2CFJvukTf9QOinFWcSgWWeKARe/qMXYJFSIXQbkObv7pU0uZNOw8OQlU1pF9ZWl5L/s8KSsm/w6Y7UGt4Tnvk8EI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 02:34:41 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:34:41 +0000
Subject: [PATCH v6 12/13] hw/i386: Move arch_id decode inside x86_cpus_init
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:34:39 -0500
Message-ID: <158389407977.22020.8482854741622304295.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:3:37::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR06CA0058.namprd06.prod.outlook.com (2603:10b6:3:37::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 11 Mar 2020 02:34:40 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e9a404d-4f95-4e3b-5f23-08d7c564c07b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB257588D035D34A30A54712FB95FC0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(103116003)(81166006)(81156014)(8936002)(8676002)(7696005)(186003)(16526019)(66556008)(66476007)(2906002)(55016002)(5660300002)(52116002)(44832011)(956004)(66946007)(478600001)(316002)(4326008)(86362001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2575;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9NSR0E/9jKeNnUQmYG3vyOV97VlQj0mfEt+6EA7h9cmfjQZOcNwLx/ntJlfu3vbBweGIS1+zGGMvLawt7W2ZFPiyC1CAXvB8IIXJhdGE3JRmBT4XGSttCd/HitXnSwv7InU/t45nhTX1UYzEynwn0r2/oV+3li47vWTk8ip2m+ma9ihF+9qNryXdFHDYixlJHj/r44UsY20jUHC2kcPkal9dfuSzEutxi1sSHnNJAflhwURJdJHYFrxQgZQUDSbgYivlVvkaM8XrmhKDHEXXso9hd+VGYERbn26Evg2xYYeEOOzgkj95358kLTZ13Gj+0fuyGibyIOoSuL/I1YssLVLq1WAxgHdfwd41Wjj6j2BzAethJBFtm0gQ6hW+jE7Exmim/Vu8Lyh8gzqYRrT+iPvvyyzN0VmS0KFsEKnNRWbwCT70eGExQgO2TV7Pz2s
X-MS-Exchange-AntiSpam-MessageData: jsx0OCbRzEivcj/0w+2lISoJmjogoTge14v+JZkjCQ3cawH0Zgs+MeXvM/o0AFK4WWRSKsaPEIre9u3jnyqOUEv0W1ixLKz0pG94vGWFH9O7t4JozOvcT6mhMPKNhUXiwlNorBQxlJVBwIPPHlMrAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9a404d-4f95-4e3b-5f23-08d7c564c07b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:34:41.4805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb60H+wMPXjbxIMTeu8PmOa+YCapICs8y4QscUKTIr9Gh6W7QYgd6ez0gz692szk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.223.50
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

Apicid calculation depends on knowing the total number of numa nodes
for EPYC cpu models. Right now, we are calculating the arch_id while
parsing the numa(parse_numa). At this time, it is not known how many
total numa nodes are configured in the system.

Move the arch_id inside x86_cpus_init. At this time smp parse is already
completed and numa node information is available.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index ad85347142..be93c1fd1b 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -140,6 +140,9 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     MachineState *ms = MACHINE(x86ms);
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
 
+    /* Check for apicid encoding */
+    x86_check_apic_id_encoding(ms);
+
     x86_cpu_set_default_version(default_cpu_version);
 
     /*
@@ -153,6 +156,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
                                                       ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        ms->possible_cpus->cpus[i].arch_id =
+            x86_cpu_apic_id_from_index(x86ms, i);
+    }
+
     for (i = 0; i < ms->smp.cpus; i++) {
         x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
@@ -177,8 +186,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                               &topo_info, &topo_ids);
+   x86ms->topo_ids_from_idx(&topo_info, idx, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -212,10 +220,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
-        ms->possible_cpus->cpus[i].arch_id =
-            x86_cpu_apic_id_from_index(x86ms, i);
-        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                    &topo_info, &topo_ids);
+        x86ms->topo_ids_from_idx(&topo_info, i, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {


