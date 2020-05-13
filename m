Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EEBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD2920659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hfjmPFBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD2920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvpN-00031v-AE
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoS-0001Uz-2u
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:00 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com
 ([40.107.243.86]:65249 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoQ-00005V-As
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:08:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfTDhwUn/4a1WhmetwzRmRI32LiU/KhAVx0sQ8yu5B08wZIiTNUwui1w7UywBbZ9jUd8hrhZWguElRQVPz/1IGBvPjuZcXoBIHlJY7LzwNwMmN6PGS2fivx1Lwiiv5NG7DTWmaeQacm2hOZFDxEj3ZpzaPzYpxJKIFBqZwcnWMBeyvuNlj9TUXWVf2TgYPmXsa1qSV+ZVfpR3aMcDJZZshjd1EB6qV5rMjgANEXFC5Yl6slHKY54/WZdtxwunoGyLw2WSLdEiKya2GwaDZjFBQ60OJUQaiAkegaGjy5I4uFL/NC9SMTcIz29khtWuew/90qsQ78LqpBUYGSY1sakMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95yqqbip7xXPz09ylUg1tmOBtjWhHrQ0bniJROEWzEE=;
 b=TMGN4f22bZa/h0+L6UBp3EBqALDGYKXM3XW8HHfcIWe4CDpqPTkMUYJjMc8iWfHy22TfoR1uTC9Ioz2BU5c4exisR8dzxStDsvMj+w25iv+3mh6blrvIupjF5jQcY533drhHvCkWj3TIPDGXGlT6IYXlmlVVqKD6QaVhkACmkm7fHEU0Fwg2VvrH2vMVsfnZZTFQ6wfKYBtpQcIwxeRGjSFnfYFJ9KvcVKXk46/nTaU0jIvBX2DLcB5q5KkLYyTGg+Y24Gb7NZT2EVpm6QjpqIfacgrSp3Q+iQ29eBvbRgM2Ru3vorOr2PcjcG9J2avJCxU8RzWnh5uEns9fAf/IEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95yqqbip7xXPz09ylUg1tmOBtjWhHrQ0bniJROEWzEE=;
 b=hfjmPFBa7S6+YqJCJQah9gWD4ZCoKwTUR1F15rnHo8bXE3qSmJEyDY6Hux+MDmW6qLSyzR+Jue9E0DEqTWcQVpeylZuL6MqjqC8si0akqufMeKsGu8jfghey5Mfaz+6RSQgm7MLZvWJgjFYEXpGILqHc7XJp2fzF6i+aDV+rnvM=
Received: from SA9PR11CA0025.namprd11.prod.outlook.com (2603:10b6:806:6e::30)
 by MN2PR02MB5920.namprd02.prod.outlook.com (2603:10b6:208:11c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Wed, 13 May
 2020 18:08:55 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::e8) by SA9PR11CA0025.outlook.office365.com
 (2603:10b6:806:6e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Wed, 13 May 2020 18:08:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 18:08:54
 +0000
Received: from [149.199.38.66] (port=59409 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvo4-0007y4-Ha
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:36 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvoM-0002TI-3D
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:54 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYvoI-0002SZ-4I; Wed, 13 May 2020 11:08:50 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2 4/4] target/microblaze: monitor: Increase the number of
 registers reported
Date: Wed, 13 May 2020 11:08:48 -0700
Message-Id: <1589393329-223076-4-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
References: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(39860400002)(346002)(396003)(376002)(46966005)(33430700001)(70586007)(2906002)(8676002)(9786002)(70206006)(4326008)(47076004)(5660300002)(7696005)(478600001)(26005)(186003)(426003)(2616005)(44832011)(336012)(6916009)(107886003)(356005)(86362001)(82310400002)(33440700001)(36756003)(81166007)(82740400003)(316002)(8936002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0f830d6-02f6-4b54-e199-08d7f768b2eb
X-MS-TrafficTypeDiagnostic: MN2PR02MB5920:
X-Microsoft-Antispam-PRVS: <MN2PR02MB59209D41243EDCA2D1C5B179D0BF0@MN2PR02MB5920.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:287;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSq6pPcpwn7podPtToWD6XRbMTD5h5aRwbdeQIJ1duI+VvwDb0hc4j3DtzWWR+YTRhEfAmtmNmN89PcTojxOukm3huHZNrKkrrYfASbdgEBmknnQKtfN+aCwZN6B0mZH6sy1ZV40OtPh0gAEymE7IjkqKvjJZ+5EwjAwDEkdU/bErt0vI18sf5CnuRkMcCuuDGnKZLPiJOmBCG3djS/zMXS/kn/mEyvS8bo4LCEjz14ZNxyjttY12rmj79TBCrtIiAZNYz5MFMg1AqHMFT+Lbq6ieBrpCVP0D7d6HhM+HJHDJfLWWcJDWEJ4h9c2HEOLNeV1tsChYmY7iKxHEWgg+tFXxIvT087yyIgUWSdeoH5nqihSIMmFQDiodsNhHX8RV5Ea37vkhI+nHPZf6Xu3dyZfxYaTb5fYighvue7d95AZSp0TyhqKvK9j5Y8mV6NeYChMp5b9fdZn6iZYHJQy8uAONQ07NsM0JKidJ2AYVUSX1la/nYfSYmd0uWB8rypqWlwmrQRHBgdYw4JWPJExXR+m0yraXGzE0rkT0/gpICqBcHsXrluc+Gz6FzdPd+ozZTZA2P3NLqx4NMYCCs534A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 18:08:54.6657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f830d6-02f6-4b54-e199-08d7f768b2eb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5920
Received-SPF: pass client-ip=40.107.243.86; envelope-from=komlodi@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 14:08:56
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


