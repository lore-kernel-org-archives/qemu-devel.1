Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC715C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6294D21929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6294D21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6Ga-0002H0-Vc
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pW-0001Aw-4e
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pU-0002Od-MD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5pU-00024B-DV; Tue, 05 Nov 2019 15:53:32 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpYGr027535; Tue, 5 Nov 2019 15:53:11 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3g6dgkbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:11 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5Kpn9H028511;
 Tue, 5 Nov 2019 15:53:11 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3g6dgkbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:11 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnwUH000955;
 Tue, 5 Nov 2019 20:53:10 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma04dal.us.ibm.com with ESMTP id 2w11e79fhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:10 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5Kr9sQ29688218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:09 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47836124058;
 Tue,  5 Nov 2019 20:53:09 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3368812405C;
 Tue,  5 Nov 2019 20:53:09 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:09 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/55] block/snapshot: Restrict set of snapshot nodes
Date: Tue,  5 Nov 2019 14:52:27 -0600
Message-Id: <20191105205243.3766-40-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Nodes involved in internal snapshots were those that were returned by
bdrv_next(), inserted and not read-only. bdrv_next() in turn returns all
nodes that are either the root node of a BlockBackend or monitor-owned
nodes.

With the typical -drive use, this worked well enough. However, in the
typical -blockdev case, the user defines one node per option, making all
nodes monitor-owned nodes. This includes protocol nodes etc. which often
are not snapshottable, so "savevm" only returns an error.

Change the conditions so that internal snapshot still include all nodes
that have a BlockBackend attached (we definitely want to snapshot
anything attached to a guest device and probably also the built-in NBD
server; snapshotting block job BlockBackends is more of an accident, but
a preexisting one), but other monitor-owned nodes are only included if
they have no parents.

This makes internal snapshots usable again with typical -blockdev
configurations.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Peter Krempa <pkrempa@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
(cherry picked from commit 05f4aced658a02b02d3e89a6c7a2281008fcf26c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/snapshot.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index f2f48f926a..8081616ae9 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -31,6 +31,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/option.h"
+#include "sysemu/block-backend.h"
 
 QemuOptsList internal_snapshot_opts = {
     .name = "snapshot",
@@ -384,6 +385,16 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
     return ret;
 }
 
+static bool bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
+{
+    if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
+        return false;
+    }
+
+    /* Include all nodes that are either in use by a BlockBackend, or that
+     * aren't attached to any node, but owned by the monitor. */
+    return bdrv_has_blk(bs) || QLIST_EMPTY(&bs->parents);
+}
 
 /* Group operations. All block drivers are involved.
  * These functions will properly handle dataplane (take aio_context_acquire
@@ -399,7 +410,7 @@ bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
         AioContext *ctx = bdrv_get_aio_context(bs);
 
         aio_context_acquire(ctx);
-        if (bdrv_is_inserted(bs) && !bdrv_is_read_only(bs)) {
+        if (bdrv_all_snapshots_includes_bs(bs)) {
             ok = bdrv_can_snapshot(bs);
         }
         aio_context_release(ctx);
@@ -426,8 +437,9 @@ int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
         AioContext *ctx = bdrv_get_aio_context(bs);
 
         aio_context_acquire(ctx);
-        if (bdrv_can_snapshot(bs) &&
-                bdrv_snapshot_find(bs, snapshot, name) >= 0) {
+        if (bdrv_all_snapshots_includes_bs(bs) &&
+            bdrv_snapshot_find(bs, snapshot, name) >= 0)
+        {
             ret = bdrv_snapshot_delete(bs, snapshot->id_str,
                                        snapshot->name, err);
         }
@@ -455,7 +467,7 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
         AioContext *ctx = bdrv_get_aio_context(bs);
 
         aio_context_acquire(ctx);
-        if (bdrv_can_snapshot(bs)) {
+        if (bdrv_all_snapshots_includes_bs(bs)) {
             ret = bdrv_snapshot_goto(bs, name, errp);
         }
         aio_context_release(ctx);
@@ -481,7 +493,7 @@ int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs)
         AioContext *ctx = bdrv_get_aio_context(bs);
 
         aio_context_acquire(ctx);
-        if (bdrv_can_snapshot(bs)) {
+        if (bdrv_all_snapshots_includes_bs(bs)) {
             err = bdrv_snapshot_find(bs, &sn, name);
         }
         aio_context_release(ctx);
@@ -512,7 +524,7 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
         if (bs == vm_state_bs) {
             sn->vm_state_size = vm_state_size;
             err = bdrv_snapshot_create(bs, sn);
-        } else if (bdrv_can_snapshot(bs)) {
+        } else if (bdrv_all_snapshots_includes_bs(bs)) {
             sn->vm_state_size = 0;
             err = bdrv_snapshot_create(bs, sn);
         }
@@ -538,7 +550,7 @@ BlockDriverState *bdrv_all_find_vmstate_bs(void)
         bool found;
 
         aio_context_acquire(ctx);
-        found = bdrv_can_snapshot(bs);
+        found = bdrv_all_snapshots_includes_bs(bs) && bdrv_can_snapshot(bs);
         aio_context_release(ctx);
 
         if (found) {
-- 
2.17.1


