Received: from eggs.gnu.org ([2001:4830:134:3::10]:45648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etAF6-0006g2-PI
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etAF2-0008AQ-0c
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:54:48 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:44589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etAF1-00089k-Qb
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:54:43 -0500
Received: by mail-wr0-x229.google.com with SMTP id v65so20420014wrc.11
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 02:54:43 -0800 (PST)
Date: Tue, 6 Mar 2018 10:54:40 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306105440.GB31045@stefanha-x1.localdomain>
References: <A73A3E8EE466CD4E9D22E0AD8ADEE00949DEB635@DGGEMA503-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <A73A3E8EE466CD4E9D22E0AD8ADEE00949DEB635@DGGEMA503-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] Question: qemu crashed for re-entry of
 bdrv_drain_recurse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "fuweiwei (C)" <fuweiwei2@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Xieyingtai <xieyingtai@huawei.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "Subo (A)" <subo7@huawei.com>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 07:57:42AM +0000, fuweiwei (C) wrote:
> We find a problem of reentrant of bdrv_drain_recurse() of the same bs, wh=
ich makes
> Qemu assertion failed at
>=20
>      assert(!bs_->wakeup);
>=20
> in BDRV_POLL_WHILE.
>=20
> To construct the problem, we do block-commit job (or others) while fillin=
g the space in host
> file-system to make it full. The VM should be automatically paused and at=
 the same time, the
> block-commit job is completed. We get the following stack.
>=20
> We can see in #24 calls bdrv_drain_recurse, and polls a bh of commit_comp=
lete, which reopen
> the image and calls bdrv_drain_recurse again.
>=20
> How to solve this problem?

Thanks for the email.  I have posted a patch and CCed you.  Please test
it and let us know if it solves the issue.

Stefan

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJannNwAAoJEJykq7OBq3PIOxMH/1/Dc6b0wqCtzNYm+2Us5R6U
mxY2LYkn/unvI1zf9PCxAdxDuVXg4yuunLM/i08yGYNialyquOgsMXrH1Vr0g6mp
wrIWuDl7x2+D0I82oZwwbIncdUYyIU1V0xMT0gEXyrQHRFmCWIMTjKTwE64jMM5u
ETVTpw7EsUa4DOwscXsN1w18+Zgyfzd7IlPQsl3gK7My1DNqNqMy95cLp1wkJANQ
Yu0S5QhCJhStBlqbdH77FEEdwLcmqQbHTMcDOXFw8OVO9IA35RIYt2IkEmr4rRI4
/sKPDZdxPwaO5c+UvxZFSdD2anFJ9fNRgDOJZYCoI2HkoxZuuYjPkMzOPiV9K1M=
=wZga
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
