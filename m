Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B293DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445002087D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ckC2NE+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445002087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2kj-0006Qx-W4
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2O8-0002o8-3K; Tue, 01 Sep 2020 05:15:36 -0400
Received: from mout.web.de ([217.72.192.78]:40851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2O5-0007Jn-9d; Tue, 01 Sep 2020 05:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598951724;
 bh=wGa1Vmn2SbeAvZdU/7dQ4fM84V6LwRiSr+jRdIG+9yw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ckC2NE+VGKGvOfpPjP/Y0GYk0QTb+Zs+k383lJXS/wd03NSwHCDDRIgacDLOiwM15
 FiFaGv9ey2VmaIhgJqR+3sOr5xTE1y8yKdnoEnugj+t+NwgGvEAUT+txQsK/a5uhsW
 IsRNSuwJ84Kw+Z8rPrLauu9KaLvo/NmGTo4+MJig=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.220]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZjb-1kjMOc39pd-00chaH; Tue, 01
 Sep 2020 11:15:23 +0200
Date: Tue, 1 Sep 2020 11:15:22 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v8 5/8] io/channel-tls.c: make qio_channel_tls_shutdown
 thread-safe
Message-ID: <460bb32096f77e892cc3555c1a70613a58855a4b.1598951375.git.lukasstraub2@web.de>
In-Reply-To: <cover.1598951375.git.lukasstraub2@web.de>
References: <cover.1598951375.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cmu7pFd7wlYcVSTV2LpusMo";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:CqWcWJ73tYPM4kOGRhTkaJS48bHYUTS2RvNuygb78Qg5S94hrzM
 cMzmZdboMQsbEufdk2Drv9G5d+KwjtnmVpcmMCN6R/hpAly5ZyG0YIruobAc/oNLYUuGx98
 h8VXMrtoZQiDzmOwdnT+WPYpJ3GlPYe9E8JjqRQ5P7soxD/1kE5UoikfKs2HScOs9P6FuwT
 yTPpiLwkF5ikF/YWvC6qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IGJjJT6m8Sc=:1n7PXbZfgBjd+vHridWlbj
 8SzBZsowJlSoakDmBhws20ViD31Vt6uQvurn2eHtSijMzsrq88vX8U0WAJgIGb4x0Vb97nMZG
 YtPb+f+6ZLdgBEMepxbBmNTYcI9J6Z86Fzor2GezAoit3L9gE3j5SM8UfTgAsU6bN2QyDkxFm
 QLSOaOfviLEWTMbSNTTIhh7bi5b2Q4ym5wItBCquf463iHj9VO14c3VFYfSHm3oQ0oysr+bSB
 28E2sp1wkRTnmDYGAhZJHXOp4/aY0JdSAVWReqdSAtZhl6E/ZScex9fmoNEh8oIjD6LcefMTg
 MGWuU3QclUwJYEoSF2giHBnQOZ6Zzfjjk6vLs+05DG3Swf6DjZQXcdPuQpLSXBUxAeBqo6uxN
 M4UDwNDrA1GKemzw/0fCfM8Wl4LSatHJegincHWV37DDFATnGFD4gYSOTU9wyJULcWYrfILFh
 Pjt2BO1NyH3RTvRKKSg+X9eH9lyjgOqDEAizxs5Ghas90p+lbA9FwhcJ9IKtPKO3o8zYgJ0O6
 Ewklu1Kn6LhAcG5s+9vn18t/C+CPZPLnAy4x4vzKfYZmnsTu63nL7qylpmphB03U8xxvYRjNx
 q53eG8+4sE58b7GsrcCqwyI7+26O9jQ83SyCChH+OGj/86R0wgZsnI9Y/KAErQw3L6NCtw+r1
 mbn9hXRmJ/4BoSRMhXhoB9Lw8ilGXCTCeUW7jQN/9V8Et0LeXkMKMvwKJlJRa0/psPeE44HJh
 /0MqfqwOkdhOo41E7t4IWSM7DpSs298AFnwQHAcgOVSOiP/l3QBD8DnsNRCpUYYb3/DdC7AVq
 J4B/IX6jQdmZiKNiy5PXOKw7og/ZNAMSyfdiXcd4x3fRHXUMPiHm3aT1Xh/nWACDtu+CZLO+w
 oteXBtYBsyp4OTtcnCy1vAQMHd7zNfLv+xnh34gyRv4Sv4nDO+In5mNnFCrQGtG9CNEw4flTw
 X3kSr9aixwPOasLYrBl/javOeOuW73mzUSx7QUizuzwTVERpDSKh2nMfYWkS6Vnfah+10pnKT
 SPcnK+TH5RZcesB/43FTyvsih/z1xHf5LZ4nK7CqUPWXaOsmuA+co/KE7sbfjVhkk1gmCU5MR
 kH2jNKQ2yziGtgZN9k9gwaU/gCGQcZOj8ES4LQF6ExlKtpxagLKQZKETuenFBQ67XFL5iFkoS
 BP37YYszFfx0V+JzjjcVMPIHmRDxNQoYX0ATKznIPu7ivTm7Gj4eou3ywbCsG1O0HHACtFCiy
 dp4PcYq5zT4U6qBsiL40hF+/FHjC6vH+UbUD4Eg==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:15:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

--Sig_/cmu7pFd7wlYcVSTV2LpusMo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Make qio_channel_tls_shutdown thread-safe by using atomics when
accessing tioc->shutdown.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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


--Sig_/cmu7pFd7wlYcVSTV2LpusMo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9OESoACgkQNasLKJxd
sljGBQ/8DUlluAiGJ5GPVAQtBZueLii/nUh5CR8+vZEf2tjLJsZGT5ao8LlcgllZ
/U/oAxyP2Z01xJLvfCbhzKnIaSQcJ5cywXDD0jKL+A/7WPZW/D16y0NSE6/bPJhR
/abetnLOlafybm8xhGdK2XJUIQXcGPxhUYDnKjy+aDCkOyXvzzKriCsnu6Nthj3C
ZmFv/0PF3K8l5Nj2d8/gz1fqvyLDp6uTHbzx1L6b0aWcsV9c1t7zvUsoEWhVLRxx
a5pPbBCiAvq1j/q0/Imtv3ZM2ixyIOeKi89pXxcD8BoPwU7uAWAI0WWI2ZQsywRM
qdIkWECnQuyXT2j+PtaL2k2Y1ZjEkmWZXaeIpXvMYG9p9+jmn+PNbfdTjAewGCZo
DPL2dkTt6wSxFhN/cF02Hv2U3VjnA5rItRLxjpLpOSbM/4Lrz3ryOAHU01pD/xiv
kPH2NcjsaSO1SjDh1/126XSNXgT/aBI6oaii3x5fUq3UwsBvHkWANmN9HTRc9H+X
++JNbxWb2QyNJfxyOlRmqnpRe7YCoJu8hLS1MpnGiYfuOMiqBGQJUBZsqWCamBYM
QzCObXjw2aesoxm8mi0X6f5UFoJ/lWzusoZJergSWAfJPWsDYTawP5PTAPdrJ5IA
fnpOIYe3+eNvAjUcvJ8xaAGDooNfUIK88gFaEAW84JfSxjy+Dqw=
=vAFY
-----END PGP SIGNATURE-----

--Sig_/cmu7pFd7wlYcVSTV2LpusMo--

