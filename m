Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB61B20829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kk87AzeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB61B20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RS6-00054V-4D
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJr-0007uo-OI; Fri, 31 Jul 2020 05:27:15 -0400
Received: from mout.web.de ([212.227.15.3]:45275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJp-0003JR-VH; Fri, 31 Jul 2020 05:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187629;
 bh=nbwft+EOV2AEzRxoXJpN4IeXwIqjDnslmRUPqCBD2B8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=kk87AzeGpwgRR/8HOBfqK0pihi2uHZn/X/RNjHVuYRnmhZflseGHbfzpe6rt2o57X
 GMMH1I60703KGQQvGZmahSYCDXKAjzSfn8PlpimHfNaOrp0MtPiIIALZ6FHYXrAbk5
 CHkFIT/DXqEXu6/d60pRQ1i486nRdFejEMwOryGo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwI74-1kqNAh0p4w-017zzk; Fri, 31
 Jul 2020 11:27:09 +0200
Date: Fri, 31 Jul 2020 11:27:07 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 9/9] tests/test-char.c: Wait for the chardev to connect
 in char_socket_client_dupid_test
Message-ID: <1a011dc69f075b0bc4f9b0b3232573a6007c8dcd.1596184200.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596184200.git.lukasstraub2@web.de>
References: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Bwri_CBUeHHdjau8xq9Io3q";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:WhU0El/+ThIpCvz20wnDR7VnoF/0ndY1P+rxcioLO+VT5FRM4ti
 /8ycAgPnvP+7ACOX0fPH1OnSjXKkY0L3XNStyNUjOybTly9PQvx/oVQTJCAMu6ArYqwthw8
 S+gxhqfdzCUDdjqyqW5tJ6PthUR05CPyGpGTOaZr40npXz6vCh7cPzuJ7/NjAvCzvVTMhSS
 9bgRsRYPVTphiWFCi4t0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vcy9lH/q2qM=:UrQEF16YPULQqdbX+alpvd
 ZPl2LMsNGP9fDAKmQg1E2CMmBpXq6KGz7h5H7hBUdD3LDdbUk5+N7XfJz1tSRj7pC0fpzTSEp
 LAGRkcadyKluygFogBJ2iftHipeiQSbotRSufMmCZlzMPBZPW1nJU5RBB/0AQvqI2x3ZGJO0o
 n2UO2JuqhIngxXdNMVScxhG8HKTAhBett4TdCGgrq1PTRBUjOFNuieiIXIivGanPaIWY+R1zP
 2dLtGRJCAoNqBmSSf3oyfOaeFiltSPkToS0vAZAkF6/QrkbISEmB5ckIH2TIUbui2QVcIAfNf
 mKXg54qEIqHEQYM6XOerzulza8zlURmxTj+kc+ZlXt6kczcKo6zvQr2z931EOtlU8zb0t9kOY
 iVNC1Msc7KiPR8rndWBN4KnyP9dMChDAprpi3UW3RwAjBQp64Vi3cf4ngYHfJrBzQjg5uTKa3
 STDxpza903qRGDkgY9vma+RbzFmU7dad60XtE/Ohp/FBagq9phRMFVhB6UmbhytIo/8K+YhOg
 401sUZ75aM8JIAYgpcm7uDKZANMeNvNDbRCFY0KS6cowHddXpsLwKw4pqQHy1lh3ddX/eGALF
 wnqLrpS+xSmB1naP8t8UQKH6D/T8Pp4Af5N7i7OqQPfx8iHXBbO2me1ORqVh7HNDl3z3qCp7h
 UUZiJ0UZBDX1o8Q9VY7zdfO13Xs+A0prdb7hTUzNTPm2CjcUZoZACOfs/OOVy+NIx0Cci6eCL
 OYqrlpFgaU+gb55vbW3QxHLz5aqrMDUxNEAe9EsZCkoWKhol2XO/norEnlbj99qJK4eEVwZ0y
 O/VMaED524zFG2s3u8e/QfqUA52Rt7xssstXRQim1lbTmQPoYNhoc92imepGEAYHOZnerOKvo
 gfllneX+ykvm6uIGCXDhdKilNJM7mwwQLh2wBBSKjcN1yKs1OqJUNF76rqhEioaFxpnFweuSz
 ntx10TuiMFwW9tUrrSZ0gWQOteEyRkOeR1UD6Xz4yqwl8wGp8KNWiYur+SSarUlfs8g6NpFz4
 pI3w7MIHPBHTKd9+9ZHZkbA3+PBlq04p+OFsyk/6k7vcS7mJ75CZyMsBIVwz9VA7F5LfIREr/
 w4F/3ti37xuOjCNo+4ents0c6xGul0/DLDXjMM5kA2rsjBRNC5tSbrtvEIXXl1qwhfkicmTka
 dwEhukMqKW5iGw+rpnKVNdw9iek8YTC84NoPFknaZ6xjnA10fuK6G25xUmUV5xiQSE7xLMGzq
 3QwalmzjJUVZnkqTKF03a7L7jpLo7HeM6SpDB8g==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:10:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Bwri_CBUeHHdjau8xq9Io3q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

A connecting chardev object has an additional reference by the connecting
thread, so if the chardev is still connecting by the end of the test,
then the chardev object won't be freed. This in turn means that the yank
instance won't be unregistered and when running the next test-case
yank_register_instance will abort, because the yank instance is
already/still registered.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
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

--Sig_/Bwri_CBUeHHdjau8xq9Io3q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j4+sACgkQNasLKJxd
slhfJBAAjHnN2zMfTCUtOdHhw8Ns14YoNpVsMsKzvDwpovl8Ywlnwhm/358JF7mY
84Ffnbx3zVNajjSJ/403lHiCfv1wwk0+Rt/oz3yvLcIxDHyFkvQ+eV6RQGw2lnPR
+1w5EySAFBbB2RZxdepJoOy5aeAd5htlKuuM2wjyp87GTAvjeXZVmbtfAfKvnB7c
EDwoSshydBzXdskW/VerXOkVakBmpOrvbe7WyAK5cmVXfTiTXTZpEFHYoVu1kIot
cJIB4j4WibVf4+XFTutsulVmri3xAHpjDBPrbGyuFR9RHSyQ1zxSJunyF7YN4YcN
24/6fD+B2L2Xaf02P6Nc7khSvxUtBfC1q/2EkegMEJHXnC9v2k2W1C3RYGRsAFR+
jYtBfnpE0yYWVMhpGJ3LCebAcOILLVoZYYVbZWjMFjsr+d/VUYxfRCPlalP3wbdz
Uf+xpcpw3/wCSFhVP61wxn86DPqZXkc/AX2QWAwZGw+BHWT/CR89fGzUvj2/8bms
xpX9MdrJ3qQYP1ORoiidan2LxwB9vk8SeVNLkLkx8XhXB4SWO5KfKkAfw9xpIyJ+
OXxAayD//Mf3uFsdKfa0jx4K9YNQa641TWiaUvo38qH9M7asSFLGIpGJrsj6ZdvJ
xHH4XizW0FsCShDZBMlY6jpJ9TfghJIU+/RjB5PoKle1gKyOKiQ=
=ItH7
-----END PGP SIGNATURE-----

--Sig_/Bwri_CBUeHHdjau8xq9Io3q--

