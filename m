Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D71C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BF720720
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Fman6Gtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BF720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkCN-00071C-PD
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8U-0003uH-W7; Tue, 23 Jun 2020 10:42:55 -0400
Received: from mout.web.de ([212.227.17.11]:56981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8S-0002Te-Ny; Tue, 23 Jun 2020 10:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592923366;
 bh=G19cw0JrVxhybvc/d/f5ihO0pHrqVaiFtWVFAQXcyis=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Fman6Gtgtnht9Y+m3YzgUhM1krKIS83SktneKJNqzpmfYtmKBkabNce9DQ6TOEuiO
 7pAIufh5/HaMRYd7nqgmgA/nQzb0k49nJB+pZ59m12pyLvql5VEXMOteuO4lwMsMC/
 TPqgY5V6JKu6aQcXepgaGG2LylZFLSkdGEj2A+LY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.8]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0PP-1jiYf52OWT-00COur; Tue, 23
 Jun 2020 16:42:46 +0200
Date: Tue, 23 Jun 2020 16:42:45 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 2/7] block/nbd.c: Add yank feature
Message-ID: <3971e5cdc40d18e16c499560e2bf3ac8e5e42e26.1592923201.git.lukasstraub2@web.de>
In-Reply-To: <cover.1592923201.git.lukasstraub2@web.de>
References: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tvQ3EGv3fjAGIck_n3v_t8U";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:31atETboUbGKSh6uWJUBdfsNnfw1HX+ulMwoPZBnNughRoHP5RD
 CcbMC7zvM0w0Thfo88JlooiQJ2BbYTIwyoWeORFfQEHwGZjg5sE06cVvM/fHWmVbiyWiykW
 nk+QZtdGWpafEA4tOxUFq5AGCZm4+Mzh80e8QHz9yMcpTsweHKoorWqUEzjWWTSELjJ/mF1
 WrprZxvidEjRW1ovwuPKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qjMqcil2Z/k=:z7KZjBVhTa0qa5LqhBtbrN
 7TomXGzuswoJfpHQJWos6d5LkegTluQotRTP8StTuUHSybcea5pdF6k/DMGCiHopMK2deVzMT
 zX/t7B9hvv39VuGzhc6qUBgT2WgLA6Z5VixpJsqNZ3orSbHBz1c4vV1LF305127Ic2SVVW/z2
 T1Fchx0wVNmkDno439hyMTGm7m3KUmDSU954p3P4TcgQBb8fmISXjyAP+S0xRauvOclqNkyge
 iMVh02CW9Gy2Yb2r6pYVRqTqu/xx2ImXqdJqghU2PwI6IFVLdCMpgEFyIK9Vc/VFykQSMM1m5
 z7Ax0X20u50Kk4QuLf3t/x17NgqrES8AeSLNRpd75ToJf75aXkSu+1vN5yjbXi+3quP3JQm15
 yHvFLlYULXnerQnTTlcKyq2BK7Ul5Ki9P2ZMXk1mlovweuN9tWSRnWu8J7RT2jqetu2w2oQwu
 EFsncopPzFyGn4M74lu0Q2Mw6vRW64+1X5/cJ0AZMaDF57w/kxjUc3ndm4GdIk0mS9InRdsOh
 0o6/jH7NcEDUZLmu3H9tz5snViUFPKCPGG0INj7zXqbtw3KTZIDxo5IwZelaLvwJu9WyM+gO7
 I1a+1dz5w2WM65tR/r5GL4sziZGUF68FMUdgS4IuN50J8xF8pdRhpR9evqTDfb6zLlWZ34qg4
 KRDQRxqLC+5kkC/iFJX9ILVgl2QRdQlLFHU9ozs8APm6qYg/L2eZ/eaOE0hWCKF7vAM4AT0GQ
 F4pDrsXLEkXt54IQfGYyTjU7vHym0czfesWkASonEtLn/sWHeJRle4RkfBq5qIYitfV8NTfve
 LXQlAjpS31khFS4rsdpG8AWcF7B2rloTRJSro1rpc0FXRoNowRWcZsvl1Voko0gBbilaOqlUi
 iCTB/EeYNRxH1awMZusOVUF2cfqfBLmXjNaG2ng1GLnml7XvScPoqZ6GzsAzLfDN6jM7az5YN
 hhlKABhE72OgBGNoNFUaB898W3rO0N+G3Vvum31ytGJ7P9RLHT0dtc2vgEAk1F4cGsEy83dH1
 bF8rGGvSVXtjkZ385NMoDaKjcdfCzxVgSFRqAbsjCkJt6yfeaj+zn/OQQmjtSrfAQycfC0HEj
 jkvXRJ+9vnuReFt7pZdGsc0urA1SQHJmxpJVRHXHL1WxziXb8mRm1oSGO28CchP2eoAnvJ6D5
 OcW7GtUOrgILLoD8mF9wOUXxcPVVfLtWwhBnGib6uJ8G3MB5Dq9/ZYass2KinnNW8fyZNIjta
 yWwdOjSFvWYW7UhhA
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 10:42:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--Sig_/tvQ3EGv3fjAGIck_n3v_t8U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register a yank function which shuts down the socket and sets
s->state =3D NBD_CLIENT_QUIT. This is the same behaviour as if an
error occured.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 block/nbd.c | 101 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 37 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index eed160c5cd..6134a82d2d 100644
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
@@ -94,6 +99,7 @@ typedef struct BDRVNBDState {
 } BDRVNBDState;

 static int nbd_client_connect(BlockDriverState *bs, Error **errp);
+static void nbd_yank(void *opaque);

 static void nbd_clear_bdrvstate(BDRVNBDState *s)
 {
@@ -106,17 +112,19 @@ static void nbd_clear_bdrvstate(BDRVNBDState *s)
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
@@ -167,7 +175,7 @@ static void nbd_client_attach_aio_context(BlockDriverSt=
ate *bs,
      * s->connection_co is either yielded from nbd_receive_reply or from
      * nbd_co_reconnect_loop()
      */
-    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
         qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
     }

@@ -206,7 +214,7 @@ static void nbd_teardown_connection(BlockDriverState *b=
s)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

-    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
         /* finish any pending coroutines */
         assert(s->ioc);
         qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
@@ -230,13 +238,14 @@ static void nbd_teardown_connection(BlockDriverState =
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
@@ -274,6 +283,7 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDS=
tate *s)
     /* Finalize previous connection if any */
     if (s->ioc) {
         nbd_client_detach_aio_context(s->bs);
+        yank_unregister_function(s->yank_name, nbd_yank, s->bs);
         object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;
         object_unref(OBJECT(s->ioc));
@@ -305,7 +315,7 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDS=
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
@@ -341,7 +351,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
     int ret =3D 0;
     Error *local_err =3D NULL;

-    while (s->state !=3D NBD_CLIENT_QUIT) {
+    while (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_QUIT) {
         /*
          * The NBD client can only really be considered idle when it has
          * yielded from qio_channel_readv_all_eof(), waiting for data. Thi=
s is
@@ -356,7 +366,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
             nbd_co_reconnect_loop(s);
         }

-        if (s->state !=3D NBD_CLIENT_CONNECTED) {
+        if (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
             continue;
         }

@@ -411,6 +421,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
     s->connection_co =3D NULL;
     if (s->ioc) {
         nbd_client_detach_aio_context(s->bs);
+        yank_unregister_function(s->yank_name, nbd_yank, s->bs);
         object_unref(OBJECT(s->sioc));
         s->sioc =3D NULL;
         object_unref(OBJECT(s->ioc));
@@ -435,7 +446,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }

-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         rc =3D -EIO;
         goto err;
     }
@@ -462,7 +473,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc =3D nbd_send_request(s->ioc, request);
-        if (rc >=3D 0 && s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (rc >=3D 0 && atomic_load_acquire(&s->state) =3D=3D NBD_CLIENT_=
CONNECTED) {
             if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
                                        NULL) < 0) {
                 rc =3D -EIO;
@@ -777,7 +788,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving =3D true;
     qemu_coroutine_yield();
     s->requests[i].receiving =3D false;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -936,7 +947,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *=
s,
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err =3D NULL;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         error_setg(&local_err, "Connection closed");
         nbd_iter_channel_error(iter, -EIO, &local_err);
         goto break_loop;
@@ -961,7 +972,8 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *=
s,
     }

     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply=
. */
-    if (nbd_reply_is_simple(reply) || s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (nbd_reply_is_simple(reply) ||
+        atomic_load_acquire(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         goto break_loop;
     }

@@ -1393,6 +1405,15 @@ static int nbd_client_reopen_prepare(BDRVReopenState=
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
@@ -1405,25 +1426,29 @@ static void nbd_client_close(BlockDriverState *bs)
     nbd_teardown_connection(bs);
 }

-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
-                                                  Error **errp)
+static int nbd_establish_connection(BlockDriverState *bs,
+                                    SocketAddress *saddr,
+                                    Error **errp)
 {
-    QIOChannelSocket *sioc;
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     Error *local_err =3D NULL;

-    sioc =3D qio_channel_socket_new();
-    qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
+    s->sioc =3D qio_channel_socket_new();
+    qio_channel_set_name(QIO_CHANNEL(s->sioc), "nbd-client");
+    yank_register_function(s->yank_name, nbd_yank, bs);

-    qio_channel_socket_connect_sync(sioc, saddr, &local_err);
+    qio_channel_socket_connect_sync(s->sioc, saddr, &local_err);
     if (local_err) {
-        object_unref(OBJECT(sioc));
+        yank_unregister_function(s->yank_name, nbd_yank, bs);
+        object_unref(OBJECT(s->sioc));
+        s->sioc =3D NULL;
         error_propagate(errp, local_err);
-        return NULL;
+        return -1;
     }

-    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
+    qio_channel_set_delay(QIO_CHANNEL(s->sioc), false);

-    return sioc;
+    return 0;
 }

 static int nbd_client_connect(BlockDriverState *bs, Error **errp)
@@ -1436,28 +1461,27 @@ static int nbd_client_connect(BlockDriverState *bs,=
 Error **errp)
      * establish TCP connection, return error if it fails
      * TODO: Configurable retry-until-timeout behaviour.
      */
-    QIOChannelSocket *sioc =3D nbd_establish_connection(s->saddr, errp);
-
-    if (!sioc) {
+    if (nbd_establish_connection(bs, s->saddr, errp) < 0) {
         return -ECONNREFUSED;
     }

     /* NBD handshake */
     trace_nbd_client_connect(s->export);
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
         return ret;
     }
     if (s->x_dirty_bitmap && !s->info.base_allocation) {
@@ -1483,10 +1507,8 @@ static int nbd_client_connect(BlockDriverState *bs, =
Error **errp)
         }
     }

-    s->sioc =3D sioc;
-
     if (!s->ioc) {
-        s->ioc =3D QIO_CHANNEL(sioc);
+        s->ioc =3D QIO_CHANNEL(s->sioc);
         object_ref(OBJECT(s->ioc));
     }

@@ -1502,9 +1524,10 @@ static int nbd_client_connect(BlockDriverState *bs, =
Error **errp)
     {
         NBDRequest request =3D { .type =3D NBD_CMD_DISC };

-        nbd_send_request(s->ioc ?: QIO_CHANNEL(sioc), &request);
+        nbd_send_request(s->ioc ?: QIO_CHANNEL(s->sioc), &request);

-        object_unref(OBJECT(sioc));
+        yank_unregister_function(s->yank_name, nbd_yank, bs);
+        object_unref(OBJECT(s->sioc));

         return ret;
     }
@@ -1911,6 +1934,9 @@ static int nbd_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
     qemu_co_mutex_init(&s->send_mutex);
     qemu_co_queue_init(&s->free_sema);

+    s->yank_name =3D g_strconcat("blockdev:", bs->node_name, NULL);
+    yank_register_instance(s->yank_name);
+
     ret =3D nbd_client_connect(bs, errp);
     if (ret < 0) {
         nbd_clear_bdrvstate(s);
@@ -1970,6 +1996,7 @@ static void nbd_close(BlockDriverState *bs)
     BDRVNBDState *s =3D bs->opaque;

     nbd_client_close(bs);
+    yank_unregister_instance(s->yank_name);
     nbd_clear_bdrvstate(s);
 }

--
2.20.1


--Sig_/tvQ3EGv3fjAGIck_n3v_t8U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7yFOUACgkQNasLKJxd
slhynhAAoJxAy3aHBpyMzV/rRl6gDw/DQn2tSWfuzkssHzVmbYeUBGqZEWvjMn2F
2H9/k75AV0oUW0u9xtx7u7VKjMSDEc29ojiSAhlUxTcIVuI4ZpCkrLYUFCocRR/5
7dVFimUqCCtUDWBo2h2jWIuOwrnDaFaXd7WRd1TwWqVjLWf+tmy3IaIe30LWZ/Ob
XZ3Z7Z2eVTiM35nzFF2gwnBG37MdYjcULhdIxSxlRb+WKU7NIpQ+RXR9W1SUf6cj
fMKsNgRO4jumxi6e+K/l0/54rbH5y3/m9ZEEdbnAOPDw38i+ojZkyrNmEa0sd6wh
dvbm7XTh9a1Rxzrqxcnz/mQXfGFJG1vpBZc7WXC6TIVRMC6CspCx3896Mksopwez
bMxLsL7zBWfmXiYfHQE3BGxW7NaA/7u4TXdwNqhqgrqhYwfdxzHdT0piUyGw/42d
UZl/hJqbY2XD2a6cZafbtYMYBWm7AN9ni/VANokFnZl8gIi9tY70fniD/KD+8wVU
aeo5IjC2moWlAzKStfCOPRcL/+C2EAuflg8oagZZKCmdr7o5ZI6l4wqbjT5haUtt
uPJn+qwV6opz2dlK+7i/TFtdhNihGcyTBfctmzc183pZpDOdbq6XVTLwPlI6MEHO
q2KVjaW4ORpm3rUdpdb5XbjGXAuS+VMmZDAT8iXP+Sdu1PK1yKU=
=JPLq
-----END PGP SIGNATURE-----

--Sig_/tvQ3EGv3fjAGIck_n3v_t8U--

