Received: from eggs.gnu.org ([2001:4830:134:3::10]:58674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpG9i-0008Ce-6S
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpG9c-0003jd-Ty
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:52:50 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:46646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpG9c-0003is-N7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:52:44 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 249FBAAEB8
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 17:52:42 +0200 (CEST)
Date: Tue, 5 Sep 2017 17:52:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170905175239.312d6e9f@bahia>
In-Reply-To: <20170905153833.14118-1-groug@kaod.org>
References: <20170905153833.14118-1-groug@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/_XzG=nJocF.L/vs0aNsrh7P";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 0/4] 9pfs/virtfs patches for 2.11 20170905
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

--Sig_/_XzG=nJocF.L/vs0aNsrh7P
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Peter,

You can ignore this pull request, I hadn't realized that Zhipeng's patch has
an ill-formed Signed-off-by tag:

Signed-off-by: Zhipeng Lu lu.zhipeng@zte.com.cn

The missing <> around the email address breaks the dialog between git send-=
email
and the mail relay... I'll fix that and send a v2.

Cheers,

--
Greg

On Tue,  5 Sep 2017 17:38:29 +0200
Greg Kurz <groug@kaod.org> wrote:

> The following changes since commit 53e2c48d3f0db6a1598f49baf0b56dd4975e53=
a7:
>=20
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' =
into staging (2017-09-04 18:53:46 +0100)
>=20
> are available in the git repository at:
>=20
>   https://github.com/gkurz/qemu.git tags/for-upstream
>=20
> for you to fetch changes up to 449bdbfa5463fb5ef79ebb69219e0e58183a6d9c:
>=20
>   virtfs: error out gracefully when mandatory suboptions are missing (201=
7-09-05 14:01:16 +0200)
>=20
> ----------------------------------------------------------------
> Some trivial fixes/cleanup and a fix to cause QEMU to error out gracefully
> instead of aborting.
>=20
> ----------------------------------------------------------------
> Greg Kurz (2):
>       9pfs: local: clarify fchmodat_nofollow() implementation
>       virtfs: error out gracefully when mandatory suboptions are missing
>=20
> Philippe Mathieu-Daud=C3=A9 (1):
>       9pfs: avoid sign conversion error simplifying the code
>=20
> ZhiPeng Lu (1):
>       fsdev: fix memory leak in main()
>=20
>  fsdev/virtfs-proxy-helper.c |  2 ++
>  hw/9pfs/9p-local.c          | 12 ++++++++----
>  hw/9pfs/9p.c                |  6 ++----
>  vl.c                        | 16 ++++++++++------
>  4 files changed, 22 insertions(+), 14 deletions(-)


--Sig_/_XzG=nJocF.L/vs0aNsrh7P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWa7IRwAKCRAC/DrrAQHb
wooSAJ4kxUCIhrRghecUtjkWzQQ3L3tu9gCeNdB3avSLJuBhb1siQmjqx/zIkJ0=
=SRRt
-----END PGP SIGNATURE-----

--Sig_/_XzG=nJocF.L/vs0aNsrh7P--
