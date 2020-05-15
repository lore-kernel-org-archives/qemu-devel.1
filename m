Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D31C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19627204EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BK5HWRWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19627204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYPF-00021I-4u
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYG0-0001lR-8a
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:12:00 -0400
Received: from mout.web.de ([212.227.17.12]:46255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYFy-0008Ej-Q5
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589541108;
 bh=h6IpceFVsmiO3dN/N26P3SqX+10w29Rm94J4RmiFVIY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BK5HWRWDTl4f8wwdSCnWZK32nGdaMxUhWqznKR3lWW5Il+Sg/6NWV3t1VGgF16iu+
 kaFlVWWzFKHPhoxN8DdwXxT0tfspRJj3knUq0Tjphy/5pn4LcCH+fCyGJNBXlHPT4z
 2QtBNs68B9fmMcYs01AdBhv7Lc5JZ9rZUrMQk23Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZUJt-1jo3Mv0OSb-00LJHO; Fri, 15
 May 2020 13:11:48 +0200
Date: Fri, 15 May 2020 13:11:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 3/6] net/colo-compare.c: Fix deadlock in compare_chr_send
Message-ID: <41051a5d0fcba1e2abe19a5d860b3cd984101db6.1589540787.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589540787.git.lukasstraub2@web.de>
References: <cover.1589540787.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jf1UHXSeiwMszPkhIHOqgs.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:mo5nJpRzt8GpmD+xL7ROUa2+6QZELEEGEzkEWobNLHa370lS+tX
 Oxs9DETs1DXf2ZTZxLOMshVIMxPWaPGSppoXXeSQ+mZfbMdz4EA7qy0QpXzDNOmPPnypyb4
 25CkNYUAlkX3gz0De2c4iWd1tu2PA8gn36RkNEddCpWiybcgVbsmYA33Gkb6eGDupi6VrQP
 mGS1X9M4pstp36xl2thKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lznnTldY390=:gbzc4FIw6xh5rA9lD0gi69
 3j/b4cwAuRkZRVcbNOJgHhNqF+s69IDEZ4Ij8CRoQY0IMcmeWAwhQpRk5Y9joYXM/AX0JgWRy
 MGyetWMOLJj8cUj18iD49C72+FdnIhAf32CQ/6xRyX7BayCgizzSnx9rOYXIFMDDzH8ardN3h
 JgwfmSvKUfGYiEdObYvPWlm+JjxzdBBT5uPyDhEGd/oWHGyD4vb3GDYaQERCp2GAQjc+yKcIW
 1PSGVaofhD1RZU7kcwMXefau0HgJ88zGVyxRl3dOdj4gCGF6QfGMakMjgPBm5vYU6FJVMM8c9
 bkZ9YG8bPmTHxntMU8O/oGQyiGtsrw/8z0v0Wjd4y6yZaUyjMGeUyVLKtSPjOXgKo37mpF+dU
 d+bHPWfzAbq4AuqsqvpuPoka74FyrrpNscE3wEPt8Vy9Y870znEhQl07n2nAGydJ2qP2mnJ9g
 EQZyRRmKIBMfEzzqE9jrKkunaSK4X5TWCB2F4I/jyQx7iKZ3syb0RaUJHL5jOQkK7RDf0i72i
 /PXEL35cT+WZz3VhFf4riFJmV3dyoIjy01tZdQFA6Jz47wFM/cfiE8WXi7ttoxO865w6kjofJ
 KDrHRd/o8UOtUFvvJq3OwW9VTJndq8FzeLr4Qn5r31ufUEMILEa+Cyg2zqgNa+qgVrg0sXO6e
 oUWh9UIcMdyOw7vwG/CpX0Uk6ODKVBKPclLnrxYiCCz195odYJhHMRSNSXD7t9xp3eEBXl21S
 zqDakHOFBPc+igz2ZDEO42N2rACoUUiX5fCZUgN/OOst/zUNnvTf74BKxULdzVgGcKzN7ZNav
 KlEC3jrOVhGJYEvpXMnEqfsDktOQDRnYLJnHVUx22I3pueH7QcCkChJTvTpvhBwKBs8d/3OSS
 i+lsFoG+8DEwGea2zkY5U91K75/gp0RhLsYZ0IC/EaINaBxewJST0IYzEsEoHszCWeuN/2byT
 avSLIBrlnE4eb+Fu6e+tTMXU6X7IF2NXbTTiF8rY1zKBR1JM6DAnuIr1jKHO8cFfEzoCVShgN
 Yo0efx6s7SBPFJLjSeJyQNWtG7eHAohX4Z4TI79brCEvExyKbpPJQc6odjpQpNveS0MS5RDBJ
 nrnxUb4X2FPYBApIU+urJRdcCFeBQSvbsa7eSg5t6CZ0pjnulrMaK1o0Eey0uDzszZYd44Qk6
 KRB47NG0S8Qrfdiqe6Tw2XZaSNFhizD/8uxzLsSSqaKuCmPce0FBCs1STqTuw+YT7aLkYerx7
 IvcfHQ9e5pwJNe5ho
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 07:11:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

--Sig_/jf1UHXSeiwMszPkhIHOqgs.
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
putting the packets in a send queue.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Tested-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 193 ++++++++++++++++++++++++++++++++++-----------
 net/colo.c         |   7 ++
 net/colo.h         |   1 +
 3 files changed, 156 insertions(+), 45 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 1de4220fe2..e47c8c6049 100644
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
@@ -77,6 +80,23 @@ static int event_unhandled_count;
  *                    |packet  |  |packet  +    |packet  | |packet  +
  *                    +--------+  +--------+    +--------+ +--------+
  */
+
+typedef struct SendCo {
+    Coroutine *co;
+    struct CompareState *s;
+    CharBackend *chr;
+    GQueue send_list;
+    bool notify_remote_frame;
+    bool done;
+    int ret;
+} SendCo;
+
+typedef struct SendEntry {
+    uint32_t size;
+    uint32_t vnet_hdr_len;
+    uint8_t *buf;
+} SendEntry;
+
 typedef struct CompareState {
     Object parent;
=20
@@ -91,6 +111,8 @@ typedef struct CompareState {
     SocketReadState pri_rs;
     SocketReadState sec_rs;
     SocketReadState notify_rs;
+    SendCo out_sendco;
+    SendCo notify_sendco;
     bool vnet_hdr;
     uint32_t compare_timeout;
     uint32_t expired_scan_cycle;
@@ -124,10 +146,11 @@ enum {
=20
=20
 static int compare_chr_send(CompareState *s,
-                            const uint8_t *buf,
+                            uint8_t *buf,
                             uint32_t size,
                             uint32_t vnet_hdr_len,
-                            bool notify_remote_frame);
+                            bool notify_remote_frame,
+                            bool zero_copy);
=20
 static bool packet_matches_str(const char *str,
                                const uint8_t *buf,
@@ -145,7 +168,7 @@ static void notify_remote_frame(CompareState *s)
     char msg[] =3D "DO_CHECKPOINT";
     int ret =3D 0;
=20
-    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true, fals=
e);
     if (ret < 0) {
         error_report("Notify Xen COLO-frame failed");
     }
@@ -272,12 +295,13 @@ static void colo_release_primary_pkt(CompareState *s,=
 Packet *pkt)
                            pkt->data,
                            pkt->size,
                            pkt->vnet_hdr_len,
-                           false);
+                           false,
+                           true);
     if (ret < 0) {
         error_report("colo send primary packet failed");
     }
     trace_colo_compare_main("packet same and release packet");
-    packet_destroy(pkt, NULL);
+    packet_destroy_partial(pkt, NULL);
 }
=20
 /*
@@ -699,65 +723,115 @@ static void colo_compare_connection(void *opaque, vo=
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
+    SendCo *sendco =3D opaque;
+    CompareState *s =3D sendco->s;
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
-        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof=
(len));
-    }
+        ret =3D qemu_chr_fe_write_all(sendco->chr, (uint8_t *)&len, sizeof=
(len));
=20
-    if (ret !=3D sizeof(len)) {
-        goto err;
-    }
+        if (ret !=3D sizeof(len)) {
+            g_free(entry->buf);
+            g_slice_free(SendEntry, entry);
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
+        if (!sendco->notify_remote_frame && s->vnet_hdr) {
+            /*
+             * We send vnet header len make other module(like filter-redir=
ector)
+             * know how to parse net packet correctly.
+             */
+            len =3D htonl(entry->vnet_hdr_len);
=20
-        if (!notify_remote_frame) {
-            ret =3D qemu_chr_fe_write_all(&s->chr_out,
+            ret =3D qemu_chr_fe_write_all(sendco->chr,
                                         (uint8_t *)&len,
                                         sizeof(len));
+
+            if (ret !=3D sizeof(len)) {
+                g_free(entry->buf);
+                g_slice_free(SendEntry, entry);
+                goto err;
+            }
         }
=20
-        if (ret !=3D sizeof(len)) {
+        ret =3D qemu_chr_fe_write_all(sendco->chr,
+                                    (uint8_t *)entry->buf,
+                                    entry->size);
+
+        if (ret !=3D entry->size) {
+            g_free(entry->buf);
+            g_slice_free(SendEntry, entry);
             goto err;
         }
+
+        g_free(entry->buf);
+        g_slice_free(SendEntry, entry);
     }
=20
+    sendco->ret =3D 0;
+    goto out;
+
+err:
+    while (!g_queue_is_empty(&sendco->send_list)) {
+        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
+        g_free(entry->buf);
+        g_slice_free(SendEntry, entry);
+    }
+    sendco->ret =3D ret < 0 ? ret : -EIO;
+out:
+    sendco->co =3D NULL;
+    sendco->done =3D true;
+    aio_wait_kick();
+}
+
+static int compare_chr_send(CompareState *s,
+                            uint8_t *buf,
+                            uint32_t size,
+                            uint32_t vnet_hdr_len,
+                            bool notify_remote_frame,
+                            bool zero_copy)
+{
+    SendCo *sendco;
+    SendEntry *entry;
+
     if (notify_remote_frame) {
-        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
-                                    (uint8_t *)buf,
-                                    size);
+        sendco =3D &s->notify_sendco;
     } else {
-        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
+        sendco =3D &s->out_sendco;
     }
=20
-    if (ret !=3D size) {
-        goto err;
+    if (!size) {
+        return 0;
     }
=20
-    return 0;
+    entry =3D g_slice_new(SendEntry);
+    entry->size =3D size;
+    entry->vnet_hdr_len =3D vnet_hdr_len;
+    if (zero_copy) {
+        entry->buf =3D buf;
+    } else {
+        entry->buf =3D g_malloc(size);
+        memcpy(entry->buf, buf, size);
+    }
+    g_queue_push_head(&sendco->send_list, entry);
+
+    if (sendco->done) {
+        sendco->co =3D qemu_coroutine_create(_compare_chr_send, sendco);
+        sendco->done =3D false;
+        qemu_coroutine_enter(sendco->co);
+        if (sendco->done) {
+            /* report early errors */
+            return sendco->ret;
+        }
+    }
=20
-err:
-    return ret < 0 ? ret : -EIO;
+    /* assume success */
+    return 0;
 }
=20
 static int compare_chr_can_read(void *opaque)
@@ -1063,6 +1137,7 @@ static void compare_pri_rs_finalize(SocketReadState *=
pri_rs)
                          pri_rs->buf,
                          pri_rs->packet_len,
                          pri_rs->vnet_hdr_len,
+                         false,
                          false);
     } else {
         /* compare packet in the specified connection */
@@ -1093,7 +1168,7 @@ static void compare_notify_rs_finalize(SocketReadStat=
e *notify_rs)
     if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
                            notify_rs->buf,
                            notify_rs->packet_len)) {
-        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true, =
false);
         if (ret < 0) {
             error_report("Notify Xen COLO-frame INIT failed");
         }
@@ -1199,6 +1274,20 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
=20
     QTAILQ_INSERT_TAIL(&net_compares, s, next);
=20
+    s->out_sendco.s =3D s;
+    s->out_sendco.chr =3D &s->chr_out;
+    s->out_sendco.notify_remote_frame =3D false;
+    s->out_sendco.done =3D true;
+    g_queue_init(&s->out_sendco.send_list);
+
+    if (s->notify_dev) {
+        s->notify_sendco.s =3D s;
+        s->notify_sendco.chr =3D &s->chr_notify_dev;
+        s->notify_sendco.notify_remote_frame =3D true;
+        s->notify_sendco.done =3D true;
+        g_queue_init(&s->notify_sendco.send_list);
+    }
+
     g_queue_init(&s->conn_list);
=20
     qemu_mutex_init(&event_mtx);
@@ -1225,8 +1314,9 @@ static void colo_flush_packets(void *opaque, void *us=
er_data)
                          pkt->data,
                          pkt->size,
                          pkt->vnet_hdr_len,
-                         false);
-        packet_destroy(pkt, NULL);
+                         false,
+                         true);
+        packet_destroy_partial(pkt, NULL);
     }
     while (!g_queue_is_empty(&conn->secondary_list)) {
         pkt =3D g_queue_pop_head(&conn->secondary_list);
@@ -1301,10 +1391,23 @@ static void colo_compare_finalize(Object *obj)
         }
     }
=20
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
+    aio_context_acquire(ctx);
+    AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
+    if (s->notify_dev) {
+        AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
+    }
+    aio_context_release(ctx);
+
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+    AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
=20
     g_queue_clear(&s->conn_list);
+    g_queue_clear(&s->out_sendco.send_list);
+    if (s->notify_dev) {
+        g_queue_clear(&s->notify_sendco.send_list);
+    }
=20
     if (s->connection_track_table) {
         g_hash_table_destroy(s->connection_track_table);
diff --git a/net/colo.c b/net/colo.c
index 8196b35837..a6c66d829a 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -185,6 +185,13 @@ void packet_destroy(void *opaque, void *user_data)
     g_slice_free(Packet, pkt);
 }
=20
+void packet_destroy_partial(void *opaque, void *user_data)
+{
+    Packet *pkt =3D opaque;
+
+    g_slice_free(Packet, pkt);
+}
+
 /*
  * Clear hashtable, stop this hash growing really huge
  */
diff --git a/net/colo.h b/net/colo.h
index 679314b1ca..573ab91785 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -102,5 +102,6 @@ bool connection_has_tracked(GHashTable *connection_trac=
k_table,
 void connection_hashtable_reset(GHashTable *connection_track_table);
 Packet *packet_new(const void *data, int size, int vnet_hdr_len);
 void packet_destroy(void *opaque, void *user_data);
+void packet_destroy_partial(void *opaque, void *user_data);
=20
 #endif /* NET_COLO_H */
--=20
2.20.1


--Sig_/jf1UHXSeiwMszPkhIHOqgs.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+ePIACgkQNasLKJxd
sliT2xAAnX1xAe5eZr/f6plDkNd7VKmrnIx1pGekjzBbfBVN8d0hlUrK+WVARoIF
Gd0fzdho33TNuIpM4B7mnX6eIDUcb3fP2HexJLhKr6X8x4kl5aKxv3vYwvil7lAg
rxtlH38AKy3xCiXEXJN618YWLzDVyPvEfF7/tEWxEDebPdLihroLisgxHGkRDmUb
R8YWB0u8Mw40s6FtUUIYDek1dBNU4bkDJ+1+jPsa5+eeUJebaSbBaad4kZwF9YW4
xgJarf8Xh75wrKat/aWSEMgMzb7LxaJWtmPSkIISzZImsvWPpmpUJMvmHst7d8rW
hhICc8P+tPQCglQL+HzwLean5uCPXa5GnMCRlpQ2wGmLiVH5oLPMJly8CXdKu00G
IC6zdLKtrWU40sggG0Is9zRS41IGeNAkInjeS4y+X2rx9fSScGqklNMRTilR6uJr
JBIawvc9kcVF36nrpFtuooLMdZIIdQQZGQfyBM4e4Lf3OUWEgrIvcP3iEGhzg1DR
Tsyh6tMs+wcNC6bUluPB4FzhnOXAkEgD4tm07TsymaVeNsXkrpwYCMoKwMBynybs
2M3NAX45ZgbVapVHcZrIhYNMI0RSiaQDIcnKJHxtQbLmmWPbBj93s+MmxybvvmFu
iEN0GAeEZ5cMEIMd9X+Gaqczm7shEnsQUfH4P0B3U8t8tnLRxOU=
=rnSv
-----END PGP SIGNATURE-----

--Sig_/jf1UHXSeiwMszPkhIHOqgs.--

