Received: from eggs.gnu.org ([2001:4830:134:3::10]:58479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxVPK-0002B2-L7
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxVPG-0008Qo-Lw
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:14:46 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:51390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cxVPG-0008OS-Ei
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:14:42 -0400
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 4C50E4ADF6
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 11:14:35 +0200 (CEST)
Date: Mon, 10 Apr 2017 11:14:25 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170410111425.634d7284@bahia.lan>
In-Reply-To: <1491562132-69066-1-git-send-email-liqiang6-s@360.cn>
References: <1491562132-69066-1-git-send-email-liqiang6-s@360.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/N3INYyxUGVIDH=sO8b_fDfg";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: xattr: fix memory leak in
 v9fs_list_xattr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: qemu-devel@nongnu.org, ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

--Sig_/N3INYyxUGVIDH=sO8b_fDfg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri,  7 Apr 2017 03:48:52 -0700
Li Qiang <liq3ea@gmail.com> wrote:

> Free 'orig_value' in error path.
>=20
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---

Good catch. I'll send a pull req later today.

Cheers.

--
Greg

>  hw/9pfs/9p-xattr.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
> index eec160b..d05c1a1 100644
> --- a/hw/9pfs/9p-xattr.c
> +++ b/hw/9pfs/9p-xattr.c
> @@ -108,6 +108,7 @@ ssize_t v9fs_list_xattr(FsContext *ctx, const char *p=
ath,
>      g_free(name);
>      close_preserve_errno(dirfd);
>      if (xattr_len < 0) {
> +        g_free(orig_value);
>          return -1;
>      }
> =20


--Sig_/N3INYyxUGVIDH=sO8b_fDfg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljrTPEACgkQAvw66wEB28L0RQCfaor7h/hxEFy40901RYUnsXiH
uxQAn1yW2aXNM6DOnbYIM7EttKsD4tvn
=oz2j
-----END PGP SIGNATURE-----

--Sig_/N3INYyxUGVIDH=sO8b_fDfg--
