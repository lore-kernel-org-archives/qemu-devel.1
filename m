Received: from eggs.gnu.org ([2001:4830:134:3::10]:56326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpyuV-0002WC-8S
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpyuU-0004h0-AD
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:07:51 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-2-mreitz@redhat.com>
	<20170320104743.GE17887@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fd8c2121-d83e-364e-e084-5934b521fc50@redhat.com>
Date: Mon, 20 Mar 2017 16:07:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170320104743.GE17887@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VNAhFTlQRxJWqWC8jwDf1IOSHkHts4tll"
Subject: Re: [Qemu-devel] [PATCH for-2.10 04/16] qemu-img: Expose
 PreallocMode for resizing
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
--VNAhFTlQRxJWqWC8jwDf1IOSHkHts4tll
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <fd8c2121-d83e-364e-e084-5934b521fc50@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 04/16] qemu-img: Expose PreallocMode
 for resizing
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214045.26857-2-mreitz@redhat.com>
 <20170320104743.GE17887@stefanha-x1.localdomain>
In-Reply-To: <20170320104743.GE17887@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20.03.2017 11:47, Stefan Hajnoczi wrote:
> On Mon, Mar 13, 2017 at 10:40:33PM +0100, Max Reitz wrote:
>> @@ -3429,8 +3442,16 @@ static int img_resize(int argc, char **argv)
>>          goto out;
>>      }
>> =20
>> +    current_size =3D blk_getlength(blk);
>> +    if (current_size < 0) {
>> +        error_report("Failed to inquire current image length: %s\n",
>=20
> Spurious newline, error_report() doesn't need it.

Oops, will fix.

Max


--VNAhFTlQRxJWqWC8jwDf1IOSHkHts4tll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljP8EASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4FIH/0wrbgcAxGHYv4V0yMnCMbSeMrCSJyOE
vGHhV2nriereGj1rfndPQQgD5hLBl94sp6/deHgpFpMFzeQHJ/gu28IN+8pdkh5z
w/Ibw2V4/sRrJ1sJnmmw3omdCbDcWZftHGVSkkT7GZZG/odDLFEAQ75mHtNBcupG
AdGmKm9sVHNhH8U8Xi3RCzQ1bLXL1AQ4sTGZ9RpT79G8D026Fl4J7tD1jgsE0kQT
K3zPK9lBqEev9XDlEaIc91n4xSmYBY98udE7qxjnnBY/vcJIgZgCp0rBj086XY1j
qbNVJdN0fvX3cr47fk3tAfybQYidoTui2/pzQQ9YNv2Q+NH6ICbOLcQ=
=APdg
-----END PGP SIGNATURE-----

--VNAhFTlQRxJWqWC8jwDf1IOSHkHts4tll--
