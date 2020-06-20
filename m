Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DDCC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B33D23BCD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OjhDml/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B33D23BCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmeeT-00085y-DL
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 10:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecL-0002aS-U3; Sat, 20 Jun 2020 10:37:13 -0400
Received: from mail-eopbgr50102.outbound.protection.outlook.com
 ([40.107.5.102]:35810 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecI-0004UK-JJ; Sat, 20 Jun 2020 10:37:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DY1Tle0A2dpAFngjfitFf4+MWwiUk9YEbCHHNYnhwHbs7sJk1XBx9rZOTd3j2KaxrUmKkgY26GgHtVc+/m/ZaJDSeKFetNh0kmwQgTjQkyM4wYFQ6I3bcV5uBFZH2si2uhQReNBaw+/MAzY+TQsVl6Dx3ov8uL+6Y4s3wmsZJ6Mcimz7igakXzEXZ7Xdf/2nSPj5Q44H1Adhh9IDwXcJTiBdlyfsnpLJ3VPXo8fhRKyWGLQoda8U9uEMXlNyHxyjAbmAZFuOFVbxZcycl2aRZdsWAb7xr2meyxH8b4PbT79wNkEE4L/A4on/nELju+xbPp7I/ZkulgsgnOXqiC/olA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHpqh/nGoe+Lav09ieBFabav9limNehGi2yb1lXU75g=;
 b=TlEnX1xRCiBusny6yHQ0YPfr1PswQ2NBhmBmP746mcCldoTtGb2yGHbwQ/8lnaWqZpoSu1w/rQinpFQPDy/1fDBFzkFl9FcaNA4eRyD+zLrbO5umz37W8ydjX+LjQ+WrtChPCMGwpwdR9VJ8Uq9HXnCoq28HcXIaoX4Hs9Pt482Y6EYjH99rKDDufNAMZMypYDuC0ZxV+qzSPRwwYJmSwJ5TT3UqXxb2++0M7FvxeNsXj+nBN+FIXvlmrtaNznw+GY33prTv0I+m1DMAALBT2FZauvqCN2qxBmjtIlOYNSflHs454pzziKLn0nC9iwL3eDejo5lAaMgW+0aES1NDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHpqh/nGoe+Lav09ieBFabav9limNehGi2yb1lXU75g=;
 b=OjhDml/doWXojak+m9sXjhVK5HBU3qdEu12RnHkwCAvOUri3RWX1l7Rn02y0aDC4RhGGmMa2K+S6LWZpKmI2BzM4ZQWnWGxtnZvwPjdZfU5/OfkJcFnYjYb2dLuyl3OcbL/p2Yj5OJNHuwblilB52lpYgAVrhGbpfTDhHG8/Uws=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Sat, 20 Jun
 2020 14:37:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 14:37:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/5] block: introduce preallocate filter
Date: Sat, 20 Jun 2020 17:36:47 +0300
Message-Id: <20200620143649.225852-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200620143649.225852-1-vsementsov@virtuozzo.com>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:207:5::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.122) by
 AM3PR03CA0055.eurprd03.prod.outlook.com (2603:10a6:207:5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 14:36:59 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d24ba8b-da83-43b6-ea30-08d815276422
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5430A86DDC85C91EDEB43331C1990@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AK/o4FhNZwNWhzisjXSzNQQ6JXMe/xcNXseBhXdY7HKVxs0ZPutgG+H57jMYYTmCXtmyaLphW8ezjYGdJfZCigbgBUkDTof/LB/BU1RL4UwWJSepIRw4waSvGVOoEym8ge7ID34YkJNgsHmM5uroakYGSuFU3bhukPqz9yphsfNnBXYYstsXvYJdhCXc5hgjT9aIoSTgK7q32T6/wj5bMrvzodzwfOm9eH61uBALCnPWh8oMp2yLn8lXdsjwJmr/KsmZzbYmm3V25rPOykfgEKkxAVF+gqWoX/iHtxvMlEHrZM9J+qv3OtdoMuB8wf6LNFTTtVp7IZ+NnzNeEwuNRZdU4ragwONi/+iYiHkaFC1GJ1ukvgySowXzLQUrwN1W60rp+HhZ7rMMaZ4U56+bINen4BsAwjhs/Ii+NtKHEuRJjvXActgLocf533peqIzrs2oPOLPKB6Ch2k8RC89odw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(6666004)(26005)(186003)(16526019)(86362001)(2906002)(6916009)(6512007)(4326008)(83380400001)(52116002)(2616005)(6506007)(478600001)(956004)(36756003)(5660300002)(6486002)(8676002)(316002)(66946007)(8936002)(66476007)(1076003)(66556008)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HwQZ25d9VOEg7ljk63r1xmnST2VHiTDWObBQbxng8G2r2DOq2Cg+LqvdQ82aqgme39nowbBnPybvVdKlqCCeqvePG2jsGNVrg2MWSpG2m+byhB3l9aPxt6AGCqqeB4erMWAMAnv0ZeYX4xf1oPLjPiUd/hexONpFKluJmujleUC3/o195vKyHjyC/wCPKGmVWfk/F+IZQFPEnwqFP71dIw7sNNg1yiwqv8wwC+296nZqbe5ZPgEgfrQI3FwId4CF2hR6MWKTnJzAz6EO6lPuQ6Wo+m+LXDbKktMkPwAVvdQnLUG9uduo+EC6zRcmBE9pRnp2Vj3UXUiOn4HsKmmG3vC04vXZl9LW2UQBqdrPphDZ/N3i3mFMTF0SKHoIMNAJ3i5+EoUeTGxgbHMmqi+l4v/vzAFDw1lxsqNMjBcVb7j/TGTM9VlDoWkigQGDRTlUhNqV/zSzy6rzY3Oi8ZaJ27SwNcLsMJ8FOPaW4Q2sIoo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d24ba8b-da83-43b6-ea30-08d815276422
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 14:37:00.2216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7vxczEWZOuzeLOBG5KXFX7rz96wVSF0Wc6NVjv3NkoReArtfb2sMHUlOl0J5rDFOA3CoWDj3W5iBegy6n83N5rCDmG7gfpumhIWR3siCTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.5.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 10:36:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It may be used for file-systems with slow allocation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json |   3 +-
 block/preallocate.c  | 255 +++++++++++++++++++++++++++++++++++++++++++
 block/Makefile.objs  |   1 +
 3 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 block/preallocate.c

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0e1c6a59f2..a0bda399d6 100644
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
             'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
@@ -3995,6 +3995,7 @@
       'null-co':    'BlockdevOptionsNull',
       'nvme':       'BlockdevOptionsNVMe',
       'parallels':  'BlockdevOptionsGenericFormat',
+      'preallocate':'BlockdevOptionsGenericFormat',
       'qcow2':      'BlockdevOptionsQcow2',
       'qcow':       'BlockdevOptionsQcow',
       'qed':        'BlockdevOptionsGenericCOWFormat',
diff --git a/block/preallocate.c b/block/preallocate.c
new file mode 100644
index 0000000000..c272a6e41d
--- /dev/null
+++ b/block/preallocate.c
@@ -0,0 +1,255 @@
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
+#include "qemu/module.h"
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
+
+static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
+                            Error **errp)
+{
+    BDRVPreallocateState *s = bs->opaque;
+
+    /*
+     * Parameters are hardcoded now. May need to add corresponding options in
+     * future.
+     */
+    s->prealloc_align = 1 * MiB;
+    s->prealloc_size = 128 * MiB;
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
+    BdrvTrackedRequest *lock;
+    int ret;
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
+    lock = bdrv_co_range_try_lock(bs->file->bs, len, INT64_MAX - len);
+    if (!lock) {
+        /* There are already preallocating requests in-fligth */
+        return false;
+    }
+
+    /* Length should not have changed */
+    assert(len == bdrv_getlength(bs->file->bs));
+
+    start = write_zero ? MIN(offset, len) : len;
+    end = QEMU_ALIGN_UP(offset + bytes + s->prealloc_size, s->prealloc_align);
+
+    ret = bdrv_co_pwrite_zeroes_locked(bs->file, start, end - start,
+                                       BDRV_REQ_NO_FALLBACK, lock);
+
+    bdrv_co_range_unlock(lock);
+
+    return !ret;
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
+    if (!bs->file) {
+        return 0;
+    }
+
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
index 3635b6b4c1..f46a353a35 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -45,6 +45,7 @@ block-obj-y += crypto.o
 block-obj-y += aio_task.o
 block-obj-y += backup-top.o
 block-obj-y += filter-compress.o
+block-obj-y += preallocate.o
 common-obj-y += monitor/
 
 block-obj-y += stream.o
-- 
2.18.0


