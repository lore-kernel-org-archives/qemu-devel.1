Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A754C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AFC20673
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c9R9J4ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AFC20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWV3-0005Bf-0c
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSZ-0001YH-Bz; Tue, 12 May 2020 11:04:43 -0400
Received: from mail-bn7nam10on2083.outbound.protection.outlook.com
 ([40.107.92.83]:23056 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSU-0002ef-Cu; Tue, 12 May 2020 11:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdHV6yLmqDh4a5m1yERmJwTGQR9HQ3221eu4TynZPIMlNFonta5KSyHFCiDhVPplqw7RthDKA1jLx4ShqCCaoJw22gdErhLj+E1YFeRKsNK2txj/U2M6TWgiZiGjcwSPg/bL7ryPDsH1Ju/wIPbmeeKlN2doDMzNRulTgCLX0hhrn/P6F0ZR+g6Q6/DdDkAYCgMpH+J8qLA0mY31z54VeauOWeFY0vzEb8M1FkCYW7WatlPbF1cfhPqrkSqGCXg9t9asuPWa5P/zn3FT4kYk+ovwk3dtvKUh0A4G1stbubNu1NHz/cErYPEEHOQ5J6/YlB79xhkQUJhotLseUu4+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gmBS/gl8DIe0Nae4lgoBJbrAZ6fMSyNH5h3lK7sZ90=;
 b=L83958A5q/P551oHjO8km7tOWtMqHu2hc86WsbEYiudE+2TpWHzYnbguAoq8XNFBzAjd3EYypEBtY+7/CttCYwFjuEY3kjO9WfRHi+Urm2YrS46Tcywt5XOkFAQaLFGuuD2ww5CgMolYeUhjC+fORSWKw3scLokutHmF4dvxP5EJGpp7wjA/yxSuyehkciO7qlvqacMYZOu0gNmphdEFv7Z/dfWmMDW/p+o059qPLUSV8mhnku4sG6RakZ6xDXW76hvOUGEzrxAxm9kwHcv1b84bP4n2mURJGoiqAMARo3s9McJvPBO54hCekhQoX9x3Q7M+3fb7p/UJ8sxQZ20K/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gmBS/gl8DIe0Nae4lgoBJbrAZ6fMSyNH5h3lK7sZ90=;
 b=c9R9J4ryqVhwDEgNLsSNViO4hnmPVvpcyUtPxm7Gxud1jVU4RF7h2t3DxU15iRMyRcU13w19sKqa4rIz1rAxKdTWh/w5Ap+rYbs+rClkdXZCKqYlUp5i6KBP1l7V+a9Q7J4dDQ9Sny1ZRRUlMNW1FPnCqS5rbWLXQ1ONLaNjJmo=
Received: from MN2PR06CA0014.namprd06.prod.outlook.com (2603:10b6:208:23d::19)
 by DM5PR02MB2265.namprd02.prod.outlook.com (2603:10b6:3:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 15:04:35 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23d:cafe::c6) by MN2PR06CA0014.outlook.office365.com
 (2603:10b6:208:23d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Tue, 12 May 2020 15:04:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:34
 +0000
Received: from [149.199.38.66] (port=48830 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWS9-00045Z-Rq; Tue, 12 May 2020 08:04:17 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSQ-0003oZ-6K; Tue, 12 May 2020 08:04:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSP-0003o6-OW; Tue, 12 May 2020 08:04:33 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 433D613C0179; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 05/12] net: cadence_gem: Set ISR according to queue in use
Date: Tue, 12 May 2020 20:24:47 +0530
Message-Id: <1589295294-26466-6-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(396003)(136003)(376002)(346002)(39860400002)(46966005)(33430700001)(70206006)(82310400002)(356005)(110136005)(2616005)(316002)(8676002)(82740400003)(42186006)(336012)(5660300002)(70586007)(36756003)(47076004)(426003)(8936002)(6266002)(186003)(2906002)(26005)(4326008)(81166007)(6666004)(33440700001)(478600001);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8801efde-95b0-46f3-01cb-08d7f685c835
X-MS-TrafficTypeDiagnostic: DM5PR02MB2265:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2265C964684B6BBFD1401CD0CABE0@DM5PR02MB2265.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMo58d/79Tmk1NYi6eW/kb7CWboKm3uCdHbxNnK5xNSF90CK3QtvJrUSyXf0TP1BiEa7SzvbPBLdbl33onM9r8bg1RNzCFQQAmFITch54uGDe10hSn6BQk8+SSbfl6/7bpR3QaYQ/cxlR0uQwqtuZfL7fBC16B8ChjVL06456Jp1v4+rroiFdJygP3ftOgTmnlsl3qmQPE5eQYp8uiXUmxejM1wHeY1ynmCVnm56QVQGt03TGw0oZXiORxMlu2CWgBu6vLN55jFpprO9Ovq6w+cFi4OgrQcJOh3/FY1TwWHVgXbVYhi6G3emVilfyAUZykOSSV1zojsZi3LZRke1VVg8nNIieZjYzWlKJ2Pm4Co+sYoGiTuDO+E1R8o0+agtMz3i/VKxV158nk01/M97+NL7jfjH9Eh2JB+r0G170a3iajFuCC4WwaSidQXIE4Qu97cFMgPcdp8yeG2DcTGMpYhyGSKfhq1M5xOKVuujDgxCgsBgsybAUFMA8qFqjKt2vDSXourijBbB5r27rYfs4ffyIo4JYX1jgh4X0Kjp80ovr5yOArjEQ+8WE3CtI+O7EnV++KTvOXlrgjH9yRbZVw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:34.6050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8801efde-95b0-46f3-01cb-08d7f685c835
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2265
Received-SPF: pass client-ip=40.107.92.83; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:37
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 40bfa5b..d3f7166 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -451,6 +451,16 @@ static inline void rx_desc_set_sar(uint32_t *desc, int sar_idx)
 /* The broadcast MAC address: 0xFFFFFFFFFFFF */
 static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
+static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag)
+{
+    if (q == 0) {
+        s->regs[GEM_ISR] |= flag & ~(s->regs[GEM_IMR]);
+    } else {
+        s->regs[GEM_INT_Q1_STATUS + q - 1] |= flag &
+                                      ~(s->regs[GEM_INT_Q1_MASK + q - 1]);
+    }
+}
+
 /*
  * gem_init_register_masks:
  * One time initialization.
@@ -906,7 +916,7 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
         s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
-        s->regs[GEM_ISR] |= GEM_INT_RXUSED & ~(s->regs[GEM_IMR]);
+        gem_set_isr(s, q, GEM_INT_RXUSED);
         /* Handle interrupt consequences */
         gem_update_int_status(s);
     }
@@ -1080,7 +1090,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     gem_receive_updatestats(s, buf, size);
 
     s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_FRMRCVD;
-    s->regs[GEM_ISR] |= GEM_INT_RXCMPL & ~(s->regs[GEM_IMR]);
+    gem_set_isr(s, q, GEM_INT_RXCMPL);
 
     /* Handle interrupt consequences */
     gem_update_int_status(s);
@@ -1231,13 +1241,7 @@ static void gem_transmit(CadenceGEMState *s)
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
                 s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_TXCMPL;
-                s->regs[GEM_ISR] |= GEM_INT_TXCMPL & ~(s->regs[GEM_IMR]);
-
-                /* Update queue interrupt status */
-                if (s->num_priority_queues > 1) {
-                    s->regs[GEM_INT_Q1_STATUS + q] |=
-                            GEM_INT_TXCMPL & ~(s->regs[GEM_INT_Q1_MASK + q]);
-                }
+                gem_set_isr(s, q, GEM_INT_TXCMPL);
 
                 /* Handle interrupt consequences */
                 gem_update_int_status(s);
@@ -1287,7 +1291,10 @@ static void gem_transmit(CadenceGEMState *s)
 
         if (tx_desc_get_used(desc)) {
             s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_USED;
-            s->regs[GEM_ISR] |= GEM_INT_TXUSED & ~(s->regs[GEM_IMR]);
+            /* IRQ TXUSED is defined only for queue 0 */
+            if (q == 0) {
+                gem_set_isr(s, 0, GEM_INT_TXUSED);
+            }
             gem_update_int_status(s);
         }
     }
-- 
2.7.4


