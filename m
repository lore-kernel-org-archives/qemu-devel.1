Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D53C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F97206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HwmdtZgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F97206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwXi-0002cj-CR
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwSX-0000nc-Ta
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwS4-0000Ut-Rd
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:53 -0400
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com
 ([40.107.223.58]:23553 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwS4-0000R4-E4; Sat, 02 May 2020 14:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbgCn2Z7xwfOZgdiYhw30yoMCMdPCzj3mH7/52ulAXAQAdwObHcwajPQD6KNwK+2asimb4wrUbBmPCmwZOMb/k8UX1mUYuNaGrvQH6bBCuoM+u/XRpwwtYT2XkgN/JvV+1C5A2qJIZ+N+iIjQdwv7+2PecZXdkD2+CuzxZU64PBzY6L84qamllTL7RBJ97989X53Owy6ATXSIXSUeOXcrX5rIKieQVYVfTS3Cu5i5tbtlG/8OEvkb8VaprPIty71y/6iD8R4bBuaGD9xObKYnP5pELAksHE8kDWHz9V6uAYjrdvx2IMXhDrhCyL/diKun10YiHN+u7Z87Osfp9+8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ1ywWiJVaXbw5dmdRo11tfhYr68Z0JK7kBrns8pnQg=;
 b=Gx5NMRPsKwBFLidL26EbF+WmA64pImE3UgqvwS7pzhw18wfP7VOk6PWUk5bNWjkjipINSGItCuGtVn0x1pQYvXijSeT+A9JX/MKBQ6CZlar4MU7A3xBbkfrEHmL9zK6jJEBs9QytRSTmkibyBAiTTYY9bQDL+X7wAa2m6iXTUe2O/24rElshsCdiOCQO1dkbD354yf9UAPSsnBmDlW3zkVBaXXNsUlvf+AFLAfHQS4UpiRvInHWwAne/OWhp78fSF6XXS577lWhLkT7B2P8u0IVZnBmNQXuCJ+6jBuksHrE+iOXgeka2yXzi666KJl9K07eQ4DgFAhdMVg1hY12S2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ1ywWiJVaXbw5dmdRo11tfhYr68Z0JK7kBrns8pnQg=;
 b=HwmdtZgnCcDDxIO5vvKw8It4Y41zrJTQ8zv7/sqiCRpVbCVBLCra4kURsRptK4kT0cfKm0i+iuIvh5pv2zVRY7Vqo5hJ+F31H31USGGj/JxdodaWKUeIzuW9TsgSZNROCmVllQXGdWGPVOsnTLv39FoVIBzKOgk+mLureP8zt30=
Received: from CY4PR18CA0072.namprd18.prod.outlook.com (2603:10b6:903:13f::34)
 by MWHPR02MB2366.namprd02.prod.outlook.com (2603:10b6:300:5d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 18:01:21 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::65) by CY4PR18CA0072.outlook.office365.com
 (2603:10b6:903:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sat, 2 May 2020 18:01:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:20
 +0000
Received: from [149.199.38.66] (port=60348 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRw-0004ni-VW; Sat, 02 May 2020 11:01:16 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwS0-0006xJ-6n; Sat, 02 May 2020 11:01:20 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1HSL010808; 
 Sat, 2 May 2020 11:01:17 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRw-0006vm-Tn; Sat, 02 May 2020 11:01:17 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id BA9CB13C1B02; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 05/10] net: cadence_gem: Set ISR according to queue in use
Date: Sat,  2 May 2020 23:23:09 +0530
Message-Id: <1588441994-21447-6-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(346002)(39860400002)(136003)(376002)(396003)(46966005)(478600001)(5660300002)(4326008)(6666004)(70206006)(336012)(70586007)(6266002)(36756003)(2906002)(186003)(26005)(8676002)(8936002)(426003)(47076004)(82310400002)(110136005)(82740400003)(81166007)(2616005)(42186006)(316002)(356005);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57ee668-10fb-402d-f232-08d7eec2d1ac
X-MS-TrafficTypeDiagnostic: MWHPR02MB2366:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2366B5A76269D40E720A4254CAA80@MWHPR02MB2366.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTBiyTLJyRp1hgQeI8teU9Cc11uRIYcN5LX/tEXYekXtmiBKI20Dm54NkQF6jQVzuCgBmLQrSYsaImREfYXYRz+OKOIbeOSP7n41HS3KUu7F+v7PRg6MqnT+wZMSK0v1VDWQ7e60Q2tHRhb4eI1eDjmAMcs5eqd9uT/ER2FHvtd7r0KdB2lZ3eWLiLp+CaJtK3CiOmo/DL9Ni+MpZemu7pOMvajF+xgeirQb0h+Mw1WpPcr6BR+zpTZrb2qNa1YZxwBSFJcLntFJktVMNF8cJ8bMUDBPNulXNNfrOD401seuda1SgRcDN6C15jxyivHD/Rfz7iBmdLtg3qkjzE1gEPOc3GVzdJ1SJ9ZAc3N9JkQgHsR+gPPLEbH0Xs/99wn1/nZXYOr9Lg6qRPGklVJ0cdbyENNa35Q6P+OE76U5I3lsHAtCOPQVDdKvskbqEo7cwyHNZd+57GWmXrSwxZfnGIem2wnZ6PXZF5YoMWWQ6punODUqasvTZKKAs89xK9d06nfXnW36NZGJm1xfCNGzfg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:20.4918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57ee668-10fb-402d-f232-08d7eec2d1ac
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2366
Received-SPF: pass client-ip=40.107.223.58; envelope-from=saipava@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:01:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.223.58
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
index e745d60..cc9e735 100644
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
@@ -1070,8 +1076,12 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
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
 
@@ -1222,12 +1232,12 @@ static void gem_transmit(CadenceGEMState *s)
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
@@ -1279,7 +1289,10 @@ static void gem_transmit(CadenceGEMState *s)
 
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


