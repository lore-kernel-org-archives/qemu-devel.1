Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8215CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3383D206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tD5i7VvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3383D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhnA-00036e-Az
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhgA-0001r2-E3; Fri, 15 May 2020 17:15:38 -0400
Received: from mail-db8eur05on2100.outbound.protection.outlook.com
 ([40.107.20.100]:45280 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg8-0005Vf-RO; Fri, 15 May 2020 17:15:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7sKDJxwi19aFvRVnsUOjkeYKyBl6LctHMf8zu4tr8qmEYCqGa40tId1JmbUIykW+FWVYuUHO1YAlmwyKT68XkkejaYJKiO09biTCbMiVCa6XH0Kl3qmXHyuAOtNsipyUSNh3Cp4iMx8IYPPBxA/pafIqUdBRwWN1hnVXJjAPzepgOpEfMWsMYHP1CpQS+eHrsJK9yFt3FwdkpSoaUgWx/nTPgGBA/dCLm0YMA7msW3HBy08+rFmj5e3fBEbY8dV56UOBDsyM2iLfcEZ3LSeoA80dYgh+vyjAgnfSqJaPxqdieZzN8xlTR48PvXBHLAweMoM87PhaZWeYQO52SmdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyIv5TZnkxP1DYonU/h9H1/h4L2fmaiuwX719YjsAd4=;
 b=oSq/j6gQaRxH9xf7RSXAXFTfKoyNc5z4gXzSy8pT4ph7e8DvxI3Nd8uqZXxWqKPKQ0k7anLJ7gsv6WtAivs7s7QuwOQA7cgFVppUvqlJ5xPAVMAYmA5gSuGaz1gmSH0CDMZ/7I10Su3GhV/gWxFmm6BYPyc7pKegyrgFuNz18s2FOo4lij5UeaAzRj3oj977yWjQTpbX3nUvet26ZtqajZrHL3Wwpt9pN9c7HVmqdst3hlm+NQKJ12Zcu6sNfUPjGVBgNquQO11vTc5c1g7dQZFayd1fIrHiZM4a1cUNjPPlII2i4ZMt0IU9BPco5g8ixmPx02ClbKNwXcJhOVbbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyIv5TZnkxP1DYonU/h9H1/h4L2fmaiuwX719YjsAd4=;
 b=tD5i7VvQ4G7jqLzL33COk7NXTUbOl7QQ3wOiV54laZTEfEdXMMUOuoKxpUCH8mzXeZc8hX5OqJMsnK48fAEemi/jnbmxNsojr0xLhJ2GLC8kAdjo2HChE33dKpgqb7uXeHQp7WoD1XMqxEECZywfgLaTYUU/N6q4Ja+50dQYFKc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:15:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 21:15:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 7/9] iotests: add testrunner.py
Date: Sat, 16 May 2020 00:15:03 +0300
Message-Id: <20200515211505.3042-8-vsementsov@virtuozzo.com>
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
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 21:15:24 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a55c757-180e-4482-19c8-08d7f91515c9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478732E9875DEC88226AF1BC1BD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGxRCjTTHIpsdY5q+B6SdEvKrPD7KHItc48x752XhSXFIyzeJsbV06MUgIYiff0NfFC7/1nKxMKzV5EkdFfUmmMkPP2bftNQhj1t0aVb3bZMsXnZMkHGglwE1sfQb9hJQem5Jswy2ARh+JsNjWzZD2L1492x5fKGPJ8gyfAjrtlrKXJTp7kC2QvnsFaRY1j7XQE9Sqlzq0oWbAvbdZgZiH1kjm+tw3Ctk867rwr5kXJzD+pVtEfjvyZRMGeuqgmxICtZEUQToJm84DIBViAQOLPaPf4LLzfEze+BsceyhymFrhi/CqcaT6W3iUAwI7bdJ/2J1NpIgs6Yu6mJtRGuA7PnRq4f/jKnLIpHsoMzi3rEzY7HbtMPFYmN5oZst3HSAQH87x3Zd6FsVwX7QCDdemLJJalHXdMwUARqPt1O1FSVW8avTZkLL/RPDASesxc4n+WO3L3UZcuJAdBx992oUcIM5F2zo1hKiabLMQKRjl3Vh4rwdFSzAUzxQh8Ga1+cqTHaSkq5FRzLLeDw1ugDlSjNgN8uaFsB1ycT1WhWwUkdyseeYnW8fLXCYxxe+Hoz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(26005)(86362001)(6486002)(2906002)(6916009)(36756003)(30864003)(8936002)(316002)(8676002)(66476007)(66946007)(1076003)(66556008)(956004)(52116002)(4326008)(186003)(16526019)(478600001)(6506007)(6666004)(6512007)(2616005)(5660300002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: G2OhA5ojinyaot0aGSMNYdnfewOQEOt0Eue2MRjJ6QO8aFeFV2v1bjTH4Hj9nHrIV75Q1w6SlS8H9Xdp+OoUecj1J33iPYv30BXkfH86HhCHsajqAa5wz4qG/c4j1pcfitx5NMFx4n2keeDIPLiRSe2ij63uvkHWeqIxZSzeiENeo2/3V/CPMRC2oVezTktFZcI3Y286Q3/e6EWDpeaKihuce+OVn+EQMAVHVG077fWGzEISmxhc85rJBFRIaTw/y4R+mw3ZpYrfYLOiD1Y3gyZ+CGWf/Joxff1GACOgfqqIk6F/eGjlTSjST3GX8YDnhlDWtSw5Fo1lTSveStxr/p4f+Mhfim2NLRUpK6RtDJzyRPrBgTaIYVnxFIi+heefYq9x727GtQZGjqk7q6aI8LwokT3jRFSqjrivS/GIPJfR9HQyfW5jka/Ft1UFgG5jN1YvnIuPaJURBB78U+MFvYPib6ZLGtyiWB/CR3S5GXs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a55c757-180e-4482-19c8-08d7f91515c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 21:15:25.3107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utR7//dWMUO+XPn0guZtmG8rNcMUOdat07Z1t5dQboxW52vh1D8YweSLcDP4FDR7oorIpDDJUJSoypLR3HDIw9/9u69aHL6p3uHVZSWAwbg=
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
 tests/qemu-iotests/testrunner.py | 351 +++++++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)
 create mode 100644 tests/qemu-iotests/testrunner.py

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
new file mode 100644
index 0000000000..e395877882
--- /dev/null
+++ b/tests/qemu-iotests/testrunner.py
@@ -0,0 +1,351 @@
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
+import termios
+import sys
+from contextlib import contextmanager
+from typing import List, Optional, Iterator
+
+from testenv import TestEnv
+
+
+def silent_unlink(path: Path) -> None:
+    try:
+        path.unlink()
+    except OSError:
+        pass
+
+
+def file_diff(file1: str, file2: str) -> List[str]:
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
+# We want to save current tty settings during test run,
+# since an aborting qemu call may leave things screwed up.
+@contextmanager
+def savetty() -> Iterator:
+    isterm = sys.stdin.isatty()
+    if isterm:
+        fd = sys.stdin.fileno()
+        attr = termios.tcgetattr(0)
+
+    try:
+        yield
+    finally:
+        if isterm:
+            termios.tcsetattr(fd, termios.TCSADRAIN, attr)
+
+
+class LastElapsedTime:
+    """ Cache for elapsed time for tests, to show it during new test run
+
+    Use get() in any time. But, if use update you should then call save(),
+    or use update() inside with-block.
+    """
+    def __init__(self, cache_file: str, env: TestEnv) -> None:
+        self.env = env
+        self.cache_file = cache_file
+
+        try:
+            with open(cache_file) as f:
+                self.cache = json.load(f)
+        except (OSError, ValueError):
+            self.cache = {}
+
+    def get(self, test: str,
+            default: Optional[float] = None) -> Optional[float]:
+        if test not in self.cache:
+            return default
+
+        if self.env.imgproto not in self.cache[test]:
+            return default
+
+        return self.cache[test][self.env.imgproto].get(self.env.imgfmt,
+                                                       default)
+
+    def update(self, test: str, elapsed: float) -> None:
+        d = self.cache.setdefault(test, {})
+        d = d.setdefault(self.env.imgproto, {})
+        d[self.env.imgfmt] = elapsed
+
+    def save(self) -> None:
+        with open(self.cache_file, 'w') as f:
+            json.dump(self.cache, f)
+
+    def __enter__(self) -> 'LastElapsedTime':
+        return self
+
+    def __exit__(self, *args) -> None:
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
+    _argparser = None
+    @classmethod
+    def get_argparser(cls) -> argparse.ArgumentParser:
+        if cls._argparser is not None:
+            return cls._argparser
+
+        p = argparse.ArgumentParser(description="= test running options =",
+                                    add_help=False, usage=argparse.SUPPRESS)
+
+        p.add_argument('-makecheck', action='store_true',
+                       help='pretty print output for make check')
+
+        cls._argparser = p
+        return p
+
+    def __init__(self, argv: List[str], env: TestEnv) -> None:
+        self.env = env
+        self.test_run_env = self.env.get_env()
+        if 'MALLOC_PERTURB_' not in os.environ and \
+                'MALLOC_PERTURB_' not in self.test_run_env:
+            x = random.randrange(1, 255)
+            self.test_run_env['MALLOC_PERTURB_'] = str(x)
+
+        args, self.remaining_argv = self.get_argparser().parse_known_args(argv)
+        self.makecheck = args.makecheck
+
+        self.last_elapsed = LastElapsedTime('.last-elapsed-cache', env)
+
+    def __enter__(self) -> 'TestRunner':
+        self._stack = contextlib.ExitStack()
+        self._stack.enter_context(self.env)
+        self._stack.enter_context(self.last_elapsed)
+        self._stack.enter_context(savetty())
+        return self
+
+    def __exit__(self, *args) -> None:
+        self._stack.close()
+
+    def test_print_one_line(self, test: str, starttime: str,
+                            endtime: Optional[str] = None, status: str = '...',
+                            lasttime: Optional[float] = None,
+                            thistime: Optional[str] = None,
+                            description: str = '',
+                            test_field_width: Optional[int] = None,
+                            end: str = '\n') -> None:
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
+            lasttime_s = f' (last: {lasttime}s)'
+        else:
+            lasttime_s = ''
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
+              f'[{starttime}] {endtime:13}{thistime:5} {lasttime_s:14} '
+              f'{description}', end=end)
+
+    def find_reference(self, test: str) -> str:
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
+    def do_run_test(self, test: str) -> TestResult:
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
+        for p in (f_bad, f_notrun, f_casenotrun):
+            silent_unlink(p)
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
+        casenotrun = None
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
+    def run_test(self, test: str,
+                 test_field_width: Optional[int] = None) -> TestResult:
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
+    def run_tests(self, tests: List[str]) -> None:
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
+            print('Some cases not run in:', ' '.join(casenotrun))
+
+        if failed:
+            print('Failures:', ' '.join(failed))
+            print(f'Failed {len(failed)} of {n_run} iotests')
+        else:
+            print(f'Passed all {n_run} iotests')
-- 
2.21.0


