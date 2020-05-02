Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7DCC47254
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EE220731
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IQA8xsx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EE220731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwTx-0002xZ-43
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwSW-0000nG-E1
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwS3-0000SY-VO
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:52 -0400
Received: from mail-eopbgr700053.outbound.protection.outlook.com
 ([40.107.70.53]:34199 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwS3-0000Pq-Ee; Sat, 02 May 2020 14:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE/l7s3WsFnYFlKvHuP2tiP97iw6dBxgcE7vlupNmMgK+qreUTMiJmsqrbqKR5OOPnxnNn6Ws4mPgwgToL2zcak0Kh9enyOEtw+PhzRRRl/v3a+P/waPkcPLp0TzFzdWD1LbkBtZ0Flvsqe43RaMpBYLTLJXiqQvHNvyMfYr0DNUu5SSiHc6EB7+hWatPzd5CgiYC88DO/MQA7DfnBr8vjz4o6JdYTu6gqP4kk+REhxpeeTgSElDLtFgHK7kXSyURUbTrSacgpE0sfPH8diLe4nglMl4F4PAJEh4sQIwRam4U3koD6MMxEq29yw7BGbZml7CsobQEamXEjujjDEy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8nNTedohwCYJlVXujzbJ9WNeICl3yYvPL0Qj4O5lWU=;
 b=A9QoRkcO0Ms/HZLogrqUlB739uf92JcA8vmbZQ53z8gPSVd/ykk2tG77FVXjcouFYAelL+obC2n75S2WVujWu3vwDxjQbckIHz/O/qS1PZsvVxm3FWVUqT1n8jqRXSwHmIXWmXqjAc0HKX4YKr3q5KWPwOsYt+mTTWGmH/SlpGoCCxkFVIuLw4hCVjnLj0G62HzwtwauDh1vgfrB3uiicZKZrqEp6GzPPbeBk+dxJv4KFd+OX+94T85LJMQrJeEgg7bV4FaA0Gxoi9ryuHeV/lwcl6c/2PKE6Ws0dl5DIt+/vL1X1BKHt6O9ODmednlKSaz9fbqO1NSTd8z8krUEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8nNTedohwCYJlVXujzbJ9WNeICl3yYvPL0Qj4O5lWU=;
 b=IQA8xsx2d/jqbWG65IS7ObnHZ7/ljj//T4uubNiXt/MAVwYtssXrMJVJq1v+Dw3VUduEwFE6dRVeY76veIpt3B4J3Dn3CTayOJ/8Y8Obaji9yUTZwCSNcQuWJEDIQTgjJyYtPF4+dBIT2MGKXHaxRGOV6yHi3b+1y27iX46HluA=
Received: from DM3PR11CA0015.namprd11.prod.outlook.com (2603:10b6:0:54::25) by
 MWHPR02MB2814.namprd02.prod.outlook.com (2603:10b6:300:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Sat, 2 May
 2020 18:01:18 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::68) by DM3PR11CA0015.outlook.office365.com
 (2603:10b6:0:54::25) with Microsoft SMTP Server (version=TLS1_2,
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
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:17
 +0000
Received: from [149.199.38.66] (port=60238 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRu-0004nQ-1U; Sat, 02 May 2020 11:01:14 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRx-0006w4-98; Sat, 02 May 2020 11:01:17 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1G3g010792; 
 Sat, 2 May 2020 11:01:16 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRv-0006ut-RX; Sat, 02 May 2020 11:01:16 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id A127313C0041; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 01/10] net: cadence_gem: Fix debug statements
Date: Sat,  2 May 2020 23:23:05 +0530
Message-Id: <1588441994-21447-2-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(376002)(136003)(346002)(396003)(39860400002)(46966005)(82310400002)(70586007)(2616005)(26005)(186003)(6666004)(6266002)(36756003)(70206006)(42186006)(316002)(336012)(110136005)(426003)(5660300002)(81166007)(4326008)(8676002)(356005)(478600001)(8936002)(2906002)(47076004)(82740400003);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f8ff5f9-0eb6-4557-09ca-08d7eec2cfef
X-MS-TrafficTypeDiagnostic: MWHPR02MB2814:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2814463D73906945639A8F84CAA80@MWHPR02MB2814.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8T7gNpiGv8qlpukN0eTZZDU0DX61WGCFfc7UokEnRQEiaBDAY+OOYBWek4puRqk0kub1hqKposduTts7cYhnaoVsbqGVG2ugr1whgDym8ZmSwVYf4KXfepXleXMj4Gk+J55DPNodUZdYj0xMbvHKx9YFHCXfikb3lPAeoJ4m9yTvMh/Rehv8yE85mg7KAcnh4F+yWcvRsa2RfdnTD7Tg9fROdKdGwbql8xewg+zNu4JcFbN9oxUaqlVPcM7gBVnEMf0h9XXm7f80K51o6yf4uhNvhQig2y149rzTuQ+aaB9boLZ8cuCZnDqpcKzoq6IdlfbzULwuwkn+HxN+nn31cvkc3kCLl0tTAy2OV+GLxJwD7qgGX+XK2ULbN+zs3mZ6+OGjpM+134FypV3EqlCYuSABxS0GZzYqrjtWx2RBugnHucpgPf0ndrWvmp8Mw6HlFPZxXkPD82p4VRj1BonL8pxTwSOU0QZGaJgiB/zYaoyMwlKCpd/wBrKJmhCNtoGADGla9P+fbKHnmTR5EHgOCA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:17.5690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8ff5f9-0eb6-4557-09ca-08d7eec2cfef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2814
Received-SPF: pass client-ip=40.107.70.53; envelope-from=saipava@xilinx.com;
 helo=NAM04-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:01:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.70.53
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

Enabling debug breaks the build, Fix them and make debug statements
always compilable.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 22a0b1b..92fcbe5 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -35,14 +35,13 @@
 #include "sysemu/dma.h"
 #include "net/checksum.h"
 
-#ifdef CADENCE_GEM_ERR_DEBUG
-#define DB_PRINT(...) do { \
-    fprintf(stderr,  ": %s: ", __func__); \
-    fprintf(stderr, ## __VA_ARGS__); \
-    } while (0)
-#else
-    #define DB_PRINT(...)
-#endif
+#define CADENCE_GEM_ERR_DEBUG 0
+#define DB_PRINT(...) do {\
+    if (CADENCE_GEM_ERR_DEBUG) {   \
+        qemu_log(": %s: ", __func__); \
+        qemu_log(__VA_ARGS__); \
+    } \
+} while (0)
 
 #define GEM_NWCTRL        (0x00000000/4) /* Network Control reg */
 #define GEM_NWCFG         (0x00000004/4) /* Network Config reg */
@@ -992,9 +991,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             return -1;
         }
 
-        DB_PRINT("copy %u bytes to 0x%" PRIx64 "\n",
-                 MIN(bytes_to_copy, rxbufsize),
-                 rx_desc_get_buffer(s, s->rx_desc[q]));
+        DB_PRINT("copy %" PRIu32 " bytes to 0x%" PRIx64 "\n",
+                MIN(bytes_to_copy, rxbufsize),
+                rx_desc_get_buffer(s, s->rx_desc[q] + rxbuf_offset));
 
         /* Copy packet data to emulated DMA buffer */
         address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
@@ -1160,8 +1159,8 @@ static void gem_transmit(CadenceGEMState *s)
              */
             if ((tx_desc_get_buffer(s, desc) == 0) ||
                 (tx_desc_get_length(desc) == 0)) {
-                DB_PRINT("Invalid TX descriptor @ 0x%x\n",
-                         (unsigned)packet_desc_addr);
+                DB_PRINT("Invalid TX descriptor @ 0x%" HWADDR_PRIx "\n",
+                         packet_desc_addr);
                 break;
             }
 
-- 
2.7.4


