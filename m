Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0EDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12783221FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YXqIYgxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12783221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNjP-0002sp-4r
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvNhs-0000Tr-S4; Tue, 14 Jul 2020 12:23:00 -0400
Received: from mail-db8eur05on2116.outbound.protection.outlook.com
 ([40.107.20.116]:22897 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvNhn-0002R9-NH; Tue, 14 Jul 2020 12:23:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+9vCEABLwcSIOrczf/hK7W3HGtDMA90cDykbh+GP6SQHdkUsI0Mn1l90R/69EahzM0ti2i13HIgtGaTHqNYy+121N4yH3XR484KAmkLX6g5Da2kmM2PuHyq1kt8KYoAHBRdpD53zKfgg5odgVlAX6gNq31mmNc3u+colb5UxhioyqXDG7TFusg2JDttFyD7uTnYmZw16wwfftwNU5tw7j+zBsc1WsysCCRfo8k9UJBdNcEda/a9OfCKtmbmBEOZQrUWEUqcJ3uTHkn6/Tydtvm2kuOzsc3VHNA7wpp/tjm9o2Dd39JAkwypjJ6xcuAelJkhfnxXCtCqXLpssqaEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/PlZw2LGkFV+PVcJLe+3W8RdSMvJIM08kQzd1mGQ1I=;
 b=GqcWuXhcfgQb4IIF8vz9ek7MXRgds6CVyq60/um9IsjDFJWsOaJ1PnpxV7X5kRmP8knO9/dfKW/AV6r/3VC79yNCg6dGuyRcvj+flpKdE9JkQ9vJDAtgqrH6VPQ9twEObV9WISdsRFE7C2mwRANjSLZZ2CBgbM10lkUQ4tK47r3jF4lKNVyjnrzvrBwDz6/ruONyFAiW4QHL8+G5WbJ5Svi/AD9wLOCP7IvocQglG6yjyMn7QVZkfVNnHTbVRVskczvZNrAswf1zsLYJ64KTUpTponlREEMpxHbeQWvoQdiYyTooHYsRaJ0GT5njtCL1m8+YfRKjUB/RL/x1CLPLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/PlZw2LGkFV+PVcJLe+3W8RdSMvJIM08kQzd1mGQ1I=;
 b=YXqIYgxNMKGv80xhXa7sBuqGbHBSbTtp14lK/4hijx3RiUS0tWcZqXo/qYJjw9I58SrldbhvGBkgJh6dF+NZZrP8JzjNssutSpSaPoTkyE2f23GmyAP9wwnrZ/VT4xnoUBLy81YWS3foCN+vPet41wbhtVEw9BNtdK05n/tOPU0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:43::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 16:22:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 16:22:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 2/2] iotests: test shutdown when bitmap is exported through
 NBD
Date: Tue, 14 Jul 2020 19:22:34 +0300
Message-Id: <20200714162234.13113-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200714162234.13113-1-vsementsov@virtuozzo.com>
References: <20200714162234.13113-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.164) by
 AM4PR0101CA0075.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Tue, 14 Jul 2020 16:22:47 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9036fdd-3434-4cc1-be9b-08d82812257f
X-MS-TrafficTypeDiagnostic: AM6PR08MB2982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2982C8E7EEB916F68715D808C1610@AM6PR08MB2982.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YPTgo8XHvyPZ7Z636z/t8/ng6ryw6ipD3UyNnY4utDvYCSy6Yhgc8M8HQ+0fMf/mkr1pHplYBBQHOPro8S/8w8FMX6EvggXjRxrKDVVHzWjKtEQ9aZOwam/AAMcZ8q42L57cXrXUUmCekpqAst5pADc/ziYwjSgP08PAKP/OCf/kCp1tbOp4e1BlNBELi0ilPYIjE+hKC+fpctzCnCzswKTsm3HGKh7UxSwT+GXEXT+nc0NG1UWtnu6N4jzXFM0iBqaoFvF37tPxHXHJ+kW5QWsUf+PTx3qrShSQX4eyZgdwGYA8VGF8m7DbWxXaRX4QhRk/Uqj2scKo/hIOHUUauMEBDlilNkOez25vVr2vN8i3stoadwZsPUAKyCSN4Q/jYIZR/Hl3NSutnMxDhfAtwC98E0KUbMCqB0xTgf3MDUjfsmgo7xZkzskvlYRGgUkBFCXK8F6CkZSLBFitBQ7tjkQ3rUACRN8FU2Cd79EKxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39840400004)(396003)(136003)(86362001)(6512007)(8676002)(6916009)(6486002)(5660300002)(66946007)(107886003)(8936002)(2906002)(6506007)(66476007)(36756003)(66556008)(26005)(956004)(186003)(52116002)(16526019)(478600001)(1076003)(6666004)(316002)(2616005)(4326008)(83380400001)(21314003)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VjlEN9AubhFUX5G6p76gj4S8tVVK+WRyhpO/MHuOWz7rNblmvpXuKO65Za2964dMU31i5I4kTRYrwgOedInD0XvuxrMU2J+nKyrtX+/1BYEiSVko3knHdaizLB79jgtW3nO73jRGjp0hfBJSWSP5d84O3oyylF7w6SDiKikzD4fAK63T8MBJEgviXgX5eVCAZgvt5Wo5C5sIwz7c/O1pPxHhXDTnSBEYs0FEocPctSYmy3GOTtKzmI1b7s3seKRqFBBKDQo7Qu1OT9z6rH7HLiN1Hx6NL577Z3StFyt+VooXLNPu6kgYIl6NoFbTroe85LWXVHousywRYMAO4EZH3azQaoj5dD4tCMYG9qjbihW/1wUYpjvdHOahgJNIYfGp3YuVRCmOZ8FSfZOx58De7EluEi6fr/r7/Oa2DD1sfdXX3y7ywodCc7TSQ2WZjHvFvI9q1FbaIqLnGQG54xflFUEdQqsup8pmopZECpC+WYA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9036fdd-3434-4cc1-be9b-08d82812257f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 16:22:47.8458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYh2rTU6WGh7klmgBhU0A4UDo67A4rrRtfAjInRGY0927CXao+7Jh9FVM+naQuvV43671tOy7ePHOeMKAz5xYbPEQJgW4aae3qus+4ECbRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2982
Received-SPF: pass client-ip=40.107.20.116;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:22:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test shutdown when bitmap is exported through NBD and active client
exists. The previous patch fixes a crash, provoked by this scenario.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/299     | 65 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/299.out | 10 ++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 76 insertions(+)
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
index 9b07a7ed03..b320e6688c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -306,3 +306,4 @@
 295 rw
 296 rw
 297 meta
+299 auto quick
-- 
2.21.0


