Received: from eggs.gnu.org ([2001:4830:134:3::10]:41618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d1MOd-0005NP-4i
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 20:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d1MOb-0005to-TF
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 20:25:59 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d1MOb-0005t2-7Y
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 20:25:57 -0400
Date: Fri, 21 Apr 2017 10:24:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170421002451.GE13992@umbus.fritz.box>
References: <cover.1492721026.git.balaton@eik.bme.hu>
	<c4328880c5a143eab3e835dd9d2e2efcd86d98d1.1492721026.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <c4328880c5a143eab3e835dd9d2e2efcd86d98d1.1492721026.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v5 13/13] ppc: Add SM501 device in ppc
 softmmu targets default configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 10:43:46PM +0200, BALATON Zoltan wrote:
> This is not used by default on any emulated machine yet but it is
> still useful to have it compiled so it can be added from the command
> line for clients that can use it (e.g. MorphOS has no driver for any
> other emulated video cards but can output via SM501)
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Sure, if you like.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> v5: Added sm501 also to ppc64-softmmu default config
>=20
>  default-configs/ppc-softmmu.mak    | 1 +
>  default-configs/ppc64-softmmu.mak  | 1 +
>  default-configs/ppcemb-softmmu.mak | 1 +
>  3 files changed, 3 insertions(+)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index 09c1d45..1f1cd85 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -45,6 +45,7 @@ CONFIG_OPENPIC_KVM=3D$(and $(CONFIG_E500),$(CONFIG_KVM))
>  CONFIG_PLATFORM_BUS=3Dy
>  CONFIG_ETSEC=3Dy
>  CONFIG_LIBDECNUMBER=3Dy
> +CONFIG_SM501=3Dy
>  # For PReP
>  CONFIG_SERIAL_ISA=3Dy
>  CONFIG_MC146818RTC=3Dy
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
> index 05c8335..f6ccb1b 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -47,6 +47,7 @@ CONFIG_OPENPIC_KVM=3D$(and $(CONFIG_E500),$(CONFIG_KVM))
>  CONFIG_PLATFORM_BUS=3Dy
>  CONFIG_ETSEC=3Dy
>  CONFIG_LIBDECNUMBER=3Dy
> +CONFIG_SM501=3Dy
>  # For pSeries
>  CONFIG_XICS=3D$(CONFIG_PSERIES)
>  CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
> index 7f56004..94340de 100644
> --- a/default-configs/ppcemb-softmmu.mak
> +++ b/default-configs/ppcemb-softmmu.mak
> @@ -15,3 +15,4 @@ CONFIG_I8259=3Dy
>  CONFIG_XILINX=3Dy
>  CONFIG_XILINX_ETHLITE=3Dy
>  CONFIG_LIBDECNUMBER=3Dy
> +CONFIG_SM501=3Dy

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+VFRAAoJEGw4ysog2bOSFgIQANnZ2ehBbfjjaEZ3tv8gomJg
CzVKRNwlUkmSY0tx4hkbenqW2ob3QBYeCiU6s9HJlmEqtMcob9Khh7ATbBoWrgQa
S/VMIMqBmN/W4lrgmKJfrmG17cCe8Dm5WAHo/N+pUlF5addyCCXCLItksRygCJuX
sX5cK3vfdBzDPcjszHiGlj2fiw0/4CI6vZ6Y/+gd4YvI6sPcVjNypWZFylvsTgg8
Cw1imloOguNTB16hf2l9Zm54TA57lBs8fC2e7hpyaCbvp9d1nA68riaHBQnl73ox
/CVhe5QCDQzAQf5ZyPvIbdhR9GECQQLWl96TA8t5DZ93ImjHmSRTNBDHGnzleNyb
hkycNhTKayRPZ7VZAF8ldN/o7HWy4X9U8wPMOZzjfx/bvsOEOY8hwNaiWH3n+M8o
VdotMqntTQoU/BpFJAvbHVxGCeNCVh4JK4ArgVOGxK5GPKDhUvYfFvXbXIMiAb3d
VPg0UOd7CuvUvpfspy3Zm73/PMIoylEcuaqAVBXksFII69t5nVUF3/StFg1yAy3+
sgHRBaHYlO7mk5d1QBOaxPWDtLVsaPqtwXK7jo9UyiWl0dEhrUcjvjOB3O/b7/+A
9B7+v35eu3wX5p77EalwsvtLDJS9BcbKPi5kjJUJciA8RbktvUIOIvHgfNTuuUUB
vBtQTYBMRCIi7L8l+Zhb
=RuiQ
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
