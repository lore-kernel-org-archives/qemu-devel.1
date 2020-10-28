Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F7C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09E224810
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LTeOHYvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09E224810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqV6-0002Hg-Ek
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqRs-0008TG-LV; Wed, 28 Oct 2020 14:45:28 -0400
Received: from mout.web.de ([217.72.192.78]:48141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqRq-0003GL-3N; Wed, 28 Oct 2020 14:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603910721;
 bh=wqDIHQ1tkVo7xVG/ViJwH0XSYWCPngSBGedj/9BT3W4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=LTeOHYvtpYGR4Fmkdbq1RebLgr9ZB1sOP2j690SJJjRjDZFkDZoS2ieGbfupXWLl6
 z4V+7wzXKjN0zgCIqZ64DnQZmPp9CmgyLekwzJAfnXpPVZ0MUhOJ2sokU17UeA/+Po
 MXkjeAMWP/Fau06UQ/zoKWYkxfUl3siT1914vr/A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.124]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHGed-1kcTIJ3695-00E3JC; Wed, 28
 Oct 2020 19:45:20 +0100
Date: Wed, 28 Oct 2020 19:45:19 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v9 2/8] block/nbd.c: Add yank feature
Message-ID: <d10f750c1a36aaeeec40a8f0073dd3a979842ab4.1603909658.git.lukasstraub2@web.de>
In-Reply-To: <cover.1603909658.git.lukasstraub2@web.de>
References: <cover.1603909658.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D6xxW8+EUuAB2H58wKDBDbT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:elvFPfceyypMYote1X9alYJtA9Ek1qY4n+7N/pxZsyKNUNZ9QBg
 dlhUokrdemC8SXrrwxnv7yQCqbSFtYD7iD0LdS3ZWhpvcXIIToY+TWS04MLI6jDcebE8FTL
 Si+/+u6uL4i5IFIzKTbMgI0Cmr8A4mOZel06IE20RDGMbqDzsX2BfGRk+YIA/4/jl6UDO0z
 b/GvN1ov0w0aJIvT0Xd9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:is/dUFRW3vs=:jv1N9n2rjF5hqU6HKyO/oT
 d3S5QCWBHwEfTPrMxNwLWddqAVt7n3ghwrTZe6z+FXFSxLuLSsz9jyVQzpPXv4eG43GQS0ZsI
 7xgbeSzszI7bBiwcBoiF3biv6HyUSH0yy3KS0O3JBE4VXLuLjEBuCkrnMSXJP3RkOBmbKjrEf
 j3mBrAPI4EDdiOtEfUYVgjK8f0c7G2Fp1UtXxPl9qCE4uAbLyeWQ9TzcZsm+Jnt0c4HjSvB5E
 uTZpEtQ+weN0gkRu/MaBXm9C2dyxxTApVtIp+w+nzzBBY4ECCxRJ/H91bUhTX96J1/I13ZWFQ
 g1NVcosbsOgwHhDiJi1P/xtP/7fvdohS0kdf+4dzWSfW0sxwi0TcZiLiM6fZ/nthjym3T/uis
 vq38AAFJJQrCOvGVe+8zrpYGKRcS64AVEJrLE6uo8R17QQRPCoCzBqZskNVxtqBp9C/ecNeMw
 L+CZh4fAqYBZc04Xy+jCkdFY8eT3EYdE6nPHgooUWE6npmTRx4QLvK7TK33N/+Wq+vAk7eGDO
 KG8IMigPq5hp8LOSaYVhsOvjkMPgRuTGjoVzJx4AKzzQqdNOmawb+QuyGvA13WphRLZuzWLsb
 1uVNA5BYRCJ/lW2zqV6hKPHNhEpvtGUpdRGpFVHDkLtay55mt1brn/n3KgGeIHweXJmv4I7uJ
 MshhMOtPvQK4T3i1i6Zid/ChHb+FtnFfBYYQdDBifA7AkqgY2uH2jPumYQkLBIUP4we9RFX+D
 e9nY/JSFoWm/zDaZySbYlVDSftBDRulRlvB5T0KNguWmdP+EgRKqKD2x+3SAe30x/dpeJiBNq
 XQIVS8SQmf529WO+ONER7Fvb4lpwdQV21ZSZghuAyHjou+l4QOB6LlwTL7NxbNJBg5qvlnasY
 pAFPlzKa01gW6Z9Vm71g==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 13:12:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/D6xxW8+EUuAB2H58wKDBDbT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register a yank function which shuts down the socket and sets
s->state =3D NBD_CLIENT_QUIT. This is the same behaviour as if an
error occured.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nbd.c | 154 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 61 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 4548046cd7..d66c84ee40 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -35,6 +35,7 @@
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
+#include "qemu/atomic.h"

 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qmp/qstring.h"
@@ -44,6 +45,8 @@
 #include "block/nbd.h"
 #include "block/block_int.h"

+#include "qemu/yank.h"
+
 #define EN_OPTSTR ":exportname=3D"
 #define MAX_NBD_REQUESTS    16

@@ -140,14 +143,13 @@ typedef struct BDRVNBDState {
     NBDConnectThread *connect_thread;
 } BDRVNBDState;

-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
-                                                  Error **errp);
-static QIOChannelSocket *nbd_co_establish_connection(BlockDriverState *bs,
-                                                     Error **errp);
+static int nbd_establish_connection(BlockDriverState *bs, SocketAddress *s=
addr,
+                                    Error **errp);
+static int nbd_co_establish_connection(BlockDriverState *bs, Error **errp);
 static void nbd_co_establish_connection_cancel(BlockDriverState *bs,
                                                bool detach);
-static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *si=
oc,
-                                Error **errp);
+static int nbd_client_handshake(BlockDriverState *bs, Error **errp);
+static void nbd_yank(void *opaque);

 static void nbd_clear_bdrvstate(BDRVNBDState *s)
 {
@@ -165,12 +167,12 @@ static void nbd_clear_bdrvstate(BDRVNBDState *s)
 static void nbd_channel_error(BDRVNBDState *s, int ret)
 {
     if (ret =3D=3D -EIO) {
-        if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (qatomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
             s->state =3D s->reconnect_delay ? NBD_CLIENT_CONNECTING_WAIT :
                                             NBD_CLIENT_CONNECTING_NOWAIT;
         }
     } else {
-        if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (qatomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
             qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
         s->state =3D NBD_CLIENT_QUIT;
@@ -203,7 +205,7 @@ static void reconnect_delay_timer_cb(void *opaque)
 {
     BDRVNBDState *s =3D opaque;

-    if (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT) {
+    if (qatomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WAIT)=
 {
         s->state =3D NBD_CLIENT_CONNECTING_NOWAIT;
         while (qemu_co_enter_next(&s->free_sema, NULL)) {
             /* Resume all queued requests */
@@ -215,7 +217,7 @@ static void reconnect_delay_timer_cb(void *opaque)

 static void reconnect_delay_timer_init(BDRVNBDState *s, uint64_t expire_ti=
me_ns)
 {
-    if (s->state !=3D NBD_CLIENT_CONNECTING_WAIT) {
+    if (qatomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTING_WAIT) {
         return;
     }

@@ -260,7 +262,7 @@ static void nbd_client_attach_aio_context(BlockDriverSt=
ate *bs,
      * s->connection_co is either yielded from nbd_receive_reply or from
      * nbd_co_reconnect_loop()
      */
-    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+    if (qatomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
         qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
     }

@@ -286,7 +288,7 @@ static void coroutine_fn nbd_client_co_drain_begin(Bloc=
kDriverState *bs)

     reconnect_delay_timer_del(s);

-    if (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT) {
+    if (qatomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WAIT)=
 {
         s->state =3D NBD_CLIENT_CONNECTING_NOWAIT;
         qemu_co_queue_restart_all(&s->free_sema);
     }
@@ -337,13 +339,14 @@ static void nbd_teardown_connection(BlockDriverState =
*bs)

 static bool nbd_client_connecting(BDRVNBDState *s)
 {
-    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
-        s->state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
+    NBDClientState state =3D qatomic_load_acquire(&s->state);
+    return state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
+        state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
 }

 static bool nbd_client_connecting_wait(BDRVNBDState *s)
 {
-    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT;
+    return qatomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WA=
IT;
 }

 static void connect_bh(void *opaque)
@@ -423,12 +426,12 @@ static void *connect_thread_func(void *opaque)
     return NULL;
 }

-static QIOChannelSocket *coroutine_fn
+static int coroutine_fn
 nbd_co_establish_connection(BlockDriverState *bs, Error **errp)
 {
+    int ret;
     QemuThread thread;
     BDRVNBDState *s =3D bs->opaque;
-    QIOChannelSocket *res;
     NBDConnectThread *thr =3D s->connect_thread;

     qemu_mutex_lock(&thr->mutex);
@@ -445,10 +448,12 @@ nbd_co_establish_connection(BlockDriverState *bs, Err=
or **errp)
     case CONNECT_THREAD_SUCCESS:
         /* Previous attempt finally succeeded in background */
         thr->state =3D CONNECT_THREAD_NONE;
-        res =3D thr->sioc;
+        s->sioc =3D thr->sioc;
         thr->sioc =3D NULL;
+        yank_register_function(BLOCKDEV_YANK_INSTANCE(bs->node_name),
+                               nbd_yank, bs);
         qemu_mutex_unlock(&thr->mutex);
-        return res;
+        return 0;
     case CONNECT_THREAD_RUNNING:
         /* Already running, will wait */
         break;
@@ -480,8 +485,13 @@ nbd_co_establish_connection(BlockDriverState *bs, Erro=
r **errp)
         thr->state =3D CONNECT_THREAD_NONE;
         error_propagate(errp, thr->err);
         thr->err =3D NULL;
-        res =3D thr->sioc;
+        s->sioc =3D thr->sioc;
         thr->sioc =3D NULL;
+        if (s->sioc) {
+            yank_register_function(BLOCKDEV_YANK_INSTANCE(bs->node_name),
+                                   nbd_yank, bs);
+        }
+        ret =3D (s->sioc ? 0 : -1);
         break;
     case CONNECT_THREAD_RUNNING:
     case CONNECT_THREAD_RUNNING_DETACHED:
@@ -490,7 +500,7 @@ nbd_co_establish_connection(BlockDriverState *bs, Error=
 **errp)
          * failed. Still connect thread is executing in background, and its
          * result may be used for next connection attempt.
          */
-        res =3D NULL;
+        ret =3D -1;
         error_setg(errp, "Connection attempt cancelled by other operation"=
);
         break;

@@ -507,7 +517,7 @@ nbd_co_establish_connection(BlockDriverState *bs, Error=
 **errp)

     qemu_mutex_unlock(&thr->mutex);

-    return res;
+    return ret;
 }

 /*
@@ -560,7 +570,6 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDS=
tate *s)
 {
     int ret;
     Error *local_err =3D NULL;
-    QIOChannelSocket *sioc;

     if (!nbd_client_connecting(s)) {
         return;
@@ -593,21 +602,22 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNB=
DState *s)
     /* Finalize previous connection if any */
     if (s->ioc) {
         qio_channel_detach_aio_context(QIO_CHANNEL(s->ioc));
+        yank_unregister_function(BLOCKDEV_YANK_INSTANCE(s->bs->node_name),
+                                 nbd_yank, s->bs);
         object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;
         object_unref(OBJECT(s->ioc));
         s->ioc =3D NULL;
     }

-    sioc =3D nbd_co_establish_connection(s->bs, &local_err);
-    if (!sioc) {
+    if (nbd_co_establish_connection(s->bs, &local_err) < 0) {
         ret =3D -ECONNREFUSED;
         goto out;
     }

     bdrv_dec_in_flight(s->bs);

-    ret =3D nbd_client_handshake(s->bs, sioc, &local_err);
+    ret =3D nbd_client_handshake(s->bs, &local_err);

     if (s->drained) {
         s->wait_drained_end =3D true;
@@ -639,7 +649,7 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDS=
tate *s)
     uint64_t timeout =3D 1 * NANOSECONDS_PER_SECOND;
     uint64_t max_timeout =3D 16 * NANOSECONDS_PER_SECOND;

-    if (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT) {
+    if (qatomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WAIT)=
 {
         reconnect_delay_timer_init(s, qemu_clock_get_ns(QEMU_CLOCK_REALTIM=
E) +
                                    s->reconnect_delay * NANOSECONDS_PER_SE=
COND);
     }
@@ -682,7 +692,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
     int ret =3D 0;
     Error *local_err =3D NULL;

-    while (s->state !=3D NBD_CLIENT_QUIT) {
+    while (qatomic_load_acquire(&s->state) !=3D NBD_CLIENT_QUIT) {
         /*
          * The NBD client can only really be considered idle when it has
          * yielded from qio_channel_readv_all_eof(), waiting for data. Thi=
s is
@@ -697,7 +707,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
             nbd_co_reconnect_loop(s);
         }

-        if (s->state !=3D NBD_CLIENT_CONNECTED) {
+        if (qatomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
             continue;
         }

@@ -752,6 +762,8 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
     s->connection_co =3D NULL;
     if (s->ioc) {
         qio_channel_detach_aio_context(QIO_CHANNEL(s->ioc));
+        yank_unregister_function(BLOCKDEV_YANK_INSTANCE(s->bs->node_name),
+                                 nbd_yank, s->bs);
         object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;
         object_unref(OBJECT(s->ioc));
@@ -776,7 +788,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }

-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (qatomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         rc =3D -EIO;
         goto err;
     }
@@ -803,7 +815,8 @@ static int nbd_co_send_request(BlockDriverState *bs,
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc =3D nbd_send_request(s->ioc, request);
-        if (rc >=3D 0 && s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (qatomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTED &&
+            rc >=3D 0) {
             if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
                                        NULL) < 0) {
                 rc =3D -EIO;
@@ -1118,7 +1131,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving =3D true;
     qemu_coroutine_yield();
     s->requests[i].receiving =3D false;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (qatomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -1277,7 +1290,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState=
 *s,
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err =3D NULL;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (qatomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         error_setg(&local_err, "Connection closed");
         nbd_iter_channel_error(iter, -EIO, &local_err);
         goto break_loop;
@@ -1302,7 +1315,8 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState=
 *s,
     }

     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply=
. */
-    if (nbd_reply_is_simple(reply) || s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (nbd_reply_is_simple(reply) ||
+        qatomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         goto break_loop;
     }

@@ -1734,6 +1748,15 @@ static int nbd_client_reopen_prepare(BDRVReopenState=
 *state,
     return 0;
 }

+static void nbd_yank(void *opaque)
+{
+    BlockDriverState *bs =3D opaque;
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+
+    qatomic_store_release(&s->state, NBD_CLIENT_QUIT);
+    qio_channel_shutdown(QIO_CHANNEL(s->sioc), QIO_CHANNEL_SHUTDOWN_BOTH, =
NULL);
+}
+
 static void nbd_client_close(BlockDriverState *bs)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
@@ -1746,52 +1769,53 @@ static void nbd_client_close(BlockDriverState *bs)
     nbd_teardown_connection(bs);
 }

-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
-                                                  Error **errp)
+static int nbd_establish_connection(BlockDriverState *bs,
+                                    SocketAddress *saddr,
+                                    Error **errp)
 {
     ERRP_GUARD();
-    QIOChannelSocket *sioc;
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

-    sioc =3D qio_channel_socket_new();
-    qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
+    s->sioc =3D qio_channel_socket_new();
+    qio_channel_set_name(QIO_CHANNEL(s->sioc), "nbd-client");

-    qio_channel_socket_connect_sync(sioc, saddr, errp);
+    qio_channel_socket_connect_sync(s->sioc, saddr, errp);
     if (*errp) {
-        object_unref(OBJECT(sioc));
-        return NULL;
+        object_unref(OBJECT(s->sioc));
+        s->sioc =3D NULL;
+        return -1;
     }

-    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
+    yank_register_function(BLOCKDEV_YANK_INSTANCE(bs->node_name), nbd_yank=
, bs);
+    qio_channel_set_delay(QIO_CHANNEL(s->sioc), false);

-    return sioc;
+    return 0;
 }

-/* nbd_client_handshake takes ownership on sioc. On failure it is unref'ed=
. */
-static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *si=
oc,
-                                Error **errp)
+/* nbd_client_handshake takes ownership on s->sioc. On failure it's unref'=
ed. */
+static int nbd_client_handshake(BlockDriverState *bs, Error **errp)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     AioContext *aio_context =3D bdrv_get_aio_context(bs);
     int ret;

     trace_nbd_client_handshake(s->export);
-
-    s->sioc =3D sioc;
-
-    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);
+    qio_channel_set_blocking(QIO_CHANNEL(s->sioc), false, NULL);
+    qio_channel_attach_aio_context(QIO_CHANNEL(s->sioc), aio_context);

     s->info.request_sizes =3D true;
     s->info.structured_reply =3D true;
     s->info.base_allocation =3D true;
     s->info.x_dirty_bitmap =3D g_strdup(s->x_dirty_bitmap);
     s->info.name =3D g_strdup(s->export ?: "");
-    ret =3D nbd_receive_negotiate(aio_context, QIO_CHANNEL(sioc), s->tlscr=
eds,
+    ret =3D nbd_receive_negotiate(aio_context, QIO_CHANNEL(s->sioc), s->tl=
screds,
                                 s->hostname, &s->ioc, &s->info, errp);
     g_free(s->info.x_dirty_bitmap);
     g_free(s->info.name);
     if (ret < 0) {
-        object_unref(OBJECT(sioc));
+        yank_unregister_function(BLOCKDEV_YANK_INSTANCE(bs->node_name),
+                                 nbd_yank, bs);
+        object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;
         return ret;
     }
@@ -1819,7 +1843,7 @@ static int nbd_client_handshake(BlockDriverState *bs,=
 QIOChannelSocket *sioc,
     }

     if (!s->ioc) {
-        s->ioc =3D QIO_CHANNEL(sioc);
+        s->ioc =3D QIO_CHANNEL(s->sioc);
         object_ref(OBJECT(s->ioc));
     }

@@ -1835,9 +1859,11 @@ static int nbd_client_handshake(BlockDriverState *bs=
, QIOChannelSocket *sioc,
     {
         NBDRequest request =3D { .type =3D NBD_CMD_DISC };

-        nbd_send_request(s->ioc ?: QIO_CHANNEL(sioc), &request);
+        nbd_send_request(s->ioc ?: QIO_CHANNEL(s->sioc), &request);

-        object_unref(OBJECT(sioc));
+        yank_unregister_function(BLOCKDEV_YANK_INSTANCE(bs->node_name),
+                                 nbd_yank, bs);
+        object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;

         return ret;
@@ -2229,7 +2255,6 @@ static int nbd_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
 {
     int ret;
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
-    QIOChannelSocket *sioc;

     ret =3D nbd_process_options(bs, options, errp);
     if (ret < 0) {
@@ -2240,17 +2265,23 @@ static int nbd_open(BlockDriverState *bs, QDict *op=
tions, int flags,
     qemu_co_mutex_init(&s->send_mutex);
     qemu_co_queue_init(&s->free_sema);

+    yank_register_instance(BLOCKDEV_YANK_INSTANCE(bs->node_name), errp);
+    if (*errp) {
+        return -EEXIST;
+    }
+
     /*
      * establish TCP connection, return error if it fails
      * TODO: Configurable retry-until-timeout behaviour.
      */
-    sioc =3D nbd_establish_connection(s->saddr, errp);
-    if (!sioc) {
+    if (nbd_establish_connection(bs, s->saddr, errp) < 0) {
+        yank_unregister_instance(BLOCKDEV_YANK_INSTANCE(bs->node_name));
         return -ECONNREFUSED;
     }

-    ret =3D nbd_client_handshake(bs, sioc, errp);
+    ret =3D nbd_client_handshake(bs, errp);
     if (ret < 0) {
+        yank_unregister_instance(BLOCKDEV_YANK_INSTANCE(bs->node_name));
         nbd_clear_bdrvstate(s);
         return ret;
     }
@@ -2310,6 +2341,7 @@ static void nbd_close(BlockDriverState *bs)
     BDRVNBDState *s =3D bs->opaque;

     nbd_client_close(bs);
+    yank_unregister_instance(BLOCKDEV_YANK_INSTANCE(bs->node_name));
     nbd_clear_bdrvstate(s);
 }

--
2.20.1


--Sig_/D6xxW8+EUuAB2H58wKDBDbT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+ZvD8ACgkQNasLKJxd
slg4SRAArrNBmnTV+4F5V4Z+FwIJnFqUYaQhYYa3RtpDCnbVYRIKw4GUUKPgW1Dy
4rVXzqgk5yYJHd8tTthWpT2977fILXmBmALYwKIGHNZy3ITDnCYgHl0NVQxtEuKR
YfCJ9R6FvvV+wjROXvYystVPi9+368HBXGWytBsNZyNfNPP5/E1kYyKy2bxNM83o
mKlTpThVBmILU0pizvB58XM7qO/XLpMprr+LgGmI+H27mYI0vqAI21HuwWVgnjHp
rDVZG1jHDnYJhGMjkiJkwRdXVrEDTINIKYrgJCbH/MY+NND1dS7mDVkpwyR52wp6
aCGMfl/69Q95w0hHwfm1hHMrmRMneL5i3QU6SQ8OyM5/sC8ieCOWNFAq/yhk/Qy9
E6eSwgiaP3AzCv81jCUEwxrU4n0yk4Yt6IjSvumUzs0crircUX6LNIjl0ClAxrLD
Q/AMOhFX2HA18nEn7JQnaAuU/LqG3HIC7KZwntbtS/YOrqA7g+SjnEOIHzYPizIW
0rJLrUZTcdzsPSq8fp5RhZBysijVG/DDuYwcuJBWczKVhgHfkcAnzgOXfNBIUiAq
rp0RXxV0IKVWeVNf8XspWWlzCSiBncIFloKap9dqPlybN4DS/YmFS0BlEnprAksd
izA+uVCtTmvoLe2viPlhN5cYf9jQ5M6zv6qqXUxrUzjytZBgB0o=
=tu+/
-----END PGP SIGNATURE-----

--Sig_/D6xxW8+EUuAB2H58wKDBDbT--

