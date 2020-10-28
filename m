Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F23C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA2A24810
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="I9qDsrFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA2A24810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqXT-0005Nf-CL
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqRz-0000A4-Ab; Wed, 28 Oct 2020 14:45:35 -0400
Received: from mout.web.de ([212.227.15.14]:36211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqRx-0003H2-1K; Wed, 28 Oct 2020 14:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603910727;
 bh=wTPWPv0O9og9MhcjtUCWN563ETwPiVJdFxQBrN5ctTY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=I9qDsrFDli5s9FQmdMTgwsCi51MWSgANimoQ3hTWvrtgas/77WE4DFVZ1Ik4Dr23+
 AS7dMBZT9S4NpBujzhZoX66s85f1udDHc55Hkn2vB0zjWhB80x7NL3ADWpYr7f4176
 7chcIVezaDXlUyTuXvo5AQsGOqCdtGF3ye2FrI9o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.124]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPHFI-1kTQbW3gMi-004VPN; Wed, 28
 Oct 2020 19:45:26 +0100
Date: Wed, 28 Oct 2020 19:45:25 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v9 3/8] chardev/char-socket.c: Add yank feature
Message-ID: <36cd86dc7ee9ce7a95562e5ba4d990db176f9cfd.1603909658.git.lukasstraub2@web.de>
In-Reply-To: <cover.1603909658.git.lukasstraub2@web.de>
References: <cover.1603909658.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/52YmmXZ_s4O488_Ozaz.paR";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:zVAgFhZg9M4yaT6Cr8sp5Lri29Wm582jv4nBZr5JA6xQyG+stzs
 ZOO6Y948qqMG84gBpKpsNtBkEHkVfPblyM5B3QZfQItiRCaKNS2/qv7T66gvMHFAL+7n5vI
 7O5nOoJXshY+GzTThq2ASn3nbg80/TPpxEMv5yhB5mgNdXjEJDGrLJt/JLVQyXcKkWTqdMa
 wqTVSgiToOBlh9pw1Y6sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iCKUJAZipsk=:2WBoTBDDHSGad6N/qWe6EY
 y8RCWTMlMvdk7YXXJYbfbEAougDl0OmxjsGk6HLCJvUTK8jJJIP3GWWSujRLDZtQmSYZuT89u
 r/vWH6oVr0lHI9zoPLaKMTVlc/izDZL7/dKSORAs7GADaNfQ14V3tjihJKqRefPPV1KTU0cxd
 nEqsrwvI1DH5L3sbe/3pazC7QVZqQhiqkmSD7NpNhisvbfmp0E6DlMnS94Gyp+9BccGeg/8Ho
 U9MUF+U3xhuii+k9B/vdZBC63zOo1C9MInxb5ewm1CpURiHiYQitrmKYGzshbSxKdmPlYBWgA
 xzlOCDbYOTtf1VsnHwKEqTJaeVSY/DISxTJl3dDuH1cYFkSIo+bg5aQvK39iUa62GF1p4LdTg
 zvhjPZAzgRzE1hQYK6av0tyRlmpe0GcBIO45DCW1+gBJvIJjl7KbM+Vq6R9DnjyOGm4Wega5l
 MkOf6uyGE3KrBryU17YZZBGH/Blo1Vxe4SsJ7z4zIIyrSJm2kAQeqUZ7ofPldOIWUbkLeUvBP
 7gkQJgfPZ3Tfs8sJk7kOhDuG573pPtynZ/6DVzELnPHtiq8nhKJwknBHrz3pQsU8kP3Ok3jWn
 8AInwwlkuVEYf16sL/SvCFyHNU19wmqwzFl1lNJohHnolwIR6FcASgQyUXM2OGsIE7YW6APQS
 SvMWgpnRcOx5xASk+4GNprUTisZAX8axJ2btp1ywdzs06S/HyMl/AJ8fA/V6TKfDb7ZGLXqRH
 XLL8L3YQ8Qaqf4xUt8i1HzqcNGboleEo5gsSSY1KnNORc7kj6JKIkoCGoHYfyKJcl0kUG+mv9
 X3rTUFzJfM/UEXQeEc0bRgGOIrDJTMwN1zYmcjOHI4VPUpVJThWu2o2jDrsoGBPxV/Va500PP
 jkwIWxlVyCGV3Jwxsivg==
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 14:45:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

--Sig_/52YmmXZ_s4O488_Ozaz.paR
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


--Sig_/52YmmXZ_s4O488_Ozaz.paR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+ZvEUACgkQNasLKJxd
slhGCA/5AeV1MBa7x3hqkM+kqYv0lYCWeP6TsQr95JjGiwJFJgLsvLBAdMV9zde8
1Kuyyz0xWoc99258J3UT63A7OH1DI9/DK5tbrHQylWRTB7cFlqqdLfn4VI8J1Irg
gqPiB7Qd+BRZEvZLOBYziZrE37JGyZpyLvUxh01ypqtN4m+803X1OqX0BQxDgpNz
vE5ZFWgjsXHNjzBPaKGueFrf8GAx8xWZFu5Smf/m/9byetxX28YlBTklBr9WLJhE
RvjiFC9u44z3/YBiNiKPjzbAfFWrbWbHLF3S3UsD/8+ij32aTeTt2EJy8yypPmif
z0bIFJa6BQc+Ago/kk3BxWaeEzW4GMldzvrz4p/FKX0dHy7Fsen+RWzWvUZwurj6
Bkh4NJZVO5IJ6mPGdEk6DdDOLDBg2YAAl9vXQNFhkwxEAlFLMbs9JobOzExREb+k
Q3yHGIMz4YLe6iJ496vnh3o6aVZLjG7ganFDinbum9OUua7SmDP53+thOUrgmRwb
XMUx2p9Z6jVHOMlxdSdYvlpYwfHeGIhqYDFyHY7Dwy81LEUcbPVj0A3UfZPcqSQ5
3/O8uS361pa9tsGBTeyieDe7qfBUO6WZuu4Ccp5TcImUd/9UJJTgte7xT0JbVjIf
ql1W+1poZneiEUk4QujFrYVa9en8ov8zREOfUW2P4BKoP15Qt30=
=D7Pd
-----END PGP SIGNATURE-----

--Sig_/52YmmXZ_s4O488_Ozaz.paR--

