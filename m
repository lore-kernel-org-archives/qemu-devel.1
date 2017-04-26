Received: from eggs.gnu.org ([2001:4830:134:3::10]:39307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Mef-0004BP-5p
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Mea-0002Hi-Nn
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3Mea-0002Go-Eg
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:06:44 -0400
References: <1493158501-22284-1-git-send-email-gm.ijewski@web.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <629a32c9-46f8-ecc5-9307-f2560f06bb57@redhat.com>
Date: Wed, 26 Apr 2017 08:06:42 -0500
MIME-Version: 1.0
In-Reply-To: <1493158501-22284-1-git-send-email-gm.ijewski@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vLwELutr1Gdr8dGHkmUfB6GcSuaO2KtWx"
Subject: Re: [Qemu-devel] [PATCH v5] crypto: qcrypto_random_bytes() now
 works on windows w/o any other crypto libs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Martin Ijewski <gm.ijewski@web.de>, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vLwELutr1Gdr8dGHkmUfB6GcSuaO2KtWx
From: Eric Blake <eblake@redhat.com>
To: Geert Martin Ijewski <gm.ijewski@web.de>, qemu-devel@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <629a32c9-46f8-ecc5-9307-f2560f06bb57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5] crypto: qcrypto_random_bytes() now works
 on windows w/o any other crypto libs
References: <1493158501-22284-1-git-send-email-gm.ijewski@web.de>
In-Reply-To: <1493158501-22284-1-git-send-email-gm.ijewski@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 05:15 PM, Geert Martin Ijewski wrote:
> If no crypto library is included in the build, QEMU uses
> qcrypto_random_bytes() to generate random data. That function tried to =
open
> /dev/urandom or /dev/random and if opening both files failed it errored=
 out.
>=20
> Those files obviously do not exist on windows, so there the code uses
> CryptGenRandom().
>=20
> Furthermore there was some refactoring and a new function
> qcrypto_random_init() was introduced. If a proper crypto library (gnutl=
s or
> libgcrypt) is included in the build, this function does nothing. If nei=
ther
> is included it initializes the (platform specific) handles that are use=
d by
> qcrypto_random_bytes().
> Either:
> * a handle to /dev/urandom | /dev/random on unix like systems
> * a handle to a cryptographic service provider on windows
>=20
> Signed-off-by: Geert Martin Ijewski <gm.ijewski@web.de>
> ---

It's useful to provide a changelog after the --- separator of how v5
differs from v4 (in this case, you fixed a typo that broke compilation).

It's also wise to cc the appropriate maintainer, using
scripts/get_maintainer.pl as your guide. In this case, that would be Dan.=


But no need to send a v6 just for that. I'll let Dan review this one.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vLwELutr1Gdr8dGHkmUfB6GcSuaO2KtWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAJtiAAoJEKeha0olJ0Nq2ioH/1f7l/92dT3jRywT20S10QTP
PTxHc//k8LZgM6IGD4Z2DIGD8wzj4RYsfFZw8gI21HN++Vns1I8v2KpZtuQfQuSi
SCqURovymJlqaT7vPkJKPs51THgz6D4sOA3ejyUzJd3EAXEBcajYP+e8D9zs37pF
3nVt2w02w5aOTVWbpOZ1qxejD/PW83XMBVJ/oBB8NbS9+pw1Pxc4b3MKo03q1DPz
xlhwq5IgpLw+TOVgSyL2OGJzC5+8ErNIQO7+9mI4O3G7icE7rzR2+Bi92Y9IMTf/
fRKOZ/AgfVON1b6EBIBWMOeQq9jKEaFpqBxQJa+5Ksn2BzNxLSVdusPhnTwjozo=
=o/97
-----END PGP SIGNATURE-----

--vLwELutr1Gdr8dGHkmUfB6GcSuaO2KtWx--
