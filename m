Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288E3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED11E2065C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JR3HRrRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED11E2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1bN-0008CW-03
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 02:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TD-0007Qx-Re
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:47:51 -0400
Received: from mout.web.de ([212.227.15.4]:38647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TC-00015i-DM
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590130056;
 bh=CNbl5+1Uwmg7N2/0VF7Mxo+xS+N3Lz/h8u8/y0OTFF8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JR3HRrRbM5rXcwtk5qjKxitJytJzbMknHG7Ch8IpHRGhv4VrYIsnKpTi+kIibcAr6
 TAwYxyjteQCINCoOzH/rcYkErJwYuj3q7k3t3m2AiXyfFpmwr3tdwE238Tj7ikIUZq
 5GRy0jXAk6ZYtwb/V83/JqAkjIOUmwUJheMUPpvU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.67]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1j5gze0IYI-00fTl5; Fri, 22
 May 2020 08:47:36 +0200
Date: Fri, 22 May 2020 08:47:34 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 2/6] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
Message-ID: <825997b334c98a48543df66ec3dd0caf670f6dc7.1590129793.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590129793.git.lukasstraub2@web.de>
References: <cover.1590129793.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d7WVS_Kr.YJkCrNunMkQ2UF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:CodRI4uaUsPjbwHWOr8hbiBqqyEvq5qA4z1yzoB0/ZUZ0AAa/A6
 c0cIjAatQszOTtMS2JnNvZf3FHaICGn0ert+Ulw/8zljPFYENgTkQOKnzfG5dyFv9LOfiHD
 2db8/O+Npz3YfQ55R6ZeoQkXHiCn8MQAnbMny2f5PvllMpiM8PmihjkNP1+4x+Zk6ZDN6fH
 LByvCaeBgZbk+cBLoJmNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Rbm5mWd3qk=:XVYkUI9RpmOSnQLdLUxXuI
 RZCljwqOZTVjw80xaknR2Ka1dOflihQFoiVOYIELcNmb2wsL+HiODIxGuxpN4qxe6Skwp1cWp
 Uo16m2g1W5hgQTUT5A4sWv7MpQ9jTBxJvmq9u4waY/kTLKCO0tqfb5eSO7WGJ6YApamuAjrMp
 Txs271iGRYueDuDFGJ2R2G+Zm/DyEz+OntS0OeEVS+V6mBJLx1XQjV+4fp5oqx7tDTnfbTp93
 FXw6JPvyoZ2Kci2Yt8E9L93JdjcHWw3KH2lSylMv1NQ6utdsLYqwx5A/qGJO7Lupsrp9F3in3
 uCrvMTFft5L86dszan+3dxY+bZiTabCaEUC8XpRrA9skhXJnKmQ3OoAkqO0f2e/7Gzgxzi4vv
 3a5URfbLRsfk7IKvJb6iJgEefHlwJLpp4qQwedR0lCMsviOws8XyDacFfu5yicJNhs06kThZa
 cdFRlWtqIFrTegzc/B3YkOQ+iuAc854e8jW2UG9lsw6J+fotfBfxLrvhAwofEKamsdf7fQaJU
 /IOFiP+RVgOqZoK5+1QpE+mR42SFEyvISOjeYxm2Z0ChFiv+1ZoPaeK1fsPMBTVPMrPjGzOuZ
 27mSD0OZcggFZZau/tJv8X/4EgWCaSAbM3FUZ2nZkVyqZ8MT/6CT1ZO7HAkLo8/vSF+atiSjO
 lF6B54fVSkU4xPouJaiHoQTtxF+FOcfCT4iHJ923sVyK1b77CQ83jyXuyfFQqixxsx9USHb1Q
 9dG5DMzjZVw+Uwj9xESAkRCupU4cfDrGEHPqqrni2GugNoDNH7qs6PxPxU1PjBkwWH53IwDXo
 KOd+zeHItVuEOg9smwPOh+GsJ2vBYuvPSZ6VShuKQb9lqwSv15HuaVW/iu8UpbEQJPVoRZuDc
 gc5VDJJugJqymfBwmiY9+V3Hh8a3YpPSU1aFjkZ+DloaqIYgkDV7XSiEV/3ZNCiZLr6LrsmpC
 jPY/ygTBk1pxWf72tpAU7tE1z/iLNpsDTdFO/bSJwB7CIzBFm4ZxB75JZ/9WRFHzgRG4aeq4z
 H8z05VRWeB4X3yB5wCE5QPSt20Bn2nkixYwj5Gk1kK2hu50sSnNTj8AMn77Jo1u8fJvGL7F7Y
 EsYVrjVzsP4Fgb28o2QJS2ODyqy63IcfAXLmotWqqEOj1jxd4Yoj4Dr/neJC+U2Tc8b6GZWKs
 RUT9xem7kG5xkqxJuIA4+w+fiyFpxGZNeyyYDhiojvCLE5p9uzBunwClfi4rVOmUMieJFsyJa
 T3RhBTlDR+ZULqpXW
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:47:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/d7WVS_Kr.YJkCrNunMkQ2UF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This will be needed in the next patch so compare_chr_send can be
converted to a coroutine.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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

 #include "chardev/char-mux.h"

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

--
2.20.1


--Sig_/d7WVS_Kr.YJkCrNunMkQ2UF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7HdYYACgkQNasLKJxd
slhdyhAAkUJ5iYmqRr1BtRz9hfBkFdkSew1DkorAVbSovgoiJnfOYD8uhPuA4yp1
+5G7JH5NDFphtFUgQMULPLQ6cOL5Bg/QEeXllGiRkZdnVwzPtgmiWLoiLIMiTryj
3avQxGvOI0ufNMSwFOAyD8fhp13M5t0PxVufbN4vxdt1yw51VIfVn1F/bx/HS/Qc
J2hkXz+Z6XlrtpCJ7FH7kXvXL1qs76FjSYxF6rASN71P0cnK8UmLUW43eOYIwMs7
i2tGDRY69aOFkPM1e3W/iSXLTL7WU647q9XWfBPUzY8mf1O6wzt+tl1IzlRdD+dG
Pf1liX84ftEdxDDAZuIRyR/gkx7+m0fVdn4KIJQQCpwSpb+MarE55qs/0BXa+tPg
HdT16wjh/2cs95ZbWzbIlvN1wuNPPdM/+8lE+HzQolgkv1Qz/0k+HgwYaGvKH4h9
741wMuou/y9iky6Ob7ANx3as4xLY528BxKIzMUq4mIUkIVDPJQS+VAOYlwcSk8jS
6o9ruKImKULcopjDtVe1yabxupPV6he69cj8rIFmpvbxOnIp7WrB61rvItxwHNBm
N+IrCqsCGUT0RHh6/s069wmdbFAy6qLCZYkAWC4Pm3LkMg+L+aQnzg/LfXSEakqu
6cTIY99KUS8/VNB3uqP8XyWODrlcpswEJZ82K6cvsB2Ia1eqR9E=
=KkKo
-----END PGP SIGNATURE-----

--Sig_/d7WVS_Kr.YJkCrNunMkQ2UF--

