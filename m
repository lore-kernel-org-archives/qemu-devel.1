Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813D6C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7DB20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bVal49ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7DB20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbt1-0000qj-Bs
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrN-00071c-RM; Mon, 04 May 2020 10:14:17 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com
 ([40.107.92.64]:21177 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrM-0005ZF-Hi; Mon, 04 May 2020 10:14:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4R5LQIQkdZAo4ufqhaQU4S7GBGjvDS58KS3TCg9KyQaFUxhs1k+Tja8ZkjTZuRMWtpJUC7o8ncWbBrHq6uj9qFO9u6UhELA+4BY1xtl1IgynEPmWB7kPSM4/XOeqQFp8A0/Gk7BaXYT2Rn/0pAD8dg6jeolYIIaGv+S9o8xcmD59aINy2fRgjoxtopIziRVYMhbTKTVaihE+FXlJ1xNvf90YoU/H6/UyIw9UBsXTue3UB2hO0OfBlIq7Kr737DphB/4x+yU4yIfKDFey1/2Tg/OW4Uu50eg1ECUGOp0lH5mCwK/3E+6SEZt/5lFTuz5EauBYuVcshkLHsYrmugQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNypU1hmvTA3ufvj5CT0uiTWGobo8vak4WTs0wpZ9rg=;
 b=QNnSQ3XhHFdGBK+AZJDeja1x6MPUo13bXR9d6gyHkOm5J06ybU8fSQ7Xe2DVMoqXXOxoui41P1S9qXzVavpDH9SYL3uJNXRnnyMEYVTyzKraC3bDK43oQmBXUHP7uQ5arZcQj7j7T3DNpKMVILYkGgkTtZLOagYwydi7j14DiT55a1MDgx6EUxusKj5MFh5HD7mImXaM0GLyF5X0xMI8IebRyi28U/t0UwWiG7JinDzm7hWXOL9VQvGbVDuKwGy0YWEqV5w9N02hJzeBkvdmxYVixYkhMc1e4ZaUfqhWxTgdrVcgyWQWxpY2PjIlfhLfU5UxnuOccU9U7tJUbdTtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNypU1hmvTA3ufvj5CT0uiTWGobo8vak4WTs0wpZ9rg=;
 b=bVal49ruD+wC079+eIqDygrAFSwLt4qxxvtzi8XWgfeO+LQREF0Nb5Z2EuMwS1tvJTLprKZx+MU22xMs9pSC5oNFBFkCBh7MpVtiCXv0T3yEehoZyYtr5ZTzJKotZi5tNlAC8L1UYyQOTSViVhe4rywSbRmbS0QwN7vvavsHkOk=
Received: from CY1PR07CA0005.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::15) by MN2PR02MB6766.namprd02.prod.outlook.com
 (2603:10b6:208:1dc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 14:14:13 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:e400:c60a:cafe::d0) by CY1PR07CA0005.outlook.office365.com
 (2a01:111:e400:c60a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 14:14:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:12
 +0000
Received: from [149.199.38.66] (port=42972 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrD-0000Gb-1T; Mon, 04 May 2020 07:14:07 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrI-0000vr-Lv; Mon, 04 May 2020 07:14:12 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrI-0000vi-4Q; Mon, 04 May 2020 07:14:12 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id D26F513C2E73; Mon,  4 May 2020 19:36:30 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 03/10] net: cadence_gem: Fix irq update w.r.t queue
Date: Mon,  4 May 2020 19:36:01 +0530
Message-Id: <1588601168-27576-4-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(46966005)(4326008)(36756003)(336012)(498600001)(70586007)(42186006)(70206006)(426003)(5660300002)(186003)(110136005)(8676002)(8936002)(81166007)(26005)(6266002)(2906002)(82310400002)(6666004)(47076004)(2616005)(356005)(309714004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0391a052-4ce2-4d93-65ca-08d7f0356bdf
X-MS-TrafficTypeDiagnostic: MN2PR02MB6766:
X-Microsoft-Antispam-PRVS: <MN2PR02MB676635B4F39FA519A16D21CECAA60@MN2PR02MB6766.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQnmclnSlggDdh7YsVSr+T2H6LPWSrVKVK8bf+hu3Zzz3XMtrjByqjkXSF8Gc/QmEOCdZ8UdJd7oS7tP1kRXIYYrXHqW4sYjNi6mj6fo+rLKPpA8nVSAYgVrrTMMEKzb723OKOTxclSMaku0AHN1x/ywJkYvnecmSo1MDSQpJnS/FRsu4jnYEPmskRi7hO7RIx299ivZR710inrpaygfRJF6RNZ6OLbcz4MF8Dfxa71on6zN5kEHBX2WEgJcKPsCQv9rxAy9vEtQdCHvagtEUXuDMakS5Nlbi9ReKdCAMenEzRvbT+LKK7FSC5xM2ihhRJErVUhEtoZCS+gakmIbCdh1fRaK9aFC2xD9ZWnY5rrsznHkf6AdoTeZce/gGWPtvvuBRlzcm4d95mO1x4iCsJL4owJqNtBMRZrNg3Q9TsJwHqvw58S7FMjV6qs921ZMl0w10eknS64btsxk/mpt+E4veceb5rwA4my447qVdRTl46J8K0kjazZXX2KysQr5lptdIRhn0NnNETw+vesV2SNBdEkAsRhBlLsbuOF3oD0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:12.9810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0391a052-4ce2-4d93-65ca-08d7f0356bdf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6766
Received-SPF: pass client-ip=40.107.92.64; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set irq's specific to a queue, present implementation is setting q1 irq
based on q0 status.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 6cb2f64..a930bf1 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -554,29 +554,10 @@ static void gem_update_int_status(CadenceGEMState *s)
 {
     int i;
 
-    if (!s->regs[GEM_ISR]) {
-        /* ISR isn't set, clear all the interrupts */
-        for (i = 0; i < s->num_priority_queues; ++i) {
-            qemu_set_irq(s->irq[i], 0);
-        }
-        return;
-    }
+    qemu_set_irq(s->irq[0], !!s->regs[GEM_ISR]);
 
-    /* If we get here we know s->regs[GEM_ISR] is set, so we don't need to
-     * check it again.
-     */
-    if (s->num_priority_queues == 1) {
-        /* No priority queues, just trigger the interrupt */
-        DB_PRINT("asserting int.\n");
-        qemu_set_irq(s->irq[0], 1);
-        return;
-    }
-
-    for (i = 0; i < s->num_priority_queues; ++i) {
-        if (s->regs[GEM_INT_Q1_STATUS + i]) {
-            DB_PRINT("asserting int. (q=%d)\n", i);
-            qemu_set_irq(s->irq[i], 1);
-        }
+    for (i = 1; i < s->num_priority_queues; ++i) {
+        qemu_set_irq(s->irq[i], !!s->regs[GEM_INT_Q1_STATUS + i - 1]);
     }
 }
 
-- 
2.7.4


