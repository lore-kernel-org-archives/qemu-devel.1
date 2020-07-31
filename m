Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B94AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C3020829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mAHkGzuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C3020829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RSX-0005By-Dq
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJS-0007fq-KP; Fri, 31 Jul 2020 05:26:50 -0400
Received: from mout.web.de ([212.227.15.3]:53807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJQ-0003Gk-P7; Fri, 31 Jul 2020 05:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187603;
 bh=Y55RT1Puo45w6Y+NNfi0kCvRF0dtXGvI+GyKGpQgDuI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=mAHkGzuhXofkypUc7/XjNaRg541socihF1WwHU1vRW2jnOMr9bALqbYKdi4fXU1RM
 FyVVEQe8xcuOSdeZb6r9omX6bOJsTJcvAqC88q2crtNN4fsABOAOJK47UFIWDs5JsJ
 4jADwic2bkS4qLyeYiaYKOzwXFsc1X60d0ptjnO8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfzgJ-1kXSkS0bPP-00peH3; Fri, 31
 Jul 2020 11:26:43 +0200
Date: Fri, 31 Jul 2020 11:26:41 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 3/9] chardev/char-socket.c: Add yank feature
Message-ID: <6c504d77050ff2f944349f98c4573f388145969b.1596184200.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596184200.git.lukasstraub2@web.de>
References: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+zyezhABBCdjSa/VP8F.T=C";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:yBLacbn3lFKMc3KzTt5HeRK54fyw4cNb+ZqAjqo9WTWV53c42rG
 ZOmzguwacuRymgJlE71sjCTP/9lJISLSobRhyF4AHdR9R+8drfrUUOgyOagwnQ4c0glMdDU
 1bHB/kNUMlJlHX35eB214DIOWuw7R0ibPVoBHgh80N40rMM7aG8LfUIhU2nZ4vdUrivmLwh
 4OvR97hgJJ475L9vXM7ZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h4E64QrEYh0=:a+AM15jRaeJrP+/AlkA37l
 XITJInmmtOtXrcHVi5moWF6omKBEx/xaEBmzyONtqa71cTqyf0Ikl3cl170cEXagW4XyX1pNo
 pDwgQ5T02QTM/2HdT/SLpu1aSY0/T2PrJEiwLyKeY4KPOSOLasUve7NJlaLNLbsq0lAW/lV9W
 nCip4+aoAM525UrUYQdhMqhpRH89lBzZ/sZWjyWdApo+AoP1qZpiDUPbOWm7fh5Bxs+MPZfsp
 nKbAFX9eM5C0SrWGFsyJb9A1Awp6swmyOMmof14DX+tMFPqdsmvXSmqUKviDMJojdu/DU3MXQ
 KmlyQClONz6ksg7EDju3hxHpoij01cHI57bAATipF9ngjFcgedKaLDVLaql9+tz0XUk904FF5
 /R/l98b/f43ibdJX3KKwL99I+X44S1DRM3DuK/E+V0M0CT1uMp0JYEdQzwh29dCoEQRXzpj9v
 B1MQpPKmMNg+J6GE5JAw7hfwxSF2HDA0MxhZ1IYDb4G3hj7pIAIL0uqikXz/2J/IOJE/qrtzU
 kyW9FKsJOYscJ2zAV+C2AKC3jYFdLgBaxe/+Mfe5R5wXr+1gUlKtmn81sRO0T4madXDh7ebN2
 IdKsmOfypdAdXZUtsNW5X6TjQ1pxXvlzEo1/dH+qsWSvpg6/KR38bb1xd4FW7WtNbSvWzrXyI
 pQf4VSvoC1/gEXoeMcuAQ1p97xFZc4/NFGzZBMjXcKYxoIVA23iKAdZiQJw4MDUUGHN+QgQGD
 n8Qv5mWMS8Sab1gsNSjT/oFomVsRdFH4kkKv6vdFXrLgJrFtXLixRAC0sIz0LHK5J/qAeV3n4
 zxjDYwP88WLmkC6TokcuSA5Bf14oCo8l8fOYPVrmqout7jPL+xwWbNO4cpdXnIpgZyZ5Zv6j9
 6d6QWpMvcBt0Tk7deuMA2E1oFfaYtJMZxtsqYy0AECaiIDFv3PTVFZPOxGjN/W+Wbsca6DuOs
 bcWRmlmzJljc4L+usSQJnCk4Kic3drzzMf9yAILhrXF4VCKqWwwiAnw3T1zILNLTY/1AvFNYx
 GrWAjQRD89XlhkzggO1tzoJM8311bJDP1f2THGQaICW9zoxniuCHCUeoi4ApUok5W8Kdj1idf
 F0jGQHj5mU82J0wnZAmHnlDmdDtlC1suSQmivJKmTUJy+0dwCEfdWU86c5PQSY7ERqqbvDJ1c
 jP/Ei6cLBjPz3fuYC9JqDP7Cq/p1bQQpKfGSKlaPVPN6EH3lTROWZd1CynXka3Qt/rjT1UTQu
 UkBOfTL72UmT66sEUsgUP6q/DIr90HROin59FWQ==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:10:35
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

--Sig_/+zyezhABBCdjSa/VP8F.T=C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Register a yank function to shutdown the socket on yank.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 chardev/char-socket.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ef62dbf3d7..c0ce4dc606 100644
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
         goto cleanup;
     }
@@ -1118,6 +1137,8 @@ static void tcp_chr_connect_client_async(Chardev *chr)
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


--Sig_/+zyezhABBCdjSa/VP8F.T=C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j49EACgkQNasLKJxd
slhgXw//YiBxx/GIuAl44nDO28Qt3n3pRPHs5ZPdO1uumpecrWgtLpmAOObbLBi/
kjXetxguFw+39/C7DLBjMuXq9HsN7v8uA7eLL5pf8iGkSOPMw/0zAfDuOySY1iqs
A4rA9akeVC62e1eWYg8l5aNNmZFBuGY2LupxmSxMzLTvQBieILYwkDIOOJDG7q1d
4AUc3r8/KtbyN2ylrt3TImkkA49PP9NBt+6Swdmwwk0r8np+NJDv+plEGNuPRpj0
+XIKjGC47iCZkex/7pwilQEIINqCQDucWBtgEUALS0FDl9xKqIUbDJYYTruRDhAP
1tA/zJ8MofuC3BxFOm0IRU77i1duk9q1RtSswv0DblA+zGVMLDpA5YtCK9+vvLfF
1HC66qz9z8pl0gwaqR2joHe30dNHv7GLe5RVFfpfbn89hwkTQn2H9fJAuRo/yNgJ
2En8hJNdWEdeqGWhKn5J55r087D7GR1qrfnaSbBSt1xvre7i+HQykl7MlkLk9D1j
xnUd825R296WBt+cNzEJhr13hK0JOuejgGCO3jESu0Pph6FsOUoks03nezFfsBM+
OCRsJGkAZYA3ut2RusFpWuDbVnN1jwxXENJF2NCvmw1HRBVFI3enAwx1f/HxIsYN
k8/QPNu94dVdS6pLWCHFsNg5jF1GHu7VA0g5YQUWmLqx1EafS4E=
=SWXH
-----END PGP SIGNATURE-----

--Sig_/+zyezhABBCdjSa/VP8F.T=C--

