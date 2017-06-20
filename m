Received: from eggs.gnu.org ([2001:4830:134:3::10]:35725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNDtf-0004Q7-4M
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 03:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNDtc-0000nh-33
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 03:48:23 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:57019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNDtb-0000nO-SE
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 03:48:20 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id BE4494DB8B
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 09:48:16 +0200 (CEST)
Date: Tue, 20 Jun 2017 09:48:12 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170620094812.3cb41fc6@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170619205952.8601-1-brogers@suse.com>
References: <20170619205952.8601-1-brogers@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/DXPll_r6kEryEEGpTD2qmFv";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: local: remove: use correct path
 component
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

--Sig_/DXPll_r6kEryEEGpTD2qmFv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jun 2017 14:59:52 -0600
Bruce Rogers <brogers@suse.com> wrote:

> Commit a0e640a8 introduced a path processing error.
> Pass fstatat the dirpath based path component instead
> of the entire path.
>=20

Good catch. Thanks!

Pushed to https://github.com/gkurz/qemu/commits/9p-next

> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  hw/9pfs/9p-local.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 1e78b7c9e9..83952eff0a 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1100,7 +1100,7 @@ static int local_remove(FsContext *ctx, const char =
*path)
>          goto out;
>      }
> =20
> -    if (fstatat(dirfd, path, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
> +    if (fstatat(dirfd, name, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
>          goto err_out;
>      }
> =20


--Sig_/DXPll_r6kEryEEGpTD2qmFv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllI0zwACgkQAvw66wEB28KCMACfbh2yZ0DQII/1WutdpZoybACn
vhcAn1tFixhdmIDvayEoLTB8sFFlhvp0
=gNxr
-----END PGP SIGNATURE-----

--Sig_/DXPll_r6kEryEEGpTD2qmFv--
