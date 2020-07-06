Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B039C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293BC2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="CStK5Ofj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293BC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXF4-00056m-EC
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 15:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXE6-0003OJ-QW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:56:30 -0400
Received: from mail-mw2nam12on2126.outbound.protection.outlook.com
 ([40.107.244.126]:37345 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXE5-00032S-7k
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:56:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSsMvOoLbKcmHHFRKliWgdrxenvyvXIRJn6iEgT3g1tG1BclxP/8e0YZrznXRI+VjthLVIPf55zMy9eann7BnItSeDCxcSjcXqL1n5YS4xUDO4+P2buvqpn9sNdCdVNhYzWMWcCDBB2bvzI2xwefOAktN0MJ0BX18z4c04gFSmgYQN4z4wtHuHuyHt+Ae/6UgslCSsoiANTfMsZ+VboxrkeT98hVIU0a6oMLyZ6oKr20v9JbkFxeFWqDUrTTzWWWV/DXOE4qw1rs13Eg+8jEkpG3fyDhuU8Jd2gMHe6mnufczWqc6Lv/pGzti7TtI30SRiJlyfvQbeT84wQNrUG6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXDB9zLidv5j9OknXJbWv5mw0T0xEQ+ky2Ou5Bv81u0=;
 b=gODHuTJVgDmQN4bgxHGBsh3JzccN19a6Q3AIOd7oRFac6R6E6i4wihD6JSNtV64LU03lL8jzmJlSG4tx+uwBrgCDqorUX6sJmhlB9NIaLzkepW31GvMJd8JAumt+HNBzjhhOvZo1b/seuoiicglbSaulgoswQDvMP0j3aSkBYPuEW/Zk1SDy15zrLY86UvJiWoP93k1UdeEhm9ZQil368uQQxLqipGzf4Dzl1Xz7ncos/rSRKmtliWU77qlIfiD1z0wH+nAr22dFDwvNHOR7uTlqbWBFS4Xmzlua1h6SFD8i8XhBq5Ndbbkw61leYI+0fUl9hFkvOJprAqwO8HiDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXDB9zLidv5j9OknXJbWv5mw0T0xEQ+ky2Ou5Bv81u0=;
 b=CStK5OfjHRrGfzV3xSbvr2JXS9TmtavtQasOtFY84d28hQxhcb1PRKWhxPK5wRwQkrStzanTi/wzrEObrFOUBz7Zb5o2tw1Zc123KRr+mftVGGfWgjpDh7tAQWDUYKOh0M7n6ecuwWqa8uqEeRvXHqTmnGSGs79xTF9xBOKEBDI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3520.namprd03.prod.outlook.com (2603:10b6:805:4d::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 19:55:49 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 19:55:49 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] docs/fuzz: add instructions for generating a coverage
 report
Date: Mon,  6 Jul 2020 15:55:34 -0400
Message-Id: <20200706195534.14962-5-alxndr@bu.edu>
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
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 19:55:48 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ea5f1c-4a0a-4474-3c3b-08d821e69468
X-MS-TrafficTypeDiagnostic: SN6PR03MB3520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB352009FC209589FF56A0375EBA690@SN6PR03MB3520.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxDuW013vZTgU6zH3XBtSwJ5m5lMSt64RGixa+EQpA49SmLwtIi6If2iy11R4OwwznLPjxh579ydZxRQdXQWWTJwTV39r0pepJBPa2qLs0vVc4NPWb4JwIeMWT705k54Y5+lVBhbdWKalzVRvw9n6UtqFHjmxZRMYVKjRIHV2Ldl6lr8c6oPfcbrl96DpEIqEiwE7OVswzg1LcZd0fP89gX6DlvIMQmkDpGXHqD0j3kPvqJS1nTT10wcaMIeAwcJmVz0AMIpLvMrkQdITGwXhiBy9OHCV00QAdWx54l0/E04//QHzvEp1wjSuzSttA7mvufw7XAjgc2NeUJj07Mc9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(83380400001)(16526019)(26005)(8676002)(66476007)(66556008)(7696005)(4326008)(786003)(75432002)(478600001)(8936002)(66946007)(1076003)(36756003)(86362001)(52116002)(316002)(6666004)(2906002)(186003)(5660300002)(6916009)(6486002)(956004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SyuJXLuFBf/X95cLHEqvS2I+4rjU8+mX6H/PbeP13RTUAqqgVmC9hlEkdsekntAIeT/jPh6iRPSBNEN8LgnRSoZs85Ny8kJ0DpnSLBT3D61pNmvjMtWr3Oe0oCdh4Nx1vWN9MuTR5ZkHVV2+KihNJtYYjY5y6mn4pIRRslQ57qx5KI6yrRmo8MzSZlvCfUewlQ6l/5M/ZdX+59NPg9CfActVMMFXEtg0hO8FK02kt7dVAnlh9U11zA6PEr0iFIn3rivp4JEWFEklO9vOc5A34yizexr8fdaC/ruJPHhlkfRUh7F2xcRyZGkCKQK/w+Fy9ghaqbP5YaFxNRWF3imr4qZyYcTD2wdbQuPp09aDKrsdpvcPE1s5U9Lppjhz+x4/+ljOjlrQyLsR7Di1ntuvdHv4lDg9juk47xkEZr6L9qs1QmPK+KL6i/L9E3shR6OznmQ0jNJTJwVfItgDkNeOfVWJM7DWytTgYq7ZEQtGgX0=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ea5f1c-4a0a-4474-3c3b-08d821e69468
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 19:55:49.3256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7lDkZimlQDU8RgaxJVmQbEKn4xhVdB0LH/yrAChXR7jaF6e7fZ5BBrVeKpJPZfN
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
 docs/devel/fuzzing.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 284d57f8fd..a9816ffce9 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -85,6 +85,25 @@ better coverage performance, depending on the target.
 Note that libFuzzer's exact behavior will depend on the version of
 clang and libFuzzer used to build the device fuzzers.
 
+== Generating Coverage Reports ==
+Code coverage is a crucial metric for evaluating a fuzzer's performance.
+libFuzzer's output provides a "cov: " column that provides a total number of
+unique blocks/edges covered. To examine coverage on a line-by-line basis we
+can use Clang coverage:
+
+ 1. Configure libFuzzer to store a corpus of all interesting inputs (see
+    CORPUS_DIR above)
+ 2. ./configure the QEMU build with:
+    --enable-sanitizers \
+    --extra-cflags="-fprofile-instr-generate -fcoverage-mapping"
+ 3. Re-run the fuzzer. Specify $CORPUS_DIR/* as an argument, telling libfuzzer
+    to execute all of the inputs in $CORPUS_DIR and exit. Once the process
+    exits, you should find a file, "default.profraw" in the working directory.
+ 4. Execute these commands to generate a detailed HTML coverage-report:
+ llvm-profdata merge -output=default.profdata default.profraw
+ llvm-cov show ./path/to/qemu-fuzz-i386 -instr-profile=default.profdata \
+ --format html -output-dir=/path/to/output/report
+
 == Adding a new fuzzer ==
 Coverage over virtual devices can be improved by adding additional fuzzers.
 Fuzzers are kept in tests/qtest/fuzz/ and should be added to
-- 
2.26.2


