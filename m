Received: from eggs.gnu.org ([2001:4830:134:3::10]:51417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXaYQ-0006hQ-B8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXaYL-0001aQ-MG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:01:18 -0400
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
	<1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b27c6322-49f7-3f73-6df3-e8f4ddae9652@redhat.com>
Date: Tue, 18 Jul 2017 17:01:10 -0500
MIME-Version: 1.0
In-Reply-To: <1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oqF0PEK6SiOdNrquXm7iooovLv7N8DHT3"
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/4] bsd-user/main.c: Fix unused
 variable warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oqF0PEK6SiOdNrquXm7iooovLv7N8DHT3
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: patches@linaro.org
Message-ID: <b27c6322-49f7-3f73-6df3-e8f4ddae9652@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/4] bsd-user/main.c: Fix unused
 variable warning
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
 <1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 11:26 AM, Peter Maydell wrote:
> On OpenBSD the compiler warns:
> bsd-user/main.c:622:21: warning: variable 'sig' set but not used [-Wunu=
sed-but-set-variable]
>=20
> This is because a lot of the signal delivery code is #if-0'd
> out as unused. Reshuffle #ifdefs a bit to silence the warning.

Why not just nuke the #if 0 code instead (we can always 'git revert' it
later as a starting point for someone that wants to implement it).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oqF0PEK6SiOdNrquXm7iooovLv7N8DHT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluhSYACgkQp6FrSiUn
Q2oW9AgAgBBKucdENlPDMPletaUcuhRl7j/M2paG2eeDy3m6pjSKbpj1lz+RZfRK
mL545LKV2BMK8hWSgl+dO5dIMxJmWrRkgkbKaHCsHgZ7Lo5g8N1B7XsCEWRCoOh5
feuOcrY6mcO9L3HgrgYRc3LkfQUMSF5w5N0KgY+GASPW9qh3w+vy+Adm4ctwZE3p
gmn0UUeySY4vjtMf5d5xjoWJ5ZYiGSibHC+Ue8DrDpsSKSi20jCMY1JRyytpyjTj
yrRWpVLA+pJbEGV2iZ+wE3pNkOI248YoH/Qxf1qfTHQkAA1e83pyT6mCi33LPkIl
NL36Dg6MyMevG9m7mfOzJp/mv07bVw==
=KGTS
-----END PGP SIGNATURE-----

--oqF0PEK6SiOdNrquXm7iooovLv7N8DHT3--
