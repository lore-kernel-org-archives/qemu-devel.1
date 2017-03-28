Received: from eggs.gnu.org ([2001:4830:134:3::10]:48462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cswuz-0005RJ-Nd
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cswuy-00034g-NL
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:36:37 -0400
References: <20170308191434.2413-1-mreitz@redhat.com>
	<20170308191544.3025-1-mreitz@redhat.com>
	<20170323180054.GD5344@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bb562503-4d1f-34df-da78-3b034ec9a325@redhat.com>
Date: Tue, 28 Mar 2017 21:36:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170323180054.GD5344@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fum9uwwhBwCcnPAHcoAko3LpSe05f5L60"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 3/4] block: Add errp to
 BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fum9uwwhBwCcnPAHcoAko3LpSe05f5L60
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Message-ID: <bb562503-4d1f-34df-da78-3b034ec9a325@redhat.com>
Subject: Re: [PATCH v2 for-2.10 3/4] block: Add errp to BD.bdrv_truncate()
References: <20170308191434.2413-1-mreitz@redhat.com>
 <20170308191544.3025-1-mreitz@redhat.com>
 <20170323180054.GD5344@noname.redhat.com>
In-Reply-To: <20170323180054.GD5344@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23.03.2017 19:00, Kevin Wolf wrote:
> Am 08.03.2017 um 20:15 hat Max Reitz geschrieben:
>> Add an Error parameter to the block drivers' bdrv_truncate() interface=
=2E
>> If a block driver does not set this in case of an error, the generic
>> bdrv_truncate() implementation will do so.
>>
>> Where it is obvious, this patch also makes some block drivers set this=

>> value.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>> diff --git a/block/iscsi.c b/block/iscsi.c
>> index 75d890538e..ab559a6f71 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -2060,7 +2060,7 @@ static void iscsi_reopen_commit(BDRVReopenState =
*reopen_state)
>>      }
>>  }
>> =20
>> -static int iscsi_truncate(BlockDriverState *bs, int64_t offset)
>> +static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error=
 **errp)
>>  {
>>      IscsiLun *iscsilun =3D bs->opaque;
>>      Error *local_err =3D NULL;
>> @@ -2071,7 +2071,7 @@ static int iscsi_truncate(BlockDriverState *bs, =
int64_t offset)
>> =20
>>      iscsi_readcapacity_sync(iscsilun, &local_err);
>>      if (local_err !=3D NULL) {
>> -        error_free(local_err);
>> +        error_propagate(errp, local_err);
>>          return -EIO;
>>      }
>=20
> I think this function contains a few more cases for patch 4.

I'm probably going to follow Stefan's proposal of adding (even generic)
error messages to all drivers anyway.

Max


--fum9uwwhBwCcnPAHcoAko3LpSe05f5L60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljauzwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUxQH/0u3racnxeLhyQIrTyMxp2uGpVCeqRZU
TV2NEJlMCozKEcCQv2p88G6UB8arnEJYLCV5IbOapoAmT9t7GRKNurGKXY+zt6RZ
jABdv/INbs2miSFZqJz82sb42CCQEug3GK3bUKHKIy+JFh+87RBmxCh+KWhUoTSZ
qo6+zcl+EsSjFPECL1cjB6MM8TseO6u6UJreT1Lo21OQCtdVJtmq97XUO34JEmIz
Z0bKn+3VwMBrOYqwEutZ4OTcDeWQCUCZKdfuJ3Abuk6c+9giv3zdQpH6jka954MW
QN7OCKwuR36EC3XaEq+ra/I3dpkld4cXIoMyMV9UhHQ3c4oa8JoTBCE=
=kkwM
-----END PGP SIGNATURE-----

--fum9uwwhBwCcnPAHcoAko3LpSe05f5L60--
