Received: from eggs.gnu.org ([2001:4830:134:3::10]:57985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpyzf-00069f-Gs
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpyze-0006zo-H5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:13:11 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-7-mreitz@redhat.com>
	<20170320110404.GJ17887@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c3909a14-2a06-74d9-8238-f1855e070932@redhat.com>
Date: Mon, 20 Mar 2017 16:13:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170320110404.GJ17887@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XK1csOQfP02NOtL0mJVEgdPq9f9Qb9MtG"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 09/16] block/qcow2:
 Generalize preallocate()
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
--XK1csOQfP02NOtL0mJVEgdPq9f9Qb9MtG
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <c3909a14-2a06-74d9-8238-f1855e070932@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.10 09/16] block/qcow2: Generalize
 preallocate()
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214045.26857-7-mreitz@redhat.com>
 <20170320110404.GJ17887@stefanha-x1.localdomain>
In-Reply-To: <20170320110404.GJ17887@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20.03.2017 12:04, Stefan Hajnoczi wrote:
> On Mon, Mar 13, 2017 at 10:40:38PM +0100, Max Reitz wrote:
>> This patch adds two new parameters to the preallocate() function so we=

>> will be able to use it not just for preallocating a new image but also=

>> for preallocated image growth.
>>
>> The offset parameter allows the caller to specify a virtual offset fro=
m
>> which to start preallocating. For newly created images this is always =
0,
>> but for preallocating growth this will be the old image length.
>>
>> The new_length parameter specifies the supposed new length of the imag=
e
>> (basically the "end offset" for preallocation). During image truncatio=
n,
>> bdrv_getlength() will return the old image length so we cannot rely on=

>> its return value then.
>=20
> You documented the arguments in the commit description.  Please move
> them into doc comments.

Yeah, right, new_length is not really a super self-explaining name...
I'll add a comment.

Max


--XK1csOQfP02NOtL0mJVEgdPq9f9Qb9MtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljP8X0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AR60H/2CX+v/ph+yCFQiZy52Vsb4ceUDBhzX7
jmjh+yFg4rLlACDO9SXtAaiU/AQFiePl6ayWGkNFkLyiETWKA/XMtbZ9tCU1RfE6
CKY1YMPAZOSKUhT4X/BkNdHfYNLZ56xxYYz6504c+VdQCTfCx70d3tOvAD2U8CA0
um1HUbwy1DcwYCOOP5EHUV8nGh/F5o5UWnHVs3EnjAMa2+ErD9X4oqpVwAVIiYHw
Jn3DKszEWa0qunHNhS4ux9E7nvRn92D6FkbeFrUMFWnAt/OCchO0eDtz83sRgWM+
yQ1PFCuuKRp3Otw1VRTQNDKbs830JCLN1JqOf19OdvYBuS9pVh5ites=
=lNQR
-----END PGP SIGNATURE-----

--XK1csOQfP02NOtL0mJVEgdPq9f9Qb9MtG--
