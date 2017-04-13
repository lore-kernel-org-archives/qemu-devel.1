Received: from eggs.gnu.org ([2001:4830:134:3::10]:44950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cySFg-0008KX-RA
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cySFf-0008PS-LE
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:04:44 -0400
References: <149204143506.10500.9312462203357418218@6c512846dbc7>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f52ad9a6-c3e7-4823-c21c-091809780341@redhat.com>
Date: Wed, 12 Apr 2017 19:04:33 -0500
MIME-Version: 1.0
In-Reply-To: <149204143506.10500.9312462203357418218@6c512846dbc7>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N9Ic3KCCNaEKdegA4a6u8iUSMindfqXEB"
Subject: Re: [Qemu-devel] [PATCH] raspi: Add Raspberry Pi 1 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, omar.rizwan@gmail.com
Cc: peter.maydell@linaro.org, famz@redhat.com, Andrew.Baumann@microsoft.com, qemu-arm@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N9Ic3KCCNaEKdegA4a6u8iUSMindfqXEB
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, omar.rizwan@gmail.com
Cc: peter.maydell@linaro.org, famz@redhat.com, Andrew.Baumann@microsoft.com,
 qemu-arm@nongnu.org
Message-ID: <f52ad9a6-c3e7-4823-c21c-091809780341@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] raspi: Add Raspberry Pi 1 support
References: <149204143506.10500.9312462203357418218@6c512846dbc7>
In-Reply-To: <149204143506.10500.9312462203357418218@6c512846dbc7>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 06:57 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:

> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/1: raspi: Add Raspberry Pi 1 support...
> ERROR: line over 90 characters
> #189: FILE: hw/arm/raspi.c:34:
> + * https://github.com/AndrewFromMelbourne/raspberry_pi_revision/blob/2=
764c19983fb7b1ef8cb21031e94c293703afa2e/README.md

You can shorten this:

https://github.com/AndrewFromMelbourne/raspberry_pi_revision/blob/2764c19=
9/README.md

to fit under 90, while still resolving to the same place (collisions
with just an 8-char prefix are rare enough to generally not be an issue
to git)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--N9Ic3KCCNaEKdegA4a6u8iUSMindfqXEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7sCRAAoJEKeha0olJ0NqvqkH+QEUpVoC9Iicoo/W31K+D3gp
SGdJYCCyp/gpjn2gJYkxpJ5ckcPCYwjtCa461fn2CVyAMtWZ0Tysg3wH/ud4+lpu
ijcSkIn5CxePfj0QBDkfnplcGZ5rOKCUqRxMX89JS6psg6Mg5lbiP8UtQ6qhGhIR
zy6jYGGkhpL4h1LAjbmF1Vi4xZyN2Q797ocdtO7G210dv7bu+D7skw5/vQcNzn+L
AixwwwOlpi9DlMGi6zI8D8QlYxrcX32vv/etMbED60g9J/Ptb5LVIZOuH8rE8Kbw
bCTqidurFfGkqihRDBr3N9HLyYLlK1eT3WwfHdAaiua8obOFn0AYsYyAmtl3Gsw=
=n51A
-----END PGP SIGNATURE-----

--N9Ic3KCCNaEKdegA4a6u8iUSMindfqXEB--
