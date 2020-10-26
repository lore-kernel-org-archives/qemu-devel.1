Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1729FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646DD206FB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hsg5evHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646DD206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6az-0008LJ-7t
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69T-00085b-9r; Mon, 26 Oct 2020 13:19:23 -0400
Received: from mail-vi1eur05on2123.outbound.protection.outlook.com
 ([40.107.21.123]:17409 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69Q-0008Ou-9U; Mon, 26 Oct 2020 13:19:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzgZ0GysBnndixUe1t7GxCwoGV5XqCVYLIrr2/xCkVXXsL3Snf3GgMCaR4svg1MHIdkJt5LzM8qPckgWsVVAchNFi7rhWUNIjAqjdyk9x4GjDwdOFOsFkbpogXfY1nawUWWVLPeYiYhOT3kTTYvZUGjbdoAzskFnsz9zomai6SRqVBtQmcinZqpr/hnCYmYU9GwCxrl6xlW6l9O2Jbih4NJp5PUkSaf4LklBC2B1FsazOVWx7ufpGTY/e2M6G3vJS4za68etubuljWL6kVCK2CeNk93GQBeinsft32rtt+SS7uw1YSn611Xc9e4Jq+oUHeIio1jOve7JULZQDBn5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyJvhW+2zXBcgvC+YU9kPP+DupghE59FnLqkhC5k/60=;
 b=URqShK1Xsfh38I2IoPK8BUHIcpqNgZ6tnh1jBzySu1dVdfPEdaGr6qQW8G+7K61kJfNhUojn5Tk8Ppcw5T8PeDaz44l4QLrjMpYkWqYe6MFmU//+KHiEVRq20ccWsjJc69LtLIbqaIAH04l/i1ihDn5DGt7LEaKKizea7s4P69Vivg3ElS8oxJamtWldc1uXIa/f7MCcRktMckU1+uAClH8gs7/moWPCuV8Zq71su4tXQXn4tI+Q/xUHLnHXO5mu4BoU+29LJc7eMPuh7DJhQ8ooPj4YOptKf6qQctAIND5RwxBHhLJIVRvI6yvHzl44dIIRwTmYHQzxrsO5Pmt0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyJvhW+2zXBcgvC+YU9kPP+DupghE59FnLqkhC5k/60=;
 b=hsg5evHqjAJ1Az/exNlr0GWtOvtIW1xPlj9V34baGWFsL7bF0W0xZ/0rK1Xw2xKfPh4YLR7uzhJ+LwNmQMjIcDKxwzMpG5i+1yjmFZKq0pmSyv70Xiej0OBEtuFzUSFfCAlBpq/kWU+ESKpBjEiI0B8DWvydaQTQToSOxNDOwTg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 25/25] simplebench: add bench-backup.py
Date: Mon, 26 Oct 2020 20:18:15 +0300
Message-Id: <20201026171815.13233-26-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1faad319-5f81-49ce-ce00-08d879d33654
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032228C3D92FD48E1A571F5C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JJN7Hh4qZS2fkjOW3zwdeaTiWn+1cHl48WnqDXkt20vL8FAb3VbYp26Uz1C2+HtQVUT6nyiSRJugb7JhtCdikx2b9iAgZG3r5/HpzzN6oOvOQU4bTdDBhyKEeBMBIPV9Q3IJutm9MBLmA+Yh3IDNJKQdsw5pXMQYl4MDZz/0NlBbI59umvoB4Bz8SVA7r8nPOw1PgFSxaG24YkG046YwktB39T+z3E13qr4RT9J3XyHXq8vuMyKLVBpdwVEw22eZ2EfI434w/XL/iV1wcQBttJ60T22UH/WpHEBlRJsAt+bQdTBZI1VjwCH9WLQ/GwVv3HtkE6NNojl0FFj/TmWEBugSHomDE+F/O436eLSy61aLWWA1N2rTfuKo0XGVmlR2M9+l3XDGsgdrrr3r6t/Kk7LUWvLiZzrrqjmW0vcRNjO33AOFvLD0beR10GI9+NBhb0DQoC94OImsN7ssMIdKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WNhrBQnyAXxP8oETKIZDt9Hg+YPgkeGuzloLFHUgeew0zPUS5ETyshR1SCf0sTh1H63E6qltaFCiTAzlsz0Ktm2Fe94ZctrEjxDa14Q+rvvDcOk6M1jFLSsabhEk1c3YqY10TA934b7VP1ZsJf1gFy/dgeqsry41ox+WFC3CigmR4YFcWItC9WJbxf+HzCAKnB0Xtj7C2uxTXAJjQI9HYjcvG6xszmH6f/f4Sk3O3Ls29Gp3nQ8cTsXaBQ3ddJzEhUMWyH3USPnoxQjkZHT9J0md55+aGVR6mbA+DXBHH6Ou+BJmbOjswCiSfmy5LubVcCwzeGWiLttY0FJwzMSLPNijJU0hq/6/6r0qQdFmEF/98F8tH2eonqC6STkWkDntmeL/Fp+b/LuRc09F52RPK2YyGPYefsEGXbviG5RlpgyjGTAztIGXgJ1ErmAR2GhLP2eKJ+JrdIR6Te98vyLl5RmoCV8a6IY7l9PRIb0xvyXvMcdiHqaiIMsEfFXCzWbJuf95t3oie5OAIoAfSfSMAbg34Gz11BcC5+QeNxP4WElP4DWXS5NGMRDBoEGIVOowDltDDxJ6uPuWZjJaLhuNUJdPN9etF6CkWsHjosdGIdk0axzqIi9JhAmnED8CH5kr9zIsFy6t/gHP8ZeEQzb6Tw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faad319-5f81-49ce-ce00-08d879d33654
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:53.1334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K73Kc8Q7kYcP2J1OAPEldp50CKuzTylriCmfbeYjGU8UmnOShRj40+DB5uILdY8T21vTLjYXGheSf1qE/rCILFf7FEgZpcwZKZwTtWIfT4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add script to benchmark new backup architecture.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench-backup.py | 165 ++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100755 scripts/simplebench/bench-backup.py

diff --git a/scripts/simplebench/bench-backup.py b/scripts/simplebench/bench-backup.py
new file mode 100755
index 0000000000..5c62b1a7ed
--- /dev/null
+++ b/scripts/simplebench/bench-backup.py
@@ -0,0 +1,165 @@
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
+import json
+
+import simplebench
+from results_to_text import results_to_text
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
+    binaries = []  # list of (<label>, <path>, [<options>])
+    for i, q in enumerate(args.env):
+        name_path = q.split(':')
+        if len(name_path) == 1:
+            label = f'q{i}'
+            path_opts = name_path[0].split(',')
+        else:
+            label = name_path[0]
+            path_opts = name_path[1].split(',')
+
+        binaries.append((label, path_opts[0], path_opts[1:]))
+
+    test_envs = []
+
+    bin_paths = {}
+    for i, q in enumerate(args.env):
+        opts = q.split(',')
+        label_path = opts[0]
+        opts = opts[1:]
+
+        if ':' in label_path:
+            label, path = label_path.split(':')
+            bin_paths[label] = path
+        elif label_path in bin_paths:
+            label = label_path
+            path = bin_paths[label]
+        else:
+            path = label_path
+            label = f'q{i}'
+            bin_paths[label] = path
+
+        x_perf = {}
+        is_mirror = False
+        for opt in opts:
+            if opt == 'mirror':
+                is_mirror = True
+            elif opt == 'copy-range=on':
+                x_perf['use-copy-range'] = True
+            elif opt == 'copy-range=off':
+                x_perf['use-copy-range'] = False
+            elif opt.startswith('max-workers='):
+                x_perf['max-workers'] = int(opt.split('=')[1])
+
+        if is_mirror:
+            assert not x_perf
+            test_envs.append({
+                    'id': f'mirror({label})',
+                    'cmd': 'blockdev-mirror',
+                    'qemu-binary': path
+                })
+        else:
+            test_envs.append({
+                'id': f'backup({label})\n' + '\n'.join(opts),
+                'cmd': 'blockdev-backup',
+                'cmd-options': {'x-perf': x_perf} if x_perf else {},
+                'qemu-binary': path
+            })
+
+    result = simplebench.bench(bench_func, test_envs, test_cases, count=3)
+    with open('results.json', 'w') as f:
+        json.dump(result, f, indent=4)
+    print(results_to_text(result))
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
+    p = argparse.ArgumentParser('Backup benchmark', epilog='''
+ENV format
+
+    (LABEL:PATH|LABEL|PATH)[,max-workers=N][,use-copy-range=(on|off)][,mirror]
+
+    LABEL                short name for the binary
+    PATH                 path to the binary
+    max-workers          set x-perf.max-workers of backup job
+    use-copy-range       set x-perf.disable-copy-range of backup job
+    mirror               use mirror job instead of backup''',
+                                formatter_class=argparse.RawTextHelpFormatter)
+    p.add_argument('--env', nargs='+', help='''\
+Qemu binaries with labels and options, see below
+"ENV format" section''',
+                   action=ExtendAction)
+    p.add_argument('--dir', nargs='+', help='''\
+Directories, each containing "test-source" and/or
+"test-target" files, raw images to used in
+benchmarking. File path with label, like
+label:/path/to/directory''',
+                   action=ExtendAction)
+    p.add_argument('--nbd', help='''\
+host:port for remote NBD image, (or just host, for
+default port 10809). Use it in tests, label is "nbd"
+(but you cannot create test nbd:nbd).''')
+    p.add_argument('--test', nargs='+', help='''\
+Tests, in form source-dir-label:target-dir-label''',
+                   action=ExtendAction)
+
+    bench(p.parse_args())
-- 
2.21.3


