Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	RCVD_DOTEDU_SUSP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AFCC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 17:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27010206DC
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 17:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="AA2nqgPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27010206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kboTk-000400-AN
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 12:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kboSv-0003Xo-35
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 12:26:57 -0500
Received: from mail-co1nam11on2121.outbound.protection.outlook.com
 ([40.107.220.121]:19040 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kboSt-0004EF-1x
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 12:26:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSGAOtWQE8QPfuDxIwZQvLhYCi3mdt24gaJAHHng3c+rgxYh5zjiWrq88oDXJ0xI04ewqJeiIDp9xinjqxTlBP6KMCHzIVdfs/TBkBuIC9jztBfGEyjuyUWTJmWIREY+Ro7zpGz0KjAtzjOKZq6UwVFrWlE+ObESOy2dGlLIzyTmaCilLw7SKlYNaQesdIS0O8NX3o+jjB3ULqVvcKvjujGqhL3zlEdgNbAUpWfe5F4l5rhgU1y+c/Lf1YoVhfs3MMaf3MCVuTLYoRdE2L8eTslAqkQ2EZrqqaS6f22/JqN5oN5NFMd+YthzV1rEbCSSecVBYhenLhGwLZYvepkYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+bcwTaEyoTo0hZ/QgZkx+clWR6/TXdvu4Nr1KbqTLM=;
 b=jHdoogaQKPNle35kLPuPL6dm++In2oX/MAesJe2pObDg82CmcjHqvzAJQu9NrtcnJC+N4X8i4rPMoe8FBlyolUFM4Vv6d+f/7oOhvZywAJkrLDvpZKOCyiIJoT1HrgTAjNGbS619F0+nGu7poH8aEExK5bYjWXeGHetChRsrT0/eTgVEBfsJJtEfcbmcStid3a4/MumRZ5aizQcIlgpHzE9FSCWZOwWb90+d+NJ2KEeSz06CrtlRDIDyEJRbWe7StO4jVABe/TEX+U0EpV5wPrYd/4JTVnM40gOnqpYdgIUyRl9vQxlDbheIKDj1WpXZHX66Arug9k+NTdBv6x0JkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+bcwTaEyoTo0hZ/QgZkx+clWR6/TXdvu4Nr1KbqTLM=;
 b=AA2nqgPc4+IQSrna+myT+U/iV4PhwVxkng/wBtR0bomnfH5BPEhlmVOIhREot+tkzxpEnruxT+ivqGaUZ5rAvBLcnXWxYerfGGIRksJIi2UislyelMUoiz/rbMVynLqHaHTR3MiFBJL7GfjPAUseQhPnWH31PPT2A140jvuqtKw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA2PR03MB5673.namprd03.prod.outlook.com (2603:10b6:806:fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 17:11:50 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3541.023; Sun, 8 Nov 2020
 17:11:49 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/oss-fuzz: give all fuzzers -target names
Date: Sun,  8 Nov 2020 12:11:36 -0500
Message-Id: <20201108171136.160607-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:208:234::32) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:208:234::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.33 via Frontend
 Transport; Sun, 8 Nov 2020 17:11:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb701ee-4d17-4de8-a8a8-08d8840960ac
X-MS-TrafficTypeDiagnostic: SA2PR03MB5673:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR03MB56736D5F09B2838803361C35BAEB0@SA2PR03MB5673.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8v2euG96nRVjhNXA/+pR0SxUddS6+zQnId6WzZqpIWY9F2pTpgH2m/Q/4bZef/cGsjv3oT5CEciRXwVvodGoH7rLsJTp7+vGiO7FTmrLj1ZQ6u7/fAJrpQxpg6OFswu6GuUjXrgQf02z3Wy9omU6CQrON339Z+q3Oaqh8RXN1CA8T5N0DF/1Mo+hclvtQVbGH3sHTNl9aX/f9HTv7htxrfto+IXcbFdhdR5RPv4f/FyIZ9yxfAsNBCT26sebltdHVoPjks0WREXWpX8MRZbO1dWIMgxVwdFuYJnMlLWC4QrufgkW27AcIJScwrPYhmERYQf7pKs5iUr0xgau+N5JVW3vS2An4y1ylDIMGzEiz82FdGuOd0Xpfb/ECMz6qG2NvxDlT+/ZfNPWAcsuB0JhZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(956004)(52116002)(186003)(2616005)(36756003)(6506007)(26005)(6486002)(54906003)(1076003)(6512007)(16526019)(4326008)(478600001)(66946007)(6666004)(83380400001)(6916009)(8936002)(2906002)(86362001)(75432002)(786003)(66556008)(66476007)(966005)(5660300002)(316002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hzhXFifXsOb8R5jBZ8TKLpblZDHHxhm6K437ITjLe4fVysPisDg+JNG0rnTwweBI51sdJHrKDG340o0y3YyX1f4fjLpdchNNm1MN774tg9rdcYp6V34qjBwBZ4bLpgLiz/Pyqzezv16QemkEAta7zsXwD92oRY0A8LwJIeP6jZE8dMopBZvYdX2nTi8wCxg9PHa1O3uPKRUFY8UOISKCxFlD9t2yZrfSwmBqGyTPzsYx7E/wZ0H5B/fsgTlk2LS2pZMDjAokDob1dUG3NxBW2UmPxwZXmHc89sSWEx6/82uwxAaCyJNhULSkJRi4V50/HthdzUulK8PHjxCYU4SmxIZ5erzMjg1aUXhDo61Alnwb1tg46CqCkbz8os6OuYosScIsIikUCyqyGooCcb1jfcj+O9hR37zwb1EVjaGADiWqtQstZqwTtVFPcqAsV2bkxC+5AUiwQKhJVSWDoDdTJEbBlq0tOvpvoPc6UvI0KmHgzQaZFPaGQFD6AXohx/cExb0Mvw5GZpSIoj65eFR+3bMwQj7GPhD+GIuh+wb62Belh7ccNcHPKU4++UwFNzkznuNb3xTDQqBnhJ6+qwtzQ9Ho4/PQ4sELfNnmY2M8wOsENBj4eHEgnhVmDBgKtlKKSfAGy9bzDdakz0LpSRtXFw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb701ee-4d17-4de8-a8a8-08d8840960ac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 17:11:48.6963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+fFBcguUAZaKXZQGvsqm9WzOxoHjHZe7Cc/kSwBtWRssYGN77F08sg7PmnUIarF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5673
Received-SPF: pass client-ip=40.107.220.121; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 12:26:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

We switched to hardlinks in
a942f64cc4 ("scripts/oss-fuzz: use hardlinks instead of copying")

The motivation was to conserve space (50 fuzzers built with ASAN, can
weigh close to 9 GB).

Unfortunately, OSS-Fuzz (partially) treated the underlying copy of the
fuzzer as a standalone fuzzer. To attempt to fix, we tried:

f8b8f37463 ("scripts/oss-fuzz: rename bin/qemu-fuzz-i386")

This was also not a complete fix, because though OSS-Fuzz
ignores the renamed fuzzer, the underlying ClusterFuzz, doesn't:
https://storage.googleapis.com/clusterfuzz-builds/qemu/targets.list.address
https://oss-fuzz-build-logs.storage.googleapis.com/log-9bfb55f9-1c20-4aa6-a49c-ede12864eeb2.txt
(clusterfuzz still lists qemu-fuzz-i386.base as a fuzzer)

This change keeps the hard-links, but makes them all point to a file
with a qemu-fuzz-i386-target-.. name. If we have targets, A, B, C, the
result will be:

qemu-fuzz-i386-target-A (base file)
qemu-fuzz-i386-target-B -> qemu-fuzz-i386-target-A
qemu-fuzz-i386-target-C -> qemu-fuzz-i386-target-A

The result should be that every file that looks like a fuzzer to
OSS-Fuzz/ClusterFuzz, can run as a fuzzer (we don't have a separate base
copy). Unfortunately, there is not simple way to test this locally.

In the future, it might be worth it to link the majority of QEMU in as a
shared-object (see https://github.com/google/oss-fuzz/issues/4575 )

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---

I also have patches ready to get rid of the hard-linking altogether, if
people prefer that.

 scripts/oss-fuzz/build.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 3b1c82b63d..c1af43fded 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -62,9 +62,6 @@ fi
 
 mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
 
-mkdir -p "$DEST_DIR/bin/"  # Copy executables that shouldn't
-                           # be treated as fuzzers by oss-fuzz here
-
 # Build once to get the list of dynamic lib paths, and copy them over
 ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
     --prefix="$DEST_DIR" --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" \
@@ -91,20 +88,23 @@ make "-j$(nproc)" qemu-fuzz-i386 V=1
 # Copy over the datadir
 cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
 
-cp "./qemu-fuzz-i386" "$DEST_DIR/bin/qemu-fuzz-i386.base"
+targets=$(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}')
+base_copy="$DEST_DIR/qemu-fuzz-i386-target-$(echo "$targets" | head -n 1)"
+
+cp "./qemu-fuzz-i386" "$base_copy"
 
 # Run the fuzzer with no arguments, to print the help-string and get the list
 # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
 # to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
 # executable name)
-for target in $(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
+for target in $(echo "$targets" | tail -n +2);
 do
     # Ignore the generic-fuzz target, as it requires some environment variables
     # to be configured. We have some generic-fuzz-{pc-q35, floppy, ...} targets
     # that are thin wrappers around this target that set the required
     # environment variables according to predefined configs.
     if [ "$target" != "generic-fuzz" ]; then
-        ln  "$DEST_DIR/bin/qemu-fuzz-i386.base" \
+        ln  $base_copy \
             "$DEST_DIR/qemu-fuzz-i386-target-$target"
     fi
 done
-- 
2.28.0


