Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECA9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D5F2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Eb4+5mR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D5F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyS8S-0000dT-S3
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5w-0004WB-Cz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:32 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5u-0002Ew-Vc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6VtSUIj/1uVsOxycihbNcZ4nZcF2DgX/zyiCwh26N2VlqOOVHOeRiTbrQNmnd2FzHK6w5wa+ApY+DKt1i/WHztiPkf2DUs9kWllnIBoitGSEhBjsUxqEks//V30IstQeYNi5ecXLnoZb9TX0prcfaEQn3LPa4r44sZHPm8hdb1hJ/AYjDOVuBof6OmnoV554K0qawcrKEc91WmxhAefiKT0wAWj5u23c/RTrVGHrxrsqL5cFw7t+GZW4lrMGCWaUBiGR/6dKxajhCknFBx05efm8AjCOyGoXQpfnPyzHQlyRZ/cWK+o2PAxnwghEdf1BzJxRIMUqr1p07rhs/6ahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktyxUGnYf+LmUVRdpxI0BGBhgpxPWQEYle6Jaz1ifws=;
 b=fCXrbzUv35Y2eRcTC/VT18Clhsdp1MXETbCL3F0qXhtiUO97FovOEFsMEn6G+2sScElFbZWL2itljCiY0Lh5aNr2mcJ/5FmBZIBT1ytAi1HRrqDnz8fHV4pSfzgkgetVFgZHF6lpjEt64+srdmM4TuQhD00Sy8qY02N1oFAfu77Z2jWYY+CLIFjBi1PAWdUq7Gv2yP09MUGt+0w9iAe3yfITTi89ynUR2XOXKjPAum9HbVtpWf/PNqjCjlyyYUebups3pSbCrF2dFSTeXCNLhcP3RqsTavjVxkUWEHedFvZocm3p0nioLxnYd535UoVNewRALw4420J8EMW54gZCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktyxUGnYf+LmUVRdpxI0BGBhgpxPWQEYle6Jaz1ifws=;
 b=Eb4+5mR8ZWWiN9FCG9FC7D4bYdKVE9mWZ1NEkC36jSuln0JCf41Jd6N7dgxmplTy3ytCnfNTodaulqBkhegN20D8HW3gLCqAfPNo8l92wQslrRaC9uVbLw6bogPGfGdfdT7qDYr2kpk3vuN9NXMwekw64TW3/iQilOYsfDXV1mY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:17 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:17 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/12] scripts/oss-fuzz: Add wrapper program for generic fuzzer
Date: Wed, 22 Jul 2020 23:39:28 -0400
Message-Id: <20200723033933.21883-8-alxndr@bu.edu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723033933.21883-1-alxndr@bu.edu>
References: <20200723033933.21883-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 03:40:15 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead30c39-6fac-4fff-3b2a-08d82eba1d61
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB39828FF3ECC728C670A38E08BA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLxPHZcrh1YbdrijRoHz1fyWWGHEIWC1g+ktndOfKVUcqzTP2v+kmxOhdjcfSVaHl0Uapq7xk+IwhHb5q3pGgtfD+pbYcgJ0euXL2RwdSbgBkuDHAA8j8PF+Ozwh8G2NdmgU5/J17PUNKv1vPk4lszEbIdtMgljvjmQoza21VkhqJwy9G/LUXwyiEUqiQan5YPobAM/i8DP6OCTPqQADxID6zFkbGGtHr1McRhYIDzTCQY88V6KSOM1n/QsK/qXsxl18qTRmLKIHetIPROYMnbLQ+Be6yQgxLLMOo32yi5jX1YLEiW4UFhvPLsdPKkHvqR++HCPLEFEnlqWeUn7tpKYYbH6RmLIWGrKaKvbJlG2CprcmnGvrTx9rGcGEIK1V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(83380400001)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7bUTUSOzZVBIgWrhpl/qAqR+NFG63Jp4roohOqDRF9Qc3u/kNPQcr10vJH166vSa9sz+apmOV46Fmaj4ud/gpUN8K4014BV0X2H1OaH7RVwUbQHwc+gRf1DS7d1l+Oaz2izUmAcRcJ+hmqu6VTscckHAHbaGF+pKNm7n3uydSDA+xJE1udobA3pJ3zmVWVCyuWpu2pq3d25WRWTLBe6cnHMb9DjuDb6YJZGKIWhhS4S5qrUbiQBcuMqekXf0jUteZC135g3Rk/tkAofJC6ar1f2hymgfGk+OlC6knuWEaQpVpE80UpGqoO7BWm/C6LZPhT4S5AnnGfY1M+foJnhfAspU+1PfnJ4pxMV9yJoNbdp0CAAX5ohA9emkACVdGLlrvwayWpft9EP8Qlbe9bi+36V3h+FK/kh3mRBEg2QQhEb514/cOcA2oo6fT+kXrb6o/Hhl+3j+WsBamHReUirs/GQIiQR2JSt287Mj8nt9TiM=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ead30c39-6fac-4fff-3b2a-08d82eba1d61
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:17.4475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHBcueXBFzcLNmCnTEMcR/4S//S6saPBvwPO4/VPd6LB76RQ9WR7RL4oimmDWfUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3982
Received-SPF: pass client-ip=40.107.244.114; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:40:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, dstepanov.src@gmail.com,
 stefanha@redhat.com, andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On oss-fuzz we need some sort of wrapper to specify command-line
arguments or environment variables. When we had a similar problem with
other targets that I fixed with
05509c8e6d ("fuzz: select fuzz target using executable name")
by selecting the fuzz target based on the executable's name. In the
future should probably commit to one approach (wrapper binary or
argv0-based target selection).

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/target.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 scripts/oss-fuzz/target.c

diff --git a/scripts/oss-fuzz/target.c b/scripts/oss-fuzz/target.c
new file mode 100644
index 0000000000..4a7257412a
--- /dev/null
+++ b/scripts/oss-fuzz/target.c
@@ -0,0 +1,40 @@
+/*
+ * Copyright Red Hat Inc., 2020
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <libgen.h>
+#include <string.h>
+#include <unistd.h>
+
+
+/* Required for oss-fuzz to consider the binary a target. */
+static const char *magic __attribute__((used)) = "LLVMFuzzerTestOneInput";
+static const char args[] = {QEMU_FUZZ_ARGS, 0x00};
+static const char objects[] = {QEMU_FUZZ_OBJECTS, 0x00};
+
+int main(int argc, char *argv[])
+{
+    char path[PATH_MAX] = {0};
+    char *dir = dirname(argv[0]);
+    strncpy(path, dir, PATH_MAX);
+    strcat(path, "/deps/qemu-fuzz-i386-target-general-fuzz");
+
+    setenv("QEMU_FUZZ_ARGS", args, 0);
+    setenv("QEMU_FUZZ_OBJECTS", objects, 0);
+
+    argv[0] = path;
+    int ret = execvp(path, argv);
+    if (ret) {
+        perror("execv");
+    }
+    return ret;
+}
-- 
2.27.0


