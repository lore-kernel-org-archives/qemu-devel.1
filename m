Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F33020767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="qbKGDskz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F33020767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTwH-00049A-LW
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTtz-0001Yk-E9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:38:19 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com
 ([40.107.237.125]:4768 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTtx-0002nB-4s
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:38:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doj3xMu3j9sEHlNgWD4tY+bqG5TybU82BJJKKfKeu8l5Do8vHSiWJdyp/4zJFwY+zOXAmtQPqSNv8mAdaoVnikOjOLOalzwBJR7dQTnUzDp6+GamZJs2VD5iA7RGhUOYBeYcsufri6GHsTxsG8NiqARMJ8QPqIBBaGbeHJ27dRVNsbmMMRrsuYRyf89rc7A9fO5PotfpOInca93lrymnVgCMSzHAOg3MnmF55l9PLiInXHTp7PonhAFGKYVCsEDsVHMD6tn4m0/fr5VLZcKoWoaNl0d2HTaq5p4xj6BbU6HY/XYI6eAffV2O5AkN565HxlD+/utME+uF3+v6RtrY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1KDyt4NnZ3cmPNntgu/rUsgtSAM5mQ3fnBRCc7JQvE=;
 b=T5gZsPg/hRudsWsmcM657B+8XaZd73lCcIwKaJfLJLMMbhjxTG1yxXObQEel5Ao7S0oI/rUEbeJSquViYOsNj66XstpBpOxwHLkv2PkBrHnaTMVcIV+BhLk7YSgpYBL7NvKJ0kF1trbqtKqsS5p3AWQbniKsdDGJYmSziKwYWuLKhD5J7OaNBf7ep3yPx+G8FUmWouH1XYRKoZu8Rk23i0IiOk4DgzPciDASnsFf02atZFypPu3PBTzK6OXFpTdPoER0CjrjOzvhtc18nSlIIg7EFskh02rb9Zd+oikCxVFz8++2pUvkS/2MbHYaJfewBX3sglzeimMyLeLwF3UDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1KDyt4NnZ3cmPNntgu/rUsgtSAM5mQ3fnBRCc7JQvE=;
 b=qbKGDskzZfzv+p9epXQvWPdn0ugWMiPUrD/IiV6w/hX+AUbTo5Q0wzbmATg9ghP0vPhAdTiwZsqEGZ6KW4igscj3JU8iAmK2uN5gNHrD/bvkFoRajzeogbOgcUCh+aKl9uFk1HwbyT0Uat1wNjiF8a3HlEaZG3HPBiMMWLIP3CM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5561.namprd03.prod.outlook.com (2603:10b6:806:bc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:38:13 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:38:13 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] meson: specify fuzz linker script as a project arg
Date: Wed,  2 Sep 2020 10:37:58 -0400
Message-Id: <20200902143800.124073-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902143800.124073-1-alxndr@bu.edu>
References: <20200902143800.124073-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0065.namprd20.prod.outlook.com
 (2603:10b6:208:235::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR20CA0065.namprd20.prod.outlook.com (2603:10b6:208:235::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 14:38:12 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96de09e4-7ba8-4a4f-0b7d-08d84f4dd25c
X-MS-TrafficTypeDiagnostic: SA0PR03MB5561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB55611D9207BDED7C5C6939E4BA2F0@SA0PR03MB5561.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBxrUaW522DFa1r9oiVzv1hDQQa0n0/XcnV4gMXElSakcE6wbvwOOAhIPUdyKzFJ1iv0FgfLH9nc0hSedbkDKsr3JCqp0l5xy0LdE+Q622w9SeOFTm0mKpbP9zWRDYL2Xuyw7g80aIdRtD6HqJd+leVRA5aD283BW3iL0zfRq6ydua6vHlxtLJyRm441lhfs0tJqcdj7/ukMOG3lU2b0OlP70KZ3j00r+vvrQJkiy7TW7vT0vlw3QwYljYIikCSxhfcV31VF8Mms1qEp7bfWBOnrX8Pi9dSjmCB97mJPj4PV9FrzC8p/DIj/228Ab2UvNoYelwQrfRX0nKYwcJYcYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(75432002)(83380400001)(8936002)(4326008)(86362001)(478600001)(16576012)(26005)(2616005)(956004)(8676002)(2906002)(36756003)(54906003)(6486002)(6916009)(66556008)(786003)(186003)(66476007)(5660300002)(66946007)(6666004)(1076003)(52116002)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VdYJ3CVf0eQ6n9eYMwKycRH3dWHwZZLquEAxHxBwmkuC8Py5thm/+UBbOuPdUyWvjEdXcq+ZfcJb0bY4aKX0UB9mxidprCMC0RDwlm6qvA3EjJ15GpmUN+K1RiM8wCQaPGdRJju867/ZgZPS9xZzoJ4u8aV2bUofseGmunozjVD7rnBpCWEtcEHjNCEImycJe/h6kWErjAxcX3wWhSNgd8+qPg/9LgCAKtMATDUUlRrcDcMYB+nrqNYkaQ+EhNT27gllbfNJwusZIxL8Ax6J4AW72RLg9uvVJm7fgOA/48qDaM7mAPUyZ6Yr9PqUCf8aODUk7gIURjOmiftYZ+ytyl1boiaC1RLktI0eyo6fRGG/uX27OXDnFFWhS3Xo4f1xbF8bixSgIjcyaFIZ44CehoCrXU2LVEeZeGTz9Kb7YsAmvtcsG3xDVEyDnSjiErlrTfrXG8dBXqlCgBUA2jP2SCGJ4T3DMVPvzBYdqgQp2DuPF+qjdrOFXYJhVwXREEhh9LMRHOzMLMnb5WywGhsHTvN+Eprcb/MhLN7rvL+yBNAzkMympx8ZaCXIJsuqrv4/MtPFX0Ele0maMTVtw2SXwl0R41cG0WEixEm7Sb7FGz2fj9y3d2DMYvFyvAUCI7LG6BAgWe7/Not39rbDzT/y3g==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 96de09e4-7ba8-4a4f-0b7d-08d84f4dd25c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 14:38:13.6387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu/15oUMo10QBbND1P7jybsR09jxCYy/X7OXTzYgGmsgBh1uEr1ObcYNsFmanoI1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5561
Received-SPF: pass client-ip=40.107.237.125; envelope-from=alxndr@bu.edu;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:38:13
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this change, the fuzzer-linker script should be specified outside
any --start-group/--end-group pairs. We need this on oss-fuzz, where
partially applying the linker-script results in a linker failure

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 meson.build                  | 9 ++++++++-
 tests/qtest/fuzz/meson.build | 1 -
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 74f8ea0c2e..a0407ce050 100644
--- a/meson.build
+++ b/meson.build
@@ -31,6 +31,14 @@ endforeach
 have_tools = 'CONFIG_TOOLS' in config_host
 have_block = have_system or have_tools
 
+# Specify linker-script with add_project_link_arguments so that it is not placed
+# within a linker --start-group/--end-group pair
+if 'CONFIG_FUZZ' in config_host
+   config_host += {'QEMU_LDFLAGS': config_host['QEMU_LDFLAGS'] +
+            ' -Wl,-T,' + (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')}
+endif
+
+
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       native: false, language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
@@ -1019,7 +1027,6 @@ foreach target : target_dirs
         'gui': false,
         'sources': specific_fuzz.sources(),
         'dependencies': specific_fuzz.dependencies(),
-        'link_depends': [files('tests/qtest/fuzz/fork_fuzz.ld')],
       }]
     endif
   else
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index bb0a3f271d..3432c3e7c3 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -10,7 +10,6 @@ specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuz
 # this will be duplicated in meson.build
 fork_fuzz = declare_dependency(
   link_args: ['-fsanitize=fuzzer',
-              '-Wl,-T,' + (meson.current_source_dir() / 'fork_fuzz.ld'),
               '-Wl,-wrap,qtest_inb',
               '-Wl,-wrap,qtest_inw',
               '-Wl,-wrap,qtest_inl',
-- 
2.28.0


