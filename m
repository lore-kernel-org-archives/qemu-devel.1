Received: from eggs.gnu.org ([2001:4830:134:3::10]:56645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaR9-0006gw-Gk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaR8-0002fE-Js
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:14:35 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<43f6f21c8f42204c23efce2755d6f53272ebb51a.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd31273d-91f2-ba7f-6271-e4e20e0e25c6@redhat.com>
Date: Tue, 16 Jan 2018 17:14:26 -0600
MIME-Version: 1.0
In-Reply-To: <43f6f21c8f42204c23efce2755d6f53272ebb51a.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Wm8M0zTG6RMEqTMfqvpuA792ZyHI7Jvas"
Subject: Re: [Qemu-devel] [PATCH v2 26/32] qcow2: Update qcow2_truncate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wm8M0zTG6RMEqTMfqvpuA792ZyHI7Jvas
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <cd31273d-91f2-ba7f-6271-e4e20e0e25c6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 26/32] qcow2: Update qcow2_truncate() to
 support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <43f6f21c8f42204c23efce2755d6f53272ebb51a.1513342045.git.berto@igalia.com>
In-Reply-To: <43f6f21c8f42204c23efce2755d6f53272ebb51a.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> The qcow2_truncate() code is mostly independent from whether
> we're using L2 slices or full L2 tables, but in full and
> falloc preallocation modes new L2 tables are allocated using
> qcow2_alloc_cluster_link_l2().  Therefore the code needs to be
> modified to ensure that all nb_clusters that are processed in each
> call can be allocated with just one L2 slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Wm8M0zTG6RMEqTMfqvpuA792ZyHI7Jvas
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeh1IACgkQp6FrSiUn
Q2pp4QgAnEB0awYEp79sdZv4S3hQOTasDd79hhTt1CxAsbs4huXFCdVcUSJo+kmN
uEj9Mqx/Fqces4/l/VOYgbh6ma/9WlZQeArcsZpecGy0PqrzBfjhSOlifTINZTne
XqdcfHVS7MbvSqapP0/VamnbLsv0aVzU5Em0ero2kk20n1Q2cLM72Zrbk9G1U2MV
5CMNxjNZUzi4fXg6yNTyEGtnMND/7nZRAEehocpYY2cSTJE7lpJQh1rOgj6Fd5Xp
hD2BS+Hf3qJW1y9gt5hRQR9m7Lb78hVdudthgwPR09o7XZzfvU5lXeYbPbptO+Dh
i/6LsYT75tvHFJDnRw1g4c+L3rqNfw==
=fhfG
-----END PGP SIGNATURE-----

--Wm8M0zTG6RMEqTMfqvpuA792ZyHI7Jvas--
