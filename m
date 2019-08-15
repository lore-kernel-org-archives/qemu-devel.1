Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B00BC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43235206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="P+EWcm6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43235206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKrI-0006In-9B
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hyKoG-0004BF-UG
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hyKoE-0006pO-IX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:49:16 -0400
Received: from mout.web.de ([212.227.17.12]:37549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hyKoE-0006oA-AM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565894936;
 bh=1aMK3WcfXGtXkTJdGeILldP4LKkJ6RJ1Yf8zxuMXcY0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=P+EWcm6tPBDbTSgxuA/Ce4H5DITJa7kJcVWQ38l9Ami+5z4EsUR9QV22H4LgPg0vg
 34SFZRyWcLcjNsy7HJ1tS0qvJV4Gzl++/KTITYS30TA8Z0O2DsBt0JQKKSoP31dJZ5
 0MX55l5J//GokFG0Mq6g72DDFbH8BuPS+4GHsu7A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.245]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKrLo-1hyKnv3PBA-0006xH; Thu, 15
 Aug 2019 20:48:55 +0200
Date: Thu, 15 Aug 2019 20:48:55 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <b80079b17afcbdf46a907a26d61ce0be97cbed72.1565894837.git.lukasstraub2@web.de>
In-Reply-To: <cover.1565894837.git.lukasstraub2@web.de>
References: <cover.1565894837.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XQIUXgVxtTTP+gnNFrDF7pKHWUhHtD0MetyfahPJ/KNbrEYPCYD
 e+nA2H/GjV9EnQHFitx/3nISTb5AwvJaz85XZ+SNrFoP/F148vCwh9RZ3H2cJUwv+d+6hTb
 s3JF78BC9/C7jkEFxvRmPxV5rRMuicHI9UPaMd/dLxdJktsI2s5/TFUuLkeifUsG8Q57a0U
 oM6/AxEBbVZ+YlTv/he+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sqRi+eHfCxw=:fNrT2wuUE8cHT6GIP5X6Cz
 FbMHX2zE54crVy1PS2T8oFNjj6/3x767CUsv5icfJqewPMrGgxcFinsXtcK3311ah8ksNgZQk
 vqLaILrtsyXfvq2MM1Rz0b6nUxF8gvtmQA+UVnC4FWlrCxxwbInaxxp45iVOpl8g4qzns3rjX
 bfZmYWtVZmGojN6a7w1nHXjf9yiFh+EbtoPFif8vLq6pvayI+ztAZOa+Zm3UaxJVYdLrvqNsH
 mdlJsLjriIsY7UEAYAN/qIR4aLKen3Mk320a47Vl9aE/Q/j7xDehrERZCw6GXJxUULcN/ucaK
 eLGFfafJ54wUtYS6F7ZAp6dkDK4+W/S75WGSaQF7LJFTXJ1zzoBcfFVNsZQbZMdZ1LqScoPna
 efUvhP2r1nwQrWlbHqO6kznyoWarzadPeWc3Ht8PJ93Yhj4LEq7Ui5Abmd157Ghk7smQOtE2l
 zRexQWZkyi8nikQdc+hN40zR8xuNUec61SLnpVGtpCR/zvx8sX+5AxH/T4e6jSp0Lwl+eQVYq
 jIb9N1dAZRV+YLJXE5L0K9f7lMmqgI3hMOtWZh/7WAMxoM/cyT3D0jgYzfmZhPsMyxgZz8hFI
 Rlfttq4D8J8IdqcnapfIMnOsZf7ovk3OIBy56vKrhmDIBG1GMbJoxl9wgHi2HBgggc8jXFD6c
 Pf4U1m3DFoZGIk3DRs/OOPTajKn49KaF+wWnqYbTv1Fxo9KIjlSdQWqWsL3NOPKSIpl3NA74w
 8dkLC7/ELqC0/2og7VFOijCp5w3FSwkQQiGqCS4av1CSdOaD1jgyReF9dKNu5iKggWy9yqWzx
 luL/MMyXKy9ofqorTnL76lUNMh2LF3IXZ+PKxtAtAPPJweHgeF7vlyEYVzDVksJARj2jcHVGi
 B4F9SQYbIqdTzH/XAKm9puBu1KrduZWR/zynnyzq1kG6JzcDMojRa5ywb6VjU3hjghx3fznSj
 Kkyo+ibewjbbRZAIt0X49rkegAmOcCq/nc5ir6cMLD7AI7Jc7zfOzkZ3h5JF6/NvcIo/r0bSB
 mbVLBLkmIcEVbrH9vx9D3CbPhy977MYfFqkZ/6gZONM5lOYvE4mrqbemWp3q+rXml7bXQAo4W
 6vF64DmuUxQ7a5CuKTkziJBTygPefz/dKJ9ieefQEz4E6n6sP56O/MgKt0+RP384of9sjkViu
 23Zkk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
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


