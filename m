Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429E0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023362074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T6v30bRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023362074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp8Q-0007ZU-QL
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfov2-00068A-JS; Mon, 01 Jun 2020 14:12:16 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfov1-00026c-CZ; Mon, 01 Jun 2020 14:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNAY83t2OTCyCQOymN3eGJoNm7Cz9RytKHxSpTqC4vhjS65EPU4+Y6Y1wllG0RI4hDogVKstDddiL6V/FUb2/S8AwROsixoV2rQnn1YARcN+ZmmECeQhBDuM1bxwB1qRcyRS5eFVTAQJZnuq0vO6kp7DstM9bAyfdqM6qfFwCHFZYeJ81pVYgvG6jlPC3C9seTwJtId4lsYwPGhrXqPYZZ5qD6Ilhi9vA/de4VomITXec81bjWz/1GToq5uv+Wdxlf3HtrOou8VDObT5G1/7aFoD+FNBfOtXhCwrj4xycHaktgdHNP8bNc+Mz8mOm7j4LxYSXnMoqPC+MTgGz+xilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuoEurP90kYN5NvdWyFGpyZ0Z+G5YuQ4ObNKY8rXjBY=;
 b=nzSJ1bA5BCS+7KWdeaZ6pRzAS2vvgPyL0ILYdWrDbwRKHxpG2EiI4/s1QZWICNYJK3thOox4T50c4yuFi+J+pfoQX9ofSkYdcciEcPE57RoehF7JzvHK8c37KYMqaFGdFTpYp9CqNqWT8PfeuRQCNFBguZaG03FoavhDdSZJVfR7Z2pBolithQNsNFhzHOwvpAni6u+ZdUqHnO70NS1q8E9E9G+nIV9hXcU4UGx0zD5vd8qH2GR6IBAO3NKCVuZ/oMzhrE1eZS3QT4aLPaLdRS5hzr7FvhHoQRlle8H2qNAxpgtiv4woAQIJuKSVl9+lzn45sNqJbXkEQcXveiWNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuoEurP90kYN5NvdWyFGpyZ0Z+G5YuQ4ObNKY8rXjBY=;
 b=T6v30bRvmX0oETG/uon095dsCtlDdJLxQ1lysYldmw2s+ax0GteRcf8NtSi+F3WcF2YaSyBUyqgbf9GgfJSJwGP7KzA/4Mdo7oB0n/RSp2kREjjTkrhJp5pxPk6Shj9O23ZpSlhZqB93tTyHPSfo8+/Ffq4JW3cuewkhreS8RQk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 20/20] simplebench: add bench-backup.py
Date: Mon,  1 Jun 2020 21:11:18 +0300
Message-Id: <20200601181118.579-21-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:48 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41057229-1195-4c55-0fa3-08d806574095
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5317FF0F252ABB293B012B24C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pz5LwcDfwij/C3nZb0eusAdGwAW3WgLkKidsnWmmgtiFQcvm/X9ZAGTBa1uGxRT8wFdQxMTapR16tb8yOO9EzDXE9p5MFlv4wIgKX4YPLZgTmkJkmXkOuD194bYEUYoA+QhDYlFUiGYiwihiEWbMllSgJWQwhvrctTLCd5RGODl/gZ4CwceazDmYtC53i99nQYbVkVMbiJE7I69NV1b/rgP25ZHYEjpEJDgf2Y1orC3sIFesRYvdzlmdVCK2Qd9j+oePs/wx+zFkaxjyA4HVzAHboQ3ElzVuVoUx7hfnmEXmgg5vmigIeQxCULXWU9U42yLUMVYmKno7gL7/piR/bbc4Wc3zBMEdNACMZVueT2F2P8ZMFzb0x/r0qHvrettHzN7LWE8V7uOgGsxVNNGYkbM+LktuVbeZJWxOCG4z+EyrewthNwwrz2LBd/whMMeMlcbq3WoMaJDggQSxE7Ol41NMad3I77GqSyIFMEYix8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: A/9HkfnLnLVEzTHfj1PVPgaA0aO4OLSBoO7j2udIvK+Hhj2SS0Gv1ClO8T/FWp0AE+JcXUWvB0xKVAzpoTQYxXAzhEB3hSczCOXJzLIacgiw5ZPQAxv6EcpSjgeUUqyna38X5heuV6TWYTFSAo0v6ZoDoqF1cc4vYwofofdP8QzL9BKrQVcqECGL+5i5eViFV7BwaI5Rpq4TTmp4IPz4m9d22bf85x3kWYkXnKj+1eFNZd+1ak7tWPZnTW5HsLgzSiEmpA5uU15huV1FbkPsngOq5ya8yDY7Ae+lBc44vT4C/SPac0Uli6beAE6qIMdc7XdcmAAhKmFLl21rjA+ImiVGk2csOtk/91dS1kQvYsf1RJ04/ndXcViGYxGnw+oMW8QzuEYWl26PtKR2bRy4CIwBhR2CzCFzjKtLJ9WfTamtzP1Zou5GfLcLX2KCPTlyzPLOK0dg3u8yr/WvinlcTfPvtjNfrK/bVv2PeLWKHtU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41057229-1195-4c55-0fa3-08d806574095
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:48.9631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G5ONW4AqIQYCvog2Y2wfqNnN4eA4FzdpFxB5GeG+ly5snpf1dj+r72L4ExntPz8DD3WUjf24YxI6IdrH+nylEKl0XIZUv+3kY7MU+pdoIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:32
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add script to benchmark new backup architecture.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench-backup.py | 132 ++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100755 scripts/simplebench/bench-backup.py

diff --git a/scripts/simplebench/bench-backup.py b/scripts/simplebench/bench-backup.py
new file mode 100755
index 0000000000..8930d23887
--- /dev/null
+++ b/scripts/simplebench/bench-backup.py
@@ -0,0 +1,132 @@
+#!/usr/bin/env python3
+#
+# Bench backup block-job
+#
+# Copyright (c) 2020 Virtuozzo International GmbH.
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
+import argparse
+import simplebench
+from bench_block_job import bench_block_copy, drv_file, drv_nbd
+
+
+def bench_func(env, case):
+    """ Handle one "cell" of benchmarking table. """
+    cmd_options = env['cmd-options'] if 'cmd-options' in env else {}
+    return bench_block_copy(env['qemu-binary'], env['cmd'],
+                            cmd_options,
+                            case['source'], case['target'])
+
+
+def bench(args):
+    test_cases = []
+
+    sources = {}
+    targets = {}
+    for d in args.dir:
+        label, path = d.split(':')
+        sources[label] = drv_file(path + '/test-source')
+        targets[label] = drv_file(path + '/test-target')
+
+    if args.nbd:
+        nbd = args.nbd.split(':')
+        host = nbd[0]
+        port = '10809' if len(nbd) == 1 else nbd[1]
+        drv = drv_nbd(host, port)
+        sources['nbd'] = drv
+        targets['nbd'] = drv
+
+    for t in args.test:
+        src, dst = t.split(':')
+
+        test_cases.append({
+            'id': t,
+            'source': sources[src],
+            'target': targets[dst]
+        })
+
+    binaries = []
+    upstream = None
+    for i, q in enumerate(args.qemu):
+        name_path = q.split(':')
+        if len(name_path) == 1:
+            binaries.append((f'q{i}', name_path[0]))
+        else:
+            binaries.append((name_path[0], name_path[1]))
+            if name_path[0] == 'upstream' or name_path[0] == 'master':
+                upstream = binaries[-1]
+
+    test_envs = []
+    if upstream:
+        label, path = upstream
+        test_envs.append({
+                'id': f'mirror({label})',
+                'cmd': 'blockdev-mirror',
+                'qemu-binary': path
+            })
+
+    for label, path in binaries:
+        test_envs.append({
+            'id': f'backup({label})',
+            'cmd': 'blockdev-backup',
+            'qemu-binary': path
+        })
+        test_envs.append({
+            'id': f'backup({label}, no-copy-range)',
+            'cmd': 'blockdev-backup',
+            'cmd-options': {'x-use-copy-range': False},
+            'qemu-binary': path
+        })
+        if label == 'new':
+            test_envs.append({
+                'id': f'backup({label}, copy-range-1w)',
+                'cmd': 'blockdev-backup',
+                'cmd-options': {'x-use-copy-range': True,
+                                'x-max-workers': 1},
+                'qemu-binary': path
+            })
+
+    result = simplebench.bench(bench_func, test_envs, test_cases, count=3)
+    print(simplebench.ascii(result))
+
+
+class ExtendAction(argparse.Action):
+    def __call__(self, parser, namespace, values, option_string=None):
+        items = getattr(namespace, self.dest) or []
+        items.extend(values)
+        setattr(namespace, self.dest, items)
+
+
+if __name__ == '__main__':
+    p = argparse.ArgumentParser('Backup benchmark')
+    p.add_argument('--qemu', nargs='+', help='Qemu binaries to compare, just '
+                   'file path with label, like label:/path/to/qemu. Qemu '
+                   'labeled "new" should support x-max-workers argument for '
+                   'backup job, labeled "upstream" will be used also to run '
+                   'mirror benchmark for comparison.',
+                   action=ExtendAction)
+    p.add_argument('--dir', nargs='+', help='Directories, each containing '
+                   '"test-source" and/or "test-target" files, raw images to '
+                   'used in benchmarking. File path with label, like '
+                   'label:/path/to/directory', action=ExtendAction)
+    p.add_argument('--nbd', help='host:port for remote NBD '
+                   'image, (or just host, for default port 10809). Use it in '
+                   'tests, label is "nbd" (but you cannot create test '
+                   'nbd:nbd).')
+    p.add_argument('--test', nargs='+', help='Tests, in form '
+                   'source-dir-label:target-dir-label', action=ExtendAction)
+
+    bench(p.parse_args())
-- 
2.21.0


