Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F124C28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDC02776C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDC02776C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36697 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXotJ-0004BY-Bm
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:28:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoWI-0001lK-7V
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoWG-0001tH-8E
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:05:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoW6-0001ZX-1t; Mon, 03 Jun 2019 11:04:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E97B31628F6;
	Mon,  3 Jun 2019 15:04:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA2896727A;
	Mon,  3 Jun 2019 15:04:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:31 +0200
Message-Id: <20190603150233.6614-27-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 03 Jun 2019 15:04:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 26/28] block/qcow2-refcount: add trace-point to
 qcow2_process_discards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Let's at least trace ignored failure.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-refcount.c | 7 ++++++-
 block/trace-events     | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3a2c673a5e..22cadd79d5 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -29,6 +29,7 @@
 #include "qemu/range.h"
 #include "qemu/bswap.h"
 #include "qemu/cutils.h"
+#include "trace.h"
=20
 static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size,
                                     uint64_t max);
@@ -737,7 +738,11 @@ void qcow2_process_discards(BlockDriverState *bs, in=
t ret)
=20
         /* Discard is optional, ignore the return value */
         if (ret >=3D 0) {
-            bdrv_pdiscard(bs->file, d->offset, d->bytes);
+            int r2 =3D bdrv_pdiscard(bs->file, d->offset, d->bytes);
+            if (r2 < 0) {
+                trace_qcow2_process_discards_failed_region(d->offset, d-=
>bytes,
+                                                           r2);
+            }
         }
=20
         g_free(d);
diff --git a/block/trace-events b/block/trace-events
index 1e0653ce6d..eab51497fc 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -92,6 +92,9 @@ qcow2_cache_get_done(void *co, int c, int i) "co %p is_=
l2_cache %d index %d"
 qcow2_cache_flush(void *co, int c) "co %p is_l2_cache %d"
 qcow2_cache_entry_flush(void *co, int c, int i) "co %p is_l2_cache %d in=
dex %d"
=20
+# qcow2-refcount.c
+qcow2_process_discards_failed_region(uint64_t offset, uint64_t bytes, in=
t ret) "offset 0x%" PRIx64 " bytes 0x%" PRIx64 " ret %d"
+
 # qed-l2-cache.c
 qed_alloc_l2_cache_entry(void *l2_cache, void *entry) "l2_cache %p entry=
 %p"
 qed_unref_l2_cache_entry(void *entry, int ref) "entry %p ref %d"
--=20
2.20.1


