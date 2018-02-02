Received: from eggs.gnu.org ([2001:4830:134:3::10]:51876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eheZ8-0003Fg-KL
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eheV0-00021g-S6
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:51:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eheV0-00020t-3v
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:47:38 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6826946-cf8c-2cb2-0eec-73938e574b78@redhat.com>
Date: Fri, 2 Feb 2018 10:47:30 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-6-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CvFXuZiFcK7OPtccm30ysM6bATR6lsc68"
Subject: Re: [Qemu-devel] [PATCH RFC 05/21] qapi: Turn generators into
 modules
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
--CvFXuZiFcK7OPtccm30ysM6bATR6lsc68
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <c6826946-cf8c-2cb2-0eec-73938e574b78@redhat.com>
Subject: Re: [PATCH RFC 05/21] qapi: Turn generators into modules
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-6-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> The next commit will introduce a common driver program for all
> generators.  The generators need to be modules for that.  qapi2texi.py
> already is.  Make the other generators follow suit.
>=20
> The changes are actually trivial.  Obvious in the diffs once you view
> them with whitespace changes ignored.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi-commands.py   | 43 ++++++++++++++++++--------------
>  scripts/qapi-event.py      | 43 ++++++++++++++++++--------------
>  scripts/qapi-introspect.py | 54 ++++++++++++++++++++++----------------=
--
>  scripts/qapi-types.py      | 56 ++++++++++++++++++++++----------------=
---
>  scripts/qapi-visit.py      | 62 +++++++++++++++++++++++++-------------=
--------
>  5 files changed, 143 insertions(+), 115 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CvFXuZiFcK7OPtccm30ysM6bATR6lsc68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0liIACgkQp6FrSiUn
Q2qPfAgAqQhqR8yLs5x60wCt04Ku6Tb4mFvwsv/07s0/JsVSL3zm4Df2gK4SAb7V
vYYeGA+KcswwIsJT1KchDCVfw31qY/DWktMYHKHQQgo3oE/2Xe7w5rKfBefcZTvn
ezh7QCNznz5j3MHhk0mL85zAGpEYRqCXCyft07DW30QNyvvypgCI4yQTdQmKzCTj
jUaARrOckE93Ub91LqEALsVyeeNauLNSvy3GSLh4eQJj3fPwB6CDhs+jYyXj3bAL
8qk95wcWHTFiUm2bOC9mcwhoAZg1bocrU9TEkyYsBTDwx7r+weR2EtRFGdm1zvrj
4N7iyd2UzjKWqmJeLwoN7KCRZVtTuw==
=htZX
-----END PGP SIGNATURE-----

--CvFXuZiFcK7OPtccm30ysM6bATR6lsc68--
