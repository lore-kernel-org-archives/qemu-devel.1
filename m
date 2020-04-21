Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99E1C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26282073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TMKC7yRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26282073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnUc-0000dF-Mf
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSd-0006RM-Kj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSa-0007TE-Uv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:51 -0400
Received: from mail-eopbgr60110.outbound.protection.outlook.com
 ([40.107.6.110]:39054 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnSX-0007DY-Ov; Tue, 21 Apr 2020 03:36:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+alcGCY2LNPVfa09uy0y+O9VP4C2+IssEwxps+Hz+ilS6Y4Tp+x5ZDT6bqnvr8SvTU/1WSKkZr2n71C1zsaf8XlVZjYXQ87MfHMk5xEFQtn4cMD8MRlVQeCHux7KjmHbk7Eo01c0fPeFiQqf6iSTYOOzu1Ovw7MzLcNzmgeD/M9XiYrIu25x3M+2B3F/eeL0hEk4UUZGqqANpaPqZDscRIYvK07vgwgETVtoGbFGHLaaPThPIyuKAAXkl9Sh/iytKJjXsy0yrwVlcDcbxG+wFX6VKCO2yCgMGa8DIjWOJjrQR49CYSyFoclxmLI21YHt0iT7E2iuuBpb8CuozaE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7qXc0mBRMxF3klrxWdsWu5jeW783gCTlOQq9zWOV4Q=;
 b=PGJj+gu1IGVjsLBsonG8nSyoF+ElZ6Nv9hk4v1zsUqI4x27stkdRTbwiuHYcCjogU72qJ1gzdJqoLe7cmkwUj5frEW1yL6ZUApl0US0yL/3oc0Od66OIOtKdvVKuOAqeDst733tyW6l1w0ZtWzQhKzK+APxBToKn9rpswfGm8dAChkTD0Nfhq6JkUW8jjcBlSvFxIMRzDb1daUhCZ+q9NOgGJt+jtnFVO1n9J+JHRdXKC1l4z+/5ObdxAHL3ZelDfWsoTtQpU19Qpi22tuFg+iGjSGyF0/qd012NILHxSOqxTKjk3yxrZdAB6d0+hkHVxSVLRSKI3ZICJ0jRpfeUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7qXc0mBRMxF3klrxWdsWu5jeW783gCTlOQq9zWOV4Q=;
 b=TMKC7yRE8fLsE4XJosDjQcA1CGVM8FjyVU5DqH3bQilqHxXvmG50gSHoQ12mLKGA/4VC7SC4eNlwUC3UvkgzsgOtbgKwVWwXD5QfbRh1GlLPem2FVXs8MgEWQaEvpP0vjGMK1cJAfHLKmcZJ9w4C2pV6XfADmh5x6PDlvSinygc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5351.eurprd08.prod.outlook.com (2603:10a6:20b:dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.28; Tue, 21 Apr
 2020 07:36:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:36:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 08/10] iotests: add testrunner.py
Date: Tue, 21 Apr 2020 10:35:59 +0300
Message-Id: <20200421073601.28710-9-vsementsov@virtuozzo.com>
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
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 07:36:41 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ebc4476-2f33-4459-afe9-08d7e5c6bbfe
X-MS-TrafficTypeDiagnostic: AM7PR08MB5351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5351AF9551E9500E638ED1EAC1D50@AM7PR08MB5351.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(39850400004)(346002)(396003)(376002)(8676002)(6666004)(66476007)(8936002)(316002)(6512007)(6486002)(86362001)(1076003)(52116002)(69590400007)(956004)(5660300002)(2616005)(6916009)(81156014)(26005)(2906002)(6506007)(66946007)(186003)(66556008)(478600001)(16526019)(4326008)(36756003)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmNqMVc4bVkDQaMHo2NuXsDJeTe3uqQtWRNa72JyQD+FocqKjZd4uB5Pc66CEj90EdntDiTAmvrVzfg1FC2+vjbmPIcB1YcmiyDb1O2laEBxzolP3WfvBNimJ+gNASUhfO5OqK8aebNTvI87IPKy93pGclcd2uGOlbvh4WFYRHC9XcyqzKX/dCImbO8PDrSA6hy64RfN7IGTCS1HSXQpEzWZsfRg1zkpEHtbKWYCutQlun5gb7DXS+SNpsTx7MKwSygwMNHzjT41N1UNlr2k7M2dsnOm/gUlNO24HL5hx4B4OI2cDSsS9svsAvZ96056Nd3FJowh19iz7ufaveyIpzHPlXpkXg1ixJNpRu+v8Y4VOfdO99vTl5wCHyp+w/Vl5zVNeWbekBQdpnGldIP1Z7EAmHCLyh+ejf8FX9FGKaWh4xTxWZKBextAKOC7CsTborDIqO4Mi0oX60hnPWGVyr4lyRoWN5KvzZbr0XvSxNxYrK4cf5OHwYQ0YysQkukvwzCyxG4u3joYG+Cx+gLWZnmN9u+I03u1Z2S/3yfy37zbNRMN3oEUKiDL3cZpfZKkRxTU8unwxpkvTIKU59tXABOJPzcKjdooGGtuI514Q50=
X-MS-Exchange-AntiSpam-MessageData: grzO3Rd9mgKd1r7EoSd3UNdx219HKHxoYwaHAnYRcjfPU0bMM76hIsM8271Nzv5JanrK2M7mQdC0hOldEWRIQxkYbG1NBbZi2BUo4mX+lDrLmiuk+r/KhUdBANoUZAb5XNxZGTLhyshkkab4wq/U7A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebc4476-2f33-4459-afe9-08d7e5c6bbfe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:36:41.9208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EE6fCepOQoFSIb9xFcWXwvrPBPLDo8QOmXuBRuytsW9sZy/kAmus7uRgJIH0fkjgzvyT41UxzOEdiS7gB97VL3lY34M+SxqqWS/gS3W5q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5351
Received-SPF: pass client-ip=40.107.6.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:36:42
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.110
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

Add TestRunner class, which will run tests in a new python iotests
running framework.

There are some differences with current ./check behavior, most
significant are:
- Consider all tests self-executable, just run them, don't run python
  by hand.
- Elapsed time is cached in json file
- Elapsed time precision increased a bit
- use python difflib instead of "diff -w", to ignore spaces at line
  ends strip lines by hand. Do not ignore other spaces.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/testrunner.py | 334 +++++++++++++++++++++++++++++++
 1 file changed, 334 insertions(+)
 create mode 100644 tests/qemu-iotests/testrunner.py

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
new file mode 100644
index 0000000000..bb9bbe304b
--- /dev/null
+++ b/tests/qemu-iotests/testrunner.py
@@ -0,0 +1,334 @@
+# Class for actual tests running.
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
+import random
+from pathlib import Path
+import datetime
+import time
+import difflib
+import subprocess
+import collections
+import contextlib
+import json
+import argparse
+
+from testenv import TestEnv
+
+
+def silent_unlink(path: Path):
+    try:
+        path.unlink()
+    except OSError:
+        pass
+
+
+def file_diff(file1, file2):
+    with open(file1) as f1, open(file2) as f2:
+        # We want to ignore spaces at line ends. There are a lot of mess about
+        # it in iotests.
+        # TODO: fix all tests to not produce extra spaces, fix all .out files
+        # and use strict diff here!
+        seq1 = [line.rstrip() for line in f1]
+        seq2 = [line.rstrip() for line in f2]
+        return list(difflib.unified_diff(seq1, seq2, file1, file2))
+
+
+class LastElapsedTime:
+    """ Cache for elapsed time for tests, to show it during new test run
+
+    Use get() in any time. But, if use update you should then call save(),
+    or use update() inside with-block.
+    """
+    def __init__(self, cache_file, env):
+        self.env = env
+        self.cache_file = cache_file
+
+        try:
+            with open(cache_file) as f:
+                self.cache = json.load(f)
+        except (OSError, ValueError):
+            self.cache = {}
+
+    def get(self, test, default=None):
+        if test not in self.cache:
+            return default
+
+        if self.env.imgproto not in self.cache[test]:
+            return default
+
+        return self.cache[test][self.env.imgproto].get(self.env.imgfmt,
+                                                       default)
+
+    def update(self, test, elapsed):
+        d = self.cache.setdefault(test, {})
+        d = d.setdefault(self.env.imgproto, {})
+        d[self.env.imgfmt] = elapsed
+
+    def save(self):
+        with open(self.cache_file, 'w') as f:
+            json.dump(self.cache, f)
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, type, value, traceback):
+        self.save()
+
+
+TestResult = collections.namedtuple(
+    'TestResult',
+    ['status', 'description', 'elapsed', 'diff', 'casenotrun'],
+    defaults=('', '', '', ''))
+
+
+class TestRunner:
+    @staticmethod
+    def colored_status(status):
+        if status == 'pass':
+            col = '\033[32m'
+        elif status == 'fail':
+            col = '\033[1m\033[31m'
+        elif status == 'not run':
+            col = '\033[33m'
+        else:
+            col = ''
+
+        return col + status + '\033[0m'
+
+    @staticmethod
+    def create_argparser():
+        p = argparse.ArgumentParser(description="Run tests",
+                                    add_help=False, usage=argparse.SUPPRESS)
+
+        p.add_argument('-makecheck', action='store_true',
+                       help='pretty print output for make check')
+
+        return p
+
+    argparser = create_argparser.__func__()
+
+    def __init__(self, argv, env: TestEnv):
+        self.env = env
+        self.test_run_env = self.env.get_env()
+        if 'MALLOC_PERTURB_' not in os.environ and \
+                'MALLOC_PERTURB_' not in self.test_run_env:
+            x = random.randrange(1, 255)
+            self.test_run_env['MALLOC_PERTURB_'] = str(x)
+
+        args, self.remaining_argv = self.argparser.parse_known_args(argv)
+        self.makecheck = args.makecheck
+
+        self.last_elapsed = LastElapsedTime('.last-elapsed-cache', env)
+
+    def __enter__(self):
+        self._stack = contextlib.ExitStack()
+        self._stack.enter_context(self.env)
+        self._stack.enter_context(self.last_elapsed)
+        return self
+
+    def __exit__(self, *args):
+        self._stack.close()
+
+    def test_print_one_line(self, test, starttime, endtime=None, status='...',
+                            lasttime=None, thistime=None, description='',
+                            test_field_width=None, end='\n'):
+        """ Print short test info before/after test run """
+        test = os.path.basename(test)
+
+        if test_field_width is None:
+            test_field_width = 8
+
+        if self.makecheck and status != '...':
+            if status and status != 'pass':
+                status = f' [{status}]'
+            else:
+                status = ''
+
+            print(f'  TEST   iotest-{self.env.imgfmt}: {test}{status}')
+            return
+
+        if lasttime:
+            lasttime = f' (last: {lasttime}s)'
+        else:
+            lasttime = ''
+        if thistime:
+            thistime = f'{thistime:.1f}s'
+        else:
+            thistime = '...'
+
+        if endtime:
+            endtime = f'[{endtime}]'
+        else:
+            endtime = ''
+
+        if status == 'pass':
+            col = '\033[32m'
+        elif status == 'fail':
+            col = '\033[1m\033[31m'
+        elif status == 'not run':
+            col = '\033[33m'
+        else:
+            col = ''
+
+        col_end = '\033[0m'
+
+        print(f'{test:{test_field_width}} {col}{status:10}{col_end} '
+              f'[{starttime}] {endtime:13}{thistime:5} {lasttime:14} '
+              f'{description}', end=end)
+
+    def find_reference(self, test):
+        if self.env.cachemode == 'none':
+            ref = f'{test}.out.nocache'
+            if os.path.isfile(ref):
+                return ref
+
+        ref = f'{test}.out.{self.env.imgfmt}'
+        if os.path.isfile(ref):
+            return ref
+
+        ref = f'{test}.{self.env.qemu_default_machine}.out'
+        if os.path.isfile(ref):
+            return ref
+
+        return f'{test}.out'
+
+    def do_run_test(self, test):
+        f_test = Path(test)
+        f_bad = Path(f_test.name + '.out.bad')
+        f_notrun = Path(f_test.name + '.notrun')
+        f_casenotrun = Path(f_test.name + '.casenotrun')
+        f_reference = Path(self.find_reference(test))
+
+        if not f_test.exists():
+            return TestResult(status='fail',
+                              description=f'No such test file: {f_test}')
+
+        if not os.access(str(f_test), os.X_OK):
+            exit(f'Not executable: {f_test}')
+
+        if not f_reference.exists():
+            return TestResult(status='fail',
+                              description='No qualified output '
+                                          f'(expected {f_reference})')
+
+        for f in (f_bad, f_notrun, f_casenotrun):
+            silent_unlink(f)
+
+        args = [str(f_test.resolve())]
+        if self.env.debug:
+            args.append('-d')
+
+        env = os.environ.copy()
+        env.update(self.test_run_env)
+
+        t0 = time.time()
+        with f_bad.open('w') as f:
+            ret = subprocess.run(args, cwd=str(f_test.parent), env=env,
+                                 stdout=f, stderr=subprocess.STDOUT).returncode
+        elapsed = round(time.time() - t0, 1)
+
+        if ret != 0:
+            return TestResult(status='fail', elapsed=elapsed,
+                              description=f'failed, exit status {ret}',
+                              diff=file_diff(str(f_reference), str(f_bad)))
+
+        if f_notrun.exists():
+            return TestResult(status='not run', elapsed=elapsed,
+                              description=f_notrun.read_text().strip())
+
+        casenotrun = False
+        if f_casenotrun.exists():
+            casenotrun = f_casenotrun.read_text()
+
+        diff = file_diff(str(f_reference), str(f_bad))
+        if diff:
+            return TestResult(status='fail', elapsed=elapsed,
+                              description='output mismatch (see {f_bad})',
+                              diff=diff, casenotrun=casenotrun)
+        else:
+            f_bad.unlink()
+            self.last_elapsed.update(test, elapsed)
+            return TestResult(status='pass', elapsed=elapsed,
+                              casenotrun=casenotrun)
+
+    def run_test(self, test, test_field_width=None):
+        last_el = self.last_elapsed.get(test)
+        start = datetime.datetime.now().strftime('%H:%M:%S')
+
+        self.test_print_one_line(test=test, starttime=start, lasttime=last_el,
+                                 end='\r', test_field_width=test_field_width)
+
+        res = self.do_run_test(test)
+
+        end = datetime.datetime.now().strftime('%H:%M:%S')
+        self.test_print_one_line(test=test, status=res.status,
+                                 starttime=start, endtime=end,
+                                 lasttime=last_el, thistime=res.elapsed,
+                                 description=res.description,
+                                 test_field_width=test_field_width)
+
+        if res.casenotrun:
+            print(res.casenotrun)
+
+        return res
+
+    def run_tests(self, tests):
+        n_run = 0
+        failed = []
+        notrun = []
+        casenotrun = []
+
+        if not self.makecheck:
+            self.env.print_env()
+            print()
+
+        test_field_width = max(len(os.path.basename(t)) for t in tests) + 2
+
+        for t in tests:
+            name = os.path.basename(t)
+            res = self.run_test(t, test_field_width=test_field_width)
+
+            assert res.status in ('pass', 'fail', 'not run')
+
+            if res.casenotrun:
+                casenotrun.append(t)
+
+            if res.status != 'not run':
+                n_run += 1
+
+            if res.status == 'fail':
+                failed.append(name)
+                if self.makecheck:
+                    self.env.print_env()
+                if res.diff:
+                    print('\n'.join(res.diff))
+            elif res.status == 'not run':
+                notrun.append(name)
+
+        if notrun:
+            print('Not run:', ' '.join(notrun))
+
+        if casenotrun:
+            print('Some cases not run in:', ' '.join(notrun))
+
+        if failed:
+            print('Failures:', ' '.join(failed))
+            print(f'Failed {len(failed)} of {n_run} iotests')
+        else:
+            print(f'Passed all {n_run} iotests')
-- 
2.21.0


