Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AF8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2282065C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="MftmjxVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2282065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1gX-0004He-KA
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 03:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TN-0007UW-GV
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:48:01 -0400
Received: from mout.web.de ([212.227.17.12]:37177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TL-00016I-GL
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590130060;
 bh=A0nODjFo6KWPTkquLJJac83giA5N9yaIoEj+gjJApoo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=MftmjxVImSczz8h74HC/VoWjQAzxl2dIg1L66ta2rjjU3QVvfG+uiEeeREHZw6CvB
 +JyKevS2q8uFuAxjfnh8/KVVlspifFFUG7z+R4eqdMBWMSUm4XiZoJatKee3eRqB29
 QCGcUOzartfZkW1yXAW5MzzhwDAERN/aThtBQBHU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.67]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBDG-1jPIJ81EPW-00PtjY; Fri, 22
 May 2020 08:47:40 +0200
Date: Fri, 22 May 2020 08:47:38 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 3/6] net/colo-compare.c: Fix deadlock in compare_chr_send
Message-ID: <bb0ea691445193d44228ff0732d533264ba047d0.1590129793.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590129793.git.lukasstraub2@web.de>
References: <cover.1590129793.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2CfJDgicf8fCwhXILbT2bM/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:43PcfcYO3Hpqzkfu3gu8XeKuXm6lu1WuIGums3nXmKW6sgiLcgh
 jEeNszt1QwBgZ5xokS78Ju+fsnwpCICYvJRJdt5UOiUkTNHk6WryZiZaEokcrDuZXo3lkUl
 BIjnlybr1bhf1hdg+0vw50QiDDbClNx1b+OXGdcck0edZMTLbxddnOphFgzygs6Rd10pe5r
 eSId1EY31RUZBgb8sPFrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jc3DtTlEx3Y=:yhVn3HU4zRL/m6GnuV86/S
 PMtPuiSTwVs8ORFFXUeBAUIy4M3qI6Iu9Oj7N1g0jS97eTXh/iCbovKhE3IFBeG7Nz5DkdjBr
 lOUHZqMY1RRE0cRuvObYlqVa9pGQqWMHXVVo7m9tuSoXZ6Omfta0rn5I3fXx0vEaXRHcqaEv6
 AmKwrwX/xreIN7Q1WDUU5YGiPCS4tZrgL82Am6gKwT2SkNo28XZQ4hMXzSbbVq0bcTz+agOab
 yEu07NN2nsrEqsNerLkxCSl0zVtxvPwXMl7V/AkKO8yGWuvlS1ngy/oSo0As1SqQTfVDWhOg8
 PtWn7ISdlycxTkrGz+/DsTlphfRvOUd0ifT3mtAz3DDBcDI+9lbw5cRZUgRIk+U2f2JXDT9Ly
 W7T2HfSe4bkBEkmllN8EqguiUIvrlQaIPRRkRXCJ+EvmL2HscLVLDPrip3CcR7lSqLrmA76wA
 mnV1rz1KagoLjM33wmlpP/E3Tv2S0EexOEDCBqf7D2EYYGJjXqAqZg9XV4PHlSIXZz+Rx3WPN
 /fWyYnH/jYE1l1lj+pQoO2AaMWqj2UQ8rgGBH0GxF2xMX9esr+zHk+ICFgBTHhAHfGWsINfCn
 uPDwNigPXymyFAIHYB1W2Y1tc3rhL77Vxp1AjNSJtJxsYeRc7RPZrnMkUBoR85aobte3sdeMb
 R5tWl4U6PTQWX0WmeEbewJRnSq/bcZw2kRm78hqWObyDcLoQGs5/Gxxv8vbFFoChA3P9LXaQd
 wjpp0lfLvPhReAYLuD7yZYeSVk1QCDATRu+tW3csPHhAn6S8pLhcECiwXpITapsWmCW1cEXWM
 kRsjPYGO6u9MI3oV/ddgDZ7m+qhbRWSxTSHvUqRRaQCXbE8AHYZc7ij7kgWn5t5vUZBiqL2KF
 dZYtFd1KtjvY5OBa9IihDbmapxGVhY1/2AqnQAC52jzgRUxncFSe1T0TRnIpq3dkQKgX9CGgZ
 L3RPzqW51NC7hdY2rGYshSjF8X69qC5DlbBEKUdTJFg6HDg8u90rwlXP3XSPjHW9ajHBsFLxF
 V3gEWWh/VTVqcL7iwpmqRVBugPaFPAg3R5ZCeyunlmC7YPrNOD7Q5zefdF8O4F6RKSDNy9M6e
 VZllrytNDv18FbyUytb55ojwqB3RI3iW6SaQCpxGQOpM7EtiVna7WjmPh2Csd3jcvcu3r4pNv
 58GtkSqcg2Nd+EsJIt9spKU8vWVhyzBOxIRxuquz3qvnqtyFdSJNMOda0niO7vtvNQB7wci0R
 FwwZYj2iZAn/ihEyv
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:47:49
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
 Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/2CfJDgicf8fCwhXILbT2bM/
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


 static int compare_chr_send(CompareState *s,
-                            const uint8_t *buf,
+                            uint8_t *buf,
                             uint32_t size,
                             uint32_t vnet_hdr_len,
-                            bool notify_remote_frame);
+                            bool notify_remote_frame,
+                            bool zero_copy);

 static bool packet_matches_str(const char *str,
                                const uint8_t *buf,
@@ -145,7 +168,7 @@ static void notify_remote_frame(CompareState *s)
     char msg[] =3D "DO_CHECKPOINT";
     int ret =3D 0;

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

 /*
@@ -699,65 +723,115 @@ static void colo_compare_connection(void *opaque, vo=
id *user_data)
     }
 }

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

-    if (!size) {
-        return 0;
-    }
+    while (!g_queue_is_empty(&sendco->send_list)) {
+        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
+        uint32_t len =3D htonl(entry->size);

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

-    if (ret !=3D sizeof(len)) {
-        goto err;
-    }
+        if (ret !=3D sizeof(len)) {
+            g_free(entry->buf);
+            g_slice_free(SendEntry, entry);
+            goto err;
+        }

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

-    if (ret !=3D size) {
-        goto err;
+    if (!size) {
+        return 0;
     }

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

-err:
-    return ret < 0 ? ret : -EIO;
+    /* assume success */
+    return 0;
 }

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

     QTAILQ_INSERT_TAIL(&net_compares, s, next);

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

     g_queue_clear(&s->conn_list);
+    g_queue_clear(&s->out_sendco.send_list);
+    if (s->notify_dev) {
+        g_queue_clear(&s->notify_sendco.send_list);
+    }

     if (s->connection_track_table) {
         g_hash_table_destroy(s->connection_track_table);
diff --git a/net/colo.c b/net/colo.c
index 8196b35837..a6c66d829a 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -185,6 +185,13 @@ void packet_destroy(void *opaque, void *user_data)
     g_slice_free(Packet, pkt);
 }

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

 #endif /* NET_COLO_H */
--
2.20.1


--Sig_/2CfJDgicf8fCwhXILbT2bM/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7HdYoACgkQNasLKJxd
sljsTg/3WyKdl0Bi4CE0MTpIIT3NSX9+AbVtknXo5wkavHQMeiwEBwszkP5S/7Cu
AuP0HKGU17TYCQuaejaedo1Sq+icEEUEw68S1yftDyXXBkiyFHvjyuL0u538ULMS
YKlTOh3XOaQcNsR57hwLNGv7Joytov47LsGhHrgqn8U2WRS9EIbgFqkcguutf+FH
IGsywiO6zs4uppWiUAlYKu320/Iyz4TqrG4KrMzxIMdJYK9hxEwCJNIvAJmuFPS6
e7NUhXiWWMJ4hGvR+dHtN8VjQ/NIeSMCjtxQqTF/ZjZ/B1PGFsxa+oEKe24Y5kXs
KZZONs75uaxMQdJ5BOs3ptif6wFtlSZWgiKfZYV4RcocG4Tgq8Iq+HzPwpiuGvDv
xiI21C+MMjlM+4MfUAdFS4A75xjRXDwGc9S2GATZdS48Nch2cEYiE4ZfuxEebkkH
L+1Fcibbxuyx5q7iKrVlxCQkDnxhq8AZ6DVFZSwMZf0AI42ioRzWrsqUutLr5BiQ
qrmaZMPV9Of9Blbr2XlPWgswNuI587EyS1wvRadaMTJFRtdhKp2OEqCFs+iTZ6GI
Q3RsD43z9BMd4K6m7y2B7C8O9G8TgR5AaO7dpNj/5SOtfhzo+LHu5DuXXM3+W/pl
vHdYAScj/W4wvtz8Apb+3egkU4SBGDfF0m1U4Msa2XhBFJDGZQ==
=kFyr
-----END PGP SIGNATURE-----

--Sig_/2CfJDgicf8fCwhXILbT2bM/--

