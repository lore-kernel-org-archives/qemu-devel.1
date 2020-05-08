Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EC0C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7F0208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XpZYjA7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7F0208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0vd-0004yK-47
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0s8-0007Xd-PY; Fri, 08 May 2020 07:08:52 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com
 ([40.107.244.44]:6030 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0s7-000213-Q2; Fri, 08 May 2020 07:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP1VROUSAskCKge5tg/tFKN42JIB43sQ1dIJePvJBspwciJsScxVPVmUZDdUzf/3pfP+bCyKnCNNVirLqEeBFD2roRfjEI/B5GnCe7L4nB2RbdmB18bKBuX1Z64VMfa+wYn1gdAhzPFyGy29UriRwteVwIVkwTkMI2gUYxTQM5Yl4+YHM2eiJ1hsRxj6X9uKfOGff0XpQBp3R413qYP8KdHlWZ4EOPj+J7tr6YFren6TyyjSrEMPWt1JjcWikI5rHchpquN7Dtd4v4OLeG/blUGdKG8E5bXL0mFWspTzy+yMaZyFpJTZAux/++BuTVfuazYsONasPr6BuafT+vZl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O3/7uVfukvTqVtr1FjQXKdSgWhJup4HXv4ZmaowwC4=;
 b=BqH+L83uZ4UZXmWOGFeGYn9Sht8vHjIlnz3Ji9sgyxOsXyO62lYB8koz40PkCADwwavOsLcK/3igTZKBp/xrRU6decgxY9/k7Sb0Yrvw2vkweO2oH86qnMGAAOuU+CzltuuHXAssFkeZSXa/unegw7Rn+0Tlor7WvmtgeK9ONv+L1DB+UCsJ85hdWPe6jU/2gaPHt8DrAXKtXY89LewHQjuJjl6xa42ZY/cIEUHmWqriYFNXE84K8hAV8cTKWGG4WOJQR413Il3hrBllNiPnVwda7JM3l4RYcztNwBMKrRgphLCQs93bcWItm7HQkJRncjnltBmzTj3S+yeH6lybvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O3/7uVfukvTqVtr1FjQXKdSgWhJup4HXv4ZmaowwC4=;
 b=XpZYjA7hq01BvRTLyD3cOBmYBATHAnsXyYh0SO/yx4Hr4x7/R6AJh7xsa9urBaMjzjR+0ahm9ONqmH7zM852IxLsJusDVNxjOuyQV7aXuyek9iQ1xz1WbNCc+7Dbs3SV5rBwhGGEcq7n6G1HOH5ggb+OCS19k6K8uLg4QNMAlv8=
Received: from SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) by DM5PR02MB2315.namprd02.prod.outlook.com
 (2603:10b6:3:4f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 11:08:48 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::ab) by SN4PR0601CA0003.outlook.office365.com
 (2603:10b6:803:2f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Fri, 8 May 2020 11:08:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Fri, 8 May 2020 11:08:48
 +0000
Received: from [149.199.38.66] (port=35792 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0rt-0002Tm-90; Fri, 08 May 2020 04:08:37 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0s4-0005ar-2B; Fri, 08 May 2020 04:08:48 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 048B8l7b021174; 
 Fri, 8 May 2020 04:08:47 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jX0s2-0005a4-Ru; Fri, 08 May 2020 04:08:47 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id C8F5613C03F7; Fri,  8 May 2020 16:30:54 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 03/11] net: cadence_gem: Fix irq update w.r.t queue
Date: Fri,  8 May 2020 16:30:37 +0530
Message-Id: <1588935645-20351-4-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(376002)(136003)(346002)(39860400002)(396003)(46966005)(33430700001)(36756003)(4326008)(42186006)(26005)(186003)(110136005)(70586007)(33440700001)(70206006)(336012)(426003)(2616005)(2906002)(8676002)(8936002)(5660300002)(478600001)(316002)(6266002)(82740400003)(47076004)(6666004)(82310400002)(356005)(81166007)(309714004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9954b02f-501f-4214-70ad-08d7f3402ec5
X-MS-TrafficTypeDiagnostic: DM5PR02MB2315:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2315C88A09EB339E2BCD10EBCAA20@DM5PR02MB2315.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p48uVqQqqy2wenjEGCC2J//AB3MEbFVrMrC+R7be4sxod2y0c9wD3WXohZ8OisCHEcL9D5/qupbmitWiWhY5bjRoTV01hKr1Z5M8ftyvDuJtCtfcM7ZPtr3ugUBFKsrgwnU3Deym/UJAUA1/KDgdQ3vz+KZTKKyJ9M9X5qnry4qf7qqRf8rp2baYHXWNsPWAqYpFqzIeWZnyqS2KMiFw+6CXFAAiOfDK/O7w5ED4XP1kbEGMnEJ2A6MXz/oQNfovdkBeyYk5apVf8UVkYaZD3/gcC3n5IX8jrANLcPQ1oxb3Q8xFkY3GVKfYzIhOlNaVdYsnfi+8ouEsMuzgrDfU6nP11+DZPsVUr4IDq3m4OBqRzCrJQL6y0tjiEZhUlo+x7IrcJqg4njHoX28m+r+A/Dsl+6sCGp+XdcMe2I0H2DatgZp2O1np9I/eSpBVONrGrWiCt2Nfp8X9Kiro8woUW4zpn0bwLrExM0X7YatV8zP1Rz24V9TmTRS9I1pftEBDxznipqHBhCIMUWOYlbTdiw/5hKFY/zAKXXDl6m/D+Od/Zo0O6rIIdfqoyyFwH8dFlc6g2mvjzMS/HmUpMTbWAIVR6bNYyQUovs14855f5z8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 11:08:48.4222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9954b02f-501f-4214-70ad-08d7f3402ec5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2315
Received-SPF: pass client-ip=40.107.244.44; envelope-from=saipava@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:08:50
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
index e6dc436..fefb360 100644
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


