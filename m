Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F52C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675B12177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PA8fAf/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675B12177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFtd-00053B-8q
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaX-0006Vs-Eo; Wed, 21 Oct 2020 10:59:41 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com
 ([40.107.20.117]:60672 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaU-00086M-Sz; Wed, 21 Oct 2020 10:59:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/PikJLjd0mhX03pHKgqc6HZE4NdNx0RV4d8549Mep0cci7jFaF1cl2INK/sP7Msz2KudmUYjP7UC/7gGXCgZwrWCkbyT5XhUEld6MZzzM1MJ8AVkXRIiQeopQbi61V6duVZD6hzQHNzzwu6J54OnJD6Us2lRp/gbWV+wq5ejyKZwONbCPiy5qQLV6jOJO1rW2a7RI5kdfIX3LT5ScF/RJD3x58RPcRJjH+/p9DtMI36zc6ev0GpUc4em9tJ5s0vYExOSyv5QpWMDEGHqZA7h3PVyYOtvuO1CyZXJqlMgMrasfjMIz4g/fnl77LKO6rvVHK9tMdpz45RN614HphlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj/z0TGHy48bGzDIPGyP4zMOBmqroG9KOWvf9VvtcWk=;
 b=SX5w9iE3/jldtlw2T6Wxn+BMEtOTLzOw6QTQglJmdaJbVHAZzu6+a3ZDUYMiC+haBU+E2S+0It4gNK9Q5PpakYYseFksgYGeW/ZnrGm2MC+IyUXeTR7qeQskp88L1WtB8RGJGz646sA2w+dlR8Z+VB2EQ2iqjhFCYfNXKx4qFIe2VbFu4h3BhHOs54UiOkhGjwOPcizW/DlIlqSOHXRRh7SfONntq8x84L6rdoqnmxT/sYIFm9GakzywHySyeLlm0f1KxmQshUPjP1yiR9F5vOICf0JQou1Jm6Y7gHpMabqZ99Bw8+a6phng/fZNpcNaazn+vTKrW8ASBfZYVuqjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj/z0TGHy48bGzDIPGyP4zMOBmqroG9KOWvf9VvtcWk=;
 b=PA8fAf/DJTl4fDdNlA93nmpBMkTU1Z5pMaZ/pB1JN2kvp4nTRNFrDZEZCN3lnNVT1JMWAYE58tyfUU4ZBvBJHv7IZ9dUyyriRIAQXA8dNUXQGr66QU9pXf9zh6iB83hU1+k/8pjr8kKwaE9OBZti/5iijRQ0CfsuWGBQNqxtb8s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 17/21] simplebench: move results_to_text() into separate
 file
Date: Wed, 21 Oct 2020 17:58:55 +0300
Message-Id: <20201021145859.11201-18-vsementsov@virtuozzo.com>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4632389-00bb-4281-19b2-08d875d1e7e9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4472F7B422F509B4AE2451EFC11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeVyz2p7BHtCh9EsQsZLJinIMgrBNJEq6TbRVYWqkceFp2zf4nGdFK+9PrN7av3qk/7M4IcZy11r4i6jsM1DIO36q/PsRIeuZBYmnobRV9uZ7L+RokcpWrxwLgr3yemuEcqhW683/f9oRSzZc9acmJjl2KOh9LL7J36a5ZKPnUPENKz6dra9aLmDpKVDvdqUbmRz6yP5yRfhUxyLM9LlCApnTVzzFXbwUX1Fu0gOOFJHYWTkPnAI/sW1ZGn5ZNpBwjOGAsgnTd/bAW+17sQHpvpvujqjvfYg33MuJvjmuGEhji8BcxXzPf8mdiYPAtgPNyd3WIH9RRq4h7FjbZgsBTRx40Q8+bEVfyuUJHc0I86dwSNop3JicFYM25g0jzuqnbqvfoaYzPoXsyo8zsCt75KbKKv3DP6U7oYEUArecBQ1LbTXIsMEjNxU1K13tq/YSaSRoaIcdObTXjFZ1Ggf+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39850400004)(346002)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zX7Bb6mfmrttv9dxfBhOYrG5lOxJFd7oUoPz8bIq1/AQ1D7fCvPUqfbRbbJUpA94cRaud9gjgRS6zIPUJkds3Cp4k2rW8+VyneKWqicVHCCm3AwKScvqS+2Y+4Q771qmYWMuLk5oz74PQKUD2SXXx4WX013W9hBVTTZeuDtKKc6BNch89D2Q+5puYn6PFJgMjubud4TIdxkOzr/54BjiJGML53a2OQjAaQYUn9EF0FUK6YwE4y9X8uNagrY/8hd1Gxa8AsmPpGoqzuGA1u5XgniM6OYv15PMe+EhcJfuIIgvNOfU0Y1udxsr97jhWCSN29WqWjiZL1DFkm+UF/4UibhDRnvP419gY6lML06FaApDjQY33vNOPeO70rxi/LmzmIiVjkOGjufBaGoy1wBwrqGN7xbn3lRHo4+t5BX0EZvwB3VgW7hSFXyn5CTxOqvXMsErC49Mpu4EYGdQlciHHhONqoZQPnZudKqmGLRI13iH6En/qDmQWjkdaW/Uee6mjw/7MwTRlv4bs1e1l+wZu8PERr7Thi92T/MPwvcOVtwgLvrPgRKaf6kRrSLoWy6Lg3raSi5lccM3KJAD4Fqyx+S/vz7E8X8O0iiANz0p6JiPwGTn2mxWbPa3pdcAOy6lB9q7qD2QRIZzfrlMtHd69g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4632389-00bb-4281-19b2-08d875d1e7e9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:27.4095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIlAlT+TlDTSfAL1av1NDwLSsYYJjYXUVi7eYvkVRT930/ZUJaPqAsTfI1AZu8xvOtoBAK/vTxg/ywkC1TXlpQ9YsgP1Mu7GPbTnvYZ1YgY=
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

Let's keep view part in separate: this way it's better to improve it in
the following commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench-example.py   |  3 +-
 scripts/simplebench/bench_write_req.py |  3 +-
 scripts/simplebench/results_to_text.py | 48 ++++++++++++++++++++++++++
 scripts/simplebench/simplebench.py     | 31 -----------------
 4 files changed, 52 insertions(+), 33 deletions(-)
 create mode 100644 scripts/simplebench/results_to_text.py

diff --git a/scripts/simplebench/bench-example.py b/scripts/simplebench/bench-example.py
index f24cf22fe9..d9c7f7bc17 100644
--- a/scripts/simplebench/bench-example.py
+++ b/scripts/simplebench/bench-example.py
@@ -19,6 +19,7 @@
 #
 
 import simplebench
+from results_to_text import results_to_text
 from bench_block_job import bench_block_copy, drv_file, drv_nbd
 
 
@@ -77,4 +78,4 @@ test_envs = [
 ]
 
 result = simplebench.bench(bench_func, test_envs, test_cases, count=3)
-print(simplebench.results_to_text(result))
+print(results_to_text(result))
diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
index e175bcd7a4..da601ea2fe 100755
--- a/scripts/simplebench/bench_write_req.py
+++ b/scripts/simplebench/bench_write_req.py
@@ -26,6 +26,7 @@ import sys
 import os
 import subprocess
 import simplebench
+from results_to_text import results_to_text
 
 
 def bench_func(env, case):
@@ -167,4 +168,4 @@ if __name__ == '__main__':
 
     result = simplebench.bench(bench_func, test_envs, test_cases, count=3,
                                initial_run=False)
-    print(simplebench.results_to_text(result))
+    print(results_to_text(result))
diff --git a/scripts/simplebench/results_to_text.py b/scripts/simplebench/results_to_text.py
new file mode 100644
index 0000000000..58d909ffd9
--- /dev/null
+++ b/scripts/simplebench/results_to_text.py
@@ -0,0 +1,48 @@
+# Simple benchmarking framework
+#
+# Copyright (c) 2019 Virtuozzo International GmbH.
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
+def result_to_text(result):
+    """Return text representation of bench_one() returned dict."""
+    if 'average' in result:
+        s = '{:.2f} +- {:.2f}'.format(result['average'], result['stdev'])
+        if 'n-failed' in result:
+            s += '\n({} failed)'.format(result['n-failed'])
+        return s
+    else:
+        return 'FAILED'
+
+
+def results_to_text(results):
+    """Return text representation of bench() returned dict."""
+    from tabulate import tabulate
+
+    dim = None
+    tab = [[""] + [c['id'] for c in results['envs']]]
+    for case in results['cases']:
+        row = [case['id']]
+        for env in results['envs']:
+            res = results['tab'][case['id']][env['id']]
+            if dim is None:
+                dim = res['dimension']
+            else:
+                assert dim == res['dimension']
+            row.append(result_to_text(res))
+        tab.append(row)
+
+    return f'All results are in {dim}\n\n' + tabulate(tab)
diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
index aa74b78a04..f61513af90 100644
--- a/scripts/simplebench/simplebench.py
+++ b/scripts/simplebench/simplebench.py
@@ -79,17 +79,6 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
     return result
 
 
-def result_to_text(result):
-    """Return text representation of bench_one() returned dict."""
-    if 'average' in result:
-        s = '{:.2f} +- {:.2f}'.format(result['average'], result['stdev'])
-        if 'n-failed' in result:
-            s += '\n({} failed)'.format(result['n-failed'])
-        return s
-    else:
-        return 'FAILED'
-
-
 def bench(test_func, test_envs, test_cases, *args, **vargs):
     """Fill benchmark table
 
@@ -125,23 +114,3 @@ def bench(test_func, test_envs, test_cases, *args, **vargs):
 
     print('Done')
     return results
-
-
-def results_to_text(results):
-    """Return text representation of bench() returned dict."""
-    from tabulate import tabulate
-
-    dim = None
-    tab = [[""] + [c['id'] for c in results['envs']]]
-    for case in results['cases']:
-        row = [case['id']]
-        for env in results['envs']:
-            res = results['tab'][case['id']][env['id']]
-            if dim is None:
-                dim = res['dimension']
-            else:
-                assert dim == res['dimension']
-            row.append(result_to_text(res))
-        tab.append(row)
-
-    return f'All results are in {dim}\n\n' + tabulate(tab)
-- 
2.21.3


