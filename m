Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EEA2076C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d51a74mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EEA2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiOGJ-0005Mw-9z
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 16:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jiOEZ-0004CO-9f
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 16:19:03 -0400
Received: from mail-eopbgr690087.outbound.protection.outlook.com
 ([40.107.69.87]:30852 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jiOEX-0001J4-TT
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 16:19:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgmFWoWCL4MzRJgnrtloXpb+GBBuwWGYwZkuiQ4kog1igRhLFsYmhwT5ate4QGfJg9VQfK/cVFqDLtFaZlsFEYeqVcqJOpcLoKvkMlAJcB7437QzYOTFtoDo4Jl1fa/ciYWNedSz2pn6zvKkplYARHrICSprFeAqdYyW7d7vAIe8OVGW6i/Dvy6mz8MRox+JTgLvrrTcKcd5A7Arn7PQVTQkdatxyvQsCPozr1PaytxhIDPsvsqm61J3kuouuh2BiNL8XjHQKfSOX+yBffB2QSArWljZ4/U7mQpynqxV2eacMBJB09z5aXgAaP49ktZ8Zqy9vUuiCDRJKrYEECAPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGushvHe+gd9cfDthHNWmccQxCFGWhsriOkhIQQb848=;
 b=KVwcjcBnlSYlQ3Ftes4UVTbLC8tZgA+AdGD6L81WpePxqRCQ1JbKYHyi3QAyU1LWUOau1pqWE+Zwibb6kkr5qPCemgkxBjYTBBY3OhTC0xHuYej5VS4wzj6jrlIR9I72cyRPGZ5nri5x6qMT87+qe9vOr8nk5VfnNph5FCx6ZXn+Blv6j5eKtTn6W/0k9XhDcxEL20xfjBwc5v9Cly6mN6IHjqfO0Navman9MuGaTj275NHACxCPiWFocuWm9Qe6z5bmwXt+tpxBcEuyoISiYhdTiHsCU/cU1GhSn6umn/irmChzAon7i+zk8Y3zKpy0IdFpE45+s241lzG/OeAb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGushvHe+gd9cfDthHNWmccQxCFGWhsriOkhIQQb848=;
 b=d51a74mXg0ac5bio215zAD/flEMwkBw7n3rI7qjsC2WwUhsyHowmx31M5fBd8Q9G9YsS2knIXYR4dkI9r6jewY9vM+NDV6tnAeMuOwWtzL5qGrhTRNTz9qiUm6cHj1g4dLhQ3IUkmeflWey5/CPyCYrPi3rG9w5CXrhDkvuDogc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Mon, 8 Jun
 2020 20:18:58 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:18:58 +0000
Subject: [PATCH 2/2] i386: Simplify CPUID_8000_001E for AMD
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, 
 marcel.apfelbaum@gmail.com
Date: Mon, 08 Jun 2020 15:18:56 -0500
Message-ID: <159164753686.20543.4158548114186964547.stgit@naples-babu.amd.com>
In-Reply-To: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
References: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:5:174::19) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR21CA0009.namprd21.prod.outlook.com (2603:10b6:5:174::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.0 via Frontend Transport; Mon, 8 Jun 2020 20:18:57 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a37d0bf-4ecb-41a3-da3f-08d80be92d03
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2558DE674E274F8F2667C4CE95850@SN1PR12MB2558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QcUVjc2TnQgzqtuaNK0DPZR1zOoAioUndlbSBVQK7RUOA8xId5QpB7rnRFbB4wje9aSrP+vMlQzlUKTeBXKBDbHPAEmCImNakLusxx+8ps0Rp57raL4Zna53kJKDiqB1ysO+u45azpVi8JPVcwWX/ekVl0yfzImnx+Hkz+hIRDTFihkULJPpaj+caIXfLoI/oK5GGChO798KwI6/FkHu8ZHeJbThKJ4g0cEetV8xf2UqiC4EibqAFD4sbXm2P1mAAfpgEVH0hr5fHu61vW+KStaG8oI6UOFD2OHqveGdT8aqOa+t4vhONqdHOqZWqGZ/yPzgEkgO+zhcCYndkmxwX2ba2/b8J5F9unXV0mULSPTuJJ6hNHWKVktIi3NONW0z3kz7/IRS/tB3yNCfy/cmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(5660300002)(44832011)(966005)(4326008)(55016002)(66476007)(66946007)(66556008)(86362001)(956004)(478600001)(103116003)(26005)(83380400001)(8676002)(8936002)(2906002)(7696005)(16526019)(316002)(186003)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y7hsf/mhsmIAsle4A1+mBxz/MzDf6mFykXbAu25hC2Kxfx+b06usIh5dU1N4rgLVs3YmBrmeLAH+IjxrXfBFIq2Ub7SXQt4gXpaWYGnuw0E7MP+EGgCbFoxHNX7kOO9rJvO25FWRNfHd4920KNOtq60Cq/lXhXHpQyNp/s4+dIXDV+dXh9li3YDFaCx535TW9ll8a1JXZhApKPaD6crlJxK/oA2Ayah+deVuYWbqsSSlSTCK1dbNyTorxii9G14yI6EtQpMclFNEYb/3qkpnQkGCha8pRQ83ddoE+SReGDoPUACDjOy59K0o8KP373LWOdVM7Q7V09sP0dtR7gd7QxGOGPR7xyuKCJDQUGoe0+RGwEOjv734sFstoTaysmsc0nORmseRqPX+y6rugAg7e+eawRVZF0NoT0diOMYreOVDxjAEB1Bf6tVNm3IReZj7HuvtO+u6FJF06Gc6KeEhCF7nRuEpJZElQ2ZefBRlpxY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a37d0bf-4ecb-41a3-da3f-08d80be92d03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:18:58.4817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onGMyP733e4QtUypJI4+RIK4SZJvcOhJhqhT7SEJCatEFpu5fRjU0Jr2MrOYAxLK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2558
Received-SPF: none client-ip=40.107.69.87; envelope-from=Babu.Moger@amd.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 16:19:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
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
 target/i386/cpu.c |   78 +++++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3733d9a279..166d2f2bde 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -388,57 +388,53 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
 {
     X86CPUTopoIDs topo_ids = {0};
     unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
-    int shift;
 
     x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
 
     *eax = cpu->apic_id;
+
     /*
+     * CPUID_Fn8000001E_EBX [Core Identifiers] (CoreId)
+     * Read-only. Reset: 0000_XXXXh.
+     * See Core::X86::Cpuid::ExtApicId.
+     * Core::X86::Cpuid::CoreId_lthree[1:0]_core[3:0]_thread[1:0];
      * CPUID_Fn8000001E_EBX
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
+     * Bits Description
+     * 31:16 Reserved.
+     * 15:8 ThreadsPerCore: threads per core. Read-only. Reset: XXh.
+     *      The number of threads per core is ThreadsPerCore+1.
+     *  7:0 CoreId: core ID. Read-only. Reset: XXh.
+     *
+     *  NOTE: CoreId is already part of apic_id. Just use it. We can
+     *  use all the 8 bits to represent the core_id here.
      */
-    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.node_id << 3) |
-            (topo_ids.core_id);
+    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.core_id & 0xFF);
+
     /*
+     * CPUID_Fn8000001E_ECX [Node Identifiers] (NodeId)
+     * Read-only. Reset: 0000_0XXXh.
+     * Core::X86::Cpuid::NodeId_lthree[1:0]_core[3:0]_thread[1:0];
      * CPUID_Fn8000001E_ECX
-     * 31:11 Reserved
-     * 10:8  Nodes per processor (Nodes per processor is number of nodes + 1)
-     *  7:0  Node id (see bit decoding below)
-     *         2  Socket id
-     *       1:0  Node id
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
-    if (nodes <= 4) {
-        *ecx = ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.node_id;
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
-        nodes -= 1;
-        shift = find_last_bit(&nodes, 8);
-        *ecx = (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
-               topo_ids.node_id;
-    }
+    *ecx = ((nodes - 1) << 8) |
+            ((cpu->apic_id >> apicid_node_offset_epyc(topo_info)) & 0xFF);
     *edx = 0;
 }
 


