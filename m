Received: from eggs.gnu.org ([2001:4830:134:3::10]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cp463-0001Ly-4D
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 22:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cp462-0005QF-0D
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 22:27:59 -0400
References: <20170317152412.8472-1-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <64e3466a-58e9-4720-e158-27227bc69d2f@redhat.com>
Date: Sat, 18 Mar 2017 03:27:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170317152412.8472-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xMD4PsxH0dj5KgIbO2oN4CKGOFIdJaUBu"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] curl: fix compilation on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xMD4PsxH0dj5KgIbO2oN4CKGOFIdJaUBu
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org
Message-ID: <64e3466a-58e9-4720-e158-27227bc69d2f@redhat.com>
Subject: Re: [Qemu-block] [PATCH] curl: fix compilation on OpenBSD
References: <20170317152412.8472-1-pbonzini@redhat.com>
In-Reply-To: <20170317152412.8472-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 17.03.2017 16:24, Paolo Bonzini wrote:
> EPROTO is not found in OpenBSD.   We usually use EIO when no better
> errno is available, do that here too.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--xMD4PsxH0dj5KgIbO2oN4CKGOFIdJaUBu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljMmyQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0VoIAKMviXvGHZFT6qmUU++o66WtlBijMpK9
bQEQAn2Gjfc8o3+PhC0TNsIp1YYY7LPDjrwELhL5wr9cDfMo/iUWBCSlPMrjj54r
ELSncqE6b00j5Yise4VikSJzTwQhJLay4HopBYGtdp1jBMZ0W4xznFL4A5JaAYiD
nxdSWMafXSiZGuB3uDvKPGx98NwbuOeI85Vh+PXqkntPf1qh9e8dctFdqE+tgoBF
eyPNf31wbGUG8/tSHGeOOsAJNvqB2etR7qFfE88km1X0Zhgef6xTvsnAX75k9rt2
pRxo+/Tf8jjG0FXq9PrctXPMv53wnVDp98eheIYZdBXWsbVa18KDom4=
=hMnI
-----END PGP SIGNATURE-----

--xMD4PsxH0dj5KgIbO2oN4CKGOFIdJaUBu--
