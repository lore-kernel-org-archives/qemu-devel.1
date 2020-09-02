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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A138CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685CA20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="FNxWmP6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685CA20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTup-0002qX-KC
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTu1-0001cD-9W
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:38:21 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com
 ([40.107.237.125]:4768 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTtz-0002nB-It
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:38:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkqzShUjCGpxvlzVV+CYRmqlFtPobFSFP2kc9HUG/Esbn9t1qzrWaPoUi5j0r+jRAFqKklXGANj9IsQv4ncNiNl0i5pDhdXNpunpb0AXgH2G9rgfL4rPRb/a0s9IfuW3VLKaSqX9wJZRosKEckhNtldKJige6G5UfK8XlringZLROGA/YhTsoc8Dkwt4VTeHWGjkhk/5xBOUjZ8TZ53OdxnsFK2eMEA1fMtvQJQZaKycMXuLq9hVIzB/jhGyFVVDGt3j58Qo49RvtVnTTwX9Z4Ep7Tb5e1nb/Yt4+shfu4w2IDM7Q7kTwc0vg7UNezrmlVNeVx9tuy8G6NpVoed2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiV8fB+najyYA1wTgi2rqdLncmQNWPzZ8YcT+GqYsXs=;
 b=kjGHvjCcG8O/JoH3hMEUZlzjnTq2cY4Zky0Nc+jTPekHxusAbrqZ/YhrwEoNJD7jVv8Qo4DPL/Ymg1mJiDtrS95xZQksYSYQwESCdrLXM2SIPIN4Z1f5eNDI41lK7URdbmnY2/YrfrUPghfLnlqihGe/DTRsoopNc0bZKwhWHvrT/QFFyvkY1wn43Yq0TCDKsTRKpJkYTz0wH9b+l/PrrzBjzz0gaUWIrwiU8+5X9YQAYEG8qTl99sSCvVl8wjtpkeecAYaMHSYiqj7IH0dFae3rRKeusEmXWrAXDy8XQR0afvP5TqRMv8vBZEP5bM1Hli+wBLmgc6HsoAbfaj9pwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiV8fB+najyYA1wTgi2rqdLncmQNWPzZ8YcT+GqYsXs=;
 b=FNxWmP6z5WB3plSjTNAVlzlT82O1UWiyKebM22WZOAVDI4BcFBN4bUZEY/ZgBvk1pvOZHB6dS1NbUJ3UQXFRA/unkDMnh7YJicO6aLN4uRQh7WRoEojcaaYIbI33p1+vapRRztFpvLO4/7tyEaJiqf8ymOEh5zyU9RoUmn2T6IM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5561.namprd03.prod.outlook.com (2603:10b6:806:bc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:38:15 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:38:15 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] fuzz: Add support for custom fuzzing library
Date: Wed,  2 Sep 2020 10:37:59 -0400
Message-Id: <20200902143800.124073-3-alxndr@bu.edu>
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
 Transport; Wed, 2 Sep 2020 14:38:14 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b492b3f3-6d5f-4149-fe04-08d84f4dd321
X-MS-TrafficTypeDiagnostic: SA0PR03MB5561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5561C51F8393488C985B9831BA2F0@SA0PR03MB5561.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ru0QUSShGUAA3LCaidERlNOyLzWhyQiXBk/dD1oFZFOAwI/UKa2Sas1dWHBA2xUVJqM3fgnmh+hWS8rMvU0+T5uDjb1giSApnKBzu5PdP5ZnW4AhLuNtej8NlQtdvaKYbdRBLCvEH+NMm/DLULWruzxGQgMLI6n8Yhb7c8NjdqsfGL1kCCTES7DvxwIjRhLIJwlPz4IH7yRqd3Uu5ajAahpaRyBX5b8Gr1PgQtMaHOtkm8JBu4w8NnCAQ4QxkX7QT4FQIVi3Alw//hBLW7kdAiwBSxNndWAaBb5hHAYMrIdWMd6kdzfesfVMI3aW5q2ey3KICgEffG5bpw6VVYTWWRrZUyUYV52QygUD8iikTeI0vWW4i7O+vGcYJMDNDrTC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(75432002)(83380400001)(8936002)(4326008)(86362001)(478600001)(16576012)(26005)(2616005)(956004)(8676002)(2906002)(36756003)(54906003)(6486002)(6916009)(66556008)(786003)(186003)(66476007)(5660300002)(66946007)(6666004)(1076003)(52116002)(316002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nNMHWeRse6qEYTlSELDVBRdCqyL/T7agbzsOD3TVKOprRiAmgyTt75vneymoe0wFbsfVSq+95nsxTTfpdkvhKZrYjANo0rcj+oFptXn1jDY7nLtvXBRCCd0yKtfLCNOemhYTV2KRSRvKiLGNKI+pHNSlxZbeen02eyCPjCqJqJl+q/zU5HrwzT/kWR+maf1WGA/3GXzY4IDOedTKkbf22llQT+PnmFYS18vGAnzYspgjvIVOeuKeDNhhad58HD0uOHDS8AOXhv35W5dcsjMmtzzNq/USF5ndtbtcr3F11m0qFJKtg3G12fTR0ZN7MoJhznYUs8HZFBiCOHmodfXpE596MHlMU+WoU1q3y9VHndAJ7l5le8whlTQOSjrJIwch/jeihjt0bOFN1KI+PRlJ4SrD07guCWqO007Lgaj8LxDA8zTQVwrjbRVc/UbPAPKlZEaVnm+CKAjRpgPvrnL6EwUuDnxmVCrYHjaNpt22GwvMUiYpbF00RIkdjUqa4ZaSHoxU1Aq1tT+Ql72yBjCxJ5IMNx6G0LBAul8D1jdUMTxEkl5PEoptooEGvj8ndzJLhXNgkYim99XOJEVjtEXSdcDSBBlbNbIvqiyKXzlLAu+A0Dq2fqIlyrEPbVQWCgHcfbNNeqT1F56ReL30/N3CfA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b492b3f3-6d5f-4149-fe04-08d84f4dd321
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 14:38:15.1318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOdFqswmk/NUlcnJDSV7SpVXk9seoZGHcRSujSLnbKh5pA32bdShi2/fVhA335WP
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

On oss-fuzz, we must use the LIB_FUZZING_ENGINE and CFLAGS environment
variables, rather than -fsanitize=fuzzer. With this change, when
LIB_FUZZING_ENGINE is set, the --enable-fuzzing configure option will
use that environment variable during the linking stage, rather than
-fsanitize=fuzzer

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 configure                    | 12 ++++++++++--
 tests/qtest/fuzz/meson.build |  4 ++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 6ecaff429b..4182a88e75 100755
--- a/configure
+++ b/configure
@@ -6165,7 +6165,7 @@ fi
 
 ##########################################
 # checks for fuzzer
-if test "$fuzzing" = "yes" ; then
+if test "$fuzzing" = "yes" && test -z "${LIB_FUZZING_ENGINE+xxx}"; then
   write_c_fuzzer_skeleton
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=fuzzer" ""; then
     have_fuzzer=yes
@@ -7505,7 +7505,14 @@ if test "$have_mlockall" = "yes" ; then
   echo "HAVE_MLOCKALL=y" >> $config_host_mak
 fi
 if test "$fuzzing" = "yes" ; then
-  QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
+  # If LIB_FUZZING_ENGINE is set, assume we are running on OSS-Fuzz, and the
+  # needed CFLAGS have already been provided
+  if test -z "${LIB_FUZZING_ENGINE+xxx}" ; then
+    QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
+    FUZZ_LINK_COMMAND="-fsanitize=fuzzer"
+  else
+    FUZZ_LINK_COMMAND="$LIB_FUZZING_ENGINE"
+  fi
 fi
 
 if test "$plugins" = "yes" ; then
@@ -7620,6 +7627,7 @@ fi
 if test "$fuzzing" != "no"; then
     echo "CONFIG_FUZZ=y" >> $config_host_mak
 fi
+echo "FUZZ_LINK_COMMAND=$FUZZ_LINK_COMMAND" >> $config_host_mak
 
 if test "$edk2_blobs" = "yes" ; then
   echo "DECOMPRESS_EDK2_BLOBS=y" >> $config_host_mak
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index 3432c3e7c3..59a630802a 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -9,8 +9,8 @@ specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuz
 # unfortunately declare_dependency does not support link_depends, so
 # this will be duplicated in meson.build
 fork_fuzz = declare_dependency(
-  link_args: ['-fsanitize=fuzzer',
-              '-Wl,-wrap,qtest_inb',
+  link_args: config_host['FUZZ_LINK_COMMAND'].split() +
+             ['-Wl,-wrap,qtest_inb',
               '-Wl,-wrap,qtest_inw',
               '-Wl,-wrap,qtest_inl',
               '-Wl,-wrap,qtest_outb',
-- 
2.28.0


