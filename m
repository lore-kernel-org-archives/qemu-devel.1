Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D11C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E52B204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LmOBaYgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E52B204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZSP-0000Xt-B8
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZO3-0001GN-Ha; Fri, 14 Aug 2020 09:04:47 -0400
Received: from mail-db3eur04on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::72e]:48915
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZO1-0006dr-3I; Fri, 14 Aug 2020 09:04:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuFk86Se+0YsAYZVlRfRY9V2f3kf83GVOB8w2R64VzPCoHhR9nm442b92ld8DpJwfwivnEKNEDHIOnKdVQa7KNl/dUuFf+Vq9PvaGekljCd/z6VT3WWOuaFNTpUZo+CKOZi+Jqyv9XH0BFPwZDEpW3YPxLe0iw8AGnuw+wu99Kwz8pk1K1Qf/nV+rdkkq+Tr5fv/8uj+DWo1tLHGPERQPnj5TIZ+7qeX1qumjYQsIorC9jILl3cXZmaBqrsIP6ZPZvZkSpeYrZTIuHAIQubIh7+1jSGxc0gz7SuM6EeWTuwxVevdfOq94oAGUmbgpM71e1z26immVMoEfmjvL862sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jdTNlw17ygJdYj/sYwPN1cVj/SjYxHid3lWhEd12wA=;
 b=eAvA479KB/vml0Mp3GwcC9Km9j5Kq6CLsDEXbV/y+qJHsJx3OEcIRY+DXE1c+YjJMhOiE8vJk0R0MWLvoGh/2yh3CbE/1kTf76n6iyMmTuptcqn3PDy+efrh41GyPeoM2SKuLCLtSpI+80af3lheIzCYIJDdaJ1fWDS6zOTFS5cFdi7vMI/NNTiPIrlM570MAzyk5Vaw4pH/FWIo2xQJvaKbu9nyij5ybd9XbwKP6o9qsqMAGyrftmlnTg3xXSta8ibTd9BODdUbwD3kI4Z5FSxIMv4FVSptJUABUbMCRVY04d+CCa3/U5dCx1oXlItKuToAtBKIDVc54/1cFIXT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jdTNlw17ygJdYj/sYwPN1cVj/SjYxHid3lWhEd12wA=;
 b=LmOBaYgytm2SMiltGy48fVEgG4JH43JT8J1sV5Ce/hCbLt2bbfRIf5FEuyMTj4SiMt++0kfjXqOJyiRNQnvnOb3cZ3V5put5Gq9UHVLVliLlSezhwaEJ/Oprof2y5Yb5zykpiDFF25KvQSlQhTHBrbnVAqeutoOOGbeUqISUMqc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 13:04:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 7/9] block: introduce preallocate filter
Date: Fri, 14 Aug 2020 16:03:46 +0300
Message-Id: <20200814130348.20625-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814130348.20625-1-vsementsov@virtuozzo.com>
References: <20200814130348.20625-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.177) by
 AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:25 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0efb814-a835-429f-df1a-08d8405292a8
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2981414F3109F560A1615E3DC1400@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vDFExEsihrtR4w9kKORdl3NUz7MLaC1uzHj2o0HABm2CdxxoXsBinul/3sMFhJlx+ezO8yCf9/+vinvwjq6JnE9D19SPdIpfcNf+/SKSJB5YtztngLUdhEWFuhqXhJn1n6sHsM1MUltkM423gZcQQTp/rzx0tJ3Ty9Gphmw2zRSGqGK9RWndkl+oGy7GqlrsfivwpIyoLo/3wxvq5ff8TwaCk2NnMAi8QqwI8dnyvjH+Ps6qqyaFhBoE8IBnw1DJcUKje4NsP/N8+VDQERqxlGnDLTcL2Q+EPaRh0ZbKmJZorFB9cY3s1Eqzvcjd75QOJFYcldaWteVskT/C/EBysBIclyHGPooszGn2qwly3y9lGqTRGlU8hk55XqxurfbHjiXojHYcJZlToUwwEw6fZD1SnCXuLgBRDgJOERm0tx7+/DWp+YhOkTMBwjJbxn7hdj3kOoYOg+pnBktcvLBLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(2616005)(956004)(86362001)(1076003)(6486002)(478600001)(8936002)(6512007)(6666004)(36756003)(83380400001)(5660300002)(8676002)(6506007)(16526019)(186003)(316002)(4326008)(30864003)(66556008)(66476007)(66946007)(2906002)(107886003)(52116002)(6916009)(26005)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4uuf5Tc7DoDRJfj/XlD63oUk+9BHYjM2ScIS+tFRB9odMyJC8pFaMkUfJkJoPpEp7EjEaPegBcq12zYQKBrJkJXOqDbk6A3/hvAnQ9rElpG720rWiOvqlF5fzRfMN5MWfypnnJQ6UIvSk+FgkOx1zu58bsDM+4L1CRPV2m+K5QTIGztAKpxvZjUXFAdsy1K0YEUPYe04FP0Tzt/eSj8+aYnU+nxGFL7qOhcPhqmTwaLpJp6Hw4vV9s4ONS5pzX2aXxgpjYNdhxl4bpzDnim++G7Regl8j1Osv/nKwZGdEw03YlRENDXRTp7B9hQmJxQp/+cEcUDMRvnsMcB5QOS4cKAjiiSTPJ641ROdlVGI1zRfWbkVC+2eSJNGtkLIylVBMGNP0W6zh7Xj1zbYW5/5e1WSU0LdeNCbvCdwsMC6/ZFR+aIpR/2x5qLkiI0MESScdW2xzLAYNb/wYhGbPTVeypghvz42nKialf8askDzMjVG7aPODmYIH10fkZ2czUvSsK0WUCVM/nYn4WQK/S4aSWSWCX6QHXQifjRUwjYaJp1JzQlSd9aiwt3OVxfqi3MlgyvbqszxzUGu/IZRCRXbLYfO0NCaSMkJ/+VYNXZsGgqdLTnaOGFCberxlk1VYvcmZNixT9gMiRQgxCIfOyxyTA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0efb814-a835-429f-df1a-08d8405292a8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:26.6893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kzqxNE1R7vnobRoO6J1rOlsHbXTD0im1i5+dpYnhHyeLaSIWdQBn/fAXb8gfMb9zqOGqYpUKkoBRJil9Is8fRm+INDBzBP3/xLBrfpqeMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=2a01:111:f400:fe0c::72e;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 stefanha@redhat.com, den@openvz.org
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
 block/preallocate.c                    | 264 +++++++++++++++++++++++++
 block/Makefile.objs                    |   1 +
 4 files changed, 310 insertions(+), 1 deletion(-)
 create mode 100644 block/preallocate.c

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index b052a6d14e..0673678744 100644
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
+Qemu supports several filter drivers, which doesn't store any data, but do some
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
+  .. option:: prealloc-align
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
index 0000000000..7cc1cc1427
--- /dev/null
+++ b/block/preallocate.c
@@ -0,0 +1,264 @@
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
+    if (s->data_end >= 0 && bdrv_getlength(bs->file->bs) > s->data_end) {
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
+    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
+
+    /* Force RESIZE permission, to be able to crop file on close() */
+    *nperm |= BLK_PERM_RESIZE;
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


