Received: from eggs.gnu.org ([2001:4830:134:3::10]:57932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGUSe-0000DA-1F
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGUSd-0007e1-2G
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:04:40 -0400
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-13-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0a2d5b5-0279-8c05-69da-4ed3d928618f@redhat.com>
Date: Thu, 1 Jun 2017 13:04:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170601172734.9039-13-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q3skkOMDmQWTVQg30g8gBqC0vtD4697SD"
Subject: Re: [Qemu-devel] [PATCH v8 12/20] qcow2: extend specification to
 cover LUKS encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q3skkOMDmQWTVQg30g8gBqC0vtD4697SD
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <d0a2d5b5-0279-8c05-69da-4ed3d928618f@redhat.com>
Subject: Re: [PATCH v8 12/20] qcow2: extend specification to cover LUKS
 encryption
References: <20170601172734.9039-1-berrange@redhat.com>
 <20170601172734.9039-13-berrange@redhat.com>
In-Reply-To: <20170601172734.9039-13-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 12:27 PM, Daniel P. Berrange wrote:
> Update the qcow2 specification to describe how the LUKS header is
> placed inside a qcow2 file, when using LUKS encryption for the
> qcow2 payload instead of the legacy AES-CBC encryption
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  docs/specs/qcow2.txt | 103 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 103 insertions(+)
>=20

> +=3D=3D Data encryption =3D=3D
> +
> +When an encryption method is requested in the header, the image payloa=
d
> +data must be encrypted/decrypted on every write/read. The image header=
s
> +and metadata are never encrypted.
> +
> +The algorithms used for encryption vary depending on the method
> +
> + - AES:
> +
> +   The AES cipher, in CBC mode, with 256 bit keys.
> +
> +   Initialization vectors generated using plain64 method, with
> +   the virtual disk sector as the input tweak.
> +
> +   This format is no longer supported in QEMU system emulators, due
> +   to a number of design flaws affecting it security. It is only

s/affecting it/affecting its/

Can keep my R-b.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q3skkOMDmQWTVQg30g8gBqC0vtD4697SD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMFcuAAoJEKeha0olJ0Nq/1IIAJV2zvfA7/23BgPg0QTeL6aU
aUEsiESPo/Ct3iwVAcd/HwbM75kzHyKut1P8Krz0WSfn/XJ3S8I08O0O4szjwfw9
amcEeJiL1jOupCq8UOriBt6jmRg5WR8Vmv7+k67eYL4pJUl+3Ux6Hk3B86Su1M8n
tzmgFM+XFmikfgqEf+gnzBMarz4e6oooq5oJRc8bKwiySUDHKvaE2D5IqxrGuK4w
GlDjYhqeaUxeBSuJcO+bUHCGQlloyjNkdITwLuwz+kI0uInG67OVu42t8FDGFaSi
q4IMwnw+b8plbO/LAyn6sb1i9YuPInOT4dVgH4jxwfMJXlt+GGmk9Q9pGmBnems=
=THFr
-----END PGP SIGNATURE-----

--Q3skkOMDmQWTVQg30g8gBqC0vtD4697SD--
