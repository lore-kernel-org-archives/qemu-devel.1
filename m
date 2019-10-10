Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9122EC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6546020650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6546020650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXBH-0003lw-GV
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWr0-0006aP-I9
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWqx-0008BI-Pe
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWqt-0008AB-Kt; Thu, 10 Oct 2019 07:43:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DDEAB883C2;
 Thu, 10 Oct 2019 11:43:26 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 838375C231;
 Thu, 10 Oct 2019 11:43:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/36] block/backup: fix block-comment style
Date: Thu, 10 Oct 2019 13:42:35 +0200
Message-Id: <20191010114300.7746-12-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 10 Oct 2019 11:43:26 +0000 (UTC)
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We need to fix comment style around block-copy functions before further
moving them to separate file to satisfy checkpatch. But do more: fix
all comments style. Also, seems like doubled first asterisk is not
forbidden, but drop it too for consistency.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190920142056.12778-7-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 5dda1673ca..f5125984db 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -223,8 +223,10 @@ fail:
     return NULL;
 }
=20
-/* Copy range to target with a bounce buffer and return the bytes copied=
. If
- * error occurred, return a negative error number */
+/*
+ * Copy range to target with a bounce buffer and return the bytes copied=
. If
+ * error occurred, return a negative error number
+ */
 static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
                                                       int64_t start,
                                                       int64_t end,
@@ -269,8 +271,10 @@ fail:
=20
 }
=20
-/* Copy range to target and return the bytes copied. If error occurred, =
return a
- * negative error number. */
+/*
+ * Copy range to target and return the bytes copied. If error occurred, =
return a
+ * negative error number.
+ */
 static int coroutine_fn block_copy_with_offload(BlockCopyState *s,
                                                 int64_t start,
                                                 int64_t end,
@@ -341,7 +345,7 @@ static int block_copy_is_cluster_allocated(BlockCopyS=
tate *s, int64_t offset,
     }
 }
=20
-/**
+/*
  * Reset bits in copy_bitmap starting at offset if they represent unallo=
cated
  * data in the image. May reset subsequent contiguous bits.
  * @return 0 when the cluster at @offset was unallocated,
@@ -592,8 +596,10 @@ static bool coroutine_fn yield_and_check(BackupBlock=
Job *job)
         return true;
     }
=20
-    /* We need to yield even for delay_ns =3D 0 so that bdrv_drain_all()=
 can
-     * return. Without a yield, the VM would not reboot. */
+    /*
+     * We need to yield even for delay_ns =3D 0 so that bdrv_drain_all()=
 can
+     * return. Without a yield, the VM would not reboot.
+     */
     delay_ns =3D block_job_ratelimit_get_delay(&job->common, job->bytes_=
read);
     job->bytes_read =3D 0;
     job_sleep_ns(&job->common.job, delay_ns);
@@ -692,11 +698,15 @@ static int coroutine_fn backup_run(Job *job, Error =
**errp)
     }
=20
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) {
-        /* All bits are set in copy_bitmap to allow any cluster to be co=
pied.
-         * This does not actually require them to be copied. */
+        /*
+         * All bits are set in copy_bitmap to allow any cluster to be co=
pied.
+         * This does not actually require them to be copied.
+         */
         while (!job_is_cancelled(job)) {
-            /* Yield until the job is cancelled.  We just let our before=
_write
-             * notify callback service CoW requests. */
+            /*
+             * Yield until the job is cancelled.  We just let our before=
_write
+             * notify callback service CoW requests.
+             */
             job_yield(job);
         }
     } else {
--=20
2.21.0


