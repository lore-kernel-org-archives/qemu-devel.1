Received: from eggs.gnu.org ([2001:4830:134:3::10]:42381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciL2l-0007RZ-JY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciL2g-0007Yq-Mf
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:08:47 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciL2g-0007Yc-Gb
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:08:42 -0500
Received: by mail-wr0-x242.google.com with SMTP id g10so10064381wrg.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:08:42 -0800 (PST)
Date: Mon, 27 Feb 2017 13:08:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227130839.GJ28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814895464.28146.14337427309543597613.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline
In-Reply-To: <148814895464.28146.14337427309543597613.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 08/28] 9pfs: local: llistxattr: don't
 follow symlinks
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


--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:42:34PM +0100, Greg Kurz wrote:
> The local_llistxattr() callback is vulnerable to symlink attacks because
> it calls llistxattr() which follows symbolic links in all path elements b=
ut
> the rightmost one.
>=20
> This patch introduces a helper to emulate the non-existing flistxattrat()
> function: it is implemented with /proc/self/fd which provides a trusted
> path that can be safely passed to llistxattr().
>=20
> local_llistxattr() is converted to use this helper and opendir_nofollow().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - introduce /proc based flistxattrat_nofollow()
> ---
>  hw/9pfs/9p-xattr.c |   35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCTXAAoJEJykq7OBq3PIV3IH/i0OPMFma/EkmkHmSjIz7CIy
1tqaIhOxqGd7+DeznwcCSgriC2mPEMhM7ojcsbsrZimjboOoPwNq4qf3M8MvYA+s
mY/heYsW3fqgmoNx/GTwBJWLlbckNv8WPvX5rnMsom5GtEou1130hRylVZyWhwSq
1ncFandCpruXUAfohZ44z284wizD8rYUpU4WL6R8BkEkNqIHEQ/rNaosCDCzdf/B
VnfUxunGoR2t85CvivULSgGVySiLFkeG46VkfbhkjRTOx9Tq6VCfQYy0XFCWQkIq
31ZRjSNRLLv75EO65HX3Jsd65TQODmkgM52eGVHEx9sgZiBMvCcvGydHcyjGcoo=
=YHZC
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--
