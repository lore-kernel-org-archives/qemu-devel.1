Received: from eggs.gnu.org ([2001:4830:134:3::10]:41670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgupx-00060L-KH
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgups-0007tV-Mh
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:57:41 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgups-0007tO-GY
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:57:36 -0500
Received: by mail-wr0-x22a.google.com with SMTP id z61so23271168wrc.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:57:36 -0800 (PST)
Date: Thu, 23 Feb 2017 14:57:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223145733.GT30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760171694.31154.11442532244785875759.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3T2jnoiI0lx9XXvh"
Content-Disposition: inline
In-Reply-To: <148760171694.31154.11442532244785875759.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 20/29] 9pfs: local: rename: use renameat
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


--3T2jnoiI0lx9XXvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:41:56PM +0100, Greg Kurz wrote:
> The local_rename() callback is vulnerable to symlink attacks because it
> uses rename() which follows symbolic links in all path elements but the
> rightmost one.
>=20
> This patch simply transforms local_rename() into a wrapper around
> local_renameat() which is symlink-attack safe.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   57 +++++++++++++++++++++++++---------------------=
------
>  1 file changed, 27 insertions(+), 30 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3T2jnoiI0lx9XXvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvhdAAoJEJykq7OBq3PIhNQH/iyYR/7561XbHv8KIy+VkhNW
/u19hZmkr6bCRP33lafHtW4I75pXZJkwpQK0SZf9aQXgZNXUmAQ+zpSlzgsX2qjQ
rGaytcN1IQh6h1+24R09gD+RqmquOMkeRjXybiEEXQp24TgoeBjzHWrKdCYD8NuP
sHtqAnfpNWE7fTOmD3kGbOMykkymaRSG6jOjhqzcJwx/GItn/7X7G8FjupLS4CwP
PaalGfnkNcnzxwNwrjrknX6rYCU0iXR4a6t/96SkwNUlOoCpfSxKB7ONuQjy6FQk
llkHa9O7NvYLQ0SuO1C0/MoyKE4C9iLLrMj81/mYsr1/TPcaAEnickZeWFZNfb8=
=qXdr
-----END PGP SIGNATURE-----

--3T2jnoiI0lx9XXvh--
