Received: from eggs.gnu.org ([2001:4830:134:3::10]:54026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6jlp-0001kg-3c
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6jln-0007uA-Vd
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:24:08 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-3-eblake@redhat.com>
	<53789feb-7a2d-09ae-cc03-8cde0b1b85e4@redhat.com>
	<c81a7c3e-5eae-5740-a600-53729fe8c6e7@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d4237cd0-a841-0f2d-2694-21311c501ae7@redhat.com>
Date: Fri, 5 May 2017 22:23:57 +0200
MIME-Version: 1.0
In-Reply-To: <c81a7c3e-5eae-5740-a600-53729fe8c6e7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XL9kpEvrF9XpPfC440islRXIPrSUaxO4I"
Subject: Re: [Qemu-devel] [PATCH v12 02/10] block: Update comments on
 BDRV_BLOCK_* meanings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XL9kpEvrF9XpPfC440islRXIPrSUaxO4I
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <d4237cd0-a841-0f2d-2694-21311c501ae7@redhat.com>
Subject: Re: [PATCH v12 02/10] block: Update comments on BDRV_BLOCK_* meanings
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-3-eblake@redhat.com>
 <53789feb-7a2d-09ae-cc03-8cde0b1b85e4@redhat.com>
 <c81a7c3e-5eae-5740-a600-53729fe8c6e7@redhat.com>
In-Reply-To: <c81a7c3e-5eae-5740-a600-53729fe8c6e7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.05.2017 22:13, Eric Blake wrote:
> On 05/05/2017 03:06 PM, Max Reitz wrote:
>> On 04.05.2017 05:07, Eric Blake wrote:
>>> We had some conflicting documentation: a nice 8-way table that
>>> described all possible combinations of DATA, ZERO, and
>>> OFFSET_VALID, contrasted with text that implied that OFFSET_VALID
>>> always meant raw data could be read directly.  Furthermore, the
>>> text refers a lot to bs->file, even though the interface was
>>> updated back in 67a0fd2a to let the driver pass back which BDS (not
>>> necessarily bs->file).
>>
>> Not sure about my English skills here, but is this missing a verb? ("t=
o
>> pass back which BDS...")
>=20
> maybe s/which/a specific/

Or that, yes. :-)

>=20
>>
>>>                         As the 8-way table is the intended
>>> semantics, simplify the rest of the text to get rid of the
>>> confusion.
>>>
>>> ALLOCATED is always set by the block layer for convenience (drivers
>>> do not have to worry about it). RAW is used only internally, but
>>
>> Just one space after the period? How inconsistent! :-)
>=20
> But do commit messages really count?  :)

It's a critical bug, I'm telling you!!!

>>> + * Internal flag:
>>> + * BDRV_BLOCK_RAW: used internally to indicate that the request was
>>> + *                 answered by a passthrough driver such as raw and =
that the
>>
>> s/passthrough/filter/? But I'm not even sure myself. Well, "passthroug=
h"
>> is a safe bet, so let's just go with it.
>=20
> Calling 'raw' a filter driver is a bit weird - but in one sense, it is =
a
> no-op filter (filter the protocol layer into the format layer by doing
> nothing).  Meanwhile 'commit' certainly sounds like more of a filter
> than a passthrough.  I could go either way, and filter is slightly
> shorter.  If there's a real reason to respin the series, 'filter' seems=

> reasonable if we're worried about line length, otherwise I'm just as
> inclined to leave it alone.

raw certainly is a filter driver; the thing I wasn't sure about is that
I'm not sure whether filter drivers are required to set this flag. But
neither the comment nor the code require it necessarily, so using
"filter" instead of "passthrough" should be OK.

The main reason for using "filter" over "passthrough" is that "filter"
is a "real" class of block drivers (just "real" in the sense that we
actually only have child-less protocol drivers and non-protocol drivers
that do have children; further dividing into "format" and "filter" is
just a convention).

But it should be clear anyway, so I don't mind either way. Leaving it as
it is certainly is simpler.

Max

>=20
>>
>> With the commit message fixed or a =E2=80=9Cno it's fine=E2=80=9D:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>=20



--XL9kpEvrF9XpPfC440islRXIPrSUaxO4I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM310SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoLwH/1EBjQrPmqnMhPx1Ca57hTCAYoh6OQGl
QXvh2CIQeN039XsBIYu1OMabHjF19br2tuNyXRXaNj4ImipEmnJ/kzD8FcjK3nR6
Us9pSuKK/lTGRP1d+jZLEcE44IIpVC/aRxNPp6PUQ0CX14h9ZlGTtn8bCyDdTXFL
/MHNowzs/MMWTeNQd5DZzvcqYMNpr8tA8Eu7aOyTsVuNSNZGT6+dSfnh7r1IFUjp
65gI3GtLKJOOLUCJ5LDC44Z+MucQfjhdPjJGyDhKrplQRyaoSDol8F+PS5uYhyL/
KG3A7zCXfUWLibrU5ypUP1kZq3DMcsNrUr0FlR/j8e/Jfh8iuBRE6B0=
=sj72
-----END PGP SIGNATURE-----

--XL9kpEvrF9XpPfC440islRXIPrSUaxO4I--
