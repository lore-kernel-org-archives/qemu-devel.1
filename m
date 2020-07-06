Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500D8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF70207D0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="TjnygGXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF70207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXG8-0007JA-E5
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 15:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXE3-0003Hl-36
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:56:27 -0400
Received: from mail-mw2nam12on2126.outbound.protection.outlook.com
 ([40.107.244.126]:37345 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXE1-00032S-HT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmYRqS1PvcCSDMptEe2rQL7E+7x5CCDz7bxc30xGaNd3/uf/9+fgq8rV4HoxTLaA1RPxyupFp8E0sVx47Lcz5S8benxoqt9WMJ4uKu0zfyYAV0Jlq6Kb34NWwRjx7Zlz3tuaPL2vgX8RlM0eYfwitvS79hGkMkxT8esbOdYTSSiDMoaA7kDRTRCP1hMbShTcjvMDaTEL/7uj7v7AktLHAIOfwmfBZDJ9ILf6dARBylsakCtEWcEuwPgA+fnB8CIIGJccPHscpVEOobFdlmQOFLB5popFBvciW4M446JWiFfximIltT8LTmGEFlQPwIl4Ojym+ZBXA7ca3n8c/nxHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81P0xTiB6eYwm9dM3xLP3FIv2owOKwkJ7xlolapJBlA=;
 b=bjIccojg/JHc9Fo8KbaKgif935bfy9/AIfx9BcFGWIH+oigA0tfERqE1BoPKwLWVP5MUxl8Rw8t2BAh0d3qVFby6ENNOJHz23lMw5Jvv2khHWU8IQ+Fxe6E0WvMd6I+8nWvgyRBg+smmv8xYz0KyYi+3xZt8IQg5ecL8sWYXWrWedwfPnN9K0lcCpBeCCJ80GGj8UBeb8HodrUxmFe/waLKaHEYBQOf19ROyoEqq53GqZIVnwhsyZp7Jwlsb7UcMZUG6UheQu8f+jmOjbJgGKwTBdr5PltHmeDj4v4iM0mOh282ZOOvdSByQc+XovcpUvRoL39m0y3Hi2t4iItCgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81P0xTiB6eYwm9dM3xLP3FIv2owOKwkJ7xlolapJBlA=;
 b=TjnygGXPLHJ34hlISy/yf+JH4c9iNA3Az2HGcJFZhNdJh8hQMEkeGHEy7PvSamsdYXB85oV9WUmweuM8HmD3kou2qFVtBsXSsJkmJ558i8uvnFbsaak/g14q2cOn7xCgvYlx6l4x/ulgBgDZi4qUKKQoiAvFikyfcrO9xumO51Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3520.namprd03.prod.outlook.com (2603:10b6:805:4d::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 19:55:47 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 19:55:47 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] docs/fuzz: describe building fuzzers with
 enable-sanitizers
Date: Mon,  6 Jul 2020 15:55:32 -0400
Message-Id: <20200706195534.14962-3-alxndr@bu.edu>
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
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 19:55:46 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea6e70fc-1b63-4c04-4fcc-08d821e69346
X-MS-TrafficTypeDiagnostic: SN6PR03MB3520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35203968FA11244261C24AE4BA690@SN6PR03MB3520.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wy/cX33jxLUeOcUQUQJ+4ojiWQM6QnCwDrhqhsoi+cU74kLHTE9jfWf1HQzm1FXI15OPKFUp05SQaPy8s8v8LRgvDfcOOFG5P5jghYolbMpLKhADV39EACaaEtb8P+ILwUJ8ix+tVbKOJZQdjwElJTwzy2dwDAXaGjkgEcssrkY7fQV9j+YF/HWU7wfGlbBsKQvNa23rndkX+7axC+/up0Pg5TGfS7x9MIi3rJZuKCxB+Y27mWTTBDBwTvCi1kMHWiGAenL4hBYvMaaGGsxp4JbibKz3qWhOBFY/jrnpcc6sNqHIA/xXSKR/ZhZk+TIu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(83380400001)(16526019)(26005)(8676002)(66476007)(66556008)(7696005)(4326008)(786003)(75432002)(478600001)(8936002)(66946007)(1076003)(36756003)(86362001)(52116002)(316002)(6666004)(2906002)(186003)(5660300002)(6916009)(6486002)(956004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oN8UrO0woKNYH5ClHi5A/8Hkc5DJ0tVswivl9UkqQ3pcJ0bHcaIBnQrWMk1BZl/MQTQUIiOySGAcm31cEmXjIjDFwQQb6pqFT3cUR9qC6e7AHTBQXd2nRx4hZZ29KJooqzoW/RcmEMNN8XPEMuexuPUG45aSg1IAHP1+qLtZDenHRe9fEZv7TA2GWIxrOlk+pUzDPnS6GRBnISXqbzBSUAohrZ2+qBr3GpClPFyztE8OGNZnVdeIQvAHfwiZFS5LUEFpsHB1+1fxtqXscUw1dOZ5Sn3DhNh12CxNVTSqERArPakPmkjeY0id2RZB0VtuSgINpma3R5tj9qhth2/bjdF8K++l6wxyqlsXU6dkIHhfA8ijQYUWL0wFE4JaR76HvEQoXF5IWXWhRd9fRQCI4X6sKOtcXrrBz88Kwz/BNainGqXvyXHi+H7zWtVr/TRy+SWxwpO3ATEW4PJhUbYkeQadB6tRNa23WJcqcuHAwLc=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6e70fc-1b63-4c04-4fcc-08d821e69346
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 19:55:47.3476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z3AcKgtLx9Uo2KHBpOiq+cuwY2KsuvlZ0bi20au+6Ty++ZqlusR/+OSKuu5ezam
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 docs/devel/fuzzing.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 324d2cd92b..382ade974e 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -23,9 +23,12 @@ AddressSanitizer mmaps ~20TB of memory, as part of its detection. This results
 in a large page-map, and a much slower fork().
 
 To build the fuzzers, install a recent version of clang:
-Configure with (substitute the clang binaries with the version you installed):
+Configure with (substitute the clang binaries with the version you installed).
+Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
+such as out-of-bounds accesses, use-after-frees, double-frees etc.
 
-    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing
+    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing \
+                                                --enable-sanitizers
 
 Fuzz targets are built similarly to system/softmmu:
 
-- 
2.26.2


