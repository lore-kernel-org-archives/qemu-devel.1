Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05B52081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QrqcmwTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05B52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dG3-0005Vj-Md
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i7dB0-0001wj-Rg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i7dAv-0005Oh-Qk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:10 -0400
Received: from mout.web.de ([212.227.17.11]:51701)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i7dAv-0005Ku-ID
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568110479;
 bh=1aMK3WcfXGtXkTJdGeILldP4LKkJ6RJ1Yf8zxuMXcY0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QrqcmwTUG4rlAj8ghY2MUPr/eOPbY8JYJxzw40NQU4wUtqjmNbJfrfItXTATkSZX5
 HfVk/QJpJjTd6Ul7n9GTdEox9uzPLOjrw3ryrFFZ2D1qVP5VFsYz6bYdVrDOMvTYQK
 VIapRYKIBFpCPRPTCyAdJcWNazHSYqJ9K+8piDUY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.217]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MS2D8-1himnN2JHG-00TAUZ; Tue, 10
 Sep 2019 12:14:39 +0200
Date: Tue, 10 Sep 2019 12:14:35 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <5305f30b0f798adfc3883bbcebbfc5030661dbe9.1568110100.git.lukasstraub2@web.de>
In-Reply-To: <cover.1568110100.git.lukasstraub2@web.de>
References: <cover.1568110100.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:THYE//mNaPjYgZsIjrcjlhxOyQIUjAtvpI2E2zYA5I2YQhLiaKW
 0PA/LaYK7vpFITiuhegf7vn3Z8+zAz8U5iPLyGJ+I0ZrcbiiZ+ZbgeJSDBRyJJDBkWkhXKI
 rYHFTwx92d7TLM6L9ILzp2RPmL14W3YjLGEGQvK9jeq1u08vPoDHRg6D3qYLg9lKmzVOoxI
 +1A+NSUZ9E5uKqVfeWo8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/M2mnrYdZjw=:tHfmilzwusskYKehAav9gO
 LeSElDBUBK+7yBLQ4zxShvflfVUO60R5Nv4rJSvQuwtAf7zmZIXjOYC/mMp6ADhVJ/RuGWANf
 uPVcIgT8T/bwldqBfHec2edATAkuViUvxlM5YY52cm8r6BhOtbV6LdFGT2tLV19rEmbwtNffy
 548Wx0S16jl7exuh38C7X+YfhKLUlle+bGYurkb9x54x8Kx8xftn0e/dLK4V7fu4TYPEtpExB
 waMm4IDnVrI20d1KyFuy1e1P9OKDiDL0GhRUZxxUVIkmsZSAvuSqg3oRbQJLEJxoX+nAEiUmi
 vjeLO8Xhp528HZ71NEExpF8NRriU/mZi3lFCrpmOoT7WMHcH76kbYnPaABnLD8pvfBDvxpLzH
 nwU1w4V7FqGh5AnTKyPnJ2nANZSWUYznMWrkDfNJzSqHkk3GA4qoDzrjbNiLXCyjTqC1AAZdV
 oNfFeWOw8hX8ZjRykFheWbw21ksppk0br48DRRAdin+JVYx2vR/JrJhm1wqlo44IMjjPgd3PU
 k52nmUlqb9887G86HKUJ//4qHV7rdv+CZMU3QeSXCcAZlnu1IWS1raZ2QPW4kvHiN0MtrogYr
 fgf6LAHHYHqS+nG+8j6khyKF4hwRFsEu39QaFEVCQ8OSo6tcR+B2MyBCW+9zpofchGYkSTrQh
 jQpj8HF9s7fEZivEyTyuNGLaKb0e22iwUiLuWTv2aEJ2jZZnkNsegx3HEeBKk/08PhviAcuil
 gvJc+3Y1Lih6WvbhV0+TPQ9G8opFB+hwLeseD4XxgGQIZz/sv3ismd+EeuwH0l7oLLnn9+z4q
 wL0tsiQSoEJnfac76PuLaPjk7M3yHN58GQlOVtnhG3gLuTegOmxJta5b8joghzAv2nNWl8y1U
 NbBne18/XpI8bLycEXLaN84HAxkSl+SeqPiiIK+tMaAq+FViEa9zTBqvHbv4ztu5vdwFccMO7
 RgqdY4XiUwuVeCuOBGc1wcthlEewKZ0UXhuc/aQzRTlknkq+3LAx+yFT9VbjOIR/n1bAwr8aC
 j9RgtIuGXohV+CkdUbeL3/pSJoj+aJRocSwf6vzuxpolvbhZQE4BYuN1nB6tapZbYVygO914i
 M0gRXyEi5hmIG7DYTFDw94Pe/5pNzHk8CCdRqkbT14Y63xxkb7bllrV7D5EHGNzwLtqBSIIh4
 Jk+NGClnk5MSz61PyMJ4ixnGEK+sj7uFnXK2xRWUntnwpFtWvF0H05nP2okfv5HMCyZmy9yQk
 TvEYdfog3ZN9NexQy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
Subject: [Qemu-devel] [PATCH v4 1/4] block/replication.c: Ignore requests
 after failover
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
Cc: kwolf@redhat.com, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, mreitz@redhat.com,
 Zhang Chen <chen.zhang@intel.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After failover the Secondary side of replication shouldn't change state, b=
ecause
it now functions as our primary disk.

In replication_start, replication_do_checkpoint, replication_stop, ignore
the request if current state is BLOCK_REPLICATION_DONE (sucessful failover=
) or
BLOCK_REPLICATION_FAILOVER (failover in progres i.e. currently merging act=
ive
and hidden images into the base image).

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 block/replication.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 3d4dedddfc..97cc65c0cf 100644
=2D-- a/block/replication.c
+++ b/block/replication.c
@@ -454,6 +454,17 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

+    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
+        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
+        /*
+         * This case happens when a secondary is promoted to primary.
+         * Ignore the request because the secondary side of replication
+         * doesn't have to do anything anymore.
+         */
+        aio_context_release(aio_context);
+        return;
+    }
+
     if (s->stage !=3D BLOCK_REPLICATION_NONE) {
         error_setg(errp, "Block replication is running or done");
         aio_context_release(aio_context);
@@ -529,8 +540,7 @@ static void replication_start(ReplicationState *rs, Re=
plicationMode mode,
                    "Block device is in use by internal backup job");

         top_bs =3D bdrv_lookup_bs(s->top_id, s->top_id, NULL);
-        if (!top_bs || !bdrv_is_root_node(top_bs) ||
-            !check_top_bs(top_bs, bs)) {
+        if (!top_bs || !check_top_bs(top_bs, bs)) {
             error_setg(errp, "No top_bs or it is invalid");
             reopen_backing_file(bs, false, NULL);
             aio_context_release(aio_context);
@@ -577,6 +587,17 @@ static void replication_do_checkpoint(ReplicationStat=
e *rs, Error **errp)
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

+    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
+        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
+        /*
+         * This case happens when a secondary was promoted to primary.
+         * Ignore the request because the secondary side of replication
+         * doesn't have to do anything anymore.
+         */
+        aio_context_release(aio_context);
+        return;
+    }
+
     if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
         secondary_do_checkpoint(s, errp);
     }
@@ -593,7 +614,7 @@ static void replication_get_error(ReplicationState *rs=
, Error **errp)
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

-    if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
+    if (s->stage =3D=3D BLOCK_REPLICATION_NONE) {
         error_setg(errp, "Block replication is not running");
         aio_context_release(aio_context);
         return;
@@ -635,6 +656,17 @@ static void replication_stop(ReplicationState *rs, bo=
ol failover, Error **errp)
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

+    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
+        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
+        /*
+         * This case happens when a secondary was promoted to primary.
+         * Ignore the request because the secondary side of replication
+         * doesn't have to do anything anymore.
+         */
+        aio_context_release(aio_context);
+        return;
+    }
+
     if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
         error_setg(errp, "Block replication is not running");
         aio_context_release(aio_context);
=2D-
2.20.1


