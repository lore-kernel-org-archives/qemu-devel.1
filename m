Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A64C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBA62075A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="MoSS9AFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBA62075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeiLx-0007R1-Mc
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeiKi-0006N3-G4
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:58:12 -0400
Received: from mail-dm6nam12on2098.outbound.protection.outlook.com
 ([40.107.243.98]:17697 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeiKh-0003lv-Nd
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:58:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHD2e9oB9Alk6NO1AmvyFd7X/dcbRU8IuqBL1+yadReOu+ywbDHhJZ/pM7n52YgkrqbFHyTymRQgyyKOnXVbLyszgNSxlmK9tCojox6fRxT1+7u4+lW7ZRTCNTJW263nuUcmgyAxedsILwPE0v4heW+0seEVfh1ujViFpF+PjIfIDL89S0WIInExAVREx0h3+5HxJaKA6qKMwJpx5iuJNWAKNtWvi2IyitQWqe/4+uaUwFE4DMGQVau+mTyaYXU0ehpj6dt1uAecD7iB2THwPtWzXqNzMF0aAkLENPpdXwRhMdCEOa51g5bWgc9CIBQluG5g22U9rs2LZBLIs9KpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF43pmbK7Aodes9LVekcIcCYpaa+Gq3Lxpdu8DvOzm4=;
 b=bf6/508CyzlVq53tdywK6Z2E9DE6J68u6jfw+I2V9wPgKXFrDL3IL9ubtrcg06STgCONqozRcC16RF+2+peMsUUwSLdHc3NBC1eMEvDuBim1+fGeYCP24+GQLrxBvrcTgtap1nxUYWW6NeQgKyGoedJJgxjzhhjB3nkTFik/isWGFn7kaAZW31gDhpmgVPGeZzmogOxd7K0uD03ocW1isyyzRtpCCO0uLUSa65sBpO1qXtaVjnSk34NTmtuC6Bll+ItFPZthohcTx9OM4RbUSpXjfzuSoFX7jbT/OYAuzQXGGn5mSFnsd1dfb4RXiLoI48/y9Rtn+uybAx5XpVNgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF43pmbK7Aodes9LVekcIcCYpaa+Gq3Lxpdu8DvOzm4=;
 b=MoSS9AFHajWdNnxAeLcvf5u+s3z/GiXL8fEpBE1pIjUTzTckXBMC6OWtvYvkRzxOmjBflnJFV5eE/6npaOBM8SUQezjulBYLuQhGzTlbSWbfGV3WKWzTo+7TOxXQWzhudFxdSeDnt4ocCr9ayebJDjurxW4vFNBglgMHLuCnOoY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3504.namprd03.prod.outlook.com (2603:10b6:805:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Fri, 29 May
 2020 16:57:36 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 16:57:36 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] fuzz: Add support for logging QTest commands
Date: Fri, 29 May 2020 12:57:19 -0400
Message-Id: <20200529165719.19262-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529165719.19262-1-alxndr@bu.edu>
References: <20200529165719.19262-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0077.namprd02.prod.outlook.com
 (2603:10b6:208:51::18) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0077.namprd02.prod.outlook.com (2603:10b6:208:51::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 16:57:34 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a54be189-ad8e-4694-a33b-08d803f162d0
X-MS-TrafficTypeDiagnostic: SN6PR03MB3504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35040750269A19A6ADCD56F8BA8F0@SN6PR03MB3504.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHtwfqW5k227XdZKzM9yhVvh2Koyzlh0CReauNY4AFynRKnPlN+5pFh3Zw0XKTxdxAM71fF+B4yX1sOlePbO2xUQX+GLk0/rJAjb/1MyTIDbmI//4IkFuXXdlD33HeSIQ1cv5kWjovXicN8u0QGlA6pQSejQTFdPm93FRiEMpovTOORzhll1cgWvivPYU1sSqri+VgYJAkBnilJg30w+/0N5L0rsdxexo3C+3rE0p0AUVNTyHBMzqbEPcblwWQmPd7eBI4LTxJqjTZP+qhI1yifmJVSsoDnyw7E1ExdwM9PLVc/o75BDy9fnJhx902E0VcQESSDVNCXiFRR2UmFuTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(478600001)(5660300002)(6486002)(26005)(4326008)(6666004)(36756003)(75432002)(54906003)(2906002)(86362001)(16526019)(786003)(316002)(8676002)(8936002)(66556008)(66946007)(1076003)(2616005)(66476007)(83380400001)(956004)(52116002)(6916009)(186003)(7696005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gPzLLitiW4FN0i23E/t210WoPq3iDaNfJTwo2oOksuxaU0EkDSGGYOjxTQfNrNo95bceLjJI4eKHt7c5A3Hn5fXTuz14GKM7VVB+fKO4HA84nnu8PmOGk7yMs7M2/jmLRU0UOEy+Viyp+d44fmASVWKTNO7zYT5BqWdE5zNHs4xE6wrwrdiobh0sO6I+x8R45zWwqh05yfUSy14y12ButW24Fbwmyor6ast2jidQeDLfcWA58z5JRqWadwH4QVL+BY17lkJ28S2V5+dIt9MHGGs9KT0pkj0WWHUXxr6Cwg2DEiklahw16H68gPO3ZENjPEbRWDGLQfJXhMw5NvDj7/wwAbYY0xaLPqpnIVkXfcl9dT7HNnSIoPpxZ837B/pIVnUZhRS3FndBW0T71kJvm6g8b+bX371zHXq6ghQWYmpGnDxSonC2tnlFtMTcgtCj2XcdtwbmPRA4/oPXDojwl6pXJqngcPbi9NJ4gM0Oia0=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a54be189-ad8e-4694-a33b-08d803f162d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 16:57:36.3790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG9BkFotNUNwmPn9watJGb/JY29gy5m4AND+cwcway3A1GHfIY/CvJCdYRVblEac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3504
Received-SPF: pass client-ip=40.107.243.98; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 12:58:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index ea630ddb9b..2c9e2ee7b7 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -94,7 +94,9 @@ static void usage(char *path)
     printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n\n"
            "Set the environment variable FUZZ_SERIALIZE_QTEST=1 to serialize\n"
            "QTest commands into an ASCII protocol. Useful for building crash\n"
-           "reproducers, but slows down execution.\n");
+           "reproducers, but slows down execution.\n\n"
+           "Set the environment variable QTEST_LOG=1 to log all qtest commands"
+           "\n");
     exit(0);
 }
 
@@ -198,6 +200,11 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
     const char *init_cmdline = fuzz_target->get_init_cmdline(fuzz_target);
 
+    init_cmdline = g_strdup_printf("%s -qtest /dev/null -qtest-log %s",
+                                   init_cmdline,
+                                   getenv("QTEST_LOG") ? "/dev/fd/2"
+                                                       : "/dev/null");
+
     /* Split the runcmd into an argv and argc */
     wordexp_t result;
     wordexp(init_cmdline, &result, 0);
-- 
2.26.2


