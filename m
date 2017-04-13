Received: from eggs.gnu.org ([2001:4830:134:3::10]:35112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyhLD-0000pV-TU
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyhLC-0005dJ-T5
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:11:27 -0400
References: <20170413160625.27719-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <552264f6-a4ae-88f5-41c8-dc1e1f33e4bc@redhat.com>
Date: Thu, 13 Apr 2017 11:11:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170413160625.27719-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cbFMrM7VhGmXOMp973tXwQtpnmbUjrWUL"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 0/2] block: An empty
 filename counts as no filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cbFMrM7VhGmXOMp973tXwQtpnmbUjrWUL
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <552264f6-a4ae-88f5-41c8-dc1e1f33e4bc@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.10 0/2] block: An empty filename counts
 as no filename
References: <20170413160625.27719-1-mreitz@redhat.com>
In-Reply-To: <20170413160625.27719-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 11:06 AM, Max Reitz wrote:
> See patch 1 for what is happening when you try "qemu-img info ''" and
> for the fix.
>=20
> (Patch 2 just adds a simple test.)
>=20
>=20
> Max Reitz (2):
>   block: An empty filename counts as no filename
>   iotests/051: Add test for empty filename

Reviewed-by: Eric Blake <eblake@redhat.com>

Agree that this is not 2.9 material (but I see you cc'd qemu-stable for
1/2 going into 2.9.1, which is fine).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cbFMrM7VhGmXOMp973tXwQtpnmbUjrWUL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY76MmAAoJEKeha0olJ0Nqwv8IAK3HrjQuF2DYCFJvr3ugxVkZ
69/u2F78RC3SaWpepSOxssY853F6AXqaVyL1r0oZSXLA9KwEu3u3Nm7O0NhgA6Rd
G06Dc9Fn5gvpEg5QTOOUDWpUTJ0mMxtWfoYIIx93L3Oe2tiHTqWHxKHVHKTEPW+2
Th/QcuXC8I8fOKxzX4c9ehXCUykNBZQYs1DeYC7IH4WAKgZOC6iEaYB67lemlC/u
KQe5FdogQo+7FHOoYW1k5eCb3IyEMcvO6jvfAaaX66WU1p1CZtg82M+ioIAdCf5j
MJJlBDcBC/FxuoHzmAmtotJm1/TkRc6aYHHFjL+z7ZA+iqtpOXQCpGE7n6RvbQA=
=zRNB
-----END PGP SIGNATURE-----

--cbFMrM7VhGmXOMp973tXwQtpnmbUjrWUL--
