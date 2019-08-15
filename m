Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA6C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FA32064A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JtTS9op+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FA32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKFL-0002IP-Dv
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hyKB8-0007RV-Bl
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hyKB5-0006c0-Vw
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:08:50 -0400
Received: from mout.web.de ([217.72.192.78]:49285)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hyKB3-0006WD-Pr
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565892506;
 bh=1aMK3WcfXGtXkTJdGeILldP4LKkJ6RJ1Yf8zxuMXcY0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JtTS9op+mNlmcwE89uGiKLqsFcKRsAeTbjDAXk7rFPUbAbYALNvgIdYuODi2xSk1+
 Gfk9jKMPQOA/vMkvUTk2c29ZpJEQKN0anw/DAMKyGJ00myHaNrsLlHiP469oP0T0RB
 EbLb+AooWQo0ylXJeoVjwXDMhuE3ilxzmMXoKvKc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.245]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Maaur-1hii3v2OrZ-00K7tj; Thu, 15
 Aug 2019 20:08:26 +0200
Date: Thu, 15 Aug 2019 20:08:23 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <20190815200823.3de1bd14@luklap>
In-Reply-To: <cover.1565892399.git.lukasstraub2@web.de>
References: <cover.1565892399.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rM1nWaZ12bjUfaU57768Ifo1LoOkeyHGgiBGivHQ36HR+pe99mB
 ZFr6ZyvdhoclTvIBydSrvru0Gq2ozdWVQf1anXr9dkTObBH8KTwiYlZUwAYXqM5P/92M1ac
 UFywEHBBIlteyIWs7U8fD8P4JKG8T1vUQ1XA9XlRCaAniEUMKihxqbg+5PgMhU4GiCMtUds
 bMN9NHq4WGlfSQoMYOGgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1uReHKE3F4A=:8CNo+FMgWhHDQ9awysVLHq
 KgFt0p/13cmKAFUYC+8oFk8/25LudFgCPkQYehszrGSOATqXcr+/Y3sETWqXitUYYyKjmTBR1
 6D9JY/8SDuusvAiOSPfPayX5gePpXPcFSrw7tNEadnZaPBo/ldV9QVkuKNsqhroC9vQUZOOsk
 mm0TxbR4XnwtbN5wHdhb1yxU5mroe4D3QVsumaRqwu7n5MJh/3obnm5U1hf8eoWYNf80XDBNi
 AdgcOE+rA58vILoz84fzHtjM02wV7c7CnOru65QQ54WxvSb7DXaG2hifLkrmJ8lJ6HgkYR+jr
 pvUTGHRA0vG0zzuGV5tvAGk4DUL1r579DnacXrQIiV8DwiDprN4K8hMY9edCKnrcKcHOqim5s
 0dgPUeagXXa/02J55964Vy0z4LrGtz5r70k+ub+cCnad/JQJ7ye/VsbQOG9JNDyCevLHsYHTz
 sU81BUqo3vZysYk0pDouCUtmxQ3RBIVHadBLmp0GVcguNB7ViLevecB3T1Trj069ZGn3k2twQ
 5tGp/GNpeqbeRKDfAxvKUmYBX4xqRVZAAxqDeOto9CoS+ryuDiD1ZlkUS+r4detk3BAZJJifu
 YIdfTafu3UqPTQAVPdcYm/zs/74Nsx/wYjwYXCT86H6YlPT6krEZ7je6KsYK/K13TTGU1YxoV
 tEWCPe9pJCRIs0oFv2P5p33tJZ9fCLMG8IOlbvO+DSOrEXZhoUp+6c1E5aOLzJH4rGd92zoFK
 oSqmvm4N9LgKIk+OBnTnB0sWIL4htL/+2gAE1Ej9/xuo9SZqs/IHNp1xl7xMbrB5PxILdDice
 N55BBLkQEY268FJvuJyLW+qHKprIxzT/raDl3Xu2to/lTF0R9Ae5dQVydC4Vi0iRIhyC/Freg
 kPLbnYuHFgI+vqFopPT6Zp+fY0cTt4SKzCXN+0StjBgqGAnFVmnc3Ok1rtH97egl/SiBW2Yb3
 uLu+j2rVblew1uhxD+hKbLbP6f/WOupZNBL4dHa5p7mSplJMI2BpFh+bnmQrIJe/eVmb5HRWO
 1vczH2He7cHXQ2UGsoW67v/esy0uF88dJpw/0+BAVoO93nux9x6WKkHD39ul/RcB3eKstQgtk
 Pvg+UgUdlftsb6sIx5mshmgJ6/95yfSt9skBH8xbm82flbKIYebhdYdqmyz0Sve3qM8MTcR34
 ivLUA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
Subject: [Qemu-devel] [PATCH v2 1/3] Replication: Ignore requests after
 failover
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Wen Congyang <wencongyang2@huawei.com>
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


