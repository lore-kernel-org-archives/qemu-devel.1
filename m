Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E28C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39FD206BF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="OF9jbFvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39FD206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSnI1-0006SU-By
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 15:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmud-0001Ce-9R
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmuc-0005kf-QG
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:25:59 -0400
Received: from mout.web.de ([212.227.15.4]:55933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSmuc-0005h4-7d
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587929144;
 bh=SxlQe2CwqaYOqz1vCvbqvBcqvHod26E6TNFCs9tSaPk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=OF9jbFvc4e23YG2KLX13/j8t1ExuQPQ3kC+4Fnq0bUtvBDyxLd+CT8i4KGwbwEaTC
 D6Io6/bylklu7p5y6hXLNioI3LlrslPWAyGTdqoWo7zcfa34t7YyTYdHkfSPPAH2mR
 Ty2coWoDT49oDIY0a43Q6A6gSO5mMQDDikTVjxq0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.95]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeBEk-1jqOrW1Pna-00PuwV; Sun, 26
 Apr 2020 21:25:44 +0200
Date: Sun, 26 Apr 2020 21:25:42 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/6] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
Message-ID: <be38e52e55c46e7de8ec23924e4f1a0071969f6f.1587927878.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587927878.git.lukasstraub2@web.de>
References: <cover.1587927878.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Aqe2/2N_.tbJ4e=37ffi_AM";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:2g0REWAPIPYjxMb5/6MrQGa6gM7ymM0942qnJLo/vDtcq9ytUOf
 JZIY4Pu4IGkbb2C8CQzatm8pyRGfHVN1RctNP/lXH8qlAy0jfxsD45NSY8xe7wnFjCfwwKX
 /vKE9jx05JOeHKjv6CCzrs68XEsO8N8Z5UekYICXk73TLHoLm/XmSKHELSaj+A87BRxW7Ye
 ESphm3Ud7zopK+0jZaN6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TIi3+7IszWQ=:b43BOh/4dXD+72dOzSJtbo
 BTsnTbVYbsdbyIApiBvg4wMGhtLc4nktV/8bZER5Ifh9/Mahhg6Pb3V4Hg3PGOuRyKYo3jpSr
 G1iFF371ncDL9r90f4un+i4Ra8suINGT0K6F5BGMEOVK255wRdRC9OTaebr2sCo8QUjxj+T0N
 fbm//ej+8pFhZdYZHRSHuAh1fLho227Yagr3U/OPaDDMniM+z8bHXpXxgcjlVfzBV2n97UmnQ
 t7TnuPJXfTeIHUtRX1Ci5+b6CS47PEt8yeZ+8qDGqLdB9Lh4EkxjN6mDc4N3zax35l4V8J7uf
 a0pKbg60i29EO5Y3G30f5KMFd+ct/oTOI4HNIstIx+d+RDAd5CBlZCpuTRz9N61Gu8Ns/vcJF
 s6/8zYkvdqkxLmpvgzm2vn79HPSQT2push3tY6VgHkGM8WSMHIcG44Rvl2LVCeqJ/EWhp1DXE
 rcfa7/+IjMUW0O7CIliDt9toOaJjfiV7r+XmTWu4fBdO3B3LcPGib1SVQewT6aIum0ABNEIMD
 zbG6cmh65lLN6VI6HGNyfmiQ9GBTddFRqPlGAUw5NgF1OKUqwLBf7UfSSF+bCqyiO7gHC2rw3
 Xm7cLdwlWj3WQ23dAH8inGt8+AkPHLzFjGprZsvDDID5Iigrtwl1UmmoV0Xe2IZRQ1hI3rzet
 5m8lXqzW2yLWjQqMtaBY/DNDkAlZDz4ZtU21vdbjX0HBh6V38KXMpvB1ROBkPs/SgP1ccYPvY
 VDK27iVPYw/k+ySn5Y/jEElNL+rCPmhbVLSBsYvXQyfoifCU+NkketYP5akiaNu6SYGFy55Dg
 eiRcSq1IcGuCfHDywMAO3KRW/FmsuKsG/uWM1nVNlggEjOflvKXKFLbqblbulleyp6Vcipp9W
 jmEBcKEvvA+UPCSFxWVWjFNOOxDXd8mDW6dEDpn8r5ApigZ5aZZFzfkUspq3BuoRrpeDqdtv9
 YJvFzXemDwrmQ4GkLMSqUt6OBuqKCo0Zv37w8h0JkbsgmTfILQ4vOWoLx2SUxU8D9FauL6QEb
 9A3qQoDlCH6hbOFrl5NiD6ycam3i1LWjR943e5eaaKXDuOsi0duaD2Lk3gBPG1rpj0pO2CK5j
 exx5Tdr/UCMkoTcR/kpxl61NxYZXh96evMHk/JPcuPMC+DLhkTflgtTy0tKbeZfVTOa5Ojltp
 kTxNV5Q4a7PC2/lCVOgo4IXg645d5owcWGC9tFvU0cpI0kWq01SacdWjVpYs+ysM7HPb7yTT+
 qa8LO2vE9yn0PWYFd
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 15:25:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
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

--Sig_/Aqe2/2N_.tbJ4e=37ffi_AM
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


--Sig_/Aqe2/2N_.tbJ4e=37ffi_AM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l4DYACgkQNasLKJxd
slg8vg/+IrcyluLr3HlgdEpvcoJbdb0bZYpQ/v3Utb+ElmpZaEqjrLtXMRUPd1c1
PS6y8CIt+F3D2iXvRKPtlT3Z698XS7WbiKNTafT19oyxEOHvta7zmps3iPuDXrz6
LFnhO14zhloajoZcsX104ZsIye/xzXtUUc+rIAgGkXaN/DQwp19M0fGPAPmYfgWl
BkQSChiRr+o4MzKKXS2tGmi4Shc7CTsclcYpYDkVzL4gAadWEPePilZAoH8k7BTi
cCNVRVB5soCTY2xFSMwktY20inwddOwwRyty4nuCCfSdFuX9qw3U3/8TyKfxgQh2
9v/k/UaUGUxtgCP330mLPMQ5gW405f0e+cp0aVpjEm1B2xuUvXrQW2/3xCh7Uynj
2ed6BccdA7kMfUh0BnFOn1IjLf3V3P7ISedj9jnHYC8e4lA7gR/M+CjzPALk3L/G
yYdtl0+HVAchx2CL/Li6etogVMwkSzdxmEL5KkwCDfuezx5ZNQzP0OGVucZ8VVn9
FvNnk1Huzgo5irnrI4J47GiI8NXzhOS8vwfbHb8QW9mchaC3FwPYmI80D2gZnwiV
U4OEJH3ckCq1ndXJNckZvOhHFlrsxNwo526fo95xr8ZdiWAYmDTYgx8wHw9HsAhZ
wHQacLSmYAINTx6LMlgDcXdco4z+3WRyPNo9F/JGvqe1ZSzHEIw=
=mqPJ
-----END PGP SIGNATURE-----

--Sig_/Aqe2/2N_.tbJ4e=37ffi_AM--

