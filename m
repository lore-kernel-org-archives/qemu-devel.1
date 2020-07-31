Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33C6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F90208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dtYzHAcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F90208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RMi-00014p-Kl
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJP-0007dQ-N5; Fri, 31 Jul 2020 05:26:47 -0400
Received: from mout.web.de ([212.227.17.11]:44495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJN-0003GW-DB; Fri, 31 Jul 2020 05:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187599;
 bh=MuCNjqd9H4ALndDqG0jP1AQMY+cLODy92P04oBv1UFk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dtYzHAcYN0AV4R+Z/BMuoq+oC7f9sVdLOSPm01UBLXFGlpcy1kdDrBWJ3eo+gIWij
 vM328TZ3A3RLEjdmv87MNRRxpxuKbVY7Niz2xTOMGepT2I2yoeqCQpHccy5qPeRcNl
 uc38kBmi2IGQsNsOuizWJsHNXo5K81YURucAvw4k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6mTI-1kxYB108iC-00wTn0; Fri, 31
 Jul 2020 11:26:39 +0200
Date: Fri, 31 Jul 2020 11:26:37 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 2/9] block/nbd.c: Add yank feature
Message-ID: <238b513ddef19cf91c8bfd379277f78e00a00f1a.1596184200.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596184200.git.lukasstraub2@web.de>
References: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z40XhgjMqFfOfh.kLsZer2n";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:k1CgawiDO0JIvBgUj19o6QQsJZK6ILIpO+fe3n/VlG7p4fWZfEz
 M9nevYPqr8idVL1Bqn39rcfaOJyDkzEsgAJdVfOVBvAxv+xmm+FIhMzu4SPtS8AJeKh7QvE
 U0g5rXdXEOWHGBFq6tY9Mg2SXE/8B5szKfAW/nACkl2m0pL8TffvTCsldSr5VE62BJVRN0S
 ItYCajJw3NQ7PIYNBvukw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KPHwng5b8tw=:PJksNSFa8Bx50LQS0SsV0A
 PyVCSGwJFbtCdCthNPqUnjvRkEfJOtMHDwQFd1wUbv9+6PPIUxtZB0kJhvuPSWkYGFJFDsIo8
 gu4Pl2JRBLCTux371tynII+aXBua9os0vk+/uw9LQuxWfhHFZpVnDFsCtt3UWPYXC8zIgB1hl
 NrJ3QxanK2t2eTbzU817X3/WGR63P7AqRt9dEccMYqtDjPGBR0vt4UhSFyj2GIvgPv54S6mZb
 +PRkNJbBkovxWXSZaBFmFdtlFMZFugrUmWEdQ0Zam6snANTR7m4CCJ17oCsvLKSJmeDLdwbly
 xlDbSi9x0InYbRHI57l30QX1mit3LIAghLGtkBiFYjDEqv1FKL/XuwzSOLOpEz3qb40jWlNdX
 3jzh4OVlGdDnf2m2D7ajpdSPiw1mVRXcWADnIrCKoWA8E2GTwsVm5e3De7uT8V3PdTza+jGo5
 pvK3cYfL+bCrl9Gaei0B+evgdeWehpd2Jr6DX77m4pvG3VOVL9GvqNLt/fgRKwJ8eDvGOLCpW
 zIGBM0xCQbSkPdlHo5vswr99Yk68rX8wgJo0ldKc5cYhjZfsKaimM4DKjJZnfE8EwMt7t2hGi
 lc2MhhLQtzr9XjAAewnlN5qE4xmba79Zp++BGhuobjAgDK+nTG+PDllgDjed6yJq+VSxtAN+a
 HKxU7zYLkoI9UJbAyyNkfA0U6OHun8rgdcUkjJZyLS4IuHxBI6LBDegTMmIFBgGj+C8P6AKZ8
 2IZ/rWWioM/Ato7msL4Zxz+b5+KH27hSZD78ZtriKhYZ8PdalaCNbZg+PpPBlLVJ5GGjrwyF+
 d7SbPeL+S2WO/ji1YM0arZUuS4LCjrhH//hNv3ashf6EB1c2DKSmmeMKkcBFwW4vd5gcFLrTw
 7IF/YBb5eQOD9ry7fpMUU3sIZxDjYOMOUu03NlJfTeew7vV3jVx+pI5fEF6YPUAX5K/Z4C5Da
 LVCXZtNHZ0NtZCpzYqSHA9RDURoLyw5S4zA2pe+Pesr6wtqd6OUGXasi+Vq1exrtI9JDpR/f3
 ISkBLp4HWt+YImjUnVLGaH/lX6Q2Ca6saYeoD4cCsbqZTXCGoIUO1BiC37tBAFL294QGD1F/X
 jIodKxdgAMqgnjIF2RhQw+WfSl4FdNK4P7A+J5wcymV2NkhCWNYWbqNLmMLx5k0QM8oJ3Izhd
 Q6lBMggfQgpVSMHdUvisPHcBmJOxkuEDJY2IHZbtW1uFuuKMSXMuz0zOG60HHifh5WvhDyl2p
 rkOemMjY2saRtswwU3qEPbVSSuP+z1gEYTBCTVA==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:26:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Z40XhgjMqFfOfh.kLsZer2n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register a yank function which shuts down the socket and sets
s->state =3D NBD_CLIENT_QUIT. This is the same behaviour as if an
error occured.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nbd.c | 123 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 49 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 7bb881fef4..e37b0f6ab0 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -35,6 +35,7 @@
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
+#include "qemu/atomic.h"

 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qmp/qstring.h"
@@ -43,6 +44,8 @@
 #include "block/nbd.h"
 #include "block/block_int.h"

+#include "qemu/yank.h"
+
 #define EN_OPTSTR ":exportname=3D"
 #define MAX_NBD_REQUESTS    16

@@ -84,6 +87,8 @@ typedef struct BDRVNBDState {
     NBDReply reply;
     BlockDriverState *bs;

+    char *yank_name;
+
     /* Connection parameters */
     uint32_t reconnect_delay;
     SocketAddress *saddr;
@@ -93,10 +98,10 @@ typedef struct BDRVNBDState {
     char *x_dirty_bitmap;
 } BDRVNBDState;

-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
-                                                  Error **errp);
-static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *si=
oc,
-                                Error **errp);
+static int nbd_establish_connection(BlockDriverState *bs, SocketAddress *s=
addr,
+                                    Error **errp);
+static int nbd_client_handshake(BlockDriverState *bs, Error **errp);
+static void nbd_yank(void *opaque);

 static void nbd_clear_bdrvstate(BDRVNBDState *s)
 {
@@ -109,17 +114,19 @@ static void nbd_clear_bdrvstate(BDRVNBDState *s)
     s->tlscredsid =3D NULL;
     g_free(s->x_dirty_bitmap);
     s->x_dirty_bitmap =3D NULL;
+    g_free(s->yank_name);
+    s->yank_name =3D NULL;
 }

 static void nbd_channel_error(BDRVNBDState *s, int ret)
 {
     if (ret =3D=3D -EIO) {
-        if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (atomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
             s->state =3D s->reconnect_delay ? NBD_CLIENT_CONNECTING_WAIT :
                                             NBD_CLIENT_CONNECTING_NOWAIT;
         }
     } else {
-        if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (atomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
             qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
         s->state =3D NBD_CLIENT_QUIT;
@@ -170,7 +177,7 @@ static void nbd_client_attach_aio_context(BlockDriverSt=
ate *bs,
      * s->connection_co is either yielded from nbd_receive_reply or from
      * nbd_co_reconnect_loop()
      */
-    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
         qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
     }

@@ -237,20 +244,20 @@ static void nbd_teardown_connection(BlockDriverState =
*bs)

 static bool nbd_client_connecting(BDRVNBDState *s)
 {
-    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
-        s->state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
+    NBDClientState state =3D atomic_load_acquire(&s->state);
+    return state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
+        state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
 }

 static bool nbd_client_connecting_wait(BDRVNBDState *s)
 {
-    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT;
+    return atomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WAI=
T;
 }

 static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
 {
     int ret;
     Error *local_err =3D NULL;
-    QIOChannelSocket *sioc;

     if (!nbd_client_connecting(s)) {
         return;
@@ -283,21 +290,21 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNB=
DState *s)
     /* Finalize previous connection if any */
     if (s->ioc) {
         nbd_client_detach_aio_context(s->bs);
+        yank_unregister_function(s->yank_name, nbd_yank, s->bs);
         object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;
         object_unref(OBJECT(s->ioc));
         s->ioc =3D NULL;
     }

-    sioc =3D nbd_establish_connection(s->saddr, &local_err);
-    if (!sioc) {
+    if (nbd_establish_connection(s->bs, s->saddr, &local_err) < 0) {
         ret =3D -ECONNREFUSED;
         goto out;
     }

     bdrv_dec_in_flight(s->bs);

-    ret =3D nbd_client_handshake(s->bs, sioc, &local_err);
+    ret =3D nbd_client_handshake(s->bs, &local_err);

     if (s->drained) {
         s->wait_drained_end =3D true;
@@ -334,7 +341,7 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDS=
tate *s)
     nbd_reconnect_attempt(s);

     while (nbd_client_connecting(s)) {
-        if (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT &&
+        if (atomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WA=
IT &&
             qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > delay=
_ns)
         {
             s->state =3D NBD_CLIENT_CONNECTING_NOWAIT;
@@ -371,7 +378,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
     int ret =3D 0;
     Error *local_err =3D NULL;

-    while (s->state !=3D NBD_CLIENT_QUIT) {
+    while (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_QUIT) {
         /*
          * The NBD client can only really be considered idle when it has
          * yielded from qio_channel_readv_all_eof(), waiting for data. Thi=
s is
@@ -386,7 +393,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
             nbd_co_reconnect_loop(s);
         }

-        if (s->state !=3D NBD_CLIENT_CONNECTED) {
+        if (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
             continue;
         }

@@ -441,6 +448,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
     s->connection_co =3D NULL;
     if (s->ioc) {
         nbd_client_detach_aio_context(s->bs);
+        yank_unregister_function(s->yank_name, nbd_yank, s->bs);
         object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;
         object_unref(OBJECT(s->ioc));
@@ -465,7 +473,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }

-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         rc =3D -EIO;
         goto err;
     }
@@ -492,7 +500,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc =3D nbd_send_request(s->ioc, request);
-        if (rc >=3D 0 && s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (rc >=3D 0 && atomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_=
CONNECTED) {
             if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
                                        NULL) < 0) {
                 rc =3D -EIO;
@@ -807,7 +815,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving =3D true;
     qemu_coroutine_yield();
     s->requests[i].receiving =3D false;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -966,7 +974,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *=
s,
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err =3D NULL;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         error_setg(&local_err, "Connection closed");
         nbd_iter_channel_error(iter, -EIO, &local_err);
         goto break_loop;
@@ -991,7 +999,8 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *=
s,
     }

     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply=
. */
-    if (nbd_reply_is_simple(reply) || s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (nbd_reply_is_simple(reply) ||
+        atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         goto break_loop;
     }

@@ -1423,6 +1432,15 @@ static int nbd_client_reopen_prepare(BDRVReopenState=
 *state,
     return 0;
 }

+static void nbd_yank(void *opaque)
+{
+    BlockDriverState *bs =3D opaque;
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+
+    atomic_store_release(&s->state, NBD_CLIENT_QUIT);
+    qio_channel_shutdown(QIO_CHANNEL(s->sioc), QIO_CHANNEL_SHUTDOWN_BOTH, =
NULL);
+}
+
 static void nbd_client_close(BlockDriverState *bs)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
@@ -1435,52 +1453,53 @@ static void nbd_client_close(BlockDriverState *bs)
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
+    yank_register_function(s->yank_name, nbd_yank, bs);

-    qio_channel_socket_connect_sync(sioc, saddr, errp);
+    qio_channel_socket_connect_sync(s->sioc, saddr, errp);
     if (*errp) {
-        object_unref(OBJECT(sioc));
-        return NULL;
+        yank_unregister_function(s->yank_name, nbd_yank, bs);
+        object_unref(OBJECT(s->sioc));
+        s->sioc =3D NULL;
+        return -1;
     }

-    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
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
+        yank_unregister_function(s->yank_name, nbd_yank, bs);
+        object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;
         return ret;
     }
@@ -1508,7 +1527,7 @@ static int nbd_client_handshake(BlockDriverState *bs,=
 QIOChannelSocket *sioc,
     }

     if (!s->ioc) {
-        s->ioc =3D QIO_CHANNEL(sioc);
+        s->ioc =3D QIO_CHANNEL(s->sioc);
         object_ref(OBJECT(s->ioc));
     }

@@ -1524,9 +1543,10 @@ static int nbd_client_handshake(BlockDriverState *bs=
, QIOChannelSocket *sioc,
     {
         NBDRequest request =3D { .type =3D NBD_CMD_DISC };

-        nbd_send_request(s->ioc ?: QIO_CHANNEL(sioc), &request);
+        nbd_send_request(s->ioc ?: QIO_CHANNEL(s->sioc), &request);

-        object_unref(OBJECT(sioc));
+        yank_unregister_function(s->yank_name, nbd_yank, bs);
+        object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;

         return ret;
@@ -1918,7 +1938,6 @@ static int nbd_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
 {
     int ret;
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
-    QIOChannelSocket *sioc;

     ret =3D nbd_process_options(bs, options, errp);
     if (ret < 0) {
@@ -1928,18 +1947,23 @@ static int nbd_open(BlockDriverState *bs, QDict *op=
tions, int flags,
     s->bs =3D bs;
     qemu_co_mutex_init(&s->send_mutex);
     qemu_co_queue_init(&s->free_sema);
+    s->yank_name =3D g_strconcat("blockdev:", bs->node_name, NULL);
+    yank_register_instance(s->yank_name);

     /*
      * establish TCP connection, return error if it fails
      * TODO: Configurable retry-until-timeout behaviour.
      */
-    sioc =3D nbd_establish_connection(s->saddr, errp);
-    if (!sioc) {
+    if (nbd_establish_connection(bs, s->saddr, errp) < 0) {
+        yank_unregister_instance(s->yank_name);
+        g_free(s->yank_name);
+        s->yank_name =3D NULL;
         return -ECONNREFUSED;
     }

-    ret =3D nbd_client_handshake(bs, sioc, errp);
+    ret =3D nbd_client_handshake(bs, errp);
     if (ret < 0) {
+        yank_unregister_instance(s->yank_name);
         nbd_clear_bdrvstate(s);
         return ret;
     }
@@ -1997,6 +2021,7 @@ static void nbd_close(BlockDriverState *bs)
     BDRVNBDState *s =3D bs->opaque;

     nbd_client_close(bs);
+    yank_unregister_instance(s->yank_name);
     nbd_clear_bdrvstate(s);
 }

--
2.20.1


--Sig_/Z40XhgjMqFfOfh.kLsZer2n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j480ACgkQNasLKJxd
slhpjA//XudcoSARbhmPTTtYuqj7Iiluo9J+Ug1BcxJN51kQtVdncKqCQ+20ZlQn
eR3jintJeJSJwZe5F7Pb6FQ7Mb3C1fJjcGNqtV1AjSyXq6t/slAznKTGIJ8VezGp
ejRuUUxjSLgwRPTzipzuES6wJy+12Oc7AojSuQE2G9Ou+wfJD38SiE0h9EUx+x7c
AcZq1BXwPA1fPIvFbf3VpDiqbZzuvmj/X5WxKTXwQeOVf8D0biMPXWjCQ7a8QJhO
gG6XhLywnOQetW307m2JiMiQR5b1e55fvqBW41/3dZ9KULtZ+aVbLfL4/IOUnKzh
jHfPBtHFWE3nnsJham+RkT5Cd6XTb9JU3du1Q+qo/W8o2wMiP2Jpc2DfokLvzd5+
jEYoFgtrFA7oaOkABmYAhpSLo2vCxRhrFwn1eHw9sHY9Ye7Hwuu9XPXx+9ubUS3Q
ZPssUPdC9u9gVcOG+w8cbJPW7lKygZh2b2KM5K5LQOzbJsDNdTrBCZ314MsVyI2O
oo25ASc40Z6A5eet/rjoi34iI1OiRE77W+Bjw9rBCiklmjQXrjXwqs4QBIf687bj
/I28q4fphlrM2YK7lNq6XmG2exe4icGwHT5hscBPB7Rldwjo6RHAhekbERG++GR1
nHH5rUeXZGvPzpiQHkvIPgWE1PEK8ezYfW801RapCPlg+Sr+8KM=
=/hTP
-----END PGP SIGNATURE-----

--Sig_/Z40XhgjMqFfOfh.kLsZer2n--

