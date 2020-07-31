Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A07C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCFB20829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ax/ApSlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCFB20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RYZ-0002UX-7g
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJf-0007jJ-LX; Fri, 31 Jul 2020 05:27:03 -0400
Received: from mout.web.de ([217.72.192.78]:54765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJc-0003HV-L8; Fri, 31 Jul 2020 05:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187615;
 bh=3A0rurnJ9LqQrMozklTVo+u7yORYQfvynASd2zRGHlk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Ax/ApSlvzQSFuLnV0cKnUgDTIWnq4wDJ8SZfUesF9p43l1pyBuyAMJ4ByppOITAxR
 oqD1rzbLhJGWr4JW/B6VvalR+T4tzrPVGEAi6reM1q12Dnbom5UKsCIO5tnGm4v2ce
 kneL6Ts72KacACUsirKgMZ28KyMpw7rt1hiieRz4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3T5g-1ks1rq3PtY-00r0Gf; Fri, 31
 Jul 2020 11:26:54 +0200
Date: Fri, 31 Jul 2020 11:26:53 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 6/9] io: Document thread-safety of qio_channel_shutdown
Message-ID: <1d059059640fe6d02e05d4fe617e6665c7640dbc.1596184200.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596184200.git.lukasstraub2@web.de>
References: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aS0YxYVG+6hOObly6x8IvO2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:zq7HdZxZPtFz0sRJ18izJysmYjt3uAkakonGsaRYfwWmDBnkB/d
 TKULpbiZiFx5XfNDruImCicx5G21Ozc+SkCs/QzaQyidJkFp3y6+xC+M00iTR7OinsKzvmd
 I1TpG39x0tKCDJboHWOZE2G9EfYPeUkFW5nwfwVW0g6S5prD0wJlD8heRyo/kBcCX4qYsIW
 No+DiwBUGWdfW4epZWTMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MYKXM0U2dA4=:povw0UHb7hRszVbDF7OSBO
 qnue3/RwH/UFaeX3er1AGFhXJ7Vdzl+Mi7dn1bLMuMbO7EkqHzsRV0qwBYWokErF/xtiqgS8k
 J1l7h+RXPe5Ji3QdOO/dJ1hG+mDxLZzBIj7k45ix/3mb0G8q6Mgq9/jFJarIWBYMaPv0BoyJ+
 UdGr2AZpEOAS3Zm2RW50u9Xi0ewQXJWV0pjTofkUVxO8pGfz8in9GzQxoSATprTHx7eM0sCBc
 OP0k4RnuSPLS/+fQh3agKgdn22Zv9gDUcJr/zg+G/kbtu6ZdlKpUKLUW+J3WkCRpNNxz0MZAH
 JI3VzYw5+HP67qsaMOGKKFFaTwvJ2aFb63dW1HQC8ZqqI0L0U/fVHRl2PWD0vhqQWCJItGkI5
 AZRnGDYFCpMpyGXJvCTZC5DPY8X2su7bhUo3kfJNBknzLj1kG55wWk+EsXrCbe3eRfE72VlA9
 7JC7VCuWI9hIPQM5s65etELtF9dp7E2foJO2glrzhvE0a6xQhDYPsuWszb6uoLv63j08y/oye
 FEPPT933LelmRRCmEjNMfzs18ahpnHWeQKq9+0tGJl9ugWsIxaH8f+p+yMo7I8MxJ6aMzLkv2
 ujoA+tqEyaxcWpblaUTnvq87Tcyt2uhc2xVZIVqQ5bNs6H3JfkD7U9uzaKQuEfECOJUDdwSp8
 RH1A/G1p59o5rAheQncoMVbNwS0PHDtJ/Xxw/f3ygurv4G8qHCMbi0G0uviI23Tj2e0MLnnqL
 3751TPS8b5OjRtp4+nPpow35tbd5URStxG6wmgP6lCoodXZw4pGD69pMVvoJESMJRL5JQ8BPs
 xqazgtUr26IxS3lq9uQZLXaG9xN4vjaRIBfuc5fohEYTx2tvj8eFvN0QqRSelnaUVzeu3Y8UX
 q0ggTG15ZSvgKnbt/iOrceSoRKDNbYLUV1tqxQjlFq+DIlT3PHrKdD4B/psXyGzFPnHxc1B7W
 FqkPwYywLAtrP4R7r4EyuX8QOzpgsj6gPieO07ODbkKI8kmRSl5G35xXf3u6CuiaEFH+ToSFB
 hOOz0l5mZ3CJwXyolB8myWjFap30DcIJSylOAqZwgEBHkndZOZq+8RAebOcyM7ZvYDAlUf2Bb
 nzIU9dqPwj/DlkuqvIkkZ9/PvNrukCMd9DuGqVlmIAXNWhuAum8K1wqFVsGrbhM0omItSxg4j
 iTMe8fEfm4tNLH72qG1CGdbggOSx7ETmRoy1REiItmFT7f+oa7n6I+tRqC59rLDLJ16fjVLxi
 abos6NYGgrBNQK2mV0yoWa/TQSCPwpTtAZNXULw==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 03:52:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

--Sig_/aS0YxYVG+6hOObly6x8IvO2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Migration and yank code assume that qio_channel_shutdown is thread
-safe. Document this after checking the code.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/io/channel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index d4557f0930..6b8a2b87b8 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -516,6 +516,8 @@ int qio_channel_close(QIOChannel *ioc,
  * QIO_CHANNEL_FEATURE_SHUTDOWN prior to calling
  * this method.
  *
+ * This function is thread-safe.
+ *
  * Returns: 0 on success, -1 on error
  */
 int qio_channel_shutdown(QIOChannel *ioc,
--
2.20.1


--Sig_/aS0YxYVG+6hOObly6x8IvO2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j490ACgkQNasLKJxd
slim1g/8DPtJM5cIG+fMfm2m0+kOETNft7FBE0f6mXPEO8A19aCW4V/LkYZhnwv0
RMeTVzNB61KOI9Odzzcv8j4IBoX0RJJR5uFky0VkQntPrNTSpxiHHNRO5/5FGzqx
GXeIbUlFTCfPbWXa1JAS0Ha6p4pOyZvws5lIoclTXul3Ks9M7oHB05X5I/T5xmQw
17A3J7Sr97iqG58pvUkjr1GqQv7vQyM599wc1S5cldZaIk8Jd9wtpp2368+3GtiV
aQs1jnLH3L7blkoac2Lv0McZ8GSQYIwpOmY1Rp9awRsJVMfcaVqkQxvS++lvrxjx
BN2MfgRt7Q7dnv4Hlui2iE0Ul4ejZZ6Nfd72kaa0LX7OpB6Tl4Wb8wK/hw3qUkGC
JBbEw43jyfMxVIVqXhjjSCM9wE/3DO9IQp2bqaAb0uJ1h6RwrEFRziHoZNWMmYmV
jhlzN0a6dOak1wWht9UlG6B2xcmAfh5wc26ciX1uccHh06CC+47RRSjpwDJv5fDx
ckiony5cYdVV++85aCqmPaGsvrN6fcM+XsJeSNdDrCSvtMy7OwTzgn3nGdCj7gYk
sSyK/PrkGTzFzMQfnVBvzI8wQJtakU8H56TTcqLwmwVTD3h+f3sYy5l/MvyYRx6F
aoanzR5LWEEB14bA2AQf4pDm7BUKbV/x6Hvr7+jS5/XV3sjPTPk=
=7oO4
-----END PGP SIGNATURE-----

--Sig_/aS0YxYVG+6hOObly6x8IvO2--

