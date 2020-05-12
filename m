Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57846C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9B2206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Aw8Ju/O1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9B2206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUuJ-00084i-4j
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnt-0007U7-PW; Tue, 12 May 2020 09:18:37 -0400
Received: from mail-eopbgr770057.outbound.protection.outlook.com
 ([40.107.77.57]:51590 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUns-0001zl-B6; Tue, 12 May 2020 09:18:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd2qQ5WENmFx54q79LGQuE/fox+MeNCracYIWCP4DcvEQl49P5q2hw+rgA8AK1GPPXZwY/h9y1sjkggxmWblyYGETOxwI5bDWrLRi6kVUfmfcYGPrJDbQi49FomtCsJsfsKiF+Ib+UmgJEuSNjMd8zLadhSsiP60lZ0R4KXb7n1Nafx23mfyAn6noVH/3Uo3h0/96z1JcEjFpndUcw4QwfFpjqz4144bD6Ul3sH6lxZc86d1Io+cSoLLyF4NATL7NADUjRtcRA+1uNxWNclSyVukc8clrNtHqyl0laFp5UIJr2Iz/aPClnOSI8lpQZugIrVeORhL15aLxl6WEth7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ul1DI5bs18h0UmD7LmGtj1djuX+GBUkpQUm2gJMMH0=;
 b=n+mmvLhu0s3Co3+YLqWVFhuPL+ez0HXcVAvl3z4kJASh+fSD17XIKB3B1n1SWshogiXHzcKhFqacT83hiw5xzPFqIhWTr0PJWRTjahFOcOut3zOc0eoDyLc6hCsnoIid1IhwhasE0HhuMfdJ4edy6q0w431ryN7cYhE81oytsL6qvd4cUl3VAXXM5QIb3QxaDNaJRy/7oi0x0YCxIYktuzWb6+M5ZDl8cZwYfU8dXD92X0GygFignKu6HIhaYagxxIGq0F82ZU8vTRXoAVaGUFOSM1/QOHeAR6TnuwR7M2wONv35DebP36YttxLqRJJ2yfSd2ztuBCTZA3okXEZuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ul1DI5bs18h0UmD7LmGtj1djuX+GBUkpQUm2gJMMH0=;
 b=Aw8Ju/O10ecCZMUWxFkJ/fTj26KdZ6/tYLVRuaeHXWkQuNbYOHxfg2wsCpH/RuDO3w9klHlhL2k0gcfqy6wsicfWGWxq5Wp5TL4amYQcxiUiRU6F1c8udVUUB6OeDng3XNj7Yo6pdrQIUQpDbgtSY/KfRKcF+3PQKiSIOvGilDU=
Received: from CY4PR13CA0045.namprd13.prod.outlook.com (2603:10b6:903:99::31)
 by CH2PR02MB7079.namprd02.prod.outlook.com (2603:10b6:610:82::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Tue, 12 May
 2020 13:18:33 +0000
Received: from CY1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::f9) by CY4PR13CA0045.outlook.office365.com
 (2603:10b6:903:99::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend
 Transport; Tue, 12 May 2020 13:18:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT046.mail.protection.outlook.com (10.152.74.232) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:32
 +0000
Received: from [149.199.38.66] (port=47676 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnX-0002QY-SL; Tue, 12 May 2020 06:18:15 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUno-0005ZK-3S; Tue, 12 May 2020 06:18:32 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDIVhe028652; 
 Tue, 12 May 2020 06:18:31 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnm-0005Yb-KU; Tue, 12 May 2020 06:18:31 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id A6B4213C0168; Tue, 12 May 2020 18:40:27 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 06/12] net: cadence_gem: Move tx/rx packet buffert to
 CadenceGEMState
Date: Tue, 12 May 2020 18:40:01 +0530
Message-Id: <1589289007-23629-7-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(396003)(376002)(39860400002)(346002)(136003)(46966005)(33430700001)(478600001)(186003)(82310400002)(2616005)(6266002)(4326008)(26005)(426003)(33440700001)(5660300002)(336012)(6666004)(8936002)(316002)(42186006)(110136005)(356005)(81166007)(70586007)(36756003)(2906002)(70206006)(47076004)(82740400003)(8676002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67240b90-fdc3-477a-2272-08d7f676f80a
X-MS-TrafficTypeDiagnostic: CH2PR02MB7079:
X-Microsoft-Antispam-PRVS: <CH2PR02MB707900E77F79056A8DB6D433CABE0@CH2PR02MB7079.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWcI59pJS9GoMXtK4CUp+IL0JfPhghguSYaPonmrr/vKGlW/I0SKNlrY428livgHfRGiEx5rfMm8gni+Y5Osn4ylHpdTFA2AlRPKdFkGTbPKfYsVrPJOspjWKlwaulLiMGsQF8zKJgLGgUYBRGd4OsIw7IsaqnmBiCvBzR45KX7iJtxd7L3qYgc05Cl49uIcIXlAWQlJi+oXUZYdCTJka3Emw9Ac9bnYOdnf95xgOMImXB/L0fdd7Fht+cOAqwl3+faNCVQC5BB5N3apDMQ08NK/dRz7UmrLra512JPmEOkWPXiby1NNvzOZH1TSkwEVMKfWU7WAU7djd4MRN9ltLlqmUkt+7c6fWJZkOxfAe7dx2B27ecsbVdV9taci7zE6BIMkRcGA3RR0OluINl02CA8ocUOdKA5C5dQWnkfeaSP4UIMlrPcRe0JtuAKxAehvEik74b+Hav0S4JOFpF2vSKvXoOlDWbXozVKcxFeyEWIqDxYpAx72WTtE5PKA3xsg57I8ClzR2o6v1uDDFW2wiJ+xwQb55j5iZrsEPuw06bH95dk/Ue4Ji9CQE+FBAJaiViClvhj5Un66V0scBlJOXw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:32.4062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67240b90-fdc3-477a-2272-08d7f676f80a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7079
Received-SPF: pass client-ip=40.107.77.57; envelope-from=saipava@xilinx.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:34
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

Moving this buffers to CadenceGEMState, as their size will be increased
more when JUMBO frames support is added.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c         | 38 +++++++++++++++++---------------------
 include/hw/net/cadence_gem.h |  4 ++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d3f7166..11e36d0 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -928,17 +928,14 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
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
@@ -994,19 +991,19 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
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
@@ -1152,7 +1149,6 @@ static void gem_transmit(CadenceGEMState *s)
 {
     uint32_t desc[DESC_MAX_NUM_WORDS];
     hwaddr packet_desc_addr;
-    uint8_t     tx_packet[2048];
     uint8_t     *p;
     unsigned    total_bytes;
     int q = 0;
@@ -1168,7 +1164,7 @@ static void gem_transmit(CadenceGEMState *s)
      * Packets scattered across multiple descriptors are gathered to this
      * one contiguous buffer first.
      */
-    p = tx_packet;
+    p = s->tx_packet;
     total_bytes = 0;
 
     for (q = s->num_priority_queues - 1; q >= 0; q--) {
@@ -1198,12 +1194,12 @@ static void gem_transmit(CadenceGEMState *s)
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
 
@@ -1248,24 +1244,24 @@ static void gem_transmit(CadenceGEMState *s)
 
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
 
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 5c83036..eddac70 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -40,6 +40,8 @@
 #define MAX_TYPE1_SCREENERS             16
 #define MAX_TYPE2_SCREENERS             16
 
+#define MAX_FRAME_SIZE 2048
+
 typedef struct CadenceGEMState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -80,6 +82,8 @@ typedef struct CadenceGEMState {
 
     uint8_t can_rx_state; /* Debug only */
 
+    uint8_t tx_packet[MAX_FRAME_SIZE];
+    uint8_t rx_packet[MAX_FRAME_SIZE];
     uint32_t rx_desc[MAX_PRIORITY_QUEUES][DESC_MAX_NUM_WORDS];
 
     bool sar_active[4];
-- 
2.7.4


