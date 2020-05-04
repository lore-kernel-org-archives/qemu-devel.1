Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E69C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D19120721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="enIe/pMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D19120721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbxp-0000BT-6n
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrU-0007Hb-Cg; Mon, 04 May 2020 10:14:24 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com
 ([40.107.244.74]:6150 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrT-0005gh-9t; Mon, 04 May 2020 10:14:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDgYO9DNY9fa0GUkHJh9FYoG6ZZBgU7RCXsjaN+I2uggvMNXMaVYD0ipQlcGMfzm1bMgLlvwbFhnfdTAZC6QfB7Z8x6lnRct0zeIxQFk5GXc20Utw7x6tLowsXtOrmdEtI+QwVtU32TVSpXWProHBhDgbcIsh2opBYeLLLthi4TTsyH5Ra4YxysqZN6U/EO7hQ1IYPZ0nmHs14T836SO0GdiZ1WDEupW0gpsLgelOPT9aHeRth+PppEWim7p20rlvrEGpCjF7J69HPfVwE92xglZQ0vz1/K1RNAiFzPlnmlu+sm5HhGhJ3dNV6tFUM8al3GuUbbWzzTreV+ZGUMFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hinxdvB+SmjEyX1WmnJdXgfcuwaXO0a8Auar+RLVvl4=;
 b=O/uyLpHU5K6rPdJnXN0KU8zQbngSt0ChGKfN7d+kMrj0woh3cwDR/gVWhr9MuWmbKbuarkLiRzJ2ErMH3EejYuFCB3S6py2Op2scXUwmQYd5xw7skvec2Ne/LPO4UASAfrbl0PaUoH+F8jt8MCZ3zW08yVZyYoaQHWjVC2wmaGeSb8uU+Xm0BaShM35ruPYiYvb9Zr5NDo1UapbA3qkNHwV+e4mPp1/mSTeVA5v2t4ahk3LXSqj18Fhs7rGRvhujXgDu9eMgAgXo4AISahz709uzFCxx9AZuOH22SU/+DzXO+cmA+65+h7ISOvayBPDJdAWmNdYOWoRpRXLvsR9N2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hinxdvB+SmjEyX1WmnJdXgfcuwaXO0a8Auar+RLVvl4=;
 b=enIe/pMWRVF9Ko81Y2zd9xgKo76vMRLHTUOJYKHpNOwKEyGHxF4um78KZBmoZI9vkCPKz8CYLobXuYGNgGnwupfDQ4r5uFYLnMkSwn7F0nfCEfx4DPEnd7+fPWImQMeQyNfyyVPsCWXDzF7jb/CBWyJs/VJNFwCsnLIZviCm3mU=
Received: from DM6PR12CA0021.namprd12.prod.outlook.com (2603:10b6:5:1c0::34)
 by DM5PR02MB3653.namprd02.prod.outlook.com (2603:10b6:4:bb::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Mon, 4 May
 2020 14:14:20 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::7c) by DM6PR12CA0021.outlook.office365.com
 (2603:10b6:5:1c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Mon, 4 May 2020 14:14:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:19
 +0000
Received: from [149.199.38.66] (port=43115 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrJ-0000H6-Fe; Mon, 04 May 2020 07:14:13 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrP-0000xJ-3p; Mon, 04 May 2020 07:14:19 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrO-0000x5-EA; Mon, 04 May 2020 07:14:18 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 2A53B13C2E73; Mon,  4 May 2020 19:36:37 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 10/10] net: cadence_gem: Fix RX address filtering
Date: Mon,  4 May 2020 19:36:08 +0530
Message-Id: <1588601168-27576-11-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(46966005)(110136005)(6666004)(70206006)(26005)(42186006)(186003)(70586007)(5660300002)(336012)(8936002)(356005)(82310400002)(47076004)(8676002)(81166007)(36756003)(498600001)(6266002)(2906002)(426003)(2616005)(4326008);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80d4ec12-cf09-49ae-ec37-08d7f0356fb4
X-MS-TrafficTypeDiagnostic: DM5PR02MB3653:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3653D5E729045D9DCE80649BCAA60@DM5PR02MB3653.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vh5E7o9mW2CfkRad6hNbqTfAzyJhgmUtwdnnKYzenzlhkf2lgTvvALGnY13hsjpP4bRV1/WE5CzurIyJEUzaiHHq6p/EVMHxqBEHjHZLnGniP+YdOkG9ZwHwCODzElLDT5m2IwHa3Z7i9DGf0S2ysqsThRNx7lMBq5M4vhyqgdR8Ydb/yVjk1yO7VC1LdU2tPKW6NHcgJrANhBpquKfWdKoX4DU437fcw+Yh1LgxqamJf5M0Sp6IYc3tWR/URdBtBRoEkGYssUAxe0Ma0fNYkJAuFGbotQwojqOzUycAoZyHA0p1rqXoc7Kyje9dLWs7TF26pWB4hjKGYNXcPWP5gF1oqFM7IfvEBkIQMggoxj3rSCPDxLaeJZVKJ+Iola5Ha4J0W+LRcxW5Lkn2kyZhN9XTD+PDG0izwgV27dEjX+CbICuKYsQ0RRZl8nertEFHDmkL8B/9Ukdv9jRlEyBq7bK4dMjftbu3STXTrAyXEjYNh/DjtQ4VcXQox8+zOgcuO8ZRmrvCg2n8yYiVpc08YQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:19.4145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d4ec12-cf09-49ae-ec37-08d7f0356fb4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3653
Received-SPF: pass client-ip=40.107.244.74; envelope-from=saipava@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:21
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

From: Tong Ho <tong.ho@xilinx.com>

Two defects are fixed:

1/ Detection of multicast frames
2/ Treating drop of mis-addressed frames as non-error

Signed-off-by: Tong Ho <tong.ho@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f0bf2e7..112794a 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "net/checksum.h"
+#include "net/eth.h"
 
 #define CADENCE_GEM_ERR_DEBUG 0
 #define DB_PRINT(...) do {\
@@ -669,7 +670,7 @@ static unsigned calc_mac_hash(const uint8_t *mac)
 static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
 {
     uint8_t *gem_spaddr;
-    int i;
+    int i, is_mc;
 
     /* Promiscuous mode? */
     if (s->regs[GEM_NWCFG] & GEM_NWCFG_PROMISC) {
@@ -685,22 +686,17 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
     }
 
     /* Accept packets -w- hash match? */
-    if ((packet[0] == 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
-        (packet[0] != 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
+    is_mc = is_multicast_ether_addr(packet);
+    if ((is_mc && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
+        (!is_mc && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
+        uint64_t buckets;
         unsigned hash_index;
 
         hash_index = calc_mac_hash(packet);
-        if (hash_index < 32) {
-            if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
-                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
-                                           GEM_RX_UNICAST_HASH_ACCEPT;
-            }
-        } else {
-            hash_index -= 32;
-            if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
-                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
-                                           GEM_RX_UNICAST_HASH_ACCEPT;
-            }
+        buckets = ((uint64_t)s->regs[GEM_HASHHI] << 32) | s->regs[GEM_HASHLO];
+        if ((buckets >> hash_index) & 1) {
+            return is_mc ? GEM_RX_MULTICAST_HASH_ACCEPT
+                         : GEM_RX_UNICAST_HASH_ACCEPT;
         }
     }
 
@@ -924,7 +920,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* Is this destination MAC address "for us" ? */
     maf = gem_mac_address_filter(s, buf);
     if (maf == GEM_RX_REJECT) {
-        return -1;
+        return size;  /* no, drop siliently b/c it's not an error */
     }
 
     /* Discard packets with receive length error enabled ? */
-- 
2.7.4


