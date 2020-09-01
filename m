Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED9BC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58964206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cFky8VPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58964206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2Z0-0002s8-D7
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2Nv-0002KD-VG; Tue, 01 Sep 2020 05:15:23 -0400
Received: from mout.web.de ([212.227.17.11]:34845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2Nt-0007GL-QA; Tue, 01 Sep 2020 05:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598951716;
 bh=75ECl9bX1EGfY3DMAQC4Qu0/MXJlbsQoukpW/VUFgz0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cFky8VPmbrQ8rP24faNszi5Cl8Cm+wVI4qeFo2+oGYAl44kPRV4s1dFz/6h7DP1E0
 7V6yFABMXzs/guyScrmccArwAqWnTKDJR3EAv6/zPauSqenSI7RzsYQklMeNJ7ZNEy
 of30ThqB5lg6BcS0tMZimXuc/QanyVXPbSF5d6pc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.220]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdEsP-1kvTs50xiD-00iVuK; Tue, 01
 Sep 2020 11:15:16 +0200
Date: Tue, 1 Sep 2020 11:15:14 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v8 3/8] chardev/char-socket.c: Add yank feature
Message-ID: <cb2de974afd99baa8646261c87f66bc663e8c36d.1598951375.git.lukasstraub2@web.de>
In-Reply-To: <cover.1598951375.git.lukasstraub2@web.de>
References: <cover.1598951375.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mF_.EjoPRGRfufbh6DGgakM";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:SWIqchQkfqMgjfjcTWWMUeWHuAzyddrcMgMwuAikZRMKfM8goQl
 TiZEgK+99+WZPdd3SyxB2oOnPx8SWmTnHYlCcOBJVqshjeYe1ixUKvAOQc+xT/a1/TFZd1P
 n9ZoCO3YZLYBELXoycswjVNdX3ofMd1dHAYrN7NWspY8fGnrjCI9IEMqFkMK7vizhx7GdAQ
 zM8UY5XjREK7qDqf/wCAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QqNDNFckpWY=:2LApKKugsQJyw5mCnBAjuz
 0yVlQS5KiJmdNtRShoWBgy4vyxGwX2vVrLT4IWrINVonl1uHpvWfN6NxQEffxaB0hOkEaDgrd
 yNGRvKsaZrnwmAH2zMwOq4vCnVl/eP7W8gUDQFR2I5OTuT6HNErAh8szrwWyaVy/eGBHjNt/x
 yi3BCmy2MfUO05yOon9xMtTqpEepsc/iodJRkaHKx1dD3fGc0pnp1P5ehSS0RgMpOdCn1Rdle
 DFl0KNq15fPd/gTz1qIQgfDqvLJpvLVPoYjrp4YAMLBUC59xjEd5A++i4Mm21q5m4KxCobjQl
 qTYaU8TAHMwbkIOglRNk+Xahos8FCHwZ2eCFmaFifPyqj/ey2+QtKdqWDYNGmP3DqoNSWFIh0
 9A6B9a9G0/sEYrArGE8gw/qnkUCjFlV0x7/U1hxNJYrp+C7Qm/BsIO1t1rCs2n1f0N8W5i+8Y
 ZpBOIN+K7hBU+V9utdn7NFiLcoZKXXh6fdsro0m6KqeyQK+0vUv1w1pulLnOxum7jQiD1NRJc
 AIE5c1PGklAFUA0bw87zLP0AVpjndgb4AxTyD59c7BBxccTUyu05vDD1V5xFSo0UweaFulGUk
 zDDll/gzerTHhokuqRvqstrxA/WFKm0rRL/T/jpWlo0vvCKsX831MQ5F6I9tNKgsA0Myri1c0
 tBS2SHtACIqrugf9UmxH0e1c1RvYu4aNsWHr1fynDGZVtLWKtaM0t6MWmbLVo8fpocye9o+sm
 2qO2mr94uOV/osVNd/YgGWZTjmFW7lUIyeIsq2kmh4q6J3psL1GEM7GzOYqwY2KVPyTJBzNWC
 IA88/rUBLr4sjboK4sHcFrPdVuBP+ZJDk9rNNoD9I4nQs1sgu9dwKf8yPmv3zeh/wuGI72K5q
 7KCPY0MieiDDWjB9FR7nnKmvxEPNwrUpgMJgZbMGpHEakmtArxuWlNoK/6f4dAWfYVldJqDfR
 jLeK8WIIVee1wMCIZ9J0n6613eDtDCkfykSj0NltwLZ0jKoUzXloqVB823UJ9KHjP+/sBP4SI
 wZUbG3TSl8SbM+LKj0fzQ2vEAlvbLmIbalwd/5E8Rt3CNRpKil0NQNBLCiLtc4Ait+fqt503S
 PxK/0NbMPvGEl04VWve1VuA0KEJruIebvLk39ZwFsNDFPb9KoqZfs9UifpP/ooaDDLbsiLbsr
 sA9GayjMVaV5r+QMbGWbXYXl3ACuuY8YnbhwyzHrlnGrpY+iPeEgSL/S4H5YdMhQywJAxGdz/
 osxJJIeXciYIgBqVXvllrX1/HR85GWC5rB/SGiA==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:15:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

--Sig_/mF_.EjoPRGRfufbh6DGgakM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Register a yank function to shutdown the socket on yank.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ef62dbf3d7..8e2865ca83 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -34,6 +34,7 @@
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "qemu/yank.h"

 #include "chardev/char-io.h"

@@ -69,6 +70,7 @@ typedef struct {
     size_t read_msgfds_num;
     int *write_msgfds;
     size_t write_msgfds_num;
+    char *yank_name;

     SocketAddress *addr;
     bool is_listen;
@@ -413,6 +415,11 @@ static void tcp_chr_free_connection(Chardev *chr)

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
@@ -916,6 +923,8 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
     }
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     ret =3D tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return ret;
@@ -930,6 +939,8 @@ static void tcp_chr_accept(QIONetListener *listener,

     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, cioc);
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(cioc));
     tcp_chr_new_client(chr, cioc);
 }

@@ -945,6 +956,8 @@ static int tcp_chr_connect_client_sync(Chardev *chr, Er=
ror **errp)
         object_unref(OBJECT(sioc));
         return -1;
     }
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return 0;
@@ -960,6 +973,8 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_net_listener_wait_client(s->listener);
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
 }
@@ -1070,6 +1085,10 @@ static void char_socket_finalize(Object *obj)
         object_unref(OBJECT(s->tls_creds));
     }
     g_free(s->tls_authz);
+    if (s->yank_name) {
+        yank_unregister_instance(s->yank_name);
+        g_free(s->yank_name);
+    }

     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
@@ -1085,6 +1104,8 @@ static void qemu_chr_socket_connected(QIOTask *task, =
void *opaque)

     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
+        yank_unregister_function(s->yank_name, yank_generic_iochannel,
+                                 QIO_CHANNEL(sioc));
         check_report_connect_error(chr, err);
         goto cleanup;
     }
@@ -1118,6 +1139,8 @@ static void tcp_chr_connect_client_async(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_channel_socket_new();
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     /*
      * Normally code would use the qio_channel_socket_connect_async
      * method which uses a QIOTask + qio_task_set_error internally
@@ -1360,6 +1383,14 @@ static void qmp_chardev_open_socket(Chardev *chr,
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }

+    s->yank_name =3D g_strconcat("chardev:", chr->label, NULL);
+    yank_register_instance(s->yank_name, errp);
+    if (*errp) {
+        g_free(s->yank_name);
+        s->yank_name =3D NULL;
+        return;
+    }
+
     /* be isn't opened until we get a connection */
     *be_opened =3D false;

--
2.20.1


--Sig_/mF_.EjoPRGRfufbh6DGgakM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9OESIACgkQNasLKJxd
slhMvg/8Chh74xXK/C30xYZdPVNZzskJ4CrBW2z9f6CxQbK/NINt1HBZMUP7NY9+
gSvJ/mo3M5Uheri3UIExt99bqMcRy424udOU7aaAm1viKZIZHyn3P3A9jF7iDgDv
Egf0MqLokUY/Tij4MIDTwBOWg3VxYs26GmfBXYxHKsoXoktPpZLCS45duny6qmPm
Tgtv2QrQ1IPMZDveW1nkIDxrLFjEcWLptQnmxaD0f0OMQGWUhnCG2wmgJMg4tjMl
3wtblxyeRWuoQKvfaLYcNrvkhDH4E67NRcMdmrnzTODOlOhHeO/mXFVD8UbVeIyV
MAmQ4f0/6HXLPwM+Lx5eJHhDUYlYCHvw/pwNfdl8eIJFGpEc48wepMU84lMjF6WW
Xqlc6tbplMvyhFMUHLWZfdGCcXKBsPawJVgy5OP3GfPxJdlJz3B/6ot77n6cWBlW
t/a4qs7FAnpuE3sKWhZ53vQXRLfLxnmOj0lAoRDi7Gx+Nmb/c8kbfoyiyD23nhbV
NIFzn5ELCKLEmdDod35czz1jNVEbOcI9XwU7RCH+uUwL3ZpMJ3HAwS990zYz7bWN
bH2tnBAEPT0MOQJjRx1yT+xINYheB7Oc7AXTFjAr+wbtgrytkp3q8ZONWpMXAAh/
3eiVQWeYcM61kH+sb0eExwJOEJu+6+tZRiHRxvYY0OOR5oR8ghM=
=Jf6V
-----END PGP SIGNATURE-----

--Sig_/mF_.EjoPRGRfufbh6DGgakM--

