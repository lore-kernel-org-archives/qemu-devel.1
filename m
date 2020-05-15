Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7573BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F19204EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="irTauzjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F19204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYJH-0004o0-8E
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYFx-0001jn-Lv
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:11:57 -0400
Received: from mout.web.de ([212.227.15.3]:51545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYFw-0008ES-2F
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589541104;
 bh=pWY/L7DWs+7R8NUfCp6QCm9+JZ2p1vUInbQcNyL3ZCA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=irTauzjl8FVe6d7AuecgybIhvkC1i8tY78hm0lvrZipusXvW31Q2ZApWTHNEq8B//
 nBNMQcoHxCUXiGAsWm36mS1VkcwhzqvzfdCuXXYOj3YY+Ig+sZrjg1oIyaIMDzNNC3
 XWk706uekyjZuJBJSvMnYjDnvvtVwtL2UTUAWlDA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqoAk-1ivWft3RkQ-00eJUM; Fri, 15
 May 2020 13:11:43 +0200
Date: Fri, 15 May 2020 13:11:41 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 2/6] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
Message-ID: <4a0a27a167669dec734a37f0d3d3826ac131db4d.1589540787.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589540787.git.lukasstraub2@web.de>
References: <cover.1589540787.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/__QCEQPc=wBcBl+1KmXIssA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:McYHL0e9SZlZmB06/zuVSjXLkTIiftNtRSumu5NPSErgCBw3gJI
 fczeYLPlCkvsjDwhyY4Dls0LjCzW/6RQixmhbHCfcgmEiUKxgN9pdqVuDfyiIGqh+19REUx
 wPyyH602ih2qHdIde6s7WkAwsl+kWYz8eqQU5d2qX+XD0MAJ/RX0BVTqpfgGxa1BSh1Sj61
 w0GWJwvcY4enG92hwoDbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sFo7pLeLXTw=:SkVirIzxt4fIfb/e+CKxa+
 Nij9uXxeUVlDiZnLlj55C37lLcl/DDboPTNJH3gN/gJjSBhKhLbf8/IPIcbl/t1LsJfJPWf1G
 2VkH1gDzq+XBobKlSadYMmaD0CBFiThhFTKTsGxm9o1bwseU5d/rLWsKUojzZffsgUFDrXvyf
 dRNeQKBmkxHso/VTu674qY5VGpG0BXVMMfCa4CbeTHInXPGi3Lv1TglyVQx1BkzEe6SSwag9F
 sz8yWL4XvORsKdU1A7dJrVCCufeaVSyC5OoJz7RzUDcgCSl/99+Dl46WSzKnF26ZfBvjFpV3p
 g8qTqBkxTteeymeP1i+/LSUD1V0GJlTS5jtEBfk45Q39gHhrtjNwPGRI26V0iS9NS0fkgIDkQ
 6DnepMdyuFOdd16nJiOFM3UrqZkvUAZotRsf8+7raVpww3i3T2E1heZqTP2B46tVNuE8ZNhLU
 7DVB9kyvMaI8MLO25wH66vrt8WfAfOb+BeOXU1rkIYGrN21Ge/OV4sALjDYB8h56AHTbkxrKG
 PxUjpDaTqWqM3f9GrO44brK00Av/ykcoKwW14Z1tFcwJP/lVp50rROsYjVDA5gM0YbzAsMMDY
 LLPToR3IyWTtHWub3re8zUFMBlIms8wWSS7KZBVbjdhDIljnyOStFcp/vlILQGKFIApqq0T8c
 B4rP6Aej2pmBZ/NKDjrBKlRJQKohKXFMfshNIp607g4aXcRWHlPeinHhbEoYDOggTJQC9n5iN
 x8V9bTk2uj+yyGs0FDKF7Q8IxpRWfbu+ZJ9BNCVfXTRIKlR2M3ComeiCeXDHO9/8JY+QpAOCF
 /Lcgowv3PbZOEvyIL3IhBk+LrFmRS6qa7cKRQ5quLzSuo8j/eBZYxFF2ntRTPDP8uEN28046/
 jk1AliSurfp6ycTU3JH0VpbSYkgkbLDl5B/VMlghtBu6D5C274BWRnnRsYcUqeFa5nQbNqw9n
 7IAeTnNjtM+31weC0aYAh/UojbPlfJV5bdvBY7N4pVhc2O8JH7wYl5bl3ek4VE+q5k9V8EmpN
 YswrDv0qbJ9H58WbKNHlPEsjxMKILQIrS6dKDVoaNuFAEF/keU8k5iQHfVqzFEwyQpOSMSxpt
 hJQtoGMmI5aAunHoYGLz8IK3gVYHCT5sZrifew/GURJvHfc7gE6lQP/g1W7k6y4HajeZhroNe
 62PTiMGOIdmspiHpUkrhN4U9bd9JgE0NL2vU88QSr+UALoxBYfA0DWIJKjj68Kh13hqfHE2qz
 GCkXa8HhaZIufMQjc
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 05:48:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--Sig_/__QCEQPc=wBcBl+1KmXIssA
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


--Sig_/__QCEQPc=wBcBl+1KmXIssA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+eO0ACgkQNasLKJxd
slg/Tg//dfMTVBTxNvTDUtKBHLIBSwGfkXZkV6wnEsIHYT0wLDv2zPrEaMfk7NqK
PWbDnqi0S+zLe5C+QtD50eDPbMAupTXYCr3aqZjnntdZIzgW0gLwcow4Q5FIrRmL
nOmiByJ5cQTQ9cK1acPBNX/DKhlpJlC8Eyak5fRGvos7BoFneeLhCwx2LP5GnSYg
ZujYLgdHwYo8npgK2vTVBDrFrIWVARXUyXXwpX0Xq/RJf1hpME38ELw5cMfzJw6K
OMZgkq04DpwUQKPzhcMPgn9dqn7uikoM1IytUzZ1JIzFcVLe7g0iViLQnA8iGk1m
o8BG+skPq7wsxuURmujx2fvNcG2er19fL2FCiaihQma8Ozu1idf3c+8VHqmOZW9T
VsAv5fNIsDlQWKbj7p62q5woK+0TgfGQOTxaExhtuff/uyTIzzNCeeB6Ke1cHxwg
uawoN8Wkqepr0tX3xJP9LGjK8Hn1UQrR2uH6fTtJaJW5LvEmpQGP3e8knyTpF6po
9JGt3rIWvATfHxVRD43iX1ZG9ysiFZZhCLiwtbqpPCeJq/of2MrBO7j4SFTuYWJK
c8hHvB6Shsq2E4Kgi7OhJj9is90E2dDcajL2XvA3HtKppR/WcfXe1at0FAwrYli+
W3CvaQ4ullbHsZdeLD3O8c3JPmFVQ29bnEriXyFbF6yjHOVZDTM=
=r4qb
-----END PGP SIGNATURE-----

--Sig_/__QCEQPc=wBcBl+1KmXIssA--

