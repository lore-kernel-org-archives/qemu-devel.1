Received: from eggs.gnu.org ([209.51.188.92]:38811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghD3C-0003QZ-1a
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghD3A-0000V7-UX
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:33:38 -0500
Date: Wed, 9 Jan 2019 12:33:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190109123324.GC18942@stefanha-x1.localdomain>
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <20190108194552.45453-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] file-posix: add
 rough-block-status parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 10:45:52PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> bdrv_co_block_status digs bs->file for additional, more accurate search
> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
>=20
> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> knows, where are holes and where is data. But every block_status
> request calls lseek additionally. Assume a big disk, full of
> data, in any iterative copying block job (or img convert) we'll call
> lseek(HOLE) on every iteration, and each of these lseeks will have to
> iterate through all metadata up to the end of file. It's obviously
> ineffective behavior. And for many scenarios we don't need this lseek
> at all.
>=20
> So, add an option to omit calling lseek.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all!
>=20
> This is a continuation of "do not lseek in qcow2 block_status" thread
> (https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05749.html)

I don't have time to participate in the discussion so my (uneducated?)
opinion doesn't count for much, but I wish it were possible to perform
this optimization automatically without introducing a new user-visible
option.

That way existing users benefit and new users don't have to learn about
a new option.

Stefan

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNeoUAAoJEJykq7OBq3PIzcUH/jBAqE6dClfGeBiTJ6+dZdBc
TocV7KW7B4HANtIwtLq50aty4F1Gi86qY7j5H9q810HHX7r7OdTAG0Sz+QQ7zQ8m
4HA2mVQLJZkFzzem/g31R6P9aU9HnK1y2zClPNLjYXRddi/6EfuKQaBohPbi9R7C
maI+6llvL07zygC9/0kArXg4elvuX6fyI/eljUsEYYLmPFHqW9mkORtfcGRctuEv
f30YBE6+lJ+Hsd6SWi/RXfuFklKDpiLMd/8VxjXY2F1F1gSG8TwpfeQFV7V9ZlZK
RrIHc7LnRTT4D/ThV78rDxswK+1D0uKy64LFtXVCNfuHkjNuiTS8tUI6CbLmnYs=
=zPFr
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
