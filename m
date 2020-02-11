Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DB5C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D45720675
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UM4imKuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D45720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Vbb-0004gd-7f
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 08:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1j1VYE-00030i-30
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1j1VYD-0005jV-26
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:26:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:33181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>)
 id 1j1VYC-0005iN-Km; Tue, 11 Feb 2020 08:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1581427558;
 bh=RIuGQiAxEON+keyaN2yoL9yG73Kwn9WzXUtj0mkXfVY=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=UM4imKuFJkS6a1NztzZgQ3fJAbSQhwRm2JYWhKhvKWZO+QPvyB7DfMXJouo0ZNFM7
 1Jv5H76OuXwmnpM6wIl7LMGAopbJwaML/v4U3QB1VsQ8MCf27F6oxNvDpWBnyY07Rv
 Su+hQrPB812w4hFaY6ZRuFz5owEBIUNDFOfkqF4Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bX1-1jRWbu3dp5-010gHg; Tue, 11
 Feb 2020 14:25:58 +0100
Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Do not run NetBSD test by
 default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200211131948.26142-1-philmd@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <a38b7bc4-971e-5373-7324-b27de9de631b@gmx.com>
Date: Tue, 11 Feb 2020 14:25:00 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211131948.26142-1-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5eQQ9kWmZGC2SS3FH1MDTTUUiv6q2bOee"
X-Provags-ID: V03:K1:nqhhH4m2u3s4VrU2RsrR6IQqhDyLZgZ8WTZ3CwuATMBfEdLduAo
 wljh1CV+nUrwwhx1O4qKdqk7E4xitZYCCigRaEZ7WO40AoLb+dd57scwNw5TSitsxsVwaWg
 1mRwOnB3fsXwBJfjPVoIBPDkeCHGOf69/4xqD8k/gFxiA0wHoVf3PCNVcN0co3bN2woUlSY
 5sXQhbPC08BlOXqvY2kiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DBgMsCVrnEs=:JHxfJh1SV2s3cY5e3MqTuV
 LR9LABee/sas679f0gXKJ10aq9QNqyFoLDFadiQWFMTof62lmWPbIx/rBVIe81a15cpX/uIJh
 gW/Kq8QWv3OxFRxcDnQXbpBZ8AyfHqkkS9XN4WyEvNWbRgSJjqqA+VhnUK2eK3SXeYcES3o4t
 LrGiCi2W8XX6Y7lZ+K6szxeTDjQcHQvt8OKA04877ue7NkasSYin1P9jqt570Wp0KlvTlFoSv
 GVHUt20cltnYPZX664OJIB4sNRRK7LHAsN9fznuHMwHYvZCImBKHmUrk813HtFUCdCbGC1t1H
 5PXT2Zc+tOKT+GsVYZUuKdn/JGqNzEyt45e3UZ5/e6eqRm7+6jcdeeB+8f1JLZvikovqC7zhD
 6Vq2ifDmcrhHQpslVxkJy6fWBtQYfVA18lHRvTbGSW2pS+KjNGiBNi78R6gE0bxGGrb5RDa9W
 2rj+8yvtaNXo6EDOk31hy01qE52OKsHxaWp4VPCrRmXCWEL8tP99N0yjdlZEtrb1GUXFasWBj
 Vqg6ZqssFB7kAhkil/L0bVe6twuvjoqH0XsosPyC7AhEdqqmHCQ28+LspLzQ69BO9+SOcQQJu
 8YWc9sz/7WCbI1uyreQbT2VPLzprYURgHRLKXI1AguYXYfwJyaf5IMYsDRu/Rr5U/s/ypcNC6
 Q5IDXe0LBa+yhewgh28B4mofiMb2+/fjE2zusQgHbsT74Cu2DOb+B6TPIJjU+wsWyCUqnz2tn
 WkIhOH1r3T3I0zwUC26xUCw3FoaAPCL+ceqUz1eOqv582/Ve1r7HoqDzjKGbvo1EKIAV/ZsxV
 RQUv4Yi1wppelkHSFu+9jJK8Fy+SDmC35cZFH02jUHGPcUhCUwD8pMEMwMdXFwzV1SqKKGi5m
 cypa/iuA0sSkH69T98KcmOFV0qe3NJXZGuPqBvN0eXvRhxAd+JTsurODq4MWRoCzX1b5NuGMd
 hFLF9vFBKYWbvZhW1r/5D3OwwBhLfpR0E8Spo3A7uBCxYGl0i94cvdUhA1JvKg/W+0cyy0WPy
 0rmgbpZShF2iO1IiWstRzUkX5Y/32qAErnAhqQ7M54za8PTN0MSzBL/qGLWiGIcd3ktw+1cuv
 v0sU0Bl/EGPWeuaGPY2lt3ChImA/XyElpCJkJyDCGwTz0STEEtCKi2KQub3MNGOW4JWNjABlZ
 QH/5RvhzqDncYSV2pP/8kQY+Ipd1mzASRmWaODyvzepSiAzmWmN3wAmwQOs/kvLhsF1T4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5eQQ9kWmZGC2SS3FH1MDTTUUiv6q2bOee
Content-Type: multipart/mixed; boundary="V2tWknc5kHbw80xntLyjvKIflS14tY7dA";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <a38b7bc4-971e-5373-7324-b27de9de631b@gmx.com>
Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Do not run NetBSD test by
 default
References: <20200211131948.26142-1-philmd@redhat.com>
In-Reply-To: <20200211131948.26142-1-philmd@redhat.com>

--V2tWknc5kHbw80xntLyjvKIflS14tY7dA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Please use cdn.netbsd.org always.

On 11.02.2020 14:19, Philippe Mathieu-Daud=C3=A9 wrote:
> The ftp.netbsd.org server is slow and downloading the NetBSD ISO
> takes too long. Do not include this test in the default suite.
>=20
> Similarly to commit 471c97a69b:
>=20
>   Currently the Avocado framework does not distinct the time spent
>   downloading assets vs. the time spent running a test. With big
>   assets (like a full VM image) the tests likely fail.
>=20
>   This is a limitation known by the Avocado team.
>   Until this issue get fixed, do not run this tests automatically.
>=20
>   Tests can still be run setting the AVOCADO_TIMEOUT_EXPECTED
>   environment variable.
>=20
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/ppc_prep_40p.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_pr=
ep_40p.py
> index b27572f212..efe06037ba 100644
> --- a/tests/acceptance/ppc_prep_40p.py
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -61,6 +61,7 @@ def test_openbios_192m(self):
>          wait_for_console_pattern(self, '>> CPU type PowerPC,604')
> =20
>      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI=
')
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might tim=
eout')
>      def test_openbios_and_netbsd(self):
>          """
>          :avocado: tags=3Darch:ppc
>=20



--V2tWknc5kHbw80xntLyjvKIflS14tY7dA--

--5eQQ9kWmZGC2SS3FH1MDTTUUiv6q2bOee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl5CqywACgkQS7MI6bAu
dmz3Bw/9E+9yBi/A5WJJ/yQq0OdmHy+0SbuO2K7neV0d2X5NTG13Uufa9JPzh5Sp
mFC0rwHWkHhka6/322jPCvO3QiDqFV1KZsPU8b3PqMgq4yeZXtMWoAgZl4zyV/D3
Ws6sSompDX50geqHFyjKNR7J1E1lP3eIcwkJCT3nHaqGpZcz7fWjo+kaJ8zVEStz
0TdsvAtSRo3OIUzoIxRf68fP4A04P+V4rEWUIc0o8XaxKGHL8aGBzAcfv+Yp/jYJ
hWJj9Irohimz3GgJtn79Y0PIGRjp7fylicHar0rAs0t/1wtDrDTSJYRa1cejgtV+
UVDE/e8LpQZaw5j306k7tTvv5hFzj89fyzNy1IGx5chtcgNEp7hMuTe57d7islHZ
ucALji6i1OPqM3amIKfRKoJFDrLJ/4vcgLc9clPJ1gUGlOSDjg6PFbfU/+7HIc1X
XTHGNQ/ScPYe0McoWMhkkojKSNFwl0ONSLvNjWZC1yxcewmkpyDTuxcU+OeQEISK
xPMAqa65CD6aMglxsLklbLgcAEKidB37uFnariJMjpqQtMNEXipSMwztwZoYZOre
gxHxcCtZlIdFLav1eOfPC5K1DAqlYk5jdjU7nl6Nl22AIU3GlEC03EJ7v8tb87i5
AOhxQslPzXt7Ds6eQW0beUoDuYFk72rTzfUlIlf/s6ZNVstA7Lc=
=DL/n
-----END PGP SIGNATURE-----

--5eQQ9kWmZGC2SS3FH1MDTTUUiv6q2bOee--

