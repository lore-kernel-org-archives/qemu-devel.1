Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14DDC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DA424656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qpxhd/j1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DA424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfuQ-0007sY-Mp
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVfli-0000q9-TT; Thu, 22 Oct 2020 14:56:58 -0400
Received: from mail-am6eur05on2090.outbound.protection.outlook.com
 ([40.107.22.90]:46561 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflg-0007YP-Ci; Thu, 22 Oct 2020 14:56:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzcfwaip1WzAvarS2Of4rQSfhqMuu+YQfPHPW4e+/n5t+0M4MadcBYLF2cC4eqUa40BCYyltMQKyM7BtUqdASBlMaGHCk5BlhHGBEFVMjV0zXJ4eB4pV1o40D4YNPzLwljzWbJbVSilO9G97gJk0Vzq3n/M4T7EsdOQhSM/IG3VVCN35PTcVLYfM9+wltcHRmpJ22KeiNHwgkLhJmtyKNHxGSwqgtunWqC4VQr2zQ2DfREzhgZ0UpKVe/pl+z8TmseT/pp7p/u+Go65dygmRwCe+RHc8An5UVa+c4d6ZUaWt9sTD/ae9/VzskwUHb/9D942InypyTipN5Er1W4TluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuSgK+bY+EKUtEHq+PsOXH/13Vn9fB/5KstEte5wmQE=;
 b=Bmp59Lly3UYTGhYZDSLDrb7jDjjJxqoIAeYZFQNn0oAW5OJ6WY66C/4BTSQZFmWDyCJMH7ffREFV6Jva5vthaMThx6CrwFbI8+MX6FUDiyFQbSbL5QPIbk4PrNC3bQa0iXGkCtLhlyQbakMRx5E+jnbaDR0rSH5la78dL2es4v/QQebD641+DUivl5dxCKwj6r6HSbz/Zz0ZixvgumuK6O4X1OUtb/w5eP9R01Lb5jgPUwgL6txmqUU7D9oE/p8nSldm3vy3lKnfwHuL0Ug9TG7ZEbxmQkHdpVOPgYreYGWYmgKeKvLvTHtxAXDdJIvNEM7Fhlso2ej6ZavxfOpKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuSgK+bY+EKUtEHq+PsOXH/13Vn9fB/5KstEte5wmQE=;
 b=qpxhd/j1DevmJmiIqTQN8Pxtdt56yvZ0pokjGmDy/mkTp9IOK/7Kl848ojyNunqfXzrjDMLuh25qZbfLzulm9e2SCOy5f15VPFTXr5he23CV5tcqv5SZh4y6Xl9NI+2v5pzbMGhpv0IUSUmlYh30IqE4OqkdgXLfBx2ydDmBPSo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH v5 08/12] iotests: add findtests.py
Date: Thu, 22 Oct 2020 21:56:23 +0300
Message-Id: <20201022185627.16987-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022185627.16987-1-vsementsov@virtuozzo.com>
References: <20201022185627.16987-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 22 Oct 2020 18:56:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4efa644-2a0d-4a5b-5d58-08d876bc39a1
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB63096A33F1D368169084A4D8C11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NteWAsHkQnZY6CuXQvMnUK728aA+VX9HIQQcYCrIAmM2uWQKiRplHWl78/TovVbfLhi6LUVHlliqDmZQLunHyGWCnSt68EuP78MIxN0+jmYB+ZXlcBNqwy7Qw/oK1V+T58rFtD0E8OedrWFkwfk+QLoijabEH8EmQgQlULEf1KrSH9ZsO3OJSNeSe2rg/FdHmlbudXfoyHJJcMh9KxmGqnS4OMHLQNotL8i8NpXyHJ8QWs6oKTxlMP74GLdhnwYq5LPafqvI98yAeUvXBoVxVJIgqTmYeI3Fjkq/R3/QYUSaeqX+dbGeVQqAAxu5tyj977tDnd7F6tZt5t3umSIW9kcCVxOcRYsu8Em76Zw9KXn/nWxUfQzDniqMyhucD94XeZnyHs+vNsVhtY6vPaXR81uGetChlUDuHEsSes7U1ffyDjdq0dhQW4hANSlUKDdT7kkzTNyDZVO+lnz3l6A5xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(30864003)(52116002)(4326008)(5660300002)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EB96RIUgfaLK23XAqVoJlxhMMbieXXNS4n6vgjyY1eZ148l337jdWsc5vKAdqAujqP7umcPjCxaNm5xXQ7P//0Wcy5XhHsxdv+aEdmkxC3VlkNDmPaRfsqUNmB2WTL2hqosDKG84cRfBdQirpC0tWI6yKmOyMy+Q+5QXplvjBv9p5V2ALC/uSAg6PSyjlKpdYXlVttd+URWyI3jXOMga/jvlvYsWw0O60c5AewSnsJjqcDD6hoYXuwQ1cMV58PHaVPhHmkUG7CIJgnvmPeDs9twESuYnBdduKP5+YiTLweMU5EowaUpQr9sK/jS619bOatUAg3N3LOMLlkC7lxXJj7wf8AIFopTjfJ6DdFmRKkjjI+jQGha4fP5W1B29dU1gxijjmYV5to7u0f1gFtwDlBfrs86GK5Fx53hbUg704EVo6e0gIzY3przEQQV1k95dc+SES9X12DhgB+z/WjvfkjOAMKO2NqNFEfkjWsMFACimvOYjQywXbjwzqcLgUgxklTQ9jXICfkoN18WEKGvJXWjkgtmzbDPhjq2rvw8w38Her8B+gzJvXnCrhanzm1qgmt6pkcLGJPA8+DGeDPw1hkvurk51iL0GOeCm1RuShYjUdMv4O1dUIIPgktmOBOj8ioaRWj7UrdxtJNSPSIhbAQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4efa644-2a0d-4a5b-5d58-08d876bc39a1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:46.6885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DumsbdP69cYWNLJI3BCNyDILhplTXed331lpLgI1IL1seiFcR53ly65i5F7IbTaxv23wspLLyAuxAC7GQ7YrXwSlKz4vioBtW6oC+hDuAw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.22.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:56:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add python script with new logic of searching for tests:

Current ./check behavior:
 - tests are named [0-9][0-9][0-9]
 - tests must be registered in group file (even if test doesn't belong
   to any group, like 142)

Behavior of findtests.py:
 - group file is dropped
 - tests are all files in tests/ subdirectory (except for .out files),
   so it's not needed more to "register the test", just create it with
   appropriate name in tests/ subdirectory. Old names like
   [0-9][0-9][0-9] (in root iotests directory) are supported too, but
   not recommended for new tests
 - groups are parsed from '# group: ' line inside test files
 - optional file group.local may be used to define some additional
   groups for downstreams
 - 'disabled' group is used to temporary disable tests. So instead of
   commenting tests in old 'group' file you now can add them to
   disabled group with help of 'group.local' file
 - selecting test ranges like 5-15 are not supported more
   (to support restarting failed ./check command from the middle of the
    process, new argument is added: --start-from)

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

This commit don't update check behavior (which will be don in further
commit), still, the documentation changed like new behavior is already
here.  Let's live with this small inconsistency for the following few
commits, until final change.

The file findtests.py is self-executable and may be used for debugging
purposes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/devel/testing.rst          |  50 ++++++-
 tests/qemu-iotests/findtests.py | 229 ++++++++++++++++++++++++++++++++
 2 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/findtests.py

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 0c3e79d31c..b2a4f6ce42 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -111,7 +111,7 @@ check-block
 -----------
 
 ``make check-block`` runs a subset of the block layer iotests (the tests that
-are in the "auto" group in ``tests/qemu-iotests/group``).
+are in the "auto" group).
 See the "QEMU iotests" section below for more information.
 
 GCC gcov support
@@ -224,6 +224,54 @@ another application on the host may have locked the file, possibly leading to a
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
+The (not exhaustive) list of groups:
+
+- quick : Tests in this group should finish within some few seconds.
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
diff --git a/tests/qemu-iotests/findtests.py b/tests/qemu-iotests/findtests.py
new file mode 100755
index 0000000000..b053db48e8
--- /dev/null
+++ b/tests/qemu-iotests/findtests.py
@@ -0,0 +1,229 @@
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
+from typing import Optional, List, Tuple, Iterator, Set
+
+
+@contextmanager
+def chdir(path: Optional[str] = None) -> Iterator:
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
+    _argparser = None
+    @classmethod
+    def get_argparser(cls) -> argparse.ArgumentParser:
+        if cls._argparser is not None:
+            return cls._argparser
+
+        p = argparse.ArgumentParser(description="= test selecting options =",
+                                    add_help=False, usage=argparse.SUPPRESS)
+
+        p.add_argument('-g', '--groups', metavar='group1,...',
+                       help='include tests from these groups')
+        p.add_argument('-x', '--exclude-groups', metavar='group1,...',
+                       help='exclude tests from these groups')
+        p.add_argument('--start-from', metavar='TEST',
+                       help='Start from specified test: make sorted sequence '
+                       'of tests as usual and then drop tests from the first '
+                       'one to TEST (not inclusive). This may be used to '
+                       'rerun failed ./check command, starting from the '
+                       'middle of the process.')
+        p.add_argument('tests', metavar='TEST_FILES', nargs='*',
+                       help='tests to run')
+
+        cls._argparser = p
+        return p
+
+    def __init__(self, test_dir: Optional[str] = None) -> None:
+        self.groups = defaultdict(set)
+
+        with chdir(test_dir):
+            self.all_tests = glob.glob('[0-9][0-9][0-9]')
+            self.all_tests += [f for f in glob.iglob('tests/*')
+                               if not f.endswith('.out') and
+                               os.path.isfile(f + '.out')]
+
+            for t in self.all_tests:
+                with open(t) as f:
+                    for line in f:
+                        if line.startswith('# group: '):
+                            for g in line.split()[2:]:
+                                self.groups[g].add(t)
+
+    def add_group_file(self, fname: str):
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
+                    print(f'Warning: {fname}: "{test_file}" test is not found.'
+                          ' Skip.')
+                    continue
+
+                for g in groups:
+                    self.groups[g].add(test_file)
+
+    def parse_test_name(self, name: str) -> str:
+        if '/' in name:
+            raise ValueError('Paths are unsupported for test selecting, '
+                             f'requiring "{name}" is wrong')
+
+        if re.fullmatch(r'\d+', name):
+            # Numbered tests are old naming convetion. We should convert them
+            # to three-digit-length, like 1 --> 001.
+            name = f'{int(name):03}'
+        else:
+            # Named tests all should be in tests/ subdirectory
+            name = os.path.join('tests', name)
+
+        if name not in self.all_tests:
+            raise ValueError(f'Test "{name}" is not found')
+
+        return name
+
+    def find_tests(self, groups: Optional[List[str]] = None,
+                   exclude_groups: Optional[List[str]] = None,
+                   tests: Optional[List[str]] = None,
+                   start_from: Optional[str] = None) -> List[str]:
+        """Find tests
+
+        Algorithm:
+
+        1. a. if some @groups specified
+             a.1 Take all tests from @groups
+             a.2 Drop tests, which are in at least one of @exclude_groups or in
+                 'disabled' group (if 'disabled' is not listed in @groups)
+             a.3 Add tests from @tests (don't exclude anything from them)
+
+           b. else, if some @tests specified:
+             b.1 exclude_groups must be not specified, so just take @tests
+
+           c. else (only @exclude_groups list is non-empty):
+             c.1 Take all tests
+             c.2 Drop tests, which are in at least one of @exclude_groups or in
+                 'disabled' group
+
+        2. sort
+
+        3. If start_from specified, drop tests from first one to @start_from
+           (not inclusive)
+        """
+        if groups is None:
+            groups = []
+        if exclude_groups is None:
+            exclude_groups = []
+        if tests is None:
+            tests = []
+
+        res: Set[str] = set()
+        if groups:
+            # Some groups specified. exclude_groups supported, additionally
+            # selecting some individual tests supported as well.
+            res.update(*(self.groups[g] for g in groups))
+        elif tests:
+            # Some individual tests specified, but no groups. In this case
+            # we don't support exclude_groups.
+            if exclude_groups:
+                raise ValueError("Can't exclude from individually specified "
+                                 "tests.")
+        else:
+            # No tests no groups: start from all tests, exclude_groups
+            # supported.
+            res.update(self.all_tests)
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
+            res.add(self.parse_test_name(t))
+
+        sequence = sorted(res)
+
+        if start_from is not None:
+            del sequence[:sequence.index(self.parse_test_name(start_from))]
+
+        return sequence
+
+    def find_tests_argv(self, argv: List[str]) -> Tuple[List[str], List[str]]:
+        """Returns tuple of tests list and remaining arguments list"""
+        args, remaining = self.get_argparser().parse_known_args(argv)
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
+def find_tests(argv, test_dir: Optional[str] = None) -> Tuple[List[str],
+                                                              List[str]]:
+    """Returns tuple of tests list and remaining arguments list"""
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
+        TestFinder.get_argparser().print_help()
+        exit()
+
+    tests, remaining_argv = find_tests(sys.argv[1:])
+    print('\n'.join(tests))
+    if remaining_argv:
+        print('\nUnhandled options: ', remaining_argv)
-- 
2.21.3


