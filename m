Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AFAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF32320723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dSwiULTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF32320723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkJB-0005fE-SG
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8e-00045s-Rl; Tue, 23 Jun 2020 10:43:04 -0400
Received: from mout.web.de ([212.227.15.3]:57299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8d-0002XA-AP; Tue, 23 Jun 2020 10:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592923377;
 bh=qd/7yebiS+3k/Kn4Vg71ggA6f9/4npqJ5cGwy+3qO4c=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dSwiULTFzoKT0vHvdiXyPQvphYqqxcY0C66nbQVhea9QBAyrNvZXpspXcMOOdzwbV
 J2KjBydYmmHiJKGXSiCw+m7+/xOhqppaN+fg6x98oC5HbmoOYmh2rlIweMTWaLb4RI
 Ix0N5bEUwGVdyjurjTtA3n7eEnHw1lPFgh096MiU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.8]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8hdL-1isSmY16up-00wFZA; Tue, 23
 Jun 2020 16:42:57 +0200
Date: Tue, 23 Jun 2020 16:42:56 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 5/7] io/channel-tls.c: make qio_channel_tls_shutdown
 thread-safe
Message-ID: <c05e7d6cc8484965d8041b90c92370a9828029d6.1592923201.git.lukasstraub2@web.de>
In-Reply-To: <cover.1592923201.git.lukasstraub2@web.de>
References: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q/juiH1myJL9FrwuPdnlx=Y";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:JzrpfeIQ8CpPCekPtyoLxLgUJ8CGMRtgW549i29qab60bCywFjm
 122WEpOsT2JxpOCqxgK6vdcYTgWc60nOv11PFrdVBXQ68W6F2CNiu9rofsTnnQgLmzM6ikD
 7kTqTJADaFBbAutAJ57S92Mbrrf68iJns03WJuDYyXYeH51oLKBnofdQ2FhGMPoPim8ruP8
 wmRH0c7wyLWBsCC/+H2Kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HFXjYqe2qpQ=:H4ukt0c+cIKFGhGH7gbjyA
 LB+KnKtF+5A3bzPBTMnCeib2LyBQXyP21pUwBm3Asz8y5aGuGZoZOfVDiBwXDCqcLD9LVk4LR
 J2d0LiGtNMJh4qmjRvQjoIWCNOniji4xOMTGjbaNP0T7yFTBbkrW0pQp8gj5FvrZtolSznqTU
 B58ld1xexmCcg4rs/QkMLzraOo0XdeNYFBNniAt/tpV9pc+aUu0hEha86nMH9V9i8wtjbvERx
 sLt4VUig0mdPnE8SvAJLLqNYOau9BY0W2i5bTNvnBf52GTD8gq6AF4wuqTIk9puHKutjaYPvn
 T5iohzxNaSm2SfjixsjaEKH6K3Ow+C6niLlIPUwAb+H+rnrORKmIdzG7+zmSLyIbcWm3pp68b
 C7Cj0ctTnJE30taMzHehkTZBrSZup6nvjv46MRb44Qwqxd1246mhwMcptacz79SmnJSYOWTez
 6LZQNaYxnSBNp/FqGlIzJkNCoWEZjOPpxoWWAuv+ZkMt8DuRyhJx9L6rdhh1Xz1SHYcoLHOgo
 71hdgTCcb043Knf3id+Nl8uZnPJ0JcOhmScckwZStDYKnUOh/9E7mQ+tGYLvroAUdQAandXJY
 i3idI0AH5H/rS4Jp0cBE8Leh2hjVcVaagasVtzcwItwOu33yakw5SVlI9URXCZ/YS0aezzGsj
 c2DaD7BprfAqBfYTbMpbeXiSo4oZCk6DiUdS3uduEUpcY7yA+25mNHZBPz9XemFpR9zMm4tBs
 c3MaIGjYHaQhTJjzsfPQ/dyZReNyzg9fI5Y7bb/64Xwc9g9GDWLfGWnqGqbC/cP1YXoLf8B6O
 pRNEaywm2cHtg68oTwVMFW5JEooVH6AuJjiH14FcRHUffjzDXvRPJucYLPluy6lAw8jixhNfS
 c2bgDpJTuS6emEwGU/sYLZ4AT5wQJlZjdt8ggplQ+EgQQtA8lpr+gC3QvB03dvWYU+o8EbFe8
 aogOrNpytG+ezJFiEMtly9z2nrnBO/DyEGmQ2Oq3r2AT2CHe2Zn52rFJXvz8rKC1rDP39GOkN
 h6H2dQmwZ8xBcJftoXm6+WNE1zRqrJpbNVnkJ3VwprH0I4GysykWtwdImM592bCE4jA3Ki5Ih
 uDPUpxU0vttYmxuRGytHtTQj6wUVmVnytVqUwyiioo1HeX/x3wY/zRe55Lf7ZLWRlFlVJV0NP
 2LlDIRcI8bOHpNTV25R5Dj1RUFJG9jYeQ8pvSJcz8bsfZr/QqcmSM5bxZ75/6TQ8wkT+BGVIz
 NMLMW3YHiilemEWvY
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 10:42:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

--Sig_/q/juiH1myJL9FrwuPdnlx=Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Make qio_channel_tls_shutdown thread-safe by using atomics when
accessing tioc->shutdown.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 io/channel-tls.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7ec8ceff2f..b350c84640 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "io/channel-tls.h"
 #include "trace.h"
+#include "qemu/atomic.h"


 static ssize_t qio_channel_tls_write_handler(const char *buf,
@@ -277,7 +278,8 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
                     return QIO_CHANNEL_ERR_BLOCK;
                 }
             } else if (errno =3D=3D ECONNABORTED &&
-                       (tioc->shutdown & QIO_CHANNEL_SHUTDOWN_READ)) {
+                       (atomic_load_acquire(&tioc->shutdown) &
+                        QIO_CHANNEL_SHUTDOWN_READ)) {
                 return 0;
             }

@@ -361,7 +363,7 @@ static int qio_channel_tls_shutdown(QIOChannel *ioc,
 {
     QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);

-    tioc->shutdown |=3D how;
+    atomic_or(&tioc->shutdown, how);

     return qio_channel_shutdown(tioc->master, how, errp);
 }
--
2.20.1


--Sig_/q/juiH1myJL9FrwuPdnlx=Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7yFPAACgkQNasLKJxd
slhZ2hAAohgSCfXNOa/WGuhGd/WcqaP32hyRrLMaJpphXwMRs8EAGYI+odZ3Jzhm
HwK1IbZOFGz3dneT1jVogpi8JggLQ7FJ2uuAsnixX0ghAugNtBJHo/ony0N1h015
hbVvfipAQcsjr87k4lThBrtPJwiOiW3MHmj8yF1LLIBk9+pZXdLutDy7wMWcciAf
ZbIOzQB26wQCqBVuEdZVqwvdKytmfqRlhnJk6fSx0oQELlPstd4il1D03yl6rciS
B6AYUKhtppyxA9BlkydXyOlSrY6SqB5ZvqREQZBQMqFoEYbDcwug7Zw8EIhXcayk
gvGZAZZo6VJimucTyYoiYCclHqhsLVRi1CZcUfDLKd47qGsQgKHUdKOJSQY1xr7w
Z+nQTevflaG8gzEbwOlRfKiXQ2DtBowbOSnkVop40EaVzx/NmqCkeYNOEXQePh8R
8P5cpENIlLp51X5KaJHn4qfnWXlznt1Q9AT9+QSyf26RMlSsIG01lQfZZHuyPwJ0
rZWUkZQORo6HH4CZyk3ebdNCtfDB3P5EhmqSCe3lJJN8zRdJRsenLT4YGV7ovMGe
XRkiPxzma64jZf7U4+QWncfm238O+vRveOHn4TLlJqPZUSRr5xln+KN/Bt8JsOCJ
7Xmroul/ReGFlUvomK2L/e7q3hgJMp6AVOXX6umGywTKbykV364=
=hKrO
-----END PGP SIGNATURE-----

--Sig_/q/juiH1myJL9FrwuPdnlx=Y--

