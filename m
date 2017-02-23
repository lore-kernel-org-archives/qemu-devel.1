Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgthq-0007Wj-D3
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgthn-0004d7-BC
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:45:14 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:32958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgthn-0004cy-4W
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:45:11 -0500
Received: by mail-wr0-x244.google.com with SMTP id s27so3974075wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 05:45:10 -0800 (PST)
Date: Thu, 23 Feb 2017 13:45:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223134506.GH30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760162344.31154.691252878759862885.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
In-Reply-To: <148760162344.31154.691252878759862885.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 08/29] 9pfs: local: lgetxattr: don't follow
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


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:40:23PM +0100, Greg Kurz wrote:
> The local_lgetxattr() callback is vulnerable to symlink attacks because
> it calls lgetxattr() which follows symbolic links in all path elements but
> the rightmost one.
>=20
> This patch converts local_lgetxattr() to rely on opendir_nofollow() and
> fgetxattrat_nofollow() instead.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-posix-acl.c  |   16 ++--------------
>  hw/9pfs/9p-xattr-user.c |    8 +-------
>  hw/9pfs/9p-xattr.c      |    8 +-------
>  3 files changed, 4 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrudiAAoJEJykq7OBq3PIdu0H/0dXO8aOXB2UzTKwBpZkrdYH
MBwXitBW3loDR99v258ZCsQQWT4AhzUaeoNxKyZZP5miC+wApnaJQFFfe1lw0usx
4sSTuzs1dbVVXeUyHgf7YDDLYnvs3OhTKlcWfYBa4OYTayqo/mTFWBI+h9OSreBH
DVYP/f82JTbkvP4sOZHVYFN037x6tETDSfOkKhft/Bfqg1G/VqtgMeWDLySmkywk
MmNA2641ZQLsn6sCAgu5RWfX1u0mBB+RoNT9PUZst/FP95zkCppsNBzHSDzcxntr
H9eIujz3stoRpflEv4PLv4N0nG2i0ZdhlEgSQMWrM+oknNqDW8LgzptEFPwhwF0=
=FiHt
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
