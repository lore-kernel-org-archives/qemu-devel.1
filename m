Received: from eggs.gnu.org ([2001:4830:134:3::10]:35980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZe7Z-0000kC-GT
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZe7V-0004wl-Jy
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:46:21 -0500
References: <20180111143201.17865-1-mjt@msgid.tls.msk.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06f69aed-3a7c-1f78-e83e-64e0fbd64791@redhat.com>
Date: Thu, 11 Jan 2018 08:46:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180111143201.17865-1-mjt@msgid.tls.msk.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ec0CX49K14KYlzkQzom2CBy3xvstDIOPx"
Subject: Re: [Qemu-devel] [PATCH trivial] scripts/argparse.py: spelling
 (independant)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ec0CX49K14KYlzkQzom2CBy3xvstDIOPx
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <06f69aed-3a7c-1f78-e83e-64e0fbd64791@redhat.com>
Subject: Re: [Qemu-devel] [PATCH trivial] scripts/argparse.py: spelling
 (independant)
References: <20180111143201.17865-1-mjt@msgid.tls.msk.ru>
In-Reply-To: <20180111143201.17865-1-mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 08:32 AM, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  scripts/argparse.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/argparse.py b/scripts/argparse.py
> index 288c1f06c0..27d1f28935 100644
> --- a/scripts/argparse.py
> +++ b/scripts/argparse.py

=46rom the top of the file:

# This is a local copy of the standard library argparse module taken
from PyPI.
# It is licensed under the Python Software Foundation License.  This is a=

# fallback for Python 2.6 which does not include this module.  Python
2.7+ and
# 3+ will never load this module because built-in modules are loaded befo=
re
# anything in sys.path.


> @@ -76,7 +76,7 @@ considered public as object names -- the API of the f=
ormatter objects is
>  still considered an implementation detail.)
>  """
> =20
> -__version__ =3D '1.4.0'  # we use our own version number independant o=
f the
> +__version__ =3D '1.4.0'  # we use our own version number independent o=
f the
>                         # one in stdlib and we release this on pypi.

Is this typo still present in the upstream source that we copied from?
It's our local downstream copy, so we can tweak it, but we might want to
feed this one back upstream.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ec0CX49K14KYlzkQzom2CBy3xvstDIOPx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpXeLYACgkQp6FrSiUn
Q2oxyQf/VufzckI8PoAG00mQtxG0tP3GzHsmDQz+P0HEUR5sMO7gZBoaIz6476RV
qGX2vgjNxBh6cqROIiuh5nSzPZEvI1ct4FK75dbcWPWgb7tDsDAkgfvwUepgkPcD
pqXPAJW/qeUUPH4D2nc9crFK06arOOfwRWO1uQTdIuKWC13m1OsMZhiRETsaBBZ+
TZrAUcIzDFivyNYHyx/SUIMagFnCHsEtR4DwFBSNze7Vu/AfMhOG5Y3PADL8qsIc
Z/zFdQ3zqDNQ+i73wlJO56kuLUsXHSmMOMom+kcNNwAGE05WfL//zXx1Vozpnfte
ZH19E5uKEKSvi4gIhiZQ/qWm9bTbkA==
=cJVT
-----END PGP SIGNATURE-----

--Ec0CX49K14KYlzkQzom2CBy3xvstDIOPx--
