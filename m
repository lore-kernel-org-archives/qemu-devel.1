Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4FCC54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5AA20700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cGSJkMsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5AA20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSn4v-0005PM-31
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 15:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmum-0001Fo-2G
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmul-0005ys-Gl
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:07 -0400
Received: from mout.web.de ([212.227.17.12]:40077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSmuk-0005yb-VS
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587929155;
 bh=B9XY0V6HG/toYTYIEUFnzTvAwLVvOsgRzhHhxFxq1Xk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cGSJkMsFmBDBtdDVqFRt09CcjauLL/Ew0xJl1i9Qi3TVKQNgH/E7ShYSIhW/qUaij
 VZZXPHREWD3vvxKSJk1VX/jCqBsGFqnysfiz+K171wLwAAMB2Xp0tcqy4icw6DGaak
 UbenyxpO5zw3ewUtNFVnf7tIcUmFaYHfDS3pwh3E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.95]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyDph-1j5CGU14C5-015bYx; Sun, 26
 Apr 2020 21:25:55 +0200
Date: Sun, 26 Apr 2020 21:25:54 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Message-ID: <9cfb9136badd63804dab1331658803cf70d0cc3d.1587927878.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587927878.git.lukasstraub2@web.de>
References: <cover.1587927878.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vu=4iky4fZqke8Lw3.hGaZ7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:gTmJjSM3VizveceaIutLKB2t+8lYiqnFCFpGJpxZznR5WCtttvJ
 AFwabXg/wIsmkDIa4IIg6T15As+NhlAZx1wWMtCXHFn04PhL2SZLe1fJfUID/3GubncPCLJ
 FfSkq0G9bA54hnR4/Ytuj7/sLc/ZwPugHsTNTbRfTneAxIqtbYFtRBEbVKscQJ3MaUxNDv+
 PhBFlxVDpnJ79S5zJJydw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MAonEhhG66E=:LgLEuOyOngMPhKtIwkbRTR
 SxN6fLCrzJkFj9RaEJ1ySBDFQViFW08BQhRaDjU4Y6QnH10AuO6m/MeQDrNEAbh1xHygcX9ZH
 RJF5U//5i8km2b79RMMTnpSEdQkVw8wia292qh1FTQaF+bzhh2bXizPQ4kw3Q4GOY1/MIvpC7
 xP2N/2PVOtumQJzbQAI80emzwneBQeBdh7E8MDnW1E5gmQpYkh/keCCJAWJ6OiITLGwk/grsq
 Xqd7+890nyv51na6tHRG9fy0pvIc9+PkIKGiwZ4Z+hNbqhiIMlsGWs236ZdjrhR4HpLbn15yS
 617UgMJD1mT07zIwBZ56R1k7rbqI1lXyh507mNvfx9W/hfW1ed4po3N6CvEgp0RwsrUiqaQep
 xcq/CSpjwp7MU5EXhp2J41tIuwx3rtuuj16a5GinrKdG4pJLCw/hLt/qezvFMojSG6zUX7SgL
 p3bpHU25IPLLzhNo/F7UgPCoryLprWAX0V1q54afrX7eBwADtbjcUfn6VuVOhy4IMYqEAVAKP
 tayMHrCOAq2jNnf79RtokvNJaVfSdygiKf+Lraloz1nZQ1/t66Vtob9W702WsX3F0KpM3o2H+
 SZwqIuZoukDOyJJhxFI2d2wsnGwI7TzxS0NgmKmjycSBl3QoG6loH5kI9TSvgbBWeSyOBl6Fp
 htx6mkPi1NGLxaQ/We3hZWU2YE0eQ/6HJs+3x7uC+0Zhg8dmxqEvH+nOMDM4S0smyih/GlYlS
 FfiRJ3T8rhJOi/UVZqpKqH4HSUELanQx/2fD/tLkZIE15BQZNbdtIf8mQo1wZXP7XAx6ZVhpp
 KuBBcQh5wqybXeZ35v4U8STiPqg5v4GB3Owrr7t3MG4OYqonvIaMTZrdjAOyRh8sF/R4GckYY
 nstaxWRoGNjwrNLt5RMmBGi7E9wvtuyN9B5Es6XJD6rUG0RjADHAdcf7iJbzQTQkmmn55Y3X+
 BOMlwlXAqdXMPuppIS33OIqxv/wxvzEC1/fFtlucgNQIfWHlS8WFtzi5vc3oHOZhr0p6WYRA+
 wfBkqQdRP5MdjqCe4uxe44pGHxYzIgsoMVGaUZeNsixp/1xiJimpN8vQPE1c6OZ/lZXciXh+Y
 gqX4jfMQkXCKEu4/Muo0YMnrUGICss6MzZovTnIO3xjyNXVaM4UzEYmFSK6PYe06WNDBBzU/U
 g5AjCK6XJuzZvaqwoJA445RKLuDGcsoKtDDaFA0Y/3EeJZHILN7y0hBeoyTr9AoW50l1gMkjY
 2yc1vIHDNMKdwK6HE
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 15:26:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
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
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Vu=4iky4fZqke8Lw3.hGaZ7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If the colo-compare object is removed before failover and a
checkpoint happens, qemu crashes because it tries to lock
the destroyed event_mtx in colo_notify_compares_event.

Fix this by checking if everything is initialized by
introducing a new variable colo_compare_active which
is protected by a new mutex colo_compare_mutex. The new mutex
also protects against concurrent access of the net_compares
list and makes sure that colo_notify_compares_event isn't
active while we destroy event_mtx and event_complete_cond.

With this it also is again possible to use colo without
colo-compare (periodic mode) and to use multiple colo-compare
for multiple network interfaces.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 34 ++++++++++++++++++++++++++++------
 net/colo-compare.h |  1 +
 softmmu/vl.c       |  2 ++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 6634911770..a82bb27a67 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =3D
 #define REGULAR_PACKET_CHECK_MS 3000
 #define DEFAULT_TIME_OUT_MS 3000
=20
+static QemuMutex colo_compare_mutex;
+static bool colo_compare_active =3D false;
 static QemuMutex event_mtx;
 static QemuCond event_complete_cond;
 static int event_unhandled_count;
@@ -912,6 +914,12 @@ static void check_old_packet_regular(void *opaque)
 void colo_notify_compares_event(void *opaque, int event, Error **errp)
 {
     CompareState *s;
+    qemu_mutex_lock(&colo_compare_mutex);
+
+    if (!colo_compare_active) {
+        qemu_mutex_unlock(&colo_compare_mutex);
+        return;
+    }
=20
     qemu_mutex_lock(&event_mtx);
     QTAILQ_FOREACH(s, &net_compares, next) {
@@ -925,6 +933,7 @@ void colo_notify_compares_event(void *opaque, int event=
, Error **errp)
     }
=20
     qemu_mutex_unlock(&event_mtx);
+    qemu_mutex_unlock(&colo_compare_mutex);
 }
=20
 static void colo_compare_timer_init(CompareState *s)
@@ -1278,16 +1287,20 @@ static void colo_compare_complete(UserCreatable *uc=
, Error **errp)
                            s->vnet_hdr);
     }
=20
+    qemu_mutex_lock(&colo_compare_mutex);
+    if (!colo_compare_active) {
+        qemu_mutex_init(&event_mtx);
+        qemu_cond_init(&event_complete_cond);
+        colo_compare_active =3D true;
+    }
     QTAILQ_INSERT_TAIL(&net_compares, s, next);
+    qemu_mutex_unlock(&colo_compare_mutex);
=20
     s->sendco.done =3D true;
     g_queue_init(&s->sendco.send_list);
=20
     g_queue_init(&s->conn_list);
=20
-    qemu_mutex_init(&event_mtx);
-    qemu_cond_init(&event_complete_cond);
-
     s->connection_track_table =3D g_hash_table_new_full(connection_key_has=
h,
                                                       connection_key_equal,
                                                       g_free,
@@ -1382,12 +1395,19 @@ static void colo_compare_finalize(Object *obj)
=20
     qemu_bh_delete(s->event_bh);
=20
+    qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
         if (tmp =3D=3D s) {
             QTAILQ_REMOVE(&net_compares, s, next);
             break;
         }
     }
+    if (QTAILQ_EMPTY(&net_compares)) {
+        colo_compare_active =3D false;
+        qemu_mutex_destroy(&event_mtx);
+        qemu_cond_destroy(&event_complete_cond);
+    }
+    qemu_mutex_unlock(&colo_compare_mutex);
=20
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
@@ -1403,15 +1423,17 @@ static void colo_compare_finalize(Object *obj)
         object_unref(OBJECT(s->iothread));
     }
=20
-    qemu_mutex_destroy(&event_mtx);
-    qemu_cond_destroy(&event_complete_cond);
-
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
     g_free(s->notify_dev);
 }
=20
+void colo_compare_init_globals(void)
+{
+    qemu_mutex_init(&colo_compare_mutex);
+}
+
 static const TypeInfo colo_compare_info =3D {
     .name =3D TYPE_COLO_COMPARE,
     .parent =3D TYPE_OBJECT,
diff --git a/net/colo-compare.h b/net/colo-compare.h
index 22ddd512e2..eb483ac586 100644
--- a/net/colo-compare.h
+++ b/net/colo-compare.h
@@ -17,6 +17,7 @@
 #ifndef QEMU_COLO_COMPARE_H
 #define QEMU_COLO_COMPARE_H
=20
+void colo_compare_init_globals(void);
 void colo_notify_compares_event(void *opaque, int event, Error **errp);
 void colo_compare_register_notifier(Notifier *notify);
 void colo_compare_unregister_notifier(Notifier *notify);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 32c0047889..a913ed5469 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -112,6 +112,7 @@
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 #include "qemu/guest-random.h"
+#include "net/colo-compare.h"
=20
 #define MAX_VIRTIO_CONSOLES 1
=20
@@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char **envp)
     precopy_infrastructure_init();
     postcopy_infrastructure_init();
     monitor_init_globals();
+    colo_compare_init_globals();
=20
     if (qcrypto_init(&err) < 0) {
         error_reportf_err(err, "cannot initialize crypto: ");
--=20
2.20.1


--Sig_/Vu=4iky4fZqke8Lw3.hGaZ7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l4EIACgkQNasLKJxd
sliOohAAgOgrkZ3qi8Oo4iy6n88/GJGJVI5fBWasZ/g6gG9uvqHYAb+e+2hJNP/C
3q+9hXRYUjnAFRyocSnJoYjik9wOj5wPwQOkoz7ZVgQq6ZIcBtkHX9S83H5hCC73
IFkCKdmOj/cAiIJY+1LWPsWpCK1SeYXPpasp2ok5ZCmrwjEeQLlxmAQQ69RO27Hu
ZQ0bMzluwYg/AEMblNkeVEK7It4rMUACqpUemW3vhWVweOtrAUcZsmAoTY8qQiGO
EOB5nzRCbmGPheoj5xLy5KW8pYf1P/ZCcXwvtfb/3m6r0cB+ZtvE3yJXJVNruYl7
1arP05wA4p1tcpCrnvoClKIYAMuZfGx2WeKw2Lv8HBRmkApfYNr8m6nFvYn17vey
Z1xag12mPPxX24egTU7BUy5vYe8GhvM5QYbjP3286YYoBhIPoLhHHzqb7pMjWZKE
odiLqvbzPxueCNh4vk3eYX1yYoChtBIRyrCbmfdT8Ekbze0cUq5XWkAApYbFzIZf
02nW0SmEFfFTbfCDbDCBRCpi4D8PrCyuouts8Y8Zeswhzv6efGFRlEV9fu0CbbYn
0mzUWkyn6Oq2zhZO0F5d/7HhjzFBZdUeJDxA6Qgz9PJZos6dS3lX/z+gEIlTBM09
iFSf55zVdvjvA5ec+JN17/Kh2DGddFmO/kRqevAVhJB14VfrVtg=
=h3B6
-----END PGP SIGNATURE-----

--Sig_/Vu=4iky4fZqke8Lw3.hGaZ7--

