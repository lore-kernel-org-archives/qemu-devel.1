Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89051C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500F220721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a0XbfN8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500F220721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbsk-0000Lj-7C
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrL-00070M-Rg; Mon, 04 May 2020 10:14:15 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com
 ([40.107.68.42]:25978 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrJ-0005VP-D4; Mon, 04 May 2020 10:14:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayCxXjNgrIR3lugml+Rn/fU3IkpRCNYRtHHWtLgdPBlVaE37pqtoUgbG5gPsvi8lMz0YP7caNDGJl0FRCtXvVg34uaJ66P8ws+LQOR8g/Z5LiYdiMKiUEK8gRsZvfvNvBay8UDcW79W0kxX6AGul027oYdQWJ+4Hwo3MPV5DkwT+/oJePeV4ZDjlAhaItw3N+4F63nVAy37p4tAqagLLjYotII1Pxz9UR+JUksM+v13uzIG+cJEjdDTIrf+odNB9XwXurF0DUdqAIyB05RxGm/B+dJwBVy0V2dGW+rAaGkHZTg2xi59918X2EWSeiFfJHV2rlJ7Mf46DRnTyAoiuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhxeHJpUlpQ1L4o3LaqYsZmLi/2REIgJCY51CXmjyrE=;
 b=lyvOHOpdetK21KbQ12BADi+y7tfOgHvne472ZOnHL8TPIfifJnstdv+r/nMz6UA3Sdj9KGyxWzHqWJ8LzR+CPaULP7+G/Q+ySvW9hn52h4zJS7/VfebTmqvf9y9bvzq/YNPfnEtpOiSWZdfxzjMQbikSAg6rXXGhoipFShTYl8dFRBFlVpH3GuEI/U9Uyi3xMabu+Obk3IyNg3KRWqD2Vim9ejaKpeC5ByMcvKyNJ50D1jdCxwegYRQHU9CUx6jDyCb/LPHTsdM73BlR33BBOBcHM3pNBsuXfjznyeofeuHqs/mMHEbBHgGH6robEp2iOkCuNaoI/i0C2Rxia891xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhxeHJpUlpQ1L4o3LaqYsZmLi/2REIgJCY51CXmjyrE=;
 b=a0XbfN8RjKBWieV8EPT9tx5dpUr2A2/oR1X2A/TZf6ZmJjY9zQx2Jo1Vi4GpzjbRGPqXyXyAXpRRnxkX8aqhIFdZjO4ZVL0U9uEi7h4HyFg77850OCDUMvSgYLXC25mBKuSpwJcqn1BP8alGX3U2FHLxUstsbPYbIsF/kDYhETA=
Received: from CY4PR06CA0025.namprd06.prod.outlook.com (2603:10b6:903:77::11)
 by BYAPR02MB5592.namprd02.prod.outlook.com (2603:10b6:a03:9b::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Mon, 4 May
 2020 14:14:10 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:77:cafe::f5) by CY4PR06CA0025.outlook.office365.com
 (2603:10b6:903:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 14:14:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:09
 +0000
Received: from [149.199.38.66] (port=42912 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbr9-0000GP-Kq; Mon, 04 May 2020 07:14:03 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrF-0000vG-8n; Mon, 04 May 2020 07:14:09 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrE-0000v6-MP; Mon, 04 May 2020 07:14:08 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 68CC013C2E73; Mon,  4 May 2020 19:36:27 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 01/10] net: cadence_gem: Fix debug statements
Date: Mon,  4 May 2020 19:35:59 +0530
Message-Id: <1588601168-27576-2-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(46966005)(42186006)(110136005)(2616005)(498600001)(186003)(8676002)(4326008)(6666004)(426003)(81166007)(336012)(82310400002)(8936002)(47076004)(26005)(5660300002)(356005)(36756003)(70206006)(2906002)(70586007)(6266002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e06332ce-8dbc-4c05-1403-08d7f03569dc
X-MS-TrafficTypeDiagnostic: BYAPR02MB5592:
X-Microsoft-Antispam-PRVS: <BYAPR02MB559286D4E5CBEC25E6373025CAA60@BYAPR02MB5592.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ic7zmkpkOa6og7w6vjiyvofNp3TPxuAxo5rZ5S7Me+Ox+ifZWWojqEXpqFO4XRy4wM1KOoBfgQ9V1T+cX67ev1pfLEKHkySxdgt0rQCFR5jaymbTvEYV+tH+ORWhXGFRPwwuCAuoARnXrnHUv/v8N5jciyq0EXmaBYymtycjOynz12qejhNNfaIsqUrOd6L2YtolpxZZnMZ7xujLRsESBDjRS3+m/OYyufFA/PvihjSG1GHHq7KXEg7RpG9E5IKHdtHT3VUqsYnRlMUNW/wtsaG9OY887+bdCLdIUvXSHJH/9JbyuvsrNPqmbZRu+TSWi4Illy4o7Xronm5BBMZlSvxBQ3o9RqEw32T9WN0CpFNV0/JdkkZEo//rNGBUYDMH/5BHlcAy8U+H4iQz6kLsFrkzb3ssrhtGYsgV97BT1Imt0/jtS8fMfiloR1up/HPuLWoxhpiLJkI+xG9GYu2WVKAzUGkIeB9EOgklWQXk+C5YWbMAQyA96mP0kOQcmFHpXrPh7Ns2iDab6H7FyWHBg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:09.5818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e06332ce-8dbc-4c05-1403-08d7f03569dc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5592
Received-SPF: pass client-ip=40.107.68.42; envelope-from=saipava@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:11
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

Enabling debug breaks the build, Fix them and make debug statements
always compilable. Fix few statements to use sized integer casting.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 22a0b1b..2f244eb 100644
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
@@ -979,7 +978,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         size += 4;
     }
 
-    DB_PRINT("config bufsize: %d packet size: %ld\n", rxbufsize, size);
+    DB_PRINT("config bufsize: %" PRIu64 " packet size: %" PRIu64 "\n",
+             (uint64_t) rxbufsize, (uint64_t) size);
 
     /* Find which queue we are targeting */
     q = get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
@@ -992,9 +992,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
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
@@ -1160,8 +1160,8 @@ static void gem_transmit(CadenceGEMState *s)
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


