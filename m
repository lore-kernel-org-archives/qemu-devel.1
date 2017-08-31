Received: from eggs.gnu.org ([2001:4830:134:3::10]:44062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnRvy-0004PA-Tk
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnRvp-0001g8-HL
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:03:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnRvp-0001fM-7k
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:03:01 -0400
References: <20170831142430.16665-1-berrange@redhat.com>
	<20170831142430.16665-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5aa15941-49fc-1cc3-941e-d715333df704@redhat.com>
Date: Thu, 31 Aug 2017 11:02:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170831142430.16665-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V8MvJboOcaGdDUiVoB2SkoSVThfF0Hu4j"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] qapi: Use OrderedDict from standard
 library if available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V8MvJboOcaGdDUiVoB2SkoSVThfF0Hu4j
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <5aa15941-49fc-1cc3-941e-d715333df704@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] qapi: Use OrderedDict from standard
 library if available
References: <20170831142430.16665-1-berrange@redhat.com>
 <20170831142430.16665-4-berrange@redhat.com>
In-Reply-To: <20170831142430.16665-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 09:24 AM, Daniel P. Berrange wrote:
> The OrderedDict class appeared in the 'collections' module
> from python 2.7 onwards, so use that in preference to our
> local backport if available.

Since we're now using argparse.py as a third-party import (commit
47e1cb1f) also for the sake of 2.6, can we treat ordereddict.py as the
same sort of third-party import?

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/qapi.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index d89af7d6c6..05cb1ee38c 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -18,7 +18,10 @@ import os
>  import re
>  import string
>  import sys
> -from ordereddict import OrderedDict
> +try:
> +    from collections import OrderedDict
> +except:
> +    from ordereddict import OrderedDict
> =20
>  builtin_types =3D {
>      'null':     'QTYPE_QNULL',
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--V8MvJboOcaGdDUiVoB2SkoSVThfF0Hu4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoMy0ACgkQp6FrSiUn
Q2qPaggArLRiK1Q9FFjyc5A1KL/XuU1IDBcvoABodnaoKfeUITVzQfuYim3vEgWF
UGjBau+4k4huNQHLARs5uBqcQTBzuFD07MCDI8CuflwwyJhSfYX9p7Ey5syn2mnG
caMpyXFZ1p5e1/YpG3XHSt2vWQr5EZXbO+bXN902H51c/1UrBe8iCjjr2KSuBeuJ
nn0Mluvvizn0/0TswekRm8GYvbYKTMR7ST65k/4qi7czpyLO9bvedcozmrU/Mc8R
30HqpITIG9uzN+ueUlxI+oCQxBIkqCZEZOeY1OlmUDYeeGCeHSQrFeh9DI5qtuqC
hIKD1nSKH0D7OG6SNHs7dLtYH5qPEQ==
=xa7Z
-----END PGP SIGNATURE-----

--V8MvJboOcaGdDUiVoB2SkoSVThfF0Hu4j--
