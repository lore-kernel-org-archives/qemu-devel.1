Received: from eggs.gnu.org ([209.51.188.92]:57445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1ggVle-0007Mu-0D
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1ggVlc-0004Cl-Ap
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:20:37 -0500
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::1]:29590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1ggVlb-0003wE-Kz
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:20:36 -0500
Date: Mon, 7 Jan 2019 15:20:16 +0100
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190107152016.03464ee3.olaf@aepfle.de>
In-Reply-To: <20181213110525.GY18875@perard.uk.xensource.com>
References: <20181026101016.28584-1-olaf@aepfle.de>
	<20181213110525.GY18875@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/PUzmwa.URpv55AFLiE_WGv7";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1] xen: preserve COMPAT in CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Ian Jackson <ian.jackson@citrix.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

--Sig_/PUzmwa.URpv55AFLiE_WGv7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 13 Dec 2018 11:05:25 +0000
schrieb Anthony PERARD <anthony.perard@citrix.com>:

> Hi,
>=20
> Ian, we have those XC_WANT_COMPAT_* #defines to allow consumers of Xen
> libs be able to use old interfaces. Do you think it's a good idea to
> have this consumers (QEMU here) #undef the flag when it has implemented
> the newer interface?

I think the wording is wrong.

The defines exist to expose existing APIs to software that was not updated =
to use the "latest" API. To me it looks like the undef's are wrong. Even th=
e usage in configure looks bogus, but that is another unrelated thing.

Olaf

--Sig_/PUzmwa.URpv55AFLiE_WGv7
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXDNgIAAKCRBdQqD6ppg2
fu5TAKCMBBZF7gk7Qc47TVW1U8GXd7YH+gCgw8IaNuKH7wgvFE1OgbPlHGXC8XI=
=MkI/
-----END PGP SIGNATURE-----

--Sig_/PUzmwa.URpv55AFLiE_WGv7--
