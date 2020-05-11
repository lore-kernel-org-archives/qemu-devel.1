Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C40C54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567C5208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="OnZ4+5Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567C5208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6Yq-0008E1-C5
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Od-0000i3-G9; Mon, 11 May 2020 07:14:55 -0400
Received: from mout.web.de ([212.227.15.14]:37697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Oc-0006ti-Hw; Mon, 11 May 2020 07:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195688;
 bh=ox7FrQlIDpodo9cR+t+IPZpwtzB7Qs5pOwi+y4G35M0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=OnZ4+5ZqLtFFJ9bQcOkXe6xYdkNM80rywQvGir9YO9Loqjn4fjAxKzlX+IEPs/O3j
 mt9kflmw8Bjwd6J2IXAdrdh7jIQQgiVkKswvdtDzlyZHTTMpvZ5XECcM5//a6FN+Iu
 1UhJklww41YGWfyadW7u851Jczij1bqbWYOhqo7E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfzcB-1ijs4B3Adv-00pgGC; Mon, 11
 May 2020 13:14:48 +0200
Date: Mon, 11 May 2020 13:14:47 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 4/5] chardev/char-socket.c: Add yank feature
Message-ID: <7f87fcd9be3cedfe0410c151de2bf4e5d907b1e2.1589193717.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193717.git.lukasstraub2@web.de>
References: <cover.1589193717.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oQzx6d5Nk2.gRvD_d/mV1E.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:0wT0tdxCVau8z0N6eYdSpqwC5zAcYrOZroPKp2QhXq3kpCeF8cG
 oGhyLcx4nw0trtcn43p7I5gR8QvRsspNvDE264Y2USE8upIFEvOpyP7u+wXw7x5J9q/7Okc
 Oqc+jMRUYoKc/pYBAZhW1rpH1lh5LfpBthTy4M+cg9soqaD3bTjjg0tmSqWn4bIOw6L+5nS
 j3JAMN+2Tks7+aeXoC+0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u/mYSBWGa1A=:V866AMqLzcEYkIHs2en4Yj
 UIEiw7bxXvUgPvL4Tzl9n7T7elfb30P9gs2GVxPJllz9UxalZIsqmc5pFkp5N9iMqORiwBInF
 FTrYLyfWqLm1RHBNQsjMGDRW9Rku9lDkAnqdTeth7TyyypL/XoEsV5OdSM0Mn6lmZPP+QI1pT
 TRoSwiKjKJvT6DO7M9TpM57P7EuMWF6r5AxFLpqNNCAryGwqyn2hFb0oUjBvaJyypu9mr8f37
 T1Q6wRPmzJmUMF1f+rTb8rLHt3BcwPDsYLyk2JS8v5cxub0dw96kUA66Av9q5+RaYFa+88wB8
 owayfvWWVWAOfAYTWVNyD5R18nJ9YMgDkEwpHAk592qBoZ/zE0oIHgIsHFJRqqFF0MwQR8a1k
 /2hjj/DS305a+5yaznSs0Ax/hk4950fcHhgGGIWw2ywZyt21R40IPewfAOFRiUC1DwQXx9oV6
 Dyzj5+5Vl4KWX6ax9OOiquDokANX7CO8K7EKpK/7ZqEHQAJLEEhaufBhPJEFFOin2xrCkKtAl
 ynx27C3jjTRf9ZcTxAyUAJQ626SH4H7YnMVNn+o25Zrl7HiH04zda1aaAL+OUWb/+rOSY9i+g
 RvDmLgbMZNOSX4fpy2v9Z8ljPDGng57vNFFhNZodNeDhfJSwZjaXQdCgI780xbaDzPAMO4c2i
 iqo17owBX27wAKu82AwqRBvuV9I8JhSwekr7gctRYrac/F/Lpy9N0v/I8kOV36vcbWPxObl4Q
 r5trFmBlOAc7yz5dGS5q3PDWMQlxhvvyuMAv8FpNEUmesdyVq7DTn8srASkbs5ybTJ1l25/jU
 yswgr/QufQV2ESAySpzLiE5A5CtCO9xxxwlxQyk7H/dpFqMTEQq9ulIlnDBAABHSWVFrw9X1o
 N06NSs39GRCeP6MlpSlLyJgxVYYxD2SSnEndK1SFDJuNbjJc+JuqgN7DRBx3XQYOZqgCtphjw
 VRus+skV9DzZrY2hz4Im7KLCTtLW8OVe5MVGpdCTrDr2+Ogs25a5Rr65jp9gd1MV4ATkhXalm
 brgnVZVFgfGzHX3WNQ/bXvL/XQO4z3GFiWBwoCcKe5JV9vXFR7yi/t8d/8s8Ios6zAKNkY5vU
 0sD4xR4ef6TFP1OQCLwGSUQbmABYVKfab8LC5ZVeLH5ZDpr5aXTCNpvJEBYnHjtyrOQznvBug
 rfa7CB+5o1UoCwIHsthELyPKYnvnOBg+pLeNcs+095uKEVmj8sHomHuZudei3X2rx5zROW/ZY
 gCgelDymDVQprt+ry
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:10:54
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

--Sig_/oQzx6d5Nk2.gRvD_d/mV1E.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Add yank option which is passed to the socket-channel.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 chardev/char-socket.c | 8 ++++++++
 chardev/char.c        | 3 +++
 qapi/char.json        | 5 ++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda..e476358941 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -65,6 +65,7 @@ typedef struct {
     int max_size;
     int do_telnetopt;
     int do_nodelay;
+    int do_yank;
     int *read_msgfds;
     size_t read_msgfds_num;
     int *write_msgfds;
@@ -877,6 +878,9 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelS=
ocket *sioc)
     if (s->do_nodelay) {
         qio_channel_set_delay(s->ioc, false);
     }
+    if (s->do_yank) {
+        qio_channel_set_yank(s->ioc, true);
+    }
     if (s->listener) {
         qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
                                               NULL, chr->gcontext);
@@ -1297,6 +1301,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     ChardevSocket *sock =3D backend->u.socket.data;
     bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : false;
+    bool do_yank        =3D sock->has_yank    ? sock->yank    : false;
     bool is_listen      =3D sock->has_server  ? sock->server  : true;
     bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
     bool is_tn3270      =3D sock->has_tn3270  ? sock->tn3270  : false;
@@ -1310,6 +1315,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->is_tn3270 =3D is_tn3270;
     s->is_websock =3D is_websock;
     s->do_nodelay =3D do_nodelay;
+    s->do_yank =3D do_yank;
     if (sock->tls_creds) {
         Object *creds;
         creds =3D object_resolve_path_component(
@@ -1400,6 +1406,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, Cha=
rdevBackend *backend,
=20
     sock->has_nodelay =3D qemu_opt_get(opts, "delay");
     sock->nodelay =3D !qemu_opt_get_bool(opts, "delay", true);
+    sock->has_yank =3D qemu_opt_get(opts, "yank");
+    sock->yank =3D qemu_opt_get_bool(opts, "yank", false);
     /*
      * We have different default to QMP for 'server', hence
      * we can't just check for existence of 'server'
diff --git a/chardev/char.c b/chardev/char.c
index e77564060d..04075389bf 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -939,6 +939,9 @@ QemuOptsList qemu_chardev_opts =3D {
         },{
             .name =3D "logappend",
             .type =3D QEMU_OPT_BOOL,
+        },{
+            .name =3D "yank",
+            .type =3D QEMU_OPT_BOOL,
         },
         { /* end of list */ }
     },
diff --git a/qapi/char.json b/qapi/char.json
index daceb20f84..f9c04e720c 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -270,6 +270,8 @@
 #             then attempt a reconnect after the given number of seconds.
 #             Setting this to zero disables this function. (default: 0)
 #             (Since: 2.2)
+# @yank: Shutdown the socket when the 'yank' qmp command is executed.
+#        (Since: 5.1)
 #
 # Since: 1.4
 ##
@@ -283,7 +285,8 @@
             '*telnet': 'bool',
             '*tn3270': 'bool',
             '*websocket': 'bool',
-            '*reconnect': 'int' },
+            '*reconnect': 'int',
+            '*yank': 'bool' },
   'base': 'ChardevCommon' }
=20
 ##
--=20
2.20.1


--Sig_/oQzx6d5Nk2.gRvD_d/mV1E.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65M6cACgkQNasLKJxd
sliFAg//YyalI54Fj8NyBm0Irs3WorpvvGdQ+OnevRLWD0hYvfia8b5uU4Az4u0O
xy1wp8U/LO+Gop0SvbYseRs+xjYM9O1Qfc8hL0cvsSiJUYR5Qrr113nLP0YMMgTL
g/qjKlRaBefhRLha5LfF5BEiI568ojmWt+s2mZzvWsQmH9J+hxkXxr8vQpSl95Nb
95+EXXPwgftwiWrme6zhC+SX/2nwNXeE11kZBhQTwaDpTwAtiqL99KK9pB2V9dxk
9cPkI4VxxO+BVvsAXVEofohHAWpkz9hFI5l//3yTNDVzdwbLaQRUJ4XmiXYux1wS
uuWdm731p+cHD1bDk3OkA4dooNJOmUUVvXhQ/EDXWB02NotNyQldNcrkKKRf9L1d
+FaH9uxloKxkyYqbCmGkkYFB+RHHWkkSHj9lrDGY3GwrgCDFxVG7YsklAtbbGils
mRFutM3rAkhtEYMjPXbSWFyY4OTjCHih7rBYYCJ0LuzSb/5jk6vxTDwu7XJj7Ss0
mePOdd7CvrvV+7/dOrEmOkXHrVkK3FlZtsjGV55X2Hq7NUzNRyjov2eXeDP605OE
+iZy1k4WjkD2kGhhW7Mr8MyN4+KkIshO2d+//w/cQ5hU2H4V82sjEKWfbDDIW6Do
3DWNSlN9W3lRYs0ao0/chwlaCNsTJ0LfUUfWgbsjdxQ76wuQHZY=
=CdWq
-----END PGP SIGNATURE-----

--Sig_/oQzx6d5Nk2.gRvD_d/mV1E.--

