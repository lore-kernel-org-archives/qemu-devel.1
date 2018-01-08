Received: from eggs.gnu.org ([2001:4830:134:3::10]:57363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYb2P-00037q-Tm
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYb2M-0006OE-OJ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:16:41 -0500
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:42658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYb2M-0006Nx-Gz
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:16:38 -0500
Received: by mail-qt0-x22b.google.com with SMTP id g9so14473032qth.9
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:16:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bb1c8d49-c800-fe4f-4a93-ca5274a830f9@amsat.org>
Date: Mon, 8 Jan 2018 14:16:32 -0300
MIME-Version: 1.0
In-Reply-To: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="sLCzKEaffJMByuoeevMEKVm2ZrMMKgEhS"
Subject: Re: [Qemu-devel] [PATCH] configure: Fix incorrect string comparison
 operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sLCzKEaffJMByuoeevMEKVm2ZrMMKgEhS
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org
Message-ID: <bb1c8d49-c800-fe4f-4a93-ca5274a830f9@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] configure: Fix incorrect string comparison
 operator
References: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 02:10 PM, Peter Maydell wrote:
> In commit c97d6d2cdf97ed we accidentally added code to configure
> that uses '=3D=3D' for string equality testing. This is a bashism --
> the portable way to write this is '=3D'.
>=20
> This fixes the "Unexpected operator error" complaint produced
> if the system /bin/sh is dash.

Thanks :)

>=20
> Fixes: c97d6d2cdf97ed
> Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
> As an aside, it's annoying that this doesn't make configure fail;
> otherwise it wouldn't have got through my build tests.
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 56f9716..6a04082 100755
> --- a/configure
> +++ b/configure
> @@ -5076,7 +5076,7 @@ fi
> =20
>  #################################################
>  # Check to see if we have the Hypervisor framework
> -if [ "$darwin" =3D=3D "yes" ] ; then
> +if [ "$darwin" =3D "yes" ] ; then
>    cat > $TMPC << EOF
>  #include <Hypervisor/hv.h>
>  int main() { return 0;}
>=20


--sLCzKEaffJMByuoeevMEKVm2ZrMMKgEhS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpTp3AACgkQ4+MsLN6t
wN6T3g//bIjDSHnbRv10jYiTyecyMWHNNd18H0iTYKxfWFPvb1Nb87o17SUUlenV
bDdmEsQ2ytaHAKTkHMG7w8lO1cOIOfS5NXXCj2EritzyiK5ezio9aPu2TrUoqu0m
gepHkhho8Rnok0nivDcgfn/qKDz9Fwz/Fge5o037Em5RCCqdWKAOke9UD7cMdJFB
HErfaj/j9FJKHilg0n77cd+wy3drLgKh/OMHpUGkag1whT3YMJ653punFuxzrcCB
gSaybtXl06A4umUc7SgAs8xv8azvL5WI8TnTA9qR3NF80p7F6IDslJToKOGbkGfp
OTnaePHlupEglZvG8yIH7IjaU4D2fhWdRrkpIcr4YDoA4p3nYSV2QljNW/VbpZid
lMDsSxJ31E8LepB77/NIMMdyn9PoxBDZIU1J1CKcuB3T0zkpGINmgmA+mHFEsh9j
iRVPsb8eU6D41XAl+bDn0finTiRDkzCN2kw4mu3Y0OGc+V5kLS2Nbwu53GZTi7VB
FYW+tPoa2dU4I77chjgFCFp/LLbj6gMyP5FRaqQeY2ZxDf0l1YgkH71DHUoNynTa
umNvHjxjiGFlM9rvodip/ERLShFgS0+5TG2XwlMCINQ8Pi0936LiMfBt/4nB57Zk
XTq/JQ0o4Q7u15jgDfxb+gAfMhohulTLGi3d2oc1CoVAZfNrdpU=
=IfNm
-----END PGP SIGNATURE-----

--sLCzKEaffJMByuoeevMEKVm2ZrMMKgEhS--
