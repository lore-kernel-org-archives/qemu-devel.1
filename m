Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE21FC47257
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF96208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="s8A/xgck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF96208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0tl-0001X1-Ov
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sA-0007bW-UK; Fri, 08 May 2020 07:08:54 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com
 ([40.107.92.64]:2817 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0s7-00022K-Tn; Fri, 08 May 2020 07:08:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaVccf1XOyD4QheWf3MLQGEMh2k/ECYJ2dADSDluf4Fv5AoT1wJTQMjbhj0ZALH3DVXI/rRhtzJ2KbDvuL5faOLjIY1iEWRzfAu5BCw9tslqCxnEsm+kJZ/29Bk2iddUMc+Ip0E2cN03XuUk+5TkKNgjkPzOp14eJCliKJYQIvPig5fCtfVO4pWWI9RImfw8b11EpmQg0Ss6C84tA9Rbz1fbszSIHCSVtdSWAww8XgAFLWGM2l+BRHiZ+B4qw+8mhSzFQzBSow8HWUu4u//R0B3oiNoVHx/Ez6mOZw7+CMA7VZFC4VOWN+7/dIvVUneIIWUfvKYh+I+wc0H3vrKRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3N4pb3Zixs8h51FbLra/Io+8LMa7VjtUAWHTX3dgLc=;
 b=bKwr+I/7dtP39kvDnpp7+FghfJh6t7pclwlIWpa0O+y/oD7ZwQCJ8BT4uvgqkbpp7JRyTWHnZriQbtzIqPqOFiztsJQBSGYywcuH3c6L01SGnWcwlJR4YVtgxD1uspZ4qGrLCUz4F3IKuX7QSqMC6aDnM8kmU4BU/InyjoZqvjQZNMbEA+DwJVu0d7p4Gj2+ktP7Jubk3DBa5lvgIUpMPQIz8M8DK6uhzJhUpQwsOSJuFSAeWydgAzV+CYeTHuAq/fY25yrQqXDvRoxf4Ycb4EwVc3n3iVKuFZa97Y+48cyKv/v8EpmgMuJp3nefrCTa3mcd0fTUl30Ycc6HbBIAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3N4pb3Zixs8h51FbLra/Io+8LMa7VjtUAWHTX3dgLc=;
 b=s8A/xgckgyDdzVMl9CNNcelztXWgUjGvzY/6tWz+wgQBVJqR3dzV0RKr75eNKZDEcikvzeDFY5gNgOi533SWOrGGTRZx2gGq2IXr5gbKoxjaQX6kSq0vEG9VLG8s4OSlOJxz3U35L/9QOCU7/+syjticS+qtm/7id6RWhsAFty8=
Received: from SN4PR0601CA0012.namprd06.prod.outlook.com
 (2603:10b6:803:2f::22) by DM6PR02MB6778.namprd02.prod.outlook.com
 (2603:10b6:5:212::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Fri, 8 May
 2020 11:08:49 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::7b) by SN4PR0601CA0012.outlook.office365.com
 (2603:10b6:803:2f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Fri, 8 May 2020 11:08:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Fri, 8 May 2020 11:08:49
 +0000
Received: from [149.199.38.66] (port=35846 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0ru-0002Tq-Bc; Fri, 08 May 2020 04:08:38 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0s5-0005bY-4l; Fri, 08 May 2020 04:08:49 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 048B8mQx017554; 
 Fri, 8 May 2020 04:08:48 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jX0s3-0005ak-TS; Fri, 08 May 2020 04:08:48 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id D248913C042F; Fri,  8 May 2020 16:30:55 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 04/11] net: cadence_gem: Define access permission for
 interrupt registers
Date: Fri,  8 May 2020 16:30:38 +0530
Message-Id: <1588935645-20351-5-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(396003)(136003)(376002)(39860400002)(346002)(46966005)(33430700001)(478600001)(70586007)(2906002)(8936002)(4326008)(36756003)(8676002)(336012)(186003)(6266002)(42186006)(47076004)(316002)(33440700001)(5660300002)(81166007)(26005)(82740400003)(356005)(82310400002)(2616005)(6666004)(70206006)(426003)(110136005)(42866002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3637c44-ba4e-4975-8bd7-08d7f3402f67
X-MS-TrafficTypeDiagnostic: DM6PR02MB6778:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6778F87E412D27EF348426A7CAA20@DM6PR02MB6778.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXZotwccfWeazW2VOKwqqcBYL4JUUR0fvuK1q7FB7dsQDLhIygNWiCNCDw+AteAXdV4FCOZb/y0Ubk6kY7KvqL1PPeQcjr0pDsquF4v+qv22ViUiqDJ9pzSJ8i8YMP/yiOKX16nyl6zZeRDFGYr/0Qt6z6xfggbGrBVVPKJ9CWwBX2Qr0qZfG9kx7yX3kpGYHU9bjfN6v0BTaX3HpivK8P89STAHUDkSFqwVg0h70+LMVqbhZsL0VUQLv17EMf+xZ1cjtvYxyrsYrzmDI7M47D7sdJ+9ZfT9tpGHiprOx/bcCAVI5MllcTuWx6hViXwx+6TbplgbIBzE8Q2faMU2BNS4tH+rzyKhFFEKczUlajO74uI+4KKrS4E8qLqWJD9wzvFyUdAFGAdcc2HIWJJo8EIl9ojxND0ZfttCmpZEyDneTmUIlt6yz6DM92jFfEsBfVPk+QO+Gcg2YgRsysE7oiOt/+GAdWSqQoNu8cPE7DjqigHOwM6upEXb3UWHV8ccv8aRbe+KVSzLV7dwehXduvPy58E74hapZ9rtuv4Hlp2HyT8VyfX6/4Ye3DeWDTRvs928QaFNa8IBpfCg9wSxzp+LKS/rlm1dF3cs4G9J6R4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 11:08:49.4846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3637c44-ba4e-4975-8bd7-08d7f3402f67
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6778
Received-SPF: pass client-ip=40.107.92.64; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:08:50
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index fefb360..74ef447 100644
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


