Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A43C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3F020767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VLOX12Y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3F020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSvP-00019q-Bt
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSq0-0002rp-Rr; Thu, 25 Jun 2020 10:26:48 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com
 ([40.107.6.138]:2563 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSpy-00061d-Rq; Thu, 25 Jun 2020 10:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbAQ5ggpDuNObyR22wkFFkgZQhcZC6xtMdD3wMN+5BWCnVk+U/qh8b6TjQkOFrOunkbMaFJTG9C/ky6wb3rDxpyppHTUFnhAS3W/AxQn9Keds5dOfYiu1YrG2jRdP/1EVCTNdwHiWWQssfJ/sRxvMYGjNUQYUlh3PRv/J3fZ1C0rYe8NTjkm66FCslY/1AQeQbi+p5Bq7t9IixvISzyNJBQaGK2cmSrd6ziQJQYVkrH9T+wiBeTT/RqQogHCMzvJLG6TCJa6/4Q23VjlDGq5R9u0+oa1IRCKJ5/ZfN/qkKw5GdwGWOnMMXjS9GxFvPum9Y5QQ/0f0JB6f8vMGDBy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRo5exCgF0rD4yOM/HfO6/WA4BuwO/sih+kRw+C+q68=;
 b=Z7FmO/DqNuCuuPZVq355ql4jQhPpAurdPKFt84+4oHicjuJgCWePYJSn6azkimc4EXk77O2Ls5a+uqNsrIUGCqk2Z3688Q9F4u0/Kl1YjB1JgKfUoZ5w+a57iKnSz0B2SvH7AOuczfr8j1NNyDppQQMiirxANiSpLR9OjLwTTR0ESFF+O62AZxB3I1avg3wWk4bZVbMEe0WOm9gGf8CSuol6TheTZuD5fdHfNIflG2pTXcx6oVQQ2HFyoi8ZOcIGMve23bJqJQ+/ZsCRRmpufkN52verxxi/pqZ8VPjjovqnXvsf57cioyW6PvsXApHitPILr0AzEv2aHlpKYEs3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRo5exCgF0rD4yOM/HfO6/WA4BuwO/sih+kRw+C+q68=;
 b=VLOX12Y3MJ7XWrjueDWNBYZgnXCZmbVVcgbq6aCVWvG8Jky+i8ahAuukY9G/zbf9u0mtOHsAcJpHbHG0SrOtObGQn4fNu/dSbIYLLldAYe7Il6E9CQc+VyblIiewxM/AIx/F5mAzbGVe13m840wt1aO8pozG06NovfP52Km0TW0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2100.eurprd08.prod.outlook.com (2603:10a6:203:50::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 14:26:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 14:26:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/4] iotests: test shutdown when bitmap is exported through NBD
Date: Thu, 25 Jun 2020 17:25:40 +0300
Message-Id: <20200625142540.24589-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200625142540.24589-1-vsementsov@virtuozzo.com>
References: <20200625142540.24589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:208:136::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 AM0PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:208:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 14:26:36 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18616bb4-b94b-4f6f-d155-08d81913c4a9
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB21001044B767D18EB83A3942C1920@AM5PR0801MB2100.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eyjrv+RuEXjupnC8QdIVoXY5Nla6SW6vniSVcDejD5uBOjZ4t50D00X4kq/kqRqn5UDJN2XpdG+gv/tCcD4+yItjcy6w/KNNQZbO2Mnzq6kVp5yUnyUw0myApRuypyLKWwTrTxg7C5lDx7XSZucemdW3fl4O/Ag3Yl7+m4UFQe3hOBhAYMolkYTGhrGucrY8afZhaHOcqx2+wH3CJyBj1hwkuelgdOFdwI0ErEgl7fRSaI0ipmExvtFjFNwueyQPYE6nJUVp6JEbKwyxYg+NvdyJ5UHsHNPYSCHHLRdzk8EgVYQJxqcObXyVA82qZM5oDPKyRVRfzokxx0yjzhAPFUMGG8YioE0gPXbXwT2JwMTR7S1vXAo/fCnbObhSYgiSUF90icgZunSz6XN8Qfp5ODBKreBhnr1HOMFU9Y9drXgxCFDLyn+YTD/Wr65trgBAWS0VoZjJxJjNGkH4olI1HvF0wrlhBlswKoy0Z8zYGIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(396003)(136003)(376002)(366004)(52116002)(5660300002)(6506007)(2616005)(86362001)(956004)(316002)(36756003)(6512007)(1076003)(6916009)(8936002)(4326008)(107886003)(8676002)(66556008)(66946007)(66476007)(478600001)(6666004)(186003)(6486002)(2906002)(83380400001)(16526019)(26005)(21314003)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ElENr13cnoDcaCdTKYktElzOD+yGzeFFuP5BGOE8mcAz8LPDEyiriEq+lP2uOKhx+1HYqjKo/0ZvQizq/NbN+Xi6N0813V4S7h4A9BKDIr9urHcPU4ng4KxM/fSWGPcUW7y61d66Dozl0FKoi54AqVGTDGPck1quSQ/SOHh603EwWmiQYKfg60KtGF/zio6x5R4NP3jU6pXIOwfFO6UkuFXr2h4knxCbRROSEYt8warLF3Qype1Pfzm24YZoGY+9VNlPoyv1MK8XYKzCd6Yp/Kn9Itw9B8hftk1PT3+hZj1Nq+aqYylAKITctxlyuu59v1D4QlV91g90yvKA2620I2WrZ6dmAYloCaiEQoY1/FHLxuJvpmKOyYO50ix6d9tgj8CbB0kd1d2Hq19Au/RMEajADJZxtnhgzp+esloXSqYyy5XjsJsQWlCU9kDuQgQUog0l8Hkgc0VZqhUDH4Ox/cNrRB/BE3bY4HM/GUSEwt8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18616bb4-b94b-4f6f-d155-08d81913c4a9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 14:26:36.8666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wppvyFFL33Llr/vCQrOUYM2XR27i4KZO9YRjYBi2HCVTXV4L1WIMpmf1IREmyQrfHjpbOmib/zgG110pI+ADj6NtzNCODLYgQJ3qNYAOcEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2100
Received-SPF: pass client-ip=40.107.6.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 10:26:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test shutdown when bitmap is exported through NBD and active client
exists. The previous patch fixes a crash, provoked by this scenario.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/299        | 65 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/299.out    | 10 ++++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py |  5 +--
 4 files changed, 79 insertions(+), 2 deletions(-)
 create mode 100644 tests/qemu-iotests/299
 create mode 100644 tests/qemu-iotests/299.out

diff --git a/tests/qemu-iotests/299 b/tests/qemu-iotests/299
new file mode 100644
index 0000000000..e129c7f7cb
--- /dev/null
+++ b/tests/qemu-iotests/299
@@ -0,0 +1,65 @@
+#!/usr/bin/env python3
+#
+# Test shutdown when bitmap is exported through NBD server
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
+import iotests
+
+# The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
+iotests.script_initialize(
+    supported_fmts=['qcow2'],
+)
+
+nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
+nbd_uri = 'nbd+unix:///disk?socket=' + nbd_sock
+size = 1024 * 1024
+
+vm = iotests.VM()
+vm.launch()
+
+vm.qmp_log('blockdev-add', **{
+    'node-name': 'disk',
+    'driver': 'null-co',
+    'size': 1024 * 1024,
+})
+
+vm.qmp_log('block-dirty-bitmap-add', **{
+    'node': 'disk',
+    'name': 'bitmap0'
+})
+
+vm.qmp_log('nbd-server-start', **{
+    'addr': {
+        'type': 'unix',
+        'data': {'path': nbd_sock}
+    }
+}, filters=[iotests.filter_qmp_testfiles])
+
+vm.qmp_log('nbd-server-add', **{
+    'device': 'disk',
+    'writable': True,
+    'bitmap': 'bitmap0'
+})
+
+p = iotests.QemuIoInteractive('-f', 'raw', nbd_uri)
+# wait for connection and check it:
+iotests.log(p.cmd('read 0 512').rstrip(), filters=[iotests.filter_qemu_io])
+
+vm.shutdown()
+
+p.close()
diff --git a/tests/qemu-iotests/299.out b/tests/qemu-iotests/299.out
new file mode 100644
index 0000000000..bba4252923
--- /dev/null
+++ b/tests/qemu-iotests/299.out
@@ -0,0 +1,10 @@
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "disk", "size": 1048576}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "disk"}}
+{"return": {}}
+{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-nbd.sock"}, "type": "unix"}}}
+{"return": {}}
+{"execute": "nbd-server-add", "arguments": {"bitmap": "bitmap0", "device": "disk", "writable": true}}
+{"return": {}}
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d886fa0cb3..250192352c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -302,3 +302,4 @@
 291 rw quick
 292 rw auto quick
 297 meta
+299 auto quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index ac9d199a1e..31d4b105ca 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -345,8 +345,9 @@ def filter_qmp(qmsg, filter_fn):
     return qmsg
 
 def filter_testfiles(msg):
-    prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
-    return msg.replace(prefix, 'TEST_DIR/PID-')
+    pref1 = os.path.join(test_dir, "%s-" % (os.getpid()))
+    pref2 = os.path.join(sock_dir, "%s-" % (os.getpid()))
+    return msg.replace(pref1, 'TEST_DIR/PID-').replace(pref2, 'SOCK_DIR/PID-')
 
 def filter_qmp_testfiles(qmsg):
     def _filter(_key, value):
-- 
2.21.0


