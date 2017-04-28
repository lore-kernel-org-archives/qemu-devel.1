Received: from eggs.gnu.org ([2001:4830:134:3::10]:37847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d46VG-0001uv-N5
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d46VC-0004wb-JX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:04:10 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170426134649.9042-1-mreitz@redhat.com>
	<20170426134649.9042-4-mreitz@redhat.com>
	<a78836bc-8a79-6164-1101-6aa756c07a40@redhat.com>
	<20170428093825.GB4714@noname.redhat.com>
Message-ID: <825fdc0a-63c4-0592-6176-42cb3063b56e@redhat.com>
Date: Fri, 28 Apr 2017 16:03:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170428093825.GB4714@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SuI63AVwadQGKDEqwWh3BVuONeeA18Jvc"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-img: Document backing options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SuI63AVwadQGKDEqwWh3BVuONeeA18Jvc
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <825fdc0a-63c4-0592-6176-42cb3063b56e@redhat.com>
Subject: Re: [PATCH v2 3/3] qemu-img: Document backing options
References: <20170426134649.9042-1-mreitz@redhat.com>
 <20170426134649.9042-4-mreitz@redhat.com>
 <a78836bc-8a79-6164-1101-6aa756c07a40@redhat.com>
 <20170428093825.GB4714@noname.redhat.com>
In-Reply-To: <20170428093825.GB4714@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 28.04.2017 11:38, Kevin Wolf wrote:
> Am 27.04.2017 um 17:36 hat Eric Blake geschrieben:
>> On 04/26/2017 08:46 AM, Max Reitz wrote:
>>> I think originally the idea was to remove the individual special case=

>>> options in the long term in favour of the uniform -o. But I don't thi=
nk
>>> the short options have fallen out of use, so we can as well document
>>> them again...

Hm, I'm not really sure what the use of deprecating them would be. We
would be able to use the single-letter options -b/-B/-F for something
else, but would we really want to do that...?

(And it should always be trivial to map these legacy parameters to
normal options.)

>>> Maybe we could change the implementation, however, so that the old
>>> options are really just aliases for the respective -o version.
>>
>> As in, a followup patch that adds a paragraph or two to the .texi file=

>> stating that '-B @var{backing_file}' is shorthand for '-o
>> backing_file=3D@var{backing_file}'?
>=20
> First and foremost, I meant in the C code where we have separate
> variables for all the shorthand options and then need to handle both
> ways explicitly in the code further down. Instead, -B could just
> directly add a 'backing_file' key to a QemuOpts (and -o would do the
> same instead of building a string that is parsed only later).

We already do that more or less for convert, actually (for -B, that is,
not for -o). We just have to keep out_baseimg separately because we
won't have a QemuOpts with -n.

Using add_old_style_options() in img_create() should be easy enough.

> But the documentation change that you're suggesting is probably a good
> idea as well.

Well, I more or less deliberately did not really document -b/-B/-F. I
just documented them in the syntax overview and named the parameters
backing_file and backing_fmt, both of which are valid options and are
*as such* documented in the explanatory text. So from my point of view,
it's already documented to be a shorthand.

Max


--SuI63AVwadQGKDEqwWh3BVuONeeA18Jvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDS8wSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATlkH/24B05rVgNf1XKaIrcuZSkM7qDgSVg5w
j5Ap/yWPnrOcXg25xrBs9KI/nz2qqkBTU1+/P2uq51IwzjSvq/cvHE51TWBwzCgM
n/cGtt6fBGEogc3q0PcL0huLZ4YR/DMSWZYieCXSSWrn45ob/C/bE+L0VsQnEu5y
fvchW6KskjVoVQov9GKfyalX6XFiatOjDvcfZ34NNTJ9x11ZoFAJWKLd4l7Ersfu
Am5WMxk3ThFT8vPgc0577kc8SUDDK56YmeE2ZrcGAfgggaSZK1P1nsRdewk0e9fC
Csv2H5thoSjyS3VR1qp1ueGT4ApO3vUZS6ib0B2JCN6p0Esq9v4uoRg=
=Kt+E
-----END PGP SIGNATURE-----

--SuI63AVwadQGKDEqwWh3BVuONeeA18Jvc--
