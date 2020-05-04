Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A901AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D46920721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="npxmX9eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D46920721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYOt-0000NR-9q
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKw-0007LX-NH
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:34 -0400
Received: from mout.web.de ([212.227.17.11]:59015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKv-0002XK-Ri
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588588103;
 bh=1PEAmI4eLur62HeDyw8IJBHKMyNIrICq9UVOCcvqm7w=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=npxmX9eG13SYR2DYHFuFZ0d+FaTGB1NTTyxVn0qivcj000da/9h+P9TVrmRL/L+fW
 IEaVXELYIvDh4FoHtDP3rGY/20vmLEzPXr1LvB2ySjNaChHPB/6tVLuz7G1SyNGirL
 O+ytSgnmW6lVYniKkdW4PxKx76iEXPAvqK3ff78w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.27]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyDlZ-1j7x9W2lHh-015bAp; Mon, 04
 May 2020 12:28:23 +0200
Date: Mon, 4 May 2020 12:28:22 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete and
 finalize
Message-ID: <ac784f17537184c3ab8c745a1d593b02bde85738.1588587700.git.lukasstraub2@web.de>
In-Reply-To: <cover.1588587700.git.lukasstraub2@web.de>
References: <cover.1588587700.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3dCsORbj7GkSjgyXXBr8QnA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ZrIXpi9XWGB8rIde8YXIlnuIb1OKTFbnPcB4xx/M+8p8E65iyPA
 JN0QU17MEcb4mEF4MqFbXrs/ifY1aaBmyW74NdIhBboKQ3AmjmHRbjHatp0mkSxAL59sGqP
 Va6l3fZFGyUmzYvC/DsAu5frntfBiWz7s8fc0zO+NDL0/luIFCWvtUR90ycehuge1+P9jLM
 oirfo7gev78neZGf4Ru/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ohmuhy9nxWQ=:vsBQhhCpF1eNUpRgJvYio7
 yy+zZT+VZRHhWYRa9bR6Y/7FkKGUh2J8mDMwWGdop6Qp677Iy1Z+2bhr8J28zHV+lCC6AU3iV
 vSDNUUz4Fdpdclpn3hsEM/Sj8ncwTB6z5cF3mBNY7N6h0fX7emBtw66Fla021n/nHWm78Z0lW
 o9ThFCrQWSmpBuHr2dvEH+vZNQ5D2E2ZR4w6+JowFezmdGFp8pF9iKuMjdT4N4TVXDPNF4eLo
 CIIiXUrz9gm51ZjyM1KsdycjN+62vxeIOa5dTv5sJOIkJB707t7o2ybMOxCAzjJYZT0ThenrQ
 T6dpqi7gKThFDm78u1zMF3P754WxRa9MHZb2rpMd78RmvMUFy4MGAKFY3oVLhDroClFsNr3dl
 ebLy95lhF0L7FEciDpDx+7ptzXgpstd9+B7rqoz2+oqOAnTIARkWVjBV0Lt/VYCi4uFaPqw15
 6B4AKYBebQgPPKPXTCvVox4PK60HE8Y+0mDcE7UuK5pK0+n3E+JIaupDaWgigp6CLwffqoofZ
 erI5NvnhrzGWSAT7FVdVWu1DLE4IGhBaWf7/b46fXwwWc5uykh4mVrvulZTPGEWKxLiuRvvD9
 oDIqzzDtJu+wVMijOfHjZdOIYq3Ky7siW2U7ESAVjUbjN+dk6wojOYG3eSdp1sQEOZIBsIqnF
 Ml8UIzW8k+fS3VfqcJEizV7ed+NOKEQfCiXtR8ccfJmsby3r7JOn5/hyS8f+TreXKfRznJ1LO
 8QiwSbQuMGo7GybHSxx1l/5jG5VYqEL8Bbp/TpGkqN67S0V5gv7TaoeWlGtBrfOdckYmJ7O1A
 MlaKuphxYDfMsbmu4iUyvhaMRNYvRq8rvyYgHHhxgeH5cYqGx5lQS5EX6iFP/m16VHvl2eole
 8C7HS503tk/sdAQ5Us+SoJdcSJBHMdj6xje9+/dvavz1Mhbn97K2cFjC/N6319MymZYzYU6M7
 t3F9H/cXjMkNyA2fYmeW1wBIl9aAp0FBiJ/Pm5twxZ+kjIA3wKOS0JvhyJgc0NBCzvQGkNn5a
 z4H63zkf0xqW5Vo/yHNkyjNM4YsGCc8l/ahjaHFl8YXlzYYtJqSl/J5h2yAbL6W9uL23SVlKN
 GceOJQsFlg8Z2bX0DheBepxijtj2VVMWhJQ5j5JQkIqizlu5xW3P38YE7C/Frn3kDAkYuvhKj
 xg5Xx/hUKWBFT1RnOrmydYzpESX6+N2dCaI/XAqEtHMmHJcsnf4AeZJEwIhnXhm3OR/1p+VuB
 ItHvARU5gd+52qqAT
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:28:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/3dCsORbj7GkSjgyXXBr8QnA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

In colo_compare_complete, insert CompareState into net_compares
only after everything has been initialized.
In colo_compare_finalize, remove CompareState from net_compares
before anything is deinitialized.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index c7572d75e9..6f80bcece6 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1283,15 +1283,6 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
                            s->vnet_hdr);
     }
=20
-    qemu_mutex_lock(&colo_compare_mutex);
-    if (!colo_compare_active) {
-        qemu_mutex_init(&event_mtx);
-        qemu_cond_init(&event_complete_cond);
-        colo_compare_active =3D true;
-    }
-    QTAILQ_INSERT_TAIL(&net_compares, s, next);
-    qemu_mutex_unlock(&colo_compare_mutex);
-
     s->out_sendco.s =3D s;
     s->out_sendco.chr =3D &s->chr_out;
     s->out_sendco.notify_remote_frame =3D false;
@@ -1312,6 +1303,16 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
                                                       connection_destroy);
=20
     colo_compare_iothread(s);
+
+    qemu_mutex_lock(&colo_compare_mutex);
+    if (!colo_compare_active) {
+        qemu_mutex_init(&event_mtx);
+        qemu_cond_init(&event_complete_cond);
+        colo_compare_active =3D true;
+    }
+    QTAILQ_INSERT_TAIL(&net_compares, s, next);
+    qemu_mutex_unlock(&colo_compare_mutex);
+
     return;
 }
=20
@@ -1384,19 +1385,6 @@ static void colo_compare_finalize(Object *obj)
     CompareState *s =3D COLO_COMPARE(obj);
     CompareState *tmp =3D NULL;
=20
-    qemu_chr_fe_deinit(&s->chr_pri_in, false);
-    qemu_chr_fe_deinit(&s->chr_sec_in, false);
-    qemu_chr_fe_deinit(&s->chr_out, false);
-    if (s->notify_dev) {
-        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
-    }
-
-    if (s->iothread) {
-        colo_compare_timer_del(s);
-    }
-
-    qemu_bh_delete(s->event_bh);
-
     qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
         if (tmp =3D=3D s) {
@@ -1411,6 +1399,19 @@ static void colo_compare_finalize(Object *obj)
     }
     qemu_mutex_unlock(&colo_compare_mutex);
=20
+    qemu_chr_fe_deinit(&s->chr_pri_in, false);
+    qemu_chr_fe_deinit(&s->chr_sec_in, false);
+    qemu_chr_fe_deinit(&s->chr_out, false);
+    if (s->notify_dev) {
+        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
+    }
+
+    if (s->iothread) {
+        colo_compare_timer_del(s);
+    }
+
+    qemu_bh_delete(s->event_bh);
+
     AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     aio_context_acquire(ctx);
     AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
--=20
2.20.1

--Sig_/3dCsORbj7GkSjgyXXBr8QnA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6v7kYACgkQNasLKJxd
slhmeg//cfpiGsggL6H+g2/2NB8kMh7/gKW/OjKr4804jMiRNUQbAKCmPLa5oGUD
D1S9YigJeEn8dpwn4kNnzIj47JmdM1URcZm2MGLTaEvRl14xl9YA80C+x3Xge0T2
KjAXPQ7YajtVrD/J2g9u5khpD8PnWcLcPShAZUrKJrhm7uuoikBqohg6HLjGqo6U
kVZRlTVwkHPSd7jZlhwmNjItbNXNtNiQfuMBhrydIaMtfUWY/OM2Ag6IWicGCvp4
0x29QrnPXfWqDFvoPtrHWJ47DohBLHoQfx4QTionAw2ai/VCUcc18U/tlJnFTSYO
tDtY0xrmE3/daurnTKxyncLf2zZ8ijjIXee0DKiYpKGFLMr/E/SvGy+dxXqbXkjl
iZBEwNvJLlndDpu9KURVr/ssqboNr2g4sAILGbhyR590QFuPB9cXXXJEt9B+Xmxk
/gSNL+iwFzZNlDRcQyzzi+sC2HMukImuAkK5NQm+NOX5BXfTkHQoqjynGwnXxilI
OLisWlzJ44YsJSF0Q4p6/n0udbzKd9jwycUz9LGDh2kRCGD3961FcZ2wJQcbkqRI
4q2i7MhLnURwuyeiNcMmZabf+1lGVQA3GevW4bUepZYJp0gfWG2joybouDwzrhWM
OoSxDA/j+hDxErG0QBYGe56ucp3hwAhKIUQs3BiLoePUtuBeJyA=
=3r7q
-----END PGP SIGNATURE-----

--Sig_/3dCsORbj7GkSjgyXXBr8QnA--

