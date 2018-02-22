Received: from eggs.gnu.org ([2001:4830:134:3::10]:37423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eosf0-0002XG-7B
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eosez-0006TI-Gb
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:19:50 -0500
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-19-mreitz@redhat.com>
	<w51po5icfbh.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f2885948-d6b3-90a3-9960-6f8fd53e0177@redhat.com>
Date: Thu, 22 Feb 2018 16:19:45 +0100
MIME-Version: 1.0
In-Reply-To: <w51po5icfbh.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Z7JVIFioGAIeOuGTxKxKIsn9XwRBQUCPa"
Subject: Re: [Qemu-devel] [PATCH v8 18/26] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z7JVIFioGAIeOuGTxKxKIsn9XwRBQUCPa
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f2885948-d6b3-90a3-9960-6f8fd53e0177@redhat.com>
Subject: Re: [PATCH v8 18/26] block: Add sgfnt_runtime_opts to BlockDriver
References: <20180205151835.20812-1-mreitz@redhat.com>
 <20180205151835.20812-19-mreitz@redhat.com>
 <w51po5icfbh.fsf@maestria.local.igalia.com>
In-Reply-To: <w51po5icfbh.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-06 16:23, Alberto Garcia wrote:
> On Mon 05 Feb 2018 04:18:27 PM CET, Max Reitz wrote:
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -886,6 +886,21 @@ static int blkdebug_reopen_prepare(BDRVReopenStat=
e *reopen_state,
>>      return 0;
>>  }
>> =20
>> +static const char *const blkdebug_sgfnt_runtime_opts[] =3D {
>> +    "config",
>> +    "inject-error.",
>> +    "set-state.",
>> +    "suspend.",
>=20
> Where did this "suspend." come from?

Er, well, er.

After having looked at it a couple of times now, I can't see anything.
I guess I'll remove it and hope for the best...?

Max


--Z7JVIFioGAIeOuGTxKxKIsn9XwRBQUCPa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqO35ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKQQIAIU4PZoxcr7rggcMCaBpnyJD8gwGhyF7
xHezcmxkLNK5t8+ayl1fVlKyUzEMUtWqatVDUCaYcQ28zYnDI8sqHv1UIbyNS0V0
iICAa7VZ/ObbqkR2Vs2RWW96kBcujYI5QeVaOAQXzoKQmdhYpp6yAP9OOo0vxXtt
xRuCGgo6jTFdmT/CyDJaPxPmqPXKzzjRs3P2YoE1j+2SlwdP+HbPzfEYlh861nVm
FbFTvm6jT/b+nUTKmDhlMhXt+Xb5ci6QLedhOh9iwxgqdp1R8Nhk1jh8U5TXlpaV
NXYo1IZzJn6GmZJPBZgwIL5xkQneP5l5LIT+4gUVmKOcgwrb6cmIIkI=
=rdC9
-----END PGP SIGNATURE-----

--Z7JVIFioGAIeOuGTxKxKIsn9XwRBQUCPa--
