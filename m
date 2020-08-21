Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A27C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FF02075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m9eGyscg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FF02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97s6-0001DR-9x
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lr-0005VX-St; Fri, 21 Aug 2020 10:11:55 -0400
Received: from mail-eopbgr50124.outbound.protection.outlook.com
 ([40.107.5.124]:48515 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lp-00053q-6a; Fri, 21 Aug 2020 10:11:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajQD4TudfbfqRSyxljGIqtEFaqrlG/TtlhPhlDaAEMbvU/7G5n37x73zeVNh4FKMJj7kZ9WvIDnl0YX1+GAu+D+uyzawHdmzbNfkDvnjr6HW/vu0igagziWrKw217MnDmn/QaOUMFJlcrGEI3SnmOE686N8H1rnNuYFTa7rZj+7+4F6sSdAleLMR7EiCStt1PtKgklJmaGbjOM38fN5TTYDdPNp6vpily/kTcS6zX1Jjz+HjFYrc0XLBPrrfeHbqcyhrL9Z5spzmsZCAjETdLRfiZBCXP8qijA7a2NUI6VMrXeC54RBY+1mcQxo+MyyHrsrcfWOpF9zGtismQv+OpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNWc3uvAHjhP7F3zdyGW6fCtrLJxdhDq6PVseTT8UEQ=;
 b=DcxZLYN7G90DrYney2v0ioUK2e22nGrl0TLwkEz448Si1sazM0Wxf+d3YWw4m5beFb2BKClfLXfvnX5guP35h3177dgKfc9ob4sxs/rvBoYicnaWHrcBWhC6QUTSyHphSMsgKGSDZnKfXwwbXiw9nQBaE3d6lPiJ+OSpp0CRPJzNOndEpWCQtk1IwvRwQPGv6ErJzYZbyGUxgsDaT5e/KXCSxWJLHlMqytiwvPEjtVyASe1Ny2FYPZcztB95fha7H7fZv67PFiRThJv0erJde9jEUPQ6UNS4qyqA+YgEBS+ViNYxu5bd2O95mW68lt+3EgenTqfcLqzX/DBqse4hkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNWc3uvAHjhP7F3zdyGW6fCtrLJxdhDq6PVseTT8UEQ=;
 b=m9eGyscgOkNvPS7Yi7BsWuZ6V8LroQvU3TO/zjoJNr/1+VtlEsHDuLh7oFz40TR6zaLMQ2/NN7udeA8CKxOkH0Bv0yHv+IfsO8iJ8TK7KaFlRsvtA3pL1p89UxIOW8dNwQf49aCeiI3/pdhcJifX7r2mSPOsvcFNUbDR+sLVePY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 14:11:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 07/10] block: introduce preallocate filter
Date: Fri, 21 Aug 2020 17:11:20 +0300
Message-Id: <20200821141123.28538-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200821141123.28538-1-vsementsov@virtuozzo.com>
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:207:3::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:43 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f60345eb-6ba5-4841-f130-08d845dc2226
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB52539FD4A2BB8CB6C017AEF5C15B0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kWRmvsxZqDygG4XoakmQkwjZYeL2ktJMOwfR0Bh68tbpAluPuZo1rH48R2sklrNGoXMUd4Ut5Jnhir6KpklevMk9JqO7m7DfJOBI9SU4TX00y2J0SVi07ez9isksWmOGAMf9nnHR9Kg9QwGG4t5b95Ubi86Jwn6G7+5ZUTLZqAga8sBc7NoUnRVyzM5zA6HTYWyhbvl+KX6Y97C/GWbY3uO8/sF7oQrQA1iTWQ11XOgH+anjvelwl3KKOLRSFH93JlwX9hqwTDbALNwIWWlH+wqTcoXxjaW9r0HpiOmLnlzMeglFhiv/TbxYHavt0nM1oTTU/Hzbra1ZvqZjrCdEe4BQQA5oUB2+LK/CXGD+3uxZY2K0PpKGMyKSNIn853DUzY2Zoz8brBYMiGw7vadacZMal26KEHqRErAjE9636HID1BNQsSePN+joOs3TArS1A7fn13IXJJP4yLiYsTkOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(5660300002)(2906002)(2616005)(186003)(1076003)(316002)(6666004)(26005)(956004)(16526019)(66476007)(6486002)(6512007)(66946007)(66556008)(8936002)(83380400001)(8676002)(30864003)(6506007)(36756003)(52116002)(478600001)(4326008)(6916009)(86362001)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PAd+I0FRksEHXsKqsneL4SKKPjdTt7TwJwtOR0MHWooh2V6h9k2rL7YTtaJAdQUP8JjUxSN+F+Q0gjbQRimcvWPP944RwS7A8hYUT3iuRE0mk2HQ+1bQhlR9XmPmk8Vto0uPqiko7m+MxMgQqqgD7mpkqLu6niY2R4/6A9CQ2WOXMVGZ2Gep+6QCVrVuRC7JXpaGFtfLvD+DXqNsnEuTF2oHScqqu6RrDqbQhar8XJz3bqQRkr0UqRVAlbN+hRwC7jkuwOTBwJ1DoXtAkZiCx33aKRDegPjKIu+20OHspES+SOYsAwTUmNAysZMZJkVzHZFJV54FJnKfwd8tCu5f8EMVV3XQ5Y/JZQlt9p2Lm2S8J+dPjq5+3Dj1B8qw1aY1Su765njZYEJmCHpjN3wUkx0G9EoTRbiAnP7Sf1pSvDtD8F7w4oecZ5tCWJoQAKK8HShjluPbN+HIWpfGNiznXXideU5JcCzSi9Tf5VQLE4C2vQrOiGAPm4YP6xTDAU+WWsCUefXR5a0Vmjsj/ShmD0IN/8NSUJRU/WEDP46bJEJSvHFKkfTUCO9v73pTuhMmTTlRgrepc/AA3US3tjJnNUId6dcQ+Pi9u+C7ooQleOuFXu4wAX13x9TKRssBChWCL1sdUtD3y1AC+7xdZU8z1w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60345eb-6ba5-4841-f130-08d845dc2226
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:44.3254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yge184z2aDToglg4xN4HOzWV9CfBnTwby31sXJqXLSJF+JUbYYZCzorhI0Pk1wEiGU+JN6W9DqchP0EbRBeNleGo7pjjCAzYFdVhkY9RG50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.5.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 10:11:37
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
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
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


