Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DCFC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC2D206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KCeyFGX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC2D206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUrj-0003fS-DP
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnv-0007Xb-QA; Tue, 12 May 2020 09:18:39 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com
 ([40.107.220.62]:6135 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnt-0001zy-Et; Tue, 12 May 2020 09:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSysTS7g3zcJNFjeHTuJExEDAzpUZaLvu9+x+vYszOWh9Gy51X6xlZSVuko2wP2ohTHw3HqgZC4TaAgoanKiRRTU1CnlJE1uf5h5HrwI5Q4xaO8gRo8QX7KsWBRlTa+vbZ/FZOt6WxfxRXp7wu/TJ0jMBOJPh+v/H39qe/rGmblUr5bpMbbExzrWmJAv9EnFaZRNHs1ecZeroqLzUkY4dlSE8MV+LYKdYhj1NOloK+hSwbovcPTmSohgtQQuYcFL52pPTBAUFOxXD0NMsYAhcWmRFLcVH1j9kOvNfNfMT0dV8Td3ZFw1niQEevyqT+4H4xzZ4fht1V7BNIfv/8UTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDwcrhsY51j0FKDUMxTnNU1qPxw/GNcOUTL856PDq8w=;
 b=by0GHr8AcqTNlU+qwhlT4evYGr/HKk2j6Mbk7m9VO6vTGie7OhN9uFAs11HKOMineMFDasusiSyhECe8+QaugcEh4ggasfkJjQjJQ+PMtqpMnIjP3Ng9V0qS8Q2AzaUD50S5od42XD1Vc1Jpi9zf5KpcwFkix4VS8zqv2jJzaj5+J4SxyUZ6zZdfI2cY0a4g1f72gCmV8uLvBGQuwKhve8uNnn1x8lJP8nxbfzmyRPVGe1ip19heZfloA/vujQLBpLNVnfJbO6yZcDWu0W5Vt2D3byDU8/FymAftOT2qCBJ+Q6cbwbOIXurELuxdL2tqFhiN9Ab56RtH3IUiD83QHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDwcrhsY51j0FKDUMxTnNU1qPxw/GNcOUTL856PDq8w=;
 b=KCeyFGX/FuLKHjlun/XOQqksqogmxIsDyPuV5VOIqv9QmFnozxYFtO6ovN2h00XvZcCpyQsglMUzt8kzF7T6GIlifRTpsPkZ5wYkVrDfdzBa2XrWX97+VvqkGasMBxHK/CcuUrrJ9pgYLn2UO24uVJDcYSsDLuOW+M4UGyBDPvU=
Received: from SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) by CH2PR02MB6824.namprd02.prod.outlook.com
 (2603:10b6:610:af::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 13:18:34 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::7a) by SN6PR2101CA0013.outlook.office365.com
 (2603:10b6:805:106::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.2 via Frontend
 Transport; Tue, 12 May 2020 13:18:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:33
 +0000
Received: from [149.199.38.66] (port=47705 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnZ-0002Qf-AH; Tue, 12 May 2020 06:18:17 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnp-0005Zf-IC; Tue, 12 May 2020 06:18:33 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDIWkJ028677; 
 Tue, 12 May 2020 06:18:32 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnn-0005Yb-Qk; Tue, 12 May 2020 06:18:32 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id D983313C0168; Tue, 12 May 2020 18:40:28 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 08/12] net: cadence_gem: Add support for jumbo frames
Date: Tue, 12 May 2020 18:40:03 +0530
Message-Id: <1589289007-23629-9-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(396003)(136003)(39860400002)(376002)(346002)(46966005)(33430700001)(70206006)(36756003)(316002)(110136005)(2616005)(47076004)(81166007)(336012)(82740400003)(42186006)(426003)(8676002)(70586007)(8936002)(356005)(5660300002)(82310400002)(4326008)(33440700001)(6266002)(2906002)(26005)(186003)(478600001)(6666004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d4f001-0df7-458c-20af-08d7f676f8ed
X-MS-TrafficTypeDiagnostic: CH2PR02MB6824:
X-Microsoft-Antispam-PRVS: <CH2PR02MB68240ECAEAC577D6DFE14B3ECABE0@CH2PR02MB6824.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tff6rCK0Eqmol3d+8udivNylczn8HDezKufWbCOe6FZ3Hp1gQ4i6OW6XwCuMlHRTzWxn0fDUxVSzz5KprAuqFsc7wZRQX9i5VIRlZHHdJICv357tANtObagXLfQywTgEaZByziAT5MSvgjFE9pkIq6XyVlQNPZyTwv/fuy0ilv+nOpvlMjnxZ7c/1si+qDoVlIPTXrW6xFY9z+LLTxOQFIi0AvNtBCzI6Ph6SjQrM1f05pomTd61iLZkpNAiL9fg/Vun9aIxq1Spi14nmIKp0ohz2kgmYcQFRk7ylYvFZPkqM2FWx1Nt1RLiKlegcTGEtnvzzudCSSGjFB0loNLnt1Fg6Q9B9xiDKXjwJHP6/tqvl+aFHGcu5eC9RyFjatfIEU3m0kYi2uH1raPtLe+tQHFUoOkAagVjG34C+5ua5yWlCTuiO1hnORP+dDI0FXNf0TQFXo8m5iG1yVe04hoSAWTE1yuaQ77aqANo3BbzK+uOd8nmi/A7M6OsjIcLBuRFh86H1i96unfVIjbvB2d6FjxzNQmx9pIdkBb5PDUQekjzlLRttfAA9mwzczWKL/C8kM4st6KdCY9Ja565TNaBoQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:33.8878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d4f001-0df7-458c-20af-08d7f676f8ed
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6824
Received-SPF: pass client-ip=40.107.220.62; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:35
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

Add a property "jumbo-max-len", which sets default value of jumbo frames
up to 16,383 bytes. Add Frame length checks for standard and jumbo frames.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c         | 46 +++++++++++++++++++++++++++++++++++++++-----
 include/hw/net/cadence_gem.h |  4 +++-
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f6ff27c..85142e1 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -61,6 +61,7 @@
 #define GEM_TXPAUSE       (0x0000003C / 4) /* TX Pause Time reg */
 #define GEM_TXPARTIALSF   (0x00000040 / 4) /* TX Partial Store and Forward */
 #define GEM_RXPARTIALSF   (0x00000044 / 4) /* RX Partial Store and Forward */
+#define GEM_JUMBO_MAX_LEN (0x00000048 / 4) /* Max Jumbo Frame Size */
 #define GEM_HASHLO        (0x00000080 / 4) /* Hash Low address reg */
 #define GEM_HASHHI        (0x00000084 / 4) /* Hash High address reg */
 #define GEM_SPADDR1LO     (0x00000088 / 4) /* Specific addr 1 low reg */
@@ -212,10 +213,12 @@
 #define GEM_NWCFG_LERR_DISC    0x00010000 /* Discard RX frames with len err */
 #define GEM_NWCFG_BUFF_OFST_M  0x0000C000 /* Receive buffer offset mask */
 #define GEM_NWCFG_BUFF_OFST_S  14         /* Receive buffer offset shift */
+#define GEM_NWCFG_RCV_1538     0x00000100 /* Receive 1538 bytes frame */
 #define GEM_NWCFG_UCAST_HASH   0x00000080 /* accept unicast if hash match */
 #define GEM_NWCFG_MCAST_HASH   0x00000040 /* accept multicast if hash match */
 #define GEM_NWCFG_BCAST_REJ    0x00000020 /* Reject broadcast packets */
 #define GEM_NWCFG_PROMISC      0x00000010 /* Accept all packets */
+#define GEM_NWCFG_JUMBO_FRAME  0x00000008 /* Jumbo Frames enable */
 
 #define GEM_DMACFG_ADDR_64B    (1U << 30)
 #define GEM_DMACFG_TX_BD_EXT   (1U << 29)
@@ -233,6 +236,7 @@
 
 /* GEM_ISR GEM_IER GEM_IDR GEM_IMR */
 #define GEM_INT_TXCMPL        0x00000080 /* Transmit Complete */
+#define GEM_INT_AMBA_ERR      0x00000040
 #define GEM_INT_TXUSED         0x00000008
 #define GEM_INT_RXUSED         0x00000004
 #define GEM_INT_RXCMPL        0x00000002
@@ -453,6 +457,19 @@ static inline void rx_desc_set_sar(uint32_t *desc, int sar_idx)
 /* The broadcast MAC address: 0xFFFFFFFFFFFF */
 static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
+static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
+{
+    uint32_t size;
+    if (s->regs[GEM_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
+        size = s->regs[GEM_JUMBO_MAX_LEN];
+    } else if (tx) {
+        size = 1518;
+    } else {
+        size = s->regs[GEM_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 : 1518;
+    }
+    return size;
+}
+
 static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag)
 {
     if (q == 0) {
@@ -1016,6 +1033,12 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* Find which queue we are targeting */
     q = get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
 
+    if (size > gem_get_max_buf_len(s, false)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "rx frame too long\n");
+        gem_set_isr(s, q, GEM_INT_AMBA_ERR);
+        return -1;
+    }
+
     while (bytes_to_copy) {
         hwaddr desc_addr;
 
@@ -1196,12 +1219,13 @@ static void gem_transmit(CadenceGEMState *s)
                 break;
             }
 
-            if (tx_desc_get_length(desc) > MAX_FRAME_SIZE -
+            if (tx_desc_get_length(desc) > gem_get_max_buf_len(s, true) -
                                                (p - s->tx_packet)) {
-                DB_PRINT("TX descriptor @ 0x%" HWADDR_PRIx \
-                         " too large: size 0x%x space 0x%zx\n",
+                qemu_log_mask(LOG_GUEST_ERROR, "TX descriptor @ 0x%" \
+                         HWADDR_PRIx " too large: size 0x%x space 0x%zx\n",
                          packet_desc_addr, tx_desc_get_length(desc),
-                         MAX_FRAME_SIZE - (p - s->tx_packet));
+                         gem_get_max_buf_len(s, true) - (p - s->tx_packet));
+                gem_set_isr(s, q, GEM_INT_AMBA_ERR);
                 break;
             }
 
@@ -1343,9 +1367,10 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_RXPARTIALSF] = 0x000003ff;
     s->regs[GEM_MODID] = s->revision;
     s->regs[GEM_DESCONF] = 0x02500111;
-    s->regs[GEM_DESCONF2] = 0x2ab13fff;
+    s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[GEM_JUMBO_MAX_LEN] = s->jumbo_max_len;
 
     if (s->num_priority_queues > 1) {
         queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
@@ -1516,6 +1541,9 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         s->regs[GEM_IMR] &= ~val;
         gem_update_int_status(s);
         break;
+    case GEM_JUMBO_MAX_LEN:
+        s->regs[GEM_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
+        break;
     case GEM_INT_Q1_ENABLE ... GEM_INT_Q7_ENABLE:
         s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_ENABLE] &= ~val;
         gem_update_int_status(s);
@@ -1610,6 +1638,12 @@ static void gem_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_gem_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
+
+    if (s->jumbo_max_len > MAX_FRAME_SIZE) {
+        error_setg(errp, "jumbo-max-len is greater than %d",
+                  MAX_FRAME_SIZE);
+        return;
+    }
 }
 
 static void gem_init(Object *obj)
@@ -1659,6 +1693,8 @@ static Property gem_properties[] = {
                       num_type1_screeners, 4),
     DEFINE_PROP_UINT8("num-type2-screeners", CadenceGEMState,
                       num_type2_screeners, 4),
+    DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
+                       jumbo_max_len, 10240),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index eddac70..f6523dc 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -40,7 +40,8 @@
 #define MAX_TYPE1_SCREENERS             16
 #define MAX_TYPE2_SCREENERS             16
 
-#define MAX_FRAME_SIZE 2048
+#define MAX_JUMBO_FRAME_SIZE_MASK 0x3FFF
+#define MAX_FRAME_SIZE MAX_JUMBO_FRAME_SIZE_MASK
 
 typedef struct CadenceGEMState {
     /*< private >*/
@@ -84,6 +85,7 @@ typedef struct CadenceGEMState {
 
     uint8_t tx_packet[MAX_FRAME_SIZE];
     uint8_t rx_packet[MAX_FRAME_SIZE];
+    uint16_t jumbo_max_len;
     uint32_t rx_desc[MAX_PRIORITY_QUEUES][DESC_MAX_NUM_WORDS];
 
     bool sar_active[4];
-- 
2.7.4


