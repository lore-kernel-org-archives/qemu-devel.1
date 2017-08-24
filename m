Received: from eggs.gnu.org ([2001:4830:134:3::10]:35638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl16c-0008D2-Nf
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 19:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl16X-00049a-So
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 19:00:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dl16X-00048Y-Kd
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 19:00:01 -0400
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<20170818142613.32394-5-ldoktor@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <1140e62e-6cb7-335f-fbf4-e818fdbc1343@redhat.com>
Date: Thu, 24 Aug 2017 18:59:48 -0400
MIME-Version: 1.0
In-Reply-To: <20170818142613.32394-5-ldoktor@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fdmLhTrNenvEsjAAnoSb1HbOBAcRXxR0R"
Subject: Re: [Qemu-devel] [PATCH v6 04/10] qemu.py: Simplify QMP
 key-conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fdmLhTrNenvEsjAAnoSb1HbOBAcRXxR0R
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org
Message-ID: <1140e62e-6cb7-335f-fbf4-e818fdbc1343@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/10] qemu.py: Simplify QMP
 key-conversion
References: <20170818142613.32394-1-ldoktor@redhat.com>
 <20170818142613.32394-5-ldoktor@redhat.com>
In-Reply-To: <20170818142613.32394-5-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/18/2017 10:26 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> The QMP key conversion consist of '_'s to be replaced with '-'s, which
> can easily be done by a single `str.replace` method which is faster and=

> does not require `string` module import.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qemu.py | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index db21407..19cbd34 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -13,7 +13,6 @@
>  #
> =20
>  import errno
> -import string
>  import os
>  import sys
>  import subprocess
> @@ -181,14 +180,12 @@ class QEMUMachine(object):
>              self._load_io_log()
>              self._post_shutdown()
> =20
> -    underscore_to_dash =3D string.maketrans('_', '-')
> -
>      def qmp(self, cmd, conv_keys=3DTrue, **args):
>          '''Invoke a QMP command and return the response dict'''
>          qmp_args =3D dict()
>          for key, value in args.iteritems():
>              if conv_keys:
> -                qmp_args[key.translate(self.underscore_to_dash)] =3D v=
alue
> +                qmp_args[key.replace('_', '-')] =3D value
>              else:
>                  qmp_args[key] =3D value
> =20
>=20

Right, this would only make sense if multiple (different) substitutions
were necessary.

Reviewed-by: Cleber Rosa <crosa@redhat.com>


--fdmLhTrNenvEsjAAnoSb1HbOBAcRXxR0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmfWmQACgkQZX6NM6Xy
CfMFkxAAuaIH0XEw1IUuTgfqEvOEwQ3SMMwosAeOIXSifaqo/SirJLkp6YgqBrYz
hriIiUuZgkNtH4t+A15bWXcElF9LiP//l6mXIfCtMX3KxGdJGER/6w2iVb9zBT0i
LylCnzZbsfxCUazfKkXYqK9S4yAPKIhGbMmS8pSt0vPJkuFMAsceWVLP6dI2Zac9
u7J9yWLYqM27RY4UaRZnjOTB+CcydhD2DOILYIqbOgYFDX/5ziwsjP3J4q0svJEz
Wu5PnrjAoZ3qL7Gqie/Rq0fadzuhC9l8pWr6wmyYN71z/qKiTpcCb4pMUcRLg0eS
uOYHNQibQriKk8fu1zOuBmOOmRBxTeGnU3bQD0FlBJH2wgLHRNdFW/K0/1I+8qIE
elAwuU0PTHhQvgioJcgpeEDjk/OQoXRe7lrfytklYUMcoPNVz3O9KJhdp7ZiLt34
zv4A5Hra4GisVJCz101jRrXU96kGXHBskA5ZuJPCbgMzLXJKQenZBQ0eS1SDJUxL
uLO48X4rgMRAVkBH0wqSqJG5E3aXeRazxu+xMzcMkEO71gIRR/liV3cIz6bFlkOR
vVTj9BUMsLo2069/C2o/lpFbebWXumfq/QyPHCwRqoszgnpsbiHXV4MDT1BKhJ3C
VQC7XA6+4jTgM7ltXJGPlabMU0PbA8czuIcP/cTViKQXBJOZbYk=
=jaDk
-----END PGP SIGNATURE-----

--fdmLhTrNenvEsjAAnoSb1HbOBAcRXxR0R--
