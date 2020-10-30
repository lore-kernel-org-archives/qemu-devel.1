Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC9CC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BE220725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="MMvyqfaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BE220725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXWn-00011k-5v
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXSz-0004RR-QH; Fri, 30 Oct 2020 12:41:32 -0400
Received: from mout.web.de ([212.227.15.4]:43665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXSv-0002zN-5j; Fri, 30 Oct 2020 12:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604076077;
 bh=XGA0O70u6TLS3an16/oRND8bYIhBPrkrTegb9iYzn/I=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=MMvyqfaWJ1sxxM4mrmlNOG5bY0M3ozqQC4q3LDWS5VrboHsjoIKQ0aEywgi1/82Nr
 oyvNbMrQMO/gyGPYYeITpRuDcXTXMKQcDEL1+34VstixBubcFibEp+CzFmj/w7mEzO
 QnHGQUu6J357MNOoGuFGH+f0n4nOY+NY2Hy1FT8Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRTvU-1kwiAv1hRw-00SccY; Fri, 30
 Oct 2020 17:41:17 +0100
Date: Fri, 30 Oct 2020 17:41:16 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v10 3/8] chardev/char-socket.c: Add yank feature
Message-ID: <20201030174116.4a23adc2@luklap>
In-Reply-To: <cover.1604075469.git.lukasstraub2@web.de>
References: <cover.1604075469.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0BhTw3FtIaMYYCyxqDI+QF1";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:WUiHWDMS+dgyktVXrDUnsHIFIVG9yBvM9T+O7EZmY55hwJ2m9wZ
 Y0wxb7t51i/wqpeRNwLs/wYwpIhcy3YLJ7NJWtVPQ4t8z3giDt212sz91c9zNEkc5D1LKZj
 YVTGtLgCTKXAC7EWBa8y7omRQ6tUagGpmvoUPU2E5Iwj96yGUA41QBEG+weLvxmu/B/2tdd
 0cc4FItvQrzlQPzJZq4OA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Q9UIPY1Vvg=:beJqlo/glAoLvVi8w5VKmC
 CFfTQdHZPa8WUoPmVpaCrHU+dFxvvEbua6ltBeOo0d9NpRPRTU6yg/ib7OS7MX3vLCKh7kJY/
 +slhpBZBFjXf7pjZX112u/5m6XgWIrm7IL1XJFNHiASDyVIMyFg3XuV99JA4PJ9ckBGpc+N7R
 cZsPm9EYaAlrRAnFHisosouwDk9bf68g7pHXvuAun072ewam0pjxNl9n3fRwkK7gqb5AO5dpN
 PHLwFy3sRkJTt0TCEM8yAxYi3Sh78kzqrLylugIEBxls+59yESPWaHYyGgB3hkoXtAJh7WkL4
 xy8EVx0BU3DGOCjiZ9F5IVAXsIYQ7zlasadk2ZtvOtI54BUkUU+gVdo3PlBeNOxhnmmUCAA6B
 vTVf6FNq5KmC36Enrqu0braumZ315JVmd71yCDv+T3RN6oQkpo5lh2wZjfmvvHssLSJATFzRl
 Sttmv/SdbVdG4fhL9CaHBk3UUozs9PHTmKc/AnGzdUkdgha2+iqOlW+gD27BzkJ0bMrDJfpKR
 qb6KAF9nnIzL957vAYVbe+gaPkKenUL1k7YKRT2YG2BEbEDNP/+RSChmilDVkR/eW1gnjlkbY
 B6vCKWTAseS62dqFoeBjWdcPiAPsua39In1WqH0u942bh4rDG8/EYTdzWdk8sEsoNeojHPedP
 rXZ730yXK6juSIskkZEjCYTvtFjV7oA9aZJ6rpk5ivPJB7s8WcpKYjjd+rrV+ipU8NbpvO5WA
 KdtYJbCERopU7BxG8kVJjM/lScIpgvOAy4RzE+Ld6Q0gOSTknG9Ls07F1oxEYqo9FAjZTw+Rv
 oxLuufMdkGr6H42KbaDKt87JtFUG/L+FNP/Qm7gjQn2zocduq5g01R+ezF2ZvaVQ5Lpt856cj
 KIKxplFCUJvikc2ISrYQ==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 12:41:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/0BhTw3FtIaMYYCyxqDI+QF1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register a yank function to shutdown the socket on yank.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 chardev/char-socket.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 95e45812d5..5947cbe8bb 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -34,6 +34,7 @@
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "qemu/yank.h"

 #include "chardev/char-io.h"
 #include "qom/object.h"
@@ -70,6 +71,7 @@ struct SocketChardev {
     size_t read_msgfds_num;
     int *write_msgfds;
     size_t write_msgfds_num;
+    bool registered_yank;

     SocketAddress *addr;
     bool is_listen;
@@ -415,6 +417,12 @@ static void tcp_chr_free_connection(Chardev *chr)

     tcp_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
+    if (s->state =3D=3D TCP_CHARDEV_STATE_CONNECTING
+        || s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED) {
+        yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
+                                 yank_generic_iochannel,
+                                 QIO_CHANNEL(s->sioc));
+    }
     object_unref(OBJECT(s->sioc));
     s->sioc =3D NULL;
     object_unref(OBJECT(s->ioc));
@@ -918,6 +926,9 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
     }
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
+                           yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     ret =3D tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return ret;
@@ -932,6 +943,9 @@ static void tcp_chr_accept(QIONetListener *listener,

     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, cioc);
+    yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
+                           yank_generic_iochannel,
+                           QIO_CHANNEL(cioc));
     tcp_chr_new_client(chr, cioc);
 }

@@ -947,6 +961,9 @@ static int tcp_chr_connect_client_sync(Chardev *chr, Er=
ror **errp)
         object_unref(OBJECT(sioc));
         return -1;
     }
+    yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
+                           yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return 0;
@@ -962,6 +979,9 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_net_listener_wait_client(s->listener);
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
+                           yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
 }
@@ -1072,6 +1092,9 @@ static void char_socket_finalize(Object *obj)
         object_unref(OBJECT(s->tls_creds));
     }
     g_free(s->tls_authz);
+    if (s->registered_yank) {
+        yank_unregister_instance(CHARDEV_YANK_INSTANCE(chr->label));
+    }

     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
@@ -1087,6 +1110,9 @@ static void qemu_chr_socket_connected(QIOTask *task, =
void *opaque)

     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
+        yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
+                                 yank_generic_iochannel,
+                                 QIO_CHANNEL(sioc));
         check_report_connect_error(chr, err);
         goto cleanup;
     }
@@ -1120,6 +1146,9 @@ static void tcp_chr_connect_client_async(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_channel_socket_new();
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
+                           yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     /*
      * Normally code would use the qio_channel_socket_connect_async
      * method which uses a QIOTask + qio_task_set_error internally
@@ -1362,6 +1391,12 @@ static void qmp_chardev_open_socket(Chardev *chr,
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }

+    yank_register_instance(CHARDEV_YANK_INSTANCE(chr->label), errp);
+    if (*errp) {
+        return;
+    }
+    s->registered_yank =3D true;
+
     /* be isn't opened until we get a connection */
     *be_opened =3D false;

--
2.20.1


--Sig_/0BhTw3FtIaMYYCyxqDI+QF1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+cQiwACgkQNasLKJxd
slhoKxAAo43gQnJjo8JvVBetXLSfeH5iVkuCvdnrlj3ekOfjhQnBWSvG2V8eUWaM
ZAFzqx1N/UN7gKODQZhXqoTSAEm/WHC2b9ETXIJndc24iAXx7EevQTA5zPu0BR+x
S+VGCPNO5kBq5u4ECAEkdIeo4/4yRDjTTs1ozlnibgb9oWYuxmcVzwS8YZ5acZbr
coQPjZTkLJ/DxiMuNZUEeLB8MZiKlBX3sTDfKOoPUoskTJEW424oDjeCz7Bv6phI
zDL9Q6GG1iPwqrOq+tsjVCbYgbWRcU8+CYNA8bg0NAJo9nyoNMCaiVm841C0+osG
gN60sB9fm9cPorJ4V6beBp0BdM6CAdeJ208guInEZEnzqgoy59eJ4huxCeWH9q4g
SBkUOYUVssNiI+zjOXAlboyqRPtZ+mNbCPWzHsW1ggY3uzUC7vS4oiXqHo6HxefX
YPPa/i+3+9B1Z913C1iDgqgXEA7yGq1AiUWtWdJxGFkXRmpp7oDwWKINhitD54AD
va1hG+7j1OICfiKNR5kmnfQWzLTPbzl9kUhS7tZhQZaYA8jpJHJN4MPbS7V6dErX
aaOHUeaptyCmff9gj61O5kUMwaLDDi0NYh+jk/xU8xoEavLnq5oNkeOyUmlJ6LQD
4gJJtPpN5qqRYqoA/qX6ywVJ4tLHnv3eZRYwjmSq2n9QHuxxvas=
=8cci
-----END PGP SIGNATURE-----

--Sig_/0BhTw3FtIaMYYCyxqDI+QF1--

