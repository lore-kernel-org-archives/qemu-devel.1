Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F3C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78655207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="I4bPaM18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78655207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCiFA-00047Z-Ki
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kCiEb-0003b2-LZ; Mon, 31 Aug 2020 07:44:25 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com
 ([40.107.236.61]:32654 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kCiEZ-0005Ir-Ge; Mon, 31 Aug 2020 07:44:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5XVx+54IcDgO1i4LvZt2AS+8NlTUW50bGz3YdmSv7L3se3dc8Mu5pFI9WuHYIfDDF8Vtf5P4qOLiy3PfW4paWm3OGFZCpzl0bGq5Ux5qhliaObe47v8QmfZxwC9miTKISWjtZZuCI1JHtkl1LoXzk8Cjp+RsDhP1RZWIXqYkpkvZ2q72GyYbnmdgTlngAjtKqhUk6kcwT3N0rqyEOAtLz10DtvQNKa6lbD7iJz5EZvgjZTrVXESEGpqeabK3ClJaJjW0eUuafcvPU7GC5mi6PvvJv3yXKEc7pYmWpxPzIsdgJhu4imqEdLeFb+9GnPeJzIypTa56yp0DKJdE/Jpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L4fSaWp/YTjTjtlz7chvvBXzPfp/Kpr1Nr+1CyUOzc=;
 b=hEuTfwS823ND6vUngWnPJUpGugnHE6/ue9+g+zi7tlEit7wHsL38L5dEs7euJ6suhhYX8PdllRwV1lC5Gbi8ikP3hAqtexsnZxzEv2mU1kDajRzaKaE+E019+urOC8Z+ISYWvxGlV/3p6TJCuqaJtptsWqLwS8ZBLw2+2l6QJ477/OxK2SUExjMY0NDa/HHauJ4USeu4FA3kjgPN2V/CQojfSRmazITYOsC01uPqIWVFwjzUnwzNx5QTtIVAQb3fbJDvZdu6HuD6j1J562OwQoESBiqp3M9VFmhcLPMHKMqDVjZN+dwB28joA2b1DvG7pntcJnRkTkM1edsMUrwkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L4fSaWp/YTjTjtlz7chvvBXzPfp/Kpr1Nr+1CyUOzc=;
 b=I4bPaM18yjf53+sBut9bNcVWwfyUjsuIXcOMk+thvOsMKelONfxzIp/HK2D227XMyGcZVWFnFbEIJM75hemfpAZoOn7iI0f7mlTK66WgtFhPM6WPJEDzmp1fwQYyii9Q9LxGQPV2m0uM52BqXDUg1kBMV7+QbpS0U67QRw/ZmxY=
Received: from MN2PR05CA0036.namprd05.prod.outlook.com (2603:10b6:208:c0::49)
 by BYAPR02MB4933.namprd02.prod.outlook.com (2603:10b6:a03:44::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 11:44:19 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:c0:cafe::c3) by MN2PR05CA0036.outlook.office365.com
 (2603:10b6:208:c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Mon, 31 Aug 2020 11:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 11:44:18
 +0000
Received: from [149.199.38.66] (port=60942 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kCiES-00031a-Rr; Mon, 31 Aug 2020 04:44:16 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kCiEU-0004Ms-I5; Mon, 31 Aug 2020 04:44:18 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07VBiHFK001892; 
 Mon, 31 Aug 2020 04:44:17 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kCiET-0004MM-8t; Mon, 31 Aug 2020 04:44:17 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 5D89D13C051A; Mon, 31 Aug 2020 17:18:44 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>,
 Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Alex=20Benn=C3=A9e=27?= <alex.bennee@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 "'Edgar E . Iglesias'" <edgar.iglesias@xilinx.com>
Subject: [PATCH] target/arm: Configure number of pmu counters
Date: Mon, 31 Aug 2020 17:18:42 +0530
Message-Id: <1598874522-5186-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d18d1460-2b75-4686-5ce6-08d84da33225
X-MS-TrafficTypeDiagnostic: BYAPR02MB4933:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4933B6E82C8B4197BE179CD6CA510@BYAPR02MB4933.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cA/wWCmE5Y1TE71E5fD2IFtXXLzxLDwLc4sMkDu+hTJFHQdSxYQ2OM8oePQedfQb62xLR6gcruMWoGLQR9Py1dvMO0koVywcOuDjiyVOktRD+EMHJW0i8EigP4KA7Jx7riuCdtKqZ8dj/gSNMGhD+oJLoZeACHWJzkpv/Ijj82bwTWdK0hpBvEfCZwKEBzMz5ATjD64ILCheilQ1Rjh/AB5eahsYjBBXbOC5pc99lq5QUIk9IhrHn/3LuTHjswAu9RJx+5wAiLoVMUgxv0MclBcHlhmYg1IkwdQ9qyRoADN7M8cIao3aS+WoBz3fg4Xd0kJQO29ji+UtsilFBYD7BGkDS2EOUBEznFjEB9ky5JQXjtGUZvYP7aIIpQX9yFKx4Ldx0kJU4833RCrmroGesY+PkwDYZkKQTJnEMDYS+Os=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(136003)(376002)(346002)(39860400002)(46966005)(5660300002)(26005)(186003)(70586007)(70206006)(336012)(36756003)(426003)(2616005)(82310400002)(42186006)(8676002)(83380400001)(107886003)(6266002)(478600001)(356005)(2906002)(47076004)(6636002)(81166007)(110136005)(8936002)(82740400003)(316002)(4326008)(42866002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 11:44:18.9132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18d1460-2b75-4686-5ce6-08d84da33225
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4933
Received-SPF: pass client-ip=40.107.236.61; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 07:44:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) AC_FROM_MANY_DOTS=2.999, BAYES_00=-1.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: sai.pavan.boddu@xilinx.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Default the pmu counters to 4 and configure it a 6 for a53 cores.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 target/arm/cpu.c    | 3 +++
 target/arm/cpu.h    | 3 +++
 target/arm/cpu64.c  | 1 +
 target/arm/helper.c | 2 +-
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6b382fc..805a692 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1051,6 +1051,9 @@ static void arm_cpu_initfn(Object *obj)
     cpu->psci_version = 1; /* By default assume PSCI v0.1 */
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
 
+    /* set number of pmu counters to 4 */
+    cpu->pmcrn = 4;
+
     if (tcg_enabled()) {
         cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
     }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ac857bd..3b47ba8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -879,6 +879,9 @@ struct ARMCPU {
      */
     int32_t core_count;
 
+    /* Number of pmu counters */
+    uint8_t pmcrn;
+
     /* The instance init functions for implementation-specific subclasses
      * set these fields to specify the implementation-dependent values of
      * various constant registers and reset values of non-constant
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dd69618..76c879a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -190,6 +190,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
     define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
+    cpu->pmcrn = 6;
 }
 
 static void aarch64_a72_initfn(Object *obj)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 44d6666..4afbefb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6534,7 +6534,7 @@ static void define_pmu_regs(ARMCPU *cpu)
      * field as main ID register, and we implement four counters in
      * addition to the cycle count register.
      */
-    unsigned int i, pmcrn = 4;
+    unsigned int i, pmcrn = cpu->pmcrn;
     ARMCPRegInfo pmcr = {
         .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
         .access = PL0_RW,
-- 
2.7.4


