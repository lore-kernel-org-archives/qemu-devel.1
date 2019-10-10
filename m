Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F49C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB43208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB43208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXXy-0007bg-G8
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrF-0006p5-FC
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrD-0008Hn-M7
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWr9-0008FN-SK; Thu, 10 Oct 2019 07:43:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D8E83086218;
 Thu, 10 Oct 2019 11:43:43 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90E8510013A1;
 Thu, 10 Oct 2019 11:43:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/36] qapi: add unmap to BlockDeviceStats
Date: Thu, 10 Oct 2019 13:42:42 +0200
Message-Id: <20191010114300.7746-19-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 10 Oct 2019 11:43:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20190923121737.83281-3-anton.nefedov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json       | 29 +++++++++++++++++++++++------
 include/block/accounting.h |  1 +
 block/qapi.c               |  6 ++++++
 tests/qemu-iotests/227.out | 18 ++++++++++++++++++
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5ab554b54a..7d3e05891c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -860,6 +860,8 @@
 #
 # @wr_bytes:      The number of bytes written by the device.
 #
+# @unmap_bytes: The number of bytes unmapped by the device (Since 4.2)
+#
 # @rd_operations: The number of read operations performed by the device.
 #
 # @wr_operations: The number of write operations performed by the device=
.
@@ -867,6 +869,9 @@
 # @flush_operations: The number of cache flush operations performed by t=
he
 #                    device (since 0.15.0)
 #
+# @unmap_operations: The number of unmap operations performed by the dev=
ice
+#                    (Since 4.2)
+#
 # @rd_total_time_ns: Total time spent on reads in nanoseconds (since 0.1=
5.0).
 #
 # @wr_total_time_ns: Total time spent on writes in nanoseconds (since 0.=
15.0).
@@ -874,6 +879,9 @@
 # @flush_total_time_ns: Total time spent on cache flushes in nanoseconds
 #                       (since 0.15.0).
 #
+# @unmap_total_time_ns: Total time spent on unmap operations in nanoseco=
nds
+#                       (Since 4.2)
+#
 # @wr_highest_offset: The offset after the greatest byte written to the
 #                     device.  The intended use of this information is f=
or
 #                     growable sparse files (like qcow2) that are used o=
n top
@@ -885,6 +893,9 @@
 # @wr_merged: Number of write requests that have been merged into anothe=
r
 #             request (Since 2.3).
 #
+# @unmap_merged: Number of unmap requests that have been merged into ano=
ther
+#                request (Since 4.2)
+#
 # @idle_time_ns: Time since the last I/O operation, in
 #                nanoseconds. If the field is absent it means that
 #                there haven't been any operations yet (Since 2.5).
@@ -898,6 +909,9 @@
 # @failed_flush_operations: The number of failed flush operations
 #                           performed by the device (Since 2.5)
 #
+# @failed_unmap_operations: The number of failed unmap operations perfor=
med
+#                           by the device (Since 4.2)
+#
 # @invalid_rd_operations: The number of invalid read operations
 #                          performed by the device (Since 2.5)
 #
@@ -907,6 +921,9 @@
 # @invalid_flush_operations: The number of invalid flush operations
 #                            performed by the device (Since 2.5)
 #
+# @invalid_unmap_operations: The number of invalid unmap operations perf=
ormed
+#                            by the device (Since 4.2)
+#
 # @account_invalid: Whether invalid operations are included in the
 #                   last access statistics (Since 2.5)
 #
@@ -925,18 +942,18 @@
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
-  'data': {'rd_bytes': 'int', 'wr_bytes': 'int',
+  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'unmap_bytes' : 'int',
            'rd_operations': 'int', 'wr_operations': 'int',
-           'flush_operations': 'int',
+           'flush_operations': 'int', 'unmap_operations': 'int',
            'rd_total_time_ns': 'int', 'wr_total_time_ns': 'int',
-           'flush_total_time_ns': 'int',
+           'flush_total_time_ns': 'int', 'unmap_total_time_ns': 'int',
            'wr_highest_offset': 'int',
-           'rd_merged': 'int', 'wr_merged': 'int',
+           'rd_merged': 'int', 'wr_merged': 'int', 'unmap_merged': 'int'=
,
            '*idle_time_ns': 'int',
            'failed_rd_operations': 'int', 'failed_wr_operations': 'int',
-           'failed_flush_operations': 'int',
+           'failed_flush_operations': 'int', 'failed_unmap_operations': =
'int',
            'invalid_rd_operations': 'int', 'invalid_wr_operations': 'int=
',
-           'invalid_flush_operations': 'int',
+           'invalid_flush_operations': 'int', 'invalid_unmap_operations'=
: 'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
            'timed_stats': ['BlockDeviceTimedStats'],
            '*rd_latency_histogram': 'BlockLatencyHistogramInfo',
diff --git a/include/block/accounting.h b/include/block/accounting.h
index d1f67b10dd..ba8b04d572 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -36,6 +36,7 @@ enum BlockAcctType {
     BLOCK_ACCT_READ,
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
+    BLOCK_ACCT_UNMAP,
     BLOCK_MAX_IOTYPE,
 };
=20
diff --git a/block/qapi.c b/block/qapi.c
index 7ee2ee065d..69c35c4196 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -440,24 +440,30 @@ static void bdrv_query_blk_stats(BlockDeviceStats *=
ds, BlockBackend *blk)
=20
     ds->rd_bytes =3D stats->nr_bytes[BLOCK_ACCT_READ];
     ds->wr_bytes =3D stats->nr_bytes[BLOCK_ACCT_WRITE];
+    ds->unmap_bytes =3D stats->nr_bytes[BLOCK_ACCT_UNMAP];
     ds->rd_operations =3D stats->nr_ops[BLOCK_ACCT_READ];
     ds->wr_operations =3D stats->nr_ops[BLOCK_ACCT_WRITE];
+    ds->unmap_operations =3D stats->nr_ops[BLOCK_ACCT_UNMAP];
=20
     ds->failed_rd_operations =3D stats->failed_ops[BLOCK_ACCT_READ];
     ds->failed_wr_operations =3D stats->failed_ops[BLOCK_ACCT_WRITE];
     ds->failed_flush_operations =3D stats->failed_ops[BLOCK_ACCT_FLUSH];
+    ds->failed_unmap_operations =3D stats->failed_ops[BLOCK_ACCT_UNMAP];
=20
     ds->invalid_rd_operations =3D stats->invalid_ops[BLOCK_ACCT_READ];
     ds->invalid_wr_operations =3D stats->invalid_ops[BLOCK_ACCT_WRITE];
     ds->invalid_flush_operations =3D
         stats->invalid_ops[BLOCK_ACCT_FLUSH];
+    ds->invalid_unmap_operations =3D stats->invalid_ops[BLOCK_ACCT_UNMAP=
];
=20
     ds->rd_merged =3D stats->merged[BLOCK_ACCT_READ];
     ds->wr_merged =3D stats->merged[BLOCK_ACCT_WRITE];
+    ds->unmap_merged =3D stats->merged[BLOCK_ACCT_UNMAP];
     ds->flush_operations =3D stats->nr_ops[BLOCK_ACCT_FLUSH];
     ds->wr_total_time_ns =3D stats->total_time_ns[BLOCK_ACCT_WRITE];
     ds->rd_total_time_ns =3D stats->total_time_ns[BLOCK_ACCT_READ];
     ds->flush_total_time_ns =3D stats->total_time_ns[BLOCK_ACCT_FLUSH];
+    ds->unmap_total_time_ns =3D stats->total_time_ns[BLOCK_ACCT_UNMAP];
=20
     ds->has_idle_time_ns =3D stats->last_access_time_ns > 0;
     if (ds->has_idle_time_ns) {
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index 3dd3ca5708..9c09ee3917 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -15,6 +15,8 @@ Testing: -drive driver=3Dnull-co,read-zeroes=3Don,if=3D=
virtio
         {
             "device": "virtio0",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -24,13 +26,17 @@ Testing: -drive driver=3Dnull-co,read-zeroes=3Don,if=3D=
virtio
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": true,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": true,
                 "rd_operations": 0,
@@ -74,6 +80,8 @@ Testing: -drive driver=3Dnull-co,if=3Dnone
         {
             "device": "none0",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -83,13 +91,17 @@ Testing: -drive driver=3Dnull-co,if=3Dnone
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": true,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": true,
                 "rd_operations": 0,
@@ -163,6 +175,8 @@ Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,=
node-name=3Dnull -device virtio-b
         {
             "device": "",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -172,13 +186,17 @@ Testing: -blockdev driver=3Dnull-co,read-zeroes=3Do=
n,node-name=3Dnull -device virtio-b
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": false,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": false,
                 "rd_operations": 0,
--=20
2.21.0


