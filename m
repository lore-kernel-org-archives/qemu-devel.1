Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7213EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287552063A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Z9Mq3FQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287552063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYUa-0004Hm-3p
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKm-0007Bl-B5
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:24 -0400
Received: from mout.web.de ([212.227.15.14]:46311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKl-0002Tc-1W
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588588091;
 bh=pvyqBBN+1r1iORC5mN/kTIaJW3AwgkWvkbILOHJnPqU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Z9Mq3FQGIf/gbRsNtd/UVErlZQZsczZC5HN1e5srn9YUuu3dLRF8usvIvMj+U9bWd
 6CoepUNdldds1jpoYU/J/6OU87g4xbvJFRK1X2ghc8kq2Hc/IQrvZyY6N+qIP1Ra2R
 PdWNvJ0UIO5HYtnY9sbtAeuOPMJMMs9ZwrtdMoSE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.27]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtTDo-1j3oIZ22Wi-010x6E; Mon, 04
 May 2020 12:28:11 +0200
Date: Mon, 4 May 2020 12:28:10 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in compare_chr_send
Message-ID: <5536749ec95380f18c01789c472324565c060bcc.1588587700.git.lukasstraub2@web.de>
In-Reply-To: <cover.1588587700.git.lukasstraub2@web.de>
References: <cover.1588587700.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.j_gjlSPYMc8g_kvVZYLVCY";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:NlXKKDz8hngzwKRJNkEUlNM/NZFX7BE3kiNmaQYTlJ4bbgj2e+P
 enuR0v6W5Qjos9HVyFit0kFDWdiDLzVzmCgw5kjvRjBj7w77C+R87E0Q7Tjet8CQuGtJpX6
 2mCqz2ACnETt4sgOe2o5Re5wb3gDF2+ccIcN4Cao3mvhKbPZokWjSuVSvZ2dbn33yqdDxh3
 CIXdoFmBL+jw6tdW3UzBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:07NyK+BJOKY=:SK5VV60Il9Nqs5IIEVKkbI
 9HZfC23pfQ1xyGki2bR8TaeqSk2DZ7RGMluarkjRuJUgh/oZnqdbKgCl2hwXaLs++2qsKvOG+
 hDbR5t1+xp9qHFRmlssNIPyp014ReQKFtwlZMk0P/DPgruOWwwuQqbu2FBcJR15+4PPmvLBTp
 yQ2KLBJY7Y2fqRIEJRtAP2zVJD6SdELCsZT67GNhHFSS+TbQg8ULOVReABTyb4PLbiJPaV81K
 TAJnZCgOWleGcq5+mJCZBBnq2xIELls273l3HhlpP4IiKXq73kc8wVusBAmnYJeesiUqkayIo
 EQlIG5PWM0+RBVhPoWX16Hn8u/6JQHXbUsvHJd5YHqBLE90waZc55kTVHjB3ZgmoCF9hkrwGp
 Ij8sEPuP2Jl3QcuxyKFdEP7+kKOJylhdRLsYnuqn0DBAQhZ+60T7Ur/9f1RSySrpz5ExKXUx+
 Adnx6kjvUAbQUI5NJhDJCF9f1v52rVnt5UM852aCpJvHsLAUEtmLmu7jZs4bQdwCuBQCY4mhW
 o9UMRExRTa8dJARviUSGEwnphwKDfaWCasnifnsu3u0fBx9tnJkQwLGmzduMsRMvgHHPmGEmW
 9VDMtvnO/+Qb8Nh1wINOF4Uo2wIlP7CYUQtbaMwMCrKXj7EAudJa7J2u+1dpXeVaVgEgY6QX+
 YoRsCPb1IWsY018noythT28c48dYeTchxYqSCm56t9u1pCi+FLE/AhPS3jw3psF29JqiL8hZE
 /kggTlHa3y6A5AXUIMHJM2eFNEz5s/FaiILqytS5VWUb50xJrxy6KxMYlsoXxc1VfKCzVw8ul
 CmR9wthSwMhq+UEKTCL9Y4bTFcQFimxtFz4rWks3tpHaLcPrPgv0VqHZG5AjrnYyQtySUoQ4c
 SAnSWxD0UJLMXapxkdMbOYPDltyuD5JUrqbnc6YiuTm+i+Sox6WN8LcPVkfyLy6TqEXeNzsz4
 Fz8fDXN0L8FCpyiY/X2Z9s2N7uUTqq06noqSOziCnjxCQfJyjWZeCEFphTSKnPO5sA1lMuuyH
 DUJGYIIG8Q2ldbK/f8fJzBNIW5ltRGnGjh2Z2tEojJkuW99PkKRsKhbZDad6XGJe2Qvk7Jv5U
 NRpggpuQOi6CY/x3L3f6jdXk4nfKpsWFmwZ1RjJa6y5bPQdgU7eOlBFosGGCfB0727Ve80YIQ
 E3XBNNhjCdZaYdxNew48OSq+Wf/gUlsANRzxy6lPMy8RPfJqO4NOodyam4BNZ5Bosh6/JHJuC
 GLaLzw/p/s/MVlLFp
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:28:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/.j_gjlSPYMc8g_kvVZYLVCY
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
---
 net/colo-compare.c | 187 ++++++++++++++++++++++++++++++++++-----------
 net/colo.c         |   7 ++
 net/colo.h         |   1 +
 3 files changed, 150 insertions(+), 45 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 1de4220fe2..2a4e7f7c4e 100644
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
@@ -1199,6 +1274,18 @@ static void colo_compare_complete(UserCreatable *uc,=
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
+    s->notify_sendco.s =3D s;
+    s->notify_sendco.chr =3D &s->chr_notify_dev;
+    s->notify_sendco.notify_remote_frame =3D true;
+    s->notify_sendco.done =3D true;
+    g_queue_init(&s->notify_sendco.send_list);
+
     g_queue_init(&s->conn_list);
=20
     qemu_mutex_init(&event_mtx);
@@ -1225,8 +1312,9 @@ static void colo_flush_packets(void *opaque, void *us=
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
@@ -1301,10 +1389,19 @@ static void colo_compare_finalize(Object *obj)
         }
     }
=20
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
+    aio_context_acquire(ctx);
+    AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
+    AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
+    aio_context_release(ctx);
+
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+    AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
=20
     g_queue_clear(&s->conn_list);
+    g_queue_clear(&s->out_sendco.send_list);
+    g_queue_clear(&s->notify_sendco.send_list);
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


--Sig_/.j_gjlSPYMc8g_kvVZYLVCY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6v7joACgkQNasLKJxd
slj1cRAAnZNyEYtDGa3k+hOirICBChnbqZmqRl4qH8Xle4KeGSPjcmqO26489fyb
vs54noE3b3y42JANh7wNJRW+yL6iF6FBdhsVObKRbeiPiF8nmOxbRL1Mt/9u9lOQ
ZZMEMedfsrGMv3QItImFZIj0mbBHsKz8WPU//ps7QS309xvpWslrJcq1A9ZiQm4o
Mzkm9MG2mZeoFDXviuG0ZnhDkv/UyRQ8s6qqNh/bJbRJYRdFFrRm7t5WJ/gyOhTb
XB86UHC5dyvLm/GiG0B0NZppbrLB7Ms8Qwd6zH4o5bRchCTB5DYMi5+CD1ze0Vbg
JuaTW6xJJqmwl5wxwGdM3MiMnbD2iQshM0K+SJTzCXwqHhufg2S1lMwrv2BUIw6E
MXXeLQylFUYE6nL1N5rUD56BzeMjVpIIYGQv0iELp3y3xwfeNcaW/VRIiXw5VA0l
/3v2iqF+qWjV+e7Q2jiACO3bikmNlaiTemDPH5reincFb6Gs43M81p6dVNZ1RMa5
OBfOa1UgZjTjiib5k3QwZM4dHoav5Saurlm/6ppE/zZSJ3bzTlXGwwXcHHmzAUNE
undLbyJem+1mo3YuAUAul6gPXD6C3LZ5YAqMF61Wryc3bSKNNs6fOJqfGJ3h20G0
YRpJwV2HdZTCONFfQVbRYOgkhLdhygTPV9kNprWGRtJfgXpSFKE=
=ep3S
-----END PGP SIGNATURE-----

--Sig_/.j_gjlSPYMc8g_kvVZYLVCY--

