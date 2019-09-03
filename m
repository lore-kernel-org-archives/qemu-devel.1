Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D9AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341D622CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Mz5u+SGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341D622CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i553n-0002eM-82
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i54zW-00083o-Fs
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i54zV-0002Q6-8n
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:46 -0400
Received: from mout.web.de ([212.227.15.3]:35737)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i54zU-0002PF-Vf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1567502426;
 bh=1aMK3WcfXGtXkTJdGeILldP4LKkJ6RJ1Yf8zxuMXcY0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Mz5u+SGsiV9KfRIGchX1DGjWSZiHo9wlfX4KBXGTPRqTVv7w3hJ9WT1pPatZv7UDb
 M0OKL5ylfTEghIfTPxDu3aFZsBKr2E5BBnGkf4GNHDsgLOZY+fR+YelEumRvpK+K/T
 mssEtkUMfmEM/3ypA1f92gy7QiZru6Kahgv3UDX4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.78]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3k9J-1iNA2F2unJ-00rLNi; Tue, 03
 Sep 2019 11:20:26 +0200
Date: Tue, 3 Sep 2019 11:20:21 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <5305f30b0f798adfc3883bbcebbfc5030661dbe9.1567500411.git.lukasstraub2@web.de>
In-Reply-To: <cover.1567500411.git.lukasstraub2@web.de>
References: <cover.1567500411.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6n7NUftyhGnsv3QHpJPJcpP7cONMly5SDtg4EveHA7CKukumlVU
 kkaEnL/EzNYE/fecpU94pqUmzucidGS3VXpCBlaloKmvHMVAjHy3DAFBjARlOVnx88Q0yjr
 Wz+IFJ1WC5QvrpADRwgNoF83JAgtKSFBD0oXyUDEWnk7rqj4OA+90C0yyQzqkooPfehMVM2
 8W8yMneAidMWlMDqnGKlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qf8/f9fOP8k=:fiQ0/c/PWc8JeIvNEadnsz
 aYlpVdKv51IbRNBwBNdNJPaTRF4LSj5FhihVn/e4lsaDgqCZSfujVoyB8g/Iaw5TuX2m/YZxo
 tpYwUcCTIotbYdCuJrOh9yGbB9Irrb2JS18jDgw9PmTsR0wU9CaphBbPxQV0WfPJQDyRTLr8R
 +8iauT+F5P5TDgQt1xTt5PhKwPeeC/FYJxqL4Mz/9w8Fv5XCxOOlaTKdpQIkFeMaE0ud/bNnW
 DcMpMO3tOL9JIZbjYHZULIYbFf/ah05AYeSN9Si+9vGTln52H1jE3fTVqEKSxzbolWjje/FG7
 fpQ5wRQd+JQkC3uEI+QX3Z9tu/dYEfek6w5/G2RgKqbmedlIAa9G4ns8mJlbH0WnZRTDrFF6H
 EQ3kJuX2K+kl0xskiksJ7fNzJFEF2PUn/HkMga6tXm4mcfBPu9IHGgW9sqFr1hwFZTyiuKtus
 2AngeNaLJbhSAjRB6jhNwfgarjKiVPjs/uwzzTdPLIOwPeHx6pvBeUzj8M3YO+hw3R/rPP/E1
 9V8ZbQzNEHHYtxBsoHD+NfOUcwnEmhDdATQTLqVzjhkWDoPGahLFExRMFzGzkX34Ns5jzNblW
 GKMjToXAtLO6GinX2cGhZBRaDfcEVxsrCX27PoP/7ISwATT7rkJyhK1kANpMGdDmd6Gm5uxPW
 JfNn/3eYFKVCu1sz+QuyBv49JV/JKYWn5VmmQ0RT+T8RZram7dFRTvjgHklAzO5oXbl4wRoT1
 sWriopiKWUIaRJHbv1NFgQMKJsMt6HkkNuDebIYKj6v9Ec4uio17fT5wOmHA6T+an2Q855iJl
 vE6v7Y4W9L3SJ587Jf6leNMFSkweXhej4CnFQCLRdmfIFI5IzCrYPCMdmCv1LZd/4v0es2362
 G6tBxX57SQ5WxONMElFgsVwqdoSKMmcRiAFbzA/ii04Ix0eyq8FmvN5NrzEaUtRV712DcC4ZP
 Ck3wTu0FywaoXJehWXOXvW4arv814LRU7SLrgMcRxkpnhIJ6lhlIC04MeZ4BbNtAYYeQ0Nr/L
 c8EFsYUn5VqrGct5JG6SGs6I4NBJ1G7szHW9uHePw88SHd3FytBwi1fEYI+No5Y4GeBxuz1hK
 wbUgOLXz4Z95RWK9vkOJcNk5gi1bgO0vvafWYNXX5Qu771q0UcBkrmd8cUKO/ZXveYndTM2zw
 KT2g0s+uYa54NYb/2VRgwKj9npE6KnGwDwTre6f9NLk2fLIg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.3
Subject: [Qemu-devel] [PATCH v3 1/4] block/replication.c: Ignore requests
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


