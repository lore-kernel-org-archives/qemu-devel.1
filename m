Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06CCC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E4020714
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VKvV+FnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E4020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYC8k-00007r-S9
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYC6z-00058d-7v
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:21:05 -0400
Received: from mail-eopbgr760058.outbound.protection.outlook.com
 ([40.107.76.58]:8291 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYC6w-0003uZ-0l
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:21:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1XMymMWEDUw54CF/6WVqeKPE389EFBdS6KsHwQeR512tEmliVohxN00OJ8NbgFQ+tkNkG0eLkKkLPPLzukGsXN1W6w98PsDuUvUFaT+63ixlPWB/uYWq158X+YILZGGUzbhsBFEGgqivS3T9hBwb4UB6qhnMTKNVdhAkN+OTryzmO0Ud1GSYGyOj7rluXTSXINy/zAMR2Ejh9PouMDtwVvxkJn2zXTMyjWCR2uM5gX9yoZzREriKZaewCpqHox3XyS5E+TSzws/ZdnjWJE56UDnJeylRzpBNol8RNrdfQo0vwQAr5l0RFYDQvqKpstU06F0RJmMaMms3LtS0bGVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95yqqbip7xXPz09ylUg1tmOBtjWhHrQ0bniJROEWzEE=;
 b=EDK3RQJER7RY0Cw/u+iDYHkPg6Ek2VdstqGp8f58lXCZXOP6qk3lel5uIEkhM1jhQatyIilG+0lpGSwKnmZ8pT2/6P0swguoIO4qVyo8riF8i3R56APJZTcMqMGKOAx8xycOePkD6tpcCkI1+aMVP+vT4z5XCt/g8YB0JCHFrsigVyYE7AzgPeWYk4awSrCMfQwJSdiBtnJmK40gb8d3z5nDLcmA/+6McmZElB64yqjERot6+nNg932kh3N3dgdUUgUon8enjKoo7S0mZmftdbDxnWy7DGf84MDw3w7a1LQcxFUw3VZ+jiKD/d4CkPBv3B5uNW4/KA519Hc1uEq+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95yqqbip7xXPz09ylUg1tmOBtjWhHrQ0bniJROEWzEE=;
 b=VKvV+FnIhqDkVnOSxmlgIbpMz4lp0MACOIdSFS7wRmRh3bYss9oplToZdgxT6t9yua2J2TvMCcegzMz3H+C1gLTIW9evG7OD1DcDc8B/UNQos24s34Pq4/C92hlbuCURBTXWbHIHmWQyOFtKkoIIDqFKAwLyt5sNXI3ujN4X0MM=
Received: from CY4PR16CA0008.namprd16.prod.outlook.com (2603:10b6:903:102::18)
 by MWHPR02MB2221.namprd02.prod.outlook.com (2603:10b6:300:5a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Mon, 11 May
 2020 17:05:56 +0000
Received: from CY1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:102:cafe::57) by CY4PR16CA0008.outlook.office365.com
 (2603:10b6:903:102::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29 via Frontend
 Transport; Mon, 11 May 2020 17:05:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT046.mail.protection.outlook.com (10.152.74.232) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Mon, 11 May 2020 17:05:56
 +0000
Received: from [149.199.38.66] (port=35066 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBs4-0007n8-PJ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:40 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBsJ-0004Py-TP
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:55 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04BH5qi3028919; 
 Mon, 11 May 2020 10:05:52 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYBsF-0004PW-Tz; Mon, 11 May 2020 10:05:51 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/4] target/microblaze: monitor: Increase the number of
 registers reported
Date: Mon, 11 May 2020 10:05:51 -0700
Message-Id: <1589216751-106038-5-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
References: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(39860400002)(396003)(376002)(46966005)(33430700001)(33440700001)(2906002)(82740400003)(8936002)(81166007)(82310400002)(426003)(5660300002)(478600001)(107886003)(6916009)(7696005)(8676002)(316002)(47076004)(336012)(9786002)(356005)(186003)(36756003)(2616005)(44832011)(86362001)(26005)(4326008)(70586007)(70206006);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 433c2f05-0a6c-4cd6-8ead-08d7f5cd91ef
X-MS-TrafficTypeDiagnostic: MWHPR02MB2221:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2221E84965035755A171F127D0A10@MWHPR02MB2221.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:287;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ao8x8JeP0WxWl4vZIo7bB2OzVhOtMhanIzpLRT3007V2e85ZsATv7+U3MkAhtm0d9phy1XqL8VFxaCJWjW2PI+6DIlbq73ivyT7GYBkiOJ1XbW+D5pgnkUU5gwlRKE7d1BV3CtKHJJzcfLsqhBinYAkalN6D09B7GGBmtmDHA3+8p+aZ2IT+KjnlN3DjSYUhJiGdNttcXJiDuHv+uM/5ofAANdqbK5usl+XGT3BweoYMUhsIHJGdPlZDge7S581ASsuc9TasFVIpEBIbidY0Xlta/CKQqkyfWx9uyXVzQMrjFWhR991vwBOh+tUZsdluTLKSc2rKqXo8B/6S4ko2ju3GWyhoqxxUGKJEnBH9B2o2kpHJaIQxbrwNHMjTx+4tCy0CM1Ycauc0LNKhDVhNfPkPKHtNJSvETntBpLph9HLG4eHzOfodNaOvltk831OtH9qW2kXTkSrHuigOG1Ln7fHtHOgUYrghswcXOQRM4Fjdu/MvB/ip8NdEr8VRxmSAtHcIAb2ZUErz69+lmdriKOl8zwFWK3IEslMIISZB877+H9dXK54297i0iLAUaZLi/esJYFn3iJcdC2Bwqn1VQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 17:05:56.1691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433c2f05-0a6c-4cd6-8ead-08d7f5cd91ef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2221
Received-SPF: pass client-ip=40.107.76.58; envelope-from=komlodi@xilinx.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 13:20:59
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

Increase the number of registers reported to match GDB.

Registers that aren't modeled are reported as 0.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 target/microblaze/translate.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 20b7427..4e7f903a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1788,9 +1788,11 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IN: PC=%" PRIx64 " %s\n",
                  env->sregs[SR_PC], lookup_symbol(env->sregs[SR_PC]));
     qemu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
-                 "debug=%x imm=%x iflags=%x fsr=%" PRIx64 "\n",
+                 "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
+                 "rbtr=%" PRIx64 "\n",
                  env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
-                 env->debug, env->imm, env->iflags, env->sregs[SR_FSR]);
+                 env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
+                 env->sregs[SR_BTR]);
     qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
                  "eip=%d ie=%d\n",
                  env->btaken, env->btarget,
@@ -1798,7 +1800,17 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
                  (bool)(env->sregs[SR_MSR] & MSR_EIP),
                  (bool)(env->sregs[SR_MSR] & MSR_IE));
+    for (i = 0; i < 12; i++) {
+        qemu_fprintf(f, "rpvr%2.2d=%8.8x ", i, env->pvr.regs[i]);
+        if ((i + 1) % 4 == 0) {
+            qemu_fprintf(f, "\n");
+        }
+    }
 
+    /* Registers that aren't modeled are reported as 0 */
+    qemu_fprintf(f, "redr=%" PRIx64 " rpid=0 rzpr=0 rtlbx=0 rtlbsx=0 "
+                    "rtlblo=0 rtlbhi=0\n", env->sregs[SR_EDR]);
+    qemu_fprintf(f, "slr=%x shr=%x\n", env->slr, env->shr);
     for (i = 0; i < 32; i++) {
         qemu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
         if ((i + 1) % 4 == 0)
-- 
2.7.4


