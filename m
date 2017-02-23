Received: from eggs.gnu.org ([2001:4830:134:3::10]:38768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguhA-0005St-R8
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguh5-0004zR-TD
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:48:36 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cguh5-0004z4-MO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:48:31 -0500
Received: by mail-wm0-x244.google.com with SMTP id u63so233190wmu.2
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:48:31 -0800 (PST)
Date: Thu, 23 Feb 2017 14:48:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223144828.GO30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760167688.31154.15169118370965638805.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f9b3biUB1f7FHqGn"
Content-Disposition: inline
In-Reply-To: <148760167688.31154.15169118370965638805.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 15/29] 9pfs: local: statfs: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--f9b3biUB1f7FHqGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:41:16PM +0100, Greg Kurz wrote:
> The local_statfs() callback is vulnerable to symlink attacks because it
> calls statfs() which follows symbolic links in all path elements.
>=20
> This patch converts local_statfs() to rely on open_nofollow() and fstatfs=
()
> instead.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--f9b3biUB1f7FHqGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvY8AAoJEJykq7OBq3PIL0YH/1i5opo1CwZW5RarUNvyedwR
sJ4X2OEUnkq7/TummniLbD+M92RRZKe742fhF1X+dvyS+oN5YBgw7OIwj6thfetz
EvFzPec77r1Bkj+sX0GsYHUMV9mY7HkMiycCn1MImVr4RltwxvWeMD3WIJFRK78h
JhegoCtFbJagT1sJfPaiKyXUYN6vzrdGN6siZ+xlesJGrWfQgEuSXxgQDeK4zrJz
wC9ds9zYK5NpFqyBrTpmMNPgkvIg1PWOL5/rCm9nKoGToCY2Nwd0SqZHX5vhtrdP
ohxhsLmCOsOqjTuTq3caH339khiLabrTx2xrD7Paf2MMncGJcR27QYWFFBZKudU=
=+S8b
-----END PGP SIGNATURE-----

--f9b3biUB1f7FHqGn--
