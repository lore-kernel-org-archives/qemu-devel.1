Received: from eggs.gnu.org ([2001:4830:134:3::10]:56160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1duirD-0000IK-Tt
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1duirD-00049c-7S
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:32:19 -0400
Date: Wed, 20 Sep 2017 20:32:10 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170920173210.ftursp2syk2vm3j5@postretch>
References: <20170920102311.25736-1-el13635@mail.ntua.gr>
	<20170920102311.25736-2-el13635@mail.ntua.gr>
	<20170920142632.GC9409@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tavq6tdkbs2vzndn"
Content-Disposition: inline
In-Reply-To: <20170920142632.GC9409@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: add bdrv_co_drain_end callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>


--tavq6tdkbs2vzndn
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 03:26:32PM +0100, Stefan Hajnoczi wrote:
>On Wed, Sep 20, 2017 at 01:23:09PM +0300, Manos Pitsidianakis wrote:
>> @@ -188,7 +194,7 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
>>      waited =3D BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
>>
>>      /* Ensure any pending metadata writes are submitted to bs->file.  */
>> -    bdrv_drain_invoke(bs);
>> +    bdrv_drain_invoke(bs, begin);
>
>Do you need to move bdrv_drain_invoke(bs, begin) before
>BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0)?
>
>This will ensure that throttling is disabled and the TGM restarted
>before we wait for requests to complete.
>

Hm yes. Before, the order was irrelevant because BlockBackend issued the=20
drain first by restarting the tgm in blk_root_drained_begin.

--tavq6tdkbs2vzndn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnCphoACgkQc2J8L2kN
9xDuaQ/8Cg5+57c0yP6SKfeocYyMEABxze5UR4pKpcIu1a1ASBRQdmv14iJPgwoZ
q453xgz843d8p0dbEZMB5XPzfyOLG13DkwQqasqpzEHIiWZKF1YUSBJWfSNtu4eQ
8U42GXw/VqCIDlk0uiq7as6PVqBE/NzN65U9cit2niFVR2eBl7XbXul17QCLCifj
t3Eo0XIaRBJaLtaLpiMKSZMKs6/MoGOtpA0bbdnNb5muYs6kBdUsayddvg/F4ric
kxGpKXap4uQ8Z9PYCOCRH6FC6ZeTc5UQcXBnqD+CooH1zGCD0PW1k6uZ4IBcrs0I
H6vJSB69iE7XrCRvWYJHWeSfd9YbsIUPbpA2d5GpWtLk6xqOnbL4da2WD1aiYczR
FWquMMf8h5grjQiIbXLJq6A/yFck49pw8JpCFRUzkYVRVZ5kOijnQmKekRkcpwKJ
8lAmgsAgNB5EBVmwvOfvzI2qrFxQAY8NWVmMMpr0Vw3ZWZjI3r3TXyvKQ5N9JrEY
ZCgBguPKsJDjYYOmGAY2bkK1ot34GYWvNmv81eHmRIoERhMtGot2eahb+lOeLngx
lvYL4Hrvf+ZSFdJ9YXKK6VlUZsEntAyWQBnjGLB8+/MlS+Ir/GMRhPbjVgJOX8Es
7h2urW4+6DRdfWIh/w4C3TinCrinweETFFyTkN+lCl67Xjpsyns=
=L5lX
-----END PGP SIGNATURE-----

--tavq6tdkbs2vzndn--
