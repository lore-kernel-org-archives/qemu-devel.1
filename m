Received: from eggs.gnu.org ([2001:4830:134:3::10]:44252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSNFp-0003cr-Gn
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSNFk-0003iI-LI
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:53:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fSNFk-0003i3-Fo
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:53:00 -0400
Date: Mon, 11 Jun 2018 14:52:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180611135257.GE17756@stefanha-x1.localdomain>
References: <20180608143026.20167-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <20180608143026.20167-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 11:30:26AM -0300, Eduardo Habkost wrote:
> All of the supported build platforms documented in qemu-doc.texi
> should already support Python 2.7.
>=20
> Removing support for Python 2.6 will allow us to remove some
> compatibility modules we carry in the QEMU tree:
>=20
> * scripts/argparse.py
> * scripts/ordereddict.py
>=20
> Python 2.6 is also not receiving bug fixes upstream and is not
> supported by pylint, which makes it harder to keep the code
> compatible with both Python 2 and Python 3.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbHn65AAoJEJykq7OBq3PIu+sH/31yEtVeRkCPshhc4G9eeRX8
+x+sVq56jljoaUr0z7dEs6nHX/5yuf4VwVh50kUNr6wY2rAr980KXOLQRF2JCvyw
xdhfzilGeKIfSEcN+uyRhUrWBS4SbkEx70zueb77PDdjbnnNugDFgp1urZ8klfb/
LwCBkVZTQUUfC5c4BsUailTSMTWp9ZiVEPkH5iovXKtSOja3FI308W/H5N0YRnOM
T1ljoqikkieQjXXApeWSQQmaN+a73RgSPbfxy+OXdC6ekAIrmtVkIWgR9F7cypcU
69mnq+M2TOlP7ThVcVzx+nO/S5CsBsK+yD20jjbm3Z1jFnnhcWIUlJGUPJMjseU=
=WW+w
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
