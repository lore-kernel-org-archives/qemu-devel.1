Received: from eggs.gnu.org ([2001:4830:134:3::10]:44986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxd6k-0005VY-2a
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxd6g-0008Jg-VU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:00:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dxd6g-0008HI-Ew
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:00:18 -0400
References: <20170928120621.30288-1-berrange@redhat.com>
	<20170928120621.30288-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4db5995-1e8e-b422-f401-3a295ccc7f64@redhat.com>
Date: Thu, 28 Sep 2017 12:59:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170928120621.30288-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="30oLGxGnEkwffTHw9sRJ8AU0BhNDGpQ5K"
Subject: Re: [Qemu-devel] [PATCH v7 1/6] build: automatically handle GIT
 submodule checkout for dtc
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--30oLGxGnEkwffTHw9sRJ8AU0BhNDGpQ5K
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4db5995-1e8e-b422-f401-3a295ccc7f64@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/6] build: automatically handle GIT
 submodule checkout for dtc
References: <20170928120621.30288-1-berrange@redhat.com>
 <20170928120621.30288-2-berrange@redhat.com>
In-Reply-To: <20170928120621.30288-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/28/2017 07:06 AM, Daniel P. Berrange wrote:
> Currently if DTC is required by configure and not available in the host=

> OS install, we exit with an error message telling the user to checkout =
a
> git submodule or install the library.
>=20
> This introduces automatic handling of the git submodule checkout proces=
s
> and enables it for dtc. This only runs if building from GIT, so users o=
f
> release tarballs still need the system library install. The current sta=
te
> of the git checkout is stashed in .git-submodule-status, and a helper
> program is used to determine if this state matches the desired submodul=
e
> state. A dependency against 'Makefile' ensures that the submodule state=

> is refreshed at the start of the build process
>=20

> +++ b/scripts/git-submodule.sh
> @@ -0,0 +1,31 @@
> +#!/bin/bash
> +
> +set -e

New file, but appears not to be covered by MAINTAINERS; that should be
fixed.  Also, an explicit copyright/license might be needed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--30oLGxGnEkwffTHw9sRJ8AU0BhNDGpQ5K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnNOJwACgkQp6FrSiUn
Q2pCFAf/Wf+myp7maxK2uS+zsLqxROxj/wTValPxjyGS5pS91SGyXNIqouSlJaSv
Bu5wWmS6Ef+BmYgLmveNFZjhi/3aBkzoPW6WaB1+EDLPxq9PeZKsb0XaD/mEmqKk
i1vqbQIKyHXBXtxi3hLY80/w12/R6URTX5g71FDBBdYiR1OxZ1fnfS9DeOF0l2hg
MerXnFSxquOfoYblgm/EOgcq+Gu2xCnO6opDIS2MvzIxwBtGqN7pwKxoDUh6a3/m
rwe4E97aJFJmvCfEvhHoa9f/wc904JZ+b2wDTZZJFar00Aq5OPgtzr7TppH1bHg2
yL2Pr9/eyHjoSroGSs5jT41N8/1BuQ==
=iSVj
-----END PGP SIGNATURE-----

--30oLGxGnEkwffTHw9sRJ8AU0BhNDGpQ5K--
