Received: from eggs.gnu.org ([2001:4830:134:3::10]:48159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHb8-000768-6m
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHb7-0006pU-Bp
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:16:26 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-6-mreitz@redhat.com>
	<0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
	<3eb16582-87e8-61f0-f880-dea9cec0e25f@redhat.com>
	<bd517fe7-8104-407d-17a9-e1fc0f9e8174@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b66cc5c8-7f06-19ac-31b0-7d68a9b69291@redhat.com>
Date: Fri, 10 Nov 2017 23:16:14 +0100
MIME-Version: 1.0
In-Reply-To: <bd517fe7-8104-407d-17a9-e1fc0f9e8174@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q2QcNVRXwr0jsGB2FCRfeMe6D4vRt7Pn4"
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get
 unaligned offsets from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q2QcNVRXwr0jsGB2FCRfeMe6D4vRt7Pn4
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <b66cc5c8-7f06-19ac-31b0-7d68a9b69291@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get unaligned
 offsets from cache
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-6-mreitz@redhat.com>
 <0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
 <3eb16582-87e8-61f0-f880-dea9cec0e25f@redhat.com>
 <bd517fe7-8104-407d-17a9-e1fc0f9e8174@redhat.com>
In-Reply-To: <bd517fe7-8104-407d-17a9-e1fc0f9e8174@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 23:15, Eric Blake wrote:
> On 11/10/2017 04:00 PM, Max Reitz wrote:
>>> Trying to understand this: we have a double corruption, because we
>>> encountered a refblock that points outside of the image, but fixing t=
he
>>> refblock in turn encounters a second refblock that points within the
>>> image but to an unaligned area.
>>
>> No, it's the very same.  As far as I've seen it, the repair function
>> tries to fix the "refblock is outside image" error by resizing the ima=
ge
>> so the refblock is inside the image.  However, the subsequent
>> bdrv_truncate() detects the alignment corruption, too, and thus marks
>> the image corrupt.
>=20
> Is resizing the image to be larger always a wise thing compared to just=

> rebuilding the refcount?  If I stick a large enough out-of-image value
> in the table, can I cause a denial-of-service by making qemu try to
> allocate petabytes of storage just to bring it into range?

But it's just a qcow2 resize (with no preallocation), so nothing will be
allocated.

Max


--q2QcNVRXwr0jsGB2FCRfeMe6D4vRt7Pn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGJS4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AU94IALoDN3N8v2TzToz/AgQxDMMVKTwJIvE4
Q7Sa0mBw01v/I0ykT1T86aAK03J9CUoMt3eydkLvvk+5DVVvy7nHh8hcKJgGppGM
e7IkNxMPgwsHVRvPbskmkEeKrMtLC1C+KOFq7vcH8yhvsrrum+EVkq1d5J/T1BDs
q77OGvvoOQ6yLN+ZBQb7KPFQThULnw3QWMqzKfRXa7ifQKHJwlM+CuI68Ba4Bfz3
EIcWdid7uxdSL9u8clV/5IRukTnNrqCuOEXnyg9Et/ILGUZg8eJgMKjLiChYbjHI
jXs5FtFD+b61HHnk2cNeCYXUdoe4UWnbfOeZD0DOKLxdbS3VZSXgTAA=
=zFEi
-----END PGP SIGNATURE-----

--q2QcNVRXwr0jsGB2FCRfeMe6D4vRt7Pn4--
