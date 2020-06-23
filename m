Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F4FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CE520723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="s41cefNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CE520723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkHw-0004go-2p
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8X-0003xF-LU; Tue, 23 Jun 2020 10:42:57 -0400
Received: from mout.web.de ([212.227.15.4]:52705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8V-0002Up-Qm; Tue, 23 Jun 2020 10:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592923370;
 bh=966MeEmCdBmXq5ZMscyj1lFFlNZ/TNvAh5y+/Tq5lgw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=s41cefNBPUc66kxALDo0Un4ry6SmtHq6HYikAkGo75s4WLKirege0MxzNQX19z6KF
 vIpJ3nQyqCmNhwfaVDI/WpdJXUn0I6jbrEB+NsHIXg5fJjDRk9F4MnVbr1Qt3Zk//1
 DFNavwI66gbiSDVv0P3fFjanw+ecsFlEg78bd9Xk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.8]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAMY6-1jgdeK1Rmc-00Bb35; Tue, 23
 Jun 2020 16:42:50 +0200
Date: Tue, 23 Jun 2020 16:42:48 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 3/7] chardev/char-socket.c: Add yank feature
Message-ID: <f98dad765c275daa6b822eba1ad27f8ca74b35d3.1592923201.git.lukasstraub2@web.de>
In-Reply-To: <cover.1592923201.git.lukasstraub2@web.de>
References: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oQU4cT/ewsXvRR5ZrO+RhVB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:JA0cV2yz/2bFiWBBpktQ57hqUazevxdqvYvJfOtkF4JGPd76AwL
 NV1xu+hp/dVNtxaeO0IKFPj2QBzogpB4Z6OojZrLBiV8p0eO9mvYvhsJGP2gZYhQBWylcbp
 0g5Cg+rD4jNMgDdgDR2HsAEgWE8nM4Ggb8qrBgvkCpaShOU5uckTarZrIviu4kJ5iAzchp3
 mEIX8pTslfEYrtRT4jpug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UsbjXQ65B/s=:nC/6YIdDm6mDm9GTvJEH6j
 ntNovQ91SUazUgIwmzmhrxaj0QISP1F/RowYMfyavs6hmTGSKqffh9HBSHebOBcZwxBPY51kk
 sPGWc5PZozCb2f5OMTWQzamSDYKitJDKzZnLLxzeUTmrBhLK5EMClmJ2YoG1pipj/t3Y1YG3E
 PAlOxzcZWaSHjFuNewZZ9GIIAqLLd4+rZ9ymw4t4OnldcuBS85uTRFsq/dYhw6H5W35cAFeVH
 5SExSkpQbXF7VoYJkhroolPnD5aqYkzuKBae0hIBVly2U8i3qqi9IDvG3zjBPh9pjGOWYsj4I
 QKi8H4aef2fimqo9KjZ1p3S7D2Dy/B4fBdWSlZz85vuiaQiSAy04I4iRMu0jNAxt7l2Vsq9H+
 ycQJ8HBvVl8h/UXWzz7/5RDQELSVxBWP0CWr4j7bRs30oWLaX1gIJvfFdo/rFwJ2cz3rt745X
 YHHQ9HL4QOte/anXvTQEYBcCKtk0v96lLW3814QjfIljqVkn5/V8Is3JoHuNpyfM/k+I8UVGI
 9tX3z6G10X0i/2shW7jnQSZLY7ylq6/FXicGGssQgGR3qCC1PoOdM31MehS7qipI3/w7s4alP
 ffvkQVQjrvYPRYqMVzHz18pJXi2cszht8YZsYlTQZpFN/dLBc17FkdrSPY/t2Iibs79enlPcI
 +oTjH9a1WXHWc7zna+feQz8LL8xUjEJGLPArpwrPSXBA36YwEJY273bOoyTDsWtSR72W18g0Q
 1vu0oYOhSVcj9JQdM6AmCRjZbLpRLvTdFSgz0LApkAPHxRMTKw02MnZNE6cAw+QdN41eV49oV
 +6dV8pyVA1eOgfgC549f8bLire5/OTQ29q6840MkwhqI7bRbtT+eoeWkvzRjlT+WvVPCWdgxl
 qpF8L6h3eo8Gk/O4J4btOijLAZof5I5/ahn96EmeFveQECEA4uCFRtId5qmCBTn+F6nljcFKb
 U2vd4JGvdwq17HxjzDrgvVjjuEsMIp2iMyDIHfgrsXaJ8Q2TibzfIkyCod0o1goKFMelwCcJ/
 la7QYZ4Oq7D00GWNzmEnZgCP2aVOQZLpmBqd7Rv5g3iEdcf7L3XX13+gksn7EO1+3u3ZRinxD
 TTfIaQSlAD+chy7sH7uRm2NZsmfOTnW7DXGpYJfHXRk4eWYUlE08R2zHVDPCCZRKFU38TZAF2
 CwptDMhLobDPYk6CVsnUcUMuBUe5ZxmrHfjQEvM+0nXvjtyK++XLW2rkJa1qGAhlfRLTPFprZ
 rQoxv1OKsEWAcTLAk
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 09:48:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

--Sig_/oQU4cT/ewsXvRR5ZrO+RhVB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register a yank function to shutdown the socket on yank.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 chardev/char-socket.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index afebeec5c3..4e7a7e9ae4 100644
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
@@ -411,6 +413,11 @@ static void tcp_chr_free_connection(Chardev *chr)

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
@@ -1070,6 +1085,8 @@ static void char_socket_finalize(Object *obj)
         object_unref(OBJECT(s->tls_creds));
     }
     g_free(s->tls_authz);
+    yank_unregister_instance(s->yank_name);
+    g_free(s->yank_name);

     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
@@ -1085,6 +1102,8 @@ static void qemu_chr_socket_connected(QIOTask *task, =
void *opaque)

     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
+        yank_unregister_function(s->yank_name, yank_generic_iochannel,
+                                 QIO_CHANNEL(sioc));
         check_report_connect_error(chr, err);
         error_free(err);
         goto cleanup;
@@ -1119,6 +1138,8 @@ static void tcp_chr_connect_client_async(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_channel_socket_new();
     tcp_chr_set_client_ioc_name(chr, sioc);
+    yank_register_function(s->yank_name, yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     /*
      * Normally code would use the qio_channel_socket_connect_async
      * method which uses a QIOTask + qio_task_set_error internally
@@ -1360,6 +1381,9 @@ static void qmp_chardev_open_socket(Chardev *chr,
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }

+    s->yank_name =3D g_strconcat("chardev:", chr->label, NULL);
+    yank_register_instance(s->yank_name);
+
     /* be isn't opened until we get a connection */
     *be_opened =3D false;

--
2.20.1


--Sig_/oQU4cT/ewsXvRR5ZrO+RhVB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7yFOgACgkQNasLKJxd
slikdxAAmOWv7fdTF83N4cbP/XbjZzDvY4kov2FIxASD01Upo86p4wH2CsZKwU3X
K6dwG8EQW8mtfzAQE1RZAneXqGSIx5r/BjULfZHA/x6x8YX9/Lu8+TncEzHRFOm3
djB7lMyS4kfJsuzhpOKT2irJi0HAowIOEkPc4UqrkOsZOWz5JAZI8c/tmJC3I8Cg
ozdsNujziZXAxOkdG2+JsV4ItSJliIAkCRGn3bNQLl5/5iNQmBsUcbqntVJWbiy6
qezedvwu2IACVmMo7fWidDR6quJhuy+xJmf25P0uzE4Ocp0pPh9Ym/MlxoxL1oBk
FUDq1OewJ2a9xiTt1LSvGpsYsQsrxmR/WU5aT6x/sNACqqgi/mdABoTXMPXA9vZc
tlbNkDAdFsXMKVV21tztcmQDNipAbrTNIxxAcWwC4f23+r+pVeYqKYkflahiBwWr
gSgVCFFwdUUrSctWidYTfqRkcyq1MGmAObNt8nycVNx88rLcjCXeXxUwn3DwLleT
WIqXVxvz1JjW+kNNl5idC5VtVczvA1uxn4BgZco+Db8SPKxcn7FEztRkjB/kcxdk
+zkmebCMyoDJwE62Y70cDg8Y1mpk4EWyRYaXzBijX4CvJnwOkmtobZE2LPMnbdB+
1BpiAe/cgXMn0dBiBQ5BjOMyhc2ue9DJRQnz5aSe/TMCdmiD2GA=
=/Yl6
-----END PGP SIGNATURE-----

--Sig_/oQU4cT/ewsXvRR5ZrO+RhVB--

