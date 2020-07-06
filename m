Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8599C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8624C207D0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ovzcMMtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8624C207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXEy-0004oA-QE
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 15:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXE1-0003Fi-8u
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:56:25 -0400
Received: from mail-mw2nam12on2126.outbound.protection.outlook.com
 ([40.107.244.126]:37345 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXDz-00032S-CX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:56:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVfYed6NJ+xGvJSSsBUWBFn+llzxP/UNO+uyHGZ5cPLH1S6u5PYIg/nqTe4eDN7WMZFHe5VvNzQ5NZEjcApemkCGI5OUcZA6yF6O3O6YBCwGLqIdJh4TTkAo3mfpEF9GShPWLAmJliwUNBnP99jm4P4DTVdXrNfFXnaZdJz6aeYl0kuh0WdrKpnLqXZ9iItaYpVLAMfgSg9mZpt/DLmoomC1Bc7t6zSZAbP2q0SYNlEB50O3+5vQ6I1z72T5WmbJYLTOd+3z5khZuKMYLsoSGgFrcgeAIaDOIVwBkKbz4wJ9J4Yedo7aVO6pN+YtYgwfgS78QcrLHyJtgkPlqTCFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsTdI6r2+KgSYYIBcSUuhcXd3d4BZo2yDSICQr8IhfA=;
 b=PQnB2DzQhmYFn7Dfv3y7wIguNvKWnoIbjVdsDP+C1EVXdHXAvQvhhW5lO4n/On0uhl8YowQVldbWMHveZsFt6MK5FJWJd4TcFOgwE4nEQA5PdG05qVyOOQ5JtaaQCqCnxImdPJGHJkePvOehT1y+DK/7VqvRDzjf7UdTIFQtnbDuY2h7JLAuM1oEqizvtTPR0XjOaMZgZ6vDlHPyyxJQ9OJKqsIQRuAn1/bgyOvJye9SGkQsTXW0hi1TuRQ4ArsHqt4tnSUBo3kSuXDB1lE7w8bjkjE/ZXQabKPK3Tml6ztFcows5caA1/zTY7hq3rPZz1iQXhG76Em7lRxaZ4tiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsTdI6r2+KgSYYIBcSUuhcXd3d4BZo2yDSICQr8IhfA=;
 b=ovzcMMtwx16S8/8OgXqCBQ2cy31Dp6Wzgoyi6M8zW0nOKj25XAXp8t6XtIfijCcar9DoYqkHze9FybSpqzpG735zC6zu3rd30iLuca3aQLHLnwNofGj2doxdQYG2ULcj0VXIEfi+ST84B1lwa+qyGkgo0H3UsZJ9YSklszNsR+E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3520.namprd03.prod.outlook.com (2603:10b6:805:4d::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 19:55:46 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 19:55:46 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] fuzz: build without AddressSanitizer, by default
Date: Mon,  6 Jul 2020 15:55:31 -0400
Message-Id: <20200706195534.14962-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706195534.14962-1-alxndr@bu.edu>
References: <20200706195534.14962-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0142.namprd02.prod.outlook.com
 (2603:10b6:208:35::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0142.namprd02.prod.outlook.com (2603:10b6:208:35::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 19:55:45 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8eea77-bfc3-4a6e-b553-08d821e692d2
X-MS-TrafficTypeDiagnostic: SN6PR03MB3520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35204F31AA531957BF8EBFBBBA690@SN6PR03MB3520.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gP5y6XVeTBOplkEYWCEfAdblt5vXY8Z+Huu6yvckPw5mnDz0T226Iu2KVBAq/AGcXch2p4N0mTVeH8zS3M/1uBdlLRz2zFqDCerHDO/szKA9pU+RFUFicsQeHAFMJ5kBitv5khXxbjIGR8LAq/U94X2TUKWoLDuPh/e94WYlPBgjnFVTmbIJOnr6qcz+eGFkjdS9t22rsHmQPu9nVIksuhurAROu7Q7tQOCvXgKqtZ4RVPTzmsCVdtKaQZCmZ/9EeaCkm3F9gjYGiehH+CBcw6ahC0CBk89Fvk44Ol234SchUBbFA8+Hh2TE8TQQ6iRrlmTpW8VsRcVzBRlE4UOfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(83380400001)(16526019)(26005)(8676002)(66476007)(66556008)(7696005)(4326008)(786003)(75432002)(478600001)(8936002)(66946007)(1076003)(36756003)(86362001)(52116002)(316002)(6666004)(2906002)(186003)(5660300002)(6916009)(6486002)(956004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VLclbXwiRjuCHFlW9FXsEY1ktDXzx7AWHHRp6xE5OoVYgK/XRESO1F3+IehxJeqAa75OK/N0G7NWCkIscrHN+l20SQxGvpreijllrg9JsaAxG5tjGpDVW6WGUAZXqcxxz46bEHclcTQsHDhijTKIXm6dLPTLL7017wkUuX1Nvrmf0r1AngvuNS1qXbS62LbrZhI5KyhPNiJxZMaerfm0NeGT+NZ/nWVZi+yT/a0BjNUXgDNSzJRlwCF5CH9jRaNWR9k33oZYc8BEaQFAA6gACd7k3++4IoBzO6wyfgVoI0U5yP+fOCR4wDxkdDnbd52HsCxBgncRS4T+tlS0YvyxPrD9+W7/IR6nzdpP6ugKV6EMk/QSuhaFlP+5M1/MdB3NQqxBbfKt0grpdZLbZNqmhS53qBBglL7/PrN9N8LgYgezmfIUAesrNa3yXsmUL4v0eGHOlPZ4sGvCsm6T1IGwhEtrK5oJ25Ob0xYWBrb3jdg=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8eea77-bfc3-4a6e-b553-08d821e692d2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 19:55:46.4411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quYUlahpIIJW/txDwHCHFTWkJdXkvyOjK7QIKDPAs4rXW0cGKkZpQ/ENZnmuhxgm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3520
Received-SPF: pass client-ip=40.107.244.126; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:56:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, philmd@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have a nice --enable-sanitizers option to enable
AddressSanitizer. There is no reason to duplicate and force this
functionality in --enable-fuzzing. In the future, if more sanitizers are
added to --enable-sanitizers, it might be impossible to build with both
--enable-sanitizers and --enable-fuzzing, since not all sanitizers are
compatible with libFuzzer. In that case, we could enable ASAN with
--extra-cflags="-fsanitize=address"

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 configure | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 8a65240d4a..010c0ca479 100755
--- a/configure
+++ b/configure
@@ -6319,7 +6319,7 @@ fi
 # checks for fuzzer
 if test "$fuzzing" = "yes" ; then
   write_c_fuzzer_skeleton
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address,fuzzer" ""; then
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=fuzzer" ""; then
       have_fuzzer=yes
   fi
 fi
@@ -7858,11 +7858,11 @@ if test "$sheepdog" = "yes" ; then
 fi
 if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
-    FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
-    FUZZ_CFLAGS=" -fsanitize=address,fuzzer"
-    CFLAGS=" -fsanitize=address,fuzzer-no-link"
+    FUZZ_LDFLAGS=" -fsanitize=fuzzer"
+    FUZZ_CFLAGS=" -fsanitize=fuzzer"
+    CFLAGS=" -fsanitize=fuzzer-no-link"
   else
-    error_exit "Your compiler doesn't support -fsanitize=address,fuzzer"
+    error_exit "Your compiler doesn't support -fsanitize=fuzzer"
     exit 1
   fi
 fi
-- 
2.26.2


