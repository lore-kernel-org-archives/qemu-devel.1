Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A716B206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fnNFH3jG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A716B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtGHB-0006ER-T0
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 16:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtGG6-0005LU-OL
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:01:35 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com
 ([40.107.237.125]:6304 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtGG3-0007qY-GW
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaTphF4xznty9RrtmLRY9SnLxIibX9EhxR9VIBmi/8BtPKe73VbHm1Cqrx2DDI2nahsWz8ltBmjTDliRsXifUG8fQ1RkZAF2jddLWZLtfllfvvCztMrmQ8ttI9AJqn83pUD2ZpkL4jFbkUbQ0Ftlb9Y85ME4BIJcquAW+C95e+yTISWn9RN9wQFg68RxqNg/NAjrhqzkkfE7oyni8TzuACFqFQWaTiZbweOaaieaRkUXG5YjPc4+AVC4TAJRQWbfU2sO/vanfv0TqlNfSVGSXbKemqNB70Gcr35oaphwXVTL1+DpkU3p75ytkXlKKsG8gY0DmMXaC6M5HEDThTz7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcK3Oy+njX0hz5kYqQeLKc44jeqOeeSYFz5dGazp148=;
 b=OxFFFiWIeaV87oUlzs4Qi+5I71tfWbjHAI3NTS/XWwb7q8hj66s2WbppnyWfVlI3VTmTwQhf3iWLscZE1uYAjUtmSWHIyv8IrT2zJanXwQPSV1cBUH/AgE5TbNMIc0nJn/ZAeXlVdLEbxVtnCd/iwmzU1G1Mvdh3cO0K+I27iTeeMnxZmgImQeTtXvObldeuTmNPFlOs66XBjtSDnXwhPB1zqsaA5eeDlZFDo4A4TTnnFV0HTOAVCkqglrmb9UKAiCPpA17wMpLTuCbDTFpHLrCSGlE236kmq83r4jHb7ASzhkJvBeD9sg7BsUyp336U7dbw/yQAt5EAQQ/RadHB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcK3Oy+njX0hz5kYqQeLKc44jeqOeeSYFz5dGazp148=;
 b=fnNFH3jGv0+SzGcOAWa83bPDdidGzwfz1UvSK9grVBbhhSLYRi5iLcd4YNhGhloNNNIHX/RCnM8tF0tAkPqcE9XZdu018Q1b3/HUCoxlj85cdACBVFcurG5eSTvfihEaUlgDTq8/U2m8HUeRIRBHFsv5NO5u5Uj7qYnK24kYEq8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4272.namprd03.prod.outlook.com (2603:10b6:805:c8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 8 Jul
 2020 20:01:26 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 20:01:26 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 1/2] configure: do not clobber CFLAGS with
 --enable-fuzzing
Date: Wed,  8 Jul 2020 16:01:03 -0400
Message-Id: <20200708200104.21978-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708200104.21978-1-alxndr@bu.edu>
References: <20200708200104.21978-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:208:23e::9) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:208:23e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 20:01:26 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a3f1cb4-ebd4-4dd8-003d-08d82379b25f
X-MS-TrafficTypeDiagnostic: SN6PR03MB4272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB427294204B40127F3C7D0E3EBA670@SN6PR03MB4272.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iF15z6UxkL2GncUZz+nRinhhPs4zbn2F2osw2xOVMG4GxaqfBWcsxkc+4xNi+ZjjFCa0YS68ZVjTNcaUtj6eVRv545beveCCct0rT6YSZFBO9rhCO+zmTla5OwZWynySn2TBV+zQQkFu+KLWEyFRHazex8xVjcvWNEZ98XJHIE4MSh0CWhmwPbUCNJgPhkTcqg5cd0XyQjAIBXCDR9Ig/fwh6Hu5l94TShAo67OazsGJH1/P9XIkzqWF/L3wuCMOuyI0EPtBhwzsm9hfqaPh77ZvLm+fsQYx47qafJ8rgnP2MD4zWbvTsL0jql51AfMPxzga6DJTf8sCJ+zlDg+xOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(6666004)(478600001)(7696005)(52116002)(66556008)(66476007)(186003)(2616005)(956004)(66946007)(26005)(316002)(16526019)(786003)(6486002)(75432002)(4326008)(8676002)(83380400001)(4744005)(1076003)(36756003)(5660300002)(2906002)(6916009)(86362001)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FU/ddYy2OPjg8WGqO/diVbkQ70dpZYKqykyAf8TQviaE0PKbXaV2EaJ1X9+21wi6jnwGo+WH6l7qEVTMK4ULL45cfuahais6qLVXuh2s1DeUWmCOtutFDHdsRjwNVU3Ol+Py/m9g22zr3+GJxWJlLXcL1UFQgEMqRRHTKfJzSK0k2Ck0HnbwDaI66SbO6l15mu0iSDBEtGly30kwoXhuhjPa3tOqbSYMJf5IArZc5mBCypbGay711He8KLrkZqC0eYAqoJ9Ie/OZkB+NjhbrUp53pj0FLCsJFJhs2lHU9uKE1GIkZvkXLCZFecE6e1M4ReF4HakHBYr7HJmN0mP1W/jN/gUsKLDPuu6s/q+4RhWmtFXgOSXroilDBjn7X4iK3h4IMKJHqc+CdNX44biDzo20J9a6jMWwbD0UKTMJ+iCoHJV8dLCsvtsGqAg8+5gt7zi0X36yNZ8ejia6J0il9m3fmYisXDigHS2CvqKKm20=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3f1cb4-ebd4-4dd8-003d-08d82379b25f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 20:01:26.5939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Nyp9x0FFSX1R+4+iPTheF37lWjRRl5JkYHTcEGGPTdmd0FSXw+CBgBcSoi+PWNC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4272
Received-SPF: pass client-ip=40.107.237.125; envelope-from=alxndr@bu.edu;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 16:01:26
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
Cc: liq3ea@163.com, philmd@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When configuring with --enable-fuzzing, we overwrote the CFLAGS
added by all the preceding checks. Instead of overwriting CFLAGS, append
the ones we need.

Fixes: adc28027ff ("fuzz: add configure flag --enable-fuzzing")
Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index ee6c3c6792..078ebaa9f3 100755
--- a/configure
+++ b/configure
@@ -7898,7 +7898,7 @@ if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
     FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
     FUZZ_CFLAGS=" -fsanitize=address,fuzzer"
-    CFLAGS=" -fsanitize=address,fuzzer-no-link"
+    CFLAGS="$CFLAGS -fsanitize=address,fuzzer-no-link"
   else
     error_exit "Your compiler doesn't support -fsanitize=address,fuzzer"
     exit 1
-- 
2.26.2


