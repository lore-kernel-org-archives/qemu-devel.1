Received: from eggs.gnu.org ([209.51.188.92]:38778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2351-0002z5-39
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234z-0002w2-T2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:38 -0500
Date: Fri, 8 Mar 2019 10:38:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307233844.GW7722@umbus.fritz.box>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hc4757KF+wLS/WHK"
Content-Disposition: inline
In-Reply-To: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] target/ppc: switch fpr/vsrl
 registers so all VSX registers are in host endian order
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


--hc4757KF+wLS/WHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 06:05:13PM +0000, Mark Cave-Ayland wrote:
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

Series applied to ppc-for-4.0, thanks.

>=20
> v2:
> - Rebase onto master
> - Rework patchset set based upon av64_offset()/vsr64_offset() as suggeste=
d by
>   Richard, rather than using separate low/high accessors
>=20
>=20
> Mark Cave-Ayland (7):
>   target/ppc: introduce single fpr_offset() function
>   target/ppc: introduce single vsrl_offset() function
>   target/ppc: move Vsr* macros from internal.h to cpu.h
>   target/ppc: introduce avr_full_offset() function
>   target/ppc: improve avr64_offset() and use it to simplify
>     get_avr64()/set_avr64()
>   target/ppc: switch fpr/vsrl registers so all VSX registers are in host
>     endian order
>   target/ppc: introduce vsr64_offset() to simplify get_cpu_vsr{l,h}()
>     and set_cpu_vsr{l,h}()
>=20
>  target/ppc/cpu.h                    | 51 +++++++++++++++++++++++++++++++=
+++---
>  target/ppc/internal.h               | 27 +++-----------------
>  target/ppc/machine.c                |  8 +++---
>  target/ppc/translate.c              | 20 +++------------
>  target/ppc/translate/vmx-impl.inc.c | 27 ++++++++------------
>  target/ppc/translate/vsx-impl.inc.c | 39 +++-------------------------
>  6 files changed, 75 insertions(+), 97 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hc4757KF+wLS/WHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBq4MACgkQbDjKyiDZ
s5JX6xAA4Q+yS+5T1VUBo3jMreY6yUHgV+mTu7sM+sS/wcJUK22fBOoL2U/QUTw6
WgR6PWCA2qgKfYspOxftePLwvD0n/DCt8A542gywV8AwPahUT2p2nGGV7O2bxXcX
3013wcYf1wRDbo6XceyrZlHcN9PK/bs4gFmS0J/Pme9ZqH8GaOddhyhdfHtmpSd4
nqh9C79NxJTabtiMf+Nx2xHTA6qPXa6fZLbD66l7T1xtPK4cj1HLX6xJyIvuqGyW
AfRq1LIX7lq/q4uSjTZiY46yodQTKASiQVM70fRNHZYu06aaPujxoF8VAvzf/rce
RcPFNSdP1mt4urf7Hq+UHS+3zEPLRDhd6hCCGocz6y1366r45I2f2wvoA0+EoFa1
V6q5B4n5b/tsc7w86BCSaJk0NzGRKS5qsRMfiDa0pE8KdZDyLIkhf8o15BgX20/I
Ts87mLgfAVmWG2TjSMTXMGyuTOUby/5MqAb4ibfRuN1adbUDsw+UZjU/u9FZgtgu
FviJ2n9v+T7q5R87p9vw1Jnzj+3o1ookkEgiz9JyAhVaKfMdFa3N4Tt0AYXViHsL
gFF07fnHLEirt00rex/Ccjxgl6SZmH/xj733+aITc94NVuzZ7EUo8iibs4i7AuKp
hjPWycCHOP355pCzRLQKb0J9TUTXgixM86hgcOnllBZcE5GGhcA=
=osgP
-----END PGP SIGNATURE-----

--hc4757KF+wLS/WHK--
