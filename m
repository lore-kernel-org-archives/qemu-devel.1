Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46255C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFAB24810
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="il8Tjkz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFAB24810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqY1-0005w6-Bz
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqSC-0000Oa-Rz; Wed, 28 Oct 2020 14:45:49 -0400
Received: from mout.web.de ([217.72.192.78]:36183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqSB-0003JH-0U; Wed, 28 Oct 2020 14:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603910741;
 bh=iohBE2TsRUHqlaHAZq3nAbb6MbYyYQk71IzJEZLd1Ag=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=il8Tjkz2a0hFfBrpQDmrh6/6+wfRRVRZRz6jdFjqckTdczqjQEZ825FuCAk+npQtv
 h2veRZx2Ek2n8xtVEzflXzcPNvRV/1H6RpnHDkIaCstVvVOevb9PTB5/4ScoX6SrsD
 dDShMYhmkCMheUurNzWp0BAODoNBNAd8E/H1hJ/w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.124]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlWGZ-1jzssU05xf-00bILd; Wed, 28
 Oct 2020 19:45:41 +0100
Date: Wed, 28 Oct 2020 19:45:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v9 6/8] io: Document qmp oob suitability of
 qio_channel_shutdown and io_shutdown
Message-ID: <10e56f6d30fca6dcb75c0be8ed605bbbe2b0fec7.1603909658.git.lukasstraub2@web.de>
In-Reply-To: <cover.1603909658.git.lukasstraub2@web.de>
References: <cover.1603909658.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sLb18prFuGqp30VaG6BeDue";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Ds90NGIY5RZLKXGb9z0vHscFNsktlAKePLSk1mem/xVbZkl98Lg
 JXsilk42eQlEF44Y85OK1aPq2ISLW9RMYo3lZ7SDkFlqt/orjBTBEy8NJuIXI/fc4IYVCmg
 5XcCURhzzHJiwq5cfy8RorX3P3kC6QS206zqN/dO3iAj5CGcIe/9xthk9EP0H0jE/eLUk3D
 KEILFCwxJSItZGQRcT/hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CC4KGKQ7peY=:fFoliSV4iffELOMD6EwQ1k
 6oiIoUbumlg8l5EznCeRc+a4M0o3s6qziAkDgHfCxs2qKqupScPsXcmgTMl6oiiRa6Vsu6XvC
 2Ozz5qaINk06DgCMwgWAlPgcOE/4DYUeC5M/5omRHK8cgBD6nAiMFMHMGEk4f2bcYmCtd1JHS
 MH3WArFMb5cYC7BhEiunaVte9nCSiMDtzt/4J+2P3UCaMr0PoLmbP0ctmjrsmx/2Xbundxkkc
 uNndVCTwvygvv9FdRsq031OZa63kWFKNIeRQG75YXJAaoBDUx5dfHAmWKrSQayrw7/R98kUdf
 nIMEhKsTydqikdD4XlC8KtbsT0uJUvFSWGp4u2K3twaMJMW7TthgIiclbRIyrzn5p5loJCjvF
 KVlXDGRRnjUzyXZW0hsITLeIhJ92bl0HxbioXvIyyd+3sVZoCaQMPaKmnDGjOD9mFnWB5v7C6
 lPoI+ygjPAUH064WoePyOQ7W+MZ/eLKUtsWQtyCZtqZZJm9E1piRnGfamrG/QrHEHboqn+jO1
 cmIS8/NzWLzIgVjQTOlWdz0NYkZiViEMdoRM7tvntmVKdK3bY4yHUMhPTwIjsMEqakVhDtXLy
 dvbX0oK4BwMEh+HxLXsXBexDv1CVsi0EMBWwv5D4uJd9pcqu4kS/9+XopyhK4ISh/V/YzlkfI
 elyO79RK9TSp9chw5GB3dyZ6IirJrpN7D0UyBq0aOz3zTP4wi10/MkCGZlmYP6sXXx6t+xr7K
 iSbAUxg6qwsQtx5toqESlEJb5g+xy72zh3dGQKrtKSFF+3KOPkMEkRez9EG9/MXnEuqm44Boq
 GwARq3YBXR6PLJkYTY8YuPlj89zBKHlqWJiHGGMMLFe0bPhL4ld1xEOMu9WCwE6AYP+XYUiQg
 tCX3s7Mh6mQs6i8u/djA==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 13:12:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

--Sig_/sLb18prFuGqp30VaG6BeDue
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Migration and yank code assume that qio_channel_shutdown is thread
-safe and can be called from qmp oob handler. Document this after
checking the code.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/io/channel.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 3c04f0edda..e0b9fc615d 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -92,7 +92,8 @@ struct QIOChannel {
  * provide additional optional features.
  *
  * Consult the corresponding public API docs for a description
- * of the semantics of each callback
+ * of the semantics of each callback. io_shutdown in particular
+ * must be thread-safe, terminate quickly and must not block.
  */
 struct QIOChannelClass {
     ObjectClass parent;
@@ -510,6 +511,8 @@ int qio_channel_close(QIOChannel *ioc,
  * QIO_CHANNEL_FEATURE_SHUTDOWN prior to calling
  * this method.
  *
+ * This function is thread-safe, terminates quickly and does not block.
+ *
  * Returns: 0 on success, -1 on error
  */
 int qio_channel_shutdown(QIOChannel *ioc,
--
2.20.1


--Sig_/sLb18prFuGqp30VaG6BeDue
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+ZvFMACgkQNasLKJxd
slgfnBAAm4EzJtCrG+SexTdcCJzKOCZTfaBNe2IR6jtDN5kFVykaRkSavwDy9xWP
HZaH+yADFC/t77WbOWTTNNvgBtlLNzVdFDRwMuampSRjo2uCQHntJDllYA2FQysD
cFL0vC+LKCvrPbMgi3+EED7mMTQLIVQ8JnGcnchQSJ4PCSxu1cFtOvUgAjT6fNPM
LIMiav3YHS3YG0tJiWq3LGt9UdKtIvfYcDVPQRGkYs1zoqIBwQwGFzTi+l888LdC
+hAk9mra/+V5ERb5TufpaJZh5oF4Ev4LcDD3bT5PsXG48UKjMqFzXbhfELRvl/r3
INBPdm9+Z2zjh+vnxFkukBWNHTxpE+s8QP1RgLQVYUeQmC5dIzZyis7pjwpovon+
Glv601ib5Q/Dw0eYO/TJWmmWbr1u0Ir/UWGuv9hVpWXnuEiiERgjAxHodfVNwLLc
FlC9Ztpo+gKZnhkhtvDURotTMT6XbbO1hb2PW4y9wkiq1GGzFEmT8U1S5VPLBFXO
7vneOBCZcRvV3SkcwK8WQ2Fb8hGrpXZLaUtArmHW87XdS0W3JvJWJz2qlIJHpIlH
ToueV4S+V1HSLJDJprM+Etc92NOP101TIHolOyZvhfZBmN5qvqnCBl72ct6tq2q6
KUqByO6dqCX9MOW+I5Ja0PkJ3msScOE8ZejrT5bmd0uP7IKeQtA=
=1VfW
-----END PGP SIGNATURE-----

--Sig_/sLb18prFuGqp30VaG6BeDue--

