Received: from eggs.gnu.org ([2001:4830:134:3::10]:35083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cli2r-0002DG-Uw
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 15:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cli2q-0004My-LA
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 15:18:49 -0500
References: <20170308200216.5931-1-eblake@redhat.com>
	<c25bd323-1324-511b-57c0-d417312b6252@redhat.com>
	<0eac6b1c-2dc0-b0aa-7392-3b7f344cae48@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <995ef14c-4a0d-0b9b-db21-743c4cc3d584@redhat.com>
Date: Wed, 8 Mar 2017 21:18:37 +0100
MIME-Version: 1.0
In-Reply-To: <0eac6b1c-2dc0-b0aa-7392-3b7f344cae48@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DCSmnkDJDq5RWHJuOMfVB48pUEvugf8cT"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Drop unmaintained
 'archipelago' driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: chris@include.gr, jcody@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DCSmnkDJDq5RWHJuOMfVB48pUEvugf8cT
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: chris@include.gr, jcody@redhat.com, qemu-block@nongnu.org,
 kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <995ef14c-4a0d-0b9b-db21-743c4cc3d584@redhat.com>
Subject: Re: [PATCH for-2.9] block: Drop unmaintained 'archipelago' driver
References: <20170308200216.5931-1-eblake@redhat.com>
 <c25bd323-1324-511b-57c0-d417312b6252@redhat.com>
 <0eac6b1c-2dc0-b0aa-7392-3b7f344cae48@redhat.com>
In-Reply-To: <0eac6b1c-2dc0-b0aa-7392-3b7f344cae48@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.03.2017 21:09, Eric Blake wrote:
> On 03/08/2017 02:05 PM, Max Reitz wrote:
>> On 08.03.2017 21:02, Eric Blake wrote:
>>> The driver has failed to build since commit da34e65, in qemu 2.6,
>>> due to a missing include of qapi/error.h for error_setg().
>>> Since no one has complained in three releases, it is easier to
>>> remove the dead code than to keep it around, especially since it
>>> is not being built by default and therefore prone to bitrot.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>
>>> My proposed alternative for Max's "block/archipelago: Make it compile=
"
>>>
>>>  qapi/block-core.json             |   33 +-
>>>  block/archipelago.c              | 1079 ----------------------------=
----------
>>>  MAINTAINERS                      |    8 -
>>>  block/Makefile.objs              |    2 -
>>>  configure                        |   43 --
>>>  tests/qemu-iotests/025           |    2 +-
>>>  tests/qemu-iotests/common        |    6 -
>>>  tests/qemu-iotests/common.filter |    4 +-
>>>  tests/qemu-iotests/common.rc     |    8 -
>>>  9 files changed, 4 insertions(+), 1181 deletions(-)
>>>  delete mode 100644 block/archipelago.c
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> But I'd like someone to confirm that I'm not the only one who can't
>> compile archipelago. ;-)
>=20
> With my proposed patch not installed, I tried:
>=20
> ./config.status --enable-archipelago
>=20
> but got the error:
>=20
> ERROR: User requested feature Archipelago backend support
>        configure was not able to find it.
>        Install libxseg devel
>=20
>=20
> I don't see libxseg-devel available for Fedora; where does one get it t=
o
> even attempt compilation?

I got it from https://github.com/grnet/libxseg, and got it to compile by
removing all "python" instances from CMakeLists.txt (including the
find_program() blocks).

Max


--DCSmnkDJDq5RWHJuOMfVB48pUEvugf8cT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljAZx0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbBMIAJ2NOtBygPylS46gX22IfmEeFZqjkOvT
p88AEqC6DhtmPitRXhtu+93u1kShBU1ZTzrv57Yp0XeTgI85bpJ8m8oXK2CWae6b
hXIa9+l6a8KRq/OtZpglYFn0+E1+nu/0c+o/7GtW8V86h7A3uteHl73dzACdOy6m
dCSGf9/D1wJZJTglUiqiNQTSkQwpGtngmljFrv1pnuQGmNA8XYdVZ9MRTbm0Data
tEnolrwy1bwRDL/u5rDHcwJ4kJ40duKfikH77y7LMW8xMXfthLvi9dcSC1BRwsr7
yj1ZT/YsK6dGdEYDTn5eMhp26m//zP7+PfFQ1Csg2NE8aTjuIhRc07o=
=UENK
-----END PGP SIGNATURE-----

--DCSmnkDJDq5RWHJuOMfVB48pUEvugf8cT--
