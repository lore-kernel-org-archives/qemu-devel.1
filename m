Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E821C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515A82076C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aPdMGOJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515A82076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2s5t-0005Hz-9o
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s34-0003YW-BO; Tue, 04 Aug 2020 04:11:50 -0400
Received: from mout.web.de ([212.227.15.3]:35801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s32-0006aK-Em; Tue, 04 Aug 2020 04:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596528703;
 bh=xEDe+zbBuVAXvPtAdZvI/hRMlZMB5Q4vXtnHyT3/2s0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=aPdMGOJjV2YRFitkCwx+7ezT2NuDWgWLi81v8tb2gAbARBOecdrmtHGK/fmyNdMSs
 MNz/joZXnob5jSduaI5P1L8J0DA+6hgis/k0Wx3uafgYFsN3WmUJxsK7oRaCuCog2c
 lTHLafgwLJzpIqeIxRkL0c83EjaXRNf9vCKwkPi0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8c2V-1kyXEa1oP5-00wFv9; Tue, 04
 Aug 2020 10:11:43 +0200
Date: Tue, 4 Aug 2020 10:11:41 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 3/8] chardev/char-socket.c: Add yank feature
Message-ID: <de56059cb421282f60ec6e9e5a9ab823745e97c1.1596528468.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596528468.git.lukasstraub2@web.de>
References: <cover.1596528468.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xnp2/WaHU++tiHJ9fKN=75S";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:dG4H8LrPxo9gvV0K3JWJERG1ay+jx4IKXQ5xJcPwD4lnE+fEnkX
 OmnkNoFSsd2pkrSw3xp9tPzISSW/oUAkshI1Akx5CojK+HW9FEFqrVS8unYB+p7OQIDU0Fm
 Kibf9Kc2CJ8bpBhqFZZDHC95mvhPR4OvMByQWcvjV6MQApTN3ChNuiBPC+ERrnsdBVP3R+4
 ya2HssTgZ4OvD422lPlIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:507kZDaXBb4=:lFH1F9/xToxkJzTRAPiZ67
 rIYS0qRhIzgPcwU6Q35EXNZ6zqdV8fL11X0qV1Jl6JBqaaHxQM07Z6rfYK5nqKxciXd+r1OEz
 pL3I+VFoeSsivQvDLODEMPd2rGqVb2kAoE6tzAUqG5hzNA8xive5uPiylSRRiY69H6rqkepWP
 nd/7T+2JFRbIIy8PLuXfHpCKqBj0mRPC6VcHuVTTCchgjAZDgioKB7OJL9rDz5nhwB65uHkI0
 iR8M950v2VWbGXwpcIsk9jSHleMQkCyX52+G4CoPWKthqBY2wdpIGp5X+1A6hWQVbWH8aFKEF
 dtqszk+y7BClCAwiZTe5zE2ZvCnH/Tqu80syrf8lkm7hcmt7++VrpLsuSO2boq+bbZz+vEqO0
 Jde1m50hTZ1/qvyKnBf5aC1BxNd1ZeaZELSbGQ0o6czcE1MpkUKVlCKuNY6AcnYALWDhsN4Ec
 KLmGBLfEj0pNdDTnKcGnJGE/AvIO2sN9bigOnJl94qydtG2xp3YrJJbtZgaqlMFudHg6ILuzz
 M591oAHhn4oPvhkopCe8qgtgPbZbf4OWRwtNP8l/bmX/svXvITMTIZTRaoQAJa7Zb4+TF1ise
 SRXu4WkUVHS6/Ha3lHAFH/LSc92DlB/N/iut6BmCkre2lRftU3/ANX5YCogE8VXup8TazBlOB
 LsaXiemJ8Pri/j3GSEO0uP1WsBiJdZgIqvLkcdhlYrrKkTbsSTGDj9/lDssDXcfwD1mN8gxHR
 MNzeV6hW/mDhzchO7yN2wBqw0Gv1GCVdwEoGzdT5IBE1tsKhYSG/2ZGS88FmdJRbSrF0cFbBt
 hwID9Nft054XSWv6yRyBrg3MDKsVlEx6E7ekKGhncWHccIE41i+v93kff6HaCngGYChBKl+vC
 B6DYuMEOJIfMK208wuym4LZ+hsw6xYfJWRI+0JWkt9c+/1CKgvM26wBKSXGDRjv3j8wbjMtaK
 ycbjrIAOjTkQA1P0MT0oFl5q50ttY/RBxsv9vkcyO/hm0zybMXFrEfzcOKWB78vU8je7p6xlE
 b82N+h1pPovhqubxTWRkF1ESlyBaDF+j1MbJAvTbdczbtE+j7DMqncCgvCJCt8eYb1mtCTpIF
 7EV5OjvPSIZQYUifQQj1ERbiaI+fWFGVAEg456m3ADXuqQvwJSBxFiuLA7WlgGquFpluctevv
 nZHasVNetuxM1Octtzg6fg5uwrbG8edKO0hAeEeotlbmycyJ0VgI5fvFXnPgs3ll4+DMPSVk1
 to64bErWS1bKAz7dheOmkP3ezPCbjTw2OIsT0Zg==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 04:11:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/xnp2/WaHU++tiHJ9fKN=75S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register a yank function to shutdown the socket on yank.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
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


--Sig_/xnp2/WaHU++tiHJ9fKN=75S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pGD0ACgkQNasLKJxd
slgUtw/+NAYhDxh+VC2yclYFd2xPyH6AyjWjtq7ijG3mABZjBWh6yGC1IrhIZRYj
Z+G4HTAZimlTC/bJiso5oC6e8pMNELJPQ1RIhQU6wQsgtzNi4m93TVC/+xPKyaaS
3kG6wCjfPlDvyipn4/DNq294/dEFnKqb52+tWsysESCRk+OyvXShUN3Xho2PX8ad
9olVxL8oyDoqHxiWOAAWlmGZ2v3tuQGfOTHWViE99I7CgOwoBVJes0thNJVALd/T
9ejtqSlHfJwX3nlCxG88gNGGal3gZh3xtUTxhV1AgPvzYwiQu98kkjOoG/61x56q
4YUxJQGk5vBVvR+VX+Q3Mxjh5jGvykpxCCYPjznZN1iit4GLjF25EyNEk9VbU6yR
7FB1rQiQf4s13EyfxvBMncyyYb+muvjKgYNWCUGR7gNeJA5u9c3RgcSfAoKi6wJX
bqoOWoGOAd8hEZpukEb/Czl9C+CsU/Vj2WaBRXOwqwTimsT1Jfj9gf1fHQ3y/pwU
DomKSoopNKOgdeKB/CQ7KkGt/w2HW6f8aDm+ne0XJBdBKPctM12DAxzo8KYXgxW8
j6o+BJW6YsHHB5B3yNYOP4bCuMmcwStXW/V+4tBzW3/lKmSlFEiL+Sqc5fqKVQSN
zTQEZPLn7N2obWXHpW8b6lIcL5Es3/gl98bH97X1gI5j70hWIXQ=
=+Myq
-----END PGP SIGNATURE-----

--Sig_/xnp2/WaHU++tiHJ9fKN=75S--

