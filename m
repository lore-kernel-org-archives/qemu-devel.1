Received: from eggs.gnu.org ([2001:4830:134:3::10]:45691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXpNK-0004BJ-5C
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXpNG-0001IT-4H
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:50:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXpNF-0001IL-Qc
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:50:46 -0400
References: <150045605172.87.12406075149250299600@5d477a5b5989>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7421557-d536-73a3-26f6-2f657ff62e52@redhat.com>
Date: Wed, 19 Jul 2017 08:50:40 -0500
MIME-Version: 1.0
In-Reply-To: <150045605172.87.12406075149250299600@5d477a5b5989>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SdtqW5Rqpitm5SNWdoga44aL52XXifLNk"
Subject: Re: [Qemu-devel] [PATCH] error: Revert unwanted change of warning
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, armbru@redhat.com
Cc: kwolf@redhat.com, famz@redhat.com, alistair.francis@xilinx.com, mdroth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SdtqW5Rqpitm5SNWdoga44aL52XXifLNk
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, no-reply@patchew.org, armbru@redhat.com
Cc: kwolf@redhat.com, famz@redhat.com, alistair.francis@xilinx.com,
 mdroth <mdroth@linux.vnet.ibm.com>
Message-ID: <e7421557-d536-73a3-26f6-2f657ff62e52@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] error: Revert unwanted change of warning
 messages
References: <150045605172.87.12406075149250299600@5d477a5b5989>
In-Reply-To: <150045605172.87.12406075149250299600@5d477a5b5989>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 04:20 AM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20
> Subject: [Qemu-devel] [PATCH] error: Revert unwanted change of warning =
messages
> Message-id: 1500449614-16811-1-git-send-email-armbru@redhat.com
> Type: series
>=20

>   GTESTER tests/test-opts-visitor
>   GTESTER tests/test-qht-par
> **
> ERROR:/tmp/qemu-test/src/tests/test-qga.c:78:fixture_setup: assertion f=
ailed (fixture->fd !=3D -1): (-1 !=3D -1)
> GTester: last random seed: R02See932bb8bef7fc7d43b8e395048caafc
> make: *** [check-tests/test-qga] Error 1

Appears to be an unrelated failure, but one that has now appeared in
response to multiple threads, so probably a recent qga regression that
needs fixing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SdtqW5Rqpitm5SNWdoga44aL52XXifLNk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvY7AACgkQp6FrSiUn
Q2pEngf+Nwp+ThHjpMZRXH/HBT4iLjwb5mPkn9yzLpVnRn3Hi+HyiVZT4AdsDzpR
hvReKwybsx3yivr3uGw6OTiz8An5YCZQ9Xnuy+N1XTE+tJB4fqnScOah+3ZkZ5dR
myiErQp3ZDXMtjRtw2e7MJccSl6pl5yXvti0z+S2qXSvQfb8apXHQ2opiW6Ib2eb
Kg6lLrpiu9qCZfE0mDmEy7FmRtOgfSVr15ug4RuLT9aHdFLkXY1tyIySr3LLrsTU
p3dhy7gS9r6T42XVVQWsl5lUIgVQwbr81QcS4ccbVv6wgklGroch8bJA/TbZCf6K
VdYnWD0wZz2RtkNnrmzUJYLDltNyWw==
=UaJW
-----END PGP SIGNATURE-----

--SdtqW5Rqpitm5SNWdoga44aL52XXifLNk--
