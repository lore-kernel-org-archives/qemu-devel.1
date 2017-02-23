Received: from eggs.gnu.org ([2001:4830:134:3::10]:59151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgu4k-00028X-Mt
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgu4f-00021n-Ol
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:08:54 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgu4f-00021L-IS
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:08:49 -0500
Received: by mail-wr0-x242.google.com with SMTP id s27so4055180wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:08:49 -0800 (PST)
Date: Thu, 23 Feb 2017 14:08:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223140846.GJ30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760163823.31154.16688868823479209435.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline
In-Reply-To: <148760163823.31154.16688868823479209435.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 10/29] 9pfs: local: lsetxattr: don't follow
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


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:40:38PM +0100, Greg Kurz wrote:
> The local_lsetxattr() callback is vulnerable to symlink attacks because
> it calls lsetxattr() which follows symbolic links in all path elements but
> the rightmost one.
>=20
> This patch converts local_lsetxattr() to rely on opendir_nofollow() and
> fsetxattrat_nofollow() instead.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-posix-acl.c  |   18 ++++--------------
>  hw/9pfs/9p-xattr-user.c |    8 +-------
>  hw/9pfs/9p-xattr.c      |    8 +-------
>  3 files changed, 6 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYruzuAAoJEJykq7OBq3PIt0wH+gJgw5uRLdoxIqgV5SkQU2EO
DpylSYPMVj/jhOhoynHCstXxJ4t8NLkq/RmTPeM76CevHZ2ZEUV3MfVJrIo5XObU
qHqKSyGGR0PITQZn1JQxrJ9ctVa3jmzYW982wpKOZo2jZgEjPzV0VPUd5A56mt+s
TI6U+TX5TfkT1g3oTvE1iNLtGWrLNEIIUFtDQDnprgELNZ2mbw2l8r4P16Wps03n
LJhTMvr0x/cGbg+WYJps1OmtvSFo06z+vKbDCl7Cn4v3q/1FSKfe+yxB7k0ChhGt
+EWAu8cPaeZwkfMkL/WwkaCRNuZKXPNth1hMy7BuXq1TIfzUNBS0qpJ5Fdb2QVw=
=XL82
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--
