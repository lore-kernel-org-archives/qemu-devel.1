Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01321C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5E1207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ViHs5jDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5E1207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFNL-0007oQ-Py
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jdFHL-000536-2I; Mon, 25 May 2020 11:44:39 -0400
Received: from mout.web.de ([212.227.15.4]:53911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jdFHI-0006d9-Jb; Mon, 25 May 2020 11:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590421471;
 bh=vjgc7wjc4cKdgQx7ocR5j9Ow5aCDgaGFl5sIJXEozlk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ViHs5jDQ4pfzj3Xp/nI5KN0SMsXGjZpKVnSmnLoiE5yesTB7r2qd7U1tjB+kXgPRJ
 2L+7kPDrqPtRUrZ0eHUgLSLBal1RvIA61OZYLn7KQpItmLfEhqzkkZFPBZ2iKRr1P2
 +YaAbUQJ+GHkeZuUSrQ2ps0pXcSmhOfT80NhHzx8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.22]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7sga-1iqetT06a0-00vMTA; Mon, 25
 May 2020 17:44:31 +0200
Date: Mon, 25 May 2020 17:44:29 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 3/4] chardev/char-socket.c: Add yank feature
Message-ID: <f513f9d9f329ca3a87a6e0aabe2f66f0775c1d6f.1590421341.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590421341.git.lukasstraub2@web.de>
References: <cover.1590421341.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VulCqIaF=ENoiYFGHsER1py";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:W4nAofsUgoJbkWOGQhUE8bIBSLOkYGcX3JNZs62PClHPOTB+190
 3oBG62HGuMOdSh2kuL5+4sGly8vrlEkG5BodS+V5aYemxGwS/IvbfNAciqq8jkb33aA9/3w
 Zy5b7IP2UfLZzhdr8n8ozYJydMm5T2UVGI1zzI9aM0PDLU+d6hWPmsZebOI86wuOK8iHH8X
 bmKtFxzmZZI1ajTNKP52Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Nrkf+Q33qo=:N14bzYhTwvlG1H02ndrZZW
 2W9cdAXK0Wn8c18TBSqFLf0kg2zNjibASllb4/ssqYhfzot77MUw96UYz9jbv/2tcS/Ol2VRl
 xPaoYrx++7/m4yu/I8reyRrrMKvsc1qg9OAtQvzDQjmqKo6GzPYqJjbwG7ClZoEwShKurh4xT
 lKrXNcaX26By7YdPIZuZSwLt11KY+kpXWrMocmzbm2Z6uAsWmsn6BEZYNhaoiWxqG5ZuUrS27
 miGCAFZJx0bx+6WSvY8UHFcLbG7K7lcGnIfAwdd0IO7HCSmDaUxt0Z5JFkW2trJENqXQ+tiVU
 O22yOUl/Lyqkvg7DjnVZ23Uzq0/tuvO0p627dZ8s7+zFvBqlr03fAG5N9JhvQ75LuItIp+/dp
 xbeSnN4CtwmcSUTMmEsh0POBYmALoSZ5y/+2yOTRtGn7B4gIipPGMp73Ll6FmgBdlKEdBmCrF
 yCDY0qr/tGLOdzkF5XD5Cntfm7hLB5IdaZr4KFv/+Qd/fhd/wks4WZ0QaQatWXDC6pCl21ME8
 yYWxb8ZDr9xy1mTHhNFt8ppmMNKGk4ATJypkpC6kPjaI/igLZaXvAM6SOy9Gnwd1p+79xqobw
 jUkkIZ9j/mGU2zVzW8Pz7N8luovJeoa8YqitFt/+byE6m8suGC99hc0it16DgHVKM41+V8Jab
 b3Po8VHYtngd93xfVNbBLmlQuO5nK0yl9lZiTbI2TuYIOw66lqSy3drFrR7mwQm+0sxhJK4bQ
 rpUo9QGVNjyvxuv7id6cSqSUuR3gawQ9Dr0SAOFa1zjSfOtXyk3XKM3zzDFG7rQ1XThn8cxo3
 mey+8nktSeRfP505kqNoJyV3GZqnSemlDGXHPAdW08G1jOzQnsdIcFYKmHCHFLrBvhYu4LZSR
 x2dvwDMRL8gP5Fq+u0eWZZxGQ4FDlmJhWek6OIcNn5Ov0C3DsW0Xo/7lGDQoVz1jioLgIAkRW
 z8Z67vb3lfdc0bOFLlMWWNWe+x9IsY5VzMs0zCQhN3zqIP6DdYKe3YIonPH9hRDlh+pIsWqgX
 1WF14g+43As6Vk7Ztyjk0pSj7p73NDDsNBDol7/DONtR7SqUVqOZsnt5uP07oHCqGidj1S+NP
 BI4i01Y7aLdM1qLNOEWeAkKbkiZ2zxJyTMAMuQhcgJptF5dLx26PHyEa/t4dWC9KAA0KR0Uvp
 lcqXd5Y/oW5uLLPG9yzBgb8FrolFMZN3A8mNuCAUAD4YjTZEvnpjhM/YvDdKCxT1xDpOiACzX
 CrsY0xsT8DYl6ypk+
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 11:44:28
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

--Sig_/VulCqIaF=ENoiYFGHsER1py
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register a yank function to shutdown the socket on yank.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 Makefile.objs         |  1 +
 chardev/char-socket.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Makefile.objs b/Makefile.objs
index 8e403b81f3..5582f4eda9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -10,6 +10,7 @@ qom-obj-y =3D qom/
 ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)

 chardev-obj-y =3D chardev/
+chardev-obj-y +=3D yank.o

 authz-obj-y =3D authz/

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda..d5c6cd2153 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -34,6 +34,7 @@
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "yank.h"

 #include "chardev/char-io.h"

@@ -69,6 +70,7 @@ typedef struct {
     size_t read_msgfds_num;
     int *write_msgfds;
     size_t write_msgfds_num;
+    char *yank_name;

     SocketAddress *addr;
     bool is_listen;
@@ -409,6 +411,11 @@ static void tcp_chr_free_connection(Chardev *chr)

     tcp_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
+    if (s->state =3D=3D TCP_CHARDEV_STATE_CONNECTING
+        || s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED) {
+        yank_unregister_function(s->yank_name, yank_generic_iochannel,
+                                 QIO_CHANNEL(s->sioc));
+    }
     object_unref(OBJECT(s->sioc));
     s->sioc =3D NULL;
     object_unref(OBJECT(s->ioc));
@@ -912,6 +919,8 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
     }
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     ret =3D tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return ret;
@@ -926,6 +935,8 @@ static void tcp_chr_accept(QIONetListener *listener,

     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, cioc);
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(cioc));
     tcp_chr_new_client(chr, cioc);
 }

@@ -941,6 +952,8 @@ static int tcp_chr_connect_client_sync(Chardev *chr, Er=
ror **errp)
         object_unref(OBJECT(sioc));
         return -1;
     }
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return 0;
@@ -956,6 +969,8 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_net_listener_wait_client(s->listener);
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
 }
@@ -1066,6 +1081,8 @@ static void char_socket_finalize(Object *obj)
         object_unref(OBJECT(s->tls_creds));
     }
     g_free(s->tls_authz);
+    yank_unregister_instance(s->yank_name);
+    g_free(s->yank_name);

     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
@@ -1081,6 +1098,8 @@ static void qemu_chr_socket_connected(QIOTask *task, =
void *opaque)

     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
+        yank_unregister_function(s->yank_name, yank_generic_iochannel,
+                                 QIO_CHANNEL(sioc));
         check_report_connect_error(chr, err);
         error_free(err);
         goto cleanup;
@@ -1115,6 +1134,8 @@ static void tcp_chr_connect_client_async(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_channel_socket_new();
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     /*
      * Normally code would use the qio_channel_socket_connect_async
      * method which uses a QIOTask + qio_task_set_error internally
@@ -1356,6 +1377,9 @@ static void qmp_chardev_open_socket(Chardev *chr,
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }

+    s->yank_name =3D g_strconcat("chardev:", chr->label, NULL);
+    yank_register_instance(s->yank_name);
+
     /* be isn't opened until we get a connection */
     *be_opened =3D false;

--
2.20.1


--Sig_/VulCqIaF=ENoiYFGHsER1py
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7L590ACgkQNasLKJxd
sljfOQ/7Bta0KcU6IflqBn+z4DjhM4F8jk9hcg96r7L3RUjgWUiMEgFSE1SPDJMo
JqaUla7q1cBDr19AIMOVjf6y6Vw9UCHfIPh7C1y9L0wY/lLv+21R/0zmd4vM4rfL
v7wKt8ZR9sEReFa5a1iSwcsxX8Sb6FUxF6KDHA9X7WyaClvEPCBPyNTSQFJp9AY3
UfGpDNdbBsTfxA2Vq0eOfU+Fj5utjopiG25OWXBwWG3yB8nGN4gJerBi38YpjGyh
xcuisp0sJfwkzjb2y+hePT9Yj3joMhen/5MoLYd9EV8Fs0Ooy67NLTnQzqj/lUq4
b/ufiHa2f93gNCj7IygVW7jZnc7BFUi341JLgU02pxReYdEUERnITL0wheqYTKHH
usEPq68NT1o5MSQzLhPQg49eccQgLEyHKrCEEB8YXe+sifjCAq13L53/1D+9ZHad
eObfFO4zItkqbUlPVCIqxxkbDN0Sj9cd+QOgsC6If3HRYpZPy0weNiyDkzu6cfTa
dB9m0Ra6wxUJRtis/DJYcl3NTekt9ovbGJihAVezfw75RnVYp/XkS8CNSvU6DWDz
wsfFLVaY/dV1gTuh86fWFoinOOO9kW9Ht0x99R2xtW/EAHb8R0XY7/2LMPefjwpb
cFLW82RbEmLlpOK+pGIgxAzidz7sF5LIfH5VubP60HbX3NCTw68=
=zUHc
-----END PGP SIGNATURE-----

--Sig_/VulCqIaF=ENoiYFGHsER1py--

