Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D228B206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="a5L+4sC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D228B206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sMn-0004uh-OR
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s3P-0003rX-LV; Tue, 04 Aug 2020 04:12:11 -0400
Received: from mout.web.de ([212.227.17.11]:34305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s3N-0006d0-Vd; Tue, 04 Aug 2020 04:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596528722;
 bh=KEmy6YMSKvjy+8JKgUemriIQsd+cq5JBtEE6CKfv37Q=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=a5L+4sC7DiSQXw34/iZxuKfBD8qIi8JAtgpWVqsaZv1TAgM1DHjtX/qUPK7+ILCSD
 aeIJZxeVnOV36rFO1WjdBBAboGkSPri5Z1XhsDFXIOodkFGa82B4TaAiStLkUP7PZG
 2yxEf/trElAMJgotGD4uRERmgTAEuVlG8MERtBcc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtnvF-1klwIh2v8X-0118Xe; Tue, 04
 Aug 2020 10:12:02 +0200
Date: Tue, 4 Aug 2020 10:12:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 8/8] tests/test-char.c: Wait for the chardev to connect
 in char_socket_client_dupid_test
Message-ID: <0c2f168afb1f66ccadef7ed623808aabf604fb65.1596528468.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596528468.git.lukasstraub2@web.de>
References: <cover.1596528468.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vnawgVI_5XO5eiA54j4_/4D";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:JqlhMxM2Wvc+dVPQauu08XY9qCHu6PE/2EtCxKJ310dLgS6sEgY
 cwyE9Lf0TfT6H7JBJDIeaR06uyXQbe3Xg9iDQtSgya2OmfSRWxBh5dFpbhqMfW/SMG7VTNN
 IVzKToF7CiNaGsTwYzBc2cG47qH8gmeAEiTTytIqP0gj0Z5QuZ8pOP86l5bcAHaFv+Gp+Rv
 FImbvexy8AU/bks2ABcyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aiL4tHeHjFo=:o77J2CB86xrPXyE84PJmrL
 TU/1LocODEVls1CFSYDGouVtSfrba2L9pRDs74ADMCCfY0Q/kjQl+B3MTuG4d1X8Uw5OhQ+4M
 OR2ctlg1YzfNpF5r1hlHxeDOY5wFboe+EfowB18NglNACgWrLDhX0BVkd4oPk+rhFewIA0lzS
 W4b1v0e4KLY7hJRK+m+zWWzl5I+NpAJZWuHPol2eL2m5XJMYpD2YHV/VCxrKkZeVQgFB0zVOu
 DpDUzvY+l4Uw1LOOK7mIFAP5lnWBRHvbeIuob2WG84+F12RpagcrQdn0g/nGIBEHwRIWV0RY0
 hYLYyKGsuS4JaLZyMp2pnXIs7M+JFN7LLo1g8gaWspJiaaPEqxt1L9bmvgVJ+YawecrSoZvA8
 rrHEdFkgWX2bgGqGx6gOy7ECG7LIuyZoxBodm/493KDMhkA6Y28M+srNWHqeTCFVa/gFvwPhO
 KTX1L2gMsMvl3rtpSVFWFzNYSuJZ4ZLDDbxACSH14bFGVT4EqkSapbqGI6rxphXn17bqCf0zM
 6U68S3hwObf/sd/ZB2aNHcXmPIOerh9ZJZS45SigGkon32+vtaLVM8AmpFxkPq2D7R+sEPuJn
 PLQPTS3hRCApwbYA2bXnKKjKUvV7gYPpkmT+JR55e+K+ptAAoUK9mticok0FzNt+65wSpRQwD
 2xMOLcsF003mY5jEw8J7BMQUqdhp0DsgTwJ/GSpb3ktSdHNk05pTGXtEz1jESdaid3aigryxr
 yL6eTW/TbbgWV92+1SKWsiabkA04uVBtxpRP7Hs4v3T39C52EVJHaSM9SoMSQRwe+hWro8Eu+
 HW6Q5JAPxK4Wy9OJH0OueiE8C2/hI+jihM8KXrYWdcLMwdNBm6R/XpP/WUd7YqtSFHKAkqxfn
 11Fg8oemU80rzasu/FI2wF1iNeKStiJkbroH3xkWvVKlcrZCb1ufHPuA+JvHs0GdiEBw5lkQn
 0rYTqjOXIcVgLjEO2FQfKT1kUa6zr2qBEhZXInnOmiSiAoEnp3RY0gdT5EcN8SYMDc1QIfA+e
 5scZjQsEIdA2pOye+2jMOjZfuEo5amtq0gqfAEOEE1I/PgifKA6kzoypQjnIGn61G7k9kkNzr
 WOIGQWkgK9V/jPd9D4AJnadO2/IaPHaUHDeWepRzFWOwQ9SvdPzqeaVrS1VZ8MKnbVmg1z0bp
 kldbWeyQ7MjV4AohZNpG4KTre+e6SXqH0jK06bAPg30Nl1AtV8BmkBVp8/uFHbhr3BZu689K8
 P1NtaiIdKMjHZNstfdc8iQK7P16q9Zna2llp12w==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 04:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

--Sig_/vnawgVI_5XO5eiA54j4_/4D
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

--Sig_/vnawgVI_5XO5eiA54j4_/4D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pGFEACgkQNasLKJxd
slgBgQ/9HA7xBYHAxskNGWj+W+tNsqzx5dJAyPjb0qnA5fxpV9vSJwGMbJ5tGOJo
ZzL+HuGN0WhAIbFO/Q6c4lhH2aaZdFr9+Csx1CxZBELKMDj7mjLO+Ml8ZfDB0gOi
5O1/B5eagZsX8hmhhhHc5cvNvELj7c8tvHC/MhFT764+1uORUODZBSEYBlrMsytv
B0m2vpFkk8dCjE9f7hNUPQSP9qpOciiOlr0dpVqLRzEVm0/MjtL84om6a0ybE9KT
6BvCz0kq4BtncJM3sArSUDMS9d7I/CdhqQpozzR7Y+HVN8bGGMUKHRFqKrzxxUKP
u5ZJps0V06iTJQsozen0574drxBTtLZnhwWfKrp9X3n5Jp5evfKBTuFCGLSZ5/E8
o0HDLcsyMbIhYmH5b9k9uW1knnWy6frs6H7Yqz91S16L2MHywwXEk4M6/rNnnXz2
R+nYrMQDNI7hW7AYvVpJmG95/xPp7tKLlUYQ/rvzEqKrYjYj9K+T8HP7/s6iX7/D
oIpOiq2aLpReJB9VUwTfZr8K92ubJLGvh8toBJ7/bNSJ2b8aF7DzS29j3sJaUg9c
slQvALJax1Ki9TpMzVFyNKVtwZNcPAYO1jx1HpKjSmVvBT9kbJMj4g3xoNFrF6jY
PsakuEwTmGz7YL80X/NI0F4RtCcoraUnfWUss4UMdwaXuTkBfCM=
=ntmX
-----END PGP SIGNATURE-----

--Sig_/vnawgVI_5XO5eiA54j4_/4D--

