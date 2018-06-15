Received: from eggs.gnu.org ([2001:4830:134:3::10]:44988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTfzW-0008Mz-FD
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 00:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTfzS-0007Yv-8P
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 00:05:38 -0400
Date: Fri, 15 Jun 2018 13:40:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615034033.GP4129@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
	<20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
	<ea3044c2-d8cd-d41d-91a6-5d78bff86e76@linaro.org>
	<20180615000020.2a3372a5@bahia.lan>
	<20180615014501.GI4129@umbus.fritz.box>
	<9a1e00ab-5b80-0402-4335-cc340ba6b582@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uQ3BaAlxDi9XKvis"
Content-Disposition: inline
In-Reply-To: <9a1e00ab-5b80-0402-4335-cc340ba6b582@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR
 values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--uQ3BaAlxDi9XKvis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 05:38:16PM -1000, Richard Henderson wrote:
> On 06/14/2018 03:45 PM, David Gibson wrote:
> >>> To wit, the instructions are recognized and transactions always fail.=
  Which is
> >>> not a bad way to test the required fallback paths that rarely fail on=
 hardware.
> >>>  ;-)
> >>
> >> If TM instructions don't cause an exception, I guess its reasonable to=
 say
> >> they're supported :)
> >=20
> > That argument has come up before, and I disagree.  I don't think it's
> > reasonable to advertise TM support as available if the instructions
> > always fail.
>=20
> Is it possible to turn it on from the command-line?

Not at present.. attempting to is what gives the error message
discussed above.

> Like one can with -cpu foo,+opt on x86 or -cpu foo,opt=3Don on s390?
>=20
>=20
> r~
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uQ3BaAlxDi9XKvis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjNSwACgkQbDjKyiDZ
s5J7cw//bu5If5BfdPqFamSdFtctHCZoo/wty8IEm5ROdV/boKHzItsor9x/JNyx
fWQ9MuDTnIPfVKP8fj3K/kgaNY7wRGU0/AwkKsBCsHn0+PN41Kl1tt666Axszsmc
LuTMM7QuCBxa+L7xIpUMQBEbQSw6paIlfaWnIkyq+2AVV0hi+1rtf0edpXqPYkvQ
DQm5FSkTNlD5XAuI7CVXu1MgmunnZyFFI3vjRM7CDHakJTwGa05yjsyCNxo85Hny
294iA1jJ3iwrpgdB/7iYeX5Km6DMoxPSgFTleKqofyjoeGN1MGi5ItaBKR3hnMay
Y0SOfFT213laT3+8qkZsBZUURe3JEPM3qDECIsbXnZloZlrpwGuFJO5N2pDWbcBq
nTEydqUDuAIFx+sgxYqQ/xgUBqa9Q8/J9WNXJcE0p6uIs+6qFZG+7JpeMwP6DB4G
CxOGjvrGttEcyNrpRygkYAS0p3sDiyMuk4rMgS01Yt1qRm0l+wZYB7Bbzjywag6t
5aJGyXWpUV59tlRCPGC3vtP4sxPLP2P62pBNJ0TiWsvI5cxEnyYD841wMFU7dH+o
Ur+zY4A9PF6u66WvHdFFkMZMJ4/Nu9RSVOyHo2zw+NIM8080qH2TGcBoc4VlB8cE
jrm8uYBgxixx+LXUQ/ePtxc2sjQHtwNbIwwY+MLrbsBaOuxrhcE=
=JbUN
-----END PGP SIGNATURE-----

--uQ3BaAlxDi9XKvis--
