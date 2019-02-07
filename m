Received: from eggs.gnu.org ([209.51.188.92]:45070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gio@debian.org>) id 1grjIt-0006zS-KO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gio@debian.org>) id 1grjId-00062g-EN
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:01:16 -0500
Received: from pietrobattiston.it ([2001:4b98:dc0:41:216:3eff:feb1:1135]:58692
	helo=jauntuale.pietrobattiston.it)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gio@debian.org>) id 1grjIb-0005i7-5T
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:01:01 -0500
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
	<20190207114913.2c5f2c5b.cohuck@redhat.com>
	<6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
	<ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
	<1a3f847e-a371-eacb-8be6-678bb3c20b05@debian.org>
	<951bf77e-f953-48aa-9e2e-3f7c66bb9db2@redhat.com>
	<78990142-121a-f84d-811b-60ec503f394b@linaro.org>
From: Giovanni Mascellani <gio@debian.org>
Message-ID: <175f1e54-4517-d815-f6ac-566be14bfc3a@debian.org>
Date: Thu, 7 Feb 2019 14:00:50 +0100
MIME-Version: 1.0
In-Reply-To: <78990142-121a-f84d-811b-60ec503f394b@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="y4iljxKzkShfp4o52JT2HvFlM62kdMuSo"
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y4iljxKzkShfp4o52JT2HvFlM62kdMuSo
From: Giovanni Mascellani <gio@debian.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <175f1e54-4517-d815-f6ac-566be14bfc3a@debian.org>
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
 <20190207114913.2c5f2c5b.cohuck@redhat.com>
 <6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
 <ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
 <1a3f847e-a371-eacb-8be6-678bb3c20b05@debian.org>
 <951bf77e-f953-48aa-9e2e-3f7c66bb9db2@redhat.com>
 <78990142-121a-f84d-811b-60ec503f394b@linaro.org>
In-Reply-To: <78990142-121a-f84d-811b-60ec503f394b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Il 07/02/19 13:15, Richard Henderson ha scritto:
> See also
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg06734.html
>=20
> which I never followed up on the review changes requested.

I can confirm that both patches (Thomas' and Richard's) work for me.
Although they produce rather different results:

 Thomas' patch:   around 6346926678828662276
 Richard's patch: around 9048173079139739571

They also appear to grow at different speeds, if I am not mistaken. I
have no idea of what is correct, because I do not know s390x.

Thanks again for your interest, Giovanni.
--=20
Giovanni Mascellani <g.mascellani@gmail.com>
Postdoc researcher - Universit=C3=A9 Libre de Bruxelles


--y4iljxKzkShfp4o52JT2HvFlM62kdMuSo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSiBF6hBvCQNcghJEaNr8EMz954SQUCXFwsAgAKCRCNr8EMz954
SVtGAQCPlIARB1RSM7fHwM9zxLnHYaA4nfTm9br8lwabhPPFAQEA5I2KriL16LSN
DoQEfHu9KbqWiH+me0e6u2zyrkKsDAU=
=FT4+
-----END PGP SIGNATURE-----

--y4iljxKzkShfp4o52JT2HvFlM62kdMuSo--
