Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B5420731
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Kw9o1t6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5420731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwWC-0007mi-Bw
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwSW-0000nJ-Vu
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwS4-0000T4-1e
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:52 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com
 ([40.107.93.71]:6109 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwS3-0000Pt-KM; Sat, 02 May 2020 14:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0qx/HuWng4XmKxsvIIvh+f8HH7kY42x9K/5sXgR/BG3zHmociN6nDxYuUp7hbS/T+qVsnWsl6aUR4sEmVx5p671wIYdNsIIilGFA+NfK1tjsBSaaov1bbopMOmnMgo4wickR16YdtDG2wfgx3gV1CP7Hs5bmeSrhayYVJ+lwzDGIoNSI8LjyU3ZHUrhcyTjps6bY1Yi6cdjSaimb2pYgmRk4OtaaCXzwbGvyTgzVnoOxalPRO/cNXiO5W922C9Sf33UtCXYOb1Cukrj2wurvFLW3mwKaF6HHlemzv+aKbUhqTysqTbUpua28FGUAX6lS1sEI8HBQAp7QNDRqvzocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6YWFOvZROHdGdOq2FmyJPOdUqi89zmGcZoGC/TJ/DE=;
 b=aSuu2P27MKu8GzUTV0B42Z2tM71PfMcNf3RngjlvoP9OHBD5Tmd+IDMNC2mFhFpy1sxln4nNnAsBA1C6q1b5FVU7/Sa6PoyNID522E5q26w1NbilD6g5pJafMgSeWtePsBFkdg4rgOkTDsvKHV/6oG7r7snn59RohZ4VSAE0dtAbuCvmnteVErnvYMEv0E/RRINXqmSTXRMdKc7NuahS/cDz4bq4ytn1fzmX+Bwb30tL8SFEpVzCPwKgj/xGgX7eDV/Pr6sk1hQkqpyBpvfzv8EhfJBnrX3PmBv3KsRzWbskE64kItKrE42hIZI1/3iMiBDaD+klGovRLJDh/TLlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6YWFOvZROHdGdOq2FmyJPOdUqi89zmGcZoGC/TJ/DE=;
 b=Kw9o1t6WlBZG4QWrrQ3AFprb659ipe/QfWR8LqwPXtKwEWb/GTgN9zl/btvfQK4VV3ZLNHk0UlC/xFgxlvzRC6p79UwlMuqwqiHM0lZQcvME7bjdDuHnw+IJldAhtMU1vdpRdMhDe9Li+Zr59dt6GE525tnWG8eAJ/ozwB3ZFWc=
Received: from CY4PR22CA0036.namprd22.prod.outlook.com (2603:10b6:903:ed::22)
 by MN2PR02MB6432.namprd02.prod.outlook.com (2603:10b6:208:181::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 18:01:19 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ed:cafe::75) by CY4PR22CA0036.outlook.office365.com
 (2603:10b6:903:ed::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 18:01:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:18
 +0000
Received: from [149.199.38.66] (port=60229 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRt-0004nK-T0; Sat, 02 May 2020 11:01:13 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRx-0006wA-4L; Sat, 02 May 2020 11:01:17 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1GFq011695; 
 Sat, 2 May 2020 11:01:16 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRv-0006ux-T5; Sat, 02 May 2020 11:01:16 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id ADB4213C1B16; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 03/10] net: cadence_gem: Fix irq update w.r.t queue
Date: Sat,  2 May 2020 23:23:07 +0530
Message-Id: <1588441994-21447-4-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(136003)(376002)(346002)(39860400002)(46966005)(356005)(5660300002)(336012)(82740400003)(47076004)(110136005)(316002)(42186006)(478600001)(8936002)(426003)(6666004)(8676002)(81166007)(2906002)(2616005)(36756003)(82310400002)(26005)(4326008)(70206006)(70586007)(186003)(6266002)(309714004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd4564c-9c27-4248-d86c-08d7eec2d044
X-MS-TrafficTypeDiagnostic: MN2PR02MB6432:
X-Microsoft-Antispam-PRVS: <MN2PR02MB64325E2F54EF7F773F859883CAA80@MN2PR02MB6432.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyuN7387vA62pxtk2KRux0zVmv/OWPwk16svZoGqhtirBWcJF8cm2MAdW+hKOi5Yzs+lgbjodof0NoOxW4XK/x0RUYPMUdTpBwxzfIAPTw4I/+3oFvSxMk3c+GPEDojZFn3+8QHDse7oDPDnMB5XuhS6EKHVLP81fh/uH2CPyJPMaDf+pZ4j+PCN6ma2HzrBn6KMRfQ6U3lDGEnEr0r0VK6o70BAyby6AFPvwwZIiLsJagARoDsmLd13xYjE539UltJOq7kNCxZ5gVu8fW3ZwFIBgJzCJqBL6S2hBZYjvQADjmUEqkpayX+qZ2KmIEyv7eZo3yGKI/yGopi/gDrNAetA0Jc+SHaraFDznmIQSntcwr01pYC0q5b9s/5LLX6dW4C1m5cIR70n+Xb4EeQ/d9A+buZzpZ3wZ9v0QeueOs+vU+Xu/MrKwS0332S6FsK3UaTm9sakJnCJ2B7K8PbvlbPWUf6hgfQU1t+3ft50ZDUMc0RB+G/Cb6qiS11jG1PIOVYvRgDferIUOYU3OZjQaYBDChxTjSdnbGiLOCQdaKI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:18.1313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd4564c-9c27-4248-d86c-08d7eec2d044
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6432
Received-SPF: pass client-ip=40.107.93.71; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:01:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.93.71
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
index 074aaa8..7782d6d 100644
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


