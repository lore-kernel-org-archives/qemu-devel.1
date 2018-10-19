Received: from eggs.gnu.org ([2001:4830:134:3::10]:36700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRIQ-0006qh-Kc
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRIO-0005IQ-NM
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:42:17 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-6-mreitz@redhat.com>
	<84df80ea-f9c8-f953-9e4d-f4af8351edf2@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0a3afbfc-ee1f-402a-1f92-2355482876cb@redhat.com>
Date: Fri, 19 Oct 2018 11:42:07 +0200
MIME-Version: 1.0
In-Reply-To: <84df80ea-f9c8-f953-9e4d-f4af8351edf2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XMejFtkxTxcixeqXKttBWU3AOILsyY6z8"
Subject: Re: [Qemu-devel] [PATCH 5/9] iotests: Different iterator behavior
 in Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XMejFtkxTxcixeqXKttBWU3AOILsyY6z8
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <0a3afbfc-ee1f-402a-1f92-2355482876cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/9] iotests: Different iterator behavior in
 Python 3
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-6-mreitz@redhat.com>
 <84df80ea-f9c8-f953-9e4d-f4af8351edf2@redhat.com>
In-Reply-To: <84df80ea-f9c8-f953-9e4d-f4af8351edf2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 00:39, Cleber Rosa wrote:
>=20
>=20
> On 10/15/18 10:14 AM, Max Reitz wrote:
>> In Python 3, several functions now return iterators instead of lists.
>> This includes range(), items(), map(), and filter().  This means that =
if
>> we really want a list, we have to wrap those instances with list().  O=
n
>> the other hand, sometimes we do just want an iterator, in which case w=
e
>> have sometimes used xrange() and iteritems() which no longer exist in
>> Python 3.  Just change these calls to be range() and items(), which
>> costs a bit of performance in Python 2, but will do the right thing in=

>> Python 3 (which is what is important).
>>
>> In one instance, we only wanted the first instance of the result of a
>> filter() call.  Instead of using next(filter()) which would work only =
in
>> Python 3, or list(filter())[0] which would work everywhere but is a bi=
t
>> weird, this instance is changed to a single-line for with next() wrapp=
ed
>> around, which works both in 2.7 and 3.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/044 | 12 ++++++------
>>  tests/qemu-iotests/056 |  2 +-
>>  tests/qemu-iotests/065 |  4 ++--
>>  tests/qemu-iotests/124 |  4 ++--
>>  tests/qemu-iotests/139 |  2 +-
>>  tests/qemu-iotests/163 |  6 +++---
>>  6 files changed, 15 insertions(+), 15 deletions(-)
>>
>=20
> You have 2 files here which use xrange (which is a manageable size, and=

> whose occurrences involve a moderate size of items) to also consider:
>=20
> if sys.version_info.major =3D=3D 2:
>    range =3D xrange

I don't think it's necessary, but it's so easy to grep for
"sys.version_info" once we want to completely switch to Python 3 that I
can't find good arguments against it. O:-)

Max

> Defaulting to the Python 3 names, but behaving the same across Python 2=

> and 3.
>=20
> To do the same for dict.iteritems() =3D> dict.items() requires a lot mo=
re
> code, so I'd stay away from it for now.  Also, it looks like most of
> those dicts are small in size (**kwargs and the like).
>=20
> Other than that suggestion,
>=20
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>=20



--XMejFtkxTxcixeqXKttBWU3AOILsyY6z8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJpu8ACgkQ9AfbAGHV
z0DSBgf/aulCJY8Nh2psHnFudYAuzxeuUR1ic0UTr0cGdh0IW1IaRAmx8W0gBvwj
Zlf5oPUnCFksHOja4Cym0sV/2E+hAjs45BIjjB1mlvJIRP37xGzhjYEbYQTe8CVx
tdzTuB9iktYI9Tg/hT/htiqdjtqoniz6PpCdxei9DGQP7cSpFgudhmuyF9W+6QVm
tCSa8WbLlEMOgQ50DSEmrBfoz+6k7Dd6BXx8LBtxH3kPmnU5MfQzvrrj0lse49q2
PDKoSqp5H7N95pPOyF7A3MH7TnROcWcBm+mJkHxDsitLDAOGkLiWwnEWyUJ33xYY
NVgl1sUmaFyfv9jz9oHlOhP2+2izpw==
=9phL
-----END PGP SIGNATURE-----

--XMejFtkxTxcixeqXKttBWU3AOILsyY6z8--
