Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541B2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20D820748
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="m1cg9iv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20D820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbW59-0002o3-SC
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuS-0002Is-1T; Wed, 20 May 2020 17:05:52 -0400
Received: from mout.web.de ([212.227.15.14]:46407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuQ-0002SG-MM; Wed, 20 May 2020 17:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590008744;
 bh=/xFb+uwZk6b6GLotHwOBOfo+Z5J6TuKbIQZ+zdDqQSY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=m1cg9iv2biN/b7i5k5H1ZaNVymcYmh3qhSeVi9LxLhjbdJ3My4cRmFzJOG1Yh4R2H
 9h0fr/2M7L6f/pYYIGrTOLoY7df8hr2n94PvFo7E7LL3FUrzvve4BwxbrZp7kowhae
 3DYBRls6eswRgV3yMqMfhcPxh/Wyg0uv0fOL9dK4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmcRH-1j2RwJ202N-00aERs; Wed, 20
 May 2020 23:05:44 +0200
Date: Wed, 20 May 2020 23:05:43 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/4] block/nbd.c: Add yank feature
Message-ID: <aa2b30bc01f9ef8261678325a332ab5871ceb24f.1590008051.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590008051.git.lukasstraub2@web.de>
References: <cover.1590008051.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mu8mAQME3gfjD8Tg1GyupO3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:mzWudhdfZSmBzlRnmCnIFlMRj4vwfVepF7bxb0Hzre35Wgs2WjU
 NGlaUDderD4pRynxQIwa1KWPBF43kacvdFjvhod6aOM9k6Vz3yQsrfBxvGbJR5mlUntA803
 fI7xtuQayqJjKZLxECHxr/t56uZaCmYCMdJNB0ue7ge2/4jc+Fuab6AsZtEThVJEmRnZ0ID
 APZMMXZi32kGS0uymobQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7B3JV0olYJc=:bfoxVDfTURBl2uJb/mDmTE
 jqfZ+6L73fc0yB8U8Y0ku4VASCpiHOXObd90Xq4gB2Gxhp0gdfdIHG2ZH8mybh6gEhzeXvmQG
 cGlarUiEwFHd6bqYLYNf2OP8NInPFPHa2g/HaE4crNHmRPS0USbsmELRa7aCzbpipUhNvzcG8
 3JrDWP0UgO4iBS+FW+hT1+h2Vh+uks9Nludw6iSrbeVA+yoKGnkiyCUgKYfvdqLU6h0swX3BV
 ot4xdceNxdKnXN3p+IQ3ac47eeAvzdFirrWPCZE/Lrp1huzkKdZHqtJSNnJkgSw8zbkDaTx7f
 bb/BaPy4Aqq34rfCKCTqot9nhCzTNAcFOlx4ZzSKGDrq/mdUstXl5nmdRhcn9q1xQCjP2efFi
 xptVSb5FWeOkN34ozwHhXnQ9kR2AfR/gVPTNgzRHcQXWCylC5oWBh+gTVm4BbWogzXcQZkrrF
 YkFVHCaZ+ylhwILcSl0MTqjJRMKHSmfYWxCj2Nfy9861uWb18wSxwtBuZALP4m1wMnH4opdT4
 HC2rjkycSBtwovge9wRBV18LG9Dpl/iulcbqPrK/B/JdGvIts39sGi6kcP/0s5OiSSBddk9Lv
 H3MwJ6Xu7QJXgcSUT23fJmfd0P6tbqun/RKr6OEvhhJw0nupz0RUITK0FH2Lj8ExuaJiES7hd
 sEH4jWYen65r4OLpflZhnDtmFlx3wRNA7zHOLi56RoB6OVzu/DLgkR7wYIQq5lCzbCpVlWevk
 iJ0HAuTnlelxCPFfUcjIWMzs76GQwi0c+7Mh+K31g3DoKEp+IYqY6AHintzxVup/s3SP5cudG
 j8c+f2BMtxznN3w3Xzlu4vuFBxNRohy+mnstpS4q/duWSTO39+yrK8K+oMjBk14oYyI6EBX1l
 /1cIbszzhdDoxVIl8aBfRTlFhWUnSRQSn1vojQqpYsiUm0VRNLVbQGjAatm1jR6m+THTVwtJw
 xYLw0bn3Qa+y4ZDyVzJLKWIzCkX3YFAsIHFVSXGR6+b/wWWaUe6aafLZvPgyyEq9hfi5SMbB/
 zxohfLTypDZq6SLYFkmT8DnorhjWS1SFXB5s4bC80jnj803GJdHPAF9y2cdHuYXOX7bjOBqTK
 c218vKSAPhqz1SNzqHEaz+cM+LCxFgrV61S3SIhtaDRo2R79Oi1xQ+gGKk/4wCEjdHOhPxL5z
 PV03PFrk/IjZJMzYSBWAU8pvAwid6iAJgsysAg6kSU/IQCdfwZjaeElZzxcVt8Uwqgjtx9o1P
 hRvToQP4mskJMx2Fe
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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

--Sig_/mu8mAQME3gfjD8Tg1GyupO3
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


--Sig_/mu8mAQME3gfjD8Tg1GyupO3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7Fm6cACgkQNasLKJxd
sljj0g/+IQlDN/L5XoZyzG0C4wZ3HsSdF4rAsKq2TIYoMFZmNBxkbki7oZppQwgD
WVFykhUbXpST6znrDSaDcBEfJd/oVtqrRK2+GOw/d+HLbXryu6OD4HM/CSWrE8F5
o/z8b/nKN1iwtvMTvXP3EfU7dEG6SLGi5usS9p3iAxKPMmTxdQok2+8/fbXR4+EC
pMCaMRN5V8uyGWAMHrMRMW/iSl6zY00kPtx2UGz5XeNi3VYfUeakYrk3VJ+Y2XLy
lm9ymiiWsCHAtAIY9xmasn7n2QH7SK2DXfw4EpeYLK60cnewtpJBGgZklud399ey
yoYmOyLV3Gv1vIvHg5qsLr+61eruHzkPtTJUGXCg1fNJOIMAfXTHKpo9KM3Kr2PF
Tw1pGjyOsmnuqP+4qY0tKFM3j6QMgR/0hOnY4aogbKjD5u/r5qog/UD06sTBBZy1
DJ1JLnSmsPWcz5alhzeGtmPycaPbxH4OuzFVbG8QPKeBnbiEivbMBOrL7w/3gx59
IwZR4HIXU7gWDafH0WgQL7EXuxBh3Bf3VTvMvp7GyNEIAxgJkI8hY/YW/qrUyMK1
7U/cfnm5chvjdoENLVa4+ntKSe6ZGOK1XriSTWEzffwYeP8K0KPMvREwy7VoHtsd
kOH4PxlYGsqELYwiN80Q9C+42ZdT4ksLdJwn1Wcu7wRSL0KzA/U=
=fOJp
-----END PGP SIGNATURE-----

--Sig_/mu8mAQME3gfjD8Tg1GyupO3--

