Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E6C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80C92073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X1rGkwDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80C92073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnYJ-00070Z-SH
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSb-0006Mf-Lj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSa-0007SA-CG
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:49 -0400
Received: from mail-db8eur05on2136.outbound.protection.outlook.com
 ([40.107.20.136]:58816 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnSU-00073m-F7; Tue, 21 Apr 2020 03:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxakXdugoioWjOQlCVBD2Q0PnT6RN01WcLuOTxJPw+usbG2ZFUKRuBCUKkFszqum67NKMCCxRiNYYEns43ZnIAar7GF8OPL/ZrXFImMwxAnAv6np/AXZ6AHk3Lz0b3yLihlkOapUD/WaESTcDiCmZMj/nU0UsfKyvSx3OszpEwmVsIN2A4Sgv1BZRzS01Tf32R3C8nhIOj08QZDLhBtEeSBIajunOy0cFz8lxAsKaROmBVzUVbEsxg4SD6SBStJZaPXCdgDKgfIhewJ+ISU5aRNlEZnw+iplsfORROCM4OluBxmuhWY4jmDdXhME/QV+wA9pPttN4JFokGYfYlyqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74WA7wBLtt4tU7nyNq7N/+qVDcHObAGHHD/1hK0v2b8=;
 b=oLT8LFodsmo7TQOTkh2UdFEOxwZPoKEGO7LsISaQIDKwJtKs0/bDWmLF1Gf5Acm0P0Ekh5WzHj9wBx5djCvc0XOOhToPBKB7LbsVDZmTm1VNDYQqU89JeyP42PpqKCn3mBgPboEP+pGZvTIZpGHmRPMQOUG51YGNmjq1205lRWgGVYvIXK26H3ugl00XbUR/v4I6CdHBT2bvuGXRkjSzn++xG7+AwgO3RGby4WflpEoPeCwP/I1z9E6hkYUbjC44k9xrGPIOo6emQ/AC56jKerOVyN3LQUTrDJjxBApPStq5BuCgQ4BjF2lHpi5Vw7WSaDpj0RKoNBcX8yoyrmDlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74WA7wBLtt4tU7nyNq7N/+qVDcHObAGHHD/1hK0v2b8=;
 b=X1rGkwDhupeA3eQgx4nbbLbv0a2wzJS5xbcaD7iHgHF6dBdSW5l+5jtx/CiiGqWBHDolF+GLMNS3aVkBa8bXQox8Aj1P8JCpqTZhaYyN9K7xJ3xeC+RLPnLoMOTNnus3RVuMuXpK0EDHaN9thJhM+xIJwv7v5IeXFZL5lDznb0c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 07:36:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:36:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 06/10] iotests: add testfinder.py
Date: Tue, 21 Apr 2020 10:35:57 +0300
Message-Id: <20200421073601.28710-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200421073601.28710-1-vsementsov@virtuozzo.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.142) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 07:36:38 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eadf7ad9-7e8b-42fc-7b6c-08d7e5c6ba91
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5397DCEEC60EA17922DCB91AC1D50@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39850400004)(346002)(396003)(376002)(136003)(366004)(36756003)(1076003)(6916009)(5660300002)(6666004)(6512007)(186003)(4326008)(316002)(2616005)(956004)(16526019)(69590400007)(66556008)(66476007)(66946007)(26005)(2906002)(8936002)(8676002)(81156014)(6506007)(6486002)(478600001)(86362001)(52116002)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKjIvo4OuB4he0TeBN2eYPU0rDQ0QM1QFygWwihGexS1nsFZZJgP+ocuaWPqolVNch8khZRyg/LrJ3b8W9I4Ymr5SOWjW4YJbKZxpxJEW2poI4E9+cvdBDjyjFZVqZSjXZ/SVYfolgaMHibuEw4oN1uU8P8/qN3oYnXJDIiA03ye5H/kfSz4qML2qDXmWxn/3Nq0HlUJ9QgBMlnPa26UrrlAe0NHIZMCOZXi1JbWF6PRNzi/E+XRkiJ8VBk6QGrVnt6U/LCYNJ6+TFxOG+xSgzv7GeOx6xD4f76koRihFRLQ6aeMK2Ny4pqSSHPW8ZkDvC+8qbIRQZpAqrQUrYXdeN2MeLK9bl4tEDFTcW36gNX+Ip27buJjOlvcGOwdFk+R8NYth3OdikmR48TCuMJCkBb8WR/7+zurTWCmccG3+otjFTyntJJiTeknawEGsClw9+kYVknkUa1bjgRAEHAVxhAxHE5wL1O0qR6NQulvByoNIl1g7xa1oy9ziVd6DzhaYjcatl1qVOaWIjVgvFAzxRhOCIHOe0u+fZbnWGc9+7nVFj0G0DhoLTmx4cs38y+Ml13ht6JLspW768OgwRIjRzd/tQMgzwQ6E8Dz/rHsIYQ=
X-MS-Exchange-AntiSpam-MessageData: +2rsgk5HhASooOfEHVCZ6L+t70rV8QCoYyhURrRSoUUO1ZPqMQsQ4ug73iAxvDKw99Av1oVhI5sn495DNcG85WAFqvKKkh4UFahmaUTC7Mt0TGuhDsYoarEN/1Dag6xhK/OtakEV2SMjtpDuQ72/oQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadf7ad9-7e8b-42fc-7b6c-08d7e5c6ba91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:36:39.8729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uq6hVPM6Bw/wq6WR9HmfNV7bu8xhem80Ab1ZT6RpEY2RHFC5mYoYCjt/+VvsOk3TJOEh57WSSRWdBfx4MZuAMvHOD3p/XqYzYfgJP2Z0Dqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.20.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:36:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.136
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add python script with new logic of searching for tests:

Current ./check behavior:
 - tests are named [0-9][0-9][0-9]
 - tests must be registered in group file (even if test doesn't belong
   to any group, like 142)

Behavior of new test:
 - group file is dropped
 - tests are searched by file-name instead of group file, so it's not
   needed more to "register the test", just create it with name
   *-test. Old names like [0-9][0-9][0-9] are supported too, but not
   recommended for new tests
 - groups are parsed from '# group: ' line inside test files
 - optional file group.local may be used to define some additional
   groups for downstreams
 - 'disabled' group is used to temporary disable tests. So instead of
   commenting tests in old 'group' file you now can add them to
   disabled group with help of 'group.local' file
 - selecting test ranges like 5-15 are not supported more

Benefits:
 - no rebase conflicts in group file on patch porting from branch to
   branch
 - no conflicts in upstream, when different series want to occupy same
   test number
 - meaningful names for test files
   For example, with digital number, when some person wants to add some
   test about block-stream, he most probably will just create a new
   test. But if there would be test-block-stream test already, he will
   at first look at it and may be just add a test-case into it.
   And anyway meaningful names are better.

This commit just adds class, which is unused now, and will be used in
further patches, to finally substitute ./check selecting tests logic.

Still, the documentation changed like new behavior is already here.
Let's live with this small inconsistency for the following few commits,
until final change.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/devel/testing.rst           |  52 +++++++++-
 tests/qemu-iotests/testfinder.py | 167 +++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/testfinder.py

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 770a987ea4..6c9d5b126b 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -153,7 +153,7 @@ check-block
 -----------
 
 ``make check-block`` runs a subset of the block layer iotests (the tests that
-are in the "auto" group in ``tests/qemu-iotests/group``).
+are in the "auto" group).
 See the "QEMU iotests" section below for more information.
 
 GCC gcov support
@@ -267,6 +267,56 @@ another application on the host may have locked the file, possibly leading to a
 test failure.  If using such devices are explicitly desired, consider adding
 ``locking=off`` option to disable image locking.
 
+Test case groups
+----------------
+
+Test may belong to some groups, you may define it in the comment inside the
+test. By convention, test groups are listed in the second line of the test
+file, after "#!/..." line, like this:
+
+.. code::
+
+  #!/usr/bin/env python3
+  # group: auto quick
+  #
+  ...
+
+Additional way of defining groups is creating tests/qemu-iotests/group.local
+file. This should be used only for downstream (this file should never appear
+in upstream). This file may be used for defining some downstream test groups
+or for temporary disable tests, like this:
+
+.. code::
+
+  # groups for some company downstream process
+  #
+  # ci - tests to run on build
+  # down - our downstream tests, not for upstream
+  #
+  # Format of each line is:
+  # TEST_NAME TEST_GROUP [TEST_GROUP ]...
+
+  013 ci
+  210 disabled
+  215 disabled
+  our-ugly-workaround-test down ci
+
+The following groups are defined:
+
+- quick : Tests in this group should finish within some few seconds.
+
+- img : Tests in this group can be used to excercise the qemu-img tool.
+
+- auto : Tests in this group are used during "make check" and should be
+  runnable in any case. That means they should run with every QEMU binary
+  (also non-x86), with every QEMU configuration (i.e. must not fail if
+  an optional feature is not compiled in - but reporting a "skip" is ok),
+  work at least with the qcow2 file format, work with all kind of host
+  filesystems and users (e.g. "nobody" or "root") and must not take too
+  much memory and disk space (since CI pipelines tend to fail otherwise).
+
+- disabled : Tests in this group are disabled and ignored by check.
+
 .. _docker-ref:
 
 Docker based tests
diff --git a/tests/qemu-iotests/testfinder.py b/tests/qemu-iotests/testfinder.py
new file mode 100755
index 0000000000..1da28564c0
--- /dev/null
+++ b/tests/qemu-iotests/testfinder.py
@@ -0,0 +1,167 @@
+#!/usr/bin/env python3
+#
+# Parse command line options to define set of tests to run.
+#
+# Copyright (c) 2020 Virtuozzo International GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+import sys
+import glob
+import argparse
+import re
+from collections import defaultdict
+from contextlib import contextmanager
+
+
+@contextmanager
+def chdir(path):
+    if path is None:
+        yield
+        return
+
+    saved_dir = os.getcwd()
+    os.chdir(path)
+    try:
+        yield
+    finally:
+        os.chdir(saved_dir)
+
+
+class TestFinder:
+    @staticmethod
+    def create_argparser():
+        p = argparse.ArgumentParser(description="Select set of tests",
+                                    add_help=False, usage=argparse.SUPPRESS)
+
+        p.add_argument('-g', metavar='group1,...', dest='groups',
+                       help='include tests from these groups')
+        p.add_argument('-x', metavar='group1,...', dest='exclude_groups',
+                       help='exclude tests from these groups')
+        p.add_argument('tests', metavar='TEST_FILES', nargs='*',
+                       help='tests to run')
+
+        return p
+
+    argparser = create_argparser.__func__()
+
+    def __init__(self, test_dir=None):
+        self.groups = defaultdict(set)
+
+        with chdir(test_dir):
+            self.all_tests = glob.glob('[0-9][0-9][0-9]')
+            self.all_tests += [f for f in glob.iglob('*-test')]
+
+            for t in self.all_tests:
+                with open(t) as f:
+                    for line in f:
+                        if line.startswith('# group: '):
+                            for g in line.split()[2:]:
+                                self.groups[g].add(t)
+
+    def add_group_file(self, fname):
+        with open(fname) as f:
+            for line in f:
+                line = line.strip()
+
+                if (not line) or line[0] == '#':
+                    continue
+
+                words = line.split()
+                test_file = words[0]
+                groups = words[1:]
+
+                if test_file not in self.all_tests:
+                    print('Warning: {}: "{}" test is not found. '
+                          'Skip.'.format(fname, test_file))
+                    continue
+
+                for g in groups:
+                    self.groups[g].add(test_file)
+
+    def find_tests(self, groups=None, exclude_groups=None, tests=None):
+        """
+        1. Take all tests from @groups,
+           or just all tests if @groups is None and @tests is None
+           or nothing if @groups is None and @tests is not None
+        2. Drop tests, which are in at least one of @exclude_groups or in
+           'disabled' group (if 'disabled' is not listed in @groups)
+        3. Add tests from @tests
+        """
+        if groups is None:
+            groups = []
+        if exclude_groups is None:
+            exclude_groups = []
+        if tests is None:
+            tests = []
+
+        if groups:
+            res = set().union(*(self.groups[g] for g in groups))
+        elif tests:
+            res = set()
+        else:
+            res = set(self.all_tests)
+
+        if 'disabled' not in groups and 'disabled' not in exclude_groups:
+            exclude_groups.append('disabled')
+
+        res = res.difference(*(self.groups[g] for g in exclude_groups))
+
+        # We want to add @tests. But for compatibility with old test names,
+        # we should convert any number < 100 to number padded by
+        # leading zeroes, like 1 -> 001 and 23 -> 023.
+        for t in tests:
+            if re.fullmatch(r'\d{1,2}', t):
+                res.add('0' * (3 - len(t)) + t)
+            else:
+                res.add(t)
+
+        return sorted(res)
+
+    def find_tests_argv(self, argv):
+        args, remaining = self.argparser.parse_known_args(argv)
+
+        if args.groups is not None:
+            args.groups = args.groups.split(',')
+
+        if args.exclude_groups is not None:
+            args.exclude_groups = args.exclude_groups.split(',')
+
+        return self.find_tests(**vars(args)), remaining
+
+
+def find_tests(argv, test_dir=None):
+    tf = TestFinder(test_dir)
+
+    if test_dir is None:
+        group_local = 'group.local'
+    else:
+        group_local = os.path.join(test_dir, 'group.local')
+    if os.path.isfile(group_local):
+        tf.add_group_file(group_local)
+
+    return tf.find_tests_argv(argv)
+
+
+if __name__ == '__main__':
+    if len(sys.argv) == 2 and sys.argv[1] in ['-h', '--help']:
+        TestFinder.argparser.print_help()
+        exit()
+
+    tests, remaining_argv = find_tests(sys.argv[1:])
+    print('\n'.join(tests))
+    if remaining_argv:
+        print('\nUnhandled options: ', remaining_argv)
-- 
2.21.0


