Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D76FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD492073B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HaYq5IdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD492073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1Wf-0002QF-Pg
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 02:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TF-0007RP-9q
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:47:53 -0400
Received: from mout.web.de ([212.227.17.12]:37377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TC-00015j-A5
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590130052;
 bh=9du8DWISUXv/co/+RlUnUwDVAZYYzGQeRITtkUXSwE8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=HaYq5IdI4rbTls14a/YlpFcFKYkMKYFLPsCHd3cloW4o1pv9lj1I6GSt80gaLde4i
 Eos4IsRM8tHqKAYNROOQX6mAnfZ3mbc30W3KWFfazyqzc3P4VGlry8aTjSgMp5WYlO
 dk2IsxFrlt9C3oXKZJCb5PwtOgomov+6CpYB4ze0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.67]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Icn-1inkV12ERb-00xFrV; Fri, 22
 May 2020 08:47:32 +0200
Date: Fri, 22 May 2020 08:47:31 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 1/6] net/colo-compare.c: Create event_bh with the right
 AioContext
Message-ID: <b5be719bf9c438ad4dafdc2fdb4ed87159065e6b.1590129793.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590129793.git.lukasstraub2@web.de>
References: <cover.1590129793.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MO8b96LwUIXatbkxjnXy4Gi";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:qDyJRU4nEHuSmr9xphLzWwYzPfTutEdFx6aKnuafChtbu08FEQg
 0ofvh+QdLshw+mYdZY0m+dSIWqDPoMBwHBNw8bzQ+qUBYqEodknTw04vdd7+sS9nPtS2GeO
 ZKsdtQAX0bXnrCwCBAdijCNsrxbtKVxqGWQpHXYL2JZHo4JqFaiJKipK+jJMT69DqKJRI2A
 uII9htBGojYZFji3rHx1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XDbXcSwVikQ=:5BxO7ZtP/4w+FOICKTd2Pq
 Y0i8ThmLuEICBCCcybB9F8yk4N5wSUeoZXBHzvD+4L3ryRDi/I4R9jzgdGZYv4LfL9va4FQXh
 nph4Nd1UXt8Vf6Hd4miJVAjzQ7PXZMPt2rCDhtlH3PeaJO40mqZsdFUEsFJBLVpq+1YiMULoO
 WPHZN/4UZ71OeMUGdYUzpAnNniouOfUo+J7ab47X5XoeZyNcx3qZD8RQbK5gpgymFFFgWQzVu
 f7pOZkPdeifm3kZHpgAcBEHrjp0wFKdKE7jLGcDHICZOWmVDEmalhZBpKJfnu019cMbA0CGmA
 Octm5N+nvPZMLuPhE4wJ9xGAu1V7bqFD8KJDAgAg4X+WmqybRsby4QUhVrkgwkIA6XmPmlSTk
 I7XDdFKY5g8vVFi/FOY13Ht5ECmxBHyCmb1TvvwYUj1HCDWXVkDVeAd4MUXghmPzr7V3aBpVN
 zAOnUK2rsJjM6c52+2xb/57EjETXttg0IPKxHMJKW1P0Z5ZczmfBnwVw22d31F25T1+5q8TPs
 oDP7/ijqAb1pCssAa0XtHPPxK+Jcs+Dt8EpTdMGqSotIt65bxNb1y62nb9o+wpTGG/gJOhAFw
 ikR4QrO/zCMk+IRH6XSWjq7ce4IvDhIn2mJT5SqcyF3RnxkBQGS9w4Wx3fWvahEPpO3ZeOpBd
 ymYDugqQmVuqWd/xGNTgd1XvRHSp5kyooy7HS2ztZuzXJJ+X6QUvuc9Q8MoCEOjRq/Yi+6Iht
 JjAIf8UqBTmn6s0TvawVl/kj9gazegwga04ej2X8p2vUzbExRN/+T1ry6LYZjrWRvoK//rCBr
 KP9BwkfegB6D+vbe5c4A54a+n9LCbA+RbO9nXgbPDg8768GuR7gdm9/KzVcScqNU2H5cQIUme
 cv1WGFvCbtLxbG0BLwnpbPqw+JLZP5L5M1a7t/A2/K0bLET7BCbTuuS2RvHE2JpUlnuaZNqjl
 0TKfKcg1iWT2S9rOGDY5grSEAAa4/jVH4JyXCT7xB0mrk8/7cojPbKpYAPGEJmK8zkuiVL7k4
 fisXvjD8p5XBWiKtlz2AvudSlmmEJ/cOiVEpDD9lBmzf1tCFH9+z68aPzurZw7JFJcz1ysR1e
 +hTZELKpAuKEI6Qfsx9sUMzMiYYMJh7EE6Kucd0KekwoOveNtcJfWh51E4jI6qki/Xkfzwo9L
 RcFOu5WnOGImh8a1U3GPRHOf+v2DC0/uFS1Fu3AqfqR5u92vqrn+U57Wok1cPsFRopEOiaYHT
 Rcedh6xCkYloUdDpE
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

--Sig_/MO8b96LwUIXatbkxjnXy4Gi
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

 static void colo_compare_iothread(CompareState *s)
 {
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     object_ref(OBJECT(s->iothread));
     s->worker_context =3D iothread_get_g_main_context(s->iothread);

@@ -906,7 +907,7 @@ static void colo_compare_iothread(CompareState *s)
     }

     colo_compare_timer_init(s);
-    s->event_bh =3D qemu_bh_new(colo_compare_handle_event, s);
+    s->event_bh =3D aio_bh_new(ctx, colo_compare_handle_event, s);
 }

 static char *compare_get_pri_indev(Object *obj, Error **errp)
--
2.20.1


--Sig_/MO8b96LwUIXatbkxjnXy4Gi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7HdYMACgkQNasLKJxd
sli+wA//UEVC3Y+QnihaSbM1m7xjVzkdQ91A58is+raoc13yXAlYmfmZB7RB4DLb
BNpXurxciFs76Fe71/rJ/pwXMym+8AgWGENBU4FFdXxR2QrvujUhD/dHS0xeztt3
69bZVxRhihrbund3+PwfuH9jVBaybDp6JsN6315JGOXfm3iGLGy7Z4RULIHnXA1U
CKI5eVvEAPC2/n5vrXHgwD3RInWb5ele+8hH5+FXRnpD+8fL0d8RLQdWOceAiap3
0J3LSUKP4fU/6ZQhEUz0My89ZIelR16cqwVA4Bd+D3ZMHkLBzGL2nCUYgZtyYIGi
ByUr3VcxnYprdpOSxbf7zgNN1ZV3FuZBUnm/OJWscV7CvT+zUrq+YIpNb4r8eh7r
CjHu4obkEnTg1EtppHd+vNlq2pTmW9qSq80OqRVUXbUDMMsnLTA0wPAseSkd3bDN
8CfQ2kzqfUcB5YcUjzmNqQSaqFqXAWSXvR/5rX2DGIr4+CBJq4/rwrX++8ubFS5m
FKX5SVwIcOYR4Lq6P3qMH02bORhpWcHrtokruKcHgQrp+vrmMK+Il8vOPaMNQ7BA
NuykObEI+Z9AaL/MRHcGhqbApyGKBI0GeJ5GeBUTdrPWznsGuCJxVBeTFfghOSh9
Pm5sqcmW5P3c8VCIWLt24mDKxQi1BXTxZjUKdnCgjp3Bm5Aw5xc=
=rIU3
-----END PGP SIGNATURE-----

--Sig_/MO8b96LwUIXatbkxjnXy4Gi--

