Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A805C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFFB120700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VgPHS+gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFB120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSn5F-0005fz-Ox
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 15:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmum-0001G3-Do
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmul-0005z0-Mb
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:08 -0400
Received: from mout.web.de ([212.227.17.12]:42635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSmul-0005yc-4N
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587929148;
 bh=XzyQeeYA8Al951pEnCzxGvm/pkLkir9rATgvuE2V/J4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=VgPHS+gmzwV2MWLkL5O9vtOEQZJipeDjLtFu3+Id43nCaPpcTCBH2kwonKaAjCcQb
 Lhl8SnsSMNVTalccIFHGW85Mheqb2V59/Ebz63nCG4I/7Gn2gkUAxpIjCiuwuVLecG
 MEGXKmxaEIBYcMLnXV99xx90LslF2b6Q4LUt2o+g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.95]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7bYJ-1jEaCp13aR-00xJ7H; Sun, 26
 Apr 2020 21:25:48 +0200
Date: Sun, 26 Apr 2020 21:25:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 3/6] net/colo-compare.c: Fix deadlock in compare_chr_send
Message-ID: <6f3906393aaaf0adf21d45a5bf7a41536c7de205.1587927878.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587927878.git.lukasstraub2@web.de>
References: <cover.1587927878.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xtl4VBV28Z=XH2MY_C=BTlx";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:cNCVc0bGI9NWmdiseP0KzPxT8y+z0bSMKMaRe4r/tQMcxZDJaAR
 oRzHXYtKiAR+Np5qImdfguvEOdZduItN/D+GPQS0sM8v0HqpD+YxY6ATT138XY3Eu4VmJwn
 ANWXwP4wwY4xOQ2nQSRextNKSd6+6uCY5ZzV29EAlzoT1g86/lFUNpELdtdvx3Y9XyDmzNW
 4Xd1OMW0/P+tMUHe0ycgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n5zX3LLSY5Y=:+oWp6sPNj/6+x71QfvQdAw
 WkR2zuiN2umGNaqBZ4ZaIoKCBnOObdYCOMV+Rs/sT+U9KovG2rbdncN3UV0JwkWQA5r6SoIPk
 UcxjWYBIfmtitS8r941JnDdry3NqkDTK5C0HtadGmQu6OXf3hlWip5Fp3zpfGXWjQigP8phMy
 RezG7Hj6xoyBOrciFUqxpbHw5h0ijE8RtYpEq0+LBb1HI/hUXnNcgSqzQMl+E5IQPvyAWp+lp
 UatQ7yLLsujBmu4JYJOUIkRpchXInWZZl+N/VtX/QOaaY5MjRsQ1U52OWykf60wHWri3pvto9
 fDIuAvtmzewwfaZin6wbOpWnfS4g163FQKEliFOfiCeOiZplIWhMPYOLS/xhtYCi7GhYGg3F/
 CyEpgCItt+S4z3Ng8xPFkCa+RSpjxA4XJXmX0Hv4sAq+CVvd8CDk0gMZrkyL75uzItW6UPww9
 ZYlKS/HSyUMqPHndq89Rf7HJsVr4UK70o8ylX7AgcMx8/Xf9q6bZnfoV2+l9gF3EIgujZbdJL
 a2lA5d+Cuto3UOCnm8QCh0vX5MRzuvTZv8ERDBMBPGKlmvpf18IUCpJm35OwznItSutodskmK
 mAc3TX45NERbVuyGiM7o8N+WQ1LrGoqIMwM7ywpgbyChSZQj59pMWzuHICspUY6W0Zahooqr9
 iblHayOawgQkJS1tFHXv8WCMNGYuoqd0BJQpsa7mKMkqBxofYZ3JWUN1cVgV8avrtEX4ymnlL
 VKL3KRHWdM5m2B5U2fW92/2Xm2Bx2guRQ2SJxzwYY8pNgk7TGEfk8BBfYt1/QUoVAzoj8fIyd
 Gwp7B0t2muo4LrypEjjI1fU0pMdgvOObT0tXPGnfcN2is6+q0N0HL4dLoC6wy0qm8r7lWJP/9
 3ZzuOC3nVpbY4GBYvSHdb5XQdC4ugi4pj8XMR0/rcGYOGCqj7LGdsmjF7FIPgdPSb9nu0kWJ3
 UuklwVV5w3lZ0M9VI/32N6qcK4lFpMbox0r2/LLvEayOSkYvMkBuI33cTpp/mMFa2ah+JjILT
 Ckf52r/DmAj8S7EYlzMYPJJjRupUDmDPwfJSXBh0J38ubcnuskU1xhhAJQO0oqKFoRsJf6Djh
 DpUjWdAI2TInDVjH/qBmzOqD6KV/VHmWaai9uS645GWeFZeOJ3hOmaemj0rhy84uJ7z+nTrWx
 UeXteGR2G2382tx+C5q0MU8/keMcsWDyAfGeAZVDLD5HtzYDw4wr6OLHVDTI6bc3n8fTPnrQe
 BbhIsfdrczEuA1++J
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

--Sig_/xtl4VBV28Z=XH2MY_C=BTlx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The chr_out chardev is connected to a filter-redirector
running in the main loop. qemu_chr_fe_write_all might block
here in compare_chr_send if the (socket-)buffer is full.
If another filter-redirector in the main loop want's to
send data to chr_pri_in it might also block if the buffer
is full. This leads to a deadlock because both event loops
get blocked.

Fix this by converting compare_chr_send to a coroutine and
putting the packets in a send queue. Also create a new
function notify_chr_send, since that should be independend.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 173 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 130 insertions(+), 43 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 1de4220fe2..ff6a740284 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -32,6 +32,9 @@
 #include "migration/migration.h"
 #include "util.h"
=20
+#include "block/aio-wait.h"
+#include "qemu/coroutine.h"
+
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
     OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE)
@@ -77,6 +80,20 @@ static int event_unhandled_count;
  *                    |packet  |  |packet  +    |packet  | |packet  +
  *                    +--------+  +--------+    +--------+ +--------+
  */
+
+typedef struct SendCo {
+    Coroutine *co;
+    GQueue send_list;
+    bool done;
+    int ret;
+} SendCo;
+
+typedef struct SendEntry {
+    uint32_t size;
+    uint32_t vnet_hdr_len;
+    uint8_t buf[];
+} SendEntry;
+
 typedef struct CompareState {
     Object parent;
=20
@@ -91,6 +108,7 @@ typedef struct CompareState {
     SocketReadState pri_rs;
     SocketReadState sec_rs;
     SocketReadState notify_rs;
+    SendCo sendco;
     bool vnet_hdr;
     uint32_t compare_timeout;
     uint32_t expired_scan_cycle;
@@ -126,8 +144,11 @@ enum {
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size,
-                            uint32_t vnet_hdr_len,
-                            bool notify_remote_frame);
+                            uint32_t vnet_hdr_len);
+
+static int notify_chr_send(CompareState *s,
+                           const uint8_t *buf,
+                           uint32_t size);
=20
 static bool packet_matches_str(const char *str,
                                const uint8_t *buf,
@@ -145,7 +166,7 @@ static void notify_remote_frame(CompareState *s)
     char msg[] =3D "DO_CHECKPOINT";
     int ret =3D 0;
=20
-    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+    ret =3D notify_chr_send(s, (uint8_t *)msg, strlen(msg));
     if (ret < 0) {
         error_report("Notify Xen COLO-frame failed");
     }
@@ -271,8 +292,7 @@ static void colo_release_primary_pkt(CompareState *s, P=
acket *pkt)
     ret =3D compare_chr_send(s,
                            pkt->data,
                            pkt->size,
-                           pkt->vnet_hdr_len,
-                           false);
+                           pkt->vnet_hdr_len);
     if (ret < 0) {
         error_report("colo send primary packet failed");
     }
@@ -699,63 +719,123 @@ static void colo_compare_connection(void *opaque, vo=
id *user_data)
     }
 }
=20
-static int compare_chr_send(CompareState *s,
-                            const uint8_t *buf,
-                            uint32_t size,
-                            uint32_t vnet_hdr_len,
-                            bool notify_remote_frame)
+static void coroutine_fn _compare_chr_send(void *opaque)
 {
+    CompareState *s =3D opaque;
+    SendCo *sendco =3D &s->sendco;
     int ret =3D 0;
-    uint32_t len =3D htonl(size);
=20
-    if (!size) {
-        return 0;
-    }
+    while (!g_queue_is_empty(&sendco->send_list)) {
+        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
+        uint32_t len =3D htonl(entry->size);
=20
-    if (notify_remote_frame) {
-        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
-                                    (uint8_t *)&len,
-                                    sizeof(len));
-    } else {
         ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof=
(len));
-    }
=20
-    if (ret !=3D sizeof(len)) {
-        goto err;
-    }
+        if (ret !=3D sizeof(len)) {
+            g_free(entry);
+            goto err;
+        }
=20
-    if (s->vnet_hdr) {
-        /*
-         * We send vnet header len make other module(like filter-redirecto=
r)
-         * know how to parse net packet correctly.
-         */
-        len =3D htonl(vnet_hdr_len);
+        if (s->vnet_hdr) {
+            /*
+             * We send vnet header len make other module(like filter-redir=
ector)
+             * know how to parse net packet correctly.
+             */
+            len =3D htonl(entry->vnet_hdr_len);
=20
-        if (!notify_remote_frame) {
             ret =3D qemu_chr_fe_write_all(&s->chr_out,
                                         (uint8_t *)&len,
                                         sizeof(len));
+
+            if (ret !=3D sizeof(len)) {
+                g_free(entry);
+                goto err;
+            }
         }
=20
-        if (ret !=3D sizeof(len)) {
+        ret =3D qemu_chr_fe_write_all(&s->chr_out,
+                                    (uint8_t *)entry->buf,
+                                    entry->size);
+
+        if (ret !=3D entry->size) {
+            g_free(entry);
             goto err;
         }
+
+        g_free(entry);
     }
=20
-    if (notify_remote_frame) {
-        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
-                                    (uint8_t *)buf,
-                                    size);
-    } else {
-        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
+    sendco->ret =3D 0;
+    goto out;
+
+err:
+    while (!g_queue_is_empty(&sendco->send_list)) {
+        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
+        g_free(entry);
     }
+    sendco->ret =3D ret < 0 ? ret : -EIO;
+out:
+    sendco->co =3D NULL;
+    sendco->done =3D true;
+    aio_wait_kick();
+}
+
+static int compare_chr_send(CompareState *s,
+                            const uint8_t *buf,
+                            uint32_t size,
+                            uint32_t vnet_hdr_len)
+{
+    SendCo *sendco =3D &s->sendco;
+    SendEntry *entry;
+
+    if (!size) {
+        return 0;
+    }
+
+    entry =3D g_malloc(sizeof(SendEntry) + size);
+    entry->size =3D size;
+    entry->vnet_hdr_len =3D vnet_hdr_len;
+    memcpy(entry->buf, buf, size);
+    g_queue_push_head(&sendco->send_list, entry);
+
+    if (sendco->done) {
+        sendco->co =3D qemu_coroutine_create(_compare_chr_send, s);
+        sendco->done =3D false;
+        qemu_coroutine_enter(sendco->co);
+        if (sendco->done) {
+            /* report early errors */
+            return sendco->ret;
+        }
+    }
+
+    /* assume success */
+    return 0;
+}
+
+static int notify_chr_send(CompareState *s,
+                           const uint8_t *buf,
+                           uint32_t size)
+{
+    int ret =3D 0;
+    uint32_t len =3D htonl(size);
+
+    ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
+                            (uint8_t *)&len,
+                            sizeof(len));
+
+    if (ret !=3D sizeof(len)) {
+        goto err;
+    }
+
+    ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
+                                (uint8_t *)buf,
+                                size);
=20
     if (ret !=3D size) {
         goto err;
     }
=20
     return 0;
-
 err:
     return ret < 0 ? ret : -EIO;
 }
@@ -1062,8 +1142,7 @@ static void compare_pri_rs_finalize(SocketReadState *=
pri_rs)
         compare_chr_send(s,
                          pri_rs->buf,
                          pri_rs->packet_len,
-                         pri_rs->vnet_hdr_len,
-                         false);
+                         pri_rs->vnet_hdr_len);
     } else {
         /* compare packet in the specified connection */
         colo_compare_connection(conn, s);
@@ -1093,7 +1172,7 @@ static void compare_notify_rs_finalize(SocketReadStat=
e *notify_rs)
     if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
                            notify_rs->buf,
                            notify_rs->packet_len)) {
-        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+        ret =3D notify_chr_send(s, (uint8_t *)msg, strlen(msg));
         if (ret < 0) {
             error_report("Notify Xen COLO-frame INIT failed");
         }
@@ -1199,6 +1278,9 @@ static void colo_compare_complete(UserCreatable *uc, =
Error **errp)
=20
     QTAILQ_INSERT_TAIL(&net_compares, s, next);
=20
+    s->sendco.done =3D true;
+    g_queue_init(&s->sendco.send_list);
+
     g_queue_init(&s->conn_list);
=20
     qemu_mutex_init(&event_mtx);
@@ -1224,8 +1306,7 @@ static void colo_flush_packets(void *opaque, void *us=
er_data)
         compare_chr_send(s,
                          pkt->data,
                          pkt->size,
-                         pkt->vnet_hdr_len,
-                         false);
+                         pkt->vnet_hdr_len);
         packet_destroy(pkt, NULL);
     }
     while (!g_queue_is_empty(&conn->secondary_list)) {
@@ -1281,6 +1362,11 @@ static void colo_compare_finalize(Object *obj)
     CompareState *s =3D COLO_COMPARE(obj);
     CompareState *tmp =3D NULL;
=20
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
+    aio_context_acquire(ctx);
+    AIO_WAIT_WHILE(ctx, !s->sendco.done);
+    aio_context_release(ctx);
+
     qemu_chr_fe_deinit(&s->chr_pri_in, false);
     qemu_chr_fe_deinit(&s->chr_sec_in, false);
     qemu_chr_fe_deinit(&s->chr_out, false);
@@ -1305,6 +1391,7 @@ static void colo_compare_finalize(Object *obj)
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
=20
     g_queue_clear(&s->conn_list);
+    g_queue_clear(&s->sendco.send_list);
=20
     if (s->connection_track_table) {
         g_hash_table_destroy(s->connection_track_table);
--=20
2.20.1


--Sig_/xtl4VBV28Z=XH2MY_C=BTlx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l4DoACgkQNasLKJxd
sliYkg/+O+kCeGrzo1km9WUIdghAAtkzzEIBzU2eKKZQwH8NH7GtzishGvRsHbIg
7d228PCXMtokIai52TXwisUUTd80VxPbEEabww//CLtF6YtJ4z2N4M2S/3HShVsP
bDa7xFHftl7wD9+1+6yPbKUfvSi7+sCF6Hv5gZ3t13pzxBsYdubrZBP2Ylfrjynu
4KZd8HfmDA7e5Le9B98+oYHztbWrOp3Gez7N4D99HkYMoLxARsOY5H4QMSHzWijm
ZrhYsXdJ+xHW2xofwphEGibfpZKYBKqmq2TUm1NvJNH4oDxSR15lrZb+H3XUp0a9
M5OxWHf1Va7Ij0Z2A0rpTbDPcC1+KAKn99pzcXxuUtuIR1xISDfF+Nkt8qekZ1jW
nAaxru3dnGwKBuBNKNK+Qh24MpKQzpSWGdBLhVyCi8WHsz9nKxnIEPsFjT58JKwd
0sYPd1B6IgQ7BAzmnxTJTthmSj4CL7yL9PkLL5uKy31KH5lX7Tm6jIzHV98qUDD2
Uo8QdjCC40lZewydTAWksZ0JXzeFPRSIwJFeS2O5xWk+KzuHwopch83s78nKsT/w
JmN11AWQIM/Z/KnrJS4xVzEHONbGcD+juhLZeHhHYXiHP+gUEvJ1yrKKEPl4k7Cp
V4hNhJ7qKYk6Le4KjvBbd5fJ2tdo+bhqRZfcIek4wPL27MQ3aHM=
=MiV5
-----END PGP SIGNATURE-----

--Sig_/xtl4VBV28Z=XH2MY_C=BTlx--

