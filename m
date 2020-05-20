Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5DDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C018207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RWPpcALT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C018207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVy6-0004Va-EJ
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuV-0002Lp-6R; Wed, 20 May 2020 17:05:55 -0400
Received: from mout.web.de ([212.227.17.11]:44687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuU-0002Se-7K; Wed, 20 May 2020 17:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590008748;
 bh=sDjR+yB4Sa8Fjus9eFBoA6y68LMtxEpQOMPCGsUwKO4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=RWPpcALTQ2rbUoui3GrM5Vtt2XrhGw6OC0cKUSRIA1IWgsHntBOQPQxRcRhN4anOS
 +KbeLr7Ul8ntS3AX0X2QI/KaQEhe84YMQdk3sV6c4mlyhATrhFX+ubHC3c7OUU5UgH
 3PGXJBnhVXXeDdV7BoXkMrbP8bmFmPuswHx19rf4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDdyH-1jjWW31eIp-00ArTE; Wed, 20
 May 2020 23:05:48 +0200
Date: Wed, 20 May 2020 23:05:47 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 3/4] chardev/char-socket.c: Add yank feature
Message-ID: <ff403c057f94c1c12b4bb1eb2bca6f8fa960a07c.1590008051.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590008051.git.lukasstraub2@web.de>
References: <cover.1590008051.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.DRYzL7/KAOmkFE.quhPpyn";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:DHrEwcV8UvTN1AYvO9yej2jPOHHiEVQkm8UNKmXMdX5YpBuOyxC
 QEIJ4rDBv0mxmXqIFn3REfGFX0owMfYrJ4PwwY7wcouz2xubB0QK4gNOe2uovnkWiXYHZej
 FWmcq2uE75wNo5BNcOlBo2Rlmu/ggTo3AhWV90VScaaxvY7AvO5b9/kMhILmzhde3FlB7KM
 /uXRCpwPnHOYn/kt/drNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O1KCSz03cNA=:xZpjl4gq2AkDVxZ3/Go0Li
 czSRpZhhwSBOp4c+8Zd5rw3wSasn5q8eQ+DJlD3X+baWOwncUts8dSCaHZILSQG1HHDG5lBus
 lPAR0XQDT+2x2Pv6hqkN1ogrH39zlLmArDTPieehn7/MZhlLgBntnAN6WWxwn7Zjh1f4StKM4
 0dHF5R8oI7tl/ehq5oqf8hpFDudeQukgoFgY4qr64atizx4m722WgGfvetaX9bDgpSUNWZqDS
 mgJffGS0js+hCf3TwuEn9Cx0lriEIXbhgJnNHtAIU88/npUoB4pryNcabkX+8eIejA9vvQvu9
 KTsHTSYN/oXCU/+C+fYWCNtjuk7cHYs+FYNr3Cc9IfAAOk4Gvj+H5Xpi3tPL0qTJnaB1YfIwZ
 DLf8PvzugqoSSu2HACHd71Wt3/BkyB9vdAJgn69JwHpSNio4KF+k3k0tLb+HHVcvaUXtcGXmh
 UEKBufLUhytgYjMTQoQo89vyEOKfqf8IKps8U4+HDg2kJqI7co3U+AkK7gImdjVylNC6IcvDw
 D/g4R4KislMc/DFLHKuo13YivcpBEkt2nrnacpJhobAQntvwzjSW4/O3cFc8Y8fK5ZPcG1HPi
 WXmCZvQLrxu8C9VZp72z8hnVhMosYKEsPM+iyumz7kxc0tsZmCIu7Nu63dzwAqZeK1QVJjDo1
 /5DIwyhMwgjd86zPQn8V1Ewi+ZXs/lJw5meIfwMMKdFnCLIlHeu4ffLPTrwxdfSm17Q5xZELK
 hN5cO6ZvpRFaw0htjx0QFVDDgJwiK9olke2bNXe3riJ4FFPew5W1Wd7KCqq147+Si3Wj8AhFm
 UDYRejWK+AP0j6vlZNpzyrLA5Qgubk+Yu4Pe25bPXAuuM1FhwKilpM9WEcvJOfjsaiz9mm2Nv
 fqU665foznaz3LH6T4fhCDz3JrxhPm8gC2SVSVYJIABM+YIaT1yMCKeGfkRLJ9VNAWua9GGnf
 2zn7WUUWCsze6o6G8yLh5ajiHgJ2nBDng1AvmBI2CrKybl5NwqrJUaNAm2snrxoiaAcA/aC5g
 ahgm5z3c/5W6rQY2YBWobz4pcj2VOIzYa9ntLRWHxWa8qBcVoF31w/OP51KrD8kDvnPYucsO2
 wjFATZjZqE0THhJbaWqORiMfKborIPu/xDXucsF5l3n7Tiuw4y/ryGzwCSb1pgQP4vdqsEnDZ
 5CviqN+5KmR31DvogRybENn3ap9GaAB46hr0X2uIVj1uYvSUolL0A6uYr45K0t51zqnVxTFFQ
 9xcGNB/ej+UpzEvJL
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:25
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

--Sig_/.DRYzL7/KAOmkFE.quhPpyn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register a yank function to shutdown the socket on yank.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 chardev/char-socket.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

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


--Sig_/.DRYzL7/KAOmkFE.quhPpyn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7Fm6sACgkQNasLKJxd
slhpOA//R1ENpCDrMNJcXxuAiDWCREdRVzeAVEC9SgZWIE7Je3gwluHnnLWI4tRX
u7ogSuwR8daQlBFg2G/SPuqkUluH5Vax5lpKopmWOMyTBWHiB7Q9GprmwG8rXZQv
zRlJVLiucxlsuVVFUB6vCGH92Ubgx2jJFuneTxqY9gqamZ2CdkJKTZEum2KKlZdC
O58Wwp5mRx1XQeJXeVTJb5+DQafuLA0va+9rYIOpkz7b86mdUJDME9MtjCvYhOnk
t45eXsZunzlgc+7gbps7iYZFMz3tnSm3UzW32K4yC87UnidRoffzoPEFCHdOFSfR
XI4e9QztMSy7oum9Ep2XrmfyE7t1bFGH8gkzLvPjcjJKGc5bFJzq60+J+lcJZ1ER
TrzgLzt8K8mn3jfDwXbIXozdCsQOljdCF/JMOhYHqtnYwt8Ms8jYzXUYUrVDps+g
NEhrLE3zGPi54kPcCkJ45cRpVIsUN8ZLVoQoL6Z1Q3T9BpH/gIEZziT+WA0lKTEK
c0p+f9LCWlmS5ZPY59WNuGxAgs8CHEz3ajaXP6opGDVyMYNEFdwL7+HJ/tNsy3G9
brkPOV83l+Rir5joDchhJiGEZMTDKzDuT0c4l4/n89sFHSfQQ8tZVDH/OwOXGWO+
0TdwZRoGxBeq9pfBotdtacb8dTMXspKdGmWCEd4DDNLVd3OwHGw=
=+kCK
-----END PGP SIGNATURE-----

--Sig_/.DRYzL7/KAOmkFE.quhPpyn--

