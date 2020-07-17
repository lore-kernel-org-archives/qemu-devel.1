Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F281CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98C620737
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="6we1KHDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98C620737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwTa0-0003A8-Vy
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 12:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwTZM-0002jX-H3
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:50:44 -0400
Received: from mail-eopbgr760122.outbound.protection.outlook.com
 ([40.107.76.122]:15011 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwTZK-0007sr-BQ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpYEWFGsioYAi90pmOYpRi2cUBpk7g5Bpz4ixsFhb2csl5neT4knd/bBIQEX6dDpAYkBxB3VK7WS99otwbsj7i73WgKde3S+RUnr5Q/CFxVIXiRqqlOnMwSkh5jcZpKo7KoOvvuU7lkw2iP7ULYI7KzVylvBO6E56obuT4ph1fkGPhvrGkIauH1W1bLviKxMdBJb1BAmoAIN7ytYmpJKHG6ia3FzGhh4y/A7rCF9kYO3uRaRLfjwWTC9ByaU1TDI+erftYEzY7v3B1L0DmSJEXvtvCwW10FsQri2Wt0vRvY3qVsQy4bAfsdWGlFpWxe9EOjo1R0yC/wpecm4I7HMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V2JXBEgemQso3mK6hby1jgciTdkBMePENs0PFIAT5Y=;
 b=V51+UcO5wexJY63E3uRmvzfMEA8W51CR0bXyXVt6TVNLogdJG+3XjJKTtXDFYQ3I+ZJPYNP1erV7B87cCmRRajynXjjVQPwR4G/jt4YgG5JXSZJm7Z1xA1knoJ97jZT9ygKyfFb6+Bi9HpHKpx92tKuAsM3b3TAR37tCuxMZy0+Yp4TDOGljH8kYrULjXl4hhSPxhnmFKpRw/TfRaSxlKKnXwKn60GBVao4Mo+mRL+8vXBdSSBgUfMUNENFpyE4UGOyK7LyVp3VlccxsEccyKXYtp5/jl4HmlG6n3ckfr+rwEm+0qNNlWdhBUKtloNK9Lm1BpxFYC5+pumCeeFxfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V2JXBEgemQso3mK6hby1jgciTdkBMePENs0PFIAT5Y=;
 b=6we1KHDVax6fgPW8ai1ZCdIquS3rb+3pIqU2Nq5vsHzhenV5EQktKYsdkuhOP2G/plQetB30xuvVW6XWPuAB6jAxCJt21AoD+zm7YBoSslxUq7lgzmvJKxX3+7EKXzRAIWwjvQbvIbumskPq6LhpJk3TOCjZ/+BU7A/I4TtAaZE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2141.namprd03.prod.outlook.com (2603:10b6:804:b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 16:35:37 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 16:35:37 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] fuzz: Fix leak when assembling datadir path string
Date: Fri, 17 Jul 2020 12:35:23 -0400
Message-Id: <20200717163523.1591-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0075.namprd02.prod.outlook.com
 (2603:10b6:208:51::16) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0075.namprd02.prod.outlook.com (2603:10b6:208:51::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 16:35:36 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86fa5aa7-810e-492d-8496-08d82a6f6f30
X-MS-TrafficTypeDiagnostic: SN2PR03MB2141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2141BC9B799073673F1B6BCBBA7C0@SN2PR03MB2141.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mR9ce2/iU6LSzN/uErItm0Mhx2lNOkRe4VQD9Bey/ckFjhycwxUzAT9A4kmcNu9fyZsDKGg+zDFroevG9IMQxmlLZ2LaOH1f2CSs76RpDfpfNBtoBvby4EORkTC5pfpI7EpoaKGTzLLEsddKuh5LZP+fq/lI09sjBQyLn6Z0zBUwRZ6eQWmQH2+eFuvcfI2tRHNKPFNKeRLsylZ/aHaUlRaEBf9URhUsDPIfuQGg/s8Wqgy6Id3OdBwqAwE400uSnWsA0H06CYHwWwyGINNq3LJFGh/iTYuSrwgsBvS82ONq9S6YHEPyKJfr+ZffmHhWdW/irw1jsVnw7KizLOhhhBdHvoYcnRKidQ7jIJfw8TCUccAzbl0lpZo57r7nZFCBmgr66OjVMw/WkJU33NQzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(2616005)(956004)(1076003)(36756003)(5660300002)(54906003)(52116002)(316002)(786003)(4326008)(7696005)(6666004)(86362001)(16526019)(186003)(83380400001)(8936002)(6486002)(8676002)(966005)(66556008)(66476007)(26005)(6916009)(478600001)(2906002)(66946007)(75432002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fYFPfhktIud59J9kaUmk+VmbKjohkyJ8Uj1zbZxE8FdFAwPsZvcp9Roub+/Q8iRon8NhEod4aBEIj8bFtDv3ojesc3loamTtjoSeb/wtOL1WYefaaop4oFYIeXiYRHUqWvkMgslNr+rUpbRBDtFo9yKQxyyceXst6Pv0HX7GswAIvQXRM3WBuKr8w6I69uQ3oq5ghmELpOyFodXfZqVm8mJvoY+Dh+gBwj+lswuxROdlhK8TxREAottGVTQNAnj0qsB46aP1rNFaH3AWT9Htcy3kM89OvEVkKa3vFVfZYBk4NDzJfB/fRVeXI4u95UJf2eNo3cJ6rqjUP7+ezdW+Lj8nRybqHgDfWHuwcsPTUfoPAaAO8I0TY5lj5R1H9PkbIjrzOPTVZouRfIn/YJFCSfap21gpZ9uLqyiKqvk7InYTmsIoQD5Q5oCyp/WHbvjLEIBt10Xe9lwQoTtxdzcPW5/2YWKDRPCpNao3tWkItOk=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa5aa7-810e-492d-8496-08d82a6f6f30
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 16:35:37.1070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZ6Iw1aUt6crA8NI1nOTR+DqPdAJFP6y8PWyzePQ0yPx+eGfFWEQMbg4+Umg24P6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2141
Received-SPF: pass client-ip=40.107.76.122; envelope-from=alxndr@bu.edu;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 12:50:40
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We freed the string containing the final datadir path, but did not free
the path to the executable's directory that we get from
g_path_get_dirname(). Fix that.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---

I ran it with Thomas' fixed build-oss-fuzz job:
https://gitlab.com/a1xndr/qemu/-/jobs/644463736

 tests/qtest/fuzz/fuzz.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 6bc17ef313..031594a686 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -143,7 +143,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 {
 
     char *target_name;
-    char *dir;
+    char *bindir, *datadir;
     bool serialize = false;
 
     /* Initialize qgraph and modules */
@@ -164,11 +164,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
          * location of the executable. Using this we add exec_dir/pc-bios to
          * the datadirs.
          */
-        dir = g_build_filename(g_path_get_dirname(**argv), "pc-bios", NULL);
-        if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
-            qemu_add_data_dir(dir);
+        bindir = g_path_get_dirname(**argv);
+        datadir = g_build_filename(bindir, "pc-bios", NULL);
+        g_free(bindir);
+        if (g_file_test(datadir, G_FILE_TEST_IS_DIR)) {
+            qemu_add_data_dir(datadir);
         }
-        g_free(dir);
+        g_free(datadir);
     } else if (*argc > 1) {  /* The target is specified as an argument */
         target_name = (*argv)[1];
         if (!strstr(target_name, "--fuzz-target=")) {
-- 
2.26.2


