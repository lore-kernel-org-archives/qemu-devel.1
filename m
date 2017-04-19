Received: from eggs.gnu.org ([2001:4830:134:3::10]:50317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0tok-0002bA-OG
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0toj-0001sD-SC
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:55:02 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-17-eblake@redhat.com>
	<7cfbc72e-06e2-6b68-004b-0a898e1d36b5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3059b242-fc42-6e57-6f4c-ff66997b8a36@redhat.com>
Date: Wed, 19 Apr 2017 12:54:48 -0500
MIME-Version: 1.0
In-Reply-To: <7cfbc72e-06e2-6b68-004b-0a898e1d36b5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ho2hFTmg28VrluDeSKdM0l6wGPtUWgogN"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/17] block: Make
 bdrv_is_allocated() byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ho2hFTmg28VrluDeSKdM0l6wGPtUWgogN
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <3059b242-fc42-6e57-6f4c-ff66997b8a36@redhat.com>
Subject: Re: [Qemu-block] [PATCH 16/17] block: Make bdrv_is_allocated()
 byte-based
References: <20170411222945.11741-1-eblake@redhat.com>
 <20170411222945.11741-17-eblake@redhat.com>
 <7cfbc72e-06e2-6b68-004b-0a898e1d36b5@redhat.com>
In-Reply-To: <7cfbc72e-06e2-6b68-004b-0a898e1d36b5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2017 05:15 PM, John Snow wrote:

>> @@ -279,9 +280,9 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMi=
gDevState *bmds)
>>          /* Skip unallocated sectors; intentionally treats failure as
>>           * an allocated sector */
>>          while (cur_sector < total_sectors &&
>> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
>> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sector=
s)) {
>> -            cur_sector +=3D nr_sectors;
>> +               !bdrv_is_allocated(blk_bs(bb), cur_sector * BDRV_SECTO=
R_SIZE,
>> +                                  MAX_IS_ALLOCATED_SEARCH, &count)) {=

>> +            cur_sector +=3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>=20
> Hm, what's the story here, why are we rounding this up? If, in theory,
> we have a partially allocated cluster won't we advance past that?

This is rounding to sectors, not clusters (that is, the code is supposed
to advance cur_sector identically pre- and post-patch).  As to whether
the overall algorithm makes sense, or could use some tweaking by
converting migration/block.c to do everything by bytes instead of by
sectors, I haven't yet given that any serious time.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ho2hFTmg28VrluDeSKdM0l6wGPtUWgogN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY96RoAAoJEKeha0olJ0NqQ4AH/jzTx1yPLFfbG7L2ehtzCuf5
V6QRpXKGudohXWeN6zL1hxsOZAQU8e9OrqxjOmBdM67U97OS8Gv7MwaZFeCEgapQ
2oDsc3TCpyMr5lFiJkkVpxfXtoVKPqSv9qaX1g4+bI4vM1N5m4TRY327csoHiH1K
WdRxPo0ZGNDcFyuWSQ/qGaffqFWsjHpRbLtWKUubs7PUsP/fZ97wMwi4/YozOjyw
sDdK649j9jY36/PDjiQxwPF20DC8sj5wzfZPGYQqDomvstXdvp1pvTX6kIomK6s1
i2/CVO0YxWV8NdYbRprdyI+6JJmpZ5fbw2WdT122Y/y/GbWj3PxYb+IJdpbpZjU=
=Z6q9
-----END PGP SIGNATURE-----

--Ho2hFTmg28VrluDeSKdM0l6wGPtUWgogN--
