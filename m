Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46439C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0748320787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mSLKI7lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0748320787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcvTT-0002Aa-Vb
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 14:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvP8-00089U-BX; Sun, 24 May 2020 14:31:22 -0400
Received: from mout.web.de ([217.72.192.78]:56759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvP6-0006Tq-Vx; Sun, 24 May 2020 14:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590345076;
 bh=elKbSKLl3l/JFRMmDA9fenj91qTQd2VT8UJA44f7Xf8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=mSLKI7loG4D4nHjVxP2SFXZa/1ooY4+ODPOzmVQNWPcA1fc1fxXH152jIX4kWdHOn
 pMp3BrR9zBx+ZdADSQ8XXsaZwPAsxQsb32HpiMFx1dhI/AuokBpufOeDHm6tE1hSiX
 8oHZpMOQAcd7nfhYz5FI5RQM4yTwfZv6GCV7zjFE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.42]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76XN-1jfv8m3RBX-008ibA; Sun, 24
 May 2020 20:31:15 +0200
Date: Sun, 24 May 2020 20:31:14 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 2/4] block/nbd.c: Add yank feature
Message-ID: <8e6a8e61b25813cdcdf385729709ef57f6255a3e.1590344541.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590344541.git.lukasstraub2@web.de>
References: <cover.1590344541.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AWcC8y5tR9GC0gTQ2tCMDEs";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:D/t3yZcETUz1dpJFdB4TItEk5myVnDtI9C7QyWOMDh3+JoNhajc
 2BJqXekcf9UY5fnBA1jp+w44jtqN3N9kglL+YIiHW/OJFbq87UpwQGTpevx598YXWYSkapk
 jBIqtoNtluBv9kJJnI9vrDSMdZvPyqac6SHENgjrUghr6RVFk/kAej3Zndup3vLJK2xgqFU
 57JaFKGj7+6gsPCzQXPCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zGWS4j3n+/I=:JX+CObVvwzs0VxNIgHBkf8
 KOsPMdHktXMYIVxQcCx4DBRQEZLKFWwT6+EhBUzp+VVyb5b8z+i7xlO5Kd3Cy8f4tSnKdW/NH
 pyMBYyt5XMIuhXcGn+zuzoRydfRDMIPrGPmGhduh3RjI8zKUpNDlO0+7IXsb3MzDCVUl+VB/r
 AMGo5WOONGh1Z845s6g6+hiF4pIu4UxQ6BUvdnHTpABwoBOnTfX0COBSyWKtQe53ooddKunlb
 P1dzZJZ3qGZpxmpf3nyvqzLvop9sFfFtM6OPHQIZU/Xixoj7byOuWybOuqu6QMxVT3jPTqNjW
 Hx6ACM0eQzp2S77+W+5DLrtDlXHeelpFrUV1IjdM4rvDyu6+dkHOBU6g9GBaX7q3/UH7IGTf5
 YFkwXc0eKD1jlPqD0yzRW9fmpw/giKOQk50vqza3fsmDlEMeY9Dbe88dFBmh0ohynts73Hsnt
 cV/fX6v/5vA1lVZnqKxxx8FCLc537ALFlzjqZ7TWbxesUAZB+NovnP6k4UFd5y5cceTl8fNLb
 oem1wMvg19t8YhvHisSAioe+zgOsqu1gGSKYmlMpybSE77Ve18UFpvfzyybQcbAdzOf0FC8SD
 DA6Wtxe9g+vulGaXjSi4WeqmyZym+j+nMh+9Z8F3Vxd8H9HaR2me4s21bL177RxONcAAJN/0p
 +Atscep0IL4iBjTYf1w1DsEHl7PEfxNXggb2etSYGpeXaS/NLF2u5Pj3s4tW++O0r4brzT4oI
 IG5K0hVd9+u6AsSIlfak0XZFd0rq1vSRs6fE81WKZrpDXAza4xcFmjpJFMEGz50mR6hdcGRn+
 ZwmzKMMAdT/NwDZqMjB4T34xQ3y4NnpY+fqcXGG6t4eQvXPJ5lxtm2YmkPQkkXTf3FD+41hKL
 RkvPm7UzteA4zfc7VIHC2CQ2OqUVxLSOARdNs0QfeY1QlUYnwFOmEwHaPHmv5HBmF3FZQN30c
 HgmYAezEMig6GomlmxfTI/w/GVOzOk5vXg3TZHcuAjqLkRTS70JMAKOCRt+8RaEXI/zYKoD/M
 rU3GZlpQulyimi1f6h/lxUeR5unsUfhKk52y8Ty1yUu/Zgoisd4uEitsbRsKzZeuqrafkgLBR
 VkLVnIHPsAdXOs2FqwE/XjFIB+cAWbvmvpKJcKplALyZqlQcKKxou8HpZDcfMIXvivmTfRv7N
 /LLpP+vOUGo5RVDvJPT+bVK9Zixj0WFpsiYv2z4J+9ELKi7ES2WmvpCnBcHajaPAu45LxXoIp
 dFKsn/uQRSu/LvyG9
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 14:31:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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

--Sig_/AWcC8y5tR9GC0gTQ2tCMDEs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register a yank function which shuts down the socket and sets
s->state =3D NBD_CLIENT_QUIT. This is the same behaviour as if an
error occured.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 Makefile.objs |   1 +
 block/nbd.c   | 101 ++++++++++++++++++++++++++++++++------------------
 2 files changed, 65 insertions(+), 37 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index a7c967633a..8e403b81f3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -18,6 +18,7 @@ block-obj-y +=3D block.o blockjob.o job.o
 block-obj-y +=3D block/ scsi/
 block-obj-y +=3D qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) +=3D replication.o
+block-obj-y +=3D yank.o

 block-obj-m =3D block/

diff --git a/block/nbd.c b/block/nbd.c
index 2160859f64..3a41749f1b 100644
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

+#include "yank.h"
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
+        if (atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
             s->state =3D s->reconnect_delay ? NBD_CLIENT_CONNECTING_WAIT :
                                             NBD_CLIENT_CONNECTING_NOWAIT;
         }
     } else {
-        if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
             qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
         s->state =3D NBD_CLIENT_QUIT;
@@ -167,7 +175,7 @@ static void nbd_client_attach_aio_context(BlockDriverSt=
ate *bs,
      * s->connection_co is either yielded from nbd_receive_reply or from
      * nbd_co_reconnect_loop()
      */
-    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
         qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
     }

@@ -206,7 +214,7 @@ static void nbd_teardown_connection(BlockDriverState *b=
s)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

-    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
         /* finish any pending coroutines */
         assert(s->ioc);
         qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
@@ -230,13 +238,14 @@ static void nbd_teardown_connection(BlockDriverState =
*bs)

 static bool nbd_client_connecting(BDRVNBDState *s)
 {
-    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
-        s->state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
+    NBDClientState state =3D atomic_read(&s->state);
+    return state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
+        state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
 }

 static bool nbd_client_connecting_wait(BDRVNBDState *s)
 {
-    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT;
+    return atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WAIT;
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
+        if (atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WAIT &&
             qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > delay=
_ns)
         {
             s->state =3D NBD_CLIENT_CONNECTING_NOWAIT;
@@ -341,7 +351,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
     int ret =3D 0;
     Error *local_err =3D NULL;

-    while (s->state !=3D NBD_CLIENT_QUIT) {
+    while (atomic_read(&s->state) !=3D NBD_CLIENT_QUIT) {
         /*
          * The NBD client can only really be considered idle when it has
          * yielded from qio_channel_readv_all_eof(), waiting for data. Thi=
s is
@@ -356,7 +366,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
             nbd_co_reconnect_loop(s);
         }

-        if (s->state !=3D NBD_CLIENT_CONNECTED) {
+        if (atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
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
+    if (atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         rc =3D -EIO;
         goto err;
     }
@@ -462,7 +473,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc =3D nbd_send_request(s->ioc, request);
-        if (rc >=3D 0 && s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (rc >=3D 0 && atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTE=
D) {
             if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
                                        NULL) < 0) {
                 rc =3D -EIO;
@@ -777,7 +788,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving =3D true;
     qemu_coroutine_yield();
     s->requests[i].receiving =3D false;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -936,7 +947,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *=
s,
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err =3D NULL;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
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
+        atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         goto break_loop;
     }

@@ -1395,6 +1407,15 @@ static int nbd_client_reopen_prepare(BDRVReopenState=
 *state,
     return 0;
 }

+static void nbd_yank(void *opaque)
+{
+    BlockDriverState *bs =3D opaque;
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+
+    qio_channel_shutdown(QIO_CHANNEL(s->sioc), QIO_CHANNEL_SHUTDOWN_BOTH, =
NULL);
+    atomic_set(&s->state, NBD_CLIENT_QUIT);
+}
+
 static void nbd_client_close(BlockDriverState *bs)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
@@ -1407,25 +1428,29 @@ static void nbd_client_close(BlockDriverState *bs)
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
@@ -1438,28 +1463,27 @@ static int nbd_client_connect(BlockDriverState *bs,=
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
@@ -1485,10 +1509,8 @@ static int nbd_client_connect(BlockDriverState *bs, =
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

@@ -1504,9 +1526,10 @@ static int nbd_client_connect(BlockDriverState *bs, =
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
@@ -1913,6 +1936,9 @@ static int nbd_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
     qemu_co_mutex_init(&s->send_mutex);
     qemu_co_queue_init(&s->free_sema);

+    s->yank_name =3D g_strconcat("blockdev:", bs->node_name, NULL);
+    yank_register_instance(s->yank_name);
+
     ret =3D nbd_client_connect(bs, errp);
     if (ret < 0) {
         nbd_clear_bdrvstate(s);
@@ -1972,6 +1998,7 @@ static void nbd_close(BlockDriverState *bs)
     BDRVNBDState *s =3D bs->opaque;

     nbd_client_close(bs);
+    yank_unregister_instance(s->yank_name);
     nbd_clear_bdrvstate(s);
 }

--
2.20.1


--Sig_/AWcC8y5tR9GC0gTQ2tCMDEs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7KvXIACgkQNasLKJxd
slh/CA/9FVNypT75WtbQBFbfM3/9+Eu5QemEamAwhKhX44Oi6boAiT+CJU0ou1+M
HQzuGQ7spXpuBgql6Bm9geegkwG077YIuhmRoJKFzWGAcIE+Uh0mgYifR0KAinz2
yM+YmFxcZrhsO+Yjw9Ri/Pdw8lxO4T6wY2MEJG2y9D7NYRQmGE6oKuYgWybtipbb
q7+VszUaGdRj9I/Xv9dtH+TknDezz5wgCO7NF2JFeOuixGtoI/m+bhvukySOanxJ
k00ZtEXhGao9ETEhCcruzVD9Xz+jyriBUPLkzJDQUs2G+8WpYLp4D7PJJsCRnZzH
1lwhqXt+gVOEC5sh52XOWLUsURwideLUjdBKIl4sNjlgOuCqI4HlLFz0At+htLr2
fNbqSQgLWUAqTFgG8CLg2BzAmrHt/Ure/jA8gF7g5ZBGkq01bTWM3seU3ztxzirc
6ht29lRreRajoTlFjYRE8DjmekmAtvnwT+rfAZXsrSNi05Bv67h1lx5DMEDgVNbl
M+XyarhhA9DJa21H02WFAmroYiwS+kqblz/JNgvfKsjFseGncPJoCtb9AnHeshS5
Ff17uAVc4njghkKbnFesXXKlSAmDImUy9gYHsxqGnU5urCQ/cHuiWWY3q0TuKgWu
MPoDO+4ilVrmIUDPdH93aUq19cL642LQUclD8MZdpPSfn6hIKo4=
=6gYe
-----END PGP SIGNATURE-----

--Sig_/AWcC8y5tR9GC0gTQ2tCMDEs--

