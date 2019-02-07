Received: from eggs.gnu.org ([209.51.188.92]:46942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gio@debian.org>) id 1grhV1-00022e-Jq
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gio@debian.org>) id 1grhUq-0007Mi-2r
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:05:33 -0500
Received: from pietrobattiston.it ([92.243.7.39]:55962
	helo=jauntuale.pietrobattiston.it)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gio@debian.org>) id 1grhUg-0006mH-4F
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:05:29 -0500
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
	<20190207114913.2c5f2c5b.cohuck@redhat.com>
From: Giovanni Mascellani <gio@debian.org>
Message-ID: <6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
Date: Thu, 7 Feb 2019 12:05:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190207114913.2c5f2c5b.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="i4NmYQPYso7JrfWRvxPiwsyRPODiTSj2z"
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
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i4NmYQPYso7JrfWRvxPiwsyRPODiTSj2z
From: Giovanni Mascellani <gio@debian.org>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
 <20190207114913.2c5f2c5b.cohuck@redhat.com>
In-Reply-To: <20190207114913.2c5f2c5b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, thanks for answering!

Il 07/02/19 11:49, Cornelia Huck ha scritto:
> Did that work before commit 7de3b1cdc67 ("s390x/tcg: properly implement=

> the TOD")?

It does not seem so:

$ /qemu-s390x-new -version
qemu-s390x version 2.12.50 (v2.12.0-1983-g7de3b1cdc6-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
$ /qemu-s390x-new ./a.out
Istruzione non consentita

(i.e., "illegal instruction")

But this might be expected. Now I go to the previous commit (f777b20544)
and recompile:

$ /qemu-s390x-new -version
qemu-s390x version 2.12.50 (v2.12.0-1982-gf777b20544-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
$ /qemu-s390x-new ./a.out
Istruzione non consentita

So again. And even going back to 76ed4b18de (i.e., skipping a few
apparently related s390x commits):

$ /qemu-s390x-new -version
qemu-s390x version 2.12.50 (v2.12.0-1976-g76ed4b18de-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
$ /qemu-s390x-new ./a.out
Istruzione non consentita
> stckf will end up at the same helper, so it seems likely to hit the
> same problem.

I guessed so.

Thanks again, Giovanni.
--=20
Giovanni Mascellani <g.mascellani@gmail.com>
Postdoc researcher - Universit=C3=A9 Libre de Bruxelles


--i4NmYQPYso7JrfWRvxPiwsyRPODiTSj2z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSiBF6hBvCQNcghJEaNr8EMz954SQUCXFwQ5QAKCRCNr8EMz954
SQx0AQDf//9Bw2be/QWrPsxHkpiHAwUfxIw/8Oy4jDVfSRC7sgEA/q/RZdM/83hM
+T4bgYDmD91/mh+/w3Fz+cTjzDeiKAo=
=GgA8
-----END PGP SIGNATURE-----

--i4NmYQPYso7JrfWRvxPiwsyRPODiTSj2z--
