Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC585C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 06:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E7B20673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 06:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LPvgbCyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E7B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJuCp-0008KY-Ku
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 02:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1iJuC0-0007sn-TT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 02:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1iJuBz-00024Q-MD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 02:50:56 -0400
Received: from mail-eopbgr760040.outbound.protection.outlook.com
 ([40.107.76.40]:56116 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1iJuBy-0001zL-RS
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 02:50:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQQOi4UzfuKvzJQ8lei+8LPNsLlvFC3fcqfqIk5swdzmmFJAMxmPLAYJ+75htF9DxsQAlQm2NcwQMmDQhTEy5DNmwfcD/Kq/LxsBpn8htIUCCi3X2LiTRJoeWwc69OwGPnVuurMzTFOBpmXwNSRVjam9jcQxrC55nLoBA+JEtCG2HFRlKy24KAwi/c0RrlF3FSq7NPYMR/LgjEeKblIYCh/frq/Ysc6565NGHDxArHnxMkH+CdIyyBeyaiXiSoOhMYMaXp+b+Hl0H3AFSJ5+vBMIcvhU1MQYE2kUipdOwhw1Vh/uSrslSQJX+GS22ohR0cd1F+NTQ3ipfZFzqAPu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJM24XW3/z8694uRR/KBWJy+oL/9o/v5uPNWOlVK76M=;
 b=RpuHsHNX/Rji8Sp2jObPLD+hx8MwfVePV3cUlqY2PZJrxZvrQLGvgpLrbgjzCxM8iofVis9cEY18nR7zzC8dzGcWobInhvfZfPKDpZlCDZSu/cYGAF6j85BJU8mv3KAKIx+STgx+Y/GjMBItoWRWaAB2Vpb9lRAgWnQkPMvY1xyHGQ3+FCjHbl9RKV2WIcBI5iQXm/xY0RoTfIdhiBX7lmkpNS+rw8sE6xpbFc+skOYC5WM6FUY2f6CZeeAzKTO2mae6AUVVy5WtyXzZ0hcHGRBT5Q8hjtk5da/oj8DdYWBqLVvlbpe3QIIU4/uuHAEBBrlV0xI3UcweSRS/8pq05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJM24XW3/z8694uRR/KBWJy+oL/9o/v5uPNWOlVK76M=;
 b=LPvgbCyu6X1Ye5PSM0g5H422IKJb7r4yb4m9lkCFgSgbokqLczVFSzJI8WLYM7oEZKW3sQOeiaeV+kT0miuGVDAm6L4B4H6oDnebEHzgCCYs+DsKb9WXqydKGP5kRkX53yUOLr4kxXeyf0F4ZMhha6AE2d/zjwPonlqFg0VLB1Q=
Received: from MWHPR0201CA0101.namprd02.prod.outlook.com
 (2603:10b6:301:75::42) by DM5PR0201MB3462.namprd02.prod.outlook.com
 (2603:10b6:4:76::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Mon, 14 Oct
 2019 06:50:51 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by MWHPR0201CA0101.outlook.office365.com
 (2603:10b6:301:75::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Mon, 14 Oct 2019 06:50:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Mon, 14 Oct 2019 06:50:50 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iJuBt-0000zI-Td; Sun, 13 Oct 2019 23:50:49 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iJuBo-0002wz-L0; Sun, 13 Oct 2019 23:50:44 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9E6oi5X002221; 
 Sun, 13 Oct 2019 23:50:44 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1iJuBn-0002wN-Kc; Sun, 13 Oct 2019 23:50:43 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 7491413C2031; Mon, 14 Oct 2019 12:21:53 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] ssi: xilinx_spips: Filter the non spi registers transactions
Date: Mon, 14 Oct 2019 12:21:39 +0530
Message-Id: <1571035899-9692-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(6266002)(126002)(186003)(2616005)(476003)(336012)(103686004)(426003)(316002)(16586007)(42186006)(478600001)(106002)(305945005)(486006)(50466002)(8936002)(356004)(2906002)(70586007)(50226002)(6916009)(70206006)(6666004)(36756003)(48376002)(8676002)(5660300002)(81156014)(81166006)(47776003)(51416003)(4326008)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR0201MB3462; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a6316b-7bd7-472b-59de-08d75072d9a2
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3462:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3462E16AA76B9FD906C20B2ECA900@DM5PR0201MB3462.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-Forefront-PRVS: 01901B3451
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yt043/BjT88NbHyzd9nF+bD71sgfkk0TIKV26BU6qiYPRrKEJKYwLtXDGXBnXNh7zKayxrELKkM+eelV64y2fDN2Y6G30iZHbRmMPpXo9k0vPDH3qdHuNwGuU6PX/xTYt3+yUD5dIaocdloQp0ZX74AII9h7L0RyAYAqfH8AJdDdUlNuPLMjVtWcxxivCcYpneUmsnm1L2f8S3p7M4vJOjpbPbBUeLH2WZhDO74X/e/5tBTsqGcqYVlhwgXUbPgn+/ED0bSni9NeTaAE2BysQEHtSdm4fwYM1s8AjoJcC60Fbb11S7fbDpiMod+MdiYEctE7UYlhr0IESyGe1OCJSVNkynkLITFIOkTsrVz7rTlE5YBDXdza2900QYCiAJlujvwMc2R/ka+zRkfy9ammCTy1gGYgR19XZUYV61mNGcc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2019 06:50:50.2883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a6316b-7bd7-472b-59de-08d75072d9a2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3462
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.76.40
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ZynqMP/Versal specific qspi registers should be handled inside
zynqmp_qspi_read/write calls. When few of these transactions are handled by
spi hooks we see state change in spi bus unexpectedly.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/ssi/xilinx_spips.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a309c71..4f9f8e0 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -109,6 +109,7 @@
 #define R_GPIO              (0x30 / 4)
 #define R_LPBK_DLY_ADJ      (0x38 / 4)
 #define R_LPBK_DLY_ADJ_RESET (0x33)
+#define R_IOU_TAPDLY_BYPASS (0x3C / 4)
 #define R_TXD1              (0x80 / 4)
 #define R_TXD2              (0x84 / 4)
 #define R_TXD3              (0x88 / 4)
@@ -139,6 +140,8 @@
 #define R_LQSPI_STS         (0xA4 / 4)
 #define LQSPI_STS_WR_RECVD      (1 << 1)
 
+#define R_DUMMY_CYCLE_EN    (0xC8 / 4)
+#define R_ECO               (0xF8 / 4)
 #define R_MOD_ID            (0xFC / 4)
 
 #define R_GQSPI_SELECT          (0x144 / 4)
@@ -938,7 +941,16 @@ static uint64_t xlnx_zynqmp_qspips_read(void *opaque,
     int shortfall;
 
     if (reg <= R_MOD_ID) {
-        return xilinx_spips_read(opaque, addr, size);
+        switch (addr) {
+        case R_GPIO:
+        case R_LPBK_DLY_ADJ:
+        case R_IOU_TAPDLY_BYPASS:
+        case R_DUMMY_CYCLE_EN:
+        case R_ECO:
+            return s->regs[addr / 4];
+        default:
+            return xilinx_spips_read(opaque, addr, size);
+        }
     } else {
         switch (reg) {
         case R_GQSPI_RXD:
@@ -1063,7 +1075,17 @@ static void xlnx_zynqmp_qspips_write(void *opaque, hwaddr addr,
     uint32_t reg = addr / 4;
 
     if (reg <= R_MOD_ID) {
-        xilinx_qspips_write(opaque, addr, value, size);
+        switch (reg) {
+        case R_GPIO:
+        case R_LPBK_DLY_ADJ:
+        case R_IOU_TAPDLY_BYPASS:
+        case R_DUMMY_CYCLE_EN:
+        case R_ECO:
+            s->regs[addr] = value;
+            break;
+        default:
+            xilinx_qspips_write(opaque, addr, value, size);
+        }
     } else {
         switch (reg) {
         case R_GQSPI_CNFG:
-- 
2.7.4


