Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE61C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9585720721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cXitUW03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9585720721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbsc-0000Dq-Mo
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrL-00070O-VP; Mon, 04 May 2020 10:14:15 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com
 ([40.107.236.47]:21953 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrK-0005Ya-LL; Mon, 04 May 2020 10:14:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo860cErilOO9mYZMDu9B0k5Br+Tniac4WpPdXCM4V+V+uZunjCdESpF7T7ACSRWxwXU+JvyCgqe9zdZ0gHlFYSy3F0+Hw1S5i2y5WBh8TFvoZcXqucbgjyy//JkbdEueNou/C2iOlOBuwlNkkayCTEt5hmiYzQ/zXSoRkJmr6fPPdkpLgkSJKYJLOQT1e4BPVmzqYX3FL4drQsiMSz7vPR1MM66wi3ZumPLdRvKF7SEs017MzOONjA28nhncEKM+r5qK4leX8bUZ2F2KBdZ7t3zNt6zDoYjS2kzXosJ/DbGB8RDTxYITjLe1XiFovvNBGWbaVh0avyWwu95P/EBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vIlQ64Qy3AwLV3W8Jl4OO97FOoWaouspVZ8rsKCRrI=;
 b=d2LVInw5i4ToxkCooBt/I5uuiLZvyDwouqJsyC0CGJoj/QwBeTmAEc5YOX0802VHqNq1mnDFrvmnsTMav03+mExZFXIyP1IQZ7djQqJ/nHmMDhexZypucCnrZ9gtUDT5RCDnH/yPxODdW0RjLDbstIp9f1zdGkyDIjpx1UCRMREW7ELHtbnwLq+yMJ5v1I5e+nE62St2cY7uTPCtpCgXMCx8eiMwaNMBb3hdYAHYuOWL+TYvhPGApNH9wQeE1Iem2QCAxJEXSYxfFKMymYqfNjMa9Nf14GghULjkAieH07MFaaNzeocst2QL0Yu12qsexKEKwYuDWW4E9Vu+cxj8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vIlQ64Qy3AwLV3W8Jl4OO97FOoWaouspVZ8rsKCRrI=;
 b=cXitUW038Sflra7xi4wG2GeoT2HNUIPIJ/Vb0g2E86d29ZCk5BmSiE/fHxntgfD9TuutbCHBmC61+hxJV4sSSdgrWzzL/EsOnbLWW59VNmURPov4hKx32OXRhtJQUppIyYFMfub4HZHo/ItBfGFzI8h/2VnQ7oVNdKh1lVg5oN8=
Received: from DM5PR11CA0007.namprd11.prod.outlook.com (2603:10b6:3:115::17)
 by BYAPR02MB5638.namprd02.prod.outlook.com (2603:10b6:a03:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 14:14:11 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::c7) by DM5PR11CA0007.outlook.office365.com
 (2603:10b6:3:115::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 14:14:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:10
 +0000
Received: from [149.199.38.66] (port=42931 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrA-0000GW-O8; Mon, 04 May 2020 07:14:04 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrG-0000vT-Cs; Mon, 04 May 2020 07:14:10 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrF-0000vK-RI; Mon, 04 May 2020 07:14:10 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 8B9B913C2E73; Mon,  4 May 2020 19:36:28 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 02/10] net: cadence_gem: Fix the queue address update
 during wrap around
Date: Mon,  4 May 2020 19:36:00 +0530
Message-Id: <1588601168-27576-3-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(46966005)(426003)(47076004)(336012)(498600001)(110136005)(2616005)(42186006)(6666004)(26005)(186003)(36756003)(5660300002)(6266002)(4326008)(8676002)(8936002)(81166007)(70206006)(2906002)(356005)(82310400002)(70586007);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0626f3a-4ca5-4616-6894-08d7f0356a84
X-MS-TrafficTypeDiagnostic: BYAPR02MB5638:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5638C98AA084C2FFEBF4E5AFCAA60@BYAPR02MB5638.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAtZd3r3ozq6PjLR+vKoMfRXHL87g2CJF7j6KtHTeogXH8eJBgVbNTe6Xp8RxZ1ywGVKk0u6lGrzn0XpTlX4YLjry8qnGnwPwJ0JcFHGn6Mdw/R4FO2BhMkV/4fBtshm6/B+yRsqzxpGD+v1huQc9ldEYQLYtIG8gtiNdi/+FvZ3RXw7tKoTRItpWmReiZbbljkGWuaVn8rcZBcwy7PYmzIiu747Z6AaHXqAiDUBY6zMOZLOYAzD7TW97+KAJnhSGKneaOcGlyarMrHT/1i7xVeRamWubiMk3NUseSP5SWrhftnX19uGNwzaSQmW513ICzSrf7CYpVk9n8slM4iELefMqkke6AfSdfAHpN5fN88hOmUiWyYTgdbtFEpng4s4iOi7AcHh6Mghu8hv06UyQ6qLB2zkpNJw06PYCLG6or3MPdKUhp311cuiKWV04zpXR60slv2RrEL7rV6s/vFH40dV6a9fOfLth62QZ7wjKMFRyzErIWQZfbxaXoF6DcOKxQr1+lOErNBVkP6JBcNpWg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:10.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0626f3a-4ca5-4616-6894-08d7f0356a84
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5638
Received-SPF: pass client-ip=40.107.236.47; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:13
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

During wrap around and reset, queues are pointing to initial base
address of queue 0, irrespective of what queue we are dealing with.
Fix it by assigning proper base address every time.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 2f244eb..6cb2f64 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -845,6 +845,25 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
     return 0;
 }
 
+static uint32_t gem_get_queue_base_addr(CadenceGEMState *s, bool tx, int q)
+{
+    uint32_t base_addr = 0;
+
+    switch (q) {
+    case 0:
+        base_addr = s->regs[tx ? GEM_TXQBASE : GEM_RXQBASE];
+        break;
+    case 1 ... (MAX_PRIORITY_QUEUES - 1):
+        base_addr = s->regs[(tx ? GEM_TRANSMIT_Q1_PTR :
+                                 GEM_RECEIVE_Q1_PTR) + q - 1];
+        break;
+    default:
+        g_assert_not_reached();
+    };
+
+    return base_addr;
+}
+
 static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
 {
     hwaddr desc_addr = 0;
@@ -1044,7 +1063,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         /* Next descriptor */
         if (rx_desc_get_wrap(s->rx_desc[q])) {
             DB_PRINT("wrapping RX descriptor list\n");
-            s->rx_desc_addr[q] = s->regs[GEM_RXQBASE];
+            s->rx_desc_addr[q] = gem_get_queue_base_addr(s, false, q);
         } else {
             DB_PRINT("incrementing RX descriptor list\n");
             s->rx_desc_addr[q] += 4 * gem_get_desc_len(s, true);
@@ -1200,7 +1219,8 @@ static void gem_transmit(CadenceGEMState *s)
                                     sizeof(desc_first));
                 /* Advance the hardware current descriptor past this packet */
                 if (tx_desc_get_wrap(desc)) {
-                    s->tx_desc_addr[q] = s->regs[GEM_TXQBASE];
+                    s->tx_desc_addr[q] = gem_get_queue_base_addr(s,
+                                         true, q);
                 } else {
                     s->tx_desc_addr[q] = packet_desc_addr +
                                          4 * gem_get_desc_len(s, false);
@@ -1252,7 +1272,8 @@ static void gem_transmit(CadenceGEMState *s)
                 } else {
                     packet_desc_addr = 0;
                 }
-                packet_desc_addr |= s->regs[GEM_TXQBASE];
+                packet_desc_addr |= gem_get_queue_base_addr(s,
+                                    true, q);
             } else {
                 packet_desc_addr += 4 * gem_get_desc_len(s, false);
             }
@@ -1458,7 +1479,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         if (!(val & GEM_NWCTRL_TXENA)) {
             /* Reset to start of Q when transmit disabled. */
             for (i = 0; i < s->num_priority_queues; i++) {
-                s->tx_desc_addr[i] = s->regs[GEM_TXQBASE];
+                s->tx_desc_addr[i] = gem_get_queue_base_addr(s, true, i);
             }
         }
         if (gem_can_receive(qemu_get_queue(s->nic))) {
-- 
2.7.4


