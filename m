Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC9C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 18:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F902072F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 18:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="B1+Ng5ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F902072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMFeb-0008Jr-Mx
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 14:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jMFWh-0006eu-BL
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jMFWg-0004Yk-Ee
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:15 -0400
Received: from mout.web.de ([212.227.17.11]:46761)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jMFWg-0004XN-1J
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586370835;
 bh=Ok7tKtjZZkKFvWc5NnUyDQ4Xr69cRQd1e1Rf/HuBLN4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=B1+Ng5uxSFUmv9TQKe59ZQw7wMAeif7QVySz8Qk5lgdi/OuzsMQ39iUV8dUkXfMlS
 qN2TebgTZcHTMXOPa57u/lib5CFj8ojcUOJneKzSOLGRG/cpYgI2ZKkcu65H/dTKJm
 au3pl3oLW3b127PJMaL6f8F6V1gqWpI2zhiSeKJc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.62]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHKO-1jQdEZ10wC-004VBS; Wed, 08
 Apr 2020 20:33:55 +0200
Date: Wed, 8 Apr 2020 20:33:53 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 2/3] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
Message-ID: <f231c9abc706f5825e41c0fbaa4fc82de1121435.1586370737.git.lukasstraub2@web.de>
In-Reply-To: <cover.1586370737.git.lukasstraub2@web.de>
References: <cover.1586370737.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DuFjdNgzUpI/ZMtZtNsb/0T";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:k1fw5k77W1NyeRTs3Wjdh2c+m6balKpYGf7d4/4vCZqFPea4tjl
 BVfTjA1Ncywgbt9jQcPTrx9yc2Ao5r85wGiirMnGgm2Ngvgp+b3J59IrUXdRELkWYlbwzeY
 IZsNmuECb3fybvWOu7Y7q5X8DYq3za/fYO0cYfTxsLgmUmrE/6UnDCRZP+JH4fzx0Bbxmm6
 84mFVf8IDwPT1SWI7OEJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BT95PjSaaH4=:z8+hTZBDLXdQXzvWczBjN9
 YLLVsE5cQDTIWeRviWWwKIAUReIh+nj2FK/H6Y7nQOQDvnLVdPyzJBlr6gSg1dgCb25Srm5ub
 ESSles58iTVkMNY/uaXNa7QdmE8w445UMK6nLmL1ApytZ9OAdXGD79O16gYThPvBsnT1me+4f
 QnnSN/1PTaZfkAXLIaQGU8z0G8oG2AwfDSeDiprZmhNCqhLii1ddn+ZMmIlXPkBv11AcWQbSf
 xzEHoT/lr7NwOBDnuge5Lfr5cs4xqNi74UjGYAvIMAvLuGrQ+3HC/NNqXQRzlY0dtPyHgsr4m
 F+FxWvlUA3fEoZD7FiWZKH9fOMfBaMZyLBO/W1/dc1U4n4k9SFpf2WiGqv/YYQr+M6TGydKIr
 5ccx2iX6u8w40roWYuIv/+9XIOeAUjzTlntNJeCfMTkSNV5mCEqO7nREfQ4xDKLJoF/6QJyRE
 Pg1yiY6DDCOLViB8sLwihfAcBBuz8VcLtH/vxF6lOQNIiWb8AtH5bkAB86BLSUxvfJaE4K/4g
 uwNKsUgAf2voX++A7yCah6kU5HfZ4S16/pxBSHOde2N4J/B8AjxdpkPuy3J6JQlWeYyN1lt0L
 papGKVVxU+kijHQrfrtw3eZc1xm2cqivZCGY9T3eYa77QG96OM+Qv4mrG8Q1SEiR9X2FWduGZ
 1s6jGBPQYxDpcsNMyYD7RQE/Af8MvDwXrEzgDCuG+TdBEw3OwXCEG2nL2YCVlkUlnk8tJdfrD
 GZphpvJVHtVJ5NiarpR5V7J1ewB9jH4jSYOjDM+hehmVfzj2j/vEJlml3vEiYi/Gg+IEDD8kO
 sXGG47ZPAia2u3G90SHFTKnQNR0+a9g5znuAoJJPyKwV2HtmuYFyXvq0NwqlODSkg7jLnC90D
 5iF8Bd/S+ytJQaHOhVMepmFnZjGQjFOiFUCwn0b/+khtncbmuyXQ+11qNW+oMfgqvfJ0w1Ysh
 yEWpWi7Ft1983+G5WRalf8iFpQoItmajGl1dwJrNkZHvAioAYWQ08M7MXMWwJba4+646176xK
 ZKh81YbaCpeS+Y4TVE9Z/cKE15QaD0Sjd7XgwxIFbXK5gnevH+hh1dansm+kdm5YFIhdDS7fB
 SmFXBwpXKfd6+H0uZ1jyDfhoUUgqda1PNKhB7ugDTqs7akWZR+rlNjG2i2qvdFauv2X3nuFvH
 8Hh8KkTlufSupu6CZ7oyxUm83xJ0XOlSu+xRu4q3fZmx5EaMTKupaKJFXdMssX7vpCp07kKpd
 fV7HbzSUjwQZPPGmJ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/DuFjdNgzUpI/ZMtZtNsb/0T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This will be needed in the next patch.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 chardev/char.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 04075389bf..51ad0dc6b3 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -38,6 +38,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/id.h"
+#include "qemu/coroutine.h"
=20
 #include "chardev/char-mux.h"
=20
@@ -119,7 +120,11 @@ static int qemu_chr_write_buffer(Chardev *s,
     retry:
         res =3D cc->chr_write(s, buf + *offset, len - *offset);
         if (res < 0 && errno =3D=3D EAGAIN && write_all) {
-            g_usleep(100);
+            if (qemu_in_coroutine()) {
+                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
+            } else {
+                g_usleep(100);
+            }
             goto retry;
         }
=20
--=20
2.20.1


--Sig_/DuFjdNgzUpI/ZMtZtNsb/0T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6OGREACgkQNasLKJxd
slhKcQ/+On2FKNMk/h0d2MJTB2FPl+Ve+/mVVexpjwZke1c1rH5k6PXt70EcWdA5
hoKVBuo2aUlK93gs2OFt7ms+NI6Mn7+XbIMnJtSKa6C/pEjC+O27IgLWP8gP2Awx
k/gmvJZ2WO062Gg7iK23h+vxhCMz2XahjqdZvuRw2YyLSZdUrfmNT0OUe5fg+xMz
/dzKeUKaUGeoZOeIapn1nlF+RCBFH18QdgGlGBrn9y+eDqzTm6ZWpbh+k9WKahhx
ucysuyILVQSec51VWGOzodSd/YmFNlhFqp3RhK7s/qUaRuqfKUREyh798FGhibd7
sn0map37KLw2u4iAhY1+/tUat1pOgUQtS9zY3uqX6qveHMWgkMZFo2jU8/Dj3EyJ
JWOLhgH3vFZKfOwqUqdPREpPAt8hMpAqEBNXAtjDVQzMjOM02TkfwQuOuINTCczr
i141LN/48g3B1YU2B7CJ0b4N/hJI2ukIwj2e1NvdbNdZfZsTweKi+IoSImWpPSE/
rZL7CaC1et4c+qgUMPN9O7QODC27La+TL3fuieK+HEJYhD3gQv+MC3Iy41Fx0o2W
SZ8kNTVCfATOBurNGGQxInunE3XwT5SOCbYRTW6CIW9pOLnhaTgsne6iRYjBEfrJ
fD6H+sVo09Pq26jfVmnagq7dqOJGXxjbD+18ZCZndqNngT71bSg=
=zSeq
-----END PGP SIGNATURE-----

--Sig_/DuFjdNgzUpI/ZMtZtNsb/0T--

