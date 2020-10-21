Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF402C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2582177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tPn6bNqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2582177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFuC-0005nL-3M
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaP-00068l-M6; Wed, 21 Oct 2020 10:59:33 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:29410 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaM-00087i-3s; Wed, 21 Oct 2020 10:59:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW4tMsDW3A2Dhepbj0Hro07qMkXPh7itVjkRt9wBXTqFHU0MVGVPO71lZy+pWnu2Ajwylh/3CzUHHunYNyJZZ1ZNgtFzusC+7/f9JRJcPWOGauVR+5gCUwC1fmkLvFy7+0M+hwMtLOdVolOBSajjib+LEPO6cF9c/P2RkOtNHXU2CaO7p2MYgnq0uTKzV4m53q6kYKSt39MleViuc1H8Y+UP+1m3oqLOOS9AtVSFH2fTyFNo1InMmEBwiNl53yEX/ycq8UTFhErAtZYxr5VFrxZiWsEd/Z/PERVCCA+J/npg8P3WF1ak8GgmFFyz0GWXSU9eoajI3ZoECqgwnlab/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUzbyurBn2JnvAZK2gIaZVQQ2JNkzIdVBrlRecRaxhI=;
 b=jo9EuSY1AajdrrMgryPfJQWCOLtj78NE7tmIMLonMQIvl7H/OErTUOcIoil+d5mpdEBSpqiQqx9iZVuFDzspADOb5lUVxOccrboP1oybT0qq5mjtUdClgctyEW6ofm96MOfXzrdkdEUGyyrt4uxReREnTDXtU6kJBJ7e3Y/OWtlp7Q2L/gpKKENvnqNDWkafrGl7mV9YENdWb0J1TIyoaAZUIgqaqhohLkCjz2KwtiIWXvBCkEW5YQZHnKxjpdCJvcyrJ5Bp80WNH1J8vYPDm8VAi23q6arh6jGFvlmERo3UrAXRV6oB97G1zl9OzDD75YYoO60ayG7v5spd4w3+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUzbyurBn2JnvAZK2gIaZVQQ2JNkzIdVBrlRecRaxhI=;
 b=tPn6bNqOxhS6Jscm5ZpZydh7MJ5vP/X7cBT2Yurc1/mgdIBnt/GDKSYxCsYkUIlsLgQVaiR8js62rqCoTqHS5ysIF2rL6YLDqMxrEwo5VPA/ZGjk1lN0xWeKHh7gW7LeB4FkC+3I/ZquyeD2kC4VaukyU0lzT1sKhRC+rz4Ifec=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 14:59:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 16/21] simplebench: rename ascii() to results_to_text()
Date: Wed, 21 Oct 2020 17:58:54 +0300
Message-Id: <20201021145859.11201-17-vsementsov@virtuozzo.com>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f013f1c-11c6-4343-0e74-08d875d1e767
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4849087CB400C9C1FAE70627C11C0@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8BLF7S0dmOg+2Ae+Cb30fOEKI1BTuvnQmV+okuyI+HdNaWQzSJXOjC6xVq/8Yx2eJlwkieg9eu34fhIxF7PlEygwyxVc/rb+eFqmVGEqUHlGsFNbtni+/wfg8HpYd1t23vgGEC0iPDhQYCSjwNJIiHHTfmudf31SrBFhzawnEfT4FC1whhXQM41e0dub1OWmhyPMKF2UrOwTiJnf/GcBXKAWrJs4PpHoBoB/m1T8GRmiiwL+aLYUUItXEr3UfSg9VRZA+AaSOQQ5HVkTSojZMctlD4vonGrGPR1aVF5wd30SapA2g9EefeiXwRwyVZr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39840400004)(376002)(6666004)(66556008)(4326008)(66946007)(36756003)(66476007)(8936002)(8676002)(6512007)(6916009)(107886003)(6486002)(956004)(5660300002)(1076003)(26005)(16526019)(186003)(86362001)(83380400001)(478600001)(2616005)(6506007)(2906002)(52116002)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FlilkmWUU19CE/4YOph8D/16JTtXFbKcxlY8OryyHY+ltb7DK8J10v0d+NCmY9TDMR4En5PKfgzwi+h3M1ji2jZTlAX0fdoGTkrmhIVjn0d+Qq8hQCMyUQUCpsK7MI79HQpK+BYrw3RSVkK3ZlfS5iJ3u6ZVDnwWMI31UdR+yIbQEHTwmn/JT8TN745gyYLfr8bjFAY3zN60w69AqX4Tkq6eSV9vc0CJBEQFNyBpKCRQjQRAxkPIv3R08D94Gn7reYIhVKV8tcQCmQkmAHBP4wM/YKJRFR6GSxYhmNZOyjL4mlRsF6NOqVOUAkPZjtsXHs3AAMo+URRZeSZNOW0TvQxTyX2vXbVReBkNdhEsRMO7UhVwaofaAer1sfAvIVDMV313u1q8xI57Y3N94Y2Fu786FX1eUEscp/Mk1v7sz8ggmht55f8qgqLmMsGjXCY0KFGDecVtJfjvOrhfsNw5RM6C040Sdh6swiy3BhI4YotT4TVT4jkwA8L70XEGLS9NnKCOczwZKn4d/Px+oVDujZ91ZjusVeZIRaYcBcT3mQ/DKV1IdA+LPFlAzDF8C68w1daeaxqm2DOudvhkqKipYrxA6bAVx/a7wUWEv2cXL9x10tL/AMfe53jswlkuY29H3n1C390rJX8cUv1eQhOoNQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f013f1c-11c6-4343-0e74-08d875d1e767
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:26.5124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMphS9/NEvtoT3bf6OkWBwa3V5X0Hg9n/vy5fZeSaeGxzzHHzfJc2q72Cg+nU+6pYsGHOdw6drl8N/8VqkueDdRoLmcEbkpSbV7cUam6dzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.7.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:28
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

Next patch will use utf8 plus-minus symbol, let's use more generic (and
more readable) name.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench-example.py   |  2 +-
 scripts/simplebench/bench_write_req.py |  2 +-
 scripts/simplebench/simplebench.py     | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/simplebench/bench-example.py b/scripts/simplebench/bench-example.py
index c642a5b891..f24cf22fe9 100644
--- a/scripts/simplebench/bench-example.py
+++ b/scripts/simplebench/bench-example.py
@@ -77,4 +77,4 @@ test_envs = [
 ]
 
 result = simplebench.bench(bench_func, test_envs, test_cases, count=3)
-print(simplebench.ascii(result))
+print(simplebench.results_to_text(result))
diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
index ca1178fd68..e175bcd7a4 100755
--- a/scripts/simplebench/bench_write_req.py
+++ b/scripts/simplebench/bench_write_req.py
@@ -167,4 +167,4 @@ if __name__ == '__main__':
 
     result = simplebench.bench(bench_func, test_envs, test_cases, count=3,
                                initial_run=False)
-    print(simplebench.ascii(result))
+    print(simplebench.results_to_text(result))
diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
index 55ec1ad5db..aa74b78a04 100644
--- a/scripts/simplebench/simplebench.py
+++ b/scripts/simplebench/simplebench.py
@@ -79,8 +79,8 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
     return result
 
 
-def ascii_one(result):
-    """Return ASCII representation of bench_one() returned dict."""
+def result_to_text(result):
+    """Return text representation of bench_one() returned dict."""
     if 'average' in result:
         s = '{:.2f} +- {:.2f}'.format(result['average'], result['stdev'])
         if 'n-failed' in result:
@@ -127,8 +127,8 @@ def bench(test_func, test_envs, test_cases, *args, **vargs):
     return results
 
 
-def ascii(results):
-    """Return ASCII representation of bench() returned dict."""
+def results_to_text(results):
+    """Return text representation of bench() returned dict."""
     from tabulate import tabulate
 
     dim = None
@@ -141,7 +141,7 @@ def ascii(results):
                 dim = res['dimension']
             else:
                 assert dim == res['dimension']
-            row.append(ascii_one(res))
+            row.append(result_to_text(res))
         tab.append(row)
 
     return f'All results are in {dim}\n\n' + tabulate(tab)
-- 
2.21.3


