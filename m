Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7138FC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1B72070B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SMP0nBPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1B72070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0xs-0000DI-BY
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sE-0007gT-Cn; Fri, 08 May 2020 07:08:59 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com
 ([40.107.93.50]:44385 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sB-00025k-Nk; Fri, 08 May 2020 07:08:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ+uVO/0c4Ueu/s/xlYIMn8D+N09S2Xml6UhqOHGTsXXXuOSrF4qEF9PE4V0vNWayvj5qIrIVGIUmsjGpNokIlKxeZYUWh2U4bwya9SDbKK39CNJJFKUfUV3BdWjPUchSUCDSkQ7x1fTyUTLB1+/7iSktvN1h8jgOESgfBYaZ7b7BJv503fcK+8i7AxhomHhBah44XW/D2zMaspnLKUpNUKxyklKBmzmTKx6R+RC0JXHtBwnQgwi6qPxIWp7h5S0kdmSKFQvrtH/Hdbvw7r+cyk+GB2JWe4C9MiXm3+iVdwRflqvJX80dBzxm/swqwaftc0WcbWDj4Y7xg3/nW8DXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKccMTLbpAmQPoqvwKLulzX4D/ligJYt5WjwzyEQl0Y=;
 b=UxyUPv8aWvfEM5pRcDLMSFmrHvQJr4BkLhPkLOWrDb4oxVCqLsCKKXH1BMhjCixG5/p2ZfCIzi4Y18opqbw4NmUbbesPuj69idHmRvoySmT/BJ7LsN2584HMqAY63DTt2A7bpXSP1Av8MS36+6fdT1gpHDxLmEcPKUREntaV2RueR1rmLRkaKa+hToQXRmbb7vI8QWZt9+0JoKCrveuC09mi5ufRD7r3fWfu14TxmuK83LXaHFTZ09QfpgGPDVxQqc2y1pDDKyvxMwkixUZY9AoDNRQjMo36d9yILqWuBqgXml++Jdbpy7/dk38niFIDYrPah9Xz6Rb60msYAEf/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKccMTLbpAmQPoqvwKLulzX4D/ligJYt5WjwzyEQl0Y=;
 b=SMP0nBPakKjsTjhVMKV5UseJmcFqFrngQbP8yrpO/id4pH6LJD4O1gzRAAwf2Y3ALataYO30X3wilpiAq42awRp+GNYAfrM6QW40TUuD/vKLwL3n/IAnip9Iup3Vto66tfwF99+KijrvPlyfiyYrGQ24LoIgmFDKmFagUye13O4=
Received: from DM6PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:40::28) by
 BL0PR02MB4754.namprd02.prod.outlook.com (2603:10b6:208:5d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Fri, 8 May 2020 11:08:52 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::9a) by DM6PR03CA0015.outlook.office365.com
 (2603:10b6:5:40::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Fri, 8 May 2020 11:08:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Fri, 8 May 2020 11:08:51
 +0000
Received: from [149.199.38.66] (port=36016 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0rw-0002Ty-Mp; Fri, 08 May 2020 04:08:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0s7-0005dR-Fu; Fri, 08 May 2020 04:08:51 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 048B8o2d017584; 
 Fri, 8 May 2020 04:08:50 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jX0s6-0005c7-4m; Fri, 08 May 2020 04:08:50 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 1746F13C042F; Fri,  8 May 2020 16:30:58 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 06/11] net: cadence_gem: Move tx/rx packet buffert to
 CadenceGEMState
Date: Fri,  8 May 2020 16:30:40 +0530
Message-Id: <1588935645-20351-7-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(376002)(346002)(39860400002)(136003)(396003)(46966005)(33430700001)(8676002)(81166007)(186003)(36756003)(42186006)(316002)(5660300002)(110136005)(6666004)(33440700001)(47076004)(478600001)(26005)(2906002)(4326008)(8936002)(356005)(2616005)(426003)(336012)(70586007)(82740400003)(70206006)(82310400002)(6266002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c75401a-e1c5-43dd-3389-08d7f34030c4
X-MS-TrafficTypeDiagnostic: BL0PR02MB4754:
X-Microsoft-Antispam-PRVS: <BL0PR02MB47546660CFFC882423A7A0DDCAA20@BL0PR02MB4754.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jabS56lp6YP/c0eXtmtKJp/MHdDKbGo1P2OQU9NHWipnaSUC6zxrPFSd8OSjZr09zLDpd28LnWWlQGGefAepNLG9wPzyB5Gf/QpIl0MVYaGksjqTVebQP7xbR5l9EovKVbaWU22cymHTd4TcVEsYC8qS6LL4daT9+w3YKDIz+AUUKxEBf0JErF8e+66YJZL84/iBQ7DoXORK5jfgMFSwc9cgndT/tyRm4eI4XTgog7Pj11lF3AumM1D+53HgmfbMpvdwdh6aUftSm5Tn33/txkO97+fIAyATOs56PBRYEnGxYDhzAaM5AKbTRexi6uoLCwYhjUkRK9clQrEFX71dmVS0oI7QYW8K/pE0aYoXMWvCYq3uoPBfW8Sg2BhRlGWXZoQ7zNevCRSVKYqNIkQZEBdoFdGL3SCFzJlUFA2mPCfd3AduPMiG4KCT/4wsRL1lcCcM7YgqkoyzjiY//iNr13YNo0NE7oKtx6tqgRfKrtwBCPKHRGDzma4wP/ew0z7eIRWJPB9L1Dt7zBbdPIUa7bDK6nUg/YX5nFrdVquS3pFq5b76hT5HXTj2vA8zpQmb6jrjqERPWacpPd03zx21Yw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 11:08:51.7705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c75401a-e1c5-43dd-3389-08d7f34030c4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4754
Received-SPF: pass client-ip=40.107.93.50; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:08:54
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

Moving this buffers to CadenceGEMState, as their size will be increased
more when JUMBO frames support is added.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c         | 52 ++++++++++++++++++++++++++------------------
 include/hw/net/cadence_gem.h |  2 ++
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 77a0588..5ccec1a 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -314,6 +314,8 @@
 
 #define GEM_MODID_VALUE 0x00020118
 
+#define MAX_FRAME_SIZE 2048
+
 static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
     uint64_t ret = desc[0];
@@ -928,17 +930,14 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
  */
 static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 {
-    CadenceGEMState *s;
+    CadenceGEMState *s = qemu_get_nic_opaque(nc);
     unsigned   rxbufsize, bytes_to_copy;
     unsigned   rxbuf_offset;
-    uint8_t    rxbuf[2048];
     uint8_t   *rxbuf_ptr;
     bool first_desc = true;
     int maf;
     int q = 0;
 
-    s = qemu_get_nic_opaque(nc);
-
     /* Is this destination MAC address "for us" ? */
     maf = gem_mac_address_filter(s, buf);
     if (maf == GEM_RX_REJECT) {
@@ -994,19 +993,19 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     } else {
         unsigned crc_val;
 
-        if (size > sizeof(rxbuf) - sizeof(crc_val)) {
-            size = sizeof(rxbuf) - sizeof(crc_val);
+        if (size > MAX_FRAME_SIZE - sizeof(crc_val)) {
+            size = MAX_FRAME_SIZE - sizeof(crc_val);
         }
         bytes_to_copy = size;
         /* The application wants the FCS field, which QEMU does not provide.
          * We must try and calculate one.
          */
 
-        memcpy(rxbuf, buf, size);
-        memset(rxbuf + size, 0, sizeof(rxbuf) - size);
-        rxbuf_ptr = rxbuf;
-        crc_val = cpu_to_le32(crc32(0, rxbuf, MAX(size, 60)));
-        memcpy(rxbuf + size, &crc_val, sizeof(crc_val));
+        memcpy(s->rx_packet, buf, size);
+        memset(s->rx_packet + size, 0, MAX_FRAME_SIZE - size);
+        rxbuf_ptr = s->rx_packet;
+        crc_val = cpu_to_le32(crc32(0, s->rx_packet, MAX(size, 60)));
+        memcpy(s->rx_packet + size, &crc_val, sizeof(crc_val));
 
         bytes_to_copy += 4;
         size += 4;
@@ -1152,7 +1151,6 @@ static void gem_transmit(CadenceGEMState *s)
 {
     uint32_t desc[DESC_MAX_NUM_WORDS];
     hwaddr packet_desc_addr;
-    uint8_t     tx_packet[2048];
     uint8_t     *p;
     unsigned    total_bytes;
     int q = 0;
@@ -1168,7 +1166,7 @@ static void gem_transmit(CadenceGEMState *s)
      * Packets scattered across multiple descriptors are gathered to this
      * one contiguous buffer first.
      */
-    p = tx_packet;
+    p = s->tx_packet;
     total_bytes = 0;
 
     for (q = s->num_priority_queues - 1; q >= 0; q--) {
@@ -1198,12 +1196,12 @@ static void gem_transmit(CadenceGEMState *s)
                 break;
             }
 
-            if (tx_desc_get_length(desc) > sizeof(tx_packet) -
-                                               (p - tx_packet)) {
+            if (tx_desc_get_length(desc) > MAX_FRAME_SIZE -
+                                               (p - s->tx_packet)) {
                 DB_PRINT("TX descriptor @ 0x%" HWADDR_PRIx \
                          " too large: size 0x%x space 0x%zx\n",
                          packet_desc_addr, tx_desc_get_length(desc),
-                         sizeof(tx_packet) - (p - tx_packet));
+                         MAX_FRAME_SIZE - (p - s->tx_packet));
                 break;
             }
 
@@ -1248,24 +1246,24 @@ static void gem_transmit(CadenceGEMState *s)
 
                 /* Is checksum offload enabled? */
                 if (s->regs[GEM_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
-                    net_checksum_calculate(tx_packet, total_bytes);
+                    net_checksum_calculate(s->tx_packet, total_bytes);
                 }
 
                 /* Update MAC statistics */
-                gem_transmit_updatestats(s, tx_packet, total_bytes);
+                gem_transmit_updatestats(s, s->tx_packet, total_bytes);
 
                 /* Send the packet somewhere */
                 if (s->phy_loop || (s->regs[GEM_NWCTRL] &
                                     GEM_NWCTRL_LOCALLOOP)) {
-                    gem_receive(qemu_get_queue(s->nic), tx_packet,
+                    gem_receive(qemu_get_queue(s->nic), s->tx_packet,
                                 total_bytes);
                 } else {
-                    qemu_send_packet(qemu_get_queue(s->nic), tx_packet,
+                    qemu_send_packet(qemu_get_queue(s->nic), s->tx_packet,
                                      total_bytes);
                 }
 
                 /* Prepare for next packet */
-                p = tx_packet;
+                p = s->tx_packet;
                 total_bytes = 0;
             }
 
@@ -1612,6 +1610,17 @@ static void gem_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_gem_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
+
+    s->tx_packet = g_new0(uint8_t, MAX_FRAME_SIZE);
+    s->rx_packet = g_new0(uint8_t, MAX_FRAME_SIZE);
+}
+
+static void gem_unrealize(DeviceState *dev, Error **errp)
+{
+    CadenceGEMState *s = CADENCE_GEM(dev);
+
+    g_free(s->tx_packet);
+    g_free(s->rx_packet);
 }
 
 static void gem_init(Object *obj)
@@ -1669,6 +1678,7 @@ static void gem_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = gem_realize;
+    dc->unrealize = gem_unrealize;
     device_class_set_props(dc, gem_properties);
     dc->vmsd = &vmstate_cadence_gem;
     dc->reset = gem_reset;
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 5c83036..8dbbaa3 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -80,6 +80,8 @@ typedef struct CadenceGEMState {
 
     uint8_t can_rx_state; /* Debug only */
 
+    uint8_t *tx_packet;
+    uint8_t *rx_packet;
     uint32_t rx_desc[MAX_PRIORITY_QUEUES][DESC_MAX_NUM_WORDS];
 
     bool sar_active[4];
-- 
2.7.4


