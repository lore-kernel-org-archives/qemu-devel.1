Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVbq7-0004eN-Sp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVbq6-0008EU-W4
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:59:23 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-15-eblake@redhat.com>
	<6a1fb943-160b-2e47-b985-dc9af86c9634@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d88aeeb-9deb-d0e4-6807-1199ebdd9622@redhat.com>
Date: Thu, 13 Jul 2017 05:59:09 -0500
MIME-Version: 1.0
In-Reply-To: <6a1fb943-160b-2e47-b985-dc9af86c9634@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lxTllHl8sRo40OftFNiBb60of0G5ts3Q1"
Subject: Re: [Qemu-devel] [PATCH v4 14/17] qcow2: Switch load_bitmap_data()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lxTllHl8sRo40OftFNiBb60of0G5ts3Q1
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <9d88aeeb-9deb-d0e4-6807-1199ebdd9622@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 14/17] qcow2: Switch load_bitmap_data() to
 byte-based iteration
References: <20170703151051.31327-1-eblake@redhat.com>
 <20170703151051.31327-15-eblake@redhat.com>
 <6a1fb943-160b-2e47-b985-dc9af86c9634@virtuozzo.com>
In-Reply-To: <6a1fb943-160b-2e47-b985-dc9af86c9634@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 04:16 AM, Vladimir Sementsov-Ogievskiy wrote:
> 03.07.2017 18:10, Eric Blake wrote:
>> Now that we have adjusted the majority of the calls this function
>> makes to be byte-based, it is easier to read the code if it makes
>> passes over the image using bytes rather than sectors.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v4: new patch
>> ---

>>
>> -        if (offset =3D=3D 0) {
>> +        if (data_offset =3D=3D 0) {
>>               if (entry & BME_TABLE_ENTRY_FLAG_ALL_ONES) {
>> -                bdrv_dirty_bitmap_deserialize_ones(bitmap,
>> -                                                   sector *
>> BDRV_SECTOR_SIZE,
>> -                                                   count *
>> BDRV_SECTOR_SIZE,
>> +                bdrv_dirty_bitmap_deserialize_ones(bitmap, offset,
>> count,
>=20
> The change is that now 3rd parameter may not be aligned by sectors, but=

> looks like it should be ok.

Correct - the dirty bitmap automatically widens any non-aligned input
into granularity.

>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
>=20

I posted a v5 prior to this email, if you want to add your Reviewed-by
on any patches there (I think this patch went unchanged into that
revision, but scripts don't always pick up R-b given on a previous
version of a patch).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lxTllHl8sRo40OftFNiBb60of0G5ts3Q1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ1J+AAoJEKeha0olJ0NqRZoH/jHmuoLD6ivDC90BX8sK3t7B
9aBIOUu0NPeMyysQzw0DD81Q5zA1uIm2kQCJWKW/MPGOikyhlWD0HPYgtUYqrN/v
xKUc6FzPm9PePCehAHuyRsa4yRByS4cNfXu6ZZlx9m0E6vZe/BvSGaVjPEWatl0a
fIgJLwiVfbDsxr4Jx9BbWI9lfrZwIDe/eoWa9VHRkSTyL9A7thQ6ZpTMlEc149mS
9AvScDpt2HRabsDYdtwWumwncWbrJWErFv3y01IX9YExrumDbQV+PJm7u1okOxLg
2akqKT53eSgZnYHjRpYGtDsWcRHoyhMFXQ0esYM4ITFiRCdPsv6mLweyvoPAZRA=
=DvW+
-----END PGP SIGNATURE-----

--lxTllHl8sRo40OftFNiBb60of0G5ts3Q1--
