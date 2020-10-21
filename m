Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C95C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9131C20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GSXCJod2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9131C20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFjl-0007Z7-5a
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaL-0005xa-Rc; Wed, 21 Oct 2020 10:59:29 -0400
Received: from mail-am6eur05on2139.outbound.protection.outlook.com
 ([40.107.22.139]:50030 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaJ-00087A-Bm; Wed, 21 Oct 2020 10:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Poin7yXmanrQJsICL8kwWBaTgtMtm/9fZh7CxKAMR2IZZpOcbMus8feMPPDTl2SMI3KnhH3QZPupy0DIsam5T0KuarL0T4NePPwAEGgJBxKJ8akcrgyngKn+vIkKZrkN5vmmanpwVeFUleu33F2/6Qmw8tjqX0wSr31htcRgd2Km3SQ1jMja4AE5i7eBPWO7VkcDv0qo9xSfVaMpWK+XpwMCxDvMAQzESGRw4lI3+Xc7RnGyN711mRuV9vBBVtTv4yaHxjLjZm7610Dix6r/JJlKL7xeT3/U7SbQgJUGGT0+MZT56aochIWErFOBcfQpF8iw6jAxFk4c4DEG7qOo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEXJBxVoOspw464yWfuxZJJdXbTjMB7KDl4x8Lf24Ec=;
 b=OHqvwsamF2dmSS2oj4BiiNuppPL1vnMl2cas4oxapsSiD2MNPsbKjwfE7MFnwWxXZAWwZgAMqPO3RR16T3EwC/0UDEcSvGel18flezrW5DohzLqxnd/EKKmWxLQ0kgD83qI06K8P//h+MNLt/jes2joVZwa3GiVYIf0U8QWGiCneacsDke2TYdV9b+RqkbgzRSETOqJXpbc3QrLWzdQ2GrrR/bhG9G98PaXAxYf0wPbat5/+hvH5x83/RBjXqyGrfZ9A1diq8vWekZD6pVab+5zmvehzv/m3dISNkXA+nOdbL1gZRachaHCxT2BtxUIOxvdzxdkNlNqGdx4GDotOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEXJBxVoOspw464yWfuxZJJdXbTjMB7KDl4x8Lf24Ec=;
 b=GSXCJod26oPP2ClV7nYOce0NvV4k+dK0HHBWkihDRzd0klXpTqGfNvBvzsJG76NjEwVM9fRCFs6XOkoaxpftQ3KSEEN4cwi23thJhjYX4jgBnJtYtQAH1++N13LHf0m5PHSigDCSLej+oudhuhChcW82Y8Kzs0ytIxOEuAZfhho=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3541.eurprd08.prod.outlook.com (2603:10a6:20b:51::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 14:59:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 14/21] scripts/simplebench: support iops
Date: Wed, 21 Oct 2020 17:58:52 +0300
Message-Id: <20201021145859.11201-15-vsementsov@virtuozzo.com>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d1b1a94-9801-4e42-728d-08d875d1e655
X-MS-TrafficTypeDiagnostic: AM6PR08MB3541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3541043B311A7F9660A11D81C11C0@AM6PR08MB3541.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61w3FXWTIcZsZKpFkAEBM0anAzB74ygnxKX+scqpMFF+oyTC3GNLcB9Agln/g8Asxvl0LE5I408Z2zNJ2Rx8JGYe+vt/Mjy5TDzvTkVIIflcGrm6MJ9dS3v9+K68tznD/FGW9jh7DZ0K1UANMRtsP1RdHuSwd9OqfezSfmfZ3e1UnJ2omn6k5c5Alk0HRXZ+i2X2PbZLMSpoJgxay336L3qlCaCMmLRJqvErZJGUg9f+o09gPAfEvq/1ist9I/YtMR3CzeOB3hW3oL9GpOhRfscunVqzDKpHJny0Lbp7lA7dtQxBUXgiLWcgEWsgbUgHW0wvFGPNKWIi4psbaoxWgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(376002)(396003)(136003)(6512007)(8936002)(83380400001)(52116002)(4326008)(478600001)(6486002)(6506007)(8676002)(186003)(16526019)(107886003)(2616005)(956004)(66946007)(66556008)(66476007)(6916009)(36756003)(26005)(2906002)(86362001)(1076003)(5660300002)(6666004)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: H413Q3jK0E/6m0U2vIK9JBeq6jqPlG3nmM9Fh3ZqxAhB4YtGoQaJ9ZxcGKYPw8DWHE5+Hr1eZi8MqGijefgH0OmHiHaOHbDvzp9zgVcFvnj7lpvlyfpKDiHqkBjm6O8YiLaURCtXic/VcSR9dAd1bfZUbw11cnNDwYyZvqs3W6rvcwRNlZhbAFrTAa1oJm/NhrOLo7G57ytjhJmGpnI3HoiSPAfRWgv8paaTnFLT/2Om6OMjpX3bq2K9+5FBPsklbB8jKxi/Q5CNXjiKbn/j7wF4Sk0F4lPv91Y66HXQFVRXjAgwATrd7vaPahUAlyTghpaq6NUzfp+XgGBXcynKDzrNoOXLziJm81DOarK9u3iuTdnzo11HLGQicUQmMzuKYN89n01D2WsYEfWo1P9L1YweTeAAaizEJFJ2Pgoz9VgvsB5Au9iaK1hbd4o7XJlNeNa4d2OAcWOT5Xu/XtqevYVna9VmA6p5+7xcxhzk39GIKP8YSKuoVDvPxtZD7z6xMD1Mo7NVox/ZppB6fKN6VHh1GddswiBpqu77XSHzRKwn4XJz/DOYjtoxHVt4B/yaVx08I651JS2rOCOH2IHrk4EpfM28ZClkFo5Yuji636ZA+qMbo2mOy88B66bSzXrqHfhJZI2YEe1iIGayYfqHGw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1b1a94-9801-4e42-728d-08d875d1e655
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:24.7313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVQc5hVMufC5BeO02wFTqKT3PKOGZ+OISw89ay1P1AHitCCH9qbGKKwwzOeOlZLHTKZ7zCZceq8OMNHPnTBOtuM2OUDh18+AgWVGcwJX1zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3541
Received-SPF: pass client-ip=40.107.22.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:25
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

Support benchmarks returning not seconds but iops. We'll use it for
further new test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/simplebench.py | 38 ++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
index 2445932fc2..2251cd34ea 100644
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
@@ -34,8 +37,9 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
 
     Returns dict with the following fields:
         'runs':     list of test_func results
-        'average':  average seconds per run (exists only if at least one run
-                    succeeded)
+        'dimension': dimension of results, may be 'seconds' or 'iops'
+        'average':  average value (iops or seconds) per run (exists only if at
+                    least one run succeeded)
         'delta':    maximum delta between test_func result and the average
                     (exists only if at least one run succeeded)
         'n-failed': number of failed runs (exists only if at least one run
@@ -54,11 +58,19 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
 
     result = {'runs': runs}
 
-    succeeded = [r for r in runs if ('seconds' in r)]
+    succeeded = [r for r in runs if ('seconds' in r or 'iops' in r)]
     if succeeded:
-        avg = sum(r['seconds'] for r in succeeded) / len(succeeded)
+        if 'iops' in succeeded[0]:
+            assert all('iops' in r for r in succeeded)
+            dim = 'iops'
+        else:
+            assert all('seconds' in r for r in succeeded)
+            assert all('iops' not in r for r in succeeded)
+            dim = 'seconds'
+        avg = sum(r[dim] for r in succeeded) / len(succeeded)
+        result['dimension'] = dim
         result['average'] = avg
-        result['delta'] = max(abs(r['seconds'] - avg) for r in succeeded)
+        result['delta'] = max(abs(r[dim] - avg) for r in succeeded)
 
     if len(succeeded) < count:
         result['n-failed'] = count - len(succeeded)
@@ -118,11 +130,17 @@ def ascii(results):
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


