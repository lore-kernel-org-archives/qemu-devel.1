Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4A4C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAA22083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="MxgByNQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAA22083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2o0-0000Iy-Bq
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2OD-0002tu-Ld; Tue, 01 Sep 2020 05:15:42 -0400
Received: from mout.web.de ([217.72.192.78]:42531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2OB-0007OA-Gw; Tue, 01 Sep 2020 05:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598951734;
 bh=5Ru4+rBV+K+onBUzRUv2vnLe/gWCnDAJyTD5IvZPjAI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=MxgByNQUcLF/Wr4p0DDeQ9tm47isswj+WbNY4oBoSSCwA+k8wMfpn50zSdFkF+oRI
 CH7lLGHuGuoP2Empeu30ZG5xH8Ph49A4MPs/Oro87kJazqZ2PuQ3ibyQhX/OkLgigp
 IUdZjcwE9zrV8tNDmlQv99YeVukxhMA2203kXoAk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.220]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiCx5-1kzJcj2urD-00nNDr; Tue, 01
 Sep 2020 11:15:34 +0200
Date: Tue, 1 Sep 2020 11:15:33 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v8 8/8] tests/test-char.c: Wait for the chardev to connect
 in char_socket_client_dupid_test
Message-ID: <613e42af4f7219cba082acb2533fcdf95fc098cb.1598951375.git.lukasstraub2@web.de>
In-Reply-To: <cover.1598951375.git.lukasstraub2@web.de>
References: <cover.1598951375.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SyW1wVCwxX5bhE85ag8/sy9";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:r9EJSI9MAlnesvO4kWkt1JtcVh32jssS9wMze4dW2So/znYxAqm
 Fg1WX8Qx2929IjCvQkXx9NKrig6hapiizA0aeIVXrlamiCmAw2W0ZAcLkCpm8edb5CVUOqL
 /5qaJcH1sCnAwv+4Qz0RSXZFiBh4TwWY10VBUesKLbd5V/EI4/k/QZpU1+gw/MD5gJ3/kG3
 mtAClBzTQRZ5uTSZykjwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e3PCHK0CH4c=:VubaWAuSmReSSNCqBnmXlw
 FJl0j2MgvuzViKohQk15M9kxF3BwJ81U5Jeo/yt4yON7le6Q7UnlRI9v+GNIDrdLsw0JxvNDz
 14neHPu3Xg6lE80IuGED2xxdLudJg3bJbFktfJCcOn+9Cvonk8jAIuZ1e5M/j075aO4otIutG
 VkP33xZLKpoXR8c7zdlftyL9HRu7MhxAOjYfGjtLbMln+udyy28Zo3iUc5YQaS6h+vkJ/g/z2
 FE7snDPtB9eG0OjWt1oGpeo7qrWQIDAJucs7odj2VobMBkB3hpJuxqMy9uwpt95YGk8/7KG0L
 2coJwRWUsM+qCizlIIcY6XRPja0Yvl9t4D1kk/QkDZBbHLUoJdze1ioU3HevefolE3LG5h+GO
 kKjKuvfNXnZCCZxkhiHiW5mowXKEJB5/3mGxGHzvFOp2zdu3FIrg9YQshE+v0Nms9K0D5N9sJ
 hkSdcWbtWAzFReKGIAw6umXM73pGO/hZ98F1NEtsOy/U+ssnE/cfZSqFGNu4Scc8eE74DRSao
 FI5GyWNPvg+GcjrTdUxuXXxTkt3LOYhSV5r9RIZqAoweZw2GzBqvCZEME6RZRrxe8HB1ouL2V
 z3Qe0gbgG//NENqRCDdoHajjlqBAPECke5am96f5Go0zlnkJWHhy2usFiQoFeesU/zlgp9ANx
 06MK+p/b2c1jYXJUCzhTjkv4MZu1Vlu996EgRxqsjOfd5J9lenN/ZpJTuNjLSI4NIpiI6noDt
 r+3DKn4MKODFS5zB1UlozFrHyi92Y1WktKPcwpPs3V492x3Jl3++i6OixYhYHHaVvRzEYI+2P
 5VKm1gX6N5otZufmwkP1ruRZ04ThaWAAxKOWh8ijdgfVO2H2BQQR9obhXrfT7a4xc8dlliO0C
 WXV0sD5UczBDz4Z6PSdAh7/2+LNq61ahuVdPjCh+AqZhoet2uTmRlDqcQ2BOcx4cT8Ecb4uoJ
 74B2l2lofNE/dpJqGNykYMNiwbrmaeKqIt0OusPZ/PjKixDwMO43I/XUV2jtNzhtvrzWHWW3f
 5+5uL38rpbSyr9MQsjU7wl8Q6Pv+DPKYw31qv1j3+aBoTd9s4rAN0XnDZprKNkxejrEfCcMt3
 RdjCBbprwk/BmBABM5vbqAOL31U5n0+O3dVLIv4y3NaTsT+KDG2+HMGJ0GzNwQZ1xjtoSZlRa
 uLddVewP90tJ6tLUi9s2KK15um20lm9CNlcz7F9k28CuoajzCo57Ayk36kTOyJGHOrbIxd6uz
 VZVcTWcCL+xVw0k50FFLhJteYG237X9pLMTootA==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:15:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/SyW1wVCwxX5bhE85ag8/sy9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

A connecting chardev object has an additional reference by the connecting
thread, so if the chardev is still connecting by the end of the test,
then the chardev object won't be freed. This in turn means that the yank
instance won't be unregistered and when running the next test-case
yank_register_instance will abort, because the yank instance is
already/still registered.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index d35cc839bc..2ced07de69 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -937,6 +937,7 @@ static void char_socket_client_dupid_test(gconstpointer=
 opaque)
     g_assert_nonnull(opts);
     chr1 =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
     g_assert_nonnull(chr1);
+    qemu_chr_wait_connected(chr1, &error_abort);

     chr2 =3D qemu_chr_new_from_opts(opts, NULL, &local_err);
     g_assert_null(chr2);
--
2.20.1

--Sig_/SyW1wVCwxX5bhE85ag8/sy9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9OETUACgkQNasLKJxd
slgYoBAAgrlkduKYqkrzRw/lwpuqroimrFPAjEAl0aLrA6QBHePtYtS4r67iULwv
oR+pVUOaBn+LpEyOb3hNuBlNzqxHXtMbMMNk0tVlXotS6KAKfZN1Q9PPn4RFn1hQ
cqertEZnZFqRKyApzMckyJ47V7pi47a7/ikan7mf6v9/XJKpgLK2p3TxvTZ2JhHu
ITnhPmWEC1488abRm8Bee66a4Yidiia2CbtWbPBY6JGzrUhZI125qTkA11N6m8sn
1/HrsmMBH9NHqpoozCvePg1OKCKHs3FGsS5aJFIpm8ZJa0ouoTHdh8VpOfZ8fAFi
C1uCf7mBbwjXuM5oftRkE/2Tr1tXPc6dnydCRi39Wdaogemex1cAE6v/eFYxn/te
Pwai21HADMyTbk4fRx6Hn5+qN+sgSInqoddJo2Z0OSatXvo83GXc8X1/tngXkm9p
1x/2w70ntd+moMXIqp9Q39LLbY2ZavQ762V2YsC5Y8OP3F1pNgAOnQvR07yPUtON
CLBnruodpE0aSIBs/ep10q8MMZM1Ec3vU5/sdzOM0+7cH3ydve6Hwpzg5W2HbGCG
/rfpRGutRDFCQfktOBmXEXNm5kxSsYZQgMQeov5yiy+eciqyjzQy+6PkVWDGzQ6/
VwcjlKrctUHZLYvH+QRytcHCjYMdhuBq8o3g0gcrujiO8NZoIPg=
=FpIY
-----END PGP SIGNATURE-----

--Sig_/SyW1wVCwxX5bhE85ag8/sy9--

