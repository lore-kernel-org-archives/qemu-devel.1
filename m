Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63CC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B352822283
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MtxRYpYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B352822283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVG1v-0006Wh-LD
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFac-0006iY-TN; Wed, 21 Oct 2020 10:59:46 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com
 ([40.107.20.117]:60672 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaa-00086M-PF; Wed, 21 Oct 2020 10:59:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bd40wRcFw6Bv8YMqMqRtchl5zSci39EdDgWtBtF7+t8oq2ynvxkHXg2L43CTeqF/0dUzM3fbAy4eL7iksHFcDNXEpiZeB+2KacNOQfxKEef7urhenx11cX9DYDiiPQMqyTOZBRaD/FcZpCUXMTUw4sTcSE4YB2TTpqHrLYNuvfZTRYeXm08TwM/xjbo/HbqWKPTF2c14eR71l+5QvRndAEGsknqgxvqCgbwZD7Voirk+Vyd6WcnzX9MxwHL/IwWuAQrwn4q6YiTaItmyhM7Njnsb34bb6+PCkNBuTHV4FXmmF3C8bAGcwwZhUJlUuQ+vhrDWEe6Y1tjLa+XaNIbwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmkbsEUCLW5Lf9RTa7rh8ZPJoXPEtNaRYYtjwkC/+WY=;
 b=RCRvnVw+27BlDWs/D0IgkP4cJImHl9EhRaBrIQWceOdAxPNxq3M4hA9gVzcfXCulpnDoK/ibhPc2sBsfR4p+x53obri6Hcv1dm2STzOtPAeyk+6JNAwJ3gSiEY/lSGCL0cRwYsCMRCi9zti43QQUUU9Jfxlz2MtHXQxTiBA+Fu9F0qbcPxNt/qiC7CcQDaGPGBmYxJkVPoRSUuquRUbq/+zI++JreE5ho580GUVKpmmkHfgVNyH7+ekeZhwwPK+yWzfSqBL0b5wmohAih2K2SEDzZTMA9qfvftX7i8PdS6Gc5sqqovIUPPeS+QCNt1e8QMo8rOy9/PmWWrcL7bRm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmkbsEUCLW5Lf9RTa7rh8ZPJoXPEtNaRYYtjwkC/+WY=;
 b=MtxRYpYW9yBwBY9ecpF9koOaREVLphLeK1Ekr8yH2qPWupQ0DGDci+DG0kRC/wR5kgahuMrf2rrVKMI9OuzBcW1eb03XdStNe0JEPY6W9mhtICAkG+KfssXZh/ddyp0RtNBe9o8n/IvKTMBgz7p0LXNa2sEWvL6i/fsOmIoobnA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 21/21] scripts/simplebench: add bench_prealloc.py
Date: Wed, 21 Oct 2020 17:58:59 +0300
Message-Id: <20201021145859.11201-22-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bda071f-51e5-4f57-8679-08d875d1e9d1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44728AD1291782FC03EC7555C11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+h6X7LDoK40bH7YQPs52j8xvYSbkqAJWaIlNGbRfoUD/dRxK4ORA6h85Vi5/OOCeB8jrkt4AmYqB+zu0lLQlOv6EBXO8fonNdRhHaTP9KFahr5dvYqjrohI8RjBQ9s1qPAOrJZYkyChVB8JYjgoN7U3xuN9CxW0O6XyDX9StgT0H1jHMHISKl1R0eHBsIbkWeDEAbV/iI00TDi5al6ijvE/YyYURvIja1RWu8rpzm+0SPPRk+ineYWpwjCBJvLvQejJqp1QoVQJskuRCFVCjwq+W8qAvqv9ff3Kh95qrLsQS6Z/eSb0xZ+7wUN0qNAV6A9CWh15tiHikd7B5my9qoaobhNOsFktTALbzf9uyckuG7/6UTmPh8UxDoY9RXoMw+Z3ij/UEWlfYit2F4VRkers+YIjdYV+S04BQHwSimBfy/LRiVk9Plg3acV9TtFi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39850400004)(346002)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zYqmzD2d51ojG1IJ8NamQgdxCQBQb153FnTakyW/jt4E45NmLROWcFN4i2JaHcRqdu+IiWj9oWXEb3gdt+udXqKJ23Kjg7KPiMAxn/pHMT9PVcDY5ushHHHjRbNyuKJMMskDsWpGtZe2lx1m03lis3DrHqHCzk+a31ORg3ItBgYlfLaEKJsAA+EoOz1xGKoPduugl0JfraLx/BlTXLTy0rCrff+/ONevbdKf9mxt2nXLTcKdgDfzhGBtwK15bJYo30DX5IGtvAvSk9P3W9XiVesBIxxp/sf56iKnxjRcbNQlbpudJfCXlreqXwl7VqdvqJNvMSaRONSEI+f1sIv/5G3TRWok3of4I+SsOoILgjPEWBJcYpuEW3r4dLKcNB9CILzDvxtxhX5tu0FQC4X04kwVo2fMQt1tQIFnd3t48O/uA/IbJLPxuaXQwVnb5aI3HaerpEsgl3UAa6ClV33Gx12HGzM7dwver4/Pwnt2ldpv+j4wzUG1jxMxQBCCu7WizyOkKHJpGuu2v5wYKpuisagBttTY2cUD8UASSZNWzd4+wZs6eGneef6ux05V+Xa/Oc6CdLje1xUcfuImC1BEjQwtinkrKnY1BdeNUGaN2jwSANrlGpjvy4X2oGguN2rdvDJXYKFfnPiJmBMyo54BPA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bda071f-51e5-4f57-8679-08d875d1e9d1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:30.5557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/aCsCg6BzaWPTh6LtRmZ+7lydypOpN5qimJSQ8Jnwg79hJMxcIOjtk7jHJKMWkISJXtHW9D+8miyRVg/gYE6rqYHjI8jTqimLYvv3X4JfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.20.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:20
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

Benchmark for new preallocate filter.

Example usage:
    ./bench_prealloc.py ../../build/qemu-img \
        ssd-ext4:/path/to/mount/point \
        ssd-xfs:/path2 hdd-ext4:/path3 hdd-xfs:/path4

The benchmark shows performance improvement (or degradation) when use
new preallocate filter with qcow2 image.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench_prealloc.py | 132 ++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100755 scripts/simplebench/bench_prealloc.py

diff --git a/scripts/simplebench/bench_prealloc.py b/scripts/simplebench/bench_prealloc.py
new file mode 100755
index 0000000000..85f588c597
--- /dev/null
+++ b/scripts/simplebench/bench_prealloc.py
@@ -0,0 +1,132 @@
+#!/usr/bin/env python3
+#
+# Benchmark preallocate filter
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
+
+import sys
+import os
+import subprocess
+import re
+import json
+
+import simplebench
+from results_to_text import results_to_text
+
+
+def qemu_img_bench(args):
+    p = subprocess.run(args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                       universal_newlines=True)
+
+    if p.returncode == 0:
+        try:
+            m = re.search(r'Run completed in (\d+.\d+) seconds.', p.stdout)
+            return {'seconds': float(m.group(1))}
+        except Exception:
+            return {'error': f'failed to parse qemu-img output: {p.stdout}'}
+    else:
+        return {'error': f'qemu-img failed: {p.returncode}: {p.stdout}'}
+
+
+def bench_func(env, case):
+    fname = f"{case['dir']}/prealloc-test.qcow2"
+    try:
+        os.remove(fname)
+    except OSError:
+        pass
+
+    subprocess.run([env['qemu-img-binary'], 'create', '-f', 'qcow2', fname,
+                   '16G'], stdout=subprocess.DEVNULL,
+                   stderr=subprocess.DEVNULL, check=True)
+
+    args = [env['qemu-img-binary'], 'bench', '-c', str(case['count']),
+            '-d', '64', '-s', case['block-size'], '-t', 'none', '-n', '-w']
+    if env['prealloc']:
+        args += ['--image-opts',
+                 'driver=qcow2,file.driver=preallocate,file.file.driver=file,'
+                 f'file.file.filename={fname}']
+    else:
+        args += ['-f', 'qcow2', fname]
+
+    return qemu_img_bench(args)
+
+
+def auto_count_bench_func(env, case):
+    case['count'] = 100
+    while True:
+        res = bench_func(env, case)
+        if 'error' in res:
+            return res
+
+        if res['seconds'] >= 1:
+            break
+
+        case['count'] *= 10
+
+    if res['seconds'] < 5:
+        case['count'] = round(case['count'] * 5 / res['seconds'])
+        res = bench_func(env, case)
+        if 'error' in res:
+            return res
+
+    res['iops'] = case['count'] / res['seconds']
+    return res
+
+
+if __name__ == '__main__':
+    if len(sys.argv) < 2:
+        print(f'USAGE: {sys.argv[0]} <qemu-img binary> '
+              'DISK_NAME:DIR_PATH ...')
+        exit(1)
+
+    qemu_img = sys.argv[1]
+
+    envs = [
+        {
+            'id': 'no-prealloc',
+            'qemu-img-binary': qemu_img,
+            'prealloc': False
+        },
+        {
+            'id': 'prealloc',
+            'qemu-img-binary': qemu_img,
+            'prealloc': True
+        }
+    ]
+
+    aligned_cases = []
+    unaligned_cases = []
+
+    for disk in sys.argv[2:]:
+        name, path = disk.split(':')
+        aligned_cases.append({
+            'id': f'{name}, aligned sequential 16k',
+            'block-size': '16k',
+            'dir': path
+        })
+        unaligned_cases.append({
+            'id': f'{name}, unaligned sequential 64k',
+            'block-size': '16k',
+            'dir': path
+        })
+
+    result = simplebench.bench(auto_count_bench_func, envs,
+                               aligned_cases + unaligned_cases, count=5)
+    print(results_to_text(result))
+    with open('results.json', 'w') as f:
+        json.dump(result, f, indent=4)
-- 
2.21.3


