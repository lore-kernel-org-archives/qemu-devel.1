Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD164206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EZ3LQxjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD164206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhke-0007d9-Ul
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg8-0001lx-8w; Fri, 15 May 2020 17:15:36 -0400
Received: from mail-db8eur05on2100.outbound.protection.outlook.com
 ([40.107.20.100]:45280 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg2-0005Vf-JR; Fri, 15 May 2020 17:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIHBGgya6xd88teOztQhluEHvOOVDYMY2W+iHeRKq+rWCrDYX1kq3Dm4366OtZSrt1KLpJl/CygxLA4XsBn0fcpu0ZBfJmpFpN3TOGupcPhUNAevNPmcRyMefuzFqnt7ZRPA6vhk3DgrY5BRUb5zSoYyioGBvQdvIoFWGvbxhmfe95HE5QtyFmzN1YTa0EpnNuNeynQSycifmieM9vliaLGCLgObiI63JPYfmWT1DYYrL308YXUWD2ORiwM5jeRgcO7eA4TZweqit1w0H2EKNIADaJM9zTR7/irbxDStU0MiDVa8U1utm1so5aGBHrXVwgFtHy+JUZwkwbybHgPwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqmrTYTwGnlmgiBtTXWc2WDELa3qPN60iKiIrOq1MjI=;
 b=UA4L4NWiYx4Oygw8jcnfjD24UFSwp0O2+3+KK4+ay0LRJmY2wX/HxcLB85jF3al0RnaHvI5h40h56KqY+EiADD86YNDuPbx4f6StxrSDQNFZHZovcXZa3EFHLpfq/3gUSey8sOom9HIfl/pzlWNnceEGSveuo1InaSL2ZxQtVybUQyLpRP11NpF5waqLdoNFuUYELZYJh4xbj3nXWleCtvFYMpXLVDHQW2Xy/F6dSL/DKymO1+846rU1wkB6uLPU5yE1cqlU5YrXurJyrEstKXT+jVL4GdEqVfd9UIKw+Ddab8jknEe5IGdZYfq2gdUnYUedCmf89hDPhMxl+AeBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqmrTYTwGnlmgiBtTXWc2WDELa3qPN60iKiIrOq1MjI=;
 b=EZ3LQxjrb2xahiHNiJ6bcAFjRrVlu2ktdGWjaQp28dntcqwSzQKRBiZNzgpliw7/Rr+LwP49nSS2MNUwTIiRqIMtOmcm4wkuPJ0ZWjJ02TAArag22GbGrsSszJw6fcgMYiVgo3s24lfmLt+K5+JErXVtyHWQP2pnlY8psWdKibk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:15:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 21:15:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 5/9] iotests: add findtests.py
Date: Sat, 16 May 2020 00:15:01 +0300
Message-Id: <20200515211505.3042-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515211505.3042-1-vsementsov@virtuozzo.com>
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 21:15:22 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a2d7d7-a205-4f33-adb8-08d7f91514ae
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54780479CFB9C8D863FDDF7CC1BD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DG8y93my9eSqZN764V0ZKUpQ2vv4l80yoa14mhL9aEnhym/9VXstopeSZg0i6zVKBPIjxvvqAE9DvJNZsZt0mi0asEadJIi+uWzUSJBSQuXMSbcKaIAUH2fxLA/Cxg2Cz1rZxmvCvi2uNn4uJ4bHL70kgpodNHgzilkZ7TQxFt0CE42jqU79OEhov7mUcSNzhPqHJ0dShxfVkB7bWHY9t6dYh0ITQm0bW6070ACJdfRiBKzVkHaC5Ts8/+Wc4Fs6OEQIMIh4/UC0MtUaK0s1OBovMIl5I7RAEkAsBTxXr+yeSLXdu6LcyVIxSXvY0NeaRuoejbPXlFRmZuNSrpSLV7H/qnJlP/oUQsDNQbNPq+IETzEtFZeMhAnBjuKcrrOYbS9hbMTxsGT2XXsKPZ2cocPCMBuypLU0jdKbwCg+8Uip3VwT/rQf0T4pynkvVd5jfyaaX7I57J8rSbpSUghTTZv9MZLKvy9FC2OvFCicpyw30GzaGYGSFaDqiFMgnLA1AMplA1Vf9NF3eaK3quszFj0y55+h+m9XHkiCVSPX7nd2vQ/SNVSj67Oq1KPsuxjz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(26005)(86362001)(6486002)(2906002)(6916009)(36756003)(30864003)(8936002)(316002)(8676002)(66476007)(66946007)(1076003)(66556008)(956004)(52116002)(4326008)(186003)(16526019)(478600001)(6506007)(6666004)(6512007)(2616005)(5660300002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OosbgT8Q+ie/PlW2bm/gu9KChAapbHNxtpYfY0J2T+RHPCjNjfxc41+y5Uis/Dmns+hfe0Z6Im1f79WZebcDqwafC4Qu08T4pgadE7+dPCOnY9Wb6nTigg8/rJV1MLtWgOnZijJOjm5NIjRaut14w9S2kFcAQdalvcXKpbGR1Ungfrn1pos9l3+PXYiMyQY7dtG5z2IrcQF8agdZZA2r8qh1/z9l4lOBXkLUT1GU79jLHJbe/zRj3K825clLROs4LLG4cZsXNQDmZcNOl7YpFJ87ExIkt/TbX+l6tsQx9X3Ks34vpTqwmBGWyNmqHd5QmS8nGA2dJCwotsm6q8fUUoyREVBMcQORprv53KHHl2NRHYOtNxHlYK8Fr2MnG3zqxH8zsMnWP47s+6fAer1CgEqIzxGJnHC6aRq+M6vRttNYv9K6OXwlS3YyLFGlY29p9trhIJAZGVPCU+T/ZiQpvYtYPMvGO+e8OF+yhzdmMTQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a2d7d7-a205-4f33-adb8-08d7f91514ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 21:15:23.5384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsI61rcGRTpX9Fu3s0dukOzLtr7Wrzt7P1SscIyJl1LxLdsDosqOVjPpSOCM6YkReSSwdtX8nYNYUaqTbrVf2fY8XE30vD/r1/Oprm0PxPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.20.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 17:15:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
index 770a987ea4..376e2f5086 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -153,7 +153,7 @@ check-block
 -----------
 
 ``make check-block`` runs a subset of the block layer iotests (the tests that
-are in the "auto" group in ``tests/qemu-iotests/group``).
+are in the "auto" group).
 See the "QEMU iotests" section below for more information.
 
 GCC gcov support
@@ -267,6 +267,54 @@ another application on the host may have locked the file, possibly leading to a
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
2.21.0


