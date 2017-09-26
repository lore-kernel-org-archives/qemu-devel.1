Received: from eggs.gnu.org ([2001:4830:134:3::10]:56855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwqST-00055w-2R
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwqSP-0004tA-1p
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:03:33 -0400
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<50c325943b1547813567efe6a11fb44644494d70.1506384414.git.alistair.francis@xilinx.com>
	<20170926005520.GA7906@flamenco>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e8efa9f-a6ad-742d-b20e-467af90da68a@redhat.com>
Date: Tue, 26 Sep 2017 09:03:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170926005520.GA7906@flamenco>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NXpfQ8SVG8eP9e2p5wR90eM9wxwjpqGQE"
Subject: Re: [Qemu-devel] [PATCH v1 2/8] tests: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, alistair23@gmail.com, Igor Mammedov <imammedo@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NXpfQ8SVG8eP9e2p5wR90eM9wxwjpqGQE
From: Eric Blake <eblake@redhat.com>
To: "Emilio G. Cota" <cota@braap.org>,
 Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, alistair23@gmail.com,
 Igor Mammedov <imammedo@redhat.com>
Message-ID: <7e8efa9f-a6ad-742d-b20e-467af90da68a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/8] tests: Replace fprintf(stderr, "*\n"
 with error_report()
References: <cover.1506384414.git.alistair.francis@xilinx.com>
 <50c325943b1547813567efe6a11fb44644494d70.1506384414.git.alistair.francis@xilinx.com>
 <20170926005520.GA7906@flamenco>
In-Reply-To: <20170926005520.GA7906@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 07:55 PM, Emilio G. Cota wrote:

>> diff --git a/tests/check-qlit b/tests/check-qlit
>> new file mode 100755
>> index 0000000000000000000000000000000000000000..950429524e3eb07e6daed1=
fe01caad0f5d554809
>> GIT binary patch
>> literal 272776
>> zcmeEvdwf*Ywf~vPB$){zGeCghJ;($So{10*LNEgfoIs*MKvBRDLV(l&F`3b5QKOS6
>=20
> ? I don't know what this is, I don't seem to have this binary in my
> checked out tree.

Ouch. We have a missing entry in .gitignore for a recent test addition,
which hits if you do an in-tree build and then an indiscriminate 'git
add tests/' (I've already mentioned it on-list).  It's a built
executable during 'make check', and doesn't belong in git.

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01067.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NXpfQ8SVG8eP9e2p5wR90eM9wxwjpqGQE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKXiIACgkQp6FrSiUn
Q2qkAgf/cXxauopul185MQP5pPb0VZlAHcTSlinZkZLcozKAhp8HIU3zdUFvjSim
P5Z16ADrObx6TqjoeGCu1bjq5elG2qkhZQZanSweKu5dXdt1DaUENzJOJLqhxbjo
CC3R8ZekQFZSKaB42/n/qyHz67+F1O2SYd0eR2CrFRBIa/eKEnaziDBfF1z/c879
Xb3T+rc1MlDZGgAyeqc/r9t2Pvp74GlcXiP1hoGSObADDL0IIalCTRkxcgSEbOSx
fRKwYvoNKg30W5ws6++ybUuQnJI3en0TTpQmOaRdV1+WmEsYUAvmbey9bRCRR8TY
vvOglQlLomvYa7YH5nRPoF56XGTI2g==
=sC5N
-----END PGP SIGNATURE-----

--NXpfQ8SVG8eP9e2p5wR90eM9wxwjpqGQE--
