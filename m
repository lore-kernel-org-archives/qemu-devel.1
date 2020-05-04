Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82938C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F0220721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Q7DL+Gbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F0220721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYUU-0004Fe-4E
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKh-00075y-Jp
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:19 -0400
Received: from mout.web.de ([217.72.192.78]:34581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKg-0002RE-LU
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588588088;
 bh=9/XfUlzD0JhzvxOKh/ThcXoK6slWbCKkPxSj2UT8mQM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Q7DL+GbhgYcXoq9DK3O+zZTxVkckul1ZBvjDnkmfgjP9wV09TEVClrLHD0LkNHz/Z
 OilSYXpkFVP/suIzAmuTn0IkPajoV7YzDGRq47Kib8KmZ9GLhUyGgc/EqQAjSOkvxC
 3iqNcO7OO2/B8B+hvm5/fHcCdR8tx7lMqPQtb74c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.27]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7epr-1jWNo23nUj-0085j7; Mon, 04
 May 2020 12:28:07 +0200
Date: Mon, 4 May 2020 12:28:05 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 2/6] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
Message-ID: <4a0a27a167669dec734a37f0d3d3826ac131db4d.1588587700.git.lukasstraub2@web.de>
In-Reply-To: <cover.1588587700.git.lukasstraub2@web.de>
References: <cover.1588587700.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J3ZP+6/aUKSyG..Yr_gimrG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:a2Bz2jMYlLxNs4b0QHBCR0y+PAYZszqhIj4J7sW7IFlyA9vNoxl
 zsGYQ261FMLk4TYTAwoO0SGXUxS/Fpy4Wjg2mKl7iA5FqU382huTkffiwwEg5esVfzh4Ea6
 Zxopd0sp3SRtGzge1Td0XqMzWSC6OyztzEQNQPCloIPjyI/1XBuWiOQyWiC6rjE70SrxEpO
 k43PS7OamUGIAFLOVMzEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pHoRy1v7tVM=:KbvtLmsO44e1gpJsiA6ybR
 hKMqg6gSm7j8EjbWKw4j7X4lVBKdig9B03u2QV/L2D6xrKRnpquAEETURIvmNXlyxoe3Y3+I6
 gIpveMx2s2pty39aQOiLHCLgF4+vJw4UajZgO4QBqoy6iXwgy4y0JDBSSz96wGS+HJ3YlT/HN
 Ds5DT9HZpdQFFNllyAcxJziplz58BsD+A+8YNINfTh5UnkC8xtFx0DYY9vAoMBHRPX2aRQz9o
 vxzfoZX76DTNfPZUT0v+hbh2c5RIEokdO8nmPMpj3Bcoaom7EZffFUUNA8o1KSNKlDWdwcXbr
 kDXUSRRA3EokxU3xhFBOSljBAzSFZ6t88bzPIRvw9FPcW3k0u75nyjJQS75vIDRxvzCR7vKcQ
 CmBqzOfinOV4k94+8mhx9SCMxPGN/BVSnTG2Fr330OM4Wg51b+7viCD645YcyHDJmdM8qWOnU
 jMtQbzva3lQbhIkdJvuGiV/0d+/rz3ep8PHcFcWNfvIlIxEEkk6Hi3PdLDm81002uW14S+ayz
 ASgzi5LyR68ML9o58wUVhTxxd+0O9pF51Ao7vNvBvf9NHK9XvbbABC9V6mjQi/6zCXXfCQamW
 NgOAkb6e9wrwdbmAN9qjtXNUZ520Ixze0btc3pKPo/IIsMOk1MG5s9EOzYLhzc/WmeWZWRu7h
 rafra2HCXBRHV5vmhQZHrL8XlTy6P+tXEUF+7PVZ1P/oBYgBWHvewbEG4eedjOG3nwAQEK1JF
 e0On+50GPDPjHEJ4RJ5u3KNsZnAjBDXMKIqrmj2T+PMQHgYiKo/4mhPlZ61D47y0iiSTHi+Jj
 nRTTgvHmUzihW+0y4gAkBH6EnvSIKTjZmbsZUIHnhaW8tX4JQKlIeu0l92MJdnJ8ag6D5FYF6
 qRn6Im6UjChjakZCKlnQI0WjZWhXqbdhv/84V/J6PE2owasagtaGaE6MaKoFfvnmhS5mrN9Cb
 V3kon6GV+KHut175bevSKXDYfPy+D/RZRqbChjGuNrGqenj3rl5WXOhZ8S2+x3IRmiRhLUREI
 I2Od3v3EQSem0lnpZuqvsKVYij4TmjTPGICRK8e36c8UdDMyN19jklvva3incUcQ4dPlwemT5
 KFMrmroa/aLEPPaSIIHRvBbvw2a4mjqGYG01HHQAtzqk54oHYb1ZJhXeLWXoTbJmkYArEfLVR
 4pKVHqSOVOHN4m2QRX5phpN3FoPqusTN6DrlrKmLAKFVYPO7i3xtARpBOtFck/yFaTy+g1k18
 n5o9m0DEJCK+FYFV4
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/J3ZP+6/aUKSyG..Yr_gimrG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This will be needed in the next patch.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
---
 chardev/char.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index e77564060d..5c8014199f 100644
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


--Sig_/J3ZP+6/aUKSyG..Yr_gimrG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6v7jUACgkQNasLKJxd
sljitBAAshdey0Kklkw2C7CSTRuaqD/EIm5W2MYwHnyvrsIMAf1ewKPpqX1rLP6X
xOi4ymiVPDz/oO253JqXUc+ax4bOo/LFcURrx9Ddmcg3F9zglKcMdewQJnWh7kNZ
113Yz/4N46gGEa9xhMzOGcH1i6c5fHZN9wLMGzFZMu6s593Zpn4t7zn9GHI4Ko28
i5apQqI8abC0iV/VaXUZjbrvw2wbIi9IfB5ennXthQ3sQ7mhSzbGlfXCowmYYcSI
F/EzZAY5s03MPhyCPphlXjeGBdLjpRKsk+1/LTziYDhc41ocPQTh0Asv6Cxabrpr
uyy+FdK9/WlEUdHNNVCx+RHP1bx5lABU48FuHg4ZNhex4IUJFxOYd5EXojtDUU3K
IDGB+fqTGU2/mPe2ZWZX56yK61ranbyHJDCjylSUv691YDdV6O6wdyw1AZYAOENH
9iX1Z9vIglXf+5U7yuBCtu6y0uic2VJCBI2MoPdT4CX8ua1+kb3NwqxejNWugA2S
PJn0nqeEni+g5rq9Ji33Rm07bERreaO4TC+movJ18YCLhCNsl7qqIjQ5V6SR8eGB
GSJTbSPsT1HK6Vv2BxWBxVQgdByDM0cI+93Zumgz6XiogRnjaZlJ0ZKsvx1Pa0LP
xW1wVMan/bdh1pGHlXjMT1YsvfMr2VIwQfGkYKRNKswwitpDtnA=
=cB3C
-----END PGP SIGNATURE-----

--Sig_/J3ZP+6/aUKSyG..Yr_gimrG--

