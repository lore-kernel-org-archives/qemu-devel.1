Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF5FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491E020702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pLzwI8k8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491E020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaPd-0006Gp-Ds
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaND-0002Dl-GA; Wed, 01 Jul 2020 06:53:51 -0400
Received: from mail-eopbgr10133.outbound.protection.outlook.com
 ([40.107.1.133]:2638 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaNB-0002JK-Gi; Wed, 01 Jul 2020 06:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA2OcxUNuP75Ph1f8nBss5xTTadNzfiAqk40qEVapYVAQMNYOjMROiPZpepErICMc3YvLe98m/M+0GLL5b+TidpKYyz3wMhdowNUFb0NUUKhsuqVejXsvhMHYY7yehTRUdT3/pwH5S76ttERcTEU3XCBrPyItEz+WVQ2kiyFeijNBmPUdME8aWFrV7jxAI59KbqjU94jhDRMKq3h355b46Zg0ZsFzO/a6CYR/lccvx0pQcVCmYjdHMKSxP66jd7Td1X2tty6RiqYriaSh+1ht5ihFZBiLpt/rltSEtJn2j5OUN9/7IYGvtQRKsub/KPEPiVuG2T3LI/N/Sl49JNLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INV8Y637qC2GJVOVxdRU5pSc9L2uP2EMdzF41dyXMa8=;
 b=STWtP+YxzWEb5c21t2+pGJMirzXyXmOxIw7720zfJ7wF7IXix3lMbXfk4jcq2pzIdLRZaL0inTM6T1D7JWI08QBRHLsRS/iTFGL6acNpBWct74EPwoPJ/lh8xf1ylt6HY1/p9oa2bBVarikp/7zPCQJngJGdmOolHKfKWJ0zVjylJ33F13r7UgEo6KtQkokxnl/h4LDb5IPtiHkBaR4IZIWtk2Sr/x6wcNu7BcB4dGb45ZXR4uhhTMtOM9aQTG4yCQM8f3xp3hqfTWAxp8QmjR1ulieI/Ly7xMIUl+y7BI8rPX8je+TsWjTFGKW3pcVLqSlQrMH0913ZxpnjAqaqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INV8Y637qC2GJVOVxdRU5pSc9L2uP2EMdzF41dyXMa8=;
 b=pLzwI8k8v9CYD6Kl9hIXBWEzlhi2QM20BPvuGf9cOHBfIs7A+grk3QhKOFc5c5kpeJNeqdIPk+Nj6DQQMzXwziW0A/1/NQe0OYvVcaA5A5iOo9MJcqVsF4Fig//IBCNKpQj0inD+rfKJwYgLmdGU6M4MlBZWQdUMiXZ6env9Fb0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 10:53:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 10:53:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/5] iotests: test shutdown when bitmap is exported through
 NBD
Date: Wed,  1 Jul 2020 13:53:31 +0300
Message-Id: <20200701105331.121670-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701105331.121670-1-vsementsov@virtuozzo.com>
References: <20200701105331.121670-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.28) by
 AM0P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 10:53:41 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcf01570-f800-408f-cc7f-08d81dad04d7
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48501FE4E084E9B648523819C16C0@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J71mtDPx81/WNwZjQOqEZrd2xXXKSEa+evYwDLUneIiDUvGhHk3I8xKBAayekDwCztcBh3Y5wZCepWnkoT4SZuFbmDlle7w4k4dC0D4VmsPzWtlIIk3vg0Ju78rE52IaacQiiSbikCFEwBaBb11v1sslD+Odlo75K11OIFbL1+3GeWlcrpYPBy5/GgMw2rdiUUYGMFEPTXvMPnji26XLEvwfeYLV7tWwa3DorAd+1j4ne7oGJEJ2b7FhRZRGrEjZ04UI/PT7B9uoNnWRTTL955M03woL9joXuFxjwLmXoq+bSxRAfMVSslkKnx3cgD+LnzK+ntUGWTGurTsLkKs0sLM8BIVUkyIFs7cE7AGTnqjSyJwfNejm78lkUXhnyeQM+grqt6KyUm6JBY9KerkYUOZ16khjPTAbf1G2i2jSqBKoYMVPCVkNt0aFIun6yfvqW2dXR56gY+7yZUAlCxl4vHBZS5jrRouJqDpyKmJa9V0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(2906002)(83380400001)(956004)(316002)(2616005)(6512007)(6916009)(107886003)(6666004)(66946007)(66556008)(4326008)(5660300002)(66476007)(86362001)(1076003)(478600001)(186003)(6506007)(36756003)(52116002)(8936002)(26005)(16526019)(6486002)(8676002)(2004002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iTaEELjJHYESdJnqjZWjHRCh15pCjy/4s6n4xrc1I51zxX3SnW5fcKDwAr0xNjWDo4iH2CUPF7dxGVDjlxJXHdLpG9FJa8LWFokpPvjxZi2Swg9S3F5m+JZyKTwQ6VixS4I/Xj/ORB/QLCyE7EkB/ALYRIVARpRcthUQOwT395Z9WZX/WXLVMdTwjYMmM53a8B5g/q9yK9fevcFmrVcSfgK+sq17GptqdAr/8YRNnbLpKLBvN4FYtaeXvpscF+aJUrDatCdHSUbeQYaeEJpDG9ElIqnnpGuL/aiWgHV55egf638cEtSb5D4h7shVoWd0hHBdEfAVGN5JPsTWDLXG5wHB28Hu1gTxGK93IbuXjJodIrBiQR+LgkmWPS2UW+IiXmZWuX9Ibtw5RrUlwu9S8T7XHy7jheisN+kg/P38Nv9QE1zGldUr9tlPZOTkkwjT1dBnFqqhHigMmPZSrXqqGAze8hH3fbF+PA3ng/zu0z4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf01570-f800-408f-cc7f-08d81dad04d7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 10:53:42.2586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz/anZ1oi/N9bLVzanavgwF5dlwFEUVpctMonnfTqysRzzl4B42MIMX9NFbagOBVg+yafmFS6t3TSmdhVUWMVgDJqRLRMW48QriwUOYqO4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.1.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 06:53:39
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
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test shutdown when bitmap is exported through NBD and active client
exists. The previous patch fixes a crash, provoked by this scenario.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
index d886fa0cb3..250192352c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -302,3 +302,4 @@
 291 rw quick
 292 rw auto quick
 297 meta
+299 auto quick
-- 
2.18.0


