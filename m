Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA1C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7639520731
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FT7tBF4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7639520731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwTu-0002oZ-Il
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwSY-0000nn-Vj
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwS3-0000SL-Py
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:54 -0400
Received: from mail-eopbgr760042.outbound.protection.outlook.com
 ([40.107.76.42]:35967 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwS3-0000OQ-7R; Sat, 02 May 2020 14:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmBLVzAPHYGrx7flxRSAGUpBWbqgZvWbcurKQjU6BvrP8yqhZunK8bOE8qGiVPJGsfLrI9oiBsL5m+nKWBFIVp2u65BN7sDmJTq3NkIxkPaj+paxr3S9WVzCOp8S35l6nsacoA5yzeik3prvSihPsphHbNFHEDgTQbcUpdc/KoJvIUh49qPbNiI15jOTz0KTo4il9mnKK9Q/PeWsBMrsqz6SahOvQOnj5d4NRvJUuHMLtKHop+0S1bSLznD26qsZ4oMgQWFNOKCD2I63P4AfmitAiWQbxJrDTHaLVxOV0l3dcHia3zI5CoXHEawm1lgPKSLw4fhpCTrC1IEmXG/cVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ocw6bLZQ7aVvGQelf4qtGWXMh0VHHX4SMx9RuqgN7J0=;
 b=QWeNZpjaZGZUsx6ZXZaN/es8Rla1QnnqSPLy857PrjXcGfsTWKozzQAKCukbW+/9t2SAG7b8vpvGSbfSfqwyj8E4iL+GXn0kjoQ9l6NTuXgpDFzmEJyFs9qBJk65ZBRcBTZW2vuth5knQbCH3APieQz891p5RWgiWaLsNhruC2Zkkcy6KEYdjyPZr/b/SbrY16XSo0lH3udsWEdtjrqIZfcIfh1YpnRdnfZvzM59oiW6R2W3ZPTKUKfQ740180BDfnG4d/Yb3yFQ+bfkddi+B4Fc8SOoFy/iQdhkcM35FdlM5AeztMSK9boVV1VHk6GbV7PdD7IBIj946rC3zCoO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ocw6bLZQ7aVvGQelf4qtGWXMh0VHHX4SMx9RuqgN7J0=;
 b=FT7tBF4u32a/XP4p1kLHEx5051ixmIWdJgDJHNCQWukCCisoy7vZEeah63pPLFJ9NQ0DXFxuQ6DcXkzXF4pcDK8Nr5R1tg8XGpspuYSmU6x0FDet0aJgGwxOY4g8uOaUNfv+WDS/YTmAGYGTVWTxjam+JiaVNKWgVsWvNcNiHJE=
Received: from SN4PR0501CA0044.namprd05.prod.outlook.com
 (2603:10b6:803:41::21) by SN1PR02MB3728.namprd02.prod.outlook.com
 (2603:10b6:802:31::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Sat, 2 May
 2020 18:01:17 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::48) by SN4PR0501CA0044.outlook.office365.com
 (2603:10b6:803:41::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.18 via Frontend
 Transport; Sat, 2 May 2020 18:01:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:17
 +0000
Received: from [149.199.38.66] (port=60209 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRt-0004nH-Pr; Sat, 02 May 2020 11:01:13 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRx-0006w6-1G; Sat, 02 May 2020 11:01:17 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1GBS010794; 
 Sat, 2 May 2020 11:01:16 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRv-0006uw-S5; Sat, 02 May 2020 11:01:16 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id A625A13C0491; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 02/10] net: cadence_gem: Fix the queue address update during
 wrap around
Date: Sat,  2 May 2020 23:23:06 +0530
Message-Id: <1588441994-21447-3-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(396003)(346002)(376002)(136003)(39860400002)(46966005)(6266002)(478600001)(82740400003)(186003)(2906002)(81166007)(356005)(26005)(5660300002)(4326008)(47076004)(70586007)(70206006)(36756003)(8936002)(8676002)(336012)(82310400002)(2616005)(6666004)(316002)(42186006)(110136005)(426003);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef57e1f1-8ad5-42bc-dd29-08d7eec2cfd0
X-MS-TrafficTypeDiagnostic: SN1PR02MB3728:
X-Microsoft-Antispam-PRVS: <SN1PR02MB3728362EAD3A1B92E16C447FCAA80@SN1PR02MB3728.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FffO6O4syjfNdepCY6qR6NdAZU1H4rslN1GMxZNyLBHgLFVgPbCN5sCJr3Gd/i/MQ9ByATnmIp2qPh8uM3oaXv+yMEqTHW/ufyHVEuhbL0NmvwB2cqDRD60qTMQT3gRNXMVBUf/yviECfp/m3DDKCPGLtG+jOedN9hLXa+9b63tOEBy2R9kYMfR2N/oIpNW01NMu7airrCOf9h4jWFs7NyqRmlBtZ57k35vb3SOPh1QiLAh5j8EyvOxMUjHLdG7RCWewk61zJxT49+zN1i56tUSoiMzL2YbDK5MqsCc+1LL/nMb+SHjdW0Ms+J7dbJyXDRbdebhZxvDNWBCREuWVHlyEATxXQXVvX3CUFAMrjkVgWzQ+szUa7R1o/ipmrnI8C5UA/00F3872uSOnPJ0CsN5N1BKuuEPeYbcJcixJc5LfxXDN0Vt2vGRzigPebWh/+qseVocs/Ga6V4XCDWcWhBW5eM2VfsW+xkll5ldiIqcKsxXLSFtyuXE07TfL4RxSs+KoakzLDtVvxcEsTW4wJQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:17.3702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef57e1f1-8ad5-42bc-dd29-08d7eec2cfd0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3728
Received-SPF: pass client-ip=40.107.76.42; envelope-from=saipava@xilinx.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:01:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.76.42
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

During wrap around and reset, queues are pointing to initial base
address of queue 0, irrespective of what queue we are dealing with.
Fix it by assigning proper base address every time.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 92fcbe5..074aaa8 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -845,6 +845,25 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
     return 0;
 }
 
+static uint32_t gem_get_queue_base_addr(CadenceGEMState *s, bool tx, int q)
+{
+    uint32_t base_addr = 0;
+
+    switch (q) {
+    case 0:
+        base_addr = s->regs[tx ? GEM_TXQBASE : GEM_RXQBASE];
+        break;
+    case 1 ... (MAX_PRIORITY_QUEUES - 1):
+        base_addr = s->regs[(tx ? GEM_TRANSMIT_Q1_PTR :
+                                 GEM_RECEIVE_Q1_PTR) + q - 1];
+        break;
+    default:
+        g_assert_not_reached();
+    };
+
+    return base_addr;
+}
+
 static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
 {
     hwaddr desc_addr = 0;
@@ -1043,7 +1062,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         /* Next descriptor */
         if (rx_desc_get_wrap(s->rx_desc[q])) {
             DB_PRINT("wrapping RX descriptor list\n");
-            s->rx_desc_addr[q] = s->regs[GEM_RXQBASE];
+            s->rx_desc_addr[q] = gem_get_queue_base_addr(s, false, q);
         } else {
             DB_PRINT("incrementing RX descriptor list\n");
             s->rx_desc_addr[q] += 4 * gem_get_desc_len(s, true);
@@ -1199,7 +1218,8 @@ static void gem_transmit(CadenceGEMState *s)
                                     sizeof(desc_first));
                 /* Advance the hardware current descriptor past this packet */
                 if (tx_desc_get_wrap(desc)) {
-                    s->tx_desc_addr[q] = s->regs[GEM_TXQBASE];
+                    s->tx_desc_addr[q] = gem_get_queue_base_addr(s,
+                                         true, q);
                 } else {
                     s->tx_desc_addr[q] = packet_desc_addr +
                                          4 * gem_get_desc_len(s, false);
@@ -1251,7 +1271,8 @@ static void gem_transmit(CadenceGEMState *s)
                 } else {
                     packet_desc_addr = 0;
                 }
-                packet_desc_addr |= s->regs[GEM_TXQBASE];
+                packet_desc_addr |= gem_get_queue_base_addr(s,
+                                    true, q);
             } else {
                 packet_desc_addr += 4 * gem_get_desc_len(s, false);
             }
@@ -1457,7 +1478,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         if (!(val & GEM_NWCTRL_TXENA)) {
             /* Reset to start of Q when transmit disabled. */
             for (i = 0; i < s->num_priority_queues; i++) {
-                s->tx_desc_addr[i] = s->regs[GEM_TXQBASE];
+                s->tx_desc_addr[i] = gem_get_queue_base_addr(s, true, i);
             }
         }
         if (gem_can_receive(qemu_get_queue(s->nic))) {
-- 
2.7.4


