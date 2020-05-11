Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE50C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E5720708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="KLqskJKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E5720708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6fu-0005FV-8W
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6OW-0000Uv-NI; Mon, 11 May 2020 07:14:48 -0400
Received: from mout.web.de ([212.227.15.3]:35957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6OV-0006rr-LE; Mon, 11 May 2020 07:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195682;
 bh=KUWMlVMntn3U1nUaS+EoCscEK7fr6wH8WZeZRn/C7XE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KLqskJKV6otItMdDFp3CRHcgzVnGX62cdARHWDWp9Wqb33VEFMm43Q9hC0F34zKBy
 owXoUCQ00wcmP0CCk1VOyM6P65xpbpRWle+h34xux6c1OxEWF3nj1NomPqv3gepkok
 xBlNTXkc4ego5pmZsdKLjF7v27tcZY5TE17ySYLo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFcPd-1jLgBz1pIL-00Eht0; Mon, 11
 May 2020 13:14:42 +0200
Date: Mon, 11 May 2020 13:14:41 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 2/5] io/channel.c,io/channel-socket.c: Add yank feature
Message-ID: <db00ff13f62fe97634132e43105b9bf63bbbf582.1589193717.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193717.git.lukasstraub2@web.de>
References: <cover.1589193717.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+Z.y1BF4DD61=sLH0F31ie5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:7Czdz+grKSXvHO3K5q013O5YYv+f/v+3lPiUpo3O1Z6jfnVFweG
 jkEvCFjB+M17hCupvgf3oMcvI3jTg1B1upcBEvPUhWivjxR371rsOdnMH2Gx66h44LIAMlD
 u50BxUBlufpE5XtVcTCSQaYnAUnyScRjRkAHsvdjwEP6CqHhrcMdE9zj41zZ0lZNmnDSt6R
 uEpnhIxBzyJZX39S4mXjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e6NH5ealTW4=:uAgmTrfDC88JrPoaVp7i8T
 lMmM2BA35dIHHF0kciOSvmPmgODxNE4ILjvk9ktLC8WNxopUyoBYOgUe24sN5aCyNxcbcPKWB
 LNBqbep5i/oZewtH6NUDxDQtoiXItmPV/71c7f8UTRhCRY0rrlVgRYeM2LUJuG+JOkJUuZKmv
 fQv8C5qItxRZXGRVqiTHaU9raK0wQhwC4f6MAzztpgG+7N/wYQfXHEaFBS7g3jC/VF2F28Ddg
 el5yqeMnYFkzr4+dr5v53cpho7DZqE+9N4T8nMLkl4srQX/vY4Mmufii0UY7Lr8CI9EVx5X4n
 HAJsnM91aSEe8jU3Yrlmvr6qBLp6L4PMt5Oo/V0qzJCucsziPIB1tFtnLXeThKmyyUjEaVAJy
 tKIOvK/7I7urkJ8qd/HlxgcF4jxfb3r6U/dCKEIOuASmqFg8Eys9FAghiqejYuz14q60F9V68
 w7Rw1HM//4QrKNf3SrGJwDxgZECbWEFRtFWmTS7YoSwrof0Po8TZTImiWk8kNziDmOX4KpjHM
 XhDiXYxUWgoYEvn4YOWIZOckr2QKBCzBjKFMxLeik2ad6MZu8kGZ6NLBNbaMACLpQedmXQejT
 KvpIsk+dRixCefEMGCTTlbOJOSp1YXaT/7E1LK9vK1lriFZbogtueOxDPRtBn04FWvg1e0C1/
 7NYITPg5JauQy6lBvE3CSdb57rLuqzpe11z6A7mvzMGZvnlgnbw5Bo4eb8aA0oNjZjo0Pt7Eg
 2P3OEHTsz/atcMXtW+tUfZbv04r9LCTW9oulVTF5supLZG0F6+SwqgsFGpqv8ohItkk3g8wu9
 /HyD8eoatkxKzFXQqQdJcVU3ULm5MApZZADX6DMbp7VplWycAOBRPEJ4DKbkkMVJcorVweUuX
 6Hg12tOnVVnZtbUS2sS3NPEdY7HqF5LBFCbhvmmOwrGs+8DSlVbExnxJLkiv5Q+E8KwVekN2R
 ffBdn1DBCUOKqhZ7X/+BBdb5fjg1F5ffIu2O604iwmOBWBmTS0DzJTlDO7fCce16M9xXisQ23
 YAxxZRKD78yFWT/7MEBn8DRPiZS9aqClARzUJ0QHYd8M6LjAd8DbSUdtTkFmuvL3+Brda99wO
 2+pmBFy7Z7qx+GvQq8uMMPhIAybmfAs7fm9T1JsVkBeSbnAS0mnVPR0+IbDIEfWSk3rNDNcE7
 lu25fibwMtVg4z2/jR4cJr1nFbcNU0atMUQ6jlL97PKiC1k50Qyz1/3ZZqK1h4jbVnl8Pg9HY
 YayNkdCDNWOlV63Hd
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:11:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

--Sig_/+Z.y1BF4DD61=sLH0F31ie5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Add qio_channel_set_yank function to channel and to channel-socket,
which will register a yank function. The yank function calls
shutdown() on the socket.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 Makefile.objs               |  1 +
 include/io/channel-socket.h |  1 +
 include/io/channel.h        | 12 ++++++++++++
 io/channel-socket.c         | 29 +++++++++++++++++++++++++++++
 io/channel.c                |  9 +++++++++
 5 files changed, 52 insertions(+)

diff --git a/Makefile.objs b/Makefile.objs
index a7c967633a..889115775c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -24,6 +24,7 @@ block-obj-m =3D block/
 crypto-obj-y =3D crypto/
=20
 io-obj-y =3D io/
+io-obj-y +=3D yank.o
=20
 endif # CONFIG_SOFTMMU or CONFIG_TOOLS
=20
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 777ff5954e..0fa7a364f3 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -48,6 +48,7 @@ struct QIOChannelSocket {
     socklen_t localAddrLen;
     struct sockaddr_storage remoteAddr;
     socklen_t remoteAddrLen;
+    bool yank;
 };
=20
=20
diff --git a/include/io/channel.h b/include/io/channel.h
index d4557f0930..782b618694 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -132,6 +132,8 @@ struct QIOChannelClass {
                         bool enabled);
     void (*io_set_delay)(QIOChannel *ioc,
                          bool enabled);
+    void (*io_set_yank)(QIOChannel *ioc,
+                        bool enabled);
     off_t (*io_seek)(QIOChannel *ioc,
                      off_t offset,
                      int whence,
@@ -550,6 +552,16 @@ int qio_channel_shutdown(QIOChannel *ioc,
 void qio_channel_set_delay(QIOChannel *ioc,
                            bool enabled);
=20
+/**
+ * qio_channel_set_yank:
+ * @ioc: the channel object
+ * @enabled: the new flag state
+ *
+ * Controls wether this channel participates in yanking.
+ */
+void qio_channel_set_yank(QIOChannel *ioc,
+                          bool enabled);
+
 /**
  * qio_channel_set_cork:
  * @ioc: the channel object
diff --git a/io/channel-socket.c b/io/channel-socket.c
index b74f5b92a0..be03946d29 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -26,6 +26,7 @@
 #include "io/channel-watch.h"
 #include "trace.h"
 #include "qapi/clone-visitor.h"
+#include "yank.h"
=20
 #define SOCKET_MAX_FDS 16
=20
@@ -55,6 +56,7 @@ qio_channel_socket_new(void)
=20
     sioc =3D QIO_CHANNEL_SOCKET(object_new(TYPE_QIO_CHANNEL_SOCKET));
     sioc->fd =3D -1;
+    sioc->yank =3D 0;
=20
     ioc =3D QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -395,10 +397,19 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
     return NULL;
 }
=20
+static void qio_channel_socket_yank(void *opaque)
+{
+    QIOChannel *ioc =3D opaque;
+    QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(ioc);
+
+    shutdown(sioc->fd, SHUT_RDWR);
+}
+
 static void qio_channel_socket_init(Object *obj)
 {
     QIOChannelSocket *ioc =3D QIO_CHANNEL_SOCKET(obj);
     ioc->fd =3D -1;
+    ioc->yank =3D 0;
 }
=20
 static void qio_channel_socket_finalize(Object *obj)
@@ -422,6 +433,9 @@ static void qio_channel_socket_finalize(Object *obj)
         closesocket(ioc->fd);
         ioc->fd =3D -1;
     }
+    if (ioc->yank) {
+        yank_unregister_function(qio_channel_socket_yank, ioc);
+    }
 }
=20
=20
@@ -686,6 +700,20 @@ qio_channel_socket_set_delay(QIOChannel *ioc,
                     &v, sizeof(v));
 }
=20
+static void
+qio_channel_socket_set_yank(QIOChannel *ioc,
+                            bool enabled)
+{
+    QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(ioc);
+
+    if (sioc->yank) {
+        yank_unregister_function(qio_channel_socket_yank, ioc);
+    }
+    sioc->yank =3D enabled;
+    if (sioc->yank) {
+        yank_register_function(qio_channel_socket_yank, ioc);
+    }
+}
=20
 static void
 qio_channel_socket_set_cork(QIOChannel *ioc,
@@ -784,6 +812,7 @@ static void qio_channel_socket_class_init(ObjectClass *=
klass,
     ioc_klass->io_shutdown =3D qio_channel_socket_shutdown;
     ioc_klass->io_set_cork =3D qio_channel_socket_set_cork;
     ioc_klass->io_set_delay =3D qio_channel_socket_set_delay;
+    ioc_klass->io_set_yank =3D qio_channel_socket_set_yank;
     ioc_klass->io_create_watch =3D qio_channel_socket_create_watch;
     ioc_klass->io_set_aio_fd_handler =3D qio_channel_socket_set_aio_fd_han=
dler;
 }
diff --git a/io/channel.c b/io/channel.c
index e4376eb0bc..0c4095e0e0 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -373,6 +373,15 @@ void qio_channel_set_delay(QIOChannel *ioc,
     }
 }
=20
+void qio_channel_set_yank(QIOChannel *ioc,
+                          bool enabled)
+{
+    QIOChannelClass *klass =3D QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (klass->io_set_yank) {
+        klass->io_set_yank(ioc, enabled);
+    }
+}
=20
 void qio_channel_set_cork(QIOChannel *ioc,
                           bool enabled)
--=20
2.20.1


--Sig_/+Z.y1BF4DD61=sLH0F31ie5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65M6EACgkQNasLKJxd
sljo9g//W+2343YJ+TbDPBooBeKFlJqOVcz1lAaJNefEdIQ1g8XfdTmp1IC3G3B1
snWrRVXb8ShCeW3fEHyiZoMkrkZ4m9wPvJi8jbcvxjurc8KKQWC1lnxTK2Vl9wqJ
FgrljFaeh6soK9o4qVvAWa5oltmAJsEo/9xItWPVBBii+ct2yF3rmlAgS/gAYhoo
vsPgyNyUL9Ioc7mdTqWGPLgn1o+MZ0ZhsImyVKWQeJCrJDkkJW6aVqDTX5+DhD6+
alRRdU9kChfCF08/TZtthlnnLTsNJh4sn8jk0CDcszIatq469OKNI/HLKdQDCBlL
rLNTIaLX63yDfKHrTV5OBXU5dHSl7oU0TMyKTuYF4MgMaBND6KRZYzqru80wsJ4k
BXH6qq9gP/4SjiW7pghzYUBjd8a9mIK4gvHJhEQqRJjvEZXkTjRSMO9Kq3nex70G
NboLA4ey2bHVVXG+UWH2VdrmVNxJE5uuyKKw7Cgc4+j6MWGfDswnHUpi4VCCJLoj
b0DQmqDTdRMYOo7ALO4vXCkxMdPTkb5wdhF51x73jWgj+i8CgwfyivtrdKVRo/sC
vmoRj58MQ8DKmzdueOINNn9WvAI46F+p4cNuJRsjmM771s6kklAfzUOAlrCWy5oi
O3ZxDXVWW64xLRGUgvOzCdy7jNNqcbXrZb8PeQi4ip+UPNyqKus=
=jpRL
-----END PGP SIGNATURE-----

--Sig_/+Z.y1BF4DD61=sLH0F31ie5--

