Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03D5C388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E730206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="QRrCU9i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E730206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb69R-0005ej-AT
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb67z-0004OL-KI
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:06:23 -0500
Received: from mail-dm6nam08on2113.outbound.protection.outlook.com
 ([40.107.102.113]:7896 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb67y-0002XB-7a
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:06:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSPOEkNAUkB3BmOw/enmcfwo1Dy1lIgWaj0/4kK1JQxdVXCz9z+xXywKlocixm+cS893F4HAABr5lW4XvGTdWE5altR+EGF59LL+2H+J09D0D/5bK2v+PUIPkZBnMg1iGW1PChhkdMDCgMpC8amrFS0iZOyWCpY0m5JtPo5H3RxRWBGi3yJdP7abke4alIDBnq6WurCVgZX/NNJlSKkzMeXnSSk3A0tWOvPT9MooXdAvFMVuR3GNo3JS7d3C31+8FderaDITASsNp13o0jqMM/WlikMd7R03q6l0z7xoQQIFpMJjRzj2gDPkSxML87vp1Mm2Z2AIngGtZGY3D1XYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyhPZZfzbZ6n8E8xHunr/Hcu9QLMUCKw2cnDIVvxfEs=;
 b=XpFNKRhnepkfb0SM4JBczjAZdkhA1YlmUYka5+PQ1V8aLCMPUBs6nnQ/UQz8GIHo7PLdYlZwhDb1AWbKfOj09Ckdk36J9GhJ6v/gEpiOn2Fdi4IjqS9H9f1jQaIqsK0oTj5uyatGgUYIQb8lAVBEePCYBnAtLFwYl6AHtZwXtAfejiAHd5dCTasA7HMjLlnBpm8fzPHhfEeiiq2sQnYQ/qqeg3rfx1uD4DvqAG1qo0Tv5aiAiYbK1QNeaVGisFubRbXNF60y5+yeqpTf8vnCFO6i1EF9utCYVZj59jb82WMQtr4z/Z8I8V/kO2xM6UCzjI0mpnLrepdUwYYwY46aBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyhPZZfzbZ6n8E8xHunr/Hcu9QLMUCKw2cnDIVvxfEs=;
 b=QRrCU9i34nxS5c1rlAB9cf9PfGS4Pb+lizNiJZ6ODEhanCAYZVyLVCXkObP8b+JDJLD2n95GmSmhr4K3C9SOJ31Ptd64BuCMXoC319MbE6/sgV6zXjqyQt/sFl29I6q68dJ2lMacpOglkaZgK2WdOWi23VItomtm35eCtmenKoQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2207.namprd03.prod.outlook.com (2603:10b6:804:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 18:06:15 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 18:06:15 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] docs/fuzz: update fuzzing documentation post-meson
Date: Fri,  6 Nov 2020 13:06:00 -0500
Message-Id: <20201106180600.360110-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106180600.360110-1-alxndr@bu.edu>
References: <20201106180600.360110-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:208:23d::9) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR06CA0004.namprd06.prod.outlook.com (2603:10b6:208:23d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Fri, 6 Nov 2020 18:06:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc658a74-6904-4b5f-0f7c-08d8827ea6ef
X-MS-TrafficTypeDiagnostic: SN2PR03MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2207BF79B3D770BC7B2BACCBBAED0@SN2PR03MB2207.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INJvoQLJ4iUNK8dIvAOzVUN47PNs+RLTKee9t5J972utki6NqrO37db8B6BreS2QNzWc+gKRH23jtSXnE9MqXfthFWGGIQt4ipUeegLTKfDu6wnh9PcutOhMZSezuVkRQhJMpmOISL04FjwCPbNe485iI6QZsEcXwnI5MHJFCchLbDATqlHoCO/tJsY7n23pSxP1HHZ18rS8qYhTMffgT9CgWe8CXeoHIuNothMvLfrRpgDyQSIRnHsQGbkCFJpR4oIcBRRUJUEiW9PyYTLHohS9PwKZy5sC1Lypp3SrCLDBnjDfWFNN7AA+sVNLn5+J/2S3ztsj1ewqRX/emb9neA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(478600001)(83380400001)(956004)(786003)(316002)(54906003)(8676002)(4326008)(66476007)(2906002)(6486002)(186003)(66946007)(36756003)(66556008)(1076003)(52116002)(6916009)(86362001)(16526019)(26005)(5660300002)(6506007)(8936002)(75432002)(6512007)(6666004)(4744005)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AnfmkcqBpKBdsF5Ltovh5smugwCvxBqazTV1e4BqFafbEI4dtjn37Pml1wj6LP8xEUhB1rI3jEgmKp26uSkrGt3zo0QnwtwrfD/+KqsoQbwUioBCTsE1oG3MERH9M6p1xk4yp+2fvU0WzFSm6lnpE1lC2DSslt2RdHNKBgALHkywSXpTguyLcZyTN4Ruyv2mH+ibCb8vxe5AGbwxTFwK36wVmo1n7TdTdTAmdYE98iAW+oH18tXkLHqLvrIq5VsybfEtmBGjhFewrVKkjaCm9yyVT8WJuJstRNzi+oFv88AdNRUs+v5M7u/ZAEP37vNINOq6y8y6qj7HuAq4+mADLphKC5+N5iMO8MsO40QRv+rdZV1IhQQib7Z0TP1KXLd2snhZ5bMhZZeoe1sdNzW3PgYcpx2CVl6ZmBxAsV65TcERvu2MSntPHH92wxHRA/uiF031eBNK+nU0PosMcWexPvt6lDRTp0OyUMaGIW5CEPd/V10lLjOjGMVo8gGwbNRy8lABfOyBl/FPPYoF96Ew80rQ8Kv4fD/UkIHNC/PPff0UxbzMxh4MhyK+5ZFm6w+DHWtIeMyPwxly9NFMM2vwP1z6nBfhxLnsVLxso8DG531XE9oTSpy/IxLWHMMVGgD0nS2cYte3zuJ91w98amb8yQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fc658a74-6904-4b5f-0f7c-08d8827ea6ef
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 18:06:15.6057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3Jada2MnRjmMnnlyVkRH90sprM1jxLC0ujAFqW/qelff+SeVCaNaiYa96gknTAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2207
Received-SPF: pass client-ip=40.107.102.113; envelope-from=alxndr@bu.edu;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 13:06:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 docs/devel/fuzzing.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/fuzzing.rst b/docs/devel/fuzzing.rst
index f19d75ceff..6096242d99 100644
--- a/docs/devel/fuzzing.rst
+++ b/docs/devel/fuzzing.rst
@@ -34,16 +34,16 @@ such as out-of-bounds accesses, use-after-frees, double-frees etc.::
 
 Fuzz targets are built similarly to system targets::
 
-    make i386-softmmu/fuzz
+    make qemu-fuzz-i386
 
-This builds ``./i386-softmmu/qemu-fuzz-i386``
+This builds ``./qemu-fuzz-i386``
 
 The first option to this command is: ``--fuzz-target=FUZZ_NAME``
 To list all of the available fuzzers run ``qemu-fuzz-i386`` with no arguments.
 
 For example::
 
-    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
+    ./qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
 
 Internally, libfuzzer parses all arguments that do not begin with ``"--"``.
 Information about these is available by passing ``-help=1``
-- 
2.28.0


