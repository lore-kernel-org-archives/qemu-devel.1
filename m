Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 05:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D2420801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 05:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="bOaflcYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D2420801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjccb-0006cj-3q
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 01:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjcbk-0004pl-8D
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 01:52:04 -0400
Received: from mail-eopbgr680126.outbound.protection.outlook.com
 ([40.107.68.126]:57499 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjcbg-0007OT-TH
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 01:52:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBa49sHMJYMgFh+GjMjMW7I2MPoYwFNCtt3KPtaO2L/vYqQC8cjpWZVjZuV628tSuz7r7bKZunclboDSMmqGGZTSBeUiI9ThYAIW6R/lyQZFaatTXv03TlWTZplVgIvZGhaCd6lca7jgogNmDn8cZxZyKQWnAKnxhpipce0keClTpuE5MjskbwAlFmzImRrF6QAbqYPVOtq1EGQSTXkpJt3Ph0M4HOFzu2F19F2PbY+R1Su/o2woa4+oiEiHL5oT8VrWlTMA0JevQI9ySsvlNfzUpinRLGwxtlVGMEYakeBgKQkGFH1PWGbKy12bLtiPrgkGNWR/Esgjgi1p3zyLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPta+Mw4Cxr9Y0IRDYjIA2SbnlK1b/r0N3MhAmfdL88=;
 b=B7nq9/rkzN/+sObL8EgPq/boHvEJDhs1aCNwCkrWdht29mpvfECHvTKEfApQh2Uag9nKDExSSxEVZO6VkWFAarg8cIXmD+y3EpfzIG2nd8Yxdm8/unF6lnsZkJayV47eiAqp1FwjJ0WrKltTSISJ6jJiasXklM7xVQwFQum1s3BvpKprMCnJGSZ2N3FfKO2pi9tUBumQYL0f1VhC1wkb0Sdq1rFvAdS0eWNLORIFVCsDYeov42u7HS7MLX6dtStLFVQ5uO/FJkNBuq9di388kixQl3lewaaLk3Qsuis3TMQ/61q+9UUzA0Qd+aIhxSjVSqkmBEFL7W75tTJq+c467w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPta+Mw4Cxr9Y0IRDYjIA2SbnlK1b/r0N3MhAmfdL88=;
 b=bOaflcYKHr3iePwSOplNgdEhiSh+LnIHJUWXSvZMBXt+e+WqoM6Bd3nX6I0sGXTF32yYltJBpg75O68dtd2drWC+FiWbfMXaM1Ud2WElEnw6caHlSE7m/W14Mjne7/lz7ajzZWkUtDTbR+rQMJVB6yZZvDkvrhYsrmbQQUqX1Vg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from DM6PR03MB3865.namprd03.prod.outlook.com (2603:10b6:5:47::31) by
 DM5PR03MB2860.namprd03.prod.outlook.com (2603:10b6:3:128::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19; Fri, 12 Jun 2020 05:51:58 +0000
Received: from DM6PR03MB3865.namprd03.prod.outlook.com
 ([fe80::e972:e73b:74f0:62ad]) by DM6PR03MB3865.namprd03.prod.outlook.com
 ([fe80::e972:e73b:74f0:62ad%6]) with mapi id 15.20.3088.019; Fri, 12 Jun 2020
 05:51:58 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] fuzz: add oss-fuzz build-script
Date: Fri, 12 Jun 2020 01:51:45 -0400
Message-Id: <20200612055145.12101-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To DM6PR03MB3865.namprd03.prod.outlook.com
 (2603:10b6:5:47::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.10 via Frontend Transport; Fri, 12 Jun 2020 05:51:57 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f8fffd8-9169-42cf-c904-08d80e94b7ea
X-MS-TrafficTypeDiagnostic: DM5PR03MB2860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR03MB2860BB0F16D7C4F1CCC2AA9FBA810@DM5PR03MB2860.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAZw+uT/B0CXOLuM/nB1LdxTdu4Z6JKaDAvRzo1MTzR6n1ZomAEgZx7vPb4q8F0Ba+swNJ70/EssEoZQpL+QcSSqSc643Y2iPsqdqW/byDAzbxW3g/lyyT0LubEgIg1Jnu4lcokvNankb8ImLlLNKPSWSlzzhwIikuiqpcvfg3ddyVN1Rs84v7yMJmhDdyiycLFHwOABuaaD9qmnBo59hZslBRzkc3XYEbKsgPMkSN7I/flKoa24WnZhS7SxC87rHTzg8DMzO6SJpeYvSVkHm2rKRIV/nLcUbyOlcbr+OmSLbkVfXlFq0h1M4LmKhy+4LZbXtRqseRnHpX5iOuiKpIkd5zMV4KFLPM5FZxtlgIy95iU5KWNgT21Fhexbfi3HZvbqGWg3ClGj1F0xafC6+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR03MB3865.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(36756003)(5660300002)(86362001)(966005)(66946007)(8676002)(1076003)(478600001)(6666004)(2906002)(66476007)(8936002)(6916009)(66556008)(83380400001)(54906003)(186003)(75432002)(316002)(83080400001)(52116002)(6486002)(16526019)(786003)(26005)(7696005)(2616005)(956004)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: A/AwnnsjmezyTmbclSHi84u9jx4C2P05vH7Gmbm4lUqFZtpekE1mUnD+As3OigquH66+dVWpC325Z0G4AosryV5ocxfqowJCc4RfWXtHVt5lDrHEsbovdozWjER4fEWp1onvwhVgEvTqg8bWu0/xQzJXrgpQR1Eg6Kr4HOqVLFy7RA8sVnql1zGmN2Olyzv4vtqlEc9wodMpB1ZL3scP5t0NnWSbsSx3xSK3oAIxZ/Oa1G1VbBmiYf6XCQAgYAZSXowO8p+VGcuh53SgYBiYLQW/IHNk4TRNJO2xtREhseKAwIbXQbJlZD6z1z9/dmR2VoeH9CAvOm7ix5zeTwYd8h8FDj1l28wUN1jN06e/ho56PC+LzE962Nclc2WPEGlZat1jmQDHvREDbbIOGs8Vow1Jpa/taEQQb5X4VgXyIpVmSD5RlNuScDXXnPfTMWm+CPYvDzJyCEIjUUZlqENe3WpUm0UrqJZFSlgt3DFywak=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8fffd8-9169-42cf-c904-08d80e94b7ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 05:51:58.0798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+YgZeEkUTiG1DRulbakK/KSoSI/kCJqKcQrM3sFkC724pyPZZ8/wqT8Ll7UH2YQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2860
Received-SPF: pass client-ip=40.107.68.126; envelope-from=alxndr@bu.edu;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 01:51:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is neater to keep this in the QEMU repo, since any change that
requires an update to the oss-fuzz build configuration, can make the
necessary changes in the same series.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---

v4: adds fatal() for error-handling, as suggested by Darren

 MAINTAINERS               |   1 +
 scripts/oss-fuzz/build.sh | 105 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100755 scripts/oss-fuzz/build.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 3abe3faa4e..094a37ebb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2336,6 +2336,7 @@ R: Bandan Das <bsd@redhat.com>
 R: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
 F: tests/qtest/fuzz/
+F: scripts/oss-fuzz/
 
 Register API
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
new file mode 100755
index 0000000000..f5cee3d67e
--- /dev/null
+++ b/scripts/oss-fuzz/build.sh
@@ -0,0 +1,105 @@
+#!/bin/sh -e
+#
+# OSS-Fuzz build script. See:
+# https://google.github.io/oss-fuzz/getting-started/new-project-guide/#buildsh
+#
+# The file is consumed by:
+# https://github.com/google/oss-fuzz/blob/master/projects/qemu/Dockerfiles
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+# build project
+# e.g.
+# ./autogen.sh
+# ./configure
+# make -j$(nproc) all
+
+# build fuzzers
+# e.g.
+# $CXX $CXXFLAGS -std=c++11 -Iinclude \
+#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
+#     $LIB_FUZZING_ENGINE /path/to/library.a
+
+fatal () {
+    echo "Error : ${*}, exiting."
+    exit 1
+}
+
+OSS_FUZZ_BUILD_DIR="./build-oss-fuzz/"
+
+# There seems to be a bug in clang-11 (used for builds on oss-fuzz) :
+#   accel/tcg/cputlb.o: In function `load_memop':
+#   accel/tcg/cputlb.c:1505: undefined reference to `qemu_build_not_reached'
+#
+# When building with optimization, the compiler is expected to prove that the
+# statement cannot be reached, and remove it. For some reason clang-11 doesn't
+# remove it, resulting in an unresolved reference to qemu_build_not_reached
+# Undefine the __OPTIMIZE__ macro which compiler.h relies on to choose whether
+# to " #define qemu_build_not_reached()  g_assert_not_reached() "
+EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__"
+
+if ! { [ -e "./COPYING" ] &&
+   [ -e "./MAINTAINERS" ] &&
+   [ -e "./Makefile" ] &&
+   [ -e "./docs" ] &&
+   [ -e "./VERSION" ] &&
+   [ -e "./linux-user" ] &&
+   [ -e "./softmmu" ];} ; then
+    fatal "Please run the script from the top of the QEMU tree"
+fi
+
+mkdir -p $OSS_FUZZ_BUILD_DIR || fatal "mkdir $OSS_FUZZ_BUILD_DIR failed"
+cd $OSS_FUZZ_BUILD_DIR || fatal "cd $OSS_FUZZ_BUILD_DIR failed"
+
+
+if [ -z ${LIB_FUZZING_ENGINE+x} ]; then
+    LIB_FUZZING_ENGINE="-fsanitize=fuzzer"
+fi
+
+if [ -z ${OUT+x} ]; then
+    DEST_DIR=$(realpath "./DEST_DIR")
+else
+    DEST_DIR=$OUT
+fi
+
+mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
+
+# Build once to get the list of dynamic lib paths, and copy them over
+../configure --disable-werror --cc="$CC" --cxx="$CXX" \
+    --extra-cflags="$EXTRA_CFLAGS"
+
+if ! make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" "-j$(nproc)" \
+    i386-softmmu/fuzz; then
+    fatal "Build failed. Please specify a compiler with fuzzing support"\
+          "using the \$CC and \$CXX environemnt variables, or specify a"\
+          "\$LIB_FUZZING_ENGINE compatible with your compiler"\
+          "\nFor example: CC=clang CXX=clang++ $0"
+fi
+
+for i in $(ldd ./i386-softmmu/qemu-fuzz-i386 | cut -f3 -d' '); do
+    cp "$i" "$DEST_DIR/lib/"
+done
+rm ./i386-softmmu/qemu-fuzz-i386
+
+# Build a second time to build the final binary with correct rpath
+../configure --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" --disable-werror \
+    --cc="$CC" --cxx="$CXX" --extra-cflags="$EXTRA_CFLAGS" \
+    --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
+make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" "-j$(nproc)" i386-softmmu/fuzz
+
+# Copy over the datadir
+cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
+
+# Run the fuzzer with no arguments, to print the help-string and get the list
+# of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
+# to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
+# executable name)
+for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
+do
+    cp ./i386-softmmu/qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
+done
+
+echo "Done. The fuzzers are located in $DEST_DIR"
+exit 0
-- 
2.26.2


