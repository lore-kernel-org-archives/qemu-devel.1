Received: from eggs.gnu.org ([2001:4830:134:3::10]:46117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxyX-00082R-FU
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxyW-0003H6-J5
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:23:17 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<f797e0f6c697b2fce069bfafe22ee53f26aebce8.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1cc40a45-4ba1-f485-2697-99e451f677bf@redhat.com>
Date: Wed, 31 Jan 2018 13:23:08 -0600
MIME-Version: 1.0
In-Reply-To: <f797e0f6c697b2fce069bfafe22ee53f26aebce8.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i5vPqQ0fc3ob9VZPNIjBXH410qw7oQabm"
Subject: Re: [Qemu-devel] [PATCH v3 38/39] iotests: Test downgrading an
 image using a small L2 slice size
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
--i5vPqQ0fc3ob9VZPNIjBXH410qw7oQabm
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <1cc40a45-4ba1-f485-2697-99e451f677bf@redhat.com>
Subject: Re: [PATCH v3 38/39] iotests: Test downgrading an image using a small
 L2 slice size
References: <cover.1516978645.git.berto@igalia.com>
 <f797e0f6c697b2fce069bfafe22ee53f26aebce8.1516978645.git.berto@igalia.com>
In-Reply-To: <f797e0f6c697b2fce069bfafe22ee53f26aebce8.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 09:00 AM, Alberto Garcia wrote:
> expand_zero_clusters_in_l1() is used when downgrading qcow2 images
> from v3 to v2 (compat=3D0.10). This is one of the functions that needed=

> more changes to support L2 slices, so this patch extends iotest 061 to
> test downgrading a qcow2 image using a smaller slice size.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/061     | 16 ++++++++++++
>  tests/qemu-iotests/061.out | 61 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 77 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--i5vPqQ0fc3ob9VZPNIjBXH410qw7oQabm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpyF5wACgkQp6FrSiUn
Q2qiaQf/aagnVhzPtcM4/fryGZ4GYNMTm8w38R+KJZyO5XTQCiauDoSjTbpV0AGy
7oWb3r06gVJ5pnShTgAVGKDYmHZkZ9+JUEeGow85xQFi8BJQBAw3N4pWj8rumzaz
qvXY3Up/SDvhJ1rSM8xnUG3ct/kCNMHgxOPi1YfQGzsy1XGQb+hT+tt2JrRDl23z
DCFKri4v48CFGQuwKGrA+m92REejuHsN8MZwfbgF8H+TU6eNuCOUVms0dSpfaBdf
J6leAFcTtmKrcw+Smtejtgi11s+o8D3bbeJs2Rwz9xWALBJInYepjKuzNkbMz/65
i8K+dQR6LJJXU3UJWFH4DbrggTh/nA==
=LcXm
-----END PGP SIGNATURE-----

--i5vPqQ0fc3ob9VZPNIjBXH410qw7oQabm--
