Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551ABC2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE54B21481
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tJxanS67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE54B21481
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEOv-00015d-67
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFEKW-0004xl-Gj; Mon, 07 Sep 2020 06:24:56 -0400
Received: from mail-eopbgr40121.outbound.protection.outlook.com
 ([40.107.4.121]:56486 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFEKU-0002N6-Fx; Mon, 07 Sep 2020 06:24:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQebLhfLL9VGGzmN/j/8l3XvIvfzteWRzoOF0qyvEPkj+B+rn5VllmJGwHoDp1jE1PC4da4YtJ7HQVLoG4Nh20mmOXeHtpsVJbAHO2aD9VjZRla2lCCn+89y4+gto/sbEIIBlTnARQOByVpBgufQWjgpKkP1WmlXfqihXxA6spORePCaT7ENL27wX4sMv3saa6HBNFu5SImMee1R9m8F0H5JkJJt/vzufgQOPqvpq9uH2/brvKMKm6vXq8c9ysU0yXErd0TaWFNqNA9FAP+MaSg42R3v7h/YhnnA1oNFU2GUkmAKfwqNPwgNUpe5g3j965a2NRMiu6snU9AsVz/nXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMBLuMFV8567opUPhsFbcgSUUcxkxJ1vuADXCpqm6Fw=;
 b=Yhjq9JfWiESx2mXs65AqzA8kWbECYrS3x/eBWf1gyL/Oy812PRjtd2hOG8mQZwUwJH42g5efW2XI14EFEMrADQyujmJma8YbEAnxRqSxw76L4+0bmxndLAX9wFwRG396sb400887L2EToqfm1A/wZUCHhU1j+xo6kS95mhul12M0PC+BHIheiM0drIa8+Yr4Q4OMtODp/5H0Hy4XMIgY2Nr90K8nDNg1QO9VudUaf13bnrcnPRId6AFpm3Dr2lDF6Q1glWXIOejQJteQ9CCzFD+pLickuPk0zjjss7k+ud2OfMgUIEpzPhtYDrAgn4ZYmIjLjbnNrQjVKXWayv5cvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMBLuMFV8567opUPhsFbcgSUUcxkxJ1vuADXCpqm6Fw=;
 b=tJxanS67KpgHqvB8PYeR4eHD0KVBVAayyTGiOO71ce3EngacFMwrR1nhghU+4ddlCnyTFuvcI+6UJ8tXpmgIV9EbFFnp1epjB5JLPD8dkm682gL3LyLF16Mxn5/o225U7FsamzIs7DgmYnmWusOn3orCRuxXqsxKdJJHLHdzOVo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4722.eurprd08.prod.outlook.com (2603:10a6:20b:c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 10:24:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 10:24:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH 3/3] iotests: add 306 to test reconnect on nbd open
Date: Mon,  7 Sep 2020 13:24:26 +0300
Message-Id: <20200907102426.24766-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200907102426.24766-1-vsementsov@virtuozzo.com>
References: <20200907102426.24766-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.137) by
 AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 10:24:41 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.137]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f33260-a6e0-4184-837a-08d853183bda
X-MS-TrafficTypeDiagnostic: AM6PR08MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47220FD42326710A76942A71C1280@AM6PR08MB4722.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJZ9jbMNu4KYe16jUa4b8LKIrk83Kn2p2yfJXXyMSxl29+6K86SE3Qqax4ztySevoA+y3oL0z/Rlb5yb9BeZugiEPaFVskBUU9C5NumRmFDWZbn7W872iqmiXc+HvhaNNQvP1yuKSg1lGSB5P/L4PEwE9InOWIoPszs8uwffdmR9l8CB8rWxSV6TJhRVsEz+g1QKC90IK+KkC3IxG5/G578+EGWwChxrNVX4hrQdxwh87Cwr6oYer3S//2B0xJHCALitAazdfwlw0aVjc213mqnVmMPCDTysdLX/mBH9urDgIRVxcMBqnYZdFuvM7VS3IB09BmMdyF1GuuYaAaTWaj0RU82Z88IKtu2RJ9f/oPidd5M955VJp1A2uxuGCv4jXr5FrpVqdL/C3KB1fHWIAK57GZ0VORc5XrBi+HD8/Y4VvQIV7UNjr7bO2mm5GPHRkZAUtbQRGddtVhw/9dae5aAGNGvuVZRofmBdLgKKseg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(136003)(346002)(376002)(366004)(4326008)(86362001)(36756003)(956004)(2616005)(2906002)(6916009)(16526019)(186003)(107886003)(8676002)(8936002)(66556008)(66476007)(66946007)(5660300002)(478600001)(6486002)(1076003)(6506007)(6666004)(316002)(52116002)(26005)(6512007)(2004002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 78x793IdJ9LXr1qy/wh+RKK5Mo9tBcZfO1vjbNRztJLrmMIrURnxyl3tMoKlJTOMlOqnQ/waoi/qfbDyH3h+Unk+bQEJvczsKBpZGZSz6h8kkRqtIoODYVOzcU98GdlMdim28+90HtdsmYEjZdJCAhRc336XvD3wztx4wPIsXhE7QiZO7GqRsJyCXXpL51cPETZzLVn48N2xU6Y7MX4WFR1qhk7pqiRCGSJgYi8RbfrbbeRBkd1jslsn/nTtKU0HGuBnzwOmo2CzMTKKYkQxVM0sa3f6wwIbFYWdsjJyXNKNsYmjCrIteFoA77YZQJCisi00hTevKjyNwGcLYuWZoWMT+DMl1pzxk7URk63qDNdax1pjgRr8JAX9/tEZP/DIISHQYxsminnw/jeAHTL9fs3xKClMV1/sm3Ai0GUmdjVAXr7iIzhSpTD4B7L6FTMSgcb4iIZYyQTwHZY35O4WLBP6hc8YeW7ic1PM1oecQL8N7G4foDiEk+tuE4JN/vxFlfroJhn8wq7Un41bYeAOqNpyzKXZRFMCtpMGZxbFZXbaV3nhbvF9+iKmHCZ2W2sv7fTUmOHQYBjf6nEO9yPea97Pz5cjOdY94+Bwz1wDmQdznCceqmxdcvurXtk3qaXZRhfrjasEY6ej8E3tMZlt2w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f33260-a6e0-4184-837a-08d853183bda
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 10:24:42.3373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbMEg/cIXQXQCmd8Doghek4dQ8Yey2kHVQhTwaJS18jV293s1lgD20XCAq2oaxEapcZ+QZ6/AkLNHRVrxj/IdqfpvkoO4AiBp/C2dOm67zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4722
Received-SPF: pass client-ip=40.107.4.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 06:24:52
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/306        | 46 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/306.out    |  5 ++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 11 +++++++++
 4 files changed, 63 insertions(+)
 create mode 100755 tests/qemu-iotests/306
 create mode 100644 tests/qemu-iotests/306.out

diff --git a/tests/qemu-iotests/306 b/tests/qemu-iotests/306
new file mode 100755
index 0000000000..4b8b4090be
--- /dev/null
+++ b/tests/qemu-iotests/306
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+#
+# Test nbd reconnect on open
+#
+# Copyright (c) 2020 Virtuozzo International GmbH
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
+import time
+
+import iotests
+from iotests import qemu_img_create, file_path, qemu_io_popen, qemu_nbd
+
+disk, nbd_sock = file_path('disk', 'nbd-sock')
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+
+client = qemu_io_popen('--image-opts', '-c', 'read 0 1M',
+                       'driver=nbd,__virtuozzo_open-reconnect-attempts=4,'
+                       'server.type=unix,server.path=' + nbd_sock)
+
+time.sleep(2)
+
+qemu_nbd('-k', nbd_sock, '-f', iotests.imgfmt, disk)
+
+iotests.log(client.communicate()[0], filters=[iotests.filter_qemu_io])
+
+client = qemu_io_popen('--image-opts', '-c', 'read 0 1M',
+                       'driver=nbd,__virtuozzo_open-reconnect-attempts=1,'
+                       'server.type=unix,server.path=' + nbd_sock)
+
+time.sleep(1.5)
+
+iotests.log(client.communicate()[0], filters=[iotests.filter_qemu_io,
+                                              iotests.filter_testfiles])
diff --git a/tests/qemu-iotests/306.out b/tests/qemu-iotests/306.out
new file mode 100644
index 0000000000..82c74b4a2d
--- /dev/null
+++ b/tests/qemu-iotests/306.out
@@ -0,0 +1,5 @@
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+can't open: Failed to connect socket TEST_DIR/PID-nbd-sock: No such file or directory
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5cad015231..e2b479ffb1 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -313,3 +313,4 @@
 302 quick
 303 rw quick
 304 rw quick
+306 rw auto quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index e197c73ca5..7d8f53fe19 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -195,6 +195,17 @@ def qemu_io_log(*args):
     log(result, filters=[filter_testfiles, filter_qemu_io])
     return result
 
+def qemu_io_popen(*args):
+    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
+    default_args = qemu_io_args[:]
+
+    if ('-f' in args or '--image-opts' in args) and '-f' in default_args:
+        ind = default_args.index('-f')
+        del default_args[ind:ind+2]
+
+    return subprocess.Popen(default_args + list(args), stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT)
+
 def qemu_io_silent(*args):
     '''Run qemu-io and return the exit code, suppressing stdout'''
     args = qemu_io_args + list(args)
-- 
2.21.3


