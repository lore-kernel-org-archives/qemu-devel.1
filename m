Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2C9C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3005320708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="stMMxOC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3005320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6mu-0004di-7A
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Oa-0000cO-2m; Mon, 11 May 2020 07:14:52 -0400
Received: from mout.web.de ([212.227.17.12]:57943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6OY-0006tK-Mn; Mon, 11 May 2020 07:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195685;
 bh=9nGypIWIejpA7HfrS60ch3u2aL2qpDcRe5ObfV39NrQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=stMMxOC5X4CrTiHK3jDxNNEGFqU/lPuzj0ycUvh7PA662QigR4LTAwtsgwO0tIJ/S
 sBSiMk64+D1fnvhAR5Zo0WciHh41HZcF7OF4bMYXmoIp2RmTrbdlOSBItxzkKPQtbi
 XiPNsp3qImpGFg1+FUYnzKxX0FsSab7vh4Ve1etU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOV6-1jji4F25xC-00P0bh; Mon, 11
 May 2020 13:14:45 +0200
Date: Mon, 11 May 2020 13:14:44 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 3/5] block/nbd.c: Add yank feature
Message-ID: <1e712fa7f08e4772c2a68197a851161bee51610f.1589193717.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193717.git.lukasstraub2@web.de>
References: <cover.1589193717.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=EWYk1vF1y85GQW7SBrQC38";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:CbWoCUPLZCMVgZAYdVQ9OIB5fjgRkbvXEKmDdD06kATq24YYNYn
 YEBaIRzw5Oxk9mEGbRwjS6as8ZZzf1qcwOdzAYxnY7nYiOd8sgXpeslloWCCEnoNzzegdIh
 l46wn8QduDAWAfnYyDladi2xx6nNpgM0zdLTrSNndS9WvW3Uj7Z6RTSIv2Z91302IJZ+PSg
 vNVrKjVwtunKVonOQ9xuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:INt/hoZG3E8=:WDYkHSwaBul5QedSSoBVCn
 wLFGoPwPXzT/9CjK5+W5ibkZ7wF/gte5AwrgDwEqciklrzwIfYVkGSpx2XptX4NPxfdUnZqNC
 Lh26/WuXP6K8ZrxArRdAcjE1jZY211hK0B8IDgTYWAq6sNsxDjWrgIVF3C68YXNytvaXiwQmE
 sadW11eYrHpA5VpNB63NippXm29tZdQi/DmhldEFEUKr9nj0nav/FY0f8UQaXpGmyHw/Gjr9u
 nY+sAql88li+qt69T09HEO8GRo0ujIjsgDeQ618508EACbZ7bfbpghcUxa5pC3cIRt0sUMaRf
 n4Q7CftrStOIJUUlGpBkwYP1M+PjzYRa/6SyeU1kppxsO82iARHTc+QcKy1D04mpO0R5U6+S0
 cunLJizIs9p2b0PPrxU9Wc5FSy9atwPYgJ3uDKxo9WoEmW432bJDM/sP27PjuMWco3EjzwwGN
 +tkKPJFT0TtLl6kVo9lSSqg62iXWvVa6GitAZ6r1ocY3gU25/ZyC5OP9QeuOuggpnObkdyM2e
 uiyvfFQsADojwt2l8EYcuSsHanj+Pt1BxUM4vrolpIod4V0DpAIlhZnI0ypcIthkWofOiILMC
 LNhhrzrX5vHHOqBLgEmpG1YQYxfDq7htuvCd7INwaR7clfWEVaklQ9OvIxPuDALYBfO0k8cZY
 H1Bb1rd86nb5lG17N6FbGxq6rJiiDyZSyI0aeaBsiUY6Hiib8es76ysHMb8SKVX8VP02MX0Kc
 FGkUpJyLbvDr7lGAo+oTEKixni4FamsyzWkhHD7SrMf1Dlw/2tIOmlzino+jDMkwmsTpl91iB
 soCrtUYXppTh7WaO69sY+y3pqgBlQ67jHWAytkSh36MHSJWccUsOnbsN0bbJMCiG9j519r8Bx
 oGdIvSnwMtTRLPVpyUz4KfNsddMh+kLbtQIRhYMyVXt1IHGnGVbQ5xebJK8x+SuXUV9kuCBrw
 Iaq35JalCiccmCiEHWJiDgrvPt35ZqeaqIaAvLK8dC6749DE+7ZLF03a3jgKrXMrbjryfUszk
 SUttqZBQVz9rEk+83r/HcY+xwK+RELXIyQF1U8/L0S4ACMzV96n/fYr5JxRH79D3lGMvCCbBa
 2pbaBckwVvVlG3viLk4ZkZEpw9zL7Cviyn7ksh9vpoemxf8WXA/mvDO+Wt7rXTAlDlFcOLoJ7
 MTXPwbJHdWC52o1oikECmDZUyy1sSqL7V18AVfVsW1woGejwgefUK1G7xPThzbGL6pQT3npI2
 bjldkT8UxxHJj5DQq
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/=EWYk1vF1y85GQW7SBrQC38
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Add yank option, pass it to the socket-channel and register a yank
function which sets s->state =3D NBD_CLIENT_QUIT. This is the same
behaviour as if an error occured.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 Makefile.objs        |  1 +
 block/nbd.c          | 68 +++++++++++++++++++++++++++++++++-----------
 qapi/block-core.json |  5 +++-
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 889115775c..4b213b3e78 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -18,6 +18,7 @@ block-obj-y +=3D block.o blockjob.o job.o
 block-obj-y +=3D block/ scsi/
 block-obj-y +=3D qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) +=3D replication.o
+block-obj-y +=3D yank.o
=20
 block-obj-m =3D block/
=20
diff --git a/block/nbd.c b/block/nbd.c
index 2160859f64..3c0fd3abb8 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -35,6 +35,7 @@
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
+#include "qemu/atomic.h"
=20
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qmp/qstring.h"
@@ -43,6 +44,8 @@
 #include "block/nbd.h"
 #include "block/block_int.h"
=20
+#include "yank.h"
+
 #define EN_OPTSTR ":exportname=3D"
 #define MAX_NBD_REQUESTS    16
=20
@@ -91,6 +94,7 @@ typedef struct BDRVNBDState {
     QCryptoTLSCreds *tlscreds;
     const char *hostname;
     char *x_dirty_bitmap;
+    bool yank;
 } BDRVNBDState;
=20
 static int nbd_client_connect(BlockDriverState *bs, Error **errp);
@@ -111,12 +115,12 @@ static void nbd_clear_bdrvstate(BDRVNBDState *s)
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
@@ -167,7 +171,7 @@ static void nbd_client_attach_aio_context(BlockDriverSt=
ate *bs,
      * s->connection_co is either yielded from nbd_receive_reply or from
      * nbd_co_reconnect_loop()
      */
-    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
         qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
     }
=20
@@ -206,7 +210,7 @@ static void nbd_teardown_connection(BlockDriverState *b=
s)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
=20
-    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTED) {
         /* finish any pending coroutines */
         assert(s->ioc);
         qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
@@ -230,13 +234,14 @@ static void nbd_teardown_connection(BlockDriverState =
*bs)
=20
 static bool nbd_client_connecting(BDRVNBDState *s)
 {
-    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
-        s->state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
+    NBDClientState state =3D atomic_read(&s->state);
+    return state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
+        state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
 }
=20
 static bool nbd_client_connecting_wait(BDRVNBDState *s)
 {
-    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT;
+    return atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WAIT;
 }
=20
 static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
@@ -305,7 +310,7 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDS=
tate *s)
     nbd_reconnect_attempt(s);
=20
     while (nbd_client_connecting(s)) {
-        if (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT &&
+        if (atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTING_WAIT &&
             qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > delay=
_ns)
         {
             s->state =3D NBD_CLIENT_CONNECTING_NOWAIT;
@@ -341,7 +346,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
     int ret =3D 0;
     Error *local_err =3D NULL;
=20
-    while (s->state !=3D NBD_CLIENT_QUIT) {
+    while (atomic_read(&s->state) !=3D NBD_CLIENT_QUIT) {
         /*
          * The NBD client can only really be considered idle when it has
          * yielded from qio_channel_readv_all_eof(), waiting for data. Thi=
s is
@@ -356,7 +361,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
             nbd_co_reconnect_loop(s);
         }
=20
-        if (s->state !=3D NBD_CLIENT_CONNECTED) {
+        if (atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
             continue;
         }
=20
@@ -435,7 +440,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }
=20
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         rc =3D -EIO;
         goto err;
     }
@@ -462,7 +467,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc =3D nbd_send_request(s->ioc, request);
-        if (rc >=3D 0 && s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        if (rc >=3D 0 && atomic_read(&s->state) =3D=3D NBD_CLIENT_CONNECTE=
D) {
             if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
                                        NULL) < 0) {
                 rc =3D -EIO;
@@ -777,7 +782,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving =3D true;
     qemu_coroutine_yield();
     s->requests[i].receiving =3D false;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -936,7 +941,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *=
s,
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err =3D NULL;
-    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         error_setg(&local_err, "Connection closed");
         nbd_iter_channel_error(iter, -EIO, &local_err);
         goto break_loop;
@@ -961,7 +966,8 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *=
s,
     }
=20
     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply=
. */
-    if (nbd_reply_is_simple(reply) || s->state !=3D NBD_CLIENT_CONNECTED) {
+    if (nbd_reply_is_simple(reply) ||
+        atomic_read(&s->state) !=3D NBD_CLIENT_CONNECTED) {
         goto break_loop;
     }
=20
@@ -1395,6 +1401,14 @@ static int nbd_client_reopen_prepare(BDRVReopenState=
 *state,
     return 0;
 }
=20
+static void nbd_yank(void *opaque)
+{
+    BlockDriverState *bs =3D opaque;
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+
+    atomic_set(&s->state, NBD_CLIENT_QUIT);
+}
+
 static void nbd_client_close(BlockDriverState *bs)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
@@ -1407,14 +1421,17 @@ static void nbd_client_close(BlockDriverState *bs)
     nbd_teardown_connection(bs);
 }
=20
-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
+static QIOChannelSocket *nbd_establish_connection(BlockDriverState *bs,
+                                                  SocketAddress *saddr,
                                                   Error **errp)
 {
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     QIOChannelSocket *sioc;
     Error *local_err =3D NULL;
=20
     sioc =3D qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
+    qio_channel_set_yank(QIO_CHANNEL(sioc), s->yank);
=20
     qio_channel_socket_connect_sync(sioc, saddr, &local_err);
     if (local_err) {
@@ -1438,7 +1455,7 @@ static int nbd_client_connect(BlockDriverState *bs, E=
rror **errp)
      * establish TCP connection, return error if it fails
      * TODO: Configurable retry-until-timeout behaviour.
      */
-    QIOChannelSocket *sioc =3D nbd_establish_connection(s->saddr, errp);
+    QIOChannelSocket *sioc =3D nbd_establish_connection(bs, s->saddr, errp=
);
=20
     if (!sioc) {
         return -ECONNREFUSED;
@@ -1829,6 +1846,12 @@ static QemuOptsList nbd_runtime_opts =3D {
                     "future requests before a successful reconnect will "
                     "immediately fail. Default 0",
         },
+        {
+            .name =3D "yank",
+            .type =3D QEMU_OPT_BOOL,
+            .help =3D "Forcibly close the connection and don't attempt to "
+                    "reconnect when the 'yank' qmp command is executed.",
+        },
         { /* end of list */ }
     },
 };
@@ -1888,6 +1911,8 @@ static int nbd_process_options(BlockDriverState *bs, =
QDict *options,
=20
     s->reconnect_delay =3D qemu_opt_get_number(opts, "reconnect-delay", 0);
=20
+    s->yank =3D qemu_opt_get_bool(opts, "yank", false);
+
     ret =3D 0;
=20
  error:
@@ -1921,6 +1946,10 @@ static int nbd_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     /* successfully connected */
     s->state =3D NBD_CLIENT_CONNECTED;
=20
+    if (s->yank) {
+        yank_register_function(nbd_yank, bs);
+    }
+
     s->connection_co =3D qemu_coroutine_create(nbd_connection_entry, s);
     bdrv_inc_in_flight(bs);
     aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
@@ -1972,6 +2001,11 @@ static void nbd_close(BlockDriverState *bs)
     BDRVNBDState *s =3D bs->opaque;
=20
     nbd_client_close(bs);
+
+    if (s->yank) {
+        yank_unregister_function(nbd_yank, bs);
+    }
+
     nbd_clear_bdrvstate(s);
 }
=20
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 943df1926a..1c1578160e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3862,6 +3862,8 @@
 #                   reconnect. After that time, any delayed requests and a=
ll
 #                   future requests before a successful reconnect will
 #                   immediately fail. Default 0 (Since 4.2)
+# @yank: Forcibly close the connection and don't attempt to reconnect when
+#        the 'yank' qmp command is executed. (Since: 5.1)
 #
 # Since: 2.9
 ##
@@ -3870,7 +3872,8 @@
             '*export': 'str',
             '*tls-creds': 'str',
             '*x-dirty-bitmap': 'str',
-            '*reconnect-delay': 'uint32' } }
+            '*reconnect-delay': 'uint32',
+	    'yank': 'bool' } }
=20
 ##
 # @BlockdevOptionsRaw:
--=20
2.20.1


--Sig_/=EWYk1vF1y85GQW7SBrQC38
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65M6QACgkQNasLKJxd
slgqZRAAkEvBgPb7R+vNzYLW/UVNHb2ZS0T3q/lfgEP9AgcCt+fqLNfoyvgoD6Hk
BJ7rGmr2sEZTF73/NnyoU/SgK3iqNP3upHftWFAS0Q0/HC424e38zHjLRekDFPlY
XbXd/SwxbBfvYJbVwi9g6g0V3d3P52BmmcGQgtu+IY2cQIUT291nn3yAQLs/z4Ta
vnDV8mVa4Mf4BffH03Wc+nnQHpEwXhcDg57T8z7Ec9nGnw829IPRYjOXbWqHi4BN
jN/KRvdp7I0uwtppBX7faSLC9IetxW6+cA7Y8315JpMnt/7Ds1sP7aj6YHL4tIza
Rq2HrbMrQUGfYcVOd2XGhMV8gSmdSToVmHSeOsRB2q0MxrK12qsUwEPZVHVmue5V
4AmT+4NDjIa/XHng115Doygk90u1ARU6eQadPA44l3cCJRBJh2YJvJ3LHilFE1RY
AtImhDStaFr860qw93Euz1q8ojq8jFILToSXOT0IEW2DEj2hXE0zXEz8myK15vod
4jpxtVKU1/5RsX+U/i9tr+6pHR+cvkMG+FNvqxIOuhSP2Rn6gCwIGzu46Ki+m3fM
sw1SGcd51uLdpeq1xNeN87Qs7dY+VsOaEPkCCNK7AVg5qfN+W8JZmlplL1PCnQEC
C+J70hrwa6jcRW7thkpr1I9RdFRpwLoqvD3Jre3cN+N+T9iDYHI=
=iKRm
-----END PGP SIGNATURE-----

--Sig_/=EWYk1vF1y85GQW7SBrQC38--

