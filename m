Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A016FC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30B7206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uXcWuzCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30B7206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLEA-0004Se-OL
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0M-0007fx-El; Fri, 18 Sep 2020 14:21:07 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com
 ([40.107.4.118]:41027 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0H-0004nY-KJ; Fri, 18 Sep 2020 14:21:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyRkXGGjjygKfjnoo3RiQvq8rSjtTgH33QQ1zG8JDw/4sYIzQ3MXcmLzSAwVvUPONlBJrZGCcoRe7mgVO74/N60ohDhh9yq//jOpQUDHMrPWbRZuRc3fQEVscBYo+C3dna56XS4tqo3v1CsWEZPK9VHcTcPcD23cO4z/dW3I0A7yOohPS/Rm3uctvghl8BYRrO5vakptq7HODwTJIK2b7s0Ftrv+cJBLemrcb/21ktrnYfIzX5uwTMT26NSSOZ3pErtCzxesEH5U9+upHt1NyNQII88qG2G6MR7cWnhHFe0CKghpP9TTUy0zr/tiOb2QXEjgJ32HtqyicnZVW5tTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGXx0477ugW7n4dPTvPsMlMEHRdvyN59tIlfSH9tDOo=;
 b=G3JpwVRdnu1TbsueyN2mpQkzv2zszRirmJtZH2DCE6+3sqEJtgmlYSTK/uC7dDuO2q6J/ljCJV6Iaoo++kq2tahFqL3ESRkiDpTgMFXAIz3m/LTyDNSj6xBFM9RiHVbr5HsTw0BPIlYdtsBnJvzBuX3pyUWt7IyepaGOf0AsHMs58C/c0X8AsSoQ73lpSJhV9FHTXaKc82yr09cWU9QLv13r4iTfL2XzeqTIIDQepKB323ik92uphhNeIyhvRtEM2bkaMul3pTxV09vRW6WWnmWAcGpfKfwnbehHYATKKPh36ed5FeowcT5JOlLqJxgE9atcBdrEjFhe73TsAzOAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGXx0477ugW7n4dPTvPsMlMEHRdvyN59tIlfSH9tDOo=;
 b=uXcWuzCM6TYN7ILQ0p3+djj1TfIcOAsFOOCY9F6JnP80udWl0sBDyWmfbGLd+UnHnJcNWB+rPFNGPbQk/bqFYyAnMQ8fiWHTzhYE3p35KSjlKYEIzRxtgnZTBVMN1GFmZuZUIkRleSREYeL90+HeI3RTI5054m8S3fLk5qmcaAI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 15/15] scripts/simplebench: add bench_prealloc.py
Date: Fri, 18 Sep 2020 21:19:51 +0300
Message-Id: <20200918181951.21752-16-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:19 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27181466-6393-4b63-557e-08d85bff8007
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB19051C624C01FFB10C72E521C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keScvEvZxUXz21ggXQStW58rhCLFYppWbDmy0KNdV4414Ea9QupAY6CIdkf6J6z9JcdCuAl2iuQCj5vP4HEshSIrL0xl3W28O9UXGHY3q+g3syl1cmldVOGSxkGeJP9XC4d1pGRjdgJl15vLEFHw+sdum/3PKOqiziX791ZdWJ0K+9Cd0tv309XKL18zjCBvWiiGQEuqDrCFvIikW67q237HtvOU/SP3TvQHMRfkUg7G0npbUrcdK3iWNl9ig+k625frjUj5uKr3fn0ChRyNx1X7am2RFKZp/p9TiodD0yZuzM0QIUvuLp9CjNQcb/cawc6dWasy6UAo5oQYLjrmif+kY82CllLmgoQwAuOxkN6czGrXwTWOqdeqowsW/lkzdCmkZfCEUVbLrShParilR3xbvP8yMxREbSi+Y8ZHVBgWQEDbaViCO+PIjv27v5BUYomGITxYppD5UXU1qaszFq4jzR/npuHf4RjkjrYQMs3OYnFiOcdZ1DTskMeM2nkS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GNoyOSFNF/esP0Ia/wR1AFkMVLPSyl07bVpQ1fojrujhy+YU+bJ830aA/wwxaZP0sszQ1ojnRE9TjDYmlu3zTqVQiu89MM8wBcH9oMWtTzxBLrjNqjqyKpCwld7eetXsG+EMyAtas/97ro6Yjvbsd7dCeOCQg/QCogLJYKGFUURpFxyr/x+BvEUMky/BgSxwRSjGiJoje6Q8LEe4zF1PRq5vXDU0ytLYHa13Cipch6ZUGmUouktuArQYl0YWZE7eg5hYxMw6bwrd9AnG+xznyN8UTCcb6DwhLKhtyuUc97IWU46hLVFJyukhja/FhuohMG/MmhT+wf5e4iKl171z7KpceewHkDdwbDdX8bulgnBBe6QftQYDY5lP+0eNCCGgjdlwPGJkn2AL/jLMKOdjQ8uxeJMgO5RdTrVEdH9YbdlIWz1odgmOYC0IOGHSScbhamQe9R5m4QyVV/0DYb2nLD8fD/olPkBzENJJF+t71U0aCSqvqjxHojTcKrMtWy+lRpdiXgOgb1qQIPbkfMoshO+V/2AuCFnwCCZ3sYck6eAwlo0gn+b1yNI+dqaSsPbfQSj01uF+BBJ21S5CygyY4j4BsP0b+aXK+PH5xK1RLJ9BwLTd90f6RIiV7oNA1gyKIHtwqKJSD+k01AML7+P3KQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27181466-6393-4b63-557e-08d85bff8007
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:19.7469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKX77NGqCO2xxMtNJy+0WLvqc9Y2xTrse8ze+lsucRvyTBpu27LTGYtjtzfOs6KiYGtFhZbL+V/7gVaZXeq04zHrXb0vT4Hssf9FjufB8CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:23
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
 scripts/simplebench/bench_prealloc.py | 128 ++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100755 scripts/simplebench/bench_prealloc.py

diff --git a/scripts/simplebench/bench_prealloc.py b/scripts/simplebench/bench_prealloc.py
new file mode 100755
index 0000000000..fda4b3410e
--- /dev/null
+++ b/scripts/simplebench/bench_prealloc.py
@@ -0,0 +1,128 @@
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
+
+import simplebench
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
+    print(simplebench.ascii(result))
-- 
2.21.3


