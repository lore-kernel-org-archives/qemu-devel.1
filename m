Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0719EC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7356F2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G5VdCIDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7356F2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFvm-0007x2-FD
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaa-0006dU-56; Wed, 21 Oct 2020 10:59:44 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com
 ([40.107.20.117]:60672 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaY-00086M-12; Wed, 21 Oct 2020 10:59:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOecqCqmNawtcPfCgqRw0k9AFloUdvNfPbpt67TfzmbPjCSZRjpv6yl0jUqMFaNpwrMl6Ao+rE8UTwOKRjMzlYDHbFGXYcDJj3aNutMDCgH6kVwTqQnjJbt81hRZj1aX0ULhhiB1kchPmg6TigOavGnMkp87gvxsU0ttg22AoNsQE6uiY3vLTBndBkVYJWF3JNoS0iIGr1Ktku+vP2UmG66VOa9IcAxRw67X5pGrAYPJM8mTjkxIG3TW3RuwXfVd40ZWYnPha3IX7D3QislbzOfEq9FoBcqbGqALpB1mo7IKOgT/DX3DNgP6UolVge7ujFblaXqAQBugQ0NEsyqFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+5Hj5A0RR4K/eFpiMDFJDBnoVDR9w6FoL8CUK98Iyo=;
 b=KST9KF6jRcRBcsRwlOwVSVEiXh0pYBvnXRMlu31v3gcya86y4aus4+odBDObCpAKC4hpJ4VNCC+uYRJJ+QrYb1+9eHB88NtexqczUIDU9CvLAfIkYiEIJhowIlPYurhKK97V+PLrp2UgV/E/a0keIa4tfpOWQZ+AaQifMcINKD8g80KrWgPZUTAKS9cpfOM1gZ9nc4lvao5Xantj4tuc/9DyrjvOI9LClFNyhj6EhMrRjMfvIxxHKYJ9pydIOsw9FinPRCyjMqgNpZwtidHoij12IXUAO3odscVzRyBfFLRsyYpmQJbwD4o42K15tY2s8B6Q302Z/m49BL4tDu5GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+5Hj5A0RR4K/eFpiMDFJDBnoVDR9w6FoL8CUK98Iyo=;
 b=G5VdCIDbu8TKe+mMFQQyKIh5BbfB7sA/8cqw9VI6MUmB2GF23qG0+9G73ut6T0X43/2OBTwEVaxW2koRdupDAyP1z0GFN54g5o5GRmT89WmZSK+AoCoBzQ26z6ohjicEH7VGIhfVgvmOlURXqySZGp3cFsROiPo3RmMJi93cJF8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 19/21] simplebench/results_to_text: add difference line to
 the table
Date: Wed, 21 Oct 2020 17:58:57 +0300
Message-Id: <20201021145859.11201-20-vsementsov@virtuozzo.com>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e865053f-ba22-490d-3638-08d875d1e8df
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4472CA3F6F6343A7356E098FC11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9m4E/gYG1AbV5NkIU0r898rF10Hsk1GRtFJsgQaGJICVnbleBfmxJzxmQNRkaBp7CVhC0nGIkPSGCQYyn6g2sNjLCfs8ElOkwSNSzLBlpU+ooqe4n6QOX2OlwpBHQKJnyap2H8UGq9E62k2DDiJ8pQ+DBlHK5bzucSvgiG3xdsWp4HyJcOFq8GXydTH+UpTKG9DwQLDJrnxsKafOJd4iX6HcSlP3tguSLTv/sY6jNh3oxD+3E7GcMFFdHZW7LlyaOr+ZHn96N41131K2BR45RPvemBFM2BEi6ENtLC82fAKvWs/PqMiB+f3h00KIsD8JLZbSxmdbu9nBiXjMYT2S+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39850400004)(346002)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: N9P0iTJmz1Gx2ZE7e59ZfpgvStb6vHUgkw4Sjh9ag0KufNq49CB7PN/rzIb/seFHsYq2SDAhhHLtvSkH9+cP5pSVhLyISZAUWLCcFOQw9JybcJLwpME3NNxaCv0FpYBySYtPbjE58eGG0T8Cz2/8u6+5qi4WAshsX3g5SKBN/AYr76etespgE7mUl+XjNeCVx09gXVtN9tjnQhTUy3hTfVzK4UdQ4lds3cGCpMMPuwVVOBLyEFcnHh0hc50gSNOksobHwueVhPMr4s52P9PC77pBoyBLQwJRUz/pYKdpwdYzZF8rrByH4Sulneq6BCWGYfWK3D3e5KD+CkE+CJDOQqYLfSJ/VGSwBwC2IsH/XCYFd0c3Ks1cpQPqoMeYqjwlx758qGBbp94RnR3UVdt6+5S1VMBskX8FJXiM1VTOMo0GLitYBJpSwzyb7w326WOi40F78JEw1O4jdEbQgbOE7fqTZydbAkwbyuKLHAKPJDjF4W3neGbvK/U18DcV4Qox3zTq9fXyXZKNPasOaiFo8tGG65PSEXfAyk0Ega2jdL74hKkPQajNdOqYwl4M7C+R4RqkdFu6r7fGr55kX4C2r1z0X8T6wjQqRz1bDl6g/SlAJOegAYJ0LlZfGpNmzaiRSbXukIcMGDqFHr37CjNlkA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e865053f-ba22-490d-3638-08d875d1e8df
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:28.9736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSIoafpvB/k1+H/vM+PfgpfYsF0xnYODODqgPduiahzVTWJNTE+nruMKP/Mrrcp8QUzboHyHgHO91E06wQ6giNqd0wNWLNiPP5UOD0WzbSg=
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

Performance improvements / degradations are usually discussed in
percentage. Let's make the script calculate it for us.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/results_to_text.py | 67 +++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/scripts/simplebench/results_to_text.py b/scripts/simplebench/results_to_text.py
index 479f7ac1d4..56fdacf7ca 100644
--- a/scripts/simplebench/results_to_text.py
+++ b/scripts/simplebench/results_to_text.py
@@ -17,6 +17,10 @@
 #
 
 import math
+import tabulate
+
+# We want leading whitespace for difference row cells (see below)
+tabulate.PRESERVE_WHITESPACE = True
 
 
 def format_value(x, stdev):
@@ -39,21 +43,70 @@ def result_to_text(result):
         return 'FAILED'
 
 
-def results_to_text(results):
-    """Return text representation of bench() returned dict."""
-    from tabulate import tabulate
-
+def results_dimension(results):
     dim = None
-    tab = [[""] + [c['id'] for c in results['envs']]]
     for case in results['cases']:
-        row = [case['id']]
         for env in results['envs']:
             res = results['tab'][case['id']][env['id']]
             if dim is None:
                 dim = res['dimension']
             else:
                 assert dim == res['dimension']
+
+    assert dim in ('iops', 'sec')
+
+    return dim
+
+
+def results_to_text(results):
+    """Return text representation of bench() returned dict."""
+    n_columns = len(results['envs'])
+    named_columns = n_columns > 2
+    dim = results_dimension(results)
+    tab = []
+
+    if named_columns:
+        # Environment columns are named A, B, ...
+        tab.append([''] + [chr(ord('A') + i) for i in range(n_columns)])
+
+    tab.append([''] + [c['id'] for c in results['envs']])
+
+    for case in results['cases']:
+        row = [case['id']]
+        case_results = results['tab'][case['id']]
+        for env in results['envs']:
+            res = case_results[env['id']]
             row.append(result_to_text(res))
         tab.append(row)
 
-    return f'All results are in {dim}\n\n' + tabulate(tab)
+        # Add row of difference between columns. For each column starting from
+        # B we calculate difference with all previous columns.
+        row = ['', '']  # case name and first column
+        for i in range(1, n_columns):
+            cell = ''
+            env = results['envs'][i]
+            res = case_results[env['id']]
+
+            if 'average' not in res:
+                # Failed result
+                row.append(cell)
+                continue
+
+            for j in range(0, i):
+                env_j = results['envs'][j]
+                res_j = case_results[env_j['id']]
+                cell += ' '
+
+                if 'average' not in res_j:
+                    # Failed result
+                    cell += '--'
+                    continue
+
+                col_j = tab[0][j + 1] if named_columns else ''
+                diff_pr = round((res['average'] - res_j['average']) /
+                                res_j['average'] * 100)
+                cell += f' {col_j}{diff_pr:+}%'
+            row.append(cell)
+        tab.append(row)
+
+    return f'All results are in {dim}\n\n' + tabulate.tabulate(tab)
-- 
2.21.3


