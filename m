Received: from eggs.gnu.org ([2001:4830:134:3::10]:49063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4C74-0004q4-5p
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4C73-0006aU-5v
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:03:34 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-9-eblake@redhat.com>
	<f73dfa75-5a2c-234b-0eea-3ebe7dc7f507@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97cc5890-9756-cc9d-9f86-356806336816@redhat.com>
Date: Fri, 28 Apr 2017 15:03:25 -0500
MIME-Version: 1.0
In-Reply-To: <f73dfa75-5a2c-234b-0eea-3ebe7dc7f507@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xqcJS3GXhRnBUeGuSkX2aiGhJgxoxEXCC"
Subject: Re: [Qemu-devel] [PATCH v10 08/17] qemu-io: Switch 'map' output to
 byte-based reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xqcJS3GXhRnBUeGuSkX2aiGhJgxoxEXCC
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <97cc5890-9756-cc9d-9f86-356806336816@redhat.com>
Subject: Re: [PATCH v10 08/17] qemu-io: Switch 'map' output to byte-based
 reporting
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-9-eblake@redhat.com>
 <f73dfa75-5a2c-234b-0eea-3ebe7dc7f507@redhat.com>
In-Reply-To: <f73dfa75-5a2c-234b-0eea-3ebe7dc7f507@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 02:53 PM, Max Reitz wrote:
> On 27.04.2017 03:46, Eric Blake wrote:
>> Mixing byte offset and sector allocation counts is a bit
>> confusing.  Also, reporting n/m sectors, where m decreases
>> according to the remaining size of the file, isn't really
>> adding any useful information.
>=20
> Since this map doesn't leave out any range in the image file -- not
> really, no. :-)
>=20
>>                                 Update the output to use
>> byte counts, and adjust the affected tests (./check -qcow2 102,
>> ./check -vpc 146).

My commit message is stale if test 179 gets committed first (although,
as we mentioned earlier, I'm trying to split this series in two, which
would delay the introduction of 179...)

I still wonder if an even more concise representation is worth it; the
resulting output lines are still quite long.  We don't make any
guarantees about qemu-io back-compat, so I may still tweak it further
(but if I do, I'll drop R-b)

I should probably also add a blurb to the commit message about how
'qemu-img map' and 'qemu-io map' are two different beasts.

>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v10: rebase to updated test 179
>> v9: new patch
>> ---
>>  qemu-io-cmds.c             |  5 ++---
>>  tests/qemu-iotests/102.out |  4 ++--
>>  tests/qemu-iotests/146.out | 30 +++++++++++++++---------------
>>  tests/qemu-iotests/179.out | 22 +++++++++++-----------
>>  4 files changed, 30 insertions(+), 31 deletions(-)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xqcJS3GXhRnBUeGuSkX2aiGhJgxoxEXCC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA6ANAAoJEKeha0olJ0NqRG8H/1pr2Mf/F/4oMtVYwSxOzdTE
a+svZztO4DFhfujegNsApIyeqwyeiDpb6LthIfYar/2B8P5MmY7RzwM1iYSPO4y4
+MNUFmQaqMWYXlik5k93NAm8SOW1e9SMyWhTsJgLZMa9CTQppPWZuKCmfLPQxGyA
IJ2TOeaAXMWCoFEGsSLNYh1imDfCWvPu/R89J6rBjUKSzlDDx/iO7HagtVGD40V/
ai+2h2TA0beRDHAuK8GEHUwmn54W49PQMRN92IhPUJyKsajGjXU8GyRAGszBTUue
ma7XqNE4FU4x2u3wRAjQZChiTq6lahhrXX4AznohvzHM7oP3qTiL6kpugRAw7Zg=
=2JmJ
-----END PGP SIGNATURE-----

--xqcJS3GXhRnBUeGuSkX2aiGhJgxoxEXCC--
