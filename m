Received: from eggs.gnu.org ([2001:4830:134:3::10]:53416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cym7T-0007um-CK
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cym7S-0002Pd-4a
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:17:35 -0400
References: <20170413203401.3213-1-mreitz@redhat.com>
	<20170413203401.3213-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <25e5ee1f-3bc7-d657-59db-c4e59baf8e28@redhat.com>
Date: Thu, 13 Apr 2017 16:17:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170413203401.3213-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gjq2WXT3WP2ejls70jd8rSVJjnfr9HgxT"
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] qemu-img/convert: Move bs_n >
 1 && -B check down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gjq2WXT3WP2ejls70jd8rSVJjnfr9HgxT
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <25e5ee1f-3bc7-d657-59db-c4e59baf8e28@redhat.com>
Subject: Re: [PATCH for-2.10 3/3] qemu-img/convert: Move bs_n > 1 && -B check
 down
References: <20170413203401.3213-1-mreitz@redhat.com>
 <20170413203401.3213-4-mreitz@redhat.com>
In-Reply-To: <20170413203401.3213-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 03:34 PM, Max Reitz wrote:
> It does not make much sense to use a backing image for the target when
> you concatenate multiple images (because then there is no correspondenc=
e
> between the source images' backing files and the target's); but it was
> still possible to give one by using -o backing_file=3DX instead of -B X=
=2E
>=20
> Fix this by moving the check.
>=20
> (Also, change the error message because -B is not the only way to
>  specify the backing file, evidently.)

For that matter, 'create -B' is intentionally? undocumented in the
qemu-img --help and man page.  (Personally, I don't know why we don't
want it documented - is it because it it not a universal option because
not all formats support backing files?)

>=20
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c                 | 14 +++++++-------
>  tests/qemu-iotests/122.out |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

Having a backing file for the destination may still make sense for some
convoluted workflow, but you can get that with a followup qemu-img rebase=
=2E

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gjq2WXT3WP2ejls70jd8rSVJjnfr9HgxT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7+rlAAoJEKeha0olJ0NqnI8H/2Dc1asvPrxm2CLeFvGeKsDE
R3QjXUPAjscU4yUH1KTLriY5RBRK2ZY7CmK3p4oA1DHR+6O0PHIdfxiViW4uZEtV
cbehupjVk6MAo1rb0oiRvbgtiUUxt63D1IncBkxvu9/XLblvkhqxSiyfUSo/rD5J
mwxwJ1YlfjRkHn8Kp0zh7HAl3+YE+uCjqJJXMD8bmsuYbwsVfv9aUqN9UbFxPfcp
2blhsYUgO6hEVmI1bhRC4M/tWNcfHr8i1kEoaHtfgC4nYGZIjpL53sS8v5+6HfXm
0mrn0gyoStgUeNCMY3vKNsjvQOlPtsiHt3XMQEfB8ka27Ka5AlGAHJ1pAmz97Z8=
=meHz
-----END PGP SIGNATURE-----

--gjq2WXT3WP2ejls70jd8rSVJjnfr9HgxT--
