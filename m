Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9852DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5DD206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MVjkUl5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5DD206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUu9-0007pG-JS
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnu-0007Uh-9i; Tue, 12 May 2020 09:18:38 -0400
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com
 ([40.107.243.65]:30640 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnr-0001zb-7k; Tue, 12 May 2020 09:18:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX2kuwBOhX/iS611bZO+vudi6WFa+zXiSOjf+uJkt/aU4d9GytLFXmew55IvT0RyuB5FTQ/8fDCdSn34JkAnGv9AbuMfGzdW2x+5ZNCj7L3PxC0XFZRyZCF5TJmM2iDFTk4VrJQQJN5mvnxK5KZdUyXWNl2V2i9qa/TJGN2Efhjp8XnSnONFBTYSyddJa9ohE4JZ5/hfefKue+LKVCYRn6WwSVUN4Se3fsHZ69SrEC/ZSbRffM90vUzcvQXF5KIFgdYAYQUEOq8yUIZ/daXZtu2m1a0hXv+9JfHZXFrbSoFMv5RqwVsQ/YYxUijKtiIxIlnOb02BGawgdbAwdbJKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDF6FAGY0G2E/tpqHe8I5TM+3q+ViAKHgK29iNyi8I0=;
 b=e3kL1Zsi33IHKzhKfNw7mO7nsoz1rWuktRv3Jvgre66Wdcb6z+rgu4D6dxk11cvjqg2aVsxg8b5+CVpWxywdyK5Vw5fzJPSFjaTHrcEeePWD8NiHcoZS4MfGZmAqzzh+R08Do7QgDfUw2d8t9ZuSAWJkdB2TrnBkKpFFijEYqktAQsejxqfG9eY3IMHAheCKDgVkgKj7ypLw98yN9oE5eThWBGzCgUEPYGxG0rGgLNpRzjpSg8Au4MPPvNY9BGx/FTpMhSoSYx/026hnbfT/0berdoa3FmWzjG04YRtbXP+jff19ckSdo3dVKa9P4NgyBt7KwbazHnqW7jgaqSzU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDF6FAGY0G2E/tpqHe8I5TM+3q+ViAKHgK29iNyi8I0=;
 b=MVjkUl5arpKVPvc9+P1HNilEdxwqd1XmmTUyj6loNAozINX/OrvL747zJCKW5gykpDwuK1oYFqkab7mpWnH0rgJY/3TtWs7Wl4cH3rHkEQjjm0DuOolYdZJIUm7vlwsdZkaYtKT3l2hqh1zeTmyENPlLL3Ox8xyAcnimdMHXh2Y=
Received: from SN2PR01CA0073.prod.exchangelabs.com (2603:10b6:800::41) by
 BYAPR02MB5911.namprd02.prod.outlook.com (2603:10b6:a03:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 13:18:31 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::4d) by SN2PR01CA0073.outlook.office365.com
 (2603:10b6:800::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29 via Frontend
 Transport; Tue, 12 May 2020 13:18:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:30
 +0000
Received: from [149.199.38.66] (port=47643 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnW-0002QN-8D; Tue, 12 May 2020 06:18:14 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnm-0005Yx-FV; Tue, 12 May 2020 06:18:30 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDIT74016836; 
 Tue, 12 May 2020 06:18:29 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnl-0005Yh-4Y; Tue, 12 May 2020 06:18:29 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id BFBB513C0170; Tue, 12 May 2020 18:40:25 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 03/12] net: cadence_gem: Fix irq update w.r.t queue
Date: Tue, 12 May 2020 18:39:58 +0530
Message-Id: <1589289007-23629-4-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589289007-23629-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1589289007-23629-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(39860400002)(136003)(346002)(376002)(46966005)(33430700001)(316002)(70206006)(5660300002)(8676002)(8936002)(33440700001)(36756003)(70586007)(81166007)(82740400003)(426003)(4326008)(47076004)(336012)(186003)(42186006)(110136005)(82310400002)(6666004)(26005)(2906002)(478600001)(2616005)(6266002)(356005)(309714004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f912b1e3-b4ab-4150-94b4-08d7f676f720
X-MS-TrafficTypeDiagnostic: BYAPR02MB5911:
X-Microsoft-Antispam-PRVS: <BYAPR02MB591178317BF2A141F7CB3802CABE0@BYAPR02MB5911.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nn5oD7tsZ5pSC74I6C9LUI5i3/z2hBmKS7SsfZf2PLiNJMPwVpSnSpHQYPv/X/k8Ni5iDI4ohOGTyfDIVqSkcT7M3HnnJT4bBn0ry9UP2n+16rupO+acAQ4IkvE0krMuE7mfdzLoBrfyX88y0hFAeUJDNXCiEVmEEIj2TRmZYlz4ZhQZnAikb0BgnNeJUfKufxmK5+u4MLks+tww2I4DdG9gJNZv0Pcby10czZ/uiTOJSkEhntlCoke3Nc7hHC0BWNKeVRnLFVQ944QZ8a7AufLYnkXXlDHeGMk1kFvE0p66uHi1rshrkO2ILS2+Ndf3+sGd5pXp8UhGEfLQidlTybV9CMxoGIxN8fotEfXdwxKKOGccazDDpZe4962QklHE2AhddA0ue9l863zf+rpvfYUxafr4+VKAFZLULg2T8CYPncPgH+gpkcb9wXxTo98N9v+iFeaQ8zmS4PR0lFkNLsnuhWPVJx7WaNz4F0Xd1ATTv9xxMpc8SkGXT/iok9/x9iwYIbA8Z0f6AeaLDp3Ir56tNG1G5Ae2fD05FoSbJAEBJxinjqYvzNwdxpOpPzRb1qMcQua8PNc+5Chvz93OhTyr6V3KA1u2mIqfqbbpTjM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:30.8755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f912b1e3-b4ab-4150-94b4-08d7f676f720
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5911
Received-SPF: pass client-ip=40.107.243.65; envelope-from=saipava@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:33
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


