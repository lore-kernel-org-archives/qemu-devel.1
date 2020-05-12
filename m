Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D51CC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521E52054F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="O+wqwMd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521E52054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWfY-0004nc-Ir
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSV-0001Oy-1F; Tue, 12 May 2020 11:04:39 -0400
Received: from mail-eopbgr690060.outbound.protection.outlook.com
 ([40.107.69.60]:60738 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWST-0002dh-JX; Tue, 12 May 2020 11:04:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmiqLIfTIu8iMhEeZ5fTv/VbECa2T2cM+bjq9j/rtYuRYh3itBbrWQ/ESg4QGKRLZrL6Q+UxVhUwGrma5HYb+J+rKjsl+RBRlSka44TBriV/FvHQ4sJtBdAKhyxKQHmVIdOq4xRs1Gn73346S2zuM1b9SfSQviwr1XzidW6EKT47q7LBBeBkLWxdQEHdS+dkptQVc4+0Q1rgK1BbrM0fRVAtJ/0mcb2BG/lU42hg9W2JHJNK/Q18uAEIE3ZoKNQVjRGDuHCHuCMjzBW6pxMzucVO9gqKrQ5GVdNTJ2PchhdE6wHdfjQ7mZ1nDXSeYaFNfTl3doGpMcqWvAPimAHtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDF6FAGY0G2E/tpqHe8I5TM+3q+ViAKHgK29iNyi8I0=;
 b=g3OWyBK9YalHuMVgHin+acdd9VUG8w6x5k2+eqaLS7JxPh9HZpEdHfQ8AFksdsRclNOWi9GaP55PazkieksaNEbEAghejMqJL3xs4O8ZC6Z0mzuA9Fnsibr10l7v9/mozPnIm/iJiqvExU8JgIbi0xtLj6QU/JSvR7oxOIWn8EzQjdrQVLVMvu3Eaj48+pcDTN7lpo+EnZczNsFmiQj1xGMDpoJ/ryRX1G8bvwlJVmoDxQBsiAJJmoSxyFkY1auk42OEwtLoeGvoED/oTdMVKBvx7Eq4xIuD6C9oTgl+eunBgYW/K3LRdrkLLBwJKsmd4t4yXloLzqpAVimBYZsiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDF6FAGY0G2E/tpqHe8I5TM+3q+ViAKHgK29iNyi8I0=;
 b=O+wqwMd9927w9P5FDF7XbFDsBMqh7/m91KjvkqZG+1mKxU4q4b8DLY8n6GNvIr/ded5yiKANWuuPe+aGZbr9X9wCIcoqEqUeTxgaydkZs7Ov/S5oECmT8YIaNyXahD3gCI7ZxwZfOkz+QAhSnlmNST1QnHkpyjUGaLlU2Z6SdIg=
Received: from DM6PR02CA0136.namprd02.prod.outlook.com (2603:10b6:5:1b4::38)
 by BY5PR02MB6504.namprd02.prod.outlook.com (2603:10b6:a03:1d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 12 May
 2020 15:04:34 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::47) by DM6PR02CA0136.outlook.office365.com
 (2603:10b6:5:1b4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Tue, 12 May 2020 15:04:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:33
 +0000
Received: from [149.199.38.66] (port=48765 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWS8-00045O-Vs; Tue, 12 May 2020 08:04:16 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSP-0003o0-AJ; Tue, 12 May 2020 08:04:33 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSO-0003nm-P5; Tue, 12 May 2020 08:04:32 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 3436C13C0177; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 03/12] net: cadence_gem: Fix irq update w.r.t queue
Date: Tue, 12 May 2020 20:24:45 +0530
Message-Id: <1589295294-26466-4-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(136003)(376002)(39860400002)(46966005)(33430700001)(70206006)(478600001)(82310400002)(81166007)(6666004)(356005)(26005)(4326008)(36756003)(186003)(70586007)(33440700001)(6266002)(2906002)(2616005)(336012)(82740400003)(426003)(316002)(8676002)(8936002)(42186006)(5660300002)(47076004)(110136005)(309714004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1da1079d-63ba-4bb6-af1d-08d7f685c79f
X-MS-TrafficTypeDiagnostic: BY5PR02MB6504:
X-Microsoft-Antispam-PRVS: <BY5PR02MB650404CEE60282D167997690CABE0@BY5PR02MB6504.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIRBgu1GFNpq71ZmnPkj1yyAuZhFMM3BtHx1ACMjJ9FGB9bfwzcDuCmvQunIhdaEAs84qFdrA9y9a+FJLnUp7H98vKU1N1ucO0/G8917hXDAEhWi6awQ0OirCv6H08HQtxh8rA1UV0i/cLvfnwbS1vkjBhIdymYErD7kncuJX4y3lyVkj8DqWThdfMjLvT4MclfBcpmPjSBjYKYB9xWZzr/Rz9t/k24wGvbYKSeVyLnJqdYJIpb5yYmEp5iXUyT+zSj0lzmJKn0XMTBEJti05jmrr1mBXhbrJmlqLWmgegeRAqZD56ctEpnkgAnfBFWJvQhPF3wX1cpUv6X+9L9DdvDx5p/IK1ezT/cqFkD6bHIqS0G3uqZJMHbcOe+4GrvsJhWXeXHjip58gTgiP6QZpjtDf2JIXd/cgbFIO0Si3KR7wqyQVMnecds2SfHfxx7l1136z4H6sndCeMjhkn2s2MPsys6HxJXhe8Yma8aMqKpdoLQwB6GzqkUpOC6CDOsVPmVLEheekGlqgqcE+s+QbYL3loDQPOzSDUrTyDGqV40WBJ7g03cHQ1PzqxuvQh0Za/u9kCMEBTSw3o3dbDqnR5cJcJTaPXdPXrdIHoB8Kto=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:33.6168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da1079d-63ba-4bb6-af1d-08d7f685c79f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6504
Received-SPF: pass client-ip=40.107.69.60; envelope-from=saipava@xilinx.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index c3536ce..76c11a1 100644
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


