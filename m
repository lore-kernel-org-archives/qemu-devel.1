Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A8DC4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667DB21479
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="k2aBxeNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667DB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9a7y-0005gb-30
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i9a4Q-0003bT-9j
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i9a4P-00010R-4W
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:26 -0400
Received: from mout.web.de ([212.227.15.3]:44085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i9a4O-000109-Ot
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568575204;
 bh=1aMK3WcfXGtXkTJdGeILldP4LKkJ6RJ1Yf8zxuMXcY0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=k2aBxeNH4Y9aZe2flT4uY7DjFDLoWMQ/oD4kAxJXSbJWA7jGfNy4QODKorfXbhAO/
 abv5RhozCQVmP/zkE3WMxJYKlgt+j2SEAmxctzdH4aq/cg/qirK6VIbCh66pf91vTa
 kVogEAcjCH4tXkalSD5opH5AGOCfwD1GE4TWUTbU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.53]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNtP9-1i2iJb1WRP-007Xvf; Sun, 15
 Sep 2019 21:20:04 +0200
Date: Sun, 15 Sep 2019 21:19:59 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <5305f30b0f798adfc3883bbcebbfc5030661dbe9.1568574478.git.lukasstraub2@web.de>
In-Reply-To: <cover.1568574478.git.lukasstraub2@web.de>
References: <cover.1568574478.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KiGlgs7reKKA72JZG9lsooaNACPtkO175t9ldaIG5awBy7Nw92X
 VbSJfAc0rSfoGayof6+BxzWgMy/RpPMj5z5YgAMS6TGaAcbOPjrEeEftRAqL8RVODotwMip
 mLabJ0K05ZuzuqbFDmvVXWpgrYUsJwzK6xfCp+xkRjt5tIfutpVZtzWUjvHpSBjDagoc/pC
 un22cwZs9bvffpHEu960w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yhEVqWDVeis=:tP+j4xQjscmSEdbBt5TVFC
 9lKJApaF+vpOaWXm2uQxSoBv3sT7CuvVylNTfU/xAoT8wptOVa9AV7CIMF+D4K7R1JKqN5PI9
 BSnFcpCA9VvdeoATmFxwQlLM2rAg5Go8uT86LqxkVoKMNp5F1/Smi2wQNUsGhBdhxWhYeYnDc
 iSri3BOtt7NjnSFDb7dxZdGFIM/4Mft3ERBfc5OTpfOlRgpJ+gpv0jlxtJCtme5MJaT3KgTfj
 hvyW+Hf+hYDrTEJNwB9XhtQX7hW5609SjI710GVMRVRaxoh2mdo1ECYkFqfFdNvjmNVXlIrf0
 AQUB0NBHd5UMEtDyUYEDSIOUjQ60NWht/WaLhyjFCgZ7OUOooafpxaIvSrLzHiWWp1HorWNdr
 SCZuqvcR7Zdz28/o8K5ykPiOObIuf0rg4c70N8iPKP6KtTZyfsqI8PdZLfCyj6wjIJgq7TSsi
 aLNycYv8xWGcunxXB6mNiF96P48O6Wc9ay94w4hbKPSK/aXDZo+a4ny2oC6GGuzH2681d+/Qc
 FLMrHreSFlBjRssSqQcv7MjK/FkGR4bUPEScFJ7Clfz7Czb+ex/hbBTqoSsaWnoR85h9gzpiR
 4KLMw+io5ChHP9ypwkMkCzEfEX6YryWYDFdDrndFMZuSYiMuXm3fWfA58ByNGt2I7KiSRSXUG
 5mE+sH8Z6VkEdjvSKjV8UkqTkJP3P9AVN7sXXTozfVnn2xoaGOm7kwLhF9ky5bh8EFkcdqr8C
 hsiUCiLVepLKQUK9Cy5jhlH/+D9J4XN/2FA1uwyd5szfwDwBTCTUE8WhLXbgsD78PMCEqylmJ
 OMYkPnU22MFaxAuW7PXnOKu5JYpuaOr9vRe8gPERQ3duA10TUwixaIju2STRdaubI/Hef4WDr
 Fa7GjGswmQV+JdGlzc2buQMRO2kWUa1IFhCqnMozR65u6TJIA7IuGudYqA0XMiCZLo9Nx+dWz
 aRfGO4BWJSnDwIZWI28jUXTuC+dMI22TQuQz8j2N3QiKb2JIC+0igxC8wDhcPm3g2hyDMiumJ
 NUVI9xoP0RRNGkLRdMMfx+16yCHoLzB9Bfb3g0aNognQwMzfheYJQ7vpe16ULog1lrhRDc361
 IScsIROklMAa+f2wfjfS7X32/aG80X8g8BrlFrflStc1MMdrRUxO/+WffXeI8TYYdvPO22GhV
 RPqKM/7WJU6CLz5ZBHFcihUryFGrvraFE6pSWQziT4YYz94sXavtKJoZuubkxHI3pIIpYaKFp
 dcwE7JlrvLivY8G/V7nAb8GfkRk4bkHxas5DsDSIlhoMAmIrgPKcWNbVZXjo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.3
Subject: [Qemu-devel] [PATCH v5 1/4] block/replication.c: Ignore requests
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


