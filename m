Received: from eggs.gnu.org ([2001:4830:134:3::10]:47033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkbm-0003hm-PX
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkbl-00082Q-5O
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:25:58 -0500
References: <1045307195-43255@kerio.kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <503b14af-ad2f-7635-e340-6078a4e4f67a@redhat.com>
Date: Tue, 14 Feb 2017 15:25:51 -0600
MIME-Version: 1.0
In-Reply-To: <1045307195-43255@kerio.kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aPlk8gMnXrA6a63SmRxOrn3Ongs4M1GD8"
Subject: Re: [Qemu-devel] [RFC PATCH V3] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>
Cc: ct@flyingcircus.io, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aPlk8gMnXrA6a63SmRxOrn3Ongs4M1GD8
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>
Cc: ct@flyingcircus.io, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <503b14af-ad2f-7635-e340-6078a4e4f67a@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH V3] qemu-img: make convert async
References: <1045307195-43255@kerio.kamp.de>
In-Reply-To: <1045307195-43255@kerio.kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[meta-comment]

On 02/14/2017 02:43 PM, Peter Lieven wrote:
>=20
>=20
>=20
>=20
>  Von:   Kevin Wolf <kwolf@redhat.com>=20
>  An:   Peter Lieven <pl@kamp.de>=20
>  Kopie:   <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, <mreitz@red=
hat.com>, <ct@flyingcircus.io>=20
>  Gesendet:   14.02.2017 17:20=20
>  Betreff:   Re: [RFC PATCH V3] qemu-img: make convert async=20
>=20
> Am 14.02.2017 um 14:39 hat Peter Lieven geschrieben:=20
>> this is something I have been thinking about for almost 2 years now.=20

Your quoting style did not introduce any extra prefix in front of
Kevin's comments...

>> we heavily have the following two use cases when using qemu-img conver=
t.=20
>> +    int nb_sectors;=20
>> +    QSIMPLEQ_ENTRY(ImgConvertRequest) next;=20
>> +} ImgConvertRequest;=20
> =20
> If I understand your code correctly, you first go through the image and=
=20
> create an ImgConvertRequest for every chunk with the same allocation=20
> status (well, actually not every chunk, but that may be a bug, see=20
> below).=20
> =20
> So let's assume a 1 TB image with every other cluster allocated:=20
> =20
>     1T / (64k * 2) =3D 8M=20
> =20
> A list with 8 million entries (requiring 8 million mallocs) feels=20
> relatively large. Not counting malloc overhead (which might be=20
> considerable here), I think we're at 192 MB memory usage for this case.=
=20
> Not as bad as I was afraid, but not really nice either. And 1 TB isn't =

> even close to the maximum image size.=20
> =20
> Is it really necessary to create this list at the beginning? Why can't =

> we just get the next chunk as the old code used to?=20
>=20
>=20
> In my initial version with AIO invoking convert_iterate_sectors caused

=2E..with the VERY annoying effect that it is now impossible to tell the
difference between what Kevin wrote and what you wrote.  Please consider
improving your mail flow to use a mailer that properly inserts '>'
prefixes in front of quoted lines, to make it easier to call attention
to the lines that you are adding to the conversation.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--aPlk8gMnXrA6a63SmRxOrn3Ongs4M1GD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo3XfAAoJEKeha0olJ0NqJugH/36FTz+jE5vEP9AAJjvq7LTK
bQuFBGz/p37o1MAq2sN69/5tVvov04KScJq0gB1XJ2ts6ufYe76h2U37Se0bv4xA
m058haYeeYQ4eCPhYX8RkqywF9oEjeFuXDq3G4ctDrO2nvMwGcNxREsmcYds253+
i68MFaShMwK9tLWPpliLnm1LOMqvSv0y5qnJmOL2KfEf+BjxV4fo7dOFeNQjD0E/
AwBaKTaszVxQ9SoYS4EnGaqtZIOIIgXJI8+JWjbOp6isZ83ttsPDJHBVyaj3D0HC
KhOH0o/CvSdL7ssSMdDAjw77G5Ci+nVmKNgkUNqrdm4kQhEu+dmVLG1g6WgYEZQ=
=v+RG
-----END PGP SIGNATURE-----

--aPlk8gMnXrA6a63SmRxOrn3Ongs4M1GD8--
