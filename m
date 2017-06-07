Received: from eggs.gnu.org ([2001:4830:134:3::10]:51991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIiop-0000mt-1K
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIiol-0007Qd-UZ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:48:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIiol-0007QM-Lh
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:48:43 -0400
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39aca404-2879-5e4c-deea-038853e70323@redhat.com>
Date: Wed, 7 Jun 2017 16:48:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170607074632.13162-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VMGJcwCU2FCoLMhtmjJS0s86bqd7aU9If"
Subject: Re: [Qemu-devel] [PATCH 1/5] coccinelle: replace code with ROUND_UP
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VMGJcwCU2FCoLMhtmjJS0s86bqd7aU9If
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Message-ID: <39aca404-2879-5e4c-deea-038853e70323@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] coccinelle: replace code with ROUND_UP
 macro
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
 <20170607074632.13162-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170607074632.13162-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 02:46 AM, Marc-Andr=C3=A9 Lureau wrote:
> I used a the following coccinelle script:
>=20
> @@
> expression e1;
> @@
> - ((e1) + (3)) / (4) * (4)
> + ROUND_UP(e1,4)


Can't you also search for:

@@
expression e1, e2
@@
- ((e1) + (e2 - 1)) / (e2) * (e2)
+ ROUND_UP(e1, e2)

to catch cases where we are rounding by a non-constant?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VMGJcwCU2FCoLMhtmjJS0s86bqd7aU9If
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOHS3AAoJEKeha0olJ0Nqvc0H/RXpxF8iPQEPIn51nRd1vXQt
Iv9Pq7OW16fq3qzra838ctO9Bh+6mzGCHYJL64R04O6oMmtixY6hTg+rkwLWsCmt
TDG54Ts33DIVdAHwz9i8Ob6i57/Ayv6SJm+dRz4s1sQTDP8f1rGxDTFOhrwHwoop
wIsph0x75K0o/iHeG2MuQffxpKZK4RbroV2gXR1vqnGWry/GVFuwhz6jY8G0Bsvh
6rGuakN2xBl30j+DdwrqIs4yBw0668ufsJzHMXXq6LlixJpmzABaG6sYsQ/Dx/Fi
pVS1obYDOLHPR4RH8b39Vir5RtUAxF47W4KIlWLPt9jolf28nLVDSOXpFb0Mppc=
=72or
-----END PGP SIGNATURE-----

--VMGJcwCU2FCoLMhtmjJS0s86bqd7aU9If--
