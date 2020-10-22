Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C44C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC3D24656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K1N4NLZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC3D24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfxQ-0002Zt-Cl
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVfll-0000sM-Rm; Thu, 22 Oct 2020 14:57:01 -0400
Received: from mail-am6eur05on2090.outbound.protection.outlook.com
 ([40.107.22.90]:46561 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflj-0007YP-FN; Thu, 22 Oct 2020 14:57:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8dtCpVgQVxOm5ciZ70RZXWbQqBImDosckIfjr2ncMdUQDuhKIO8xegGFwkiJViEL/7q+/r/LwuSR9jQzR3oSN5rR4IUbSw89/mxYObkSaMcuBaKfYdb8w/e2cVloEaAp75A+cuM/eHXlb2Tronuh6j1KxdwOcawqqFTopJ0mGZVk+1UWeMwImcvPipd8fz4jCENZsQeKXTvPgjWQ6H0R9i7LqMnh4jcmlIQioyqE/ihVA4tzPVkEZ02M9gCxbx5nj5n16awc+c7FkE1gQ8yOq+N+BO+MxDATAdpFnRXw5qx5NbuW6Nyxt94tuOIhKkIyJW9DzkEneNzP08KXmLWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK2eGIcI2lg8dI9kF7IczM5Qgl05Zzvj/xw1CQleWYc=;
 b=mp150k4WJnpifuRsvlF11Jn498v2pFlcmSYFmTlM5ZpISvj1dtTjyu/dr9nbdOni9SpQyb5l1Dh2blDQ/GM9AyjCmTSQqNY8ZiwcoOArZ6IZCkQZOx8y+AlsPe2fglrVvk2YbbAHjyWjP+SjHEQVfGlI/q1hJL9lzD/1M8r1PQACvUu12LGkg3MEQkNvgXcDIEVKxA1YD6nn2WWCEmxlILVilAgWSbWKHrkAiCc66D2QyNVJoEWKl/pbio4D00okp2++py4MHBKT7Z7mmWGP4UVjXhZIqJWmfEARGDSQRK80XEOrVXw7zgSguemDOhfTRI+/rD76I2gIzOk4uBlK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK2eGIcI2lg8dI9kF7IczM5Qgl05Zzvj/xw1CQleWYc=;
 b=K1N4NLZ/wkmWb8Epr0SrB06/ddh9KM0GY/CPKB2lPeaYy2VjVK16+A+JGxlEwe8JThimt+vBuMDqFPDVi2fCHpJykeTQZMKpshUBEa9JIv7qH2MxPEwA7z2OoLf7NBE0Hu19O7F+118/Ysp3oy2oXmXmkC9c9XbJhhsXmi/dYTI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH v5 10/12] iotests: add testrunner.py
Date: Thu, 22 Oct 2020 21:56:25 +0300
Message-Id: <20201022185627.16987-11-vsementsov@virtuozzo.com>
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
 Transport; Thu, 22 Oct 2020 18:56:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49eee21d-0bb9-4ff4-45c8-08d876bc3a8f
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6309FA325FD48ABFF1841E2BC11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGK3faNAanl9yey3ZUMgS8KpKrJ6GuVvA3S11W7Hyx6EbxMfUb1EZGpItMMfJOZZGT/R7cDf623XhFNDzru7dDEUFLNpGmL0CTLayLQCHDDkLgDSxsZ2N8LX1iquQZGOvIglAvCesb32S5S07XtMXTFl54GBlOwrn9PdtZaEFUFfTjzlC6i8eSdsBgHepJe6/P+s/YLo6NY1EvLvHGzfrs0PZln57TZv9MIh6trVFUbsx6VHTW/K9prSI6zdmQ/TN1VWnWzUqJ25Lszb6dMqFYR975iLBBDXdDK7iCBfBnXiA+OoqZkraP8q2lkbjK54SeHH0W/PYenoicezmSfGWGZrAKAMc/HaKWqv1l5lc0K4jeVGGUdP9qBaerpjbsmjKfHjntCOM5tykLjlI5TOdwkZ2d6dHriWP4PfQmtLJYhkqbGXRZBoiD/1gKglVnrQf1FpNdIy642d5Xrsb57mbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(30864003)(52116002)(4326008)(5660300002)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Fu+c+MqsaojBu5Q1iE9iLsvRMvMbzVVeChexdi9ZbuMFRZKe+dkUOctOwYJkJFlYpjiigcEvZ6tgMuOP93+au1m0Fefe9DVK537Br6yTfvION3BJ3STQeGvvY1XUyUDemZIfGlfu9zCYZrsov2TcJoo6SFknKyc6KAA84EJwKUuAcPCis+kWLBMSmfvA9k5NANScqSv1FtWd+OYKuqkWS0VshCtsnqfUGRV4v9LdA4MnYaO7BgvRQYChOoMTP03h6emxbpm5+OF1rV6NNDEynAXjI5vjsj9g1/Bqmrs0pHOG78EBGomDwL7j47HvgClCiSC8N5VAaEFsWwlxujrE3qQbBkYsPUUSPSdhCX7ugchxjGYCYiB+D5LS0LYlSaOP8bR3yh3xFpW/NNHZcREW7Cvt0ws5XI/m6zmsuX9pRwgVk8MqolUH9/2XgqS/cKzmpwoo6Jsx1LBUAnoAnfx9JD3nWxvQvOs20ChKZdN9ajEwKHrYd0ePNCWZbt5taa4u29emvxX8qApz9yQCanVP+qYLeXRtNOKpSgkF4RW3htXE+Z4gFWfVzEM7Dd5tpFu9IH1mUcyhrzunw8aruBobU4qnbVuPmJoEnrfPaP9K0l4cTTZs2x1liZXXfJ77lMoCbgo0akLQBdBBjfsDwBZKBA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49eee21d-0bb9-4ff4-45c8-08d876bc3a8f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:48.2497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz5KMmiXTAqXUzccZW1d7B7Waps5i7GApA/mgKonjkXpJBcvLT0JcYYmBtPjaCwjbjoaiW1czcvu1qiP9mtXIUb3ue2/eY20faWgkkf9+9M=
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
2.21.3


