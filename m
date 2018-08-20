Received: from eggs.gnu.org ([2001:4830:134:3::10]:36907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frjAg-0003b9-5o
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frjAf-0002By-DH
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:20:34 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
	<48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
	<20180820020715.GB10682@lemon.usersys.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fed17a0f-c940-db3c-4ff9-3f72e18db03c@redhat.com>
Date: Mon, 20 Aug 2018 14:20:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180820020715.GB10682@lemon.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MyV7f2AZ8BbZy2kGi5rvw1IMUkNnatZhe"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, fullmanet@gmail.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MyV7f2AZ8BbZy2kGi5rvw1IMUkNnatZhe
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, fullmanet@gmail.com, qemu-block@nongnu.org
Message-ID: <fed17a0f-c940-db3c-4ff9-3f72e18db03c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
References: <20180815025614.53588-1-eblake@redhat.com>
 <20180815025614.53588-3-eblake@redhat.com>
 <48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
 <20180820020715.GB10682@lemon.usersys.redhat.com>
In-Reply-To: <20180820020715.GB10682@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-20 04:07, Fam Zheng wrote:
> On Thu, 08/16 04:20, Max Reitz wrote:
>> No, the real issue is that dd is still not implemented just as a
>> frontend to convert.  Which it should be.  I'm not sure dd was a very
>> good idea from the start, and now it should ideally be a frontend to
>> convert.
>>
>> (My full opinion on the matter: dd has a horrible interface.  I don't
>> quite see why we replicated that inside qemu-img.  Also, if you want t=
o
>> use dd, why not use qemu-nbd + Linux nbd device + real dd?)
>=20
> The intention is that dd is a familiar interface and allows for operati=
ng on
> portions of images. It is much more convenient than "qemu-nbd + Linux n=
bd + dd"
> and a bit more convenient than "booting a Linux VM, attaching the image=
 as a
> virtual disk, then use dd in the guest". More so when writing tests.

This is my fault, but frankly, since I always get seek and skip mixed
up, whenever I use dd for anything but copying a whole image, I have to
look into the man page anyway, so the advantage over modprobe nbd &&
qemu-nbd -c /dev/nbd0 is gone.

And in my opinion the fact that it is a familiar interface doesn't make
it less of a horrible interface.

My main issue is that it's built right into qemu-img where it shouldn't
be.  We have convert, you can now even access portions of images with
the raw driver, so it really should have been just a script on top.

Max


--MyV7f2AZ8BbZy2kGi5rvw1IMUkNnatZhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt6sgQACgkQ9AfbAGHV
z0D7Igf7BF2Op+yBoWEeAgJ6Ms2LYILN5c3dFctXgx1nDSMBPyNu6wOy781v0FSH
nDU8bgqrgOamzsgzBySzKHbpZhjOcSt4KvSPIwAT8mJuU6X4igKIuFteVXV1zfw/
wHudEzc0jaxB7sIN23tr7Oifrerf5GxZlpIozMP7ZcQK5TzBxl8hMp9AIu4Dhk8H
Upb5S8Q5nlB1kaDSjxS2hWz6C+HEHqMqGlevyefZzHInBLSXsxAKuHKXy97ypEw3
PTEUZjhCw3WXr5Bhjr+nK9IUv+Nrrta/joBSOGiVhSiWry7cKsPrBBLAE6U/li75
2fLBT75yYHGz9NeKelSTmo6swUGy7w==
=oL0v
-----END PGP SIGNATURE-----

--MyV7f2AZ8BbZy2kGi5rvw1IMUkNnatZhe--
