Received: from eggs.gnu.org ([2001:4830:134:3::10]:43140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8Bmt-0001mI-Dk
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8Bmp-0003ad-Ab
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:31:15 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:53684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d8Bmp-0003a9-4D
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:31:11 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C3ECBE9D94
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 22:31:09 +0200 (CEST)
Date: Tue, 9 May 2017 22:31:04 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170509223104.55412e1b@bahia>
In-Reply-To: <1494356693-13190-2-git-send-email-sstabellini@kernel.org>
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
	<1494356693-13190-2-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/rwhgYiVV_ui593pL0sJBdi6";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] Check the return value of fcntl in
 qemu_set_cloexec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xen.org, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>

--Sig_/rwhgYiVV_ui593pL0sJBdi6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  9 May 2017 12:04:52 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Assert that the return value is not an error. This issue was found by
> Coverity.
>=20
> CID: 1374831
>=20
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> CC: groug@kaod.org
> CC: pbonzini@redhat.com
> CC: Eric Blake <eblake@redhat.com>
> ---
>  util/oslib-posix.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Greg Kurz <groug@kaod.org>

> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4d9189e..16894ad 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -182,7 +182,9 @@ void qemu_set_cloexec(int fd)
>  {
>      int f;
>      f =3D fcntl(fd, F_GETFD);
> -    fcntl(fd, F_SETFD, f | FD_CLOEXEC);
> +    assert(f !=3D -1);
> +    f =3D fcntl(fd, F_SETFD, f | FD_CLOEXEC);
> +    assert(f !=3D -1);
>  }
> =20
>  /*

--Sig_/rwhgYiVV_ui593pL0sJBdi6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkSJwgACgkQAvw66wEB28Jf9wCdEkzkfWxjbcJ1BpUwpEuD1ebM
VDYAn02VUPTG59b9dNO1W2vgVw6hbezM
=5nY4
-----END PGP SIGNATURE-----

--Sig_/rwhgYiVV_ui593pL0sJBdi6--
