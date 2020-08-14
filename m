Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C20C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A2423A78
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l2d7R+Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A2423A78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y5P-0008Fb-TQ
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6y3f-0006LQ-P8
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:25:23 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com
 ([40.107.244.56]:53089 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6y3a-0003Li-00
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:25:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnD3TbxiAEMIOl3MQF3JBQCROeLeNTmIuVTjfPaUIcvaGQeuRxJuYxQ7mf66dYU8fSuSvuF3jSVolFXfyTrN1BISW6mLTVSlApMsn8aDjJYsoDeCQIoWEuivPNhVIYdMEK1FIqSfjLHqj20Yy1AgJUCt2v3UnCd5ANH0kvG6Bvm8vVBBxqintNVsTouAkEg/m0C+RFOynjom3nFW3ivqpZd5VWf5nuBWnN9x4v0v2gN+/RdNkrBOdBT8WVMDma3JYaNhGcE4VcZ7/+E62D1BEhUFTdhx8M0QDFV5kCtIb5U98dGmsPG5n5QD/lf8SReeDgOVzj87aBnSx/cpIApqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B26YppXTwlb/yoLTMJAE5O+ozgEi0uS1W9JnjFNYFpA=;
 b=EPUhkco24Dzba3pXt38jUvtX5+9kIH/D/Mo53/92ZWuRa+p/OLsTTLwOYWZELRoO8WrXH1EvGmEuREV8Y8+2mwSfU4ktZGJiQgc4EzuLaPFtV6K4TMQIgRFzrJ2FC+Ko6nNVt2BtmM2FhD+68yT/iVVYxro2eFi9T7SvnNse6FWjnZOn2Pg+KE6xhmzTqUTKxrVVgQrDonYsGF/FTAJUVHlLx3RYScuPa5E/LKkP3rvHeFU4A0B8VyE+Syjt088rm8I3lUCY9eRuT12cYRofFxm9m9H++juK+bwtdG7KRyYEzD6MMC0zSiifcBwtfJzpv4db8E64Lkf46DblZpH5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B26YppXTwlb/yoLTMJAE5O+ozgEi0uS1W9JnjFNYFpA=;
 b=l2d7R+WhRksvdusk30g1+KJR9NhxGHsb07zJfkBNVnEEPGYiHjiXl5DgrIZaCyJ38T/bNZ+lLvPl23B18P8FiB9W5461v9RQf0SWPp4CSzZZe0rTH76ISuzr7XR5lCWd6hPz+mpgy8LxysNsC3AmG0FCx9sLIX7XUfX99l93eXY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 21:39:28 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3261.026; Fri, 14 Aug 2020
 21:39:28 +0000
Subject: [PATCH v4 1/3] i386: Simplify CPUID_8000_001E for AMD
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 14 Aug 2020 16:39:27 -0500
Message-ID: <159744116751.39197.2874909606354377403.stgit@naples-babu.amd.com>
In-Reply-To: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
References: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0058.namprd02.prod.outlook.com
 (2603:10b6:803:20::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0201CA0058.namprd02.prod.outlook.com (2603:10b6:803:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Fri, 14 Aug 2020 21:39:28 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65731107-9e60-42b0-08f3-08d8409a85a4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4528:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4528D7705F5549A5C0A08AB395400@SA0PR12MB4528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CdlkiiGsyAw/jF8LI3Ffvgb2kc0ZorLo0ClYZZOpel9xVxu2A7Oqd0eApupWYdSwmmx39yT3h+F2qdpwSqWyOtxuH1WU5oJCX+kw+YJrhRDdvyXT5mbN1i1ppb3zXGBRrioaFSHeCatpXBv7y2ssOpiADWoZC6bVtBPnBf0lNoSM6eY3pJvU0nc5Zan4cmGGyRtC2SUbQiyxK+46R5k37fgzmFYa9xg9xwqjew6/57ZqP5hHfU7l2WKsFH92b2Jb9M4bdA+JRreZf492biJsRLLOk0fykxl52fJS7INL0bVP7Nl+BBKv83wOp8EuU2R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(956004)(186003)(16526019)(26005)(316002)(478600001)(8936002)(8676002)(2906002)(86362001)(44832011)(4326008)(52116002)(7696005)(55016002)(83380400001)(5660300002)(66556008)(66476007)(103116003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wcTUOwt9vLaEMxsYVp+dj6SPtEX11ptnHBg/LR1E+Ho0bElcdLa2WVh3hYC7RlFJ+k83iYdFdSSCJxx1kVDApRJvRpD/A9LVQxw65kvByGZcOOHK7fEBsK2Y4wLv9vnNGq/nelZ5Xbw7idBSKdYVztQRVv+RGObEQNfKSEghRZm1so1sj7arK5T8F2BWZfnYoq3LysPa/udwC1psSvd2dgXE1RJSHZIHJhST76cY/zMjtB3rcP1nswwEkS5qqkT2yB4geeoH7REMEMKZffTI/CuZPNTUsnOyp8XtyS+IIoJP2VDxLBtN2itjj9yJpKFDoc+M8hN3Jco/ZHLjvtDJXwgaC2tGt9XNWWS5xuHBIp70fwh99zJJqQ07UzOsMJ2rSbAohr0gtsjSJBUriSbXwhIU5+T1ianPqjWcsCjPyj25vQh5bUpC247aG4Ty/EDeF47P5zc2r2Pn/A0jpCma8oLgdl0hvjrqLTYRb54KdZLEYr3fUwMQkLDcp48yBw6ownW12wuzsetsUl38kFqLYYfvrOvX/kCg/XWeQlDHPlvLP18pw38+9KETITUETXZ10vPGfrNkbzJ9n/ZWVY7isNES5U8I/KGgkhjg9qv5kTXEFSTlWTWndZjoSX6iZ/2NiZowuU6sjQDovr9VXvivmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 65731107-9e60-42b0-08f3-08d8409a85a4
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 21:39:28.6245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5rZjQ9nnf/ALDbAsK1OR4EE5wkaxxj17ag+iajlxYLkojUwvQgAUAdt9DYnYbuR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: amd.com
Received-SPF: none client-ip=40.107.244.56; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 11:25:16
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
 


