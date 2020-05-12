Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9CC54E8E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41551206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KH0EpMp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41551206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWqp-0000M2-Fz
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWT1-0002Mb-06; Tue, 12 May 2020 11:05:11 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com
 ([40.107.244.44]:23360 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSz-0002rh-Iu; Tue, 12 May 2020 11:05:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+IYTO1JKnj28KstfK9V53sAvap/giyGieaC2XaAX5bVh+FVPwGHmo6jGVomG6QsaGnDrRS04VpmDnwHIvTP9wBBYlicW3fM324mUU0JAyl8XCezLQpkT/GmbCLZ2sHQpBfTiJ4wTRzC1cFoC4DQPwoDGR4YFo7w23NkuBIJAfQkfTD8z/TXCgM1hGcXLzMCy6N6LotlAF4WgVNz6Y8OcjUy1M7BtzyuGPtuwyiGuYOT6RTLV5Dv9r57PO84R2QdMQg6Ki2ZS9E4IUYEC6mxywBBaDjzVj41nCbotydetymC8qa0KYP4XgZHhX63/28Ih68x3LoeWsew3Rb4ps1n0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q2+oS9GKCSBUE47+B38hjhpoGkd+/1OAYoUh0Rcrdo=;
 b=Aoz18CEcHNJhjLIMOfjF/FNdfEzRv0cDIH4OYlyyUW6p2EeaCKLbIOPvW5nbdP9u/1ZntNGr/ujzHLrNCFRYjwXteRSkemmprC28k5+29g30JIqBcCRbZuQLNdO5YPle4il+WYr+ScQe+SO0FtLQtL4JY+iELVGJs1sx78zT9g54KjYlkMjjJ4gCcLhpd76uAyLpp0N4eISd998npk3vd1K/3VB0ypI2bIP5i6jBZoT3QJESm62C4ljTRCCKHCQ4Ao3DeZpm+Y3KzNhpjodvHlXgP3kqpq/v5AkX/Wc/7jl5g6XDdTZOis8spq4VVaqB96Q9js88jpPzwGpzrz537A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q2+oS9GKCSBUE47+B38hjhpoGkd+/1OAYoUh0Rcrdo=;
 b=KH0EpMp1MIBJoZBHCRUzlNTWB8/MtqpyGix5uE/FDttiMcpiOHnnnSXRcep6XtVvWA9fjzNkhNPvgYsClStSZp/uRGrCngaSN6fp1u5uaTfv3Igv1rQ46CxqNdfHTC1gVGAhL3fNWrB5lorKBw+Rd1hCdASX6S6sEP17cCuqEIs=
Received: from CY4PR13CA0042.namprd13.prod.outlook.com (2603:10b6:903:99::28)
 by BN7PR02MB4004.namprd02.prod.outlook.com (2603:10b6:406:fe::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 15:04:35 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::ee) by CY4PR13CA0042.outlook.office365.com
 (2603:10b6:903:99::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend
 Transport; Tue, 12 May 2020 15:04:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:34
 +0000
Received: from [149.199.38.66] (port=48864 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSA-00045p-AR; Tue, 12 May 2020 08:04:18 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSQ-0003ot-MM; Tue, 12 May 2020 08:04:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSP-0003oA-P3; Tue, 12 May 2020 08:04:34 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 57C4713C017D; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 08/12] net: cadence_gem: Add support for jumbo frames
Date: Tue, 12 May 2020 20:24:50 +0530
Message-Id: <1589295294-26466-9-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(39860400002)(376002)(136003)(396003)(346002)(46966005)(33430700001)(316002)(110136005)(36756003)(33440700001)(426003)(2616005)(70206006)(81166007)(356005)(82310400002)(82740400003)(70586007)(6266002)(8936002)(8676002)(336012)(2906002)(26005)(186003)(4326008)(47076004)(42186006)(478600001)(6666004)(5660300002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 351a239d-7b7e-4383-5f4e-08d7f685c869
X-MS-TrafficTypeDiagnostic: BN7PR02MB4004:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4004833E130135CB86649525CABE0@BN7PR02MB4004.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVOMKIOZ95AzTiPO325HwSJ2LqArZ3km0sO3N+T8lmLVncaOTxWs8ic409RtNPnoTT5MbGTuWFsNmSjYmR/LBJIk+QTOzj/NOdMNc/nuJaXQC9dc+NHz+IwPzvqNA8QU0E5I0VG/mV6Ol1FH4b4z/RG8Dqn0bmGpzjjcgBoUZpp6rPlDodEgQbc/+BwzdRSHYoSBEMu9ZZpIhy8eCGJcPH0sNa8cHIyZmSCM/5CUV7FL3DrRc4ez32bFXxBMpwpClCvmRrZmzJHc+RSUG0nCGigv+L77oo+ihxoFkGWX1jK2yHNrlZlNQwF3IJIJ3G2HtNMa5cNK41qCq6W+Ng5ZpBqeJQqS4pO+pnqAK9xqIiaMWOSx8EZx7JJb7x9sWCkdW0n+Hy/NJp0R22QyMKkVbS37jNprrldgO+F/YShg5B8uOC7RL7r6o1GjepEC/mvMW16qp19tgW1BCBSPB1kWQz3TaT08Ns1Z8KUV5YNVgS4Ed3hs71QBm4ai/vVARBzu6YplpTQRzmDminpSfcxc+8BnLvhPTSo+CWsywIRBG4Dl5dlaIICIJslsfdJKpMnRX0+9eFFtTlzIP0z/OxeroQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:34.9506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351a239d-7b7e-4383-5f4e-08d7f685c869
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4004
Received-SPF: pass client-ip=40.107.244.44; envelope-from=saipava@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:05:06
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
up to 16,383 bytes. Add Frame length checks for standard and jumbo
frames.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c         | 51 +++++++++++++++++++++++++++++++++++++++-----
 include/hw/net/cadence_gem.h |  4 +++-
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f6ff27c..eb02946 100644
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
@@ -453,6 +457,24 @@ static inline void rx_desc_set_sar(uint32_t *desc, int sar_idx)
 /* The broadcast MAC address: 0xFFFFFFFFFFFF */
 static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
+static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
+{
+    uint32_t size;
+    if (s->regs[GEM_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
+        size = s->regs[GEM_JUMBO_MAX_LEN];
+        if (size > s->jumbo_max_len) {
+            size = s->jumbo_max_len;
+            qemu_log_mask(LOG_GUEST_ERROR, "GEM_JUMBO_MAX_LEN reg cannot be"
+                " greater than 0x%" PRIx32 "\n", s->jumbo_max_len);
+        }
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
@@ -1016,6 +1038,12 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
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
 
@@ -1196,12 +1224,13 @@ static void gem_transmit(CadenceGEMState *s)
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
 
@@ -1343,9 +1372,10 @@ static void gem_reset(DeviceState *d)
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
@@ -1516,6 +1546,9 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         s->regs[GEM_IMR] &= ~val;
         gem_update_int_status(s);
         break;
+    case GEM_JUMBO_MAX_LEN:
+        s->regs[GEM_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
+        break;
     case GEM_INT_Q1_ENABLE ... GEM_INT_Q7_ENABLE:
         s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_ENABLE] &= ~val;
         gem_update_int_status(s);
@@ -1610,6 +1643,12 @@ static void gem_realize(DeviceState *dev, Error **errp)
 
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
@@ -1659,6 +1698,8 @@ static Property gem_properties[] = {
                       num_type1_screeners, 4),
     DEFINE_PROP_UINT8("num-type2-screeners", CadenceGEMState,
                       num_type2_screeners, 4),
+    DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
+                       jumbo_max_len, 10240),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index eddac70..54e646f 100644
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
@@ -59,6 +60,7 @@ typedef struct CadenceGEMState {
     uint8_t num_type1_screeners;
     uint8_t num_type2_screeners;
     uint32_t revision;
+    uint16_t jumbo_max_len;
 
     /* GEM registers backing store */
     uint32_t regs[CADENCE_GEM_MAXREG];
-- 
2.7.4


