Received: from eggs.gnu.org ([2001:4830:134:3::10]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpyu7-0002K0-7g
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpyu6-0004ZU-03
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:07:27 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214001.26339-2-mreitz@redhat.com>
	<20170320101828.GC17887@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <56ea38e1-61fa-9339-741a-dbe8ceed8816@redhat.com>
Date: Mon, 20 Mar 2017 16:07:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170320101828.GC17887@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F5gpWU9rvKTGRseo4QNEG3ILNNfBJeoPX"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 01/16] block: Add
 PreallocMode to BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F5gpWU9rvKTGRseo4QNEG3ILNNfBJeoPX
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <56ea38e1-61fa-9339-741a-dbe8ceed8816@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.10 01/16] block: Add PreallocMode to
 BD.bdrv_truncate()
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214001.26339-2-mreitz@redhat.com>
 <20170320101828.GC17887@stefanha-x1.localdomain>
In-Reply-To: <20170320101828.GC17887@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20.03.2017 11:18, Stefan Hajnoczi wrote:
> On Mon, Mar 13, 2017 at 10:39:46PM +0100, Max Reitz wrote:
>> diff --git a/block/iscsi.c b/block/iscsi.c
>> index ab559a6f71..5d6265c4a6 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -2060,11 +2060,16 @@ static void iscsi_reopen_commit(BDRVReopenStat=
e *reopen_state)
>>      }
>>  }
>> =20
>> -static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error=
 **errp)
>> +static int iscsi_truncate(BlockDriverState *bs, int64_t offset,
>> +                          PreallocMode prealloc, Error **errp)
>>  {
>>      IscsiLun *iscsilun =3D bs->opaque;
>>      Error *local_err =3D NULL;
>> =20
>> +    if (prealloc !=3D PREALLOC_MODE_OFF) {
>> +        return -ENOTSUP;
>> +    }
>> +
>>      if (iscsilun->type !=3D TYPE_DISK) {
>>          return -ENOTSUP;
>>      }
>=20
> Nevermind what I said about adding a BiteSizedTasks entry:
>=20
> The missing errp usage is not in qemu.git/master yet.  Please fix up
> your bdrv_truncate() errp patch to use errp in all cases, e.g.
> error_setg("Unable to truncate non-disk LUN").

The thing is that I wasn't comfortable doing that for all block drivers.
I mean, I can take another look but I'd rather have vague error messages
("truncation failed: #{strerror}") than outright wrong ones because I
didn't know what error message to use.

Of course you could argue that this may probably come out during review
but that implies that every submaintainer for every block driver would
actually come out for review...

Max


--F5gpWU9rvKTGRseo4QNEG3ILNNfBJeoPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljP8CQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9An18IALFOVp6BGZaO/ms0TErNh0r+5Yp+ohQc
6HQItwc0SaumxEICNJKny76d9ZBS8kwdXsPA6yHanAmUR2NveJapS37h+ATnijq1
bXiJVRX3bIgThcweXo19RAXcgRzW1AcCwB86aLAI7p36AdR7F6K+4i9X1m3I/WkZ
A4yLSqJKLIEADPHFONf1BHpqRlls61SmIBekV55BiTFmGvD1rpyGfpt96Esg9Ejz
MdfUQT9M5BcA+rzRRRN+f3pvBrGXQniq8f7npmzIOoEz4G173hpyO6q0BbMLI2w/
udgQN7D6e2uWZM6qXsCyk2rXkqZ2IsAVaB7QvyPwTXLesuv4+psWfqA=
=Wze6
-----END PGP SIGNATURE-----

--F5gpWU9rvKTGRseo4QNEG3ILNNfBJeoPX--
