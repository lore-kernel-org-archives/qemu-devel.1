Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 05:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9470A21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 05:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lB7t6701"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9470A21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNsDa-0003sb-OM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 01:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1iNsCQ-0002yJ-R4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 01:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1iNsCP-0005Jf-KM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 01:31:46 -0400
Received: from mail-eopbgr750078.outbound.protection.outlook.com
 ([40.107.75.78]:31153 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1iNsCP-0005Gi-8r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 01:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qetf7RB2nia3FkMcHh7auCnCdgjGdIpRG1qX+n8v6es+lUB2bCyNfYBuQ9DdZjfmzBMJ6tEEg5MAEMYrVXE9yj62W/K8ET59FzdtcAUVrMKlaa2NuHBfjuTzedcq8JpQP1AW9XktBhqPGpVBeTmGRJ6QzmZrxfdcZQCCl77aP8uHPEkbuvdeSrh/9HZG/iKyYtwC67a9PYS14VwDibnUdZIaPtBXq8a81SK9BuFyQurXrmk8cYzPIfRu6QOfPXcdFutIpfkcQrTSvzuNAFzsfpttb7BtuPxdxO7PRZq4dEn4eqag1xJx7FFKDL6b9o4dB5NJWSGD6wGjxkVQkZ2pvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+ug6MKPikNK7zIEaGYQeqIvhdgix1fZzn8QY3uuZZo=;
 b=UEqoVvdcvE7xaycH0sCOjoc6eP0cDMqhqlvsfjAvFC7J8/pVoaQyKydBn1jC10NJiJ3mGFKvV78e/125r4IvQmmfrezmID6D0+RrhwVAIRjdVHn0ORKpQsjBOuq1vxK/mKLlIlXyGpeVrSaKmBGjsrWnnR6QHDNPDpXGMGqGZlN7FbbJXtzjpVkMMUnS11T2EkhXpcp0XmCS1dizki9tDEvW4R92EBulcXIuMVvSbUcnFeECrGMRXKIs7jUBhlQkhT7B8Vjww/aVJQKvbWlAdxUZyBtaHfCjlPZ0q7eGcRzD7rB+xA6jb7wlkNsnh6o2nAMhCiScwBkfv8FVz2zAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=alistair23.me smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+ug6MKPikNK7zIEaGYQeqIvhdgix1fZzn8QY3uuZZo=;
 b=lB7t6701eoib3R5CmCMxwvfhVxpz4SfrxGRnouqenDV8j7lj8fHXRO0wAE0nQi1GDoIrTlKoZyveST9HoYCVnV2vY8pYwUxTYxnkrCCpjtdXpE+YNDzG4Ndp0Gox/x+TjzbTcTZA6G2u6CsctS3IzgxnQSXjuu0SP5u5U4ZoA5M=
Received: from CH2PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:4e::12)
 by MN2PR02MB6464.namprd02.prod.outlook.com (2603:10b6:208:184::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 25 Oct
 2019 05:31:41 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by CH2PR02CA0002.outlook.office365.com
 (2603:10b6:610:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20 via Frontend
 Transport; Fri, 25 Oct 2019 05:31:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; alistair23.me; dkim=none (message not signed)
 header.d=none;alistair23.me; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Fri, 25 Oct 2019 05:31:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iNsCK-00076L-F8; Thu, 24 Oct 2019 22:31:40 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iNsCF-0003PL-AU; Thu, 24 Oct 2019 22:31:35 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1iNsCE-0003P6-JR; Thu, 24 Oct 2019 22:31:34 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 3573913C02EF; Fri, 25 Oct 2019 11:02:15 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Alistair Francis <alistair@alistair23.me>,
 Francisco Iglesias <frasse.iglesias@gmail.com>
Subject: [PATCH v5] ssi: xilinx_spips: Skip spi bus update for a few register
 writes
Date: Fri, 25 Oct 2019 11:02:11 +0530
Message-Id: <1571981531-27498-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(47776003)(50466002)(8676002)(316002)(70206006)(103686004)(478600001)(70586007)(81156014)(305945005)(126002)(356004)(50226002)(81166006)(8936002)(6666004)(48376002)(15650500001)(2906002)(6266002)(26005)(14444005)(36756003)(16586007)(2616005)(110136005)(476003)(5660300002)(54906003)(42186006)(106002)(336012)(186003)(426003)(486006)(4326008)(51416003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6464; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7822e47-8728-4657-fc95-08d7590c9d48
X-MS-TrafficTypeDiagnostic: MN2PR02MB6464:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6464DE69A145518B649344EDCA650@MN2PR02MB6464.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:104;
X-Forefront-PRVS: 02015246A9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRAr2XJZFmuDKXwBB/togQ45t8YLsRr93rn0IjXCgLSCLrcrd++VTNHCswvJpMkWIxLfsjIcbZ660Onk3f1q++6HfafGjOerWdDWfHClqXYsNRLfcEbnhu1z0pmwIDfavIPYNRU0W5kKO7D/CbrtSbWpsNr0smhTtYa/Q+DQVr0Nk+zBq4uUZtLqhqtezYBdcNXk0jc6kJh+KEfAQ3hLVQExkt6OKT+iNHsgAvt50+Mh95AGa2hmHpt4catQNebCnJbWnRMO/gCGBl7vWM6r8wspuaOXyCOk+A2LI0nSigdIJVSUl5ChUklWDZMsGShOG/JNc3koPaTOepZiN4374wiJVV65XsHWVGAkxmgXASbbr+6pp+gToLtAZPCxOWjBcyOLN7UuzFH1i60uEYsv+190O/DI1DBkyPpYN2zX1HWzEfzBCY7eITeLzpjaAJoa
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2019 05:31:40.8359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7822e47-8728-4657-fc95-08d7590c9d48
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6464
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.78
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgari@xilinx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A few configuration register writes need not update the spi bus state, so just
return after register write.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---

Changes for V2:
	Just skip update of spips cs and fifos
	Update commit message accordingly
Changes for V4:
	Avoid checking for zynqmp qspi
	Skip spi bus update for few of the registers Changes for V4:
	Move the register list to existing switch case above.
Change for V5:
	Fixed Commit message.

 hw/ssi/xilinx_spips.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a309c71..0d6c2e1 100644
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
@@ -970,6 +973,7 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
 {
     int mask = ~0;
     XilinxSPIPS *s = opaque;
+    bool try_flush = true;
 
     DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr, (unsigned)value);
     addr >>= 2;
@@ -1019,13 +1023,23 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
         tx_data_bytes(&s->tx_fifo, (uint32_t)value, 3,
                       s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
         goto no_reg_update;
+    /* Skip SPI bus update for below registers writes */
+    case R_GPIO:
+    case R_LPBK_DLY_ADJ:
+    case R_IOU_TAPDLY_BYPASS:
+    case R_DUMMY_CYCLE_EN:
+    case R_ECO:
+        try_flush = false;
+        break;
     }
     s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
 no_reg_update:
-    xilinx_spips_update_cs_lines(s);
-    xilinx_spips_check_flush(s);
-    xilinx_spips_update_cs_lines(s);
-    xilinx_spips_update_ixr(s);
+    if (try_flush) {
+        xilinx_spips_update_cs_lines(s);
+        xilinx_spips_check_flush(s);
+        xilinx_spips_update_cs_lines(s);
+        xilinx_spips_update_ixr(s);
+    }
 }
 
 static const MemoryRegionOps spips_ops = {
-- 
2.7.4


