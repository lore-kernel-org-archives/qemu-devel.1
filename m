Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BE1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F4199204EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="brbWciR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4199204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYJK-0004pD-07
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYFx-0001k0-Ug
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:11:57 -0400
Received: from mout.web.de ([212.227.17.12]:45535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYFw-0008EZ-TU
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589541100;
 bh=V8Ro8PCn+awct1ifQ7K17SdfEaWVDnw4fl1+hJCAEU0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=brbWciR+gwN+EtGsRqLvfv+KYpyupVDNlJAn5fWby/RuZwefC1ciUiZ1YfF26mf93
 NPl72WGnnOgJS+4pVGMyksdSw5/q5fLHjP5gc1WZnWu/15AYNTcEjtiC+mABREG4kt
 2lpWyiLelLJSzfozjQI8xAElmtq024voOMKpvy/0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59jC-1jYSK73Nqe-001DJe; Fri, 15
 May 2020 13:11:39 +0200
Date: Fri, 15 May 2020 13:11:38 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 1/6] net/colo-compare.c: Create event_bh with the right
 AioContext
Message-ID: <b5be719bf9c438ad4dafdc2fdb4ed87159065e6b.1589540787.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589540787.git.lukasstraub2@web.de>
References: <cover.1589540787.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0VZdIhnMt.95UK.BCFwRk63";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:UaxdX+O290qLgsa8UWIDFt/lMcbTzHlpvbL0edd/IFhzpw4v/1d
 SORb9A9UL/KTQ6rxE6Go7XXpKFjtk1aOm/oxsQN/jP89JkqzETx9/OwOaq7WJwlxhQ8IEQZ
 Lmh59fHCpzjijH/dUet0pKhVyOB7JVduIA5/A/NrbdlyGy8zhwnusKh0AQ7NP7+VZ+jKmpt
 dUxQ8Ks1l/YnEuTyHtfVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TAbGL+UbG44=:OtnPRtzapNhuLA15sfnaxC
 /O3tv15JhxB8Rb5pVnthvS22YQH8fmzkNGSwTphdq2TCRn257NwMkhdpSDrm8FQP27mGrj3sL
 PV02w0novpyyyb9qLixgmYQYemZHf/W0GavCLIc1IZKb/oC0uoYX3MB4KeyJYkrWn5zjtDDKW
 32++zTAPHBaaqDPXFYqZTMrK2f2MvpaV89wEPa4DAl2IF9nnbqteIZgf1p0JKIQH7KLRyFpSh
 4zPuAVrHVw6WcyHyFXLyiP/vGsqFNSRGSjU3aA7/RjGv7XwzXzB7U/49UzCrnPCiOJjlTcFDx
 F1FQgTZHzwJWq6u/RZvc07V+pLEA4lR8bGSShUu6qoE9HMh/h1mBNJMsHE2y0S8W/elgrW6Rq
 4vmgF4qx7Wafh2rCdybT7c3FCQ7Gpg5VV/DkK2vx8R4/9uZ8njGqVcu+JPCuageJTvEE5nQnG
 T2+qjVumFT20RywgsJAt9QzsY2ZE6A6taB/ELc/CV8scRBcSqDKIzdfVEQxBRxiWczCjXHmgc
 vm/mxScoqF0WLsNcsic2e289EfpAYCEcTzLu+fUvfstBo9bTKZU6e1ezzh8bCEindQbo+nAps
 O1qrU5KLJXPaA3MTM7du3/YAIHqJvKT1yJhdtDlTKEUDn2uHNEeb52h9Mcyykyo8NXjHQXgfn
 mzJd5mWjIY540ycJlHt43op4KgiXYhRhrKUcRlbILAjk6JJzAoKdG/EyPW2/VIS/JRfai/fS6
 0hh1wWun0oK1w7KOZzNA4oaC4z8qw7/1ctEwxdDNMqY1wu2TSvC/O/mTkGAN4kakaKFphX8Bh
 qjZscL+TXC+pxAq/3j5CWBPF2P2kybFghu4VC0z9uJuUJ9puXcCFlmkXGdd4UkTg1joD2sPnI
 BD5n8fS+u/XI5zhjxo4+WnRDKKL23EbWb3Eo9PAHQujBJs0wTK41RideqYFPuTLu6jY6jeCzn
 6GEi60ALhcIh62pO7Eol5vQQCnyIqLCqa8aS8Ciqupxpk9EKn/4+AR0oa+gEKlx3iguaHp60o
 ZUvcnEQP1jVsBTY/MoI921S7IInBvltqrX/3hSmWGhuhS9Zqi0z5tvm1Vz8uo4Lf0FOzAESdz
 HD5Tu9iUckEvpmu3IPPlEEq5LmuuX60GJ8OKxNaBmVNUMndaXlYTpya08oYh6e898oW33YNct
 R3RAu76TXYawB6FHbIRreUk9T5BLlqNtgsqyRZRvIoMzFyI7GVLr564w0VD9oJnd7nINhQoHn
 f42cL/CLZyyttMVIf
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 07:11:55
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

--Sig_/0VZdIhnMt.95UK.BCFwRk63
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


--Sig_/0VZdIhnMt.95UK.BCFwRk63
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+eOoACgkQNasLKJxd
slgFKw/+LM70aV3IsdsopQgCnEbEVoeE0BwDRLBOwCs6u2JiQLo81KDQcc6cxWgS
LSQD3SSDis9YpSwgAdtpmMykFuuDgfXfonNbHdX2G3F4NScnaozORCmHBj8eoc9N
0xgNgwm306hx3AUtv8mdupyDqcNLWng1mO3oNiUs3042xyCNpzXPIFjRkmWJmE2S
WfalMeLGl124Vi//cifPpyJwbqq3X5SUoJXLt68ICh8VAvDLQG1xeS4vhIGQfTOW
/H+UwLXci7bY675hZXJbiowZyvjxXX8d0VRra+0P8z5QlbV1QtxbOQ6yDTVo0cdv
BMYd8F2Rdokqzqc4CjZJr0Zu0LT3NmEZ4qaZost2y0g2DfFYzq/eyGGgS+7I1P7R
PAsE8LkRD39xx7OaWgvDTItK7ZStquvhOJ2KMaAST2VVfp9rlylFrJgUJdGs5YeI
IptpgwiNilk78WCLx/fJkBizNbCKc39cMPHShLNo0JricbnPKeiUj2oS900334Qa
oB6BRnv00ar1PuUpmkno5fT7FY0vOQt0RoNwMUNC1ofRmeEYNWrfPFR0gKeI76hF
AhXMaWiwHBCrkUqqaVZbeNoLKEABWOUBbXQZxkhrG4KZuoSBNC1N9Z6mfFBCbCnt
Lqxqp6JhIZprLjVusGaZrJ0x3N0waPECKGqqhb+WwxA0cusXZE8=
=OwRi
-----END PGP SIGNATURE-----

--Sig_/0VZdIhnMt.95UK.BCFwRk63--

