Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B6C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6363F206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QPRFeEZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6363F206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWlC-0003MU-K9
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSW-0001Sq-TR; Tue, 12 May 2020 11:04:40 -0400
Received: from mail-eopbgr690087.outbound.protection.outlook.com
 ([40.107.69.87]:27619 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSU-0002e9-Bp; Tue, 12 May 2020 11:04:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZabTxxWMZECsX8TvJkHvS30wdHTev3lQ3Kro353a7fFtovMHjHJzm8QK+rYNLeC5Ug5DjO7ymILNHnguXUlU/qMaufaZaT/yZuQexKUFoy95qHvTcVdWoPcsufHJaeTm5i6MTuTygYEcdSvMQVmI9R2lXs+X2UAqyVvYAwnTvmslD24qZ3GI3fKto3srINc5/DQ2XWbiuHHa4s61qd0mC4nI6KLiX3i4TytV6XaEN1vVo7gF17XEVy8FTYMgMyz33BtTLiCx/PM8sxhfYzR22rJvbDhQZsuQOTmg3t6RW06xkbmFYycbCablnzgjw2/GPC/gT2lYkvzmZKDStfaqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ul1DI5bs18h0UmD7LmGtj1djuX+GBUkpQUm2gJMMH0=;
 b=D+Co+9XH3fwrkaY6VejUtHsZOFZNew4XRMBsFV+/ySzOwYN7ibGflvcxlavzOFVXvyAD/zmtaKJdhMcCEphqYQBSojiUZcWjKz2AWpPROaWJB+7AB0AWviSyC2AadXewbCHwG3uV3mre4mqgVIr2reS7aVD2g/vCPDx6JohSUZKW08F/xalaobSGIyGSJGvfSCEAz7eQmHKgtQSFXgm4INQi9fCXs5SwvfTBf6djpnOe8lBuh0MyPtU6S7bbU25U1mubeR+87/i1yJ2E1XiXexfOb+O2LEWbepT21RD9SQ6226ZF/PTAx4OfbRMXQ6vdAnQE2pB7nig5MyVQuTi85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ul1DI5bs18h0UmD7LmGtj1djuX+GBUkpQUm2gJMMH0=;
 b=QPRFeEZEjK0odZ1qVAh+kBi4tlMWgNvt4I5c4uWEbSf5dy4yor2myXlFqDjqtmSlJp+IfI2oR0M+zPs++/ViIO54m01hXPpJ8leoNvHfUe8sh9S4HyXm7QXCzTPDLPwMzTs9I9qtFDMimP8/7VfObGLrgnLJAmmkJHDADEyqXNY=
Received: from MN2PR22CA0021.namprd22.prod.outlook.com (2603:10b6:208:238::26)
 by BN7PR02MB5186.namprd02.prod.outlook.com (2603:10b6:408:21::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 15:04:35 +0000
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:238:cafe::c0) by MN2PR22CA0021.outlook.office365.com
 (2603:10b6:208:238::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29 via Frontend
 Transport; Tue, 12 May 2020 15:04:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT048.mail.protection.outlook.com (10.152.76.109) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:34
 +0000
Received: from [149.199.38.66] (port=48839 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWS9-00045d-Te; Tue, 12 May 2020 08:04:17 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSQ-0003oY-7w; Tue, 12 May 2020 08:04:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSP-0003o7-Oe; Tue, 12 May 2020 08:04:33 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 4B39913C017A; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 06/12] net: cadence_gem: Move tx/rx packet buffert to
 CadenceGEMState
Date: Tue, 12 May 2020 20:24:48 +0530
Message-Id: <1589295294-26466-7-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(396003)(39860400002)(376002)(136003)(346002)(46966005)(33430700001)(81166007)(70206006)(186003)(5660300002)(70586007)(426003)(336012)(8676002)(4326008)(2616005)(2906002)(47076004)(82740400003)(6666004)(110136005)(42186006)(82310400002)(33440700001)(36756003)(8936002)(6266002)(356005)(316002)(478600001)(26005);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa4a7dab-615c-4961-f776-08d7f685c838
X-MS-TrafficTypeDiagnostic: BN7PR02MB5186:
X-Microsoft-Antispam-PRVS: <BN7PR02MB51868351C0873C27D1FCBE4ACABE0@BN7PR02MB5186.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZZ5S3FUgSYJ1nnqA6BJb89beFqEU9nutHQpj15tsiOdEb+7Pw7Y8sEBWIsAulS6TclfyNPmk75wAKvLqEgBs+v5ZqqtzB/iTDwlcg8jJCK3+F146kZ8FoFl5RAg42L2NZhILDR9oxqyEDMQQDmKJVbUklFQBunmg01uXEkF4gmVkHUFeFI0FYV5o+eP5BR9s1nRXRga+4ePFtBc+5F1yHSatBAanhAJDWVazZ5XLVtugV4yXtaz+O+g/MLGndJwtm+Am7UPqkEFaZXRnV4huLW5frUMlaswbKSenQWHJYNMbH50w14BlHzO0qAUI5avoexlrG1S3ohnqw43YyD4F4K0jNuvqcf7zILzvo7mrwIBlDhz0ES1K1dPqsshJlj6C+8WLomhgyuV6c8rwbXwvNFOnmjl9JWpU9vwGviHMrSHBt6+m0dQ+zpWccfui7hTSM4dkP06aeBO9blHWJPiX0TcT0WMGAacAEA66qw0xpMxfiCbz2tUrVRHt/pD6QAO0K3mhNNcvqJfEQIcrSmBVgpXZJVw86X4imEf+pZEi0TULgzNZQUIOakvLueCq1bZceiMvCnzIaeqJl92Dft1hw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:34.6344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4a7dab-615c-4961-f776-08d7f685c838
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5186
Received-SPF: pass client-ip=40.107.69.87; envelope-from=saipava@xilinx.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:36
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


