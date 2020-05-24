Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267F4C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E191C20776
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="GiFtLT3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E191C20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcrmG-0004jg-3x
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jcrlW-0004IF-6k
 for qemu-devel@nongnu.org; Sun, 24 May 2020 10:38:14 -0400
Received: from mail-co1nam11on2134.outbound.protection.outlook.com
 ([40.107.220.134]:31904 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jcrlU-0000MV-EO
 for qemu-devel@nongnu.org; Sun, 24 May 2020 10:38:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzX2ElumCXPWnTsH1Rad1i8AZpeZ4tyw3H23iAbyhe/Y3Jxbc4no+gL4Nc0xZdFEjoA5vyjvzBtWo5FrCrWIWBcKdiKCyCda4TCp/2RKPA11kinnC5YX5oJQp7P5pjVWTFtWW0ncLCI1183cWN3O9M+w+l8mqoYy97BK7w7A4eAwKnUOximAsTuPVFZfQAOrlfEsgSbbOh/KV9Yup3nWefxBlFuqV3lc6jTPEGK0neUB4sh9mE/l98zRhZswqCBplrvZPSS4IYXCFjOXDdaBCW3cMiy12NLynJJn7NIp4zCAcl3u7yCsNy0RJMc5ZRVtK5LI9ZzpIQS7zipzvZ2NoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+p4yUhh1+DrxG51Ru2XF7wJBHVF1eg938VXLrg9EgI=;
 b=Ru2iNY2hSnxsDuUFX5nyJP1LGHGqTlFqtQGT3OvTpiHXzZAE+KtrfqOwWiNj+P8Lf2gMswchX5ElpmzC/ecD3w1ycBHeRFitAXPbnik01aCemHrjD9zEvNOgcBIJIvjd3LEzZIgTQugDcqLGk+GiWxDC7BlC/u1i7hl2uSjTZsymOz0kv5CH/OvMbOQXg5eyYptGdDJmuCvdnD3Ml/bCu7+lY37fy/gfdL7fpEivWN0USAW391OgDXKU95CXsSHwNcApZ6BCBqLzLj6xTIXlYjWc1evgbQqLgkfnhaSkcTxUliGO929BGUEKT7GK5r3af4b2PlqKDVhaos2z9yPG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+p4yUhh1+DrxG51Ru2XF7wJBHVF1eg938VXLrg9EgI=;
 b=GiFtLT3n1ov/bnUR1tfeMAuRPFtM0rXCJIEX7LQtPvHJBXn7DsUvDv7S7aW02ovvoOmeCc7llIiiiWZhmvTTJrKHqJOH/1z/nK3RCyk4y/GlfUZYnaU5HYIzcbMwNriG9G9nJv1s6yF6NRNdR0zhCKqKjPbscP5O28vn5dHJMQU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4590.namprd03.prod.outlook.com (2603:10b6:805:fe::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Sun, 24 May
 2020 14:38:09 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.3021.029; Sun, 24 May 2020
 14:38:08 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] fuzz: add information about useful libFuzzer flags
Date: Sun, 24 May 2020 10:37:38 -0400
Message-Id: <20200524143738.23218-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0022.prod.exchangelabs.com
 (2603:10b6:207:18::35) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0022.prod.exchangelabs.com (2603:10b6:207:18::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.26 via Frontend Transport; Sun, 24 May 2020 14:38:07 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc7b7af1-697b-45be-bd15-08d7fff01365
X-MS-TrafficTypeDiagnostic: SN6PR03MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4590B7D9975133C445CD7FA7BAB20@SN6PR03MB4590.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0413C9F1ED
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lB9NtkGmFBdXN7rnfkfpVn1n1aB8OyMJF30lISqX6LT+gmiuF0Mz7EnU9orvVXlbyiw+cnoShTbPmm/D0Rz4FwY0tDtALrufPAtiR31k3+U4L6OZ6jBjxcxl5uWz5prtjtGUiwKf2d6x5tBc1/Wr2tAQ469bh7Rm5MIFEQZUwMjA42xcirYSy5eFKcQr3nN8wxwea6neT8/u6wWfqbCEwsK9vsu9SbQXO7a4vx0r5HXKp2HzLSUFiCJ4Xov0+KF+g0c62cXtCjQ1zo44b9gbWBfMZ/ErZZePxjkd8o9ljyzVOYvVzlrR5zZHIiCFEjsuI/ly0dqzGYV1EYXQ7R9eRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(66476007)(66556008)(4326008)(86362001)(7696005)(186003)(26005)(52116002)(16526019)(66946007)(2616005)(956004)(8676002)(8936002)(75432002)(316002)(786003)(6666004)(1076003)(36756003)(6916009)(6486002)(2906002)(478600001)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4S9fwbrD5fcFTLGzHEihjKsXUicWwdasIq5L1mp5qn+b1Fyyy05Wlt+0BWwlDworo9baq+2KMjExUCXbBPKtHpZilvS1tvWZV/DlJ6pLYKXDM3hv62FBWjo7yR0bU9UzU7qXbwypZqPfzfxGJYvxtX6FQYYeXd3TAsYkUvcDUMBsb4OUFNGa+T93lhf/qlMNAdTxNFl0gx/0TXhtw/hIRyfSbhMjv2g6hlcA9M8fUzVYDptD6+RiD1cs3ZZVNoQrF6UBV3/ZJIOkoh5350ODYXB/Ty3jLWVuqGsJ/sHjgznlg7DOGLC2fgd/Xjt9K4P3L4/84Q65bgVhWG5L/eb7/8fxTJE0DT4vt14XxqMyiBfEzPKwNyTHx5EYB3Zl/PSy/pPFRP4oGSUWVhaJYadTap8IzndmSEFEGkl82OO2SICwEyQOU+0Oa0InRxUrS0unFE4Z1VsCAY39bhMHxgPu4+FJazKVifdipI1rqk4SJNY=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7b7af1-697b-45be-bd15-08d7fff01365
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2020 14:38:08.1911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgHIW/9ItKjnDJ36VNy57vWWpFfhLBM1XJi6u8K36el8gwQjPe9gmRZjrp5CKxs3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4590
Received-SPF: pass client-ip=40.107.220.134; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 10:38:10
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 docs/devel/fuzzing.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 324d2cd92b..3458763e53 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -45,6 +45,39 @@ Information about these is available by passing -help=1
 Now the only thing left to do is wait for the fuzzer to trigger potential
 crashes.
 
+== Useful libFuzzer flags ==
+
+As mentioned above, libFuzzer accepts some arguments. Passing -help=1 will list
+the available arguments. In particular, these arguments might be helpful:
+
+$CORPUS_DIR/ : Specify a directory as the last argument to libFuzzer. libFuzzer
+stores each "interesting" input in this corpus directory. The next time you run
+libFuzzer, it will read all of the inputs from the corpus, and continue fuzzing
+from there.
+
+-max_len=4096 : specify the maximum byte-length of the inputs libFuzzer will
+generate.
+
+-close_fd_mask={1,2,3} : close, stderr, or both. Useful for targets that
+trigger many debug/error messages, or create output on the serial console.
+
+-jobs=4 -workers=4 : These arguments configure libFuzzer to run 4 fuzzers in
+parallel. Replace 4 with a number appropriate for your machine. Make sure to
+specify a $CORPUS_DIR, which will allow the parallel fuzzers to share
+information about the interesting inputs they find.
+
+-use_value_profile=1 : For each comparison operation, libFuzzer computes 
+(caller_pc&4095) | (popcnt(Arg1 ^ Arg2) << 12) and places this in the coverage
+table. Useful for targets with "magic" constants. If Arg1 came from the fuzzer's
+input and Arg2 is a magic constant, then each time the hamming distance
+between Arg1 and Arg2 decreases, libFuzzer adds the input to the corpus.
+
+-shrink=1 : Tries to make elements of the corpus "smaller". Might lead to
+better coverage performance, depending on the target.
+
+Note that libFuzzer's exact behavior will depend on the version of
+clang and libFuzzer used to build the device fuzzers.
+
 == Adding a new fuzzer ==
 Coverage over virtual devices can be improved by adding additional fuzzers.
 Fuzzers are kept in tests/qtest/fuzz/ and should be added to
-- 
2.26.2


