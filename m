Received: from eggs.gnu.org ([2001:4830:134:3::10]:60030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfm3V-00085M-QP
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfm3U-0005gL-Tl
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:22:57 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-17-git-send-email-kwolf@redhat.com>
	<ef9df6e6-6029-29ba-caa6-93bdbe835bae@redhat.com>
	<20170220112201.GB4814@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6c2e5f4a-3f7e-e8a8-930f-71721ba2d36d@redhat.com>
Date: Mon, 20 Feb 2017 12:22:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170220112201.GB4814@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1F8Wrdx9xkgV0guEc8d00rlDdMT7GEujW"
Subject: Re: [Qemu-devel] [RFC PATCH 16/41] block: Add error parameter to
 blk_insert_bs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1F8Wrdx9xkgV0guEc8d00rlDdMT7GEujW
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <6c2e5f4a-3f7e-e8a8-930f-71721ba2d36d@redhat.com>
Subject: Re: [RFC PATCH 16/41] block: Add error parameter to blk_insert_bs()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-17-git-send-email-kwolf@redhat.com>
 <ef9df6e6-6029-29ba-caa6-93bdbe835bae@redhat.com>
 <20170220112201.GB4814@noname.redhat.com>
In-Reply-To: <20170220112201.GB4814@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20.02.2017 12:22, Kevin Wolf wrote:
> Am 20.02.2017 um 12:04 hat Max Reitz geschrieben:
>> On 13.02.2017 18:22, Kevin Wolf wrote:
>>> Mow that blk_insert_bs() requests the BlockBackend permissions for th=
e
>>> node it attaches to, it can fail. Instead of aborting, pass the error=
s
>>> to the callers.
>>
>> So it does qualify as a FIXME, but just for a single patch. Good. :-)
>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/backup.c                   |  5 ++++-
>>>  block/block-backend.c            | 12 ++++++++----
>>>  block/commit.c                   | 38 ++++++++++++++++++++++++++++++=
--------
>>>  block/mirror.c                   | 15 ++++++++++++---
>>>  blockdev.c                       |  6 +++++-
>>>  blockjob.c                       |  7 ++++++-
>>>  hmp.c                            |  6 +++++-
>>>  hw/core/qdev-properties-system.c |  7 ++++++-
>>>  include/sysemu/block-backend.h   |  2 +-
>>>  migration/block.c                |  2 +-
>>>  nbd/server.c                     |  6 +++++-
>>>  tests/test-blockjob.c            |  2 +-
>>>  12 files changed, 84 insertions(+), 24 deletions(-)
>>
>> [...]
>>
>>> diff --git a/migration/block.c b/migration/block.c
>>> index 6b7ffd4..d259936 100644
>>> --- a/migration/block.c
>>> +++ b/migration/block.c
>>> @@ -446,7 +446,7 @@ static void init_blk_migration(QEMUFile *f)
>>>          BlockDriverState *bs =3D bmds_bs[i].bs;
>>> =20
>>>          if (bmds) {
>>> -            blk_insert_bs(bmds->blk, bs);
>>> +            blk_insert_bs(bmds->blk, bs, &error_abort);
>>
>> I don't think it's obvious why this is correct. I assume it is because=

>> this was a legal configuration on the source, so it must be a legal
>> configuration on the destination.
>>
>> But I'd certainly appreciate a comment to make that explicitly clear,
>> especially considering that it isn't obvious that blk_insert_bs() can
>> fail only because of op blockers and thus will always work if the
>> configuration is known to be legal.
>=20
> Actually, it's just because the requested permissions for bmds->blk are=

> still 0, BLK_PERM_ALL here. Once the FIXME is addressed (patch 37) and
> the real permissions are requested, we get some error handling here.

OK, good, thanks.

Max


--1F8Wrdx9xkgV0guEc8d00rlDdMT7GEujW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliq0YYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AB4AH/11AjBFrmH7MSgCTHSzhT44hpLl44/bw
N3ZvSwuk4XPuZU4qzDKqiWKUi5BODGP5IFVQ6DwolA6MlbjIfqstjGbmPJyXHFFk
0bHUv4u918OuUPnOjliOmqgGk31mMdidtB8HtTo6GUTW+DczM11D06a6PPz6sjpy
oMEdLe6you6N1lPf8/+ugDkQLnJGAu+XxkFy5/G1aKT98gLgSpzPqVy74I5vnH/q
57psmtXMIhYg2syA0B9m9E3bvxHo8SuDPEMIrpBIFRu6MFabkh5z9fADGS1EgLa0
s3dB8aO7zEGa0t06uQx2y+n68j0EQRfJtPLM6Oqk4AaIZtOKw/xIrao=
=MGXY
-----END PGP SIGNATURE-----

--1F8Wrdx9xkgV0guEc8d00rlDdMT7GEujW--
