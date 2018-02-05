Received: from eggs.gnu.org ([2001:4830:134:3::10]:45266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimSv-0005BE-Kv
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimSr-0005JB-Nq
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:30:09 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimSr-0005Io-HY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:30:05 -0500
Received: by mail-qk0-x242.google.com with SMTP id 15so5788696qkl.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:30:05 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180205150426.20542-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7d26c4fc-1b4d-c841-6be6-7d94e879bc38@amsat.org>
Date: Mon, 5 Feb 2018 16:29:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180205150426.20542-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="hcdQmPwbcmruNwTBBcKvPKmpHx8uEwAUf"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Allow PC to be set
 on command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hcdQmPwbcmruNwTBBcKvPKmpHx8uEwAUf
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, patches@linaro.org
Message-ID: <7d26c4fc-1b4d-c841-6be6-7d94e879bc38@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Allow PC to be set
 on command line
References: <20180205150426.20542-1-peter.maydell@linaro.org>
In-Reply-To: <20180205150426.20542-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2018 12:04 PM, Peter Maydell wrote:
> The documentation for the generic loader claims that you can
> set the PC for a CPU with an option of the form
>   -device loader,cpu-num=3D0,addr=3D0x10000004
>=20
> However if you try this QEMU complains:
>   cpu_num must be specified when setting a program counter
>=20
> This is because we were testing against 0 rather than CPU_NONE.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've also noticed that you can't use this to specify that
> the starting address should be in Thumb mode for Arm CPUs,
> but I'm not so sure of the right way to fix that...

Can using an impair addr work? (no arch-specific parser)

>=20
>  hw/core/generic-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index 46012673c3..cb0e68486d 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -105,7 +105,7 @@ static void generic_loader_realize(DeviceState *dev=
, Error **errp)
>              error_setg(errp, "data can not be specified when setting a=
 "
>                         "program counter");
>              return;
> -        } else if (!s->cpu_num) {
> +        } else if (s->cpu_num =3D=3D CPU_NONE) {
>              error_setg(errp, "cpu_num must be specified when setting a=
 "
>                         "program counter");
>              return;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


--hcdQmPwbcmruNwTBBcKvPKmpHx8uEwAUf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4sLcACgkQ4+MsLN6t
wN71mRAAnGS17m1l8cZl5Lk2XCBgyCpvnJ0hQmUvhAXUoaDsrc7C5M6ya7cl25Ta
0c3IQLWddQS/IJX3RzOto1DVLFT7HLMUAKHCCLQEta9HvJisQkChKy6pvZYt//Sf
1ZcsLGBpfd4x9OmkzVgG092fsYAULCaCJYYRTNLxpkLGp7xBksJCn0pNKE2tuEBC
vAZkvJ2aMld1NlkYA05Sc1BRr9BjFkgrQaY0AcyOYONKVFAFKiygnRqB6UhtlzSr
pRcLYBD2nmSSptt56WcyRYJUMgL9VCPXbIWnKM9Aiz/p8WO1Lg/h4hUg/lqikbXn
ET2/HDfe+XBGrCNWhpC83RWwXUgtDk4YQCqN+jjA244WuUrK0cxT91m3hXMe0SgR
rXaHGsnSRi9XkRZ3kPAGJC4bzi2WzSjSMA7uOuNe8DL6e6qBPZwFf6lXL9XeZWBo
sEtADE9xXM81Ot2gjP81pej+tN7QK/rfZSgrCdQSHBEzOR5+DNkBQaKoVYZgnlAh
eaFaGFogAwoKU9Q66awOFolkEJL0KqagXn5hBKOU7AkPWKz4bm332xLg5pZ83Yl+
GpPG20S52Vdc0v3GP3oFzvZMO6ur/JY3bwqDl61suMNbWMEZOwwzirqMqYEdP3Ew
NzBkw4e24KlX3mEhmHBE531tQsFLa8WDeBArNurh+EFzKP/T0VE=
=q/wQ
-----END PGP SIGNATURE-----

--hcdQmPwbcmruNwTBBcKvPKmpHx8uEwAUf--
