Received: from eggs.gnu.org ([208.118.235.92]:54858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdqD-00056q-F8
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdq9-0007nR-26
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:05:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdq8-0007mz-PF
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:05:24 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05113113-5b7c-c094-2870-2eb4a5b09454@redhat.com>
Date: Fri, 2 Feb 2018 09:47:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-3-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mAnrFAfDq3MU3F3sr0Rpn9dI7hqbL36Zi"
Subject: Re: [Qemu-devel] [PATCH RFC 02/21] qapi: Generate up-to-date
 copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mAnrFAfDq3MU3F3sr0Rpn9dI7hqbL36Zi
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <05113113-5b7c-c094-2870-2eb4a5b09454@redhat.com>
Subject: Re: [PATCH RFC 02/21] qapi: Generate up-to-date copyright notice
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-3-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> Each generator carries a copyright notice for the generator itself,
> and another one for the files it generates.  Only the former have been
> updated along the way, the latter have not, and are all out of date.
>=20
> Fix by copying the generator's copyright notice to the generated files
> instead.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/scripts/qapi-commands.py
> @@ -1,16 +1,17 @@
> -#
> -# QAPI command marshaller generator
> -#
> -# Copyright IBM, Corp. 2011
> -# Copyright (C) 2014-2016 Red Hat, Inc.
> -#
> -# Authors:
> -#  Anthony Liguori <aliguori@us.ibm.com>
> -#  Michael Roth    <mdroth@linux.vnet.ibm.com>
> -#  Markus Armbruster <armbru@redhat.com>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2.
> -# See the COPYING file in the top-level directory.
> +"""
> +QAPI command marshaller generator
> +
> +Copyright IBM, Corp. 2011
> +Copyright (C) 2014-2018 Red Hat, Inc.
> +
> +Authors:
> + Anthony Liguori <aliguori@us.ibm.com>
> + Michael Roth <mdroth@linux.vnet.ibm.com>
> + Markus Armbruster <armbru@redhat.com>
> +
> +This work is licensed under the terms of the GNU GPL, version 2.
> +See the COPYING file in the top-level directory.
> +"""

So python lets you start a file with a string constant that is not
associated with any variable name?

> =20
>  (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
>                              'qmp-marshal.c', 'qmp-commands.h',
> -                            blurb)
> +                            blurb, __doc__)

Ah, and there's what I was missing - python auto-assigns such an initial
string to a magic automatic variable.  Cool language feature I hadn't
seen before!

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mAnrFAfDq3MU3F3sr0Rpn9dI7hqbL36Zi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0iAkACgkQp6FrSiUn
Q2p6IQf+I8/czfTlBDVyiIkILSHdCEu97fw/6qCHHfj+IcQzfUK9MLBjLULBuX0E
teRv0SX+f+SEqrsIokyyYBRtc0MnVfxIJ7e1KukFUoo83UU/3yTn8sPaJBihFuLp
qFkA3nazzfTarKf+WS23thA6R7t8cuwiYX9wwRPAw8X3Bm5VSrig0asf20Z3Q0Bp
PJGGQTsD9SP3ZIWPMgMuPgb1vNHD6Qy8z7MKj7CwOAhItCKL8iWXaD8CZ8p4CjBd
x//2z4vG/xUQFUWyEgil5ZigKKJRkqlC48BvRlHzNNgFldSLgpoTRkrvNVc7LzKj
A/GmykEhSXx0TKEGPVpkInqY6goHqA==
=MWCT
-----END PGP SIGNATURE-----

--mAnrFAfDq3MU3F3sr0Rpn9dI7hqbL36Zi--
