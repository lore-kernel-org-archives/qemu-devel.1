Received: from eggs.gnu.org ([2001:4830:134:3::10]:33500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBK26-0005LQ-3s
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBK22-0007kA-TB
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:00:26 -0400
From: Eric Blake <eblake@redhat.com>
References: <20180424192506.149089-1-eblake@redhat.com>
	<20180424192506.149089-5-eblake@redhat.com>
Message-ID: <b293a052-41c9-c6d9-e28a-ebcb8b11a9e8@redhat.com>
Date: Wed, 25 Apr 2018 08:00:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180424192506.149089-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h7eUmt8qy5IIpXL3sFVOEAmBHGDCiGi6s"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/6] rbd: Switch to
 byte-based callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h7eUmt8qy5IIpXL3sFVOEAmBHGDCiGi6s
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <b293a052-41c9-c6d9-e28a-ebcb8b11a9e8@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 4/6] rbd: Switch to byte-based callbacks
References: <20180424192506.149089-1-eblake@redhat.com>
 <20180424192506.149089-5-eblake@redhat.com>
In-Reply-To: <20180424192506.149089-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 02:25 PM, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the last few sector-based callbacks
> in the rbd driver.
>=20
> Note that the driver was already using byte-based calls for
> performing actual I/O, so this just gets rid of a round trip
> of scaling; however, as I don't know if RBD is tolerant of
> non-sector AIO operations, I went with the conservate approach

s/conservate/conservative/

> of adding .bdrv_refresh_limits to override the block layer
> defaults back to the pre-patch value of 512.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org



--h7eUmt8qy5IIpXL3sFVOEAmBHGDCiGi6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrge9MACgkQp6FrSiUn
Q2p9kwgArVsvH73xuWY/FGVUMZtHnUzSnRn1b5lMmTsyEdAN2akm9pVcJYfY4aEa
qDTDyt8ni7+UiAz4PrucOlt8NVYdQsmYr58irgh+CIbXBWGLy1bHripuscCjc+7+
GH5qpxgypnemPkFXq4QIqXQxFSgEFuDEjCGLg706bp+Hag4LarjaS53c0Oy6RLgD
uFIUlmlIJaCH67LpWnVHMc8McLZEPlU/5LxAqUPJdmV9vsGAtfvYRgHURnPHjWCr
rZwi9k0U11gUSS3+9Mcq0MeWHF0wK03Y/7GDFSU+1HPsrw8QYfFrygl0VcrFDVyE
TBMzDv+Lx4/vxxg22lF+rcVpcAvUbw==
=l6F3
-----END PGP SIGNATURE-----

--h7eUmt8qy5IIpXL3sFVOEAmBHGDCiGi6s--
