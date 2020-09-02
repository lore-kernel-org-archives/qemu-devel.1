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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA4EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8DC207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="3FMYfrjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8DC207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWhw-0006gG-3m
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDWh8-0005hA-AF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:37:14 -0400
Received: from mail-mw2nam10on2114.outbound.protection.outlook.com
 ([40.107.94.114]:28257 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDWh6-0004ye-MS
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:37:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLiwVvGrVgyuz159E0st5MOfiu9H+HImMgc1bzYNXtgXmapgNT8ljVlnZznDNqrYgPZhRk2XIl8S4XUfS/7pI1PRyLtVRFd/lBHhNvs2bVqlMopP2XkmG14hurS9m/kHwJwnQEgqcorEmU0P7AamY/kx/bNchbRHOc9ScHsREtZHWxHYSOT3V2b2jMXA7LzXFjBoU3GsgMbGQKEjhPTQC/1UTZ9BLuwj5+7ZRku+nd0I/mDmt8se6KJSRzX6mKUCuXfWjNj9aWPrhxLrXnIyLoydn88hE+7GIYVR6sjTI9pSVRNx0kIglrcR4+bn4hIAaVArxG8TZpcBdRHwARlt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zG111vJKYBE+ottBjJGVcG6DnspCfx1N4HWJDFgNJg=;
 b=Kc/nklHcOrNL5X0Dfl6aJFePn36oV92ZduxFdHJVjJhIwxt0AWZWLXBejR13zUeQ8k8Qj/dMwulBF1bf7E8VvkYB664kE8DkmJsLTzxcM794R5YlgJiKJpsoml7V5sAALNFkvWH2zQnr/PQQ8aLkUEpqraaJHiW2ZDtITn5F/8dmQxDAADs8NXcw5/dKDxI41PvKghvP8qalYL3lp9ahDuL6HTN2EYo9tBGYFL+HXAPVoOF6kY6Ux1xOzDse8Lm17CxsxcOuUYImsj8sUB6oPq+YLpjPLzXNt60kGLOYFSPO08CGxFdRW91R7qyyHq2NYgRP7LI11Gy9SKnihxSexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zG111vJKYBE+ottBjJGVcG6DnspCfx1N4HWJDFgNJg=;
 b=3FMYfrjKU8SpFuyIN/vT1ZQ7HEhML4t/woSo5KEcsMemOAvVLjubxF73pyuLhDp17jbDr+ymF4t9c+0JKBfKMetqTfotdz/sW5Wx2fbQjK+7tbdCvjdQRUwcgT+WgPJWZ2AIN0K/2cMg4eOI+pJDOTxWT+XQLauT5O+h00ZnCQ0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 17:37:07 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 17:37:07 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] meson: specify fuzz linker script as a project arg
Date: Wed,  2 Sep 2020 13:36:50 -0400
Message-Id: <20200902173652.307222-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902173652.307222-1-alxndr@bu.edu>
References: <20200902173652.307222-1-alxndr@bu.edu>
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
 Transport; Wed, 2 Sep 2020 17:37:06 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: debfed56-487d-4f60-52e2-08d84f66d029
X-MS-TrafficTypeDiagnostic: SN6PR03MB3871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB387165EE1E356A516A0E8CCFBA2F0@SN6PR03MB3871.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUpjEfzEasExcOnP3gcTOCrSOVZXdfeUvDjWctA4xDC3T8DczywPT2uGoUMZDiqQI/ST/nZrMJjwLq6aSc/zSXpWF5srMXRD5mNv4jPt58TN6mvxKAnMNQR8xrI8b6eCSACv2QIJDg7dHNHsqs1xzf+4XrZbTygVqxWLA1cEOvMR1pj2tAZYUBnD7iFjfllH9mUJnxKEwfwbpNJXgjnjTw1R81AScBl2oC7MdQdA+J0UKHfvza2lEMgLGDcykd5B523eeuIBsZK2pIRCKkRQdtKJpr/R040+yOBZvjAybq480CVzP3Tw00a6V1saZgLpsXmxiT+cGaLLnkn/Fv1APQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(6486002)(2616005)(1076003)(4326008)(86362001)(66946007)(956004)(36756003)(66476007)(5660300002)(16576012)(66556008)(83380400001)(316002)(8936002)(478600001)(54906003)(2906002)(52116002)(186003)(6666004)(8676002)(26005)(6916009)(75432002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VTwDOt09M+b/FhxJ67gvhxqRkgzWIAuIWUxXFzFhUnXlF0d4zbXP5vQ0sE5+4CftByCyS/WPglBljrRRnVDia5g1x23kyCUN65rAZT+pb1DQ//XKwzjsF9Ov9zkcOFTQIRegKR1fHak9b4+KgQYNdLxW2BheaR+zWm0UD5bVk/dSCpB9TyjlfJmVIE8APKQJF0+Bh8Z4YIuktkoUqr/7FC0CYj4Svq8GP9qLz3fphSs49BNNxOXKsfhZZriR0yYZIwrlU5C62UUvRpp/y23Zgm70wJdr08BQ0cGn7jMewXrZUOriVqCMUkihfOOMOx1FnUt/Fep1gxWk7J+va7GSO+hOKdLwxg6vQKuFn23nOSRKaZ0WO4hLgnv4kHBA54tiqJrzpAo/ZzPeHJo1gE7WnRr7+2KFo7XBo66FAX3xFYpr8gr5CFW9PyjIa34H6gmlhJC4wcvyABzPpNv8l8lCP2spupvEnzWm1O1ZtfIuw1d8IjIuHCh47tgnQgAR3SZZ3vMQjJrBSRDnxK2QwIf8PNLBZaLFtDnVhgbu5hruQOYK4CSvrbUKhTb0Ik6wjbAkdYV+53E7EOh6jzYt/2sJaktV7eO8HC1TO1cbd52pcV2BzhRvD9qHhXD3TdxLgIzEcpqkdChfpdlDKCDSmkhBzg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: debfed56-487d-4f60-52e2-08d84f66d029
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 17:37:07.2191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAXWH0lJO6gfdHUk7x+jrQyz5hi3koiPJmoFeDxrJ+0jGbJvJ7fd6b3Fn9GPPwcz
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this change, the fuzzer-linker script should be specified outside
any --start-group/--end-group pairs. We need this on oss-fuzz, where
partially applying the linker-script results in a linker failure

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 meson.build                  | 9 ++++++++-
 tests/qtest/fuzz/meson.build | 3 ---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 74f8ea0c2e..94413c2c25 100644
--- a/meson.build
+++ b/meson.build
@@ -40,6 +40,14 @@ add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
                       language: ['c', 'cpp', 'objc'])
 
+# Specify linker-script with add_project_link_arguments so that it is not placed
+# within a linker --start-group/--end-group pair
+if 'CONFIG_FUZZ' in config_host
+   add_project_link_arguments(['-Wl,-T,',
+                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
+                              native: false, language: ['c', 'cpp', 'objc'])
+endif
+
 python = import('python').find_installation()
 
 link_language = meson.get_external_property('link_language', 'cpp')
@@ -1019,7 +1027,6 @@ foreach target : target_dirs
         'gui': false,
         'sources': specific_fuzz.sources(),
         'dependencies': specific_fuzz.dependencies(),
-        'link_depends': [files('tests/qtest/fuzz/fork_fuzz.ld')],
       }]
     endif
   else
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index bb0a3f271d..bcc393828e 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -6,11 +6,8 @@ specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true: files('i440fx_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
 
-# unfortunately declare_dependency does not support link_depends, so
-# this will be duplicated in meson.build
 fork_fuzz = declare_dependency(
   link_args: ['-fsanitize=fuzzer',
-              '-Wl,-T,' + (meson.current_source_dir() / 'fork_fuzz.ld'),
               '-Wl,-wrap,qtest_inb',
               '-Wl,-wrap,qtest_inw',
               '-Wl,-wrap,qtest_inl',
-- 
2.28.0


