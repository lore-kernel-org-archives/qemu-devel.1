Received: from eggs.gnu.org ([209.51.188.92]:58468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gNm-0005Aj-Lp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gNl-0005eB-KS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:43:22 -0500
Date: Mon, 4 Mar 2019 16:43:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304054309.GL7792@umbus.fritz.box>
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YIleam+9adpUeYf+"
Content-Disposition: inline
In-Reply-To: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/8] target/ppc: switch fpr/vsrl registers
 so all VSX registers are in host endian order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--YIleam+9adpUeYf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2019 at 05:23:35PM +0000, Mark Cave-Ayland wrote:
> After some investigation into Andrew's report of corruption in his ppc64le
> tests at https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07234.h=
tml, I
> discovered the underlying cause was that the first 32 VSX registers are n=
ot
> stored in host endian order.
>=20
> This is something that Richard and I had discussed before, but missed tha=
t with
> VSX if you have source registers from different register sets then even l=
ogical
> operations will give you the wrong result.
>=20
> Rather than revert 7b8fe477e1 "target/ppc: convert VSX logical operations=
 to
> vector operations" let's keep the use of the accelerated vector instructi=
ons,
> and instead fix the real problem which is to switch the first 32 VSX regi=
sters
> to host endian order matching the VMX registers.
>=20
> Patches 1-5 aim to consolidate the offset calculations for both CPUPPCSta=
te
> and the associated _ptr() functions into one single place.
>=20
> With this preliminary work complete, patch 6 switches the first 32 regist=
ers
> into host endian order without too much difficulty.
>=20
> Finally now that all VSX registers are stored in the same way, the vsr of=
fset
> functions and get_cpu_vsrh()/get_cpu_vsrl() can be simplified accordingly.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I've applied the first two patches.  The rest I'll wait on a respin
addressing Richard's comments.

>=20
>=20
> Mark Cave-Ayland (8):
>   target/ppc: introduce single fpr_offset() function
>   target/ppc: introduce single vsrl_offset() function
>   target/ppc: move Vsr* macros from internal.h to cpu.h
>   target/ppc: introduce avrh_offset() and avrl_offset() functions
>   target/ppc: introduce avr_offset() function
>   target/ppc: switch fpr/vsrl registers so all VSX registers are in host
>     endian order
>   target/ppc: introduce vsrh_offset() function
>   target/ppc: simplify get_cpu_vsrh() and get_cpu_vsrl() functions
>=20
>  target/ppc/cpu.h                    | 56 +++++++++++++++++++++++++++++++=
++++--
>  target/ppc/internal.h               | 27 +++---------------
>  target/ppc/machine.c                |  8 +++---
>  target/ppc/translate.c              | 28 ++++++++-----------
>  target/ppc/translate/vmx-impl.inc.c | 27 ++++++++----------
>  target/ppc/translate/vsx-impl.inc.c | 39 +++-----------------------
>  6 files changed, 88 insertions(+), 97 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YIleam+9adpUeYf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8uuwACgkQbDjKyiDZ
s5K12g/+LR8RV7N18RcQ74f8vRabV/r3T6rGNlIEsCGJri/U09nrt5yi3Mbs1j3k
cO7yvnoELpgG6hI58ZSXTlhekUgUYAndctScgI4QKAgfY+mncoiImJ5LHWiAqPYI
Ae027Lecl5NVYrCEcQ74gpbr1Xdql/OoeZGfO/YxUWlneFEYZMzLPARgF2fsdl5l
Tf6ojeb+eI9xG/q8EnxeIhlI3g7O6CeCQ8d/Bl1MqE9AoVaEQG9Ztg7HEMLgQAz0
TeyYi8myF3pTH1lwQ8PdRJqsdCGxE13OPAUxmULl33ngFj2Jmaq2PWDmm+6f/3z8
hI3lm1w1hf1a5wjkuIDaLp4rwaWHt0TMJdPKwWdhDu0qVx4H+r3Hldapw1J+cBiR
KQWeFLBR1cnTM8fIxMp2wrnAXk+qDEukUicIrIBgxeg2z0sqRTUDM8rgvBusDGni
30AnBDzkxb3sPLVfnv85sXBNQjCDVWdkTEFPJF7lBQp+4icPBSPDVaamOl4jm9H9
dEMuFr5qAntW1/9NbY2imonjtGTHKW8QvIk4OisaupFqwH3p7m/bL5ME4NwK82bk
aK7ZPhfBoj86A9pIQdFTvZdN9cWGYNbcseFd1crRSqnIMHmsN/1C4GxRCMgnrUNS
2mEdtHgA/LExNLn5njMWOutfkyOrr6N4HenAxDA+oB2paRlmytU=
=HQ85
-----END PGP SIGNATURE-----

--YIleam+9adpUeYf+--
