Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA1FC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAFC206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PTAuN9bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAFC206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCZD-0003il-1V
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYCYL-0002WW-1a
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:49:21 -0400
Received: from mail-eopbgr760070.outbound.protection.outlook.com
 ([40.107.76.70]:12246 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYCYI-0006dc-L0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:49:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF2G1zTNQQUXqSI83MBaIzFdqDbbfT9IStIYyh0yGyL1wceJm05Twr5jbaOuFg7/zZKFTYDQybn7PL9j8EnMmpUz61w8ZofMhiACE4SApuvThVGpj6apKDy7NiJThwctxAwYqsXrxDw54yi61fqC0h1FWvYqqTRgbhbcK6hNieoX/7aAKuZ6YdoAAEuQja+ahJ9YqRNotiwLekq45krnDw06y5ty98PieTMcIdPShOnzPa7fiVm1i4zDRAfiipUYYS3sFObezg2zGaCHs8flKdDC6PwEKuxDlszP4q0AResPr5/HCzjB8l/J9TMZ9d9TdjA1bjHR2ESCpsNXRlU/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEJ07MZZ65NStudZoNoVgRDN2CWun3It+fcOOpRZ+Dc=;
 b=TR528hnXhzQILX4q/hTsSY9fommXD+Zizf+Ktpnjs07hz9CPQ30XQZZuuxM1NMVltGPtyPzHkWVW19L0vov4APd6e07bi7uQiRyeX1C13oe8XWLIC7TGHCjqGeUISh782qxhZwWgpX01ONWHgtxcIbZ+VXZKXqj2x1JxgdwVxz8O4ysrfKFpiF5f2OZlYEH0Wx64G8eeieI1ZerT28lPq8U/4/kDTIl5NNQs3Blv0M8gh7d7IUE4nu3o3da0bejny0Um7CwFpF+HdrUm/czFT//fatHsuVADe47ULlWcQoKNOaLU95l+v8qaSTcGPZOnGFHx8omoxmoOM4zRoVMNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEJ07MZZ65NStudZoNoVgRDN2CWun3It+fcOOpRZ+Dc=;
 b=PTAuN9bhhozE6VBrLxvmOJZEt3PFpOEiB2myxKhIKO5OlNv/AGCIRUX5WckjvnvlRsD0t7Zo+ZMKf4lhgN56e0VKhcILxIY/yHt+ctQYb7FvWGHfTviJlSbXXUKEX0SB0toVUSgTbDhFATb2oDddAswQ3z1i1nGQInVoJwZzPok=
Received: from MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12)
 by MN2PR02MB6030.namprd02.prod.outlook.com (2603:10b6:208:1b7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 17:49:15 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:235:cafe::ff) by MN2PR20CA0043.outlook.office365.com
 (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Mon, 11 May 2020 17:49:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Mon, 11 May 2020 17:49:14
 +0000
Received: from [149.199.38.66] (port=47072 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYCXz-0008Ql-De
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:48:59 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYCYE-0000KC-Jd
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:49:14 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04BHn6mQ008557; 
 Mon, 11 May 2020 10:49:06 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYCY6-0000GQ-9v; Mon, 11 May 2020 10:49:06 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] target/microblaze: Fix FPU2 instruction check
Date: Mon, 11 May 2020 10:49:06 -0700
Message-Id: <1589219346-106769-2-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589219346-106769-1-git-send-email-komlodi@xilinx.com>
References: <1589219346-106769-1-git-send-email-komlodi@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(136003)(376002)(39860400002)(46966005)(33430700001)(81166007)(8936002)(9786002)(4744005)(8676002)(5660300002)(316002)(82740400003)(478600001)(6916009)(2616005)(44832011)(86362001)(2906002)(7696005)(356005)(336012)(4326008)(107886003)(26005)(82310400002)(426003)(47076004)(70586007)(36756003)(33440700001)(186003)(70206006);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f3889c9-91db-44ab-61ac-08d7f5d39eeb
X-MS-TrafficTypeDiagnostic: MN2PR02MB6030:
X-Microsoft-Antispam-PRVS: <MN2PR02MB60300A3EAB0223C2BB6E39CBD0A10@MN2PR02MB6030.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rujfktL+jD446ug6Yk2U+BZt1Ucs9/XyE6H1XKEQ71aByHXCmQop8BF+PZf5YLd7S3Ug+cxEaywBXA+zBCScuJ3/QqoWk9WkezB4yLrUe9e2ljpm2yK9IJ+EDcDw+ZmTm39iCFsnRkNRH/tm9lb57mdnPZajyJnMwP1UEZ0ha8A6UWdlhkrKAbYJgFR4/v/schsaDQ+7ejLqOoHDOEBLbdZ5o9zL4eJmB6V2RwqJvYr2NjzKwqmLCvE4MCkApAq0ow6U7BwR0wUv11u0ZF4xwRChz4cgE+/gKBJPiZo5z5oew9HHsqLVi29DwSj0Cdboru3EBaIInToDoeLLpO2rHefPAbvFFz92kaoqc0bGnzZqO2FDXWe4uFwDz0sJxhx3FJRmEpdBODjoXu9Nu7TH8NzX2/3WXE4Xf8I/VBqp97skNtPSYQy6YS1+4JWUzxzFia68Cbis1LmTYyFtYnsBehXYM4Smd1TSoCcV0/uVFwz+ME/gMAqXOaS9wv0zYooOtHMoXzL2VnV/xrda7zcOHcIU3r81nRnzquNhnWrR6oKVCmBCLeFrf4V1NP7Oj4Z4xAdngfVFtD63uinBtLv/xw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 17:49:14.9315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3889c9-91db-44ab-61ac-08d7f5d39eeb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6030
Received-SPF: pass client-ip=40.107.76.70; envelope-from=komlodi@xilinx.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 13:49:16
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The check to see if we can use FPU2 instructions would return 0 if
cfg.use_fpu == 2, rather than returning the PVR2_USE_FPU2_MASK.

This would cause all FPU2 instructions (fsqrt, flt, fint) to not be used.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 target/microblaze/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4e7f903a..329743b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1391,7 +1391,7 @@ static int dec_check_fpuv2(DisasContext *dc)
         tcg_gen_movi_i64(cpu_SR[SR_ESR], ESR_EC_FPU);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
-    return (dc->cpu->cfg.use_fpu == 2) ? 0 : PVR2_USE_FPU2_MASK;
+    return (dc->cpu->cfg.use_fpu == 2) ? PVR2_USE_FPU2_MASK : 0;
 }
 
 static void dec_fpu(DisasContext *dc)
-- 
2.7.4


