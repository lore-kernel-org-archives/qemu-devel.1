Received: from eggs.gnu.org ([2001:4830:134:3::10]:38832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6vQ-0002Wr-QR
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6vP-00078o-Tj
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:32:24 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<db0de08fbcb9cc8d77e7bd5040e89e167cbe1adf.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6bb0b754-f5a9-3344-d7a8-dc1df388d5b0@redhat.com>
Date: Fri, 26 Jan 2018 10:24:57 -0600
MIME-Version: 1.0
In-Reply-To: <db0de08fbcb9cc8d77e7bd5040e89e167cbe1adf.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AduKmt8iWIdEtSq8cBFRBtk1LEFD5c1HT"
Subject: Re: [Qemu-devel] [PATCH v3 16/39] qcow2: Prepare l2_allocate() for
 adding L2 slice support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AduKmt8iWIdEtSq8cBFRBtk1LEFD5c1HT
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <6bb0b754-f5a9-3344-d7a8-dc1df388d5b0@redhat.com>
Subject: Re: [PATCH v3 16/39] qcow2: Prepare l2_allocate() for adding L2 slice
 support
References: <cover.1516978645.git.berto@igalia.com>
 <db0de08fbcb9cc8d77e7bd5040e89e167cbe1adf.1516978645.git.berto@igalia.com>
In-Reply-To: <db0de08fbcb9cc8d77e7bd5040e89e167cbe1adf.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 08:59 AM, Alberto Garcia wrote:
> Adding support for L2 slices to l2_allocate() needs (among other
> things) an extra loop that iterates over all slices of a new L2 table.
>=20
> Putting all changes in one patch would make it hard to read because
> all semantic changes would be mixed with pure indentation changes.
>=20
> To make things easier this patch simply creates a new block and
> changes the indentation of all lines of code inside it. Thus, all
> modifications in this patch are cosmetic. There are no semantic
> changes and no variables are renamed yet. The next patch will take
> care of that.

Thanks for the split - it does make reviewing easier.

>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 55 ++++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 30 insertions(+), 25 deletions(-)

More lines than before, because of the added {}.  But diff ignoring
whitespace makes this one easy to validate.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AduKmt8iWIdEtSq8cBFRBtk1LEFD5c1HT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprVlkACgkQp6FrSiUn
Q2p+VAgAlLm+huTYxJhV564rLrA69GR6wO0UGFDHUhHZEfEcY6UNfOZhPeJUXImN
s8bZutmi6+pQfFPXCr22a5/dDApbVhGQHWqe43g3cRec5Z/G1XYSoKQxv6Y0g8L4
zaJBIVNx7YUawTbS7I3RFN+ehQKOx9pDo8+kBkxQBMjLCy8xT+VuIITQ2BI5zpW5
mCGAnmGhcXlhc9D5vKkn0yM1bT5jlNJNmmGCO+kBxYqKfr3XL67UmGpZYcVgh897
PQIUa6e4PzG+WpqPOq1hsM1IO7gcVAlqV7f4/tsrnlJ9x0S3mzllhuk/SMUMnhuK
9K0XE0md7grlLEqDsBCGqkKfENxkcQ==
=vyCG
-----END PGP SIGNATURE-----

--AduKmt8iWIdEtSq8cBFRBtk1LEFD5c1HT--
