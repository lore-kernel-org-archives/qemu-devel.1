Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E84C3E8AB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 13:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D734222C8
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 13:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ehfGa9U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D734222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGjrm-0004yz-HO
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 09:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iGjkt-0002ki-An
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iGjks-0005SV-39
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:05:51 -0400
Received: from mout.web.de ([217.72.192.78]:52685)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iGjkr-0005Qu-MM
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570280725;
 bh=R0IRo8VMRmUK4dg5KQRbFBwzAqI8nGg0X+OwDoGxLWM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ehfGa9U9l/1J0bEnnjAUzFhCeV8F5HcWz/0jyLMXdMWEwWXUQyPDCZdQGTnh5+lI9
 L6D2ljk2rDNaoQ12cWSsMAt20sH0V/FV2PVB1ZTA83pU82BHKZhmlaX731GSgT7DBt
 a//2Fy6+2WJZSdkMSebYIKWKZeOqT9T8iw3FKEQA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.231]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTh6a-1ihErV2C5A-00QTQZ; Sat, 05
 Oct 2019 15:05:25 +0200
Date: Sat, 5 Oct 2019 15:05:23 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 1/4] block/replication.c: Ignore requests after failover
Message-ID: <596a6f07850002a09461f317afa75f3e0c9bb784.1570280098.git.lukasstraub2@web.de>
In-Reply-To: <cover.1570280098.git.lukasstraub2@web.de>
References: <cover.1570280098.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YOVCmClvx9HEE1dFzp4GHc9NXGOxuebHDtMPBOu9EOhb9psnocK
 xUjUxlxc3wlDfaMwPRKBshOSW5MDOfpfX89dPkVhGNsxtZ8s3r0DulmbrJv1iRv1HBzdvNQ
 Ql3pBpIeQzy78d/9sMSIFMaJNiH7WLlMn+4lit3kCV/puC6w8DLaRKaDMsSWSnGCibI9NU9
 xRCEnimUZXSCzmEezWmXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w0A6Urtw3cA=:UgS6dH2fGSksF4B+YgeDB6
 GxxTWEAWlYLtgfnhiIdvm9rvFyNSZDHomiMMdjpmScr1TpCG5SYB9ROHGVGbfd0m8YlBdIt1K
 uWsYY5vuVrvmrCnj1Bg6smzrwaAOexR3+1oMRCxbvstj2+ZfP7mIRaGtziIZROPVb8KNuHzhS
 nWjx6tJ1TQWgcl1WzeTqQT/AUSZeTYdGjxFpaUGcRGXWuDzv6Ro2LBvEmaHNxMnTL3tWSok1B
 wp8Bsak4XOXHauPtCV8cl9Uy+sjp41OUaUPB/epabmmqIQfGhmmBZ/dVlg6Dx6BMFvLv4z7oy
 Y2Wt4UXzoistUzRQ+isxhzwcNTJhjc81nC7NoQXer+lq5+qs0jdaC3CGj8e4UXhao3tvow3Xs
 tGG4MyY4k2FmhK8+i2PXZuzLlGh9mvBkt5lA8FgAeULlHxLRvtlkUVSyrJlsT6chxgdebErHh
 XurnaznFFz8hWosHXbmF1c9+qIBzXsnHDS6MBBqM6Hgk7JZs/3aB9pwHH5Ei4gAiwogIR2ccl
 r+qRA5Dc/I5AFnS/1CvpQ6Z2sYjII+2zrwtsD981ufM2yW6ec+PPipcdUUf82cyYIwS/jLQW/
 fsML6XnNtrLTw9xv3muCkEvQvG1rrCgc6p4oopr4apX6On1h5abZWbcwA9LKcZxcDz3hxwG/R
 j1MLhJ1Su78wamV9G6JOaolnvxFsqQFaw1zzuVQRAIW6Vq+hd2yumt8ivLXn2K/J1GIBslrx+
 kySfXj8Ima5tIBX/HV6S6TEhYR28gsv4jND5SZF9iRWDH3MS8xp/nVENqdLv6MI+IlV/rwt6R
 2w+lnbzERHqOZQwLscBMK0yQCmTwliADrnl1v65E+9+mNpWhJTuhQLcD7h6KaLZ8qyF0KrjaI
 ThzobHjvK1nh2XVIlU9rMuxcImBtUhvwV31sGzBUsbQfN4lJfuF+l5iGR+zqpI9gE4HNG7csM
 NlUNn5DRO/NFBFV3KgVPJTvJR/t5xu0ORU5za1ynPS7sE/938RkxLcZ8L84HfyMtgJsk7F8NS
 rUlHFVdULOutJvPhS+KJt62y26v+GX+tG4mlujEj9UW7+uuLVUd4kVOWyDBrcQ9DSwW2gZUkc
 Ozl/stij6jSGWMYD/qYT87SkcxJ9GDJz8dOBN+Dm8BH9/Ckd9sLT6XI/Ggqx9zAljKA4gKEuW
 8162exq47M+No9puzorOSfdwsNNjbYB4nnDXztmRXu3a8q0Tuey68jVneD2Bl0nDXUqHEk1SO
 YI47H7djA6NPQyapgW6j1/Hl5/YaWdFD7IttmfTNGEisbCS6wb9bwOzdI7dc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.78
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
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
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
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


