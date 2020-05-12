Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD73C54E8E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A042054F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AgxzgGS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A042054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWdi-0002ho-3L
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSa-0001bW-Rn; Tue, 12 May 2020 11:04:44 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com
 ([40.107.223.50]:24321 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSZ-0002jd-Qf; Tue, 12 May 2020 11:04:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWWklXRyKgVqgySraCY6t70adMvTVGRGTacvnjWX2wA0eKJrBPMgDrgQw4CpIHUbzzv4pCUeN+jKWbgRM4dX9qYGsYCXQjmXsZCtzKw7E6+DoUMHFmIpfXGaUwwbKQu9RsV5vCQ1JWt37Zsl/sXoGIMcxJZEwnwoYwPxWCbtOIaCxio5go7ECpUVTkOzP8JyFjthvZUC/tsbhCqnilTGUBdiYPJiyidK8Q0WfkagntQKCKTGgqCtxpaHMA4VCUQT9oZCekCqOjWva5UOxbQN8k6ywjQahU7XJ2ZbI/3d5VhGrNbA/ip8dh/lEhkNp5oUmFnZZpyN0hNN1XihyIrjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFVdyN2RnF2TKeIRiIzAdU14DDjKqB5V1aTWg1nGN6k=;
 b=GzxI3eLQ7n0NSizmiD1Ub1JBjT8KJIOLnRu9Ze/MK20Xn/Vi6BMKdlettfL8XLgjR2LiGl5hdtxrfsRGQq+P1Il7sUWgOsluhKpl7geh7jOeljUodwoB/wgarMIQcu9XemyGdNfp+CRFgzIJQlqF21V80l7BMJaSs+QoBjzdF7zeSAW0GhSGMaqh2HRxMr0DsqTXrAZYBxV2M5zCVfXzn9LmAVBYLHYYaZW+RMo/joP+NGBi0VD4A19CwsCXFQ3FhA4bEgdAfohRij3skztsuBPnfJsCXpdQ7P+IuEBdcN9kOqcNjLMaTyCqzufMMCxAc4fLJkAbRqDewXT2LUwztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFVdyN2RnF2TKeIRiIzAdU14DDjKqB5V1aTWg1nGN6k=;
 b=AgxzgGS/TZ0hvFHiJzqgsfyu29QKBUsxAB+/TpcwW4Tvh8ibu2LrNWOL5LrStlXR+5i0C5kChfubUs8J1vs63oyiqqvpQrnpmK1gkWOzIYGG+8BVcvGhmaLrv716e9DpY/jEH1iSoCsw+tERA/q4/FUkGBHt9uXbaklwiN2cA8w=
Received: from BL0PR01CA0026.prod.exchangelabs.com (2603:10b6:208:71::39) by
 MWHPR0201MB3626.namprd02.prod.outlook.com (2603:10b6:301:77::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 12 May
 2020 15:04:35 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:71:cafe::eb) by BL0PR01CA0026.outlook.office365.com
 (2603:10b6:208:71::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Tue, 12 May 2020 15:04:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:34
 +0000
Received: from [149.199.38.66] (port=48850 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSA-00045i-4S; Tue, 12 May 2020 08:04:18 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSQ-0003oj-Ez; Tue, 12 May 2020 08:04:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSP-0003oH-Qa; Tue, 12 May 2020 08:04:34 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 7046113C019C; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 11/12] net: cadence_gem: TX_LAST bit should be set by guest
Date: Tue, 12 May 2020 20:24:53 +0530
Message-Id: <1589295294-26466-12-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(39860400002)(396003)(136003)(376002)(346002)(46966005)(33430700001)(6266002)(47076004)(8676002)(82740400003)(33440700001)(8936002)(6666004)(5660300002)(26005)(70206006)(4326008)(478600001)(70586007)(186003)(36756003)(426003)(2616005)(82310400002)(316002)(110136005)(81166007)(42186006)(336012)(356005)(2906002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13aa770b-539e-4ef5-7b36-08d7f685c866
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3626:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3626B65D97361A63F7543213CABE0@MWHPR0201MB3626.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:255;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSmEx3pF+vFpox6pJrprlpmxvbVyfsGAKQfSfduUWihudmYtcYy70j3/OB0iew1ijiHw4XJ6MPGjip0MzYfzq8pC8q0KiYjBO5tJCg+tX8P02Jx8SJFWXQCtIOv4iLEwNit8MUeZqgmhpz+y6T6yIwTKWRtI56a08zZEBWEWQyMF6SMlicH7A2ikIHWDCdjKFwyMfI0FxG14FDj0C+i8LpFFlPNfe0nGdkIC343nsK4Ec5mOGjjZm0qqJXa3REsuMOZI6nXLKfQP5L1ffs6KNCVEDlS2EmykgGbQOAxOPAbQZuPc7/ZZ6wSyucLv/FZFztfiZxJAH6D4o1EOm8MdbVVaXermfuRb63wMvrc0rNkRsf13/BJCJI/rGNVFTmmMsZ+qTeAvuAyhqdyI1Pru79nKWPv7nJlMcY3invTJcrJHV+r8/9Cxo0udUvLBZ35wsg9NPcWen5vqF7pck02/H8u/44VdQFqWT/uYCZvEu8T6u/8fhSZGpL08ugYUHdzr1AUOgI5mXY8FI+flk3BdGk8bQt43Cp+CLBBIM+dKr/OrblI/d3HLYv56judaXDm8C2V9Uan8m4E3w9AHjQ5+Yw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:34.9307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13aa770b-539e-4ef5-7b36-08d7f685c866
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3626
Received-SPF: pass client-ip=40.107.223.50; envelope-from=saipava@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:42
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

TX_LAST bit should not be set by hardware, its set by guest to inform
the last bd of the frame.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index ddb8938..57d94a5 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -350,11 +350,6 @@ static inline unsigned tx_desc_get_last(uint32_t *desc)
     return (desc[1] & DESC_1_TX_LAST) ? 1 : 0;
 }
 
-static inline void tx_desc_set_last(uint32_t *desc)
-{
-    desc[1] |= DESC_1_TX_LAST;
-}
-
 static inline unsigned tx_desc_get_length(uint32_t *desc)
 {
     return desc[1] & DESC_1_LENGTH;
@@ -1298,7 +1293,6 @@ static void gem_transmit(CadenceGEMState *s)
 
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
-                tx_desc_set_last(desc);
 
                 if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
                     packet_desc_addr = s->regs[GEM_TBQPH];
-- 
2.7.4


