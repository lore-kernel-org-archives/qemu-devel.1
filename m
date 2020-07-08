Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96861C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67071206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="QjmQ0zuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67071206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtGH9-0006Bh-HJ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 16:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtGG3-0005LA-Fy
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:01:31 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com
 ([40.107.237.125]:6304 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtGG0-0007qY-OW
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:01:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu7jYTug9Q+pYgBBRNEvCdMH6P2wxolXC/6O/EOCJVUWVkycozJ7SawwQmW8gdOohOHp8XZyfdOx16cDVwfWVea7vN0x80zkiAu8xME3PGhh0vffolR/Ryw0oHnf1BArdCm3HsolhTS6MmtwSGJreLdST7NUUnHTeeTEYUHl3ZJwxjtMitn0WLHIv5bvf8OO4qOBQlbBWnwZNmZpg3pH6fQBsE3sApJujf5wr14HDvvG9vZmTb21sRc3/bekT2zKAOZOUL9QBOiT+45pNJpi/hMOX+rF6iyzXCBwUQz3qKQbftmtSY1QsEAPxQM1v9/wg9EYkMRZUiiR86Cok2OQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8MXYdxtmaarr4rkoM2IttDd7gx1f2XL9VQS90KUP30=;
 b=eVWaCcZOLkN9t6DHNEy6b2xdHmXoTKZXQtx1VPAePZ8FIULI6OzZ+RP10rCYzWAHHzIAjlgmrgRuw8RrZit/+dFWZOiiUcammAws/aypq+RIly4V/FO+h41DvBjD6bGOmOWFDAiog5SG1x5Xq7Z86qJDL3odgtisxd+Tg4yc+s4njnRVDLvKNUk+CKRvuhpmeLl04q8r7JzECckqzx4+O2y+PtVx+F7BDpaIHVKs+8G9JkUGfuWMpwEVNeCuQRGPUYi/75gglz/hE+YJBx8pvb39Ik8D3ZqEmYe+V6fali+owM9lrxFMwp5ahAT+LojDZAtinrySoJoXUa99GGD+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8MXYdxtmaarr4rkoM2IttDd7gx1f2XL9VQS90KUP30=;
 b=QjmQ0zuObCqjj+AMmKFjeJaI78wu9UWnYtNrQIPUuyp19t+m4PN38FoReMV6Ikiz7ERziVOgdR0i6yCj02GsPiysY4K0r0fFziotSzYLjTcuD7ayWn8I3X/DbbqetlflBJ/zXOrtASGF8EbGo8yP6iF628McTk1x9N/YbYcoZNg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4272.namprd03.prod.outlook.com (2603:10b6:805:c8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 8 Jul
 2020 20:01:25 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 20:01:26 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 0/2] fuzz: broken build fixes
Date: Wed,  8 Jul 2020 16:01:02 -0400
Message-Id: <20200708200104.21978-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
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
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 20:01:25 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d5a9800-b100-4311-57b2-08d82379b1d8
X-MS-TrafficTypeDiagnostic: SN6PR03MB4272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB42723D32E577575B65CE8B0DBA670@SN6PR03MB4272.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoHwOnU1Og+ypyseXCgteuspQrlUguPF09aZQ5Yp7ZERDkWTbJ4GtW3QMssQmYvQkKcnUruFl9q9dVaIGPxX32LfdRIph1JlG9y1V2XiRYNO87LcY6PctOam1PT03o55EBsEXGm1CQSmjuH/qyEFZE3XrpqtyX+FImB17A8vD6flUNNDELzVLI3mUi5sORZmI5Bc49KOwsWFFEbgkX9CXsQBXSMCZc/en6ZtK3byrKarXCA1tTz1Iz5nyVIKBFiVS4717kGXoC6/ZNIBvELzrL6hzocw2gHIm2/3he4NzD2CDPLcsGIyi8nULNSYNISZZB9HV7j0aAYhtUNIBk+MFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(6666004)(478600001)(7696005)(52116002)(66556008)(66476007)(186003)(2616005)(956004)(66946007)(26005)(316002)(16526019)(786003)(6486002)(75432002)(4326008)(8676002)(83380400001)(4744005)(1076003)(36756003)(5660300002)(2906002)(6916009)(86362001)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4hUT8cZbG+8rXISIH5XGcMqqWbY9cxM2FwwK0hKzdvwMW3wlrpmbV5qf6GzlUszX3cSLumjwAtUZ3Q52lesGyN9dFTHye60X5soYR7dWAP7eMxDyHq4TJFlfg/ltJlojeN2BtrhYjc26X5gO9nugVQPyy8peubBtR1cL4k4BBXvOiMjWzMGbUTzOZ7S2XA84hNWgrrVDfJtCEauMv+s92FVqXs2TFZibdTfTd2d/sCr20eK7XncT+82sdpLtR/v7yh2AwZcIsHUV2d24qW1Iji0KyIRemV0LlI5omTTqCKr1enb9pFSyhcorSOaUF/d0WH0Fry6bA9iXfxGLQqoTJ5ybwLHZe6IhIsjr4FleZph7r6akII2Rrdbr0UrlVygOirVTkRLrxsw0uZ5SJrZd+qVzUjmHFmFH9fjupgk5WCJmxfQ4iooLJzfr1UmNZXzwVaba+/mdr7b4FJI56/tMSO6NRPYKlL84Y5ng+3HTEZY=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5a9800-b100-4311-57b2-08d82379b1d8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 20:01:25.8193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I4FbDaUnui/i2FMu3Qf/iWV7L4KpbYwNL0W2vk+mYge0GXH+ZkpbNdnRv90+As1
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

Hi,
These fix build-breaking problems with --enable-fuzzing
The first patch prevents --enable-fuzzing from overwriting CFLAGS.
The second patch adds a missing header to fuzz.c
-Alex

Alexander Bulekov (2):
  configure: do not clobber CFLAGS with --enable-fuzzing
  fuzz: add missing header for rcu_enable_atfork

 configure               | 2 +-
 tests/qtest/fuzz/fuzz.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.26.2


