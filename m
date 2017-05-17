Received: from eggs.gnu.org ([2001:4830:134:3::10]:50626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAyd2-0002Xh-Uv
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAycz-0001Jy-Pl
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:04:36 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAycz-0001Jq-HS
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:04:33 -0400
Received: by mail-wr0-x22e.google.com with SMTP id l50so9087054wrc.3
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 06:04:33 -0700 (PDT)
Date: Wed, 17 May 2017 14:04:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170517130428.GH8260@stefanha-x1.localdomain>
References: <alpine.DEB.2.10.1705161157280.4103@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1705161157280.4103@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] [PULL 0/4] please pull xen-20170516-tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: peter.maydell@linaro.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2017 at 12:19:26PM -0700, Stefano Stabellini wrote:
> The following changes since commit cdece0467c00007cf8e3f4b3c3f0b13bf2c4fe=
a9:
>=20
>   block/win32: fix 'ret not initialized' warning (2017-05-16 15:34:18 +01=
00)
>=20
> are available in the git repository at:
>=20
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170516-=
tag
>=20
> for you to fetch changes up to 01cd90b641e1aed40cf13a577e6a737af94d55e7:
>=20
>   xen: call qemu_set_cloexec instead of fcntl (2017-05-16 11:51:25 -0700)
>=20
> ----------------------------------------------------------------
> Xen 2017/05/16
>=20
> ----------------------------------------------------------------
> Anthony PERARD (1):
>       configure: Remove -lxencall for Xen detection
>=20
> Stefano Stabellini (3):
>       xen/mapcache: store dma information in revmapcache entries for debu=
gging
>       xen/9pfs: fix two resource leaks on error paths, discovered by Cove=
rity
>       xen: call qemu_set_cloexec instead of fcntl
>=20
>  configure                     |  2 +-
>  exec.c                        |  8 ++++----
>  hw/9pfs/xen-9p-backend.c      |  4 +++-
>  hw/i386/xen/xen-mapcache.c    | 15 ++++++++++-----
>  hw/xen/xen_backend.c          |  2 +-
>  include/sysemu/xen-mapcache.h |  5 +++--
>  6 files changed, 22 insertions(+), 14 deletions(-)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHEpcAAoJEJykq7OBq3PI1ocH/RVhG+1o8+dUzhFJ8EeH2ph4
XSfBy05auKHYt3zA3wqIniXTJyCM0NDKe5eCd/4QTe/PMNYl251XR7FbrspLXyLX
O1JwGtFO71yzi5YuHFIIvPije0jOwrGk8IfQ1Qch4r5AAPcOzUP2G2c8ryyDaTev
FDQ7H0ljr5mCRmQxHcvAuHvq+UTvODO1J0GBcT6uR7/jMko73shD+xI5BXTtfWyf
zYQ4jYE/k8zUB0FOu2jPU7+B307mk07KfwUc02jknsxA0vJ1uU2IIALnJLgSkn/x
es5EAYujx5PcrDmSqXLmdgh55fmp0ZplaeMSKPPDMz/PlN5aCjrlhRJeHCOo1cI=
=2H6F
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
