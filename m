Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBCFC54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9D220700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="T3rLQyUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9D220700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSpFs-0002QG-FS
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 17:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSogY-0004OB-7T
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSogJ-0006UX-29
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:34 -0400
Received: from mout.web.de ([212.227.17.11]:39057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSogI-0006Rj-C6
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587935938;
 bh=RrNnM3VAiZMXdLeP1/sr9CeC+WSjjrizzc8RS1g9EpE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=T3rLQyUXwU8fROMdEWL4KF3YgV9mr164LQkajiC4CQ40xWZfd8YC9m9apXRUICB1L
 g5M0fNzotd323zXbDAxxmaWGulTNlMHdlKeB/906yeh2ctJRPTbE2H5f6kVTZZdrH8
 ys6Diarez3dn5HbBM1H4QGVTFveaaZINfd64gLhQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.69]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MA5v3-1jLtrn1Nij-00BHS0; Sun, 26
 Apr 2020 23:18:58 +0200
Date: Sun, 26 Apr 2020 23:18:57 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 4/6] net/colo-compare.c: Only hexdump packets if tracing
 is enabled
Message-ID: <e0e3f058620cce728ec5cb18d136f2f2b475b5ec.1587935686.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587935686.git.lukasstraub2@web.de>
References: <cover.1587935686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+MJ=v7zwCerCYO3j3qpjScx";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:lDz6X3ZU7pODbf1VA2Si+YHMF7AJQJE01nMe/5ffIrgm8FjiFaG
 o5LK6IbOaWzz0b0V7j6sR6VGQBpbZAdIwOLPhGrA3UXhhn7gzlXTpb2MPG71RUkHyYN3sla
 JdcyFcd0L987Lz/P+rfJmS5RjETTPyg+T3PqoVZtIwQKb6lgyZHxN6+orXgeWxV79su68WO
 XBHz1XiGJo0+wxRUjWpOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pXqqKDTcxHY=:JABBwYcb1o9fbA/cfFpkvV
 veUwx9TWFRO+o6Vd2ba2m8bvmUgP5whadWLgzKh7PS/uI6wVNYJnaKL4CjjChYglrjw3uSsJn
 gTZkeJirGo2CzoTJsSYm17fdyWGsbmZsQcDg8TBmL7MVgiO+8mXdqZiNracesZqmcOVWXen+/
 l/CwlnHaH6k8ngXqRtaFLLP6CedVioEvhJvXo8v+XxV86JXX6ZY485avXUeUQwIBVp9dDPp9m
 ndjb8AZp0jf3CYT1MWbBbwQHSDGrqjXUqqtpIjmGPXa45Urn/5btxCh0WRd71B8ppmgyZVsHK
 HGcGnPA6vvN+Ka2tvX4PFbX32r2nfCwV5wEeCnugoCxdgcRyT78QyB7jr7rPpzZ2NKH9anoqe
 DAVFWxdYwtZDV5p5XVio9WjecUz/WyNClOinWPeZN/sw8cBArnmuvAewGnYSxUiOEPYzrmRT2
 gFUjxAAOhd1LATBwPJQQwiVxpkhB15nTrtLcu4lPizx/3PJGhc18KqB0p1RP2hagWwgiKLImH
 Ya1KsW+1RZRohaY1+v59S5j+k5AY1SyQ1+QV0oB9SNxi0I9OdC9jjpdogoXWECNhpWFof0AzL
 N+YbwD00KsqGU9G8vE/QIV1Ja9i1raNI2IWTyGiJbPKgKG5iLq7bysi1BVOcVk3azjIMSUlo7
 5kpzYp1GoQTcHWhXbRJu5Wq7oKdmWzw+W2aXBgc7qdh1pIbrhtM0bvs+WopJZ5QJz4ck8mwJq
 AsBr88nwGWmlHi+zDEm5vRN8hfkWUddlkXdb0SPpvEG0jGVbAC/a0Ztm5y287lS6oet6l65nj
 xsqQObtIOTfnl72HiAm+Lp2BqRpJBwRcXUL9LoIyIYn4pUskGUfm3yOTBSmg19OiuROX5yWJG
 D1We27oa2k8qV8JPTHYZWjw3kgtAlZHpPWRTjSxw6N4QbxQvJaXsEc8GHxDo3zWY2N9Yh2+N1
 qbY9DvETlVoGKmqQ/TBpWYX2Unq9pyzK2Zhc6DqbFhHJRMXccB6k5Ez0kSO7ICyYqE7rDVuxw
 4Pqoxqed3mfveQKIrXJ8UUnhaa9RxZsul7LmrrH66GezbncSVyk1oTQCtuwym4k6ei7+Lwlus
 Nu9PJU6Nb96NucHuXQvdI22XkQUTPZMdR5oNx2j/C0cI1EtslgagRieqDYvZTiy3bipb6FsH5
 yItOMg37vZ6ciGZcgKzJH8DrNuNyYR7wvad6egymHaGgzG36lIGzVXKbYRpi5s9O0o0qM5ES6
 R/DM+jfO6GdgYcvpH
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 17:18:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

--Sig_/+MJ=v7zwCerCYO3j3qpjScx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Else the log will be flooded if there is a lot of network
traffic.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ff6a740284..6634911770 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -479,10 +479,12 @@ sec:
         g_queue_push_head(&conn->primary_list, ppkt);
         g_queue_push_head(&conn->secondary_list, spkt);
=20
-        qemu_hexdump((char *)ppkt->data, stderr,
-                     "colo-compare ppkt", ppkt->size);
-        qemu_hexdump((char *)spkt->data, stderr,
-                     "colo-compare spkt", spkt->size);
+        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))=
 {
+            qemu_hexdump((char *)ppkt->data, stderr,
+                        "colo-compare ppkt", ppkt->size);
+            qemu_hexdump((char *)spkt->data, stderr,
+                        "colo-compare spkt", spkt->size);
+        }
=20
         colo_compare_inconsistency_notify(s);
     }
--=20
2.20.1


--Sig_/+MJ=v7zwCerCYO3j3qpjScx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l+sEACgkQNasLKJxd
slhlaA//Q0SEdt/yh7EOeBntThcLEHXvhHFt48vFzq9lmUx9V23OaJszqMZ2tXeo
Y+q9PN6iKZJi0Wf4IzKQJp+K2KbcoR0pD8bT6GcrAvuaVUPwkMiSuRJl3q2zlC/Y
A+hV+4LjXv+i2tbUAabEe9EH/jqrPdda/VB6AnEMjYhseFBXwKInjxYvHXKR5krh
uq4BcfafVQFHjQn/fEuSlXOqtglnu/Nj65rnl1QYWiWJ3aQhzYWtJfuIJRZE5/yQ
qmISKcLCYVLTNdPah7nRaS3KBydMsEZyKCgddZxo2ecz2ua/aU0LK8m7eeTSntPz
2IKeSGPMY8lqEFAwip5QydgXLOTKjtL7pU7FoE6jF5CTEcsWfuxqw4xQFGgch6+H
MEpIOwcUdJpFD7ORK5iQc+cf6AIpDD5d0KoB74BHS26zqNRiXLMmGF8COYv4x3JY
BCUqjeAP5z2ViwxdbprNhIbg9gvMuF5jxVzsAvyUVpVyY14qV2r6XUabkBzVkkUG
4bvyyE2hzBjjixEiOMarinXBDVdRjlf0/Cf4+o9g+QrHqmFS3AEVC6/sG9yjXBqi
We/3NVbEkyxK4TT+eyAK1hIoVuQyHaxZTpFZuyfrSfjAb0uirQ8aVQMYstiOe8p2
Mr7qHlJ4vVfnmh9X2sel+Ck+EhzptVpXPnfRmaiK/jNj0mSuNuI=
=2yGW
-----END PGP SIGNATURE-----

--Sig_/+MJ=v7zwCerCYO3j3qpjScx--

