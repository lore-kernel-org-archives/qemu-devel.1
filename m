Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED80C47257
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297F22145D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="izi0ALS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297F22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0zM-0002NO-Po
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sP-0007vU-7n; Fri, 08 May 2020 07:09:09 -0400
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com
 ([40.107.236.75]:6197 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sL-0002Lo-P1; Fri, 08 May 2020 07:09:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7xIPnV1HQLVLmhpl6XriVJMan0OQAifWbrOu/oKqg2dHLq1lfPID7LWeg8UamYYWsBRPBvLh80ae8q7zVvXOq5dDRANsVRZWNlk2YDQm3bP1cCf0bTQDbDQP3hkpiznKXUoHlk+sjS8pj63iUbzZOxH/W75D7dEZHU7F3TEouyfR66zMY9ywCPnrpz1oCKWWIb1o5h3GA3Ky34uiAr5TH1esw62+JYzPhWeQUSVBzOxAhieHxub+VsieKJ1Q0vmIbYGzDpP8LvxkFH41IUCNQye1KltUDJLU0R8AzYnrfEjz+UrgY0SmJ7hEVn7O/QQuahTnBpRQ6FysCjT91bMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDEdz2ZwwD6SaA7WEb/JGYbD23d6qRJ1JIfdSIRVRmI=;
 b=cDnvD8wqUjDY63PHRBZQjMxoAEEC8i0v45cKw0k1VC9GhjBCeSBaAVIY4GismBzZbh6hSWaKR/69niO9uqWFaO2CaY2dNCQsdE4S3eUtv/i9EF7FUIaFfvN8BVVjGsumx3UcK0AgFSs3GCzPUrYdVSEbKAGbbE8XiiqSLFU3g3dmGOKzBychMCAlplXMtK3nhLHGJDdzCX/4JAR8fSZnRVpelNbTakhun4zsMJ1gYSDkpk7R8dzdoWUs75neRQpRpFypneEysBH+cV3pu2/IchQ0Xfm5o2Beu0PDDNe6zuyPIvmWkA9AUZkeRg6S9F1/54rmaDSSOr9eG73zSyJytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDEdz2ZwwD6SaA7WEb/JGYbD23d6qRJ1JIfdSIRVRmI=;
 b=izi0ALS7CD/UYBnb8MKqjzZCxx0/pDMV2/PZHSEmR7THtHqJFjMB2ugLmO5qult026Iix3Q4ohlgk6ZNnqLkgyTclhNH3Cg4ENFb5fNO41IJQTooKOrkmpmE3mCpRSL30V3hOu7dVKHONDfb2Y0FMe7IYbCqYtVu/7dvdMT22g0=
Received: from BL0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:207:3c::32)
 by BYAPR02MB5701.namprd02.prod.outlook.com (2603:10b6:a03:97::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 11:09:00 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::72) by BL0PR02CA0019.outlook.office365.com
 (2603:10b6:207:3c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Fri, 8 May 2020 11:09:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Fri, 8 May 2020 11:08:59
 +0000
Received: from [149.199.38.66] (port=36360 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0s4-0002UJ-Bn; Fri, 08 May 2020 04:08:48 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0sF-0005hI-5E; Fri, 08 May 2020 04:08:59 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 048B8wPK017677; 
 Fri, 8 May 2020 04:08:58 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jX0sD-0005gZ-VF; Fri, 08 May 2020 04:08:58 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id E24AD13C03F7; Fri,  8 May 2020 16:31:05 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 11/11] net: cadence_gem: Fix RX address filtering
Date: Fri,  8 May 2020 16:30:45 +0530
Message-Id: <1588935645-20351-12-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(39860400002)(136003)(376002)(346002)(396003)(46966005)(33430700001)(4326008)(478600001)(33440700001)(426003)(6666004)(2616005)(82310400002)(8936002)(316002)(26005)(356005)(36756003)(186003)(8676002)(110136005)(81166007)(42186006)(336012)(2906002)(70586007)(47076004)(5660300002)(70206006)(6266002)(82740400003);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72df032b-7b62-47bc-7465-08d7f3403568
X-MS-TrafficTypeDiagnostic: BYAPR02MB5701:
X-Microsoft-Antispam-PRVS: <BYAPR02MB57017A1EE6EA750F29E39CC7CAA20@BYAPR02MB5701.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIQK55BLmxwMlnIFpEx2sOtJIO/pM3IZsRaEvCudmLLrLHxMJJifFieh6/0JqXR8jCcYXnLvfO0CNZtgnY0u6lxXKlDoKFN7lk7Fm2i3EDWdf8HH6dmDWF++IfnK1JGFktx0VbJrMIC1r3UsUFyLJ3NHz3m7rla8pWVgNF20WsVaOQu3X/E/vMPoeGWOSq4WwoYCSt7pXk1vr8XojJpEOTbSOB5Ku14JZX4v99zWa59FN0LBSZ9OIBqWzYFZpmVGLW1hqM+cD7pFbAPlxVad4e9ATgEf5PMj+2am7FzKDT9A1UygEO3moF0Jt7NIUpIUbK8T/40V/IExdY/lZJyAm/4U5nhDoUXU9lcwpN+tLBnDLJPZggmYxlNeU8dnPztI+Vhqk0I7JZHpT/H+mOqZGh0adteLJjAWvOXFQklGGYK4YlpL4FMJen1HI08i1t8ESi4W8zv3pF39Ay6bgcJitPaYa7O41Ae65qZsdbOZRyGP7x7sD73t7dhUcLm8+Hvlb0f+rHU2CDH2LKJDbZylE1olPqk2dBNjmb6IHcOEJMLGD2l+CgyA5CEoGlhrSokYs+r34SaHfPmNBAcNQv4ICA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 11:08:59.5559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72df032b-7b62-47bc-7465-08d7f3403568
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5701
Received-SPF: pass client-ip=40.107.236.75; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:09:03
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f8cea63..ccd087d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "net/checksum.h"
+#include "net/eth.h"
 
 #define CADENCE_GEM_ERR_DEBUG 0
 #define DB_PRINT(...) do {\
@@ -682,7 +683,7 @@ static unsigned calc_mac_hash(const uint8_t *mac)
 static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
 {
     uint8_t *gem_spaddr;
-    int i;
+    int i, is_mc;
 
     /* Promiscuous mode? */
     if (s->regs[GEM_NWCFG] & GEM_NWCFG_PROMISC) {
@@ -698,22 +699,17 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
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
 
@@ -938,7 +934,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* Is this destination MAC address "for us" ? */
     maf = gem_mac_address_filter(s, buf);
     if (maf == GEM_RX_REJECT) {
-        return -1;
+        return size;  /* no, drop siliently b/c it's not an error */
     }
 
     /* Discard packets with receive length error enabled ? */
-- 
2.7.4


