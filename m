Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9522EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6149520748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nZbtE4cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6149520748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k45JH-0007Ow-GJ
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 12:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k45IZ-0006kn-EN
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:32:51 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com
 ([40.107.92.64]:44064 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k45IW-0002VT-NA
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:32:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsmDTV2ca7ecd457E3Tw9f3r0KF1ArCuSp/ndJAPmP8PP1j2AOiexnlJfua5wb+Ta+5XhJ4juGU3kFFh8BVvkqxugERHJA5HqqnRlyS5ApcSsDjGAMMazM+LY/IXvq0NC9EnMAJdirhVddvxmdz92OnG6XaBDBB//GWOm9fzE1RgDWkL7Zm92TIX/W2QcmDq7w94vYG7Qyg1A+MrkVlLdOVTeGx61ppCKaKiz98BqehtsNP1mfyewexxfTWYU9tK+PKUHMnXQNuSqn8LK4CtFaj61r58Tl7g0qIfJ0l1nARP8oRSMdDpZa7BxSfEcWvgQJRj28+qgQ9OkldAHjID0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3Bcud70015EEBHv9exnpqLDea/RqX1ukkWulpKXHYM=;
 b=GfG1GGLCIaJ40KnLPx6tkVMn5nlOlIBR9o2/LAWaz8StAhZS6bO2UNBiJMQZXJ2N/Raxh8K6bQ8HriFSwJLrQr8AcdEeYiOPvg8hLHTSqtSik+/BugJqgTNMdPFZqYfSb1gVqv2trwRhoaXP7PsVMJEcdxgqWmJ5Fb3fCCtXEQi7Mtvz9BXwgzq3GjM5+ZRMTDJfj+hHg0ts5qQPsR7aysegDx7eEpl6uiHvJTwTWbh9EuFa2woSAHgy3L5youj3eKoii0xgIAz5esPkQ5tg9CPgTXP73LKdH7+3qJ1qrxHZOUV/tQozXrKQlgrI6kK1Ybm+zF6AIEjFRXV3aZehyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3Bcud70015EEBHv9exnpqLDea/RqX1ukkWulpKXHYM=;
 b=nZbtE4cKWtY3ltXZZ5VGw/3IcK8LIlr2vrJ5yoTpRgGGipJVOGgjIgEcwrJtF1R7Vjn3RWOoRmWoHBITO/2PDekK/9L+PtkzEM4svSq5wctQLIvdkHL4EfbPivLhLEpniJTtSl4xaxX7cvDdkq4GALDJxGp74cgoelIR9FRgi/M=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2429.namprd12.prod.outlook.com (2603:10b6:802:26::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 16:32:46 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 16:32:46 +0000
Subject: [PATCH v3 1/3] i386: Simplify CPUID_8000_001E for AMD
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 07 Aug 2020 11:32:45 -0500
Message-ID: <159681796533.9679.8403552849052625336.stgit@naples-babu.amd.com>
In-Reply-To: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0070.namprd02.prod.outlook.com
 (2603:10b6:803:20::32) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0201CA0070.namprd02.prod.outlook.com (2603:10b6:803:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20 via Frontend
 Transport; Fri, 7 Aug 2020 16:32:46 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f5b9451-2f28-4c30-2b09-08d83aef8443
X-MS-TrafficTypeDiagnostic: SN1PR12MB2429:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24290B963059112BBB24CA4295490@SN1PR12MB2429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUTXmbZCQEbMtruFPwgJAlzM9o3URVgohc7lvQfc11aveK5OUsdcpcd5odouVHiW0/LB1vB1dGuS0xcNn6Hh7D0J3GlOZS91o1gfe0//h3qJb6VPDEjXC1UsVJvc12D66p436Y/YGcmt+HdgKl7sJlR1bu+qqTjHFTNQgKz+SkCp0fIslhZB91BmRiy1znYLMvj1lLF/HmZ2ZBwVAJbWfpTSg/okUJZ2LgqF2dBR7FVbfI1StbxQaSskblJar55QVpdnQ6TQjxDVzLaWv82kJrqJv98CbhShOAcn5ndDWJpV8gDr+2jKFIHvcOzaOEkl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(2906002)(52116002)(7696005)(66946007)(478600001)(316002)(55016002)(16526019)(26005)(186003)(86362001)(44832011)(956004)(103116003)(66556008)(66476007)(4326008)(8676002)(8936002)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1WU2dFa+xsy7r350uiFmS4NCboPDkfZfX+Qi5QxCwRDqdZ83ZmHqcZV3A+QBfN26/l1WXEtgwfj3r1/rPs/dpZ9xZSW8aD2vkqj8tX7t9BfWhac8pIjvQqEG/5kenomyCSJaS8D9Xfo0z3QL0u7egPFsH7MD2HqXoYqpFHlY2+k5f0i3F9UOqY28u5LDAVy1hLgKdkjy40ryX+GzRhQBB3WVUfwzdc4Z9hQnuosVulPt+I6kVbIQvqbtq5v7ATMbI/wT5owfhNuFK2mAz0T8+LAINYExOOeo1b9t7NOnby+ANaALuF4uX40XbfKnCxL5VXN4msTjNxaLuhKWa04+XzGRZh9nX7Ja6VBQkjcjEL8Wt0aVnBgq8n55vsiUkTdIkoY9oycTXeXNJA/s86xXfGyvGO4tWHcuEkJneVXloIq3sl0xQunWPh316JLj80RlzgHJJQKnPR15NWBmw7Q6j6WQ3vP+iaLOZSs2t7Gr03f8r9Ux9GKNcarmMyW2n9WMIf9KNvUag76bEqxhp/B4YMZQ+SNUIOSMGD2NPSQMYyvFw5UoOeFF4gwveQFo7YVgwad3bDILEjTxSE97UmnNsSMbHnF/few+imn7Kdjf3vJDliESwUFqfO75QtzOlrprIr/1R8i1PMPJw0uaoOSpNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5b9451-2f28-4c30-2b09-08d83aef8443
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 16:32:46.4483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywRcCx2WYo0C+MYsIiEIyy4pEC0UAF3igwKBpaQ3QUkfKcWcL24bnl1ru4fXVMSH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2429
Received-SPF: none client-ip=40.107.92.64; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 12:32:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

apic_id contains all the information required to build CPUID_8000_001E.
Also remove the restriction on number bits on core_id and node_id.
Remove all the hardcoded values and replace with generalized
fields.

Refer the Processor Programming Reference (PPR) documentation
available from the bugzilla Link below.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   77 +++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 588f32e136..c892432cae 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -388,57 +388,52 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
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
+    *ecx = ((nodes - 1) << 8) | cpu->node_id;
     *edx = 0;
 }
 


