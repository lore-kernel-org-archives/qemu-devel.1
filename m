Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34C2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879CE20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lSKLuxYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879CE20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbvD-0004Qf-Iu
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrO-00072G-2j; Mon, 04 May 2020 10:14:18 -0400
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com
 ([40.107.223.81]:7004 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrN-0005Zx-4J; Mon, 04 May 2020 10:14:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsimN+X6r4alWi9R+4sdR9IuVBs5hh3LhpIt8JNhlNQ0qd//S/9sbxFRYfWiC5fMwEeNx+dIr+/nREpjjAuDvEgKiByCEKrNFaT24M9VzomSqtpvoXR2Rht0TmSQiaH1ys3KvvVhtmbxcuYSJNMCeCcShrGcmiydRLpRUFOByeXvfU0IQSzu8g3ipGjYR1VDu+ekXU9whZwYOltmlqeWV5Fozc92CyNQSBJn8G4AIRkh4RBawteQB3l/ZZhreybKwMdRtoe2RqKrdEDcanqGq5ZWuTF25wr0hkCO92FtccODljiUf3kim/E5fwjZoASvHeL6MIHRflRVqhG3ozQkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAuDjr+zIBOLa810TTj8jaKa1T8kU+Kf4Se1Tq8SOdU=;
 b=lannz9DcMJ3cvtY3wPAxIV/YwzQQjN8LY9kRB6XHOxcstg7zur2CYr1lpbFu+TKeostqE1Uj3KGpToH6+vCelN9PmGosw2J/ZqNQBErkZCqZtM+cgr+JWi1uiXb56RWplTvhLgG4/pL0zit5lldN2kVw1H0xFWFrob7I8d4mrPkHYoUsU5B2CGBTGgIJRoVna95LJv9J+SNpa2ZJPr5F+hkAFLG/J1KU5bIHhoIn5HoIJDYAOd1v+E/JD0JVE1vr7GfLMUS8TPQKAmPBV1hC7fs44HEPhATlCOiAAl6WmRs+0Gyizj5qPIXsd1z1P/F/sIcKaSI6cx5FcAR8idB1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAuDjr+zIBOLa810TTj8jaKa1T8kU+Kf4Se1Tq8SOdU=;
 b=lSKLuxYVrpr9ROBnQR/HawVILkQtubqBgss6DFjTQPodj+DgVixTcrvP0cvwjxFH99Af6uACQRIanj9Ma27d+mhvHd/hE3NUME1JB2io2TinjGfBuUijq2O65/2xP55zP7WjgIDbk/021d3MKk6+iYnPbmPm5p/uMeFGX5cjNh8=
Received: from SN4PR0801CA0001.namprd08.prod.outlook.com
 (2603:10b6:803:29::11) by SN6PR02MB5039.namprd02.prod.outlook.com
 (2603:10b6:805:70::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 14:14:14 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::37) by SN4PR0801CA0001.outlook.office365.com
 (2603:10b6:803:29::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Mon, 4 May 2020 14:14:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:14
 +0000
Received: from [149.199.38.66] (port=42997 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrE-0000Gf-35; Mon, 04 May 2020 07:14:08 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrJ-0000w5-Nm; Mon, 04 May 2020 07:14:13 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrJ-0000vt-2C; Mon, 04 May 2020 07:14:13 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id C273713C304C; Mon,  4 May 2020 19:36:31 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 04/10] net: cadence_gem: Define access permission for
 interrupt registers
Date: Mon,  4 May 2020 19:36:02 +0530
Message-Id: <1588601168-27576-5-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(46966005)(8676002)(8936002)(6266002)(4326008)(356005)(70206006)(2906002)(81166007)(82310400002)(70586007)(42186006)(110136005)(47076004)(426003)(336012)(498600001)(2616005)(186003)(36756003)(26005)(5660300002)(6666004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9eeb401-34e6-432e-f5ea-08d7f0356c88
X-MS-TrafficTypeDiagnostic: SN6PR02MB5039:
X-Microsoft-Antispam-PRVS: <SN6PR02MB50393E654F020E8B4F94E54DCAA60@SN6PR02MB5039.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXxTRzR+f04jAPG5PZpn/9OWofb/LlGvTIQALURn6aZSLW1ZCovfmuogS6UToObCQutne5B6hAtynTFoYe6k1vZYb8kKlHtbKfepyrs1hCFhi3f+ZQ0/ztAaZnI6dgdN3FWh1XKCcUcOxl5d6IcTuJ/J8PJcr6ZG8DsrwmXwImTlL876wawrmalykBw/rS5ykNs8qtQAjgYbYAZeJcD4jDMprSglM8rAXBkS2azmTCC/PUatEK1qjMotINGBY+V+ZM1RB28P2mLX2sUebWRzMzwc9WplW5U0hnlBAberuXB37Km+tOx6kwmuB4D+p5YqZ2dqJzBw6nyti9J3eTid06lcgPQGKjoxv6RESEFp80DpZfopgH8PELlZ60PCHcGXAyInYaBXVNn+vpcYQEN39w8u3UeQwCIi8DI51AuDCi/pY39q8k9UCTkgs+mopadknsaq1wEMldGmpr4zMqS5PEdzQPfx2RdFFey9wxHGwEElXSucXlCO0udWGpkeCU6v7Lv0Uy7RQIZpjYppZiQapw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:14.0912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9eeb401-34e6-432e-f5ea-08d7f0356c88
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5039
Received-SPF: pass client-ip=40.107.223.81; envelope-from=saipava@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:15
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

Q1 to Q7 ISR's are clear-on-read, IER/IDR registers
are write-only, mask reg are read-only.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index a930bf1..c532a14 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -458,6 +458,7 @@ static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
  */
 static void gem_init_register_masks(CadenceGEMState *s)
 {
+    unsigned int i;
     /* Mask of register bits which are read only */
     memset(&s->regs_ro[0], 0, sizeof(s->regs_ro));
     s->regs_ro[GEM_NWCTRL]   = 0xFFF80000;
@@ -470,10 +471,19 @@ static void gem_init_register_masks(CadenceGEMState *s)
     s->regs_ro[GEM_ISR]      = 0xFFFFFFFF;
     s->regs_ro[GEM_IMR]      = 0xFFFFFFFF;
     s->regs_ro[GEM_MODID]    = 0xFFFFFFFF;
+    for (i = 0; i < s->num_priority_queues; i++) {
+        s->regs_ro[GEM_INT_Q1_STATUS + i] = 0xFFFFFFFF;
+        s->regs_ro[GEM_INT_Q1_ENABLE + i] = 0xFFFFE319;
+        s->regs_ro[GEM_INT_Q1_DISABLE + i] = 0xFFFFE319;
+        s->regs_ro[GEM_INT_Q1_MASK + i] = 0xFFFFFFFF;
+    }
 
     /* Mask of register bits which are clear on read */
     memset(&s->regs_rtc[0], 0, sizeof(s->regs_rtc));
     s->regs_rtc[GEM_ISR]      = 0xFFFFFFFF;
+    for (i = 0; i < s->num_priority_queues; i++) {
+        s->regs_rtc[GEM_INT_Q1_STATUS + i] = 0x00000CE6;
+    }
 
     /* Mask of register bits which are write 1 to clear */
     memset(&s->regs_w1c[0], 0, sizeof(s->regs_w1c));
@@ -485,6 +495,10 @@ static void gem_init_register_masks(CadenceGEMState *s)
     s->regs_wo[GEM_NWCTRL]   = 0x00073E60;
     s->regs_wo[GEM_IER]      = 0x07FFFFFF;
     s->regs_wo[GEM_IDR]      = 0x07FFFFFF;
+    for (i = 0; i < s->num_priority_queues; i++) {
+        s->regs_wo[GEM_INT_Q1_ENABLE + i] = 0x00000CE6;
+        s->regs_wo[GEM_INT_Q1_DISABLE + i] = 0x00000CE6;
+    }
 }
 
 /*
-- 
2.7.4


