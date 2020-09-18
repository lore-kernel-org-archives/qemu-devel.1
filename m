Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765E4C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CA6206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HYxw5LRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CA6206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLDR-0003h4-K2
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0F-0007c6-Vf; Fri, 18 Sep 2020 14:21:01 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com
 ([40.107.4.118]:41027 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0C-0004nY-EO; Fri, 18 Sep 2020 14:20:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkUuwR4++Yi+pzpB191hN7E9xehMP3/KBIuw8Pg5aWpovDHbnbeTh0FIjkmz3w1slTuA5xnq8H3ijtFwwZjuD33g1H0pXgF2yb+LbTftPYnytjNINkcTEl+iZqrouva7FBBHjbAwDWdmzyGAgUY/+MV0j7UjdHMdnUPxDRlLsG18QogMdXYYAPS6QbgfHgaz6WJVKkHHlkXVEtmIvvI11e3T4GTyJ+3vgE+a0kYCGPiZ+hjiMldWNNEk0NJPu1Izcp/ygONoCbeIkF9YYSjw8Aaa6FtjVAAacyj5sCKoZby3aZMjB/uFzlS26zwljqgs1YUlOdhsNW6shaWgL8tcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq8xuOhk5d5JLQAxmxNgkhhkjs/y4dVC0KUNG14nYtU=;
 b=mAw+eTHfLnq7zicAWWbGrI0X0HUVjBDNw72Ef3dT1MuhtlD02CTznL3OAcIewTrXYYVfJ6oa9MiOPU/qc8y7HMBSzPgo/KDTyeXknN9ZVw0yGZZgPjhW233gbp/tFMhy1yzj+FcVHILSGN+Ts17QjUpBO54KPBMbDqrYPM9PQHTmjER56u1Pe6sWqofgWFoHVt8TC8w799ED/CN8wbTyWKwlCSMubVrhJbBZt493kWWhVm1KRXWnX01WADqaHfyybDpqPH7e/cAqqcEoU7h/Fik7GTmLRkG7iWxyUqgCneslWpRxUITfTnaojZ5C8i6hJhQG9xVVN6HwpQ5VItAkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq8xuOhk5d5JLQAxmxNgkhhkjs/y4dVC0KUNG14nYtU=;
 b=HYxw5LRS9XXTpsAH3NgRn45Sk78TDZ4EoxvwVYNQEca/U90YJfQBFe7lKGnptzJtQwYVQ/CZwFheT07NjRiK4byX/WGgfNBQtp0zN+okt/ZtTeHNk91dNfdLUwpGmwv0AVVI2M62XoLrfIc5BKrX3m1RXvqCSN+c6SsoYKSIA74=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 12/15] scripts/simplebench: support iops
Date: Fri, 18 Sep 2020 21:19:48 +0300
Message-Id: <20200918181951.21752-13-vsementsov@virtuozzo.com>
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
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:15 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 881f40e8-eccc-4667-a586-08d85bff7e39
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB190554191DB5199AFB3E403AC13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4GA0XiDkEW0+9ilVlb1TxTnP4C1ITL287QIbeU74CR1h3MfUhAb39n7/khHWfM08zDiotO1hpXf/Wo59ZmwcUg6w7JTJz+bBq8C2K2KAyp9XT9h41hFkOitjChfmnbZIoVLE4v2r49qeTVTWwx3X8Xef3JqF6i/eZ2FboVs78bZizoKJ2HtZKxjCvTy4+5A7Q+CWxVAIZ50PKeMzXZRZ1E7/BUTFceFwLXFVkCeyTH+OXrt9xgNyuv6KHc8YGDlLzyNpZsicrNy7O2gBF1nbgdZZFdwR9ipAIM/fiWK9XyHZXqK4ve5I8re8fy7Ua5DeSo6l+NwS8llbpEWyy6k+fUNUDGRG10q7AhhLQfitVjliQW5ySHI1Dp0Q/JsKoOG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: X4cd2fCU0J5bY40Y3xjlLkSKGwQx/wFEp041skomOsRW9xxHaq+CPmZ5sk5JXtgBwN4qokadqsP1MOX9zY7vlHHK61ZXbYn3Y+0V4n4nmwdt2878j20CRFAUoP9dX3wAQJt6xlyRPIbgsEFhnDedwg3aEamUTsSHpAXo2jOd8pN7+WA5d/SgPypsejoKOjxK5qIQ+IRcDOTOLdyiydMUEX0kEsMqfryYXCgjLjgj+lsDpZs5Hsqp8rxgsWpqtLwXPYsxb0duY4XABrg985V+FHfUGw+BO+KaqKnBZbIqXjzmh0YUP5TxA7jIcLuvGW0mMrFurgq+uy7Ez6RLWHEpX13H9mf175Fs2udfR2fjsbEVjGsTJgf5XTOO5P6NtXQkVh1D5oCeQLBGQ/mmSTeUn8nOiyPYMDl6WZotQPx9QSl8PsNa6ZYHVmdy9kuyyKx4A/j2n+Kg0n5KmRjAqXM88EG2RYT8vK6FZ5NATbcfiEKCXX61fDJZEfQBV50JVKzifjqePLPV/VRQb3oLW1uI6ioCSUkvG53c3QLXVYHjpDVZYhDCu1uydHjOolC8f7YZMmj+FBn3PaAwohkW+X+XM3FhGRSBRktyG38y46aRwKTTmuszM4o1uCn08TtqM2THTG1UOwQ6Rnp3OqEcYlMnkg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881f40e8-eccc-4667-a586-08d85bff7e39
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:16.9024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GKvOacYWZwta1/hZwsNEmhzfR2dmGSZKov/0NMjFk2DDXZhSE7oGRqaWIC7/mALioyIB1bPEIfRkL7lH4cZ1TAaOXZl52+LkkDiEKBwjaI=
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

Support benchmarks returning not seconds but iops. We'll use it for
further new test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/simplebench.py | 35 +++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
index 59e7314ff6..716d7fe9b2 100644
--- a/scripts/simplebench/simplebench.py
+++ b/scripts/simplebench/simplebench.py
@@ -24,9 +24,12 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
 
     test_func   -- benchmarking function with prototype
                    test_func(env, case), which takes test_env and test_case
-                   arguments and returns {'seconds': int} (which is benchmark
-                   result) on success and {'error': str} on error. Returned
-                   dict may contain any other additional fields.
+                   arguments and on success returns dict with 'seconds' or
+                   'iops' (or both) fields, specifying the benchmark result.
+                   If both 'iops' and 'seconds' provided, the 'iops' is
+                   considered the main, and 'seconds' is just an additional
+                   info. On failure test_func should return {'error': str}.
+                   Returned dict may contain any other additional fields.
     test_env    -- test environment - opaque first argument for test_func
     test_case   -- test case - opaque second argument for test_func
     count       -- how many times to call test_func, to calculate average
@@ -34,6 +37,7 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
 
     Returns dict with the following fields:
         'runs':     list of test_func results
+        'dimension': dimension of results, may be 'seconds' or 'iops'
         'average':  average seconds per run (exists only if at least one run
                     succeeded)
         'delta':    maximum delta between test_func result and the average
@@ -54,11 +58,20 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
 
     result = {'runs': runs}
 
-    successed = [r for r in runs if ('seconds' in r)]
+    successed = [r for r in runs if ('seconds' in r or 'iops' in r)]
     if successed:
-        avg = sum(r['seconds'] for r in successed) / len(successed)
+        dim = 'iops' if ('iops' in successed[0]) else 'seconds'
+        if 'iops' in successed[0]:
+            assert all('iops' in r for r in successed)
+            dim = 'iops'
+        else:
+            assert all('seconds' in r for r in successed)
+            assert all('iops' not in r for r in successed)
+            dim = 'seconds'
+        avg = sum(r[dim] for r in successed) / len(successed)
+        result['dimension'] = dim
         result['average'] = avg
-        result['delta'] = max(abs(r['seconds'] - avg) for r in successed)
+        result['delta'] = max(abs(r[dim] - avg) for r in successed)
 
     if len(successed) < count:
         result['n-failed'] = count - len(successed)
@@ -118,11 +131,17 @@ def ascii(results):
     """Return ASCII representation of bench() returned dict."""
     from tabulate import tabulate
 
+    dim = None
     tab = [[""] + [c['id'] for c in results['envs']]]
     for case in results['cases']:
         row = [case['id']]
         for env in results['envs']:
-            row.append(ascii_one(results['tab'][case['id']][env['id']]))
+            res = results['tab'][case['id']][env['id']]
+            if dim is None:
+                dim = res['dimension']
+            else:
+                assert dim == res['dimension']
+            row.append(ascii_one(res))
         tab.append(row)
 
-    return tabulate(tab)
+    return f'All results are in {dim}\n\n' + tabulate(tab)
-- 
2.21.3


