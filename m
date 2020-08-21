Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFF8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859BD207C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VF8xTNyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859BD207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9FKx-0001QI-P6
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 18:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FIE-0005jm-1H
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:50 -0400
Received: from mail-co1nam11on2088.outbound.protection.outlook.com
 ([40.107.220.88]:26369 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FIC-0002AI-92
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS/nJjj+n2uDzx7+/8K0RWDtefHowclLOw6zNgVEounf1kPBBBzkUyYmNO6nFEP71UofVBnGrg4ewoG5n2f9XNzo6v1sAOzOfXZ+Z2VB0tw7oqC7/xahsKhhvATMMmMOoMeitPfiRsiVfX5dIjEeZXvu1a75ohkDN7dEqT6xgiN/BHvPNisYZIm4NHipJiKv/QPwUYgO2bwaWo/lEAuDyEewoBLRW1KeH6vN3EgVLgv5G5VOkItP0kRzv90HhZtT061CeurkE9H9RRBRZ3l/e/mdeyncvQwcLBmGNP19o2jdDfZoQ7EC+ihyHyK0UUeWKXG57QgD7+sGkKb2hofvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajB3IXkdasp7HSg1LuxDW2TgICDFokJPRSZaL1+zbTw=;
 b=ZxqKTlWx7VfwHDWFYq2yA/IxdKAFhq7tDbQwmUbqsdgM+7gnIxf2ImLRCIDjGb8br5Xy1TDzNoxFntNz43TP0t0BzyJb8T+JeLAKb46fo1ngFpEpw0tcal28n4cfNgZS0ZPHYIUIXyFm7hqneB/F7wRRoemtnrhzBuo+f8TcGDS8V4wyOlPB15LG+JZTAavfbHYNJzfEYqn292tyJ8VSx1mPAyku6CwFsc81hRy3u6Sk7A9A+dvSwh0ikgyuD5G3hKdetvO3dz/RXNEo0pDCeVgW2T1LEvs1gEX+eIAccCgoP2xSE8hZ9uvZxdiHCsXyBtKsNN67KDWXQ6Sw/L6p9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajB3IXkdasp7HSg1LuxDW2TgICDFokJPRSZaL1+zbTw=;
 b=VF8xTNyI5sd7O65m4D5Kihl3WeNakBsXa83vwOJ/fpimO6SziqtNXA39Jm2WvT94CNglyWpuMCE//xFCc72on/Ry7kSckAfoUuz96fjnaBmPyu+KJ+bnQ/NFsJ7ZeUzFX4j8LEuPqKzfnSJlmzNccPJ59RPtKAhisJZ2mbUKP4A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2383.namprd12.prod.outlook.com (2603:10b6:802:26::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:13:10 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 22:13:10 +0000
Subject: [PATCH v5 8/8] i386: Simplify CPUID_8000_001E for AMD
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 21 Aug 2020 17:13:09 -0500
Message-ID: <159804798946.39954.6416009204638021915.stgit@naples-babu.amd.com>
In-Reply-To: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0097.namprd05.prod.outlook.com
 (2603:10b6:803:42::14) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0501CA0097.namprd05.prod.outlook.com (2603:10b6:803:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Fri, 21 Aug 2020 22:13:10 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbf86e7f-5d01-463b-d969-08d8461f63b2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2383:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2383F836F531317D8139E6A8955B0@SN1PR12MB2383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkqN6JkVNNlVAjh72hJJk0dUknQ2CaJtQ/OC3pyT0vSu140tqcColuT7KdkdvgYdGtUdVSC+2ghcYynebfvqhi6W2ReKes4r1a0BGmNP/zs5XnA7Jp649012zTYNUWnauZHSzRKfccdfIH0/d9NvOANscB4hsK/+o3DRlmp0aRojtLMZHMbvzU8jluhi4BkpvmUNK0gVCfB0xL4/tYLZeKO+uG76l446ejaWUpB6XKQy6lauImLXz3nrg4TnSCSEVn14jIywzcUOBZu44f4aT+q+Y6Me6RT1Lhvuo+hhymOCkJCLEIrRsq3WeauQI9ne+B3cqYX+Zce1ikGgP4jYdb55aUWY1VfqtZLOCTYFG8VZf0f3sbKRQXnwmR6k7zeUeNbe2kD7xG+wo94cq24Pi7u13fIjsh2nkNsNxJT9pmARbTfXddfzuSRSBlzbF9yhe+f9cBIkfZJdfAzEL9BgYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(83380400001)(6486002)(2906002)(8676002)(103116003)(956004)(8936002)(44832011)(110011004)(26005)(478600001)(86362001)(966005)(16576012)(316002)(52116002)(66946007)(186003)(66556008)(66476007)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WurHs2nvSDuZsABcunfFx9MkIoMq2vM8hBD7fJMKd9Xn/trCzWWJjN+uq1fai3s25Th7vFUnhCbz6b8WvL8wuSfaWs6Dt0RQ+4VzAoQ1ZiDJmvyMGu/U5TvMiv8n2pdy1lJCtyb6qLPKLn5729Ya16rCwJZoeSA2k5tJXdvbRnt5XOco5Lur4HB4VqwUCqBAx6mN3tuRAixi1BAFX32x/6jQiBJ5f87uf32o2Rvko+IaYbJe/WLwVZRk5DsPaYqiOgFPPTZB5DJQMyYgMIToQzyy9TPcfEMrlsvUh9KGs4oKhf5LT36kTyfSc5G3FMX92pHPmgMNBlCdKph+nsmFZRbCvWQD09zorIOYznlHWIHGfT0MrT0ngeeibsiA8eRBBine93xuD0eEjXv7CU/JCrAu4gxjyduveOFC+vrFsGWBwwbXLwS2+vOlS52E6sYZ0Jo+4SN9LCCB8dhqEQy44D8Ulz3buBhO6vapAsAiN8Ha2oArj3w9JPZHd24nin76KlFTDotDq7lEqpts05tiS1AZcBP51cbP7RJ4zKrW8Sr2bBzyt3/WKwcQ3DBOplR3AxgIzjV7OsCCSBnvzIsY5pKz91v6JJk25TNcBUb8WJfbbyntcBcQCIOLSrfVya/nejdY73fZLp0bKNfdzjgoXw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf86e7f-5d01-463b-d969-08d8461f63b2
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:13:10.5390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATMt+9AyJADPj/2nmtinxkKXoYOHc5YxtWj6WsSYhNqtQMQIaI59jY7HuFWydDTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2383
Received-SPF: none client-ip=40.107.220.88; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 18:13:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

apic_id contains all the information required to build
CPUID_8000_001E. core_id and node_id is already part of
apic_id generated by x86_topo_ids_from_apicid_epyc.
Also remove the restriction on number bits on core_id and
node_id.

Remove all the hardcoded values and replace with generalized
fields.

Refer the Processor Programming Reference (PPR) documentation
available from the bugzilla Link below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   81 ++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 44 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b29686220e..bea2822923 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -385,58 +385,51 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
                                        uint32_t *ecx, uint32_t *edx)
 {
     X86CPUTopoIDs topo_ids = {0};
-    unsigned long dies = topo_info->dies_per_pkg;
-    int shift;
 
     x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
 
     *eax = cpu->apic_id;
+
     /*
-     * CPUID_Fn8000001E_EBX
-     * 31:16 Reserved
-     * 15:8  Threads per core (The number of threads per core is
-     *       Threads per core + 1)
-     *  7:0  Core id (see bit decoding below)
-     *       SMT:
-     *           4:3 node id
-     *             2 Core complex id
-     *           1:0 Core id
-     *       Non SMT:
-     *           5:4 node id
-     *             3 Core complex id
-     *           1:0 Core id
+     * CPUID_Fn8000001E_EBX [Core Identifiers] (CoreId)
+     * Read-only. Reset: 0000_XXXXh.
+     * See Core::X86::Cpuid::ExtApicId.
+     * Core::X86::Cpuid::CoreId_lthree[1:0]_core[3:0]_thread[1:0];
+     * Bits Description
+     * 31:16 Reserved.
+     * 15:8 ThreadsPerCore: threads per core. Read-only. Reset: XXh.
+     *      The number of threads per core is ThreadsPerCore+1.
+     *  7:0 CoreId: core ID. Read-only. Reset: XXh.
+     *
+     *  NOTE: CoreId is already part of apic_id. Just use it. We can
+     *  use all the 8 bits to represent the core_id here.
      */
-    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.die_id << 3) |
-            (topo_ids.core_id);
+    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.core_id & 0xFF);
+
     /*
-     * CPUID_Fn8000001E_ECX
-     * 31:11 Reserved
-     * 10:8  Nodes per processor (Nodes per processor is number of nodes + 1)
-     *  7:0  Node id (see bit decoding below)
-     *         2  Socket id
-     *       1:0  Node id
+     * CPUID_Fn8000001E_ECX [Node Identifiers] (NodeId)
+     * Read-only. Reset: 0000_0XXXh.
+     * Core::X86::Cpuid::NodeId_lthree[1:0]_core[3:0]_thread[1:0];
+     * Bits Description
+     * 31:11 Reserved.
+     * 10:8 NodesPerProcessor: Node per processor. Read-only. Reset: XXXb.
+     *      ValidValues:
+     *      Value Description
+     *      000b  1 node per processor.
+     *      001b  2 nodes per processor.
+     *      010b Reserved.
+     *      011b 4 nodes per processor.
+     *      111b-100b Reserved.
+     *  7:0 NodeId: Node ID. Read-only. Reset: XXh.
+     *
+     * NOTE: Hardware reserves 3 bits for number of nodes per processor.
+     * But users can create more nodes than the actual hardware can
+     * support. To genaralize we can use all the upper 8 bits for nodes.
+     * NodeId is combination of node and socket_id which is already decoded
+     * in apic_id. Just use it by shifting.
      */
-    if (dies <= 4) {
-        *ecx = ((dies - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.die_id;
-    } else {
-        /*
-         * Node id fix up. Actual hardware supports up to 4 nodes. But with
-         * more than 32 cores, we may end up with more than 4 nodes.
-         * Node id is a combination of socket id and node id. Only requirement
-         * here is that this number should be unique accross the system.
-         * Shift the socket id to accommodate more nodes. We dont expect both
-         * socket id and node id to be big number at the same time. This is not
-         * an ideal config but we need to to support it. Max nodes we can have
-         * is 32 (255/8) with 8 cores per node and 255 max cores. We only need
-         * 5 bits for nodes. Find the left most set bit to represent the total
-         * number of nodes. find_last_bit returns last set bit(0 based). Left
-         * shift(+1) the socket id to represent all the nodes.
-         */
-        dies -= 1;
-        shift = find_last_bit(&dies, 8);
-        *ecx = (dies << 8) | (topo_ids.pkg_id << (shift + 1)) |
-               topo_ids.die_id;
-    }
+    *ecx = ((topo_info->dies_per_pkg - 1) << 8) |
+           ((cpu->apic_id >> apicid_die_offset(topo_info)) & 0xFF);
     *edx = 0;
 }
 


