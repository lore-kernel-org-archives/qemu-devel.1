Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BFFC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA2220787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DlLFCDWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA2220787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcvUd-0003Bm-3O
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 14:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvPG-0008Cz-2t; Sun, 24 May 2020 14:31:30 -0400
Received: from mout.web.de ([212.227.15.14]:46561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvPB-0006U2-AL; Sun, 24 May 2020 14:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590345079;
 bh=fLYzf2F8wnaTovtphVpUv0gbKjiN2QoyW9YUN9gfPYI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=DlLFCDWAcxT0BnkdWxdbWXnvVmEw1U8Q/GwwgOE0si5AREE4t8PnCNsilbHCAttDA
 xewjs8lMgTb2kqv/I9nop9e+O0IswraB1530UJPVoifIF8/xFf6r/MJD9tG136e8Iv
 AMzzppq9jzdBAhVVXYYLVbpPH+cLSFf/uz99VWCg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.42]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKJAE-1jdTMn1JaA-001ivB; Sun, 24
 May 2020 20:31:19 +0200
Date: Sun, 24 May 2020 20:31:17 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 3/4] chardev/char-socket.c: Add yank feature
Message-ID: <f513f9d9f329ca3a87a6e0aabe2f66f0775c1d6f.1590344541.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590344541.git.lukasstraub2@web.de>
References: <cover.1590344541.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3dUW0fNNjA4dKmcqu7ZQgXI";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:4URxPNh+ZnLePpm4Ak6csq4RN1keqS/nxPX84HMEZT0bRARdDCi
 Mb7Wq3Z5kHzZziVKdybUjbk+aE4nAbUjbIshGdXzE4cXHbo+I4kzd3BwW5DEOfBhSwMRWsD
 Wra+BOW2jyqNZK2jZQTVUrh8cMsW9XQoICrsMJtfo5I7nZTXy1ZJn91HyWtrDbdC2/tYQCf
 bDwgCMd0EIFjFp9yOj/vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A9kqLo+EwDw=:ZHFjfyIuVpflSrSbXR9e0/
 dOxENVao30hOGZJbqvCyOtxLnyw6O9oMgVXnYA0N3Y7XTpy23cSjHt1aOvsiOJiD1MtWZj7/T
 yUilGCMRFOMT6uHuxlBYbJCqDy5fJu6UbXcikSxcT+Cu5sA8c88tRcSp+1rkHvc4GkPpWQQOZ
 It8f1wQVAeTbUCVbCDZrzHPSqcRYz+dGYfvZjKWkUQe6sgzbWvgTrMYjvPua9/+NoNKYBUWMK
 XU+l9tggxVKTxlQxSUv/HgEKAdRh1TgbrmZn1TxgHg8j5g0T0wH9MqQWU5/vQsml1h3fQFhJM
 AgncmDfdfJ9cbDs5Sktwdd5crjIyIcEHUfx1OlWzgxrlvJ6BfQFpYerw9bwdxVJ/AvXc5J2Z4
 YE8iFULmA2farqFg7oswBpiwv2g0gIVV3nzf3X17tlFj/yABX2E7TVjcsxccomNTuvZwrULv+
 SLQuGdZS2E4Enhc863LoQbrBZJ48it+50oRhSheT5cHjXQL9wOXPbiAXVFH/h8AB8eSYc636m
 K79cU2OQNhvVbt7svFBxbIQBNorzG3hZE+BSZ1sMGlO3OaAKlKnvBOgniNIId7RnPXFAb4qmg
 G6ORo8OJahIxFznyBQ9o7FGdh6n7HQelQqmiboc64KLM9M80e0UhqX9CbFrPxcYQTWFuxRVWQ
 vRpnj7D3gB3DBmcNcpFFeyFegp5r/pTVzzmG0o6B+ZguI1OvS9hlA48O8yq8QRZXTSxPEmTJU
 AZejQrkIrc2DLRZTo0FPXnPWb9hT0VJvGQMERHMWY/OcwwAw7sYvMla8N9Lc9SdXssn7mxRci
 IUjWOLQqm5GQG62F+ukkOcezdgHBYYtoILlOS/1gHgwkUWcNlkMr87o1MRhkInAbj0D78MIaC
 Ee8OajLwHXyK5NI1jlD5eD4mvTPIbrB3Phr/I0oP+i4LA3VMpDsJIQpa4A+u3Pzodn6+bIQ/y
 o4AfeHRFbkS+FuVhvl1IwXPGLPQ8FT+Cv68LAXduuZ/z2xA6Ix7yUx/VhDYsygvRs6IjcutPj
 3pn/0mGzz0fjypTeYEur48+fYBCmsHjmWZPD7K5NPXBEzRM0p7OJPB5IVo5PfT8NrQeCGXv70
 v2/+ShrjD33ruxNmJ/UdnuKE066ABhTXgiJann0Hg1LWwHNRJZjlEyZ1G6bQmOMEFEQdGADB+
 365DO229H1a/GA4dqguuA0Of/YINegG2mSnr9lCgrH7fv/YOZrcj6rxMHzvEYB/l2CV7M3PSP
 4XrZQoUF7UrkvZV1t
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 14:31:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/3dUW0fNNjA4dKmcqu7ZQgXI
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


--Sig_/3dUW0fNNjA4dKmcqu7ZQgXI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7KvXUACgkQNasLKJxd
sljQrA/+P3UH8rHpKBU1s9XL51FfL96CxSInsbAM5t3KIaPupm16lW8/xMq8ZlIv
YsUdL03eP4T7bwWaV3WuiKdF93taEeARDn69EteZbEGKU9mv0VPybZGRGbH7BsqG
Vg/iBMDCFfxTy/C8k+/v0v8/lJ7jQuna04WNn+cNw4oXh5qRGp1Dyj8pR4awnDG+
Ly7Wsk4vlSfSXIegby6zqeFEgy2BNxC5bOyAkUdzXw/dLJ/umL1ROydxfk9Xemws
f80JVwLN2LmaqA1U3JIxhRJXvgGgGxUnqgYsIUosMWh3bZSnYxa0UWFX/SCp3fJN
LajWp3WNOGsNcDYkIAvMUQ4PkM6Qxy4xxaevzklWBZDejvIYndI8BUamUao10TA2
aZQPv+zw31QruEzgMEC/tYToWeXXKa2ZnhSL/V/+6FwIA10A7o/rH0zigcqUf48V
c7ZrChM2bvM9dBx5F8w8ouXhkMeW3ybzE0PtsJVGgVZHcNr/z31PQcn0F0ZuD9Cs
fQepKaIcJDhElMZanlEUzNzgraeCw6H7ZxMAq8ldBKw0RjuHVI92gmquiSgGAkJK
mtUkVGU1J9sSozUj5/nhiv/qrCSoRhAHjuNnkO1KVm3N1hmHvsKtgqktgbQW9FbF
Ccex2uLnuQzRJI+Wf53znL2tV9coQA35p2//kPxrwARxTYdK4k4=
=kLCv
-----END PGP SIGNATURE-----

--Sig_/3dUW0fNNjA4dKmcqu7ZQgXI--

