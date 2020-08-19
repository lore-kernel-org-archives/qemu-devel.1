Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF596C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87422063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="MrHVCy1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87422063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HL3-0005LW-Tc
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK3-0003mA-DB
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:43 -0400
Received: from mail-bn8nam11on2094.outbound.protection.outlook.com
 ([40.107.236.94]:24608 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK1-0001Y3-8Q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9qVtKIr4f30K41YUr6wB/A89QepprACARFeseeSrXxz/DKQBVTCFn/YowSwp32mP0urkKOWtLTfX515szkL11s95o0SK25M0IP2gnp/zHgIo+Xln999uKCkm1l9YsjUOk5Tzqqs+cphBVu66wNwcZI3ijPyG0wZdgdTSeydRRkq09TZP55UnHB6LJfa7kuK4y+qA/ecUN4iMbP/n7Rq9ANg8SulNh8ksxrFOK0QXgOOw1sC5Dpus2LzdqqTY/n4fBqGV/Ti6f3zkdKqvh1fOAd+Z4uswP+N2uaJNGF9fKxd/QonkPBe/Mn6jWIIjpxsX+rXLRoXg+LefgQBztQA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy876L3SaINJIQ4UizsMomYb3fp4iPmxSgYioPmr5Ns=;
 b=RklFadHLowQTnFxKTyrPDfBRxL9cBMwUxxdbEX4WzX6hMyZhDmiMpCW2nNpnOLRhqwwrpkxADwrG4l8A4nL4cakTDGRWPMWNGbZ0j/No4X8Zja40VL1On0qyaldiyAN+8U1k598NKJ40QPfJWGhrwtafRgCWTBmeJnMleGYds+W223+zjT2JPeD1OfQ3uRAemjNWdhDY8/nwk8uoXdxgzwlhZzlXNzaQZWcQ2cPwrEd/PMCsyILl4zRrandVRovIrrmH2vkM5IwRoHp7d0xs3XFUALPKdrAilYP6GAEELONythZfSU3vCh5cIHdi8L0fDwOf55/6JYfGDltcFrWznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy876L3SaINJIQ4UizsMomYb3fp4iPmxSgYioPmr5Ns=;
 b=MrHVCy1f1Bjp7VAW4QhKYB7HXJzoU57aEb4v4ftRIbUSkv2wHmmekrHbMANGLayKbSkzIUmL5sEJKrEciDFHnNedt3JY2/KJJ98J5o3/GxSFW1NW56er10wpR9A1IxOhrgreWbkh5w/UOL3NSCQw7LcD5ex8+1rkoPG9UE9BkTw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3934.namprd03.prod.outlook.com (2603:10b6:805:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 06:11:32 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:32 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/15] fuzz: Change the way we write qtest log to stderr
Date: Wed, 19 Aug 2020 02:10:56 -0400
Message-Id: <20200819061110.1320568-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819061110.1320568-1-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 06:11:31 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44916f85-cd34-44ea-35bf-08d84406b7fb
X-MS-TrafficTypeDiagnostic: SN6PR03MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB39348A762591935BB8B7E2CBBA5D0@SN6PR03MB3934.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9p/lLXI2MBJkKFPFA0d9v7CJytHFL/xUcqDb+sP+N2gLVC3hfOBEHuFpnVLe9s2QZGhGQq5lO/za/z8P0G+4297B5Qs5zKrRMU9mYlFxsqn9rcL0Okoj81K5as4zAfb7d9OwW0aAlN+1pEiexP9Atq6hvoNDVAajDIRPQMI06icxx0RjtZPDDeJ3kxvAEwbWtf3BmkwdWoIO8fqhpkExUZcEpPfhTg2rG0dI1DRdEouiSj31rStLwDcMYXJUTiu6rgdKltSFFupYl3f73h10HxdW7U0UzqOJpN4sdgl2iLFEXyV4AsAfKMH5/fXrH/A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(1076003)(8676002)(6666004)(2906002)(6512007)(8936002)(6916009)(83380400001)(6486002)(54906003)(956004)(6506007)(2616005)(36756003)(26005)(52116002)(86362001)(478600001)(786003)(66556008)(316002)(4326008)(75432002)(66946007)(5660300002)(66476007)(186003)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lMz0dTpocGTK9MUNw1erv68p+4BXu1yjJpw2pmK4EGgzsAWIl0PcUp140zAoM9CedCvMHHS02pdghCAE/cMvs9KDN3/truXNa70TJQHNqQ0yox3vqMAP5o+BZ5mtvdeTZQ2EKRHpWAcONyC1KkSOkWHvgAhsp/H+ENJhs0hvCwybHAqM5i/8x5GK0x5pI24DocIWXaX0Gt1KZZJFyjmarZ/bRXB9jxIt6PzyYR8IZkQeSGR+RwsrzzDS8zDxGvNrORt4QCNJza/U5rJs/ZtGilGTCc4J82I7FJUu8OzmEdZDVWandDR6sVj8c2mlpYWEFhyPJYweW3SVAAaEbtJAadPWXx9pvhG4v1cqkjQPQoCN3INPee/XUAyKG3Ux9V2QJJhscyIFOW/Nca5zPAFRmLJZ8HA1x+ytIBhxsicxmg+7UvCz68StyqM8ATIjSqpMc1gVdtYWWX4zwFLpoBIur6RGhNiQnLc8WzsIvSe8qp0rZXBFpuYMzr9lfKpWICeqA7T/301bRQKEYXlOoHG1HQk8uhiP+jnMmwTTp0mvP/2erjV+xY1OmDsVXBM07HIi4gBATnN7knV/ioeMn4IQrJbhfbTeEMkZ73jhxKXWJw6Ku151rLJ14MzGEsHL6LS3mUeI6BoNWAhSE/DigLHcIw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 44916f85-cd34-44ea-35bf-08d84406b7fb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:32.4609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6xwjuCHNBuhUquLn72HlJ5XvanJcAu0Q3oA4weATQy5LgZ9T5buEvvISlYrDfXu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3934
Received-SPF: pass client-ip=40.107.236.94; envelope-from=alxndr@bu.edu;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:11:39
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Telling QTest to log to /dev/fd/2, essentially results in dup(2). This
is fine, if other code isn't logging to stderr. Otherwise, the order of
the logs is mixed due to buffering issues, since two file-descriptors
are used to write to the same file. We can avoid this, since just
specifying "-qtest" sets the log fd to stderr. If we want to disable
qtest logs, we can just add -qtest-log none.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 031594a686..8234b68754 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -202,9 +202,8 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
     GString *cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
-    g_string_append_printf(cmd_line,
-                           " -qtest /dev/null -qtest-log %s",
-                           getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null");
+    g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
+                           getenv("QTEST_LOG") ? "" : "-qtest-log none");
 
     /* Split the runcmd into an argv and argc */
     wordexp_t result;
-- 
2.27.0


