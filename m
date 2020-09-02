Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE75BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E817207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="QKKrJfeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E817207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWhs-0006aA-Ib
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDWh6-0005gF-BV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:37:12 -0400
Received: from mail-mw2nam10on2114.outbound.protection.outlook.com
 ([40.107.94.114]:28257 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDWh4-0004ye-Gy
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:37:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OacrMk80JWiN8I+j67uJcT1W2cF11zdbG6Gq01EQTKt7188f9uf3mHfBOIYhxNSxVlDGGZEgjz/GaVRaKOXlrpYG4B+EYcxmiBrEsa2vyIURo78HPxE4qdfloBkpe4XHEift1lWZMo0ZQLqHY2SGQtYOQOFiWsLrd40NmabidsAZIWToh/lMjnZ3PF0d/MXgcj0n3a5s/5AXtE025FNosmdJ8pyb/u/AfMv0+TsFsxriFYPtQ0+NHGcpawjWgum5Y5Igfgrp8bAVvux3exUL7DhnE6lQ6eDalp/2cl5J+F44GGxcBvCyYaVdFcQbVAVsH5B/BT9yD2FTjBEuuQ8MLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boB2OTZy1jpQlhFZ+Q2AfSQwuLr7aEyu8nhsxOZLiHI=;
 b=J8yuHKRjkoo4OhDu+1n6trQqWnImS9HXdXPvEB3/5lyUioxipaBrGKgnk5Vkdw9cIRUqxc0+SXpOUx3Y/VBOPM4ebvOYLJL+Zp50u3F7EUlIBZMJCqlNZCGSzTtGDQtRV+34djsxV8SY/yNdY8oDNM+/UxV2dVd4pbxCE8K9E4fWTEWXEfIG/i0I8iLL2lPkZqylwBVKcnFAWC2cYitBXrIXyr4h67Cu1AYq0WfvyK/ixTaLZeryfE3e0sXJMsQISBJnx4YDNf0kb4+/8B1kVsuVe7FWb8eZjOaQDkfP7H/yJMd0H49tUwkYimZlDkQjCu7etCFP3wRewjo/cma0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boB2OTZy1jpQlhFZ+Q2AfSQwuLr7aEyu8nhsxOZLiHI=;
 b=QKKrJfeGIyNPbgZnhW9vz6aQGOGbyZDHlpmOxV5bezkQi3S2bmj7awmvpbYBB4ClKhPNhBSWBsKhL8g+Jqm/pc7w83KtzH8ytfPyP4bbV+vuW0Nu9+MS2Z3xtRxsADfFqb9gXs5KN3K2MWQhFvw3EnLJKrq86z1xfNvyK72xn/U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 17:37:06 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 17:37:06 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Fix oss-fuzz builds post-meson integration
Date: Wed,  2 Sep 2020 13:36:49 -0400
Message-Id: <20200902173652.307222-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend
 Transport; Wed, 2 Sep 2020 17:37:05 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7964680a-bbd7-49cb-59aa-08d84f66cf43
X-MS-TrafficTypeDiagnostic: SN6PR03MB3871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB38714F1A8187003E7F586CCBBA2F0@SN6PR03MB3871.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HzojsPBTC8BOWNm3wCBcPQCe7Davxs5iZDNAdlngI+lIGvvjD3R1Go99Y1l0Ba8svypw/3B9uvfwrnxZNbwpGlkZxwUFyjR6NQcHsJmuf4MLfG7OCdxtuk2s8PNb380WsdVSnRv2eUyUwvpzgGDy71xmDgXYgZv8JpzgkrjvHKF6wkchsJv2NVW5FKSEPeiV94tvTGUmT+xzqgNpkCv7rMANRKxFUijqKC5G21roiMIzXtlxVnQA1wRmfGdi0SlTU7YUuyLeYwfWXF5psg2d1N626S/CPmZlgtFds9m6srieNIYK3f3shmhw3YJHFKQSbXgbVO25FYRrZThGaA38CbqKM7Oxn2UKXrgmFXL++LJeDY0lWt9Tfy1O/9D+cu9/h0UCJk701AGnnHBWXwcCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(6486002)(2616005)(1076003)(4326008)(86362001)(66946007)(956004)(36756003)(66476007)(5660300002)(16576012)(66556008)(83380400001)(316002)(8936002)(478600001)(2906002)(52116002)(186003)(6666004)(8676002)(26005)(6916009)(83080400001)(966005)(75432002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cNRxf2p0uAvMPxwTisjmfyaS5IxLVn/6jgiy8tZ1tqME+iTNMMBQkCYkMtc9kniHd5DD11KT+DAft7oyklGTgYHHI1H9Ifm9JuQqyFc48tCrcbdIT+Ybj59TZYtYF99jRog0EAIEOwuvDbn1xII9+G1/ZpilFOw7bvjDGAKqJFM/Z+Zwt5t+Hu5DMQojoibSQtAEuQ6IE3RR2L9PvzZBsJNUglIoy2k4kfMAake91n+mK+JxfdsgI3ec9eGoDQkPY4rioTJdECm4O2uW1bwvfyf2Qsgg8f3EumTseW9VNlIqCZ0Bs6bu43IQYeYIb9CIs39/Msz2GtEiBMe+Zocg6pNY/AJvImJ/71IhUArK3DvXRrnyZbOVaru1mTmTpEiEym3KQ20BhxQZWy7nKjFt8adkVDaPJKBq6JBzM+wSeVCYBvaT3ILb9NujfmFZJigQbDrvL+xlmg+KnnuAfP3/afpwAORP7/hS/ovuPUe1zt9SQ3CzCORdJtjTlAryASnCw63pS3LckHQ/qyoApWW4GZiyFLTug4cwoLzNruZqSMMCxiaiR2R3Mm3NL/7UTR2HfXAp9602+f5cOGM9C+fG2L05JGp29emnXbCiEedKUZmQ2+ItKUTgzPqGTmA3DEg5w8qolhQSJO82a1gUUEmtAw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7964680a-bbd7-49cb-59aa-08d84f66cf43
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 17:37:06.0208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0pbJFl5CbfUsL5/LwHBWNyQQ3qNOPr+yE/Qqt+b15wYteaMqdxcntVCSHRt4Bsr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3871
Received-SPF: pass client-ip=40.107.94.114; envelope-from=alxndr@bu.edu;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 13:37:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: pbonzini@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:
 * FUZZ_LINK_COMMAND -> FUZZ_EXE_LDFLAGS
 * Add a separate call to add_project_link_arguments, rather than
   appending to config_host['QEMU_LDFLAGS']
 * Remove stray comment in tests/qtest/fuzz/meson.build

QEMU stopped building on oss-fuzz, after the meson integration, due to
some linking issues:

https://oss-fuzz-build-logs.storage.googleapis.com/log-3eaddfbd-7e05-4ddd-9d86-ee4b16c0fac6.txt

Those problems should be partially fixed by:

Depends-on: meson: fix libqos linking
(https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00802.html)

These patches:
1. Build on the above patch to fix the way we specify the linker script,
   to ensure that it is not specified within start-group/end-group linker
   pairs
2. Add support for running --enable-fuzzing with a custom LIB_FUZZING_ENGINE
3. Fix a problem with how we specify custom rpath in the oss-fuzz
   build-script

Alexander Bulekov (3):
  meson: specify fuzz linker script as a project arg
  fuzz: Add support for custom fuzzing library
  scripts/oss-fuzz/build.sh: fix rpath

 configure                    | 12 ++++++++++--
 meson.build                  |  9 ++++++++-
 scripts/oss-fuzz/build.sh    |  2 +-
 tests/qtest/fuzz/meson.build |  7 ++-----
 4 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.28.0


