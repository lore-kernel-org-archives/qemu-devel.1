Received: from eggs.gnu.org ([2001:4830:134:3::10]:57904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEgEF-000611-Jw
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEgEE-00071B-Qq
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:46:35 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
	<CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
	<94700229-5afe-159f-9453-f507b9c83085@redhat.com>
	<0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
	<9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
	<1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <20253223-df8f-162d-b8c8-dfa56af9fffd@redhat.com>
Date: Tue, 14 Nov 2017 19:46:25 +0100
MIME-Version: 1.0
In-Reply-To: <1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BoWwwvTWmUlcf14e8tNSuo3wj5nIjfd1F"
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
To: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BoWwwvTWmUlcf14e8tNSuo3wj5nIjfd1F
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Message-ID: <20253223-df8f-162d-b8c8-dfa56af9fffd@redhat.com>
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow v1
 to v2 creates a qcow v3 file?
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
 <CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
 <94700229-5afe-159f-9453-f507b9c83085@redhat.com>
 <0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
 <9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
 <1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
In-Reply-To: <1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 19:45, Thomas Huth wrote:
> On 14.11.2017 14:32, Max Reitz wrote:
> [...]
>> Well, do you want to document it?  I'd rather deprecate it altogether.=

>=20
> Maybe a first step could be to change qemu-img so that it refuses to
> create new qcow1 images (but still can convert them into other formats)=
=2E
> So basically make qcow1 read-only?

Yep, and the actual first step to that is to make it issue a deprecation
warning when creating qcow v1 images (which is what I proposed). :-)

Max


--BoWwwvTWmUlcf14e8tNSuo3wj5nIjfd1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLOgESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AM/8H/0mRHWfPbg7yU/06BgCavywgTITHzVxX
gP/7nCEoej/JBeXBrmfROWBvBcdoMkX8nd29KxUZKxB3Z4u8RxBIhgXWOQ6TTxa5
Bd9RKuq4ZAP73nE6N1sbCjoYeOMwoBWJSOlugCma7seUZqAS5gcz0BU1xOi/Worn
gYe0zDo+dyAK04o2mNjaoUeeA5BOZks7Zsq0jB7FDDTN9z0Y9gL5bs/eZidvfscu
7SRB08ZWj5rRoUFxlQGDka104nspVQsSvc0wAIHjZ120QwKt/r/07X75BjNB0gem
/B+9s87fEISDDxDijT+t/4xr7vKSJZ3Zj3U+VcaKgWzY58JMuXIUaec=
=O4rd
-----END PGP SIGNATURE-----

--BoWwwvTWmUlcf14e8tNSuo3wj5nIjfd1F--
