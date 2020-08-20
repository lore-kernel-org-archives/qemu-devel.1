Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08D2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C22207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bkglD47a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C22207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pcb-0004YD-UE
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUH-0000y9-Ah; Thu, 20 Aug 2020 14:40:33 -0400
Received: from mail-eopbgr00104.outbound.protection.outlook.com
 ([40.107.0.104]:1630 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUB-0003CQ-P4; Thu, 20 Aug 2020 14:40:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSs4LfNixodFfukYw0w79TsUxAJf9GuJH/xr5rz79Ahrb4aYTZ9am2E+wDog/S1QPVEpfZAXGzcS9Y9TbsCepuYTnxFhDvoCw2HMnTlsBFs0C24NIv7dntIk1k8xEhiOaHhTSKBJHzWYnU5qW+amHaKSbc8+cpYh0RB8o2bDKh+iYTMYicCt8/48hiLvxtSUqKJ1GR662ZDggM1xozhVdc2E/BiA5qaFgwugirxW24G6QBD8omcM60TCsJretrIe6jSJNMWJ8gdQ329Aj422jh37ujMhgfnuoXvT2uUTxu4kOlpYUgAoxDRM42/h+ZU4Tx9pTwa0evXtEzD2Emr1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNWc3uvAHjhP7F3zdyGW6fCtrLJxdhDq6PVseTT8UEQ=;
 b=minwwzmCJUNY7j3bnviy78AOj8S+K9lZ82xaoiQUKdICjn5d6aNmMvP0PzFZRgIH/rQpxBZ5QUgdMpuJK8TKZqxO0pWFYKyrmAwzS3vbN0fZlY7DfLgp1/zIN08GoOrBdPYcK24eZx0ff0EeU0P+8dyi3lr3bJA7EqmD/F0EZgC5gD3eLVuGg3i5GTxNB6v8161O2mIkpjqFNQtPjfgby1qWcmIAqZfMuBH9d+ZdCDlfne5/7kAk0lNs2MpU9upN1z0SBSuvRATlv5hkU6RT6tj/sxssBWBu6jp6c9IpTho8s9/qDeK/U35zJdgXLEUYEXRjh9y/jBUkobMtVhS2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNWc3uvAHjhP7F3zdyGW6fCtrLJxdhDq6PVseTT8UEQ=;
 b=bkglD47aJkZJpMXrl15xo4V8BKv1zLBm+e40SaDoQ14IolD/et4k0au7cqTQJRep9RBXZ9CrkvzV7VLtvaKDTn263Ohs0gRTMg0SYF1BJa/t6QcL2fcme32xqKMnwIaZrqjfKlv9xqTgycMTywxaRQlifmUK2IcU760VV4ynoj4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 07/10] block: introduce preallocate filter
Date: Thu, 20 Aug 2020 21:39:47 +0300
Message-Id: <20200820183950.13109-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200820183950.13109-1-vsementsov@virtuozzo.com>
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 18:40:09 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f08633a-fd22-4512-a088-08d8453877ab
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032EE4A06D6F38ADA8FAD2DC15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wI/hrzN0n32ZjX4rKvpUB/+vMCeMPzWuAtk3BnRAqwKLVTQAAb8dJ+4Vdr3oC9GobKF+mAXXwEPZsTGnGDNdDnz5zS2HEQ+R48Y9O5yOLTb2gLsLVr5PUFJOv1JM+KAyZ35rxFodINHkPKJejhlXPfNZz3IEoEPPQPZx2R3FFkCaCd5wl/nEwao7XS55hzN4LhbAL36kPVJCk4CQB7UNuf3dBxE2ja87dDAfATbZ4JL7d76S+tXl4ABn0W/jWJRcKssQs7SpVPQ4XhnnHQkEVGDmUZqqc3L1bazq3sjBPOGYKLsDnnVkUYCTnz4UNMpJsw0c/RQXP4KtHPdDdxbu0uTzzT4pXwBdp3k9J1FMoj+w+Rsz66V2QZVymOuzrSvLJEXjje5ViZCaDyL6ySiLM/gH9xNnbHigIof4/3EYFtsZxISj40qsXE6Shv0e/7n0lamtDUHKwa8b6OyObnsL4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(107886003)(6486002)(83380400001)(36756003)(86362001)(2906002)(478600001)(30864003)(6916009)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(1076003)(6512007)(956004)(2616005)(52116002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qFfTqbMBaj0wDPHmq1TYUFDUkXUeeWKs1HeUF7du9Pf/NT4svlBAyBxGiQEIqrXGe0LJhOqeyoGSh3FzjyD2Sw/jJGinMFPwPdoqNR5JF53MxFc2kIeuKwe6VnjoUsFR2P+TYXCV1w5ah3LygqAZ3SS2cdf3aMAibBF9zZHpRx4J4rl3pNySloMmcaTLOlx3x1ovnwkuEUwLeQ8J2GdCxIjQDsEqYpnlv0p6MOwWgMvduPIjarpr50qsgsQ1fHq5dp3+/Fj44YzFkv7L6/5QgB4Q2yrMKnyfiE9YeXnuGzG8P/FOvRIFS7e2F5ZIYa2FpifSlqyEFLc/eQ/TCk1mnZ0MKACc7dtWWwAUpuvtW4N/Yk8uaokYyajiXmFPNcmpCJupfoNwutgfcwqLy2+u1mRdyAZkhYZThWBuyauxHGmpErLz6aVUif9QEFBfgi8daMTqhgBcdbAUYP+WRPeASjzpAT3N4GtQwmHEpJXcUpXjzxhd0fLaIPijoBdQ16SiZRSFg98wo4MR6HwueXMN703SCN6vpDFpzjUBjhaZfN+fL8S9udzptBMiePTC8XdmcLSRhxNkAcr4OOC9VUid9jBKouw8ySQ/nOcl4gb8BovQawXlK31zHPgNdHUgpkIzm2IEqL/qAoXooPLSqWiDFw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f08633a-fd22-4512-a088-08d8453877ab
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:10.3177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4r2nait6YFAiVvK72OPMSOJFtsdktvUW6XBDP9oFIV/SLMUA5C9WLJBXD10yeepvTAGT6Rs4WQ+KapEOL3qt0bPcLVPlpyGdV8wMWEic3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.0.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 14:40:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's intended to be inserted between format and protocol nodes to
preallocate additional space (expanding protocol file) on writes
crossing EOF. It improves performance for file-systems with slow
allocation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/system/qemu-block-drivers.rst.inc |  26 +++
 qapi/block-core.json                   |  20 +-
 block/preallocate.c                    | 291 +++++++++++++++++++++++++
 block/Makefile.objs                    |   1 +
 4 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 block/preallocate.c

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index b052a6d14e..5e8a35c571 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -952,3 +952,29 @@ on host and see if there are locks held by the QEMU process on the image file.
 More than one byte could be locked by the QEMU instance, each byte of which
 reflects a particular permission that is acquired or protected by the running
 block driver.
+
+Filter drivers
+~~~~~~~~~~~~~~
+
+QEMU supports several filter drivers, which don't store any data, but do some
+additional tasks, hooking io requests.
+
+.. program:: filter-drivers
+.. option:: preallocate
+
+  Preallocate filter driver is intended to be inserted between format
+  and protocol nodes and does preallocation of some additional space
+  (expanding the protocol file) on write. It may be used for
+  file-systems with slow allocation.
+
+  Supported options:
+
+  .. program:: preallocate
+  .. option:: prealloc-align
+
+    On preallocation, align file length to this number, default 1M.
+
+  .. program:: preallocate
+  .. option:: prealloc-size
+
+    How much to preallocate, default 128M.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 197bdc1c36..b40448063b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2805,7 +2805,7 @@
             'cloop', 'compress', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps',
             'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'iscsi',
             'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels',
-            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
+            'preallocate', 'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
             { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' },
             'sheepdog',
             'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
@@ -3074,6 +3074,23 @@
   'data': { 'aes': 'QCryptoBlockOptionsQCow',
             'luks': 'QCryptoBlockOptionsLUKS'} }
 
+##
+# @BlockdevOptionsPreallocate:
+#
+# Filter driver intended to be inserted between format and protocol node
+# and do preallocation in protocol node on write.
+#
+# @prealloc-align: on preallocation, align file length to this number,
+#                 default 1048576 (1M)
+#
+# @prealloc-size: how much to preallocate, default 134217728 (128M)
+#
+# Since: 5.2
+##
+{ 'struct': 'BlockdevOptionsPreallocate',
+  'base': 'BlockdevOptionsGenericFormat',
+  'data': { '*prealloc-align': 'int', '*prealloc-size': 'int' } }
+
 ##
 # @BlockdevOptionsQcow2:
 #
@@ -3979,6 +3996,7 @@
       'null-co':    'BlockdevOptionsNull',
       'nvme':       'BlockdevOptionsNVMe',
       'parallels':  'BlockdevOptionsGenericFormat',
+      'preallocate':'BlockdevOptionsPreallocate',
       'qcow2':      'BlockdevOptionsQcow2',
       'qcow':       'BlockdevOptionsQcow',
       'qed':        'BlockdevOptionsGenericCOWFormat',
diff --git a/block/preallocate.c b/block/preallocate.c
new file mode 100644
index 0000000000..bdf54dbd2f
--- /dev/null
+++ b/block/preallocate.c
@@ -0,0 +1,291 @@
+/*
+ * preallocate filter driver
+ *
+ * The driver performs preallocate operation: it is injected above
+ * some node, and before each write over EOF it does additional preallocating
+ * write-zeroes request.
+ *
+ * Copyright (c) 2020 Virtuozzo International GmbH.
+ *
+ * Author:
+ *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/units.h"
+#include "block/block_int.h"
+
+
+typedef struct BDRVPreallocateState {
+    int64_t prealloc_size;
+    int64_t prealloc_align;
+
+    /*
+     * Filter is started as not-active, so it doesn't do any preallocations nor
+     * requires BLK_PERM_RESIZE on its child. This is needed to create filter
+     * above another node-child and then do bdrv_replace_node to insert the
+     * filter.
+     *
+     * Filter becomes active the first time it detects that its parents have
+     * BLK_PERM_RESIZE on it.
+     *
+     * Filter becomes active forever: it doesn't lose active status if parents
+     * lose BLK_PERM_RESIZE, otherwise we'll not be able to shrink the file on
+     * filter close.
+     */
+    bool active;
+
+    /*
+     * Track real data end, to crop preallocation on close  data_end may be
+     * negative, which means that actual status is unknown (nothing cropped in
+     * this case)
+     */
+    int64_t data_end;
+} BDRVPreallocateState;
+
+#define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
+#define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
+static QemuOptsList runtime_opts = {
+    .name = "preallocate",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
+    .desc = {
+        {
+            .name = PREALLOCATE_OPT_PREALLOC_ALIGN,
+            .type = QEMU_OPT_SIZE,
+            .help = "on preallocation, align file length to this number, "
+                "default 1M",
+        },
+        {
+            .name = PREALLOCATE_OPT_PREALLOC_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "how much to preallocate, default 128M",
+        },
+        { /* end of list */ }
+    },
+};
+
+static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
+                            Error **errp)
+{
+    QemuOpts *opts;
+    BDRVPreallocateState *s = bs->opaque;
+
+    /*
+     * Parameters are hardcoded now. May need to add corresponding options in
+     * future.
+     */
+    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, options, &error_abort);
+    s->prealloc_align =
+        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_ALIGN, 1 * MiB);
+    s->prealloc_size =
+        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_SIZE, 128 * MiB);
+    qemu_opts_del(opts);
+
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
+    s->data_end = bdrv_getlength(bs->file->bs);
+    if (s->data_end < 0) {
+        return s->data_end;
+    }
+
+    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
+        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
+
+    bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
+            bs->file->bs->supported_zero_flags);
+
+    return 0;
+}
+
+static void preallocate_close(BlockDriverState *bs)
+{
+    BDRVPreallocateState *s = bs->opaque;
+
+    if (s->active && s->data_end >= 0 &&
+        bdrv_getlength(bs->file->bs) > s->data_end)
+    {
+        bdrv_truncate(bs->file, s->data_end, true, PREALLOC_MODE_OFF, 0, NULL);
+    }
+}
+
+static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                   BdrvChildRole role,
+                                   BlockReopenQueue *reopen_queue,
+                                   uint64_t perm, uint64_t shared,
+                                   uint64_t *nperm, uint64_t *nshared)
+{
+    BDRVPreallocateState *s = bs->opaque;
+
+    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
+
+    s->active = s->active || (perm & BLK_PERM_RESIZE);
+
+    if (s->active) {
+        /* Force RESIZE permission, to be able to crop file on close() */
+        *nperm |= BLK_PERM_RESIZE;
+    }
+}
+
+static coroutine_fn int preallocate_co_preadv_part(
+        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, int flags)
+{
+    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
+                               flags);
+}
+
+static int coroutine_fn preallocate_co_pdiscard(BlockDriverState *bs,
+                                               int64_t offset, int bytes)
+{
+    return bdrv_co_pdiscard(bs->file, offset, bytes);
+}
+
+static bool coroutine_fn do_preallocate(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes, bool write_zero)
+{
+    BDRVPreallocateState *s = bs->opaque;
+    int64_t len, start, end;
+
+    if (!s->active) {
+        return false;
+    }
+
+    if (s->data_end >= 0) {
+        s->data_end = MAX(s->data_end,
+                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE));
+    }
+
+    len = bdrv_getlength(bs->file->bs);
+    if (len < 0) {
+        return false;
+    }
+
+    if (s->data_end < 0) {
+        s->data_end = MAX(len,
+                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE));
+    }
+
+    if (offset + bytes <= len) {
+        return false;
+    }
+
+    start = write_zero ? MIN(offset, len) : len;
+    end = QEMU_ALIGN_UP(offset + bytes + s->prealloc_size, s->prealloc_align);
+
+    return !bdrv_co_pwrite_zeroes(bs->file, start, end - start,
+            BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
+}
+
+static int coroutine_fn preallocate_co_pwrite_zeroes(BlockDriverState *bs,
+        int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    if (do_preallocate(bs, offset, bytes, true)) {
+        return 0;
+    }
+
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
+}
+
+static coroutine_fn int preallocate_co_pwritev_part(BlockDriverState *bs,
+                                                    uint64_t offset,
+                                                    uint64_t bytes,
+                                                    QEMUIOVector *qiov,
+                                                    size_t qiov_offset,
+                                                    int flags)
+{
+    do_preallocate(bs, offset, bytes, false);
+
+    return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offset,
+                                flags);
+}
+
+static int coroutine_fn
+preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
+                        bool exact, PreallocMode prealloc,
+                        BdrvRequestFlags flags, Error **errp)
+{
+    BDRVPreallocateState *s = bs->opaque;
+    int ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
+
+    /* s->data_end may become negative here, which means unknown data end */
+    s->data_end = bdrv_getlength(bs->file->bs);
+
+    return ret;
+}
+
+static int coroutine_fn preallocate_co_flush(BlockDriverState *bs)
+{
+    return bdrv_co_flush(bs->file->bs);
+}
+
+static int64_t preallocate_getlength(BlockDriverState *bs)
+{
+    /*
+     * We probably can return s->data_end here, but seems safer to return real
+     * file length, not trying to hide the preallocation.
+     *
+     * Still, don't miss the chance to restore s->data_end if it is broken.
+     */
+    BDRVPreallocateState *s = bs->opaque;
+    int64_t ret = bdrv_getlength(bs->file->bs);
+
+    if (s->data_end < 0) {
+        s->data_end = ret;
+    }
+
+    return ret;
+}
+
+BlockDriver bdrv_preallocate_filter = {
+    .format_name = "preallocate",
+    .instance_size = sizeof(BDRVPreallocateState),
+
+    .bdrv_getlength = preallocate_getlength,
+    .bdrv_open = preallocate_open,
+    .bdrv_close = preallocate_close,
+
+    .bdrv_co_preadv_part = preallocate_co_preadv_part,
+    .bdrv_co_pwritev_part = preallocate_co_pwritev_part,
+    .bdrv_co_pwrite_zeroes = preallocate_co_pwrite_zeroes,
+    .bdrv_co_pdiscard = preallocate_co_pdiscard,
+    .bdrv_co_flush = preallocate_co_flush,
+    .bdrv_co_truncate = preallocate_co_truncate,
+
+    .bdrv_co_block_status = bdrv_co_block_status_from_file,
+
+    .bdrv_child_perm = preallocate_child_perm,
+
+    .has_variable_length = true,
+    .is_filter = true,
+};
+
+static void bdrv_preallocate_init(void)
+{
+    bdrv_register(&bdrv_preallocate_filter);
+}
+
+block_init(bdrv_preallocate_init);
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 19c6f371c9..f8e6f16522 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -44,6 +44,7 @@ block-obj-y += crypto.o
 block-obj-y += aio_task.o
 block-obj-y += backup-top.o
 block-obj-y += filter-compress.o
+block-obj-y += preallocate.o
 common-obj-y += monitor/
 block-obj-y += monitor/
 
-- 
2.21.3


