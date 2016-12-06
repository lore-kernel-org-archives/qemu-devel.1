Received: from eggs.gnu.org ([2001:4830:134:3::10]:52054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECwM-0002Rt-Ty
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECwI-0006BY-V4
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:25:38 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cECwI-0006BJ-KG
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:25:34 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so43013080wjc.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 02:25:34 -0800 (PST)
Date: Tue, 6 Dec 2016 10:24:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206102431.GB20860@stefanha-x1.localdomain>
References: <1480991552-14360-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <1480991552-14360-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PULL V2 0/3] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: peter.maydell@linaro.org, stefanha@redhat.com, qemu-devel@nongnu.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 10:32:29AM +0800, Jason Wang wrote:
> The following changes since commit bd8ef5060dd2124a54578241da9a572faf7658=
dd:
>=20
>   Merge remote-tracking branch 'dgibson/tags/ppc-for-2.8-20161201' into s=
taging (2016-12-01 13:39:29 +0000)
>=20
> are available in the git repository at:
>=20
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>=20
> for you to fetch changes up to 9f5832d34b0c155e9538a745c80e441aed257670:
>=20
>   fsl_etsec: Fix various small problems in hexdump code (2016-12-06 10:23=
:50 +0800)
>=20
> ----------------------------------------------------------------
>=20
> Changes from V1:
> - fix coding style
>=20
> ----------------------------------------------------------------
> Andrey Smirnov (2):
>       fsl_etsec: Pad short payloads with zeros
>       fsl_etsec: Fix various small problems in hexdump code
>=20
> Prasad J Pandit (1):
>       net: mcf: check receive buffer size register value
>=20
>  hw/net/fsl_etsec/etsec.c | 4 ++--
>  hw/net/fsl_etsec/rings.c | 8 ++++++++
>  hw/net/mcf_fec.c         | 2 +-
>  3 files changed, 11 insertions(+), 3 deletions(-)
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRpHfAAoJEJykq7OBq3PINEMH/0xbayqkfM9/bsdr1+kjPECh
BObdiZ9a5YpeZehXgsy4gXGHurxqaWvt/CGvsIF3MgDvC92k1i8M4zpp3p6wCVdO
x0p9qLtf6wqooYXGEKuCzVTKv7HuhlBGlsW8W4lnfialYO5HIqT3IWS/Co2PwtBm
/lYlt43hy3O0ssyqSZCz3/jMxqZ5MLziaziVHPrwcgPFnVYRsArMaFUBd9PPCbP0
V/ZXEYNfL7/to4e0c2f7wlKqlAEHfz19S0edl9KNSzevuEoUm3HWa45E/Qp760kA
sBYcqVCfaznWJEDLg5PedOuCOckQ1WJJX8cqAPb5IC3nTv70gRBZqQt0YvAlbxo=
=wps1
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
