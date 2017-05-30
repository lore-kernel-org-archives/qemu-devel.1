Received: from eggs.gnu.org ([2001:4830:134:3::10]:49605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFjJX-0001fU-Vw
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFjJW-00017n-UK
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:44:08 -0400
References: <20170530104857.70083-1-vsementsov@virtuozzo.com>
	<20170530104857.70083-2-vsementsov@virtuozzo.com>
	<21763282-556d-4389-29b5-664f6f4f4479@redhat.com>
	<bd1de229-7eda-be84-c297-920d0de7b85f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8aa69d4f-9f2f-fa70-617d-f92586308408@redhat.com>
Date: Tue, 30 May 2017 10:43:58 -0500
MIME-Version: 1.0
In-Reply-To: <bd1de229-7eda-be84-c297-920d0de7b85f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X2o0G3jdQTI5d0IoROsLro5faStjiBGKJ"
Subject: Re: [Qemu-devel] [PATCH 1/4] block: add bdrv_get_format_alloc_stat
 format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X2o0G3jdQTI5d0IoROsLro5faStjiBGKJ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <8aa69d4f-9f2f-fa70-617d-f92586308408@redhat.com>
Subject: Re: [PATCH 1/4] block: add bdrv_get_format_alloc_stat format
 interface
References: <20170530104857.70083-1-vsementsov@virtuozzo.com>
 <20170530104857.70083-2-vsementsov@virtuozzo.com>
 <21763282-556d-4389-29b5-664f6f4f4479@redhat.com>
 <bd1de229-7eda-be84-c297-920d0de7b85f@virtuozzo.com>
In-Reply-To: <bd1de229-7eda-be84-c297-920d0de7b85f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 10:27 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.05.2017 17:53, Eric Blake wrote:
>> On 05/30/2017 05:48 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> The function should collect statistics, about allocted/unallocated by=

>>> top-level format driver space (in its .file) and allocation status
>>> (allocated/hole/after eof) of corresponding areas in this .file.
>>>

>>> +# @alloc_hole: allocated by format driver but actually is a hole in
>>> +#              underlying file
>> The portions of the format file in use by the format, but where the
>> entire cluster is a hole in the underlying file (note that with cluste=
r
>> size large enough, you can get a cluster that is part-data/part-hole i=
n
>> the underlying file, it looks like you are counting those as data).
>=20
> No, I account on sector boundary on bs->file. So it is not cluster-alig=
ned.

Okay, worth knowing (and therefore worth including in the documentation).=


>=20
>>
>>> +#
>>> +# @alloc_overhead: allocated by format driver after end of
>>> underlying file
>> The portions of the format file in use by the format, but where the
>> entire cluster is beyond the end of the underlying file (the effective=

>> hole).  Do we really need to distinguish between hole within the
>> underlying file and hole beyond the end of the file? Or can this numbe=
r
>> be combined with the previous?
>=20
> alloc_alloc + alloc_hole + hole_alloc + hole_hole =3D size of bs->file,=
 I
> think this is good and clear.

That relationship is worth including in the documentation.

>=20
> these 4 stats describes bs->file usage in details (not on cluster
> boundary, but on sector, based on bs->file block status), alloc_overhea=
d
> is separate.

I'd lean more towards alloc-overrun than alloc-overhead (we have
metadata overhead no matter what, but overrun does a nice job of
explaining offsets that are important to the format but which are not
present in the underlying protocol).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--X2o0G3jdQTI5d0IoROsLro5faStjiBGKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLZM+AAoJEKeha0olJ0NqUXcH/2SHPF2vg2xL2lxvlCf4M1cg
hQ5Km9EnZDwfy/9yDhyGj+1pxIPEngAIYo5zd8lcpuW6xw3jP0onhB9Z7zvo5fs5
nRd0dK7wToHhih+pVOc5xLNY+0MsyKzQNrI2z0QguceLM4Vt30RjGfd/CTdLhlsd
4JIYPhCobVEMNa9p+X7jz/JYiX4ZKK8CNl3CtWJpyMH+anUkTAcAqF/ZXkm13gT6
2vrZnNMQdZJZkc6l3cTtkRXRdnawR61infEw67JW7p7ZSiFHhjb/VU95hKSj39pz
HaAJShEih5Mh/FHBr3CVlQNkhpl9fj44dLanQiCePgvn74QM0HNm5vtJQxmCOyI=
=gMha
-----END PGP SIGNATURE-----

--X2o0G3jdQTI5d0IoROsLro5faStjiBGKJ--
