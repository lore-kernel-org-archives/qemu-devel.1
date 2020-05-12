Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04F5C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96154206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tTnhXeI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96154206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUxd-0005Fu-Pe
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnz-0007fr-Ig; Tue, 12 May 2020 09:18:43 -0400
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com
 ([40.107.223.44]:34913 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUny-00022K-AU; Tue, 12 May 2020 09:18:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhgrlmBnEFJ/7jSWshCucHQogQavYSLyQ7pMbOpTLdDsFNOnJtzOsYwFyzExFbyAogS3492hbCCjJvr2qse2hz9Th792BmtvFYXvRijLu7nCn7zJRs/XOnYzksco8ETFYg/a2KNR+P1z33yk3+QB1+dXeOMO51+0XmRBcY3r0AgrkOWNz5nQE+YCkYshcsBd6UWNKT85YTg0g2LK9FGEjEBnzpJrL3T8ypwaKJGXuiLLYM1VXkcEcmnfa4mWqWH/WugQpT229g4k4j+GliDBSS5rL7PNF0u8FvB322Fkh8yc8IjRHONbWCGyHrFb3tK0pmnrKraqms5RWUjgkdR6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grgNXVOzkjl0aS2jc5ism/z0QVBi8SQ5OEXBYFA6Hk4=;
 b=AZY0ggkWC9A/tCagHdSrK+WENNpjWPk9uxWS1wsI3v/e8Q3JgHWp+hNvDRM9gzPxivCzj/YioOJEmfZ18sK3XJFyQahKmdk53os5DsYYLH64aRfRLc6okOseH3Kqyoc883H1B7Z+/MvNe5CPzgvHN0Bjqv4NhEknvGXaFjx+xRiQP/5PQhtjbihnK7PKQh/3TS7DgESJHIAQotTezAcwZtigSzt2FY29msRehhqMaJRAblCGjMDweriWqSCCsnHo1dZOPX0j21nu3GfK0ocEy8JmShMj+mC7mckk0xdBEgjBKyKBfs6inoiC692E+C+ol7TBC6zHTaWR+hg0zjzbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grgNXVOzkjl0aS2jc5ism/z0QVBi8SQ5OEXBYFA6Hk4=;
 b=tTnhXeI86/OK/kP2QWT53s+2+9eP+0paQlx5GcaF2+2Yl6cw+Byvz5rT/QZAEbgnGmsJvjgE0tG8Ju7jO5APZjNsczDv1Fn8dB3jZrL3NyK/55xflo3TdcXJ42EpAjE1ogVxiXR95RlGoIL9B1tJlPH2b1zzzr86N0FQqJVHyZM=
Received: from SN6PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:805:106::17) by BYAPR02MB3989.namprd02.prod.outlook.com
 (2603:10b6:a02:f1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Tue, 12 May
 2020 13:18:38 +0000
Received: from SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::f6) by SN6PR2101CA0007.outlook.office365.com
 (2603:10b6:805:106::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.2 via Frontend
 Transport; Tue, 12 May 2020 13:18:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT004.mail.protection.outlook.com (10.152.72.175) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:36
 +0000
Received: from [149.199.38.66] (port=47747 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnc-0002Qt-6E; Tue, 12 May 2020 06:18:20 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUns-0005a7-Dg; Tue, 12 May 2020 06:18:36 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDIZML016858; 
 Tue, 12 May 2020 06:18:35 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnr-0005Zv-0J; Tue, 12 May 2020 06:18:35 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id A0DBA13C0168; Tue, 12 May 2020 18:40:31 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 12/12] net: cadence_gem: Fix RX address filtering
Date: Tue, 12 May 2020 18:40:07 +0530
Message-Id: <1589289007-23629-13-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589289007-23629-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1589289007-23629-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(39860400002)(396003)(376002)(346002)(46966005)(33430700001)(110136005)(82740400003)(26005)(426003)(81166007)(70586007)(70206006)(36756003)(356005)(186003)(8676002)(336012)(33440700001)(2616005)(6666004)(2906002)(8936002)(478600001)(82310400002)(5660300002)(6266002)(42186006)(316002)(47076004)(4326008);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b5dcda-6bc4-42d5-1b76-08d7f676faa1
X-MS-TrafficTypeDiagnostic: BYAPR02MB3989:
X-Microsoft-Antispam-PRVS: <BYAPR02MB3989AA485DDFE949858A58C8CABE0@BYAPR02MB3989.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrra3HYY262zXvD+1OnKyTS47TN0jD7WJNEZE+HLKPv9IeTYxBqD3ygJ72Sf7Fus2PReceshxMF1KfNWEnU0sHFq+T2yB+aUM0MwRGPIm5eUWV3x6EgoWhS/3F5bbmL0Fo+pll2W07noLm6rjiCvf+Mr7NXIpfF3eJSjEUfmf2bDat3Tn7NUor7tmziYXuhpGJ2L7BQVF3kxDBB8HLBCbnZ2WKmY+2aMNVXvruSjdH0WaAqfrNEOXkRQNR0q+q/Mv9bEnmpnUxMXlHR+nIjoi3GzqSy+Sj26tWk7gV4vZ+J/rqCJLuuZPjKhNRYYns7GRLlL6DcE36Whlj0fP+sIRbbKJgxX9HO2J47R/ikukjChQjc8Zq/ByWDohcMTft7f0CzgBvcckdbg6yxn6DsFLJ2n5A7TUwDJy9kfj/+l6YcFz6J/K9nBvHbX0PTvebJ5/XJ6jggF4WqvdzVsQkm739uy4hUvftqPU7F08zU4ZqK+Yv+HMLPrlkzV7IgOE70XNu7qlUjpsbPjPZ1SFBagFeitgwbMR6kFIyzTHp/gXHBjNmb1lmykmicdlBZWYuB2ly3kN24GOO5lhhGg6FKPKg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:36.7500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b5dcda-6bc4-42d5-1b76-08d7f676faa1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3989
Received-SPF: pass client-ip=40.107.223.44; envelope-from=saipava@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:40
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
index 00fe5d7..e911859 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "net/checksum.h"
+#include "net/eth.h"
 
 #define CADENCE_GEM_ERR_DEBUG 0
 #define DB_PRINT(...) do {\
@@ -697,7 +698,7 @@ static unsigned calc_mac_hash(const uint8_t *mac)
 static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
 {
     uint8_t *gem_spaddr;
-    int i;
+    int i, is_mc;
 
     /* Promiscuous mode? */
     if (s->regs[GEM_NWCFG] & GEM_NWCFG_PROMISC) {
@@ -713,22 +714,17 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
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
 
@@ -953,7 +949,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* Is this destination MAC address "for us" ? */
     maf = gem_mac_address_filter(s, buf);
     if (maf == GEM_RX_REJECT) {
-        return -1;
+        return size;  /* no, drop siliently b/c it's not an error */
     }
 
     /* Discard packets with receive length error enabled ? */
-- 
2.7.4


