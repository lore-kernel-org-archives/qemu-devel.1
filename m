Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E828C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0A420752
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="B1+dYnql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0A420752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbvG-0004Yk-TV
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrQ-000791-Pq; Mon, 04 May 2020 10:14:20 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com
 ([40.107.237.51]:6173 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrP-0005dC-QF; Mon, 04 May 2020 10:14:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avNvRfiLh/A9JahMFMqVdlyXwW5vt6CaLBYOMD5PcEz6Ciiw7S7LZDesE7kreEq6aMVecT/LMZJxGeCyD41m+Cg1ByW4f5a48zTJRr2M8Jsr8xvysEUbXaIvZlbTzYt9c1apK30QTHvKerBmOhxWnsR0cZ0/jyqUexx+H2tskimWbXbVeSNZzsOjNgBhOeQHRoyRAYarqWBkbrL1m9WKAT5lVa3dvL/R3dKtDy7BUSHl3LdsEvTIu5dL6mMyPpDANLod3+OTt8PbMwCP4dmyvwwhNi7A5nyJYpFcm5Umc/yxCtwtxrdQhex8Dp/ONF3oepOQUuY+JlRBpgWORVUvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6HbE8gMqCyOai28ZLOwVOXU19t12aPfUTwPZ2g2ZC8=;
 b=EBw/4i7UyHmWvZIvHrQ0v23WWjhn6LugqY3mdwa2ErhAf1NTZiUZSsgk9Cb9ABAdY3DCCpMtZcabIXqm772qkeqGU3V+wRV+6wSAyYZfAdC46IDnvUBPIkiywOKmxvT9+kNhCoh8bJenrbmz8T1hjOs9hitQr4smGmQ8fT+T3zxS9BTRIWlu+xpxszYOpbaJoBIpVpvE81lxYHtEHzWdbwYTswMVW8dcS3CJmVUlFRJZkJbsgr6wKfp0HkCfS9KkM1e6wf+DFVCJfNTso1mt1J2AkV6p+z6xkDf+kZtDfXGYZyAkGSzln28VYgslzByFUsZd+6EaAb8saZqG/HALsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6HbE8gMqCyOai28ZLOwVOXU19t12aPfUTwPZ2g2ZC8=;
 b=B1+dYnql2FBfV39t9DaR2qn129SNpUnOSXhUKGWeyYjiE4nH+tqk66B+0l22/KrCCrr+Fb0FqcrTGFmgKeTFptSj7ZRwchhwuj5TXcZjc7JqM658cyzKouObQGbv7eRf4JKdyF0V/n4QDIHtgUFTdiQjGaMtDdXSflkBuikocx8=
Received: from SN6PR16CA0041.namprd16.prod.outlook.com (2603:10b6:805:ca::18)
 by MWHPR02MB2880.namprd02.prod.outlook.com (2603:10b6:300:106::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Mon, 4 May
 2020 14:14:15 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::f3) by SN6PR16CA0041.outlook.office365.com
 (2603:10b6:805:ca::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 14:14:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:14
 +0000
Received: from [149.199.38.66] (port=43016 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrE-0000Gj-SA; Mon, 04 May 2020 07:14:08 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrK-0000wK-H2; Mon, 04 May 2020 07:14:14 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrK-0000wA-2q; Mon, 04 May 2020 07:14:14 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id C5BBA13C2E73; Mon,  4 May 2020 19:36:32 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 05/10] net: cadence_gem: Set ISR according to queue in use
Date: Mon,  4 May 2020 19:36:03 +0530
Message-Id: <1588601168-27576-6-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(46966005)(8676002)(4326008)(82310400002)(356005)(8936002)(498600001)(336012)(110136005)(5660300002)(81166007)(426003)(2906002)(47076004)(2616005)(186003)(26005)(70586007)(70206006)(42186006)(36756003)(6266002)(6666004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2ca8c25-fbb5-4286-04b9-08d7f0356cff
X-MS-TrafficTypeDiagnostic: MWHPR02MB2880:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2880470EF4ACD62A947A607BCAA60@MWHPR02MB2880.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pxo0274jkAOFPXeNFCw17ap8MDXGfrsKZhc4m7CTrXd7LvCPT/f+fuc2dHyleTIq7GwkUefDHyqg73wNipk7c8ST/UUdRp+99pRah0m+kmgUasie0nyErXv+GJh62aMV7MM88Z0bWCIs0W9whW1nE30snX/nYnBjd1rTYpJs0LuloRLikoRC/E3Vy+R6REbHKSK+POSNmEAkV4mK4xfUoDSo2jm51DlafpaS7zSLX5dnP8GucO9cStLzFi8uiBM4upgto4uUCha/t+de6uUxDOHcqaVO+3pOGxh4fNaVMFnu0dCJ34qIjj6ekedvUzB/NHO8D07r2h2WxkuhQ8SN/DB3eh4QdfsjgvV/b4E8g+xcvDRAtpf5yrMTRP2QUgwOsFZLBJ5L/grqAOL9Ndc4c+LDuZVnV+1rV12KaVOWw2pRfwNIY4aldsqOkdhQiNKavN4B+DN4FWbOA3ykJxz1wI4gUFdmjbSrlqm8O+hZGc5RalM1UB3GX/XCg31lAtdqjU5CzcI72zfj/77n9/HLoA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:14.8659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ca8c25-fbb5-4286-04b9-08d7f0356cff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2880
Received-SPF: pass client-ip=40.107.237.51; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:18
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

Set ISR according to queue in use, added interrupt support for
all queues.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index c532a14..beb38ec 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -896,7 +896,13 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
         s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
-        s->regs[GEM_ISR] |= GEM_INT_RXUSED & ~(s->regs[GEM_IMR]);
+        if (q == 0) {
+            s->regs[GEM_ISR] |= GEM_INT_RXUSED & ~(s->regs[GEM_IMR]);
+        } else {
+            s->regs[GEM_INT_Q1_STATUS + q - 1] |= GEM_INT_RXUSED &
+                                          ~(s->regs[GEM_INT_Q1_MASK + q - 1]);
+        }
+
         /* Handle interrupt consequences */
         gem_update_int_status(s);
     }
@@ -1071,8 +1077,12 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     gem_receive_updatestats(s, buf, size);
 
     s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_FRMRCVD;
-    s->regs[GEM_ISR] |= GEM_INT_RXCMPL & ~(s->regs[GEM_IMR]);
-
+    if (q == 0) {
+        s->regs[GEM_ISR] |= GEM_INT_RXCMPL & ~(s->regs[GEM_IMR]);
+    } else {
+        s->regs[GEM_INT_Q1_STATUS + q - 1] |= GEM_INT_RXCMPL &
+                                      ~(s->regs[GEM_INT_Q1_MASK + q - 1]);
+    }
     /* Handle interrupt consequences */
     gem_update_int_status(s);
 
@@ -1223,12 +1233,12 @@ static void gem_transmit(CadenceGEMState *s)
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
                 s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_TXCMPL;
-                s->regs[GEM_ISR] |= GEM_INT_TXCMPL & ~(s->regs[GEM_IMR]);
-
+                if (q == 0) {
+                    s->regs[GEM_ISR] |= GEM_INT_TXCMPL & ~(s->regs[GEM_IMR]);
+                } else {
                 /* Update queue interrupt status */
-                if (s->num_priority_queues > 1) {
-                    s->regs[GEM_INT_Q1_STATUS + q] |=
-                            GEM_INT_TXCMPL & ~(s->regs[GEM_INT_Q1_MASK + q]);
+                    s->regs[GEM_INT_Q1_STATUS + q - 1] |=
+                            GEM_INT_TXCMPL & ~s->regs[GEM_INT_Q1_MASK + q - 1];
                 }
 
                 /* Handle interrupt consequences */
@@ -1280,7 +1290,10 @@ static void gem_transmit(CadenceGEMState *s)
 
         if (tx_desc_get_used(desc)) {
             s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_USED;
-            s->regs[GEM_ISR] |= GEM_INT_TXUSED & ~(s->regs[GEM_IMR]);
+            /* IRQ TXUSED is defined only for queue 0 */
+            if (q == 0) {
+                s->regs[GEM_ISR] |= GEM_INT_TXUSED & ~(s->regs[GEM_IMR]);
+            }
             gem_update_int_status(s);
         }
     }
-- 
2.7.4


