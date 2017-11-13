Received: from eggs.gnu.org ([2001:4830:134:3::10]:43697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJ9l-0003JO-AA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJ9k-0003Cw-7L
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:08:25 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
	<CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
	<94700229-5afe-159f-9453-f507b9c83085@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
Date: Mon, 13 Nov 2017 12:08:16 -0600
MIME-Version: 1.0
In-Reply-To: <94700229-5afe-159f-9453-f507b9c83085@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="btMBvQuKo1QUkX4tOlaAqFxOokkjEhc78"
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow
 v1 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--btMBvQuKo1QUkX4tOlaAqFxOokkjEhc78
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow v1
 to v2 creates a qcow v3 file?
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
 <CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
 <94700229-5afe-159f-9453-f507b9c83085@redhat.com>
In-Reply-To: <94700229-5afe-159f-9453-f507b9c83085@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2017 11:58 AM, Eric Blake wrote:

>>> qemu-system-aarch64: -drive if=3Dnone,file=3Dhda.qcow2,format=3Dqcow,=
id=3Dhd:
>>> Unsupported qcow version 3
>>
>> ah, this means it wants "format=3Dqcow2".
>=20
> Oh, I should have read this followup before writing my other reply.
>=20
>>
>> This is pretty confusing, especially the error message, the
>> output of "file", and the fact that "format=3Dqcow" can't just
>> DTRT if it gets a qcow version 3 (2?), since it can clearly
>> identify what it's got.
>=20
> Indeed, making the qcow driver smart enough to reopen with the qcow2
> driver (for both v2 and v3 images) might be an interesting ease-of-use =
hack.

And having the qcow2 driverautomatically be able to open a qcow v1 image
read-only might also be nice - although v1 is lacking so many features
that we'd be insane to let a read-write request of the qcow2 driver
downgrade to qcow.

Another observation: is there any official documentation for the qcow
(v1) format?  I know it's an outdated format that we no longer recommend
for new image creation, but it's sad when I have to resort to a google
search to find old posts like this:

https://people.gnome.org/~markmc/qcow-image-format-version-1.html

rather than being able to see the documentation of v1 alongside v2 in
the qemu.git repository.

At any rate, since qcow and qcow2 share the same 4-byte magic number and
version field, it explains why both drivers are able to identify (but
fail to open) the files of the other version number.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--btMBvQuKo1QUkX4tOlaAqFxOokkjEhc78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJ35AACgkQp6FrSiUn
Q2qsHAf6ApamRjiqu5ehJG8g2lvf81ORFK78w61KTIZTzJ1odppxI7DhZ2LWpanb
euIr71CrxzgdHD8O2w+AQGXA8ZdU23E8CxzlUAyoHDF1XAgRRY+VPZP97TZtBIEf
kncmCUhB2LESvGRpvH6LNysjeOq5TsoISQomAxA3tlfto33hCOc2pxyexLcBWWbG
diUVR17vAWgVPck4ia/lKfmHVZEhfkAtDKNQ2v6hGgSDCLrKXFaSBg9Hx2zcnt+f
OXVTe4P0uq0Ct2EWvweBb19iTffPeGgNtLYI1omEFj9QfVivqHM7bod3nE/fiHVn
lKvytt+yUXnsKtadzKeYxv7I0xp1Bg==
=mreZ
-----END PGP SIGNATURE-----

--btMBvQuKo1QUkX4tOlaAqFxOokkjEhc78--
