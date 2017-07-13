Received: from eggs.gnu.org ([2001:4830:134:3::10]:39060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVeXY-0000xc-DU
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVeXX-0001ji-Ag
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:52:24 -0400
References: <20170418013356.3578-1-eblake@redhat.com>
	<20170418013356.3578-30-eblake@redhat.com>
	<20170713125546.GB20828@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cca4bfad-d712-870e-81ca-fc884395e3c9@redhat.com>
Date: Thu, 13 Jul 2017 08:52:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170713125546.GB20828@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5hhMLHeEMWThnTWSGPGl0pk7IbOWCFXP2"
Subject: Re: [Qemu-devel] [PATCH 29/31] vpc: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5hhMLHeEMWThnTWSGPGl0pk7IbOWCFXP2
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@nongnu.org,
 jsnow@redhat.com, Max Reitz <mreitz@redhat.com>
Message-ID: <cca4bfad-d712-870e-81ca-fc884395e3c9@redhat.com>
Subject: Re: [PATCH 29/31] vpc: Switch to .bdrv_co_block_status()
References: <20170418013356.3578-1-eblake@redhat.com>
 <20170418013356.3578-30-eblake@redhat.com>
 <20170713125546.GB20828@noname.redhat.com>
In-Reply-To: <20170713125546.GB20828@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 07:55 AM, Kevin Wolf wrote:
> Am 18.04.2017 um 03:33 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Update the vpc driver accordingly.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> I know this is an old series, but I think you split it for later
> versions and there hasn't been a respin of this final part of the serie=
s
> yet.

Yep, the respin should be coming up later today.

>=20
> When I just told Peter that get_sector_offset() would go away with your=

> patches, I decided to check whether this was actually true, and found..=
=2E
>=20
>>          /* *pnum can't be greater than one block for allocated
>>           * sectors since there is always a bitmap in between. */
>>          if (allocated) {
>>              *file =3D bs->file->bs;
>>              return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;=

>>          }
>> -        if (nb_sectors =3D=3D 0) {
>> +        if (bytes =3D=3D 0) {
>>              break;
>>          }
>> -        offset =3D get_sector_offset(bs, sector_num, 0);
>> +        image_offset =3D get_sector_offset(bs, offset, 0);
>>      } while (offset =3D=3D -1);
>=20
> ...this bug. I think you want to use get_image_offset() now.
>=20
> This should also be the last caller of get_sector_offset(), so the
> function should go away in this commit.

Will do, and thanks for catching it!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5hhMLHeEMWThnTWSGPGl0pk7IbOWCFXP2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ3sLAAoJEKeha0olJ0Nqi+IIAIpbgD33wOSgmambh3I1o2rs
8nihFtkCnd2muEe7T4ouqGG5Cj9YWs6iK2EJTviLP4ipVFIT/TwIQP0obYgYd4jK
zqSXM/mcTmAG/nPfJeaUBS0Izrgr4Myo+PtwREn+Wazo9BbtxYgN3XwMw9xUNQFt
wePSqG6efF7EOMoWSHDYcpidGcGiZf9CuMzcl56THFll0U3nW6eQylvCO29YgkdS
PwBJkInKgDPpC3RBpK6QcjPpGKEnpQ6h3CKgQER03Tbrgmzy+Qc1H9gN4Vq27L0D
Cezw7LuSL9z4wBn+XxFjMZKuAWKDV5QhoIt2azpmfrBM/19fZeC+7+IlwXTSHgM=
=i9vj
-----END PGP SIGNATURE-----

--5hhMLHeEMWThnTWSGPGl0pk7IbOWCFXP2--
