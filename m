Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4075C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9032B2073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F5IzlBus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9032B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp5h-0002iz-OP
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouh-0005Qn-8h; Mon, 01 Jun 2020 14:11:55 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:10211 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoug-00027N-8D; Mon, 01 Jun 2020 14:11:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R53cB136DB3Eg+/dxd9tX+LvQ6bbCTXobvg0Q5wN9YW94fzTmz9WqCg5VbGoik5XDnyorNuqRWC5VFd8wSPt4ILVJ0GvxrxCLjSnDdC+P0teZqxzanKLS+TnHLca2p0DfbY4qZ1cUxB9lvgldai3DWmNr/nlRImL4uhjBSXuHUc6peyJQKJP12RNmVuMf0LeEyDtqpVqX84JSwbzpyiSC2r4OSvSDZ0xW9IGnk3WzNG26GiGJg83gAMbLg0YlxuwBlhuYdtKwtuw1OPbKsrGXjFgkFWHlRLFcWtWm9cdqRVp+EzqHQtbr3ow7TVfqL4Z1jTwuoPjTaf+vOtjhH+iJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRYGwYFnRiNvUOKySjXGOxsgPnCdKbAgtWwjjH0icW4=;
 b=T6ojhMi6vKuwR3LBBgjjGfoFB6dxkJo+a6Y8Cy2iWLRnvQ4NVNGtLJTCXHqSytwNy+lbfYsiBR6w/aI2iZSFwXUF6i51MTCN6XaGnN2mhL/UANCWIH9LJAskNDYdevkuZcej+kvh+2R8PuvK0W4MfEBhC+XYigOI6aR98adoYfmqg9Orjc+YIsTw5hKvb6bnS/RHa/MUUS/JGIroMgoPUPoKCk+4W71fry3Drv6/iBru/7+EmqpIgLsG+6dElQ/egM4uZRQrdNtfbQj8rpx+RSmOgscTWffXzHW/tvPvquzQvMlVLG5Pw7phhGxLJVDuTsSA0wFO3Xz/RMcM/DVdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRYGwYFnRiNvUOKySjXGOxsgPnCdKbAgtWwjjH0icW4=;
 b=F5IzlBusOH4M2WKvHzCTkc0Y1mclw3PZLkRbov6aQx2r9BczhIOD356QJpRjTKIvvv3BTV4nItbXS9IsvbXn2+CtnajRclhMfVf1pvN7DX9yKrReioY4uOUHmiQxGreucqqgFDtQVbB6Iq/DGiqAyKlapIABtxPZPF8B/6NrTfk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 19/20] simplebench: bench_block_job: add cmd_options
 argument
Date: Mon,  1 Jun 2020 21:11:17 +0300
Message-Id: <20200601181118.579-20-vsementsov@virtuozzo.com>
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
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:47 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7597b3b-2e1b-49ff-fa49-08d80657400f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53170B978BA3002B86DBD637C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yK4ZQGfVRhUTdLZOW2tyye4dmcl3uKXeq51E1PS7XjuvWlcJeiZRTBuz16gGef1GYbFmPhUTYweBWqqZmHdLBnZkcjWTeQf40eCYL2Zv95AYNzbWGuGJuIPU7GoeZJtmPn2nnV67eP5P8Awoouh4kgYAho8wqpW24rFny9cr3SZbYOiIUP9iyFQ+zmMTfR38saOzaZOr/U5exl6UTX7V3XkKCTdSBccUFYd1MlFERAKCIqrp56N60WELQlw4mv9pH/E5qH3keTsbZgTkq9+zVa8Q5J7M1OAUnlZAXAxG9AQI+hPG5WLwMrqA1J3WzOR1hQjNNeirAAfFB4N8zvrMJxWc6vz5btC8R5mH4PEguWEY+2mq1T+08UM/2d+t0z8p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FlR9tnOaFcncFPkTkGjyZHu8JKXbT2pDTdHs/hIpsHR/2pX1rsD6qH9+cb11JytCHwJjqmbUAKd17PKzF0KGHkOruLQXy0JpGIHcvGT4CUkIum/TfsUZOhaAqiD5vDIszn9psReVLxprGnqK4n617ymOVVIPHMlVr1XAtWgSQiMl9ss5h5qjgmX21T4X8YWhJWlNuJ2rDiMr16siHy+6z09buJXs+WxoGpCP5tMkFjUSjmIuOe2P3H47ntlQg16kpzGEs4FywEsAqTgPQRUzdJ6kguUQsIZskLx9CueupbASIz4ifvzqpBJzR+1LkXV0gv/mh+kgpZmg3wrZO9JNiSTBVOA9LWm6esSP6WznLfBKs0mzSo/nHBeLpVP9rFmY63KW4mQsAIPqTST2UgHghE85OhAGSawivhATbR6wEtiTbX4D14dYn7c/zUx5lkRC10GwxymYjbrtxtk2wlAffY8jBaMfbAWUtFasCdwng1M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7597b3b-2e1b-49ff-fa49-08d80657400f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:48.1104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFP/aXrtLP16xBdjrCxgLf3fbmTso1gNClhWeBk3iFsthSrJ21YY/x8wDQgKZRNciuAG1qs5g6RjsfNTiQto2tJPusy7IJ0LrmGYaBri2CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:40
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

Add argument to allow additional block-job options.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench-example.py   |  2 +-
 scripts/simplebench/bench_block_job.py | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/simplebench/bench-example.py b/scripts/simplebench/bench-example.py
index c642a5b891..c3d17213e3 100644
--- a/scripts/simplebench/bench-example.py
+++ b/scripts/simplebench/bench-example.py
@@ -24,7 +24,7 @@ from bench_block_job import bench_block_copy, drv_file, drv_nbd
 
 def bench_func(env, case):
     """ Handle one "cell" of benchmarking table. """
-    return bench_block_copy(env['qemu_binary'], env['cmd'],
+    return bench_block_copy(env['qemu_binary'], env['cmd'], {}
                             case['source'], case['target'])
 
 
diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
index 9808d696cf..7332845c1c 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Benchmark block jobs
 #
@@ -78,16 +78,19 @@ def bench_block_job(cmd, cmd_args, qemu_args):
 
 
 # Bench backup or mirror
-def bench_block_copy(qemu_binary, cmd, source, target):
+def bench_block_copy(qemu_binary, cmd, cmd_options, source, target):
     """Helper to run bench_block_job() for mirror or backup"""
     assert cmd in ('blockdev-backup', 'blockdev-mirror')
 
     source['node-name'] = 'source'
     target['node-name'] = 'target'
 
-    return bench_block_job(cmd,
-                           {'job-id': 'job0', 'device': 'source',
-                            'target': 'target', 'sync': 'full'},
+    cmd_options['job-id'] = 'job0'
+    cmd_options['device'] = 'source'
+    cmd_options['target'] = 'target'
+    cmd_options['sync'] = 'full'
+
+    return bench_block_job(cmd, cmd_options,
                            [qemu_binary,
                             '-blockdev', json.dumps(source),
                             '-blockdev', json.dumps(target)])
-- 
2.21.0


