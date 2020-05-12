Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1220DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8B5206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rdZzjEvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8B5206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUsC-0004rr-UC
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUns-0007TF-Bb; Tue, 12 May 2020 09:18:36 -0400
Received: from mail-eopbgr770050.outbound.protection.outlook.com
 ([40.107.77.50]:7574 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnq-0001zL-5o; Tue, 12 May 2020 09:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGrrTxr8bPEUTTJemwonCSbowKLmk6KhIRpsMfW6Y3vf3XG+r4Pq68dAmOT2Ngp/pQv/FvASdF0EMUBwgNfQEcgLj1r1r/IU1MUE43tyZ5OALPv3YfxJsNT9L/HMELAKoSIq2vBUewxoIhW1UjruiZYksl9qWnpttscw2ULb2T3rKD98E3qbrgb5/50ugL9QKp0YuKSkBSKmYUMAhUC65QVyH49o/nSOBzBuhkYyzeqmCAavI+jMAA3DNAVUxTRkr+uGXGKGZ3YB4dJP0OOwXOGZt9uER9Ufh/CEv6Y3nMHOMtdX86f1riaqKC7m4hx7m6HPk9KPAXafCrOckVg9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU0O8Ak969WK02hryUKYGxuUpZqp0gUowhHwVt4h8w0=;
 b=A+OSr9++zIxLpY4LZ3FGcXIDKRdLGM3lOh25yrRz5nKVQ5h5CH9yh3avRXS8Z2HlVjSppMbLUjJ32Vq4MX02q/5fyIivonfLprskmJ6gVHLRvEVJ75J29Fz76fKXzwfoumy5iOyeHtlrJUjoUsdO3zgS/BSBgVM4favGGJ+7kI1PuJHsKmQivo4ZwhwCfWxudMz/NnNLNf8AxZy0MvQBpd5Bul36dYaRZMnex9KfjCMYFYFKe3jXAlfg9pC0+QCON4ZNUTZG/1WMp5o71hXJodz9TfivxCzCbz2hYEgXvoYLy5dJbHOniwsbikbpxy2g4C4Bv4BisUDKJxPti5zBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU0O8Ak969WK02hryUKYGxuUpZqp0gUowhHwVt4h8w0=;
 b=rdZzjEvsucoS0gR7JGWNr0kSUNXk7XAm/6FhogkzBrf5M5zjeFXwvHl8UHYiW7d60d0XuY3p2RlISv4jP+JzHDOPYlFIDAknoRFO85sC99atw9rPrUr2adItHkK4qsHAK/RmoEwmcafFJqcAzhUJikn/hP8qcwqI+m4BZKqR4Pk=
Received: from SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) by DM6PR02MB5132.namprd02.prod.outlook.com
 (2603:10b6:5:51::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 13:18:31 +0000
Received: from SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106::4) by SN6PR2101CA0027.outlook.office365.com
 (2603:10b6:805:106::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.2 via Frontend
 Transport; Tue, 12 May 2020 13:18:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT043.mail.protection.outlook.com (10.152.72.184) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:30
 +0000
Received: from [149.199.38.66] (port=47647 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnW-0002QQ-AA; Tue, 12 May 2020 06:18:14 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnm-0005Z1-Hu; Tue, 12 May 2020 06:18:30 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDITY0016840; 
 Tue, 12 May 2020 06:18:29 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnl-0005Yb-D2; Tue, 12 May 2020 06:18:29 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 6FB7F13C0168; Tue, 12 May 2020 18:40:26 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 04/12] net: cadence_gem: Define access permission for
 interrupt registers
Date: Tue, 12 May 2020 18:39:59 +0530
Message-Id: <1589289007-23629-5-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(39860400002)(136003)(396003)(376002)(346002)(46966005)(33430700001)(33440700001)(110136005)(42186006)(6666004)(8676002)(2616005)(186003)(26005)(426003)(5660300002)(4326008)(6266002)(8936002)(70206006)(70586007)(478600001)(82310400002)(336012)(36756003)(2906002)(47076004)(356005)(82740400003)(316002)(81166007);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac85cb10-2a88-45ec-21a2-08d7f676f71f
X-MS-TrafficTypeDiagnostic: DM6PR02MB5132:
X-Microsoft-Antispam-PRVS: <DM6PR02MB513254314F5C56EC57C7AD8ACABE0@DM6PR02MB5132.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtMNGDqgobJBQWfELgfUGG0nQuVfDrTj2KYXIde8xeANIOylUophK5FoYWCyh1aIZ0RDGx6zP96K3+Vy6D5EXVK4FGNTZrRWs7VcNKTgZ4UcHwanqPN9uOaPfHlaU9aXj/Q/r+exWJoUG9dSgvy0/M8ekAM8NDg39DJxT/WORBiUhDwpWKoV4EPi0ZiWgz/9nY75Kce1BBCM0z3qMkbJnvEbzC4jvR93uDSE5Fn/FR0Cx35dLBr+NtUa27graSherR7MsFzdO2+sA6wdCKxW1flrHeMspqOFOejV78fx1TSEQ3sFBx3dQBgP943tMjHkgirLWFVNW5VPwjBRxx6N0UbF2IHPMSfbMkhshy4np/OB77PuV0cPFVj3kHW/MXWKqpcgBamz+y1NBLQmU7Cgp4qNySBAMvZ1VCcpdKLnJfQrnuyz+GS+l1aVzH6w9LF94yg/rVdkjD+4hQio9EeuMPS4/xOpho/PGK+v/G85htdgb6EaFlIgMVXh+GakIRqSMnw6JiVzuDl7D41h+2V5AsF793Wi91LFAcPmGE0wB6qdeCyNTLVWTbvYIBrw7oE6S0dVQfIvlXLbLRHWImL3sw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:30.8660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac85cb10-2a88-45ec-21a2-08d7f676f71f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5132
Received-SPF: pass client-ip=40.107.77.50; envelope-from=saipava@xilinx.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:32
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

Q1 to Q7 ISR's are clear-on-read, IER/IDR registers
are write-only, mask reg are read-only.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 76c11a1..40bfa5b 100644
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
+        s->regs_ro[GEM_INT_Q1_ENABLE + i] = 0xFFFFF319;
+        s->regs_ro[GEM_INT_Q1_DISABLE + i] = 0xFFFFF319;
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


