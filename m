Received: from eggs.gnu.org ([2001:4830:134:3::10]:42679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJGsY-0004ES-DT
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJGsV-0005BT-5p
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:10:54 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:12371)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJGsU-0005BP-ME
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:10:51 -0400
Date: Fri, 9 Jun 2017 13:10:40 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170609101040.lxrnoxo7grbpxsct@postretch>
References: <20170608232255.1621-1-el13635@mail.ntua.gr>
	<20170609094113.GD26144@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wqygvzpvvneceuga"
Content-Disposition: inline
In-Reply-To: <20170609094113.GD26144@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2] block: change variable names in
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--wqygvzpvvneceuga
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 10:41:13AM +0100, Stefan Hajnoczi wrote:
>On Fri, Jun 09, 2017 at 02:22:55AM +0300, Manos Pitsidianakis wrote:
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 0b48b64..1a74339 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -416,16 +416,16 @@ static void ide_issue_trim_cb(void *opaque, int re=
t)
>>                  /* 6-byte LBA + 2-byte range per entry */
>>                  uint64_t entry =3D le64_to_cpu(buffer[i]);
>>                  uint64_t sector =3D entry & 0x0000ffffffffffffULL;
>> -                uint16_t count =3D entry >> 48;
>> +                uint16_t bytes =3D entry >> 48;
>>
>> -                if (count =3D=3D 0) {
>> +                if (bytes =3D=3D 0) {
>>                      continue;
>>                  }
>>
>>                  /* Got an entry! Submit and exit.  */
>>                  iocb->aiocb =3D blk_aio_pdiscard(iocb->blk,
>>                                                 sector << BDRV_SECTOR_BI=
TS,
>> -                                               count << BDRV_SECTOR_BIT=
S,
>> +                                               bytes << BDRV_SECTOR_BIT=
S,
>>                                                 ide_issue_trim_cb, opaqu=
e);
>>                  return;
>>              }
>
>This change looks suspicious:
>
>  bytes << BDRV_SECTOR_BITS
>
>Therefore 'bytes' is actually in units of sectors!
>
>Please drop this hunk.


:) Rookie mistake, thanks. (At some other places there's count >>=20
BDRV_SECTOR_BITS, hope this change makes it clear) Will send a v3.

--wqygvzpvvneceuga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlk6dCAACgkQc2J8L2kN
9xDFog//d6veREDoAui1P1Ta/6WDDofEHBPQz7a8uslY6fjw9KjFCZu4PK1jwEHz
IWZwzfky6A5qjcWZFTT0z9yvbAcxuWj2d5Mj6ZXHmCHHLoz9bdHZOYRPmSboDJVC
phOeHCLfdKyAD9bqNE/0BfMSPx7gurS6p9AnpaE6dcd0vd5/+1gntMFR1vXuKTzu
psbpB3DTa1jOl5sf8ER+MhIf9MIi8urTyhWixnbTPF2+rLiEYG1wj/5lHimFdZiy
ylPfuh0XCVl2K80FSQrHLOylMg/gyQqnIxtQjPMoSPqKh3Rw2ibFBg6VJT0i9Kt4
sjgzuz7pk1X8uSMd3+SNuzbtLxspOtemmy5mo0P4ZgTXaA4AhGYX7yVtDz3jWbpA
TnIO0GAd+w8I3pi6vljKcDwOsLZlnVizZFviEPO1A2P4C5JmME6YxtFX04jnsf5O
Q5CmvKUNIVVA6yLX5aFtvAhwAEMph22Qr4KeNc3lyx3MCrmwzmCCmF44n5H6bXSn
rArLD9XS2iLn7BMpV0kFKYjnb+7Y8gW7Olxnn5+HgZV4507oMIjHhFmUF6m2LW+u
y8tVFo0m4yLLgSQNG5fa4ohzV6vk1ymHh6gc7aQr4fJnakXg2suiJb8aA8nTm7nA
mCFyN2SkNIJtEaS+yhpyoLJh88jcMRcKavWzmg0TL2ApZ2NuhYE=
=pxbg
-----END PGP SIGNATURE-----

--wqygvzpvvneceuga--
