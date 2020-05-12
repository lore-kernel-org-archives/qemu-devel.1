Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CDEC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B1F20674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="R6y8gbWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B1F20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWbV-00087Q-EK
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSa-0001ak-DV; Tue, 12 May 2020 11:04:44 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com
 ([40.107.236.63]:6221 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSU-0002eC-1Y; Tue, 12 May 2020 11:04:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELBPE0I7ajfoxZORK9cnmkhgDmc02Yu0EMqLTYSH1gmL1ECeJIarl0/ENIdULHYxAumRB9itJRJTYXB0VgPTzTLYxna5gI2knFlaNjXlDb6vbP7AvJZcoWpCj8S54jmg+YEH6Nrhz3vwQrnQ3uJd4nPTwWqUJ8aFEv5ezMgYMRat62vHHmRkeKyu5Q0ry6N/oEpBHfth6gvQ2gRBXce7yZCVvnDC9NMA+aZ/Nu9s72a5rJ98vU2V5uau+PYLCKKjqXzR3OHXisDo7r5eEXlpqvqWrFoEkr4TMDdxGw+tyxTNcfUFkjLoDuEthD610rgqmgFhIPLFG3zXfmMmmwjJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XQoTGedvkwS9swdiT58yodiF6SIdBGUmjcFFtpSlYo=;
 b=WRIyN/BApVj2cbpVZt/qdjUZeU90jEcN/2ZRczEFzeNofdUsGqFzln7R8BuPvMR3GB1Dq1bFjdG8Osr/hV505s3w7uFslpsfJIfBBi9Oss/2kw0Q7ibBSjzZnV93DxGKEE1xdh+HVrabPKFPKWoyvi2LcFRO9azzDpgHhgVdKmgxZ51wHHOVoKBB1ibDTGy5tbYOuLXlynaSblcDYToI6bNFRUi+v6GZ0HxZE+aDcuCdNn4oDjA9pukTsHdUXunNkTZ4grD8V30gSjnkNx1kNFsVfxEyRL7JfXiYLy8yQIcyDD6ITmRWIxRdbqxS7klhKahYQqG3ppjnCowFNcZAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XQoTGedvkwS9swdiT58yodiF6SIdBGUmjcFFtpSlYo=;
 b=R6y8gbWvKUhA+AmJ/DJqQOcN2llnu1vAIWsBl8/Td19rl+WS5RI5DG1T08KTJrFZz5EySm7E9qpBc83yBztldVP0fFDXZLq/rZSrx/TPyXu1W74xo5JNhbjpghHrQ0DnfstXasaOZHLIwr6UrRqiavh9s7AtIyoXLsH+oNSGMcA=
Received: from CY4PR01CA0006.prod.exchangelabs.com (2603:10b6:903:1f::16) by
 BYAPR02MB5960.namprd02.prod.outlook.com (2603:10b6:a03:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 12 May
 2020 15:04:35 +0000
Received: from CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:1f:cafe::ad) by CY4PR01CA0006.outlook.office365.com
 (2603:10b6:903:1f::16) with Microsoft SMTP Server (version=TLS1_2,
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
 CY1NAM02FT015.mail.protection.outlook.com (10.152.75.146) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:34
 +0000
Received: from [149.199.38.66] (port=48859 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSA-00045m-8H; Tue, 12 May 2020 08:04:18 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSQ-0003ol-J7; Tue, 12 May 2020 08:04:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSP-0003oI-Qw; Tue, 12 May 2020 08:04:34 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 77CEA13C01B6; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 12/12] net: cadence_gem: Fix RX address filtering
Date: Tue, 12 May 2020 20:24:54 +0530
Message-Id: <1589295294-26466-13-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(136003)(396003)(376002)(346002)(39860400002)(46966005)(33430700001)(36756003)(70206006)(316002)(2616005)(426003)(33440700001)(70586007)(478600001)(356005)(6266002)(110136005)(82310400002)(4326008)(2906002)(42186006)(6666004)(186003)(82740400003)(8936002)(5660300002)(81166007)(336012)(26005)(47076004)(8676002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faa0bdcf-0e19-4656-3112-08d7f685c867
X-MS-TrafficTypeDiagnostic: BYAPR02MB5960:
X-Microsoft-Antispam-PRVS: <BYAPR02MB59608752CD5A0C90B4A9855ACABE0@BYAPR02MB5960.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9Ng9b6dLAX2aYSlgm+icdToDwywh75cQPq6x3gUZYwzoM/KiAgldsOzmISAbmIZpCxxNaDXDKW3ORrwIGIFj8U45pEPozgCKKL8qlseWelQwaR1LenPnRDjyBKljHnfW9uExill7GAriED5mDcaLIvu73DOOlMwS+gcE6BcVITz/aB4clOTzQrJdLOmA/drq1E1KvucjN5FTAKA98sz/Zpu9DrfU7JG2rU/MQtqfZgRbIEGgOgy4dDwHG4Qwp3qVwUhoa5L9Y4dpLJesMz+LI3y4Jr/YPOAk8l1W2izhOkmSeMQ2l5HnrLDLpcvl2FJldUd73KkzyU2ZJ3ep2LnNp7b9yb0SU6S5K3zOEysYpHVaOjnm7ZdXCjQf0xFAbuiLRowlrSbtGE71hcVYoMvyvk+0IvSMTGaoSUqZrgdn0e58P6I0Hc3NOqYKsJpkzyYjt7iT/co80gqblVP+nxBX9oIBNHrI9vlJ8sdQVb/VmxKYXD4QXMe2I0ei7R8Yieol8xal1+VRbn3M7qZ1XQ3ocb1qEymhl3D2j3Yog5thDMlqyeXhz4OwvIi8ztOn9ey/hYKPcGombWtY0x9a5Qp/A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:34.9363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa0bdcf-0e19-4656-3112-08d7f685c867
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5960
Received-SPF: pass client-ip=40.107.236.63; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:36
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
index 57d94a5..71d42b8 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "net/checksum.h"
+#include "net/eth.h"
 
 #define CADENCE_GEM_ERR_DEBUG 0
 #define DB_PRINT(...) do {\
@@ -702,7 +703,7 @@ static unsigned calc_mac_hash(const uint8_t *mac)
 static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
 {
     uint8_t *gem_spaddr;
-    int i;
+    int i, is_mc;
 
     /* Promiscuous mode? */
     if (s->regs[GEM_NWCFG] & GEM_NWCFG_PROMISC) {
@@ -718,22 +719,17 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
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
 
@@ -958,7 +954,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* Is this destination MAC address "for us" ? */
     maf = gem_mac_address_filter(s, buf);
     if (maf == GEM_RX_REJECT) {
-        return -1;
+        return size;  /* no, drop siliently b/c it's not an error */
     }
 
     /* Discard packets with receive length error enabled ? */
-- 
2.7.4


