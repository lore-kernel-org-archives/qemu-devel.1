Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766DBC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326DB2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Kb2dtL2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326DB2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjGUK-0004mF-E8
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 02:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGTg-0004Bc-S4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 02:14:16 -0400
Received: from mail-bn8nam12on2109.outbound.protection.outlook.com
 ([40.107.237.109]:34241 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGTe-0005la-FH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 02:14:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRAZzPfL1b6FFlPvfU95FGKb2gWspTMMJFzU66JqAlVKFEjxD/nwz7vC1DffEf11Gx8MMKRiFDOyGnRMWxDoiKlvOZKUcF4nTX5o35sCKP/+tJPGGbc+F3afb2TJrt+gMz/Jdyf0RiaHa2MypCA1Led1KtzBYlwBmrIfN2YY0GOnVQ8EnzrGdjHzGG7M13ARjduHKnhALAUZgnBWzfyJjM7HEeGyE1rnJ+LQpdwikxzG6GDJcseaaePLAl2FmnhLVV00t+83vQmoE9rmlvGLlh5uB/QcqNdzVIwfugeK7YCjplnQ+6JrsUaUgIJVJjwYIAKnh7yDYtpWWQQJkN/l3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DVBcf3bHdSsSl4kPBoO99pDxWQcJBg/l5U3TrPN0xk=;
 b=cilfqcme5iONrTo86YFM8KlkDRuFE3L37wWK4uxNz1I0T9gYat8SU8ZXyseX6tzjZh8dWxDZZmFDiDIYZG67A2w4UBq4HoMAHnd9527U54x/GOqYE/Rks0laiqa64XA/7UPG33mj04Qffo7rdABkxlNp9Um+h6ZpQRudZP64ztjUQbmnzxrCdapHO0kTs2sWopvbzcPVUfjwHtfCe/gcquD1jugxEVyPKPjRkuMhpMnPq/xrwTVtESqITU8LL2ZpMxFLa2piF1jv+jT3v5tu0NEvRHcPnKJjCBlrZ7OKSkFnVEX6TIOByZ33iTqKP7bhQSGTr3Fncp37nT3t/J2KjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DVBcf3bHdSsSl4kPBoO99pDxWQcJBg/l5U3TrPN0xk=;
 b=Kb2dtL2TO47WXNdqA75yUwzUxKBZNmfbCG4sptQ22mD1l8LybSdhKv0ywvwwBdyQOZa5c8vbYznmDkjNztk/6MggabKLsNTVQqYtmih/on5rmw4JQyLDRzLXyRNcCur436LzvonXDyFFpD9PZ35fTHxK+nKewHeSXBNeeiKKbuc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4125.namprd03.prod.outlook.com (2603:10b6:805:c6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 11 Jun
 2020 06:14:11 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 06:14:11 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] fuzz: add oss-fuzz build-script
Date: Thu, 11 Jun 2020 02:13:55 -0400
Message-Id: <20200611061355.31967-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:207:3c::36) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 06:14:11 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be0ed014-bc6f-441c-0ffc-08d80dcea894
X-MS-TrafficTypeDiagnostic: SN6PR03MB4125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB41251751582F686840409623BA800@SN6PR03MB4125.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggUBpYgculylAlATL/LzKAJb8L8WmD0bTXfLA/cn8YpkSyQ1BxeFK1IeJ2zUsOgaaVxxhztb7etAUnVfyxXcWC/v9NPRf8UAiQY+eTd4Pq5b6FjJMZarlwrCXkVZ8SZ+fc1LlBsf4a6UyGx0pHnZR4+BxcSInX84uoh9Ajja6dgWKrFYMsk14Rri2IjSIweTzuMSeCLZBS87kppp8S0PNTkxjPWWZPA0gJdNGjBBcrXDVOqf9XDdGsEOyDrT5Wy1/FY1PH8XqXPQ/fB344wZLp1htoB0DhTAKA5R0c+pHuXW7IrZfxaasOGjGNF1jlRvDdTeHz/FhZI9Bv/A+J6FZdfFPC7KcAL5YCIKQ1oFICm22Pe40Xg9XBihKbcib926o1Gmst+KCMoHk6HcUWK3+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(966005)(6486002)(8936002)(5660300002)(2906002)(16526019)(6916009)(83080400001)(1076003)(478600001)(186003)(2616005)(83380400001)(956004)(7696005)(54906003)(36756003)(6666004)(786003)(66946007)(316002)(66476007)(66556008)(52116002)(26005)(8676002)(86362001)(75432002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EUMd/cpp8DSBU+tUbgjv9uNvjqWBVCRTDN0aEHOdZZ6JhbQbYWnm5MWlSudGtuVFtNFDnJVxtwNyW6oOgyLBO5T5T4mCHwGfRZGE3OfyTxsP6U/4OfYpfrAUr+D7tCdDo1/fhtsAI+V8hg+XHfQ6Voy6oW1bkgLwT6l5eSZejeQ3cHvVh/eg5a6OLMlokgciqP/i6hcT05Ze24pna/euIHWLGWYTxVL9y6ZFDoJMwFEpflTWeqor26f4vUFBIrtSds/lo3IJ9FhlRskzQXbni6u+h88hzhtsg801y1YwssMMMGqUegePsfbZphg+dmFTso+DRS75xXN4iS+XceJDIEpaFzH1iT1mE/0ffd64Mgwaxt/x7+BwDu/P/lCIjJuVhoVWn1ZZD9621uleTZPIawI2bV28HqlkTW1bjSF3SFXMaqng7MOOaGZsb1FTC5uVyvPLiY4wHm2P+lOq3iKspn04TmzFgULTx+tVO7h4AJs=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: be0ed014-bc6f-441c-0ffc-08d80dcea894
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 06:14:11.6994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgnRufrC96BPmpm5MQwamSKZ1ZlBuM/Ugxc77eB3+xA0DXmig2NLBqKgegpFqTor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4125
Received-SPF: pass client-ip=40.107.237.109; envelope-from=alxndr@bu.edu;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 02:14:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
---

In v3 I tried to make this build outside the oss-fuzz docker
environment. I wasn't able to find a way to use the Makefile to install
the pc-bios and qemu-fuzz binaries per Philippe's suggestion.
Additionally, right now I create a separate build directory within the
the tree for build. I am not sure whether this is a good approach, but
we must rely on some default that will work with both oss-fuzz and on
a developer's machine.

 MAINTAINERS               |  1 +
 scripts/oss-fuzz/build.sh | 99 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
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
index 0000000000..4be6b21caf
--- /dev/null
+++ b/scripts/oss-fuzz/build.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
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
+    echo "Please run the script from the top of the QEMU tree"
+    exit
+fi
+
+mkdir -p "./build-oss-fuzz/"
+cd "./build-oss-fuzz/" || exit
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
+    echo  "Build failed. Please specify a compiler with fuzzing support"\
+          "using the \$CC and \$CXX environemnt variables, or specify a"\
+          "\$LIB_FUZZING_ENGINE compatible with your compiler"
+    echo  "For example: CC=clang CXX=clang++ $0"
+    exit 0
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
-- 
2.26.2


