Received: from eggs.gnu.org ([2001:4830:134:3::10]:44188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elDKC-00021q-89
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elDKB-0006hb-Gj
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:35:12 -0500
References: <20180123140201.31163-1-kwolf@redhat.com>
	<20180123140201.31163-7-kwolf@redhat.com>
	<ffb4a2c5-1335-20f8-2760-b9cdd9e32600@de.ibm.com>
	<1a226804-f877-982a-22e9-7d66f8022a5f@de.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c6f0bab1-88c8-ce59-8f05-f125a1d2a5bf@redhat.com>
Date: Mon, 12 Feb 2018 13:34:49 +0100
MIME-Version: 1.0
In-Reply-To: <1a226804-f877-982a-22e9-7d66f8022a5f@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dQQTjmPgjxwEirMxN6hEnOrM8m436tLh0"
Subject: Re: [Qemu-devel] [PULL 06/29] iotests: Make BD-{remove,
 insert}-medium use @id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dQQTjmPgjxwEirMxN6hEnOrM8m436tLh0
From: Max Reitz <mreitz@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>
Message-ID: <c6f0bab1-88c8-ce59-8f05-f125a1d2a5bf@redhat.com>
Subject: Re: [Qemu-devel] [PULL 06/29] iotests: Make BD-{remove,
 insert}-medium use @id
References: <20180123140201.31163-1-kwolf@redhat.com>
 <20180123140201.31163-7-kwolf@redhat.com>
 <ffb4a2c5-1335-20f8-2760-b9cdd9e32600@de.ibm.com>
 <1a226804-f877-982a-22e9-7d66f8022a5f@de.ibm.com>
In-Reply-To: <1a226804-f877-982a-22e9-7d66f8022a5f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-12 12:33, Christian Borntraeger wrote:
> Adding Max and Alberto,
>=20
> I think the issue is that on s390 you cannot add a floppy

Thanks for letting me know.  I don't know why I resorted to floppy when
virtio would have worked (in this test) just as well...

Max


--dQQTjmPgjxwEirMxN6hEnOrM8m436tLh0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBiekSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKvwH/1WvFvYjQqvd8cS5/e6FKH/ZFAB8ysne
wIKtl+vgq8TUAo/kSYT3OR1mjEUbQVYcV/XX/2w1TbiBkE+IhpcHJH/BHKsyjcak
UnAKEQL0EqbLeJChsjlFgdF+vUx3rQT2IBRtMeYeuoM0Rn31s0TZIwVklKBKnJ+O
hj/rlnvv1Z0ISahL8rS/Wx/DfW+M7UmU4C8FFjX6kUoZz4YmZThUBLIkoiq0bESQ
XYlWv60ZpyECCvsEMSAPLX3lnbRsKfS/MmvbOgDyUYVMmYy18spR7qeEWKjAV8Fk
0w5uF9ysXj1EkOGD0p4eoOLcj05DJ7AFlkyycDVCPcVAVrn63eUQHBY=
=rfkv
-----END PGP SIGNATURE-----

--dQQTjmPgjxwEirMxN6hEnOrM8m436tLh0--
