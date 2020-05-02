Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F9C47258
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5482075B
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eWioHTez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5482075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwhj-0004PU-7M
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwge-0003kS-0I
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwgc-0007AZ-8y
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:16:27 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55]:6018 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwgb-0007AH-PR; Sat, 02 May 2020 14:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSnlIOpxbTa7IDrv3EJN+IXK2NbeRc2U9XSEMLWlHuPG79y4MQDCr30Z2RO3dLsbG1OvvQG2XOAgzwNRUhuJ0uwXLa1WHfBSU4B8IZ0iccLSsQejGpCiAKrUpozIk2yMFAc4ClPnaq5PADmN4sUXvNUKmUql4qS5ujC4vBZi1pK8IN6LF6gtJomoevk3CUgjmQ6suttgaypLzM7t7Eagy04zcy6UNLxnzGbowySrgcWp0SX/emfDafCwZDFRoRJ9ycTbVk79bxFXb/sZSSwCM12x4GdgonB0vB4wqkuMn7I3IjJP9PY7sXbUy4xNXm4eYJUCx8kmoA/YjmSeQ+LX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY+x62VhB6+USmW9Enw2l4C2Oz6Uy9FKo8uDilKpuOQ=;
 b=lXzcwsKMQ/zzf9GD9zmTF+4T7LU4xOELXpGHcXe0dHAt1sgjTOmNsSHsQwNbBZ57mYYuSbP8OSQ+7mzYISp82C11S19f/G/MBSvPuMtbv6nii2PzHEEtaR5oonkszkWR+x5yG+dXo26GUN1//mfppLB8iSNgF8RzfJ6DHr7xD7ZHT1rp6hJHVCZQUKnCRkHk2RPmqp7Sdq1m7AkYeQ/nxmogxjgjJk0VBtkas87Du9D1ApXqbkHGf+/V53Cer1CPozgeY3KD1wrI7G+LII//VsysAS0cj4PUKI2wblvn1FhJJteWH5hSc57KFlZdaiMLjaoE4nEtbCY355EikY1MHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY+x62VhB6+USmW9Enw2l4C2Oz6Uy9FKo8uDilKpuOQ=;
 b=eWioHTezyTjFBpi0o9r2XY6jcv8mMbrwLtmdvT3UjvZSbMRw3c23OLxpqA34IAm2tJ8mWHFxL5YF7Ku8cwsaj5eT/Y9NAyU7uMSn2oiQ0oH8wFbMhUqbw9sX/zQbSxIuC7s2gDRLm458GUuWuff5f+LCXiZIjduWOp3TuwPf2vU=
Received: from SN4PR0501CA0042.namprd05.prod.outlook.com
 (2603:10b6:803:41::19) by SN1PR02MB3712.namprd02.prod.outlook.com
 (2603:10b6:802:2d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 18:01:18 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::b3) by SN4PR0501CA0042.outlook.office365.com
 (2603:10b6:803:41::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.11 via Frontend
 Transport; Sat, 2 May 2020 18:01:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:18
 +0000
Received: from [149.199.38.66] (port=60277 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRu-0004nX-Tb; Sat, 02 May 2020 11:01:14 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRy-0006wr-4v; Sat, 02 May 2020 11:01:18 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1HE7011722; 
 Sat, 2 May 2020 11:01:17 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRw-0006vs-US; Sat, 02 May 2020 11:01:17 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id E242113C260D; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 10/10] net: cadence_gem: Fix RX address filtering
Date: Sat,  2 May 2020 23:23:14 +0530
Message-Id: <1588441994-21447-11-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(396003)(39860400002)(346002)(136003)(376002)(46966005)(42186006)(316002)(70206006)(70586007)(4326008)(6266002)(6666004)(36756003)(2906002)(426003)(336012)(8676002)(8936002)(110136005)(82310400002)(186003)(26005)(2616005)(356005)(47076004)(478600001)(81166007)(82740400003)(5660300002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a502ac9c-b72d-4a4d-3918-08d7eec2d07b
X-MS-TrafficTypeDiagnostic: SN1PR02MB3712:
X-Microsoft-Antispam-PRVS: <SN1PR02MB3712EE5ED50C94B1ADC6EF9BCAA80@SN1PR02MB3712.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gSFQ+VQ4UOFRhdsuluAv9ZvHrhhmbT9rQYvkHI7/8DOA9Bd0emlhcaXL0otaaLABg8k/QzOngUyJh5G5dtCZ/XWtUshKgaUiqE1MB9hs8R0W3CXG8orTeZmREAeQK/ZZIn+q13eJHMItNZcjUyYyU2yy9aQEbA3wN1okFPd5fqrgX3BcHO8Pw+p2TUHfqjeEVpkxJtqb8VMK0Qqd8B5n6BmQefROeyHh3HHtsuJkdW4exTZw0+8j26Gwywlp8R/0CdX9k5KV76XhwVutNmEOk2sNYtiJ90En0bndreuaRbt1C4t2lscz2nEL2tmjqbnmSJDlaqEdMj0hyGnRoJ8MzucPNfAbQ2zTnp5DKJopcowNAtzeTzTtIvpWCIyFzFgSXQ/4IyHqY6GyJGhvyARiizK6a82F6JWQ1+eukcqjGEneME0W3JWasit6U7d6xviJCFlCTV4c5GaBkxu+5G+sKAs6iJy1uZbygr6TV9W510xfHDWDb9h1QE4C1cXHpLeH+kgaHVjkmlyim6jc3lASw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:18.4877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a502ac9c-b72d-4a4d-3918-08d7eec2d07b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3712
Received-SPF: pass client-ip=40.107.94.55; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:16:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.94.55
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
index 06128c2..10a7cb2 100644
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


