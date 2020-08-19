Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69BAC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA1220738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="jSDaUWJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA1220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HR7-0008ES-1D
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKG-0004Cq-V3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:56 -0400
Received: from mail-dm6nam08on2119.outbound.protection.outlook.com
 ([40.107.102.119]:43040 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKF-0001Ya-7O
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTwU9fdSPmQYvnUliTtfl+a9bmER9lmsrXKWz3pXyXFJwUg6jHSxyHBWKWTQmd+aOJ0gR/tXk/QsTdFm5fdFyzyr4RHmWu/Qv2K7GIA9I+b4pIrY0pD61jRWOKZ6guNGa49+tYY0Wihlh8QkqCetxPCUJhaBDCxG179WoMejQmeXvCeyhNtueulQBX6QNtHxQPfc+jxKZthc+vcqi/UbZ2hCMAXa1A/LRM0NCrjQKPKMN1yM7BCAO8QmmYPWwIKoTfruDI04YGSBmm4xcEEiVZwpF4jQOUtOcFmLXyTSUZRaYmG7d+tTA5NUSKDe1Ur2AS8VQWlla37ABf4ibfyQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlDkX144i9bzPIsAfGO0qjdctGzXJJqv2P+4rdPQcLA=;
 b=BRLCS3TK0DYFaPqI5WptNTxFfiYcBmzPf6zi3k9Sjv6Bmd2arutcv0Upsnur4ilABO08++Oab/eJo7UJOPSH7DzwupqoeqKheQZ7ai9cnSj8HayW4LcR+zh6nthcrBBJ101qSkX/2qCMfhDbuzLI5zMFZRcgxiCgmOgPahurUJ3n79ULDcg8FlvEORQEi8YRP6zgC/uhKCubp3Vr6lG+rCtPmnO3FI+9XP9OGcUffUUZp1wIcV+DPLiOjrEDwL9mv5PBXtF/JRjhgRGtq7w+ie7R7HFMdpDHcV+35OPRCxaMPK9f8YhJapwedW2mP3VAuB6lJDo5xeKuWf0gqOmMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlDkX144i9bzPIsAfGO0qjdctGzXJJqv2P+4rdPQcLA=;
 b=jSDaUWJYP0LJ59U+QLIt/gLVP4WL3BZ3qpuOaTtwnNzs5d0U4eD77amMTaZCLey5kPectM0DzSV/fbqLpwcFLZ3ohdcDaUfDV3ht2f3chQ7LBpR9GOHqICMGOzQKgHzd/qqsgo6iFyYEjxMLjYCS7BbmOiiQpLkCtwUhkDkYerk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3486.namprd03.prod.outlook.com (2603:10b6:805:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 06:11:50 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:50 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/15] scripts/oss-fuzz: build the general-fuzzer configs
Date: Wed, 19 Aug 2020 02:11:08 -0400
Message-Id: <20200819061110.1320568-14-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819061110.1320568-1-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 06:11:49 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e1ae9dd-2f79-4d9c-6953-08d84406c2b2
X-MS-TrafficTypeDiagnostic: SN6PR03MB3486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3486DA4632F0603DF3413E40BA5D0@SN6PR03MB3486.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okVvWj3OvQCHJlBdxEPtQTR6Kd4o8ZYrGSHCxaMNhztNdY3MWmq+ezvbtobQ+Ivl/2PXOfFPO0+WR8srnSFl5G+CKcnWXqO34zA7NtSvYf3ob11645fUH1LmSG7B3seOhsnXgnAIuuAc7AVQtFocZFbxgBjo7yM2g6DAUc7xhxkIHJQ6G3lym5mCmmM7kKDbkTzXCpSfu2iEONOIvGeXojem3Y2Yz2Hgkj3dprkAF0NQmyIxcgyQC9V5aENgz3R9gve7+eoyFSFqj2Oay7o1Yx8k3gaYzoc6TV6SGVdag1xUrxfNVM/fBBZ8jYlX1d4Z0MNheOFkYU9Yz/E5rp7Wmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(66946007)(1076003)(6666004)(66476007)(8676002)(66556008)(956004)(86362001)(83380400001)(786003)(54906003)(316002)(2616005)(26005)(75432002)(4326008)(6916009)(6512007)(6486002)(8936002)(36756003)(16526019)(186003)(2906002)(478600001)(52116002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XUWlpJaXfKIZ0bw95IWAc0cEn+PZXvTT5se/sZTNWs55nMK9D6uLI7lGy4ZQqld8vm3T8mXTN0FLwElhNzbQXDARLgWGlrOvbWdaXWNoY//QdtALCiiWHUa4hv8RTusiYSlB5YkzlA3E/6rIPWc5hXUBoM8mH3Uie8OwIFyVyuTvbUWrVFhRW/2R3s5GbL9/4v4Nep5DBdVWNMcFLZgfyWNwup1o9VNEY+Hn9ynNIQOjgP54sIz3fpWBoADPyGSQxBnmAcU8J002Fyr/g8gyCtQXcgCiXfhXvT7gpvI5RiKEDtK8zKUSNDT0/kaSs3w1JcHN2Pr3qNCG240bp6fL94K4pNoa6my+Cj1MNh+aRmMaxOq0E6Ko+cKiZruRDglmOpIb9XTCQHm6cWuFGRgLUvOwcSYdnOK2q61P4RijGHua92Yu1nX1BWZIqS0wcMzzAqvblIXhumXmo4umjc8bYr7NhrOyOMULmmXyeSVPTwCIoRndR1eZ+ffcEwzL/J1JIbra54hf51kU6AJyVR6Zy5AtGcIa1PZUW2gr5vJoljGqdf/90YxsD9yLVyeQ6oFXSlwKeW/hvQGy8Ee8u2JW1abDhsYcnaOjkXIbT6V+FsziPQu6dY2E8XIwwLPthhG9SAI0L4xn2Yqar/PQ9/JRMw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1ae9dd-2f79-4d9c-6953-08d84406c2b2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:50.2498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpJPoROapvDoi9HdHC+RBfVZfqltSgOph0uFIm4RockByqngisIigS+n6j2Lgzey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3486
Received-SPF: pass client-ip=40.107.102.119; envelope-from=alxndr@bu.edu;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:11:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build general-fuzzer wrappers for each configuration defined in
general_fuzzer_configs.yml and move the actual general-fuzzer to a
subdirectory, so oss-fuzz doesn't treat it as a standalone fuzzer.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build.sh                   | 8 +++++++-
 scripts/oss-fuzz/general_fuzzer_configs.yml | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index a07b3022e8..2071e77ac2 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -38,7 +38,7 @@ OSS_FUZZ_BUILD_DIR="./build-oss-fuzz/"
 # remove it, resulting in an unresolved reference to qemu_build_not_reached
 # Undefine the __OPTIMIZE__ macro which compiler.h relies on to choose whether
 # to " #define qemu_build_not_reached()  g_assert_not_reached() "
-EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__"
+EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__ -DCONFIG_FUZZ=y"
 
 if ! { [ -e "./COPYING" ] &&
    [ -e "./MAINTAINERS" ] &&
@@ -101,5 +101,11 @@ do
     cp ./i386-softmmu/qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
 done
 
+mkdir -p "$DEST_DIR/deps"
+mv "$DEST_DIR/qemu-fuzz-i386-target-general-fuzz" "$DEST_DIR/deps/"
+
+./scripts/oss-fuzz/build_general_fuzzers.py \
+    "./scripts/oss-fuzz/general_fuzzer_configs.yml" "$DEST_DIR/general-fuzz-"
+
 echo "Done. The fuzzers are located in $DEST_DIR"
 exit 0
diff --git a/scripts/oss-fuzz/general_fuzzer_configs.yml b/scripts/oss-fuzz/general_fuzzer_configs.yml
index 010e92a2a5..f70bacb243 100644
--- a/scripts/oss-fuzz/general_fuzzer_configs.yml
+++ b/scripts/oss-fuzz/general_fuzzer_configs.yml
@@ -92,7 +92,7 @@ configs:
         -device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid
         -device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1
         -device usb-tablet -device usb-wacom-tablet -device usb-audio
-      objects: "*usb* *uhci* *xhci*"
+      objects: "*usb* *xhci*"
 
     - name: pc-i440fx
       args: -machine pc
-- 
2.27.0


