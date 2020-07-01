Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8854C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A012078A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d1h1HDer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A012078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqgbE-0004mR-MU
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jqgZl-0003kR-NV
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:31:13 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com
 ([40.107.68.81]:64518 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jqgZh-0003Sq-Na
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL/p9KrQwZNybYuY53fqcJoYcOH0gVotLuFu2/OmZU3+bwjyy4D8YI/OxK3MbL+GNcOosiBWGcyw3KDMf0bI15PqA0wbUQYl9zV0/uXW5Q+qNREyU/D0LP8973E4Qs1lUmc/9GEAMt9TQEhLU5kre1NbCy9sJ9a1v50wr9U66UgTNJ/rOpSzm2ys2ohOHKRvGMlw+a0eeltZwOMEHBc3m+Fq53h8+kpflGmmuTYFyLaHclTMGsh/k/AyVoZEAGnmsl7lpweet6NFbcFpJXzfSvlFzD8gPM1aFhI0ifzvxJLhG0V9CkARVDNGQBq5gNa/11Cdu+NE+VSCHg7gY8XWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AJUfzgrQ0nhEyNw5/jUEJJe+tp+o0a/OVkRa9tZOsk=;
 b=SuH27QxjoOrYdoPS9N6f93fqAvWb9gpXzJ4NpmnE5zSAfPlOAo9hpmQsOsRrV3UFm61iRPkITOLmrXrOW74ENPgUwkZhChVoQbM/PFp/RuiiAszBaHhs0zvkmOZVsvWf6ESC3mTDAi9z388OHezAYTo1H/CyIMcJkmsQKfAwrmh2VOcEkPaqTfe/LWfspBMjwFVjeN3z3ORgN6WtdCe6lAW2ZQJ+hyizBglZhCM/0DucoAoFLki/mxSgyvzc6X+qUqEBM9QTMs5x7ogTKLCOdtEQ66tD5sxrw3moJ0MGrqOCvJo/iCn5cPXARxS36kHSIy8cfLQFQYG8R/V76mW59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AJUfzgrQ0nhEyNw5/jUEJJe+tp+o0a/OVkRa9tZOsk=;
 b=d1h1HDerY76RDPvUNfJsi6d9sliko55piUr8ExvauBDi58rpuI+U/RTu11EZJiCiMf1CwEuBSEezW9HT6XU2+J41JmsdPK9pA3yNAgs2Yca5bVxGzjOU6KW4F1r1BZ1CWSjgLNHiEtNh1xtZYRT9Ocv4kLKT2hrCZ6XZiKJXP5I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2556.namprd12.prod.outlook.com (2603:10b6:907:a::11)
 by MWHPR12MB1278.namprd12.prod.outlook.com (2603:10b6:300:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 1 Jul
 2020 17:31:03 +0000
Received: from MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::9c8e:f3d8:eb8a:255c]) by MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::9c8e:f3d8:eb8a:255c%6]) with mapi id 15.20.3153.022; Wed, 1 Jul 2020
 17:31:03 +0000
Subject: [PATCH v2 1/3] hw/i386: Initialize topo_ids from CpuInstanceProperties
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Wed, 01 Jul 2020 12:31:01 -0500
Message-ID: <159362466108.36204.3751851750959980962.stgit@naples-babu.amd.com>
In-Reply-To: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:4:ad::37) To MW2PR12MB2556.namprd12.prod.outlook.com
 (2603:10b6:907:a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR07CA0072.namprd07.prod.outlook.com (2603:10b6:4:ad::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Wed, 1 Jul 2020 17:31:02 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 080ed443-52e2-4848-61f0-08d81de48700
X-MS-TrafficTypeDiagnostic: MWHPR12MB1278:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1278ED2099A7619FA83B891D956C0@MWHPR12MB1278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPgWSlwaze5w4P0lyHk/vwg/xBnYKYn/Qggv7Vm0mXGaS0N1WJc3eHQjoKvx8BoptqKQv8sltxl3UXe2cgfwYjbZnpe48XqrSmht5m7eYZDu/nv9BTgYqHRHY8kVWjMR6p29LGkHNtcLuceX0fMUdKxEsSfGXC4o317j7NO1qnKon5WhCCAw8d/ZrJM5p0QE7tq5s0dEAjSnNe2xPnKzMltyhWiRgq4YJRbyAV3eeBIJB3fALoJzZpztRpouA44SzaSWyhkRIn667vIQQ2+FBfjK5KKKEuspHrwxL7yM6BHIIPUFsqFJ6AuGEYOjwcuV9daQFLxnl+82Yww2AJfuGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2556.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(16526019)(316002)(8936002)(8676002)(26005)(66556008)(66946007)(66476007)(55016002)(5660300002)(478600001)(2906002)(186003)(4326008)(44832011)(86362001)(103116003)(7696005)(956004)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: km615CxPJxrPZZAgSd92f65dim70ct0DJWmfTqZsPGETCUO4rKT9CzASz7NQ8o/z4Uwea18nTmOxZ5nF2EyjiJ3i0RgbCiCi6Hiz4t/ApMsphzmDYws956UYoeINKckw9acrE0A/L3pBchaUsV5n9H7AJ5a/KHUoqFsYYKNJYUkcYpeSw5it9+jvlwzyEVYbDDdbFyWfOwC8VjoEH77hufkIR+XTsPZiya8aP2hJxSxg6Q4SPYim0cLVq+EVovPSiCVMMtE3pILstZwp10XPbkCVPbWT32ukya8fnf+jJDwfPKjqAQxEWE7SOtODrNEvnXJocd46a1YRXn90rfEldFXzlbGsYI6gpSTKqyy2Zob3pYAxTUOcxFIE6OfSE+wYNdnIXnkMP+BUMyh9Ap6T3yiZqpnkZl0SVAUhuFvP2epk78qUhzFP6f1I8pHhE41wgZ5tPRiNWaL0bU0pZwaRg05mkMqqHtmaAQWyrP5dKso=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080ed443-52e2-4848-61f0-08d81de48700
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2556.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 17:31:02.9542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/7p03T4yyU0zL1SeiZTPrBRccwuU6MJFfjTFK6OaHEcNVQEIcHHIZCjVIAn24lG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1278
Received-SPF: none client-ip=40.107.68.81; envelope-from=Babu.Moger@amd.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 13:31:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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

This is in preparation to build the apic_id from user
provided topology information.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/i386/topology.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 07239f95f4..7cb21e9c82 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -40,6 +40,7 @@
 
 
 #include "qemu/bitops.h"
+#include "qapi/qapi-types-machine.h"
 
 /* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
  */
@@ -196,6 +197,24 @@ static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
     topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
 }
 
+
+/*
+ * Initialize topo_ids from CpuInstanceProperties
+ * node_id in CpuInstanceProperties(or in CPU device) is a sequential
+ * number, but while building the topology we need to separate it for
+ * each socket(mod nodes_per_pkg).
+ */
+static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
+                                     CpuInstanceProperties props,
+                                     X86CPUTopoIDs *topo_ids)
+{
+    topo_ids->smt_id = props.has_thread_id ? props.thread_id : 0;
+    topo_ids->core_id = props.has_core_id ? props.core_id : 0;
+    topo_ids->die_id = props.has_die_id ? props.die_id : 0;
+    topo_ids->node_id = props.has_node_id ?
+                        props.node_id % MAX(topo_info->nodes_per_pkg, 1) : 0;
+    topo_ids->pkg_id = props.has_socket_id ? props.socket_id : 0;
+}
 /*
  * Make APIC ID for the CPU 'cpu_index'
  *


