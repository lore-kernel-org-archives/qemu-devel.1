Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BA5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA8F20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="r1t/iVmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA8F20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYOc-0000Ab-4W
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKg-00074M-Jj
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:18 -0400
Received: from mout.web.de ([212.227.15.4]:58221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKf-0002R9-Gt
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588588083;
 bh=49rFwmwm3wTNOlxvlHpbJp+Nr690qaVX1fypakIKSro=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=r1t/iVmqBUm8evnaVtQodqdIi6IGNit+KdyXnNH4OtE+gl9cM6PVWnfHi81kxi2Yd
 pg1zODwoUXs5vZNOScoNORIEo1SQ3XfG4motN785xqc+iChGR0nXqIBKE6Ae8g8DmV
 0YPta7l3jrKhx2rn/1SI3eimypKWDlJAnpAIxB7c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.27]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJCEk-1jSnAu41Xe-002pe0; Mon, 04
 May 2020 12:28:03 +0200
Date: Mon, 4 May 2020 12:28:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 1/6] net/colo-compare.c: Create event_bh with the right
 AioContext
Message-ID: <b5be719bf9c438ad4dafdc2fdb4ed87159065e6b.1588587700.git.lukasstraub2@web.de>
In-Reply-To: <cover.1588587700.git.lukasstraub2@web.de>
References: <cover.1588587700.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s6q0XVhHqm25NT3YOV5nWfw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:A77I2kLsIrVU50R5laHuCTeEg+6N9tbxM+JO6wyoOcbgOIjoKFV
 tnFBFakp0GRln9b+ZH8KarQmRBcpe1a3mGSOOOpMFRSXAu9d5dr+W4mRGKU93t5FAS6/1Rs
 lKXvSZ3VEEZNbuGIlJI6vW+xwZ+iDf0WBxwhtPgUIpjtIx9OXTAj+1B7zve8yJdhHMZ0C7F
 7oSFphdaMNSbKVXFd4Q3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gcz4lEaoG1I=:Toqs8isLPKIFtfp9TQ/Li/
 c2RaZ1HD9wVECJzfnKvOG9DnB6c+QLXDm4UnhBmqJdEjWjtryC/nHqvGunxAK3jfZcQeSxG0n
 2bLndZGhhq+hIpuCZIUz9HeUKkAYKzFbtQrkFBwQLGxc+0KGWWmxhrzTDFs2D4mpTyt/0+k0F
 T7oLlLdJ7u/5JqwXmMg7bViyXb+73RJy0M7egD215YzvL+d8Ax6rSEijz08QGmrR1GwuTvNk5
 Xy7p1NIdFJ1FZLlqv1R1BJnMR5DU0AEiSIjpIZ64xD683DKpmsJr0ql7PmuvZjCeGKvHEii8S
 4x0b8XhMdmFKy3NUZR7X3IYJGasFW9Fnib1FVhCR4r4Cbdjr9ElXpZ6axIA8iyEmFPxTvCJzA
 /zfCfEC2BSB33xr1furAlwrWwXJYAhz5pdlJIaQt35RzC1NkoprpOyPco8RjUKyn5shdiT2mu
 pP2YBi106wYyvxqZrkOyqca9/z0c7weL/eieTIJduUnW6Sh6Eo5ek5vu1qaIa9lQJHa4SjoMm
 um1D+/XK0/5ae1ysM+1ww5JEa4PPZIJ9zl1L8AgfB39f2K+VguIdvVy5x4+Rl1/QKofjBYk5q
 mZyqodno7+zB107jLwHQ2MtsrpFEMFywzwNNJ58x1KWbjMC28CnFhDARS6WURGkKO7zfu67Wn
 1Sj0geq+SKO9/e3uj0hKahhLmsXXkFMsc80ShBF3K4b31kARaubjDRZ2q2GQAyiIgyTMddk0t
 1tweBga2wKyeIqQW9ZMjUGOvVTBSzbORBOPW0AFcShncJjA6LvVHRGDAU09rZ2gzaIyHDf2Wl
 fNuB9vdisQ6wPf3aXWAFvP9646eiNfji6K9FZgGgn1md8syla7rcg0ty9vYE+Xo+cjOWPk0mP
 +g5P8Z8PZflBZOO8St5f5KAeLM3NdIeFOPr2WHW7zlEWLamVYTrZ6x3kOWH/m5IigjtSBXsjZ
 zvw1NUB+N9lGaBVx/VWqNqwH+f3/1v1F+4pspIPIRomXTM+8sr8qMWrYmJhQ0XstED40zPy4z
 XSHi2oxpsZW6En6vFWZiSnUMslKuiWJxX0YlauSvtvmO7n53cXBkiGf90r/UFOu/m94mDIt7J
 1fSPZKWYqWHsn06NH9MNADL37CuyKnVf44vVHTi0MNoVUBSB4hbamjXLLCzqu/iV9cq+wpdYx
 yBnVYkidj3Utxceivf0CyNjJAu5fQBeE0aFEk6hxh9fKqWch4eUHHKibDDY2A9TO3pp1NDLqB
 KhX2IhXG6ltubtSrc
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:28:16
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
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/s6q0XVhHqm25NT3YOV5nWfw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

qemu_bh_new will set the bh to be executed in the main
loop. This causes crashes as colo_compare_handle_event assumes
that it has exclusive access the queues, which are also
concurrently accessed in the iothread.

Create the bh with the AioContext of the iothread to fulfill
these assumptions and fix the crashes. This is safe, because
the bh already takes the appropriate locks.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Derek Su <dereksu@qnap.com>
Tested-by: Derek Su <dereksu@qnap.com>
---
 net/colo-compare.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 10c0239f9d..1de4220fe2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -890,6 +890,7 @@ static void colo_compare_handle_event(void *opaque)
=20
 static void colo_compare_iothread(CompareState *s)
 {
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     object_ref(OBJECT(s->iothread));
     s->worker_context =3D iothread_get_g_main_context(s->iothread);
=20
@@ -906,7 +907,7 @@ static void colo_compare_iothread(CompareState *s)
     }
=20
     colo_compare_timer_init(s);
-    s->event_bh =3D qemu_bh_new(colo_compare_handle_event, s);
+    s->event_bh =3D aio_bh_new(ctx, colo_compare_handle_event, s);
 }
=20
 static char *compare_get_pri_indev(Object *obj, Error **errp)
--=20
2.20.1


--Sig_/s6q0XVhHqm25NT3YOV5nWfw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6v7jEACgkQNasLKJxd
sljHBw/8DAicldDJrVDdgKMBKAJMYwACttCjljfnSd2/jqj6BxvhrHH3qMilPeBN
mtrzWxU3A04vuMB7bEpFDqvjMj3SxJq30UZ38kYv2R4sIAO3TKJmWzbFk9s7Jm3i
QuExC/U60VmryFzBeobaxQlCFOfqqKbU136jJzTr4WK8m9Fpr/og3C4y/GlKAq7i
+EZOZZtqC2qk7wnCt2OwM7y93KZje3Ba8AvoaPATsXn36gxtzPChDIt8WmKT5x0F
bhmam5E1hp7oZ6kyiohI6A2mJKWN5r/HZCWPsYE22oyTQ5IN8ld1gZZyolLIDx67
nl8p4UeNlQWxTQfwpSFZij9QrXHj2/3R3cZKzsoDJ5x+/f+Lh7xhOZemNRvWLxFN
YVAOPXk3DmD6SFP7HyYy+PiskSVhoUg+DfCJnJ677AdKV40GAVk+wrzs5gAUiYwe
jjcF+jXZwq1UZxDQY4Vedm4tJMTyUMaxZ/PCGNPHtycxxGLe+KCq3slWJI7NjBEO
Giwdgd2GK6F68f9y5Yo7C+7PsCfAuf3nATnkoojwm8zGsMoENp346qZU+uWx+DCJ
XllocXUq64LMkplauAyqAvs13k/bE/Pl7fWNlI1KZCZWcjDyftdfUIUxyBHBGZpE
oV7WQTYKkThLk9ZqwNo/Sl6xa3hSdU7M5zkzz2YMexKLxIEKJoc=
=6Cs4
-----END PGP SIGNATURE-----

--Sig_/s6q0XVhHqm25NT3YOV5nWfw--

