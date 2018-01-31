Received: from eggs.gnu.org ([2001:4830:134:3::10]:41048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egt6A-0002qY-0a
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egt64-0001YD-7S
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:10:49 -0500
References: <20180131102152.16902-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efe28ca0-aa46-3b8b-4d3c-84e886f575e5@redhat.com>
Date: Wed, 31 Jan 2018 08:10:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180131102152.16902-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OtT2Uhnypn9owDs2zSUpEckQe6grGSGDR"
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: Replace align_offset() with
 ROUND_UP()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OtT2Uhnypn9owDs2zSUpEckQe6grGSGDR
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <efe28ca0-aa46-3b8b-4d3c-84e886f575e5@redhat.com>
Subject: Re: [PATCH v2] qcow2: Replace align_offset() with ROUND_UP()
References: <20180131102152.16902-1-berto@igalia.com>
In-Reply-To: <20180131102152.16902-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 04:21 AM, Alberto Garcia wrote:
> The align_offset() function is equivalent to the ROUND_UP() macro so
> there's no need to use the former. The ROUND_UP() name is also a bit
> more explicit.
>=20
> This patch uses ROUND_UP() instead of the slower QEMU_ALIGN_UP()
> because align_offset() already requires that the second parameter is a
> power of two.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OtT2Uhnypn9owDs2zSUpEckQe6grGSGDR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpxzkcACgkQp6FrSiUn
Q2qBFAf49LFzjnj5C8c2cRdBd5tSEPAw5yQFs1VqHxhBhZJjUeNtvOHnVwz6BzBu
0gfeEpmFW8IPJMkbN6h6I7P/mRKACC+kw6T1DoMfJmOFhtHBuAbhreEMStIFlFwn
fzdr3O4voEwCIN6OuYpjXWsaHtrhXYAqiLiDGxDg8wPRmevI8iGAu1xGCENk+onf
IjeenU44i2GS8V6C6IfqvXblRzSzS2vbT42Ho7PKVlooYmCF8C3ObNSmgrlsHFQd
DpIONpnybvGs2xOP+X4JdDwhTWLK5QX9Cy/hBSGQJ6xMkvm8DRXgUt+AgMrLrnMl
nZsJKNACSravOYX9tvOdsnBpfu5Z
=2MFw
-----END PGP SIGNATURE-----

--OtT2Uhnypn9owDs2zSUpEckQe6grGSGDR--
