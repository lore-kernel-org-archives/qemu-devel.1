Received: from eggs.gnu.org ([209.51.188.92]:37045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy3L0-0002bl-F0
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy3Kz-0003Ly-CU
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:38 -0500
Received: from ozlabs.org ([203.11.71.1]:47975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gy3Kw-0003It-Le
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:37 -0500
Date: Mon, 25 Feb 2019 10:31:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190224233142.GC7668@umbus.fritz.box>
References: <20190222055950.17403-1-richard.henderson@linaro.org>
	<a46631f2-fc78-2f06-09f0-25b2563af52d@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <a46631f2-fc78-2f06-09f0-25b2563af52d@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: Add vector opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 05:13:37PM +0000, Mark Cave-Ayland wrote:
> On 22/02/2019 05:59, Richard Henderson wrote:
>=20
> > This requires VSX, not just Altivec, so Power7 or later.
> >=20
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >=20
> > At present there are no tunables that can avoid the 64-bit element
> > load/store requirement.  As with requiring AVX1 for x86 hosts, I'm
> > not sure it's worth inventing such a tunable for pre-power7 hosts.
> >=20
> > Tested vs aarch64 risu test cases.  It's probably worth testing
> > this vs Mark's target/ppc conversion.
>=20
> Oooh this looks really exciting! However... I only have a G4 Mac Mini aro=
und that I
> use for testing which is Altivec-only :(  Is it much work to support
> non-VSX hosts?

I have access to POWER8 and POWER9 machines, but I haven't worked with
RISU before.  If you can give me a straightforward recipe I can try
running the tests.

>=20
> This leads me to a related point that came up when Howard and I were test=
ing the PPC
> vector patches - how do we know at runtime which optimisations were being=
 used, e.g.
> what is the value of have_avx2 on a particular CPU running QEMU?
>=20
> Under Linux this isn't too bad since you can just do "cat /proc/cpuinfo |=
 grep avx2"
> but it becomes more tricky when getting bug reports from Windows users wh=
o aren't
> particularly technical...
>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzKV4ACgkQbDjKyiDZ
s5K3gg/8DPYs0hcU9q1zN4q+eroCfmI5zlHQnE0PpoWFHMyGMzAXE2u6MuaveOEn
Q996j7BcM03/biG0JBti5YnpSX4UaEx6LBbnlxyswW7hg0NXRXN1Pq1SKezl0vmJ
mO/b0tWoUrflyBUjH5hWN91EgCxvYMJebLhOl3OQBBnNShP2aB+vpYsJa7TNApFA
X2HTT2Rd/BgyfIzeyRJcETLvg6pf/a6Pro7PHhwdm0Xe4o/ZcaEhW7r6dhS20UHP
4JknhDz3TllwHhS3/duPH0aBqQ+MBR6w5AA2PeqcIGq03HIMifdiEV4235WWPma1
ottOaa0dHnStyvAvVChCZUQXV2t8jOMd6/H3JfUYzA/hxZE1eCJQUKq4hqTfmejG
9n0QA+c/0lO/1PHh9dc8Y/HT1+h8zH5Lq/MgKOiHPrfed9+cuAsUIt5aDZmkvcKQ
PsK02ATMdsq0/6HckrMk853Zb6e4mtakLM/Q0wvyDD30F9nfbBClq2yB8npKxdVU
/KklX9bwOzsu7I8UAAuAJy4gJ2bx9YvR8DxsbFZB86cKopupVAAueGUxoTdu9GYg
ZWoYoHzUixoeIn3m36F9jwTIC3vx3OkwbNPe7Gg6LaObASMPT/Ecn6MQs97YSJyQ
vH1r8waDZ/vhkt9hWshqXDjQK+K1Er0c1fGsudQ1ZSaqymaOizQ=
=Gzmm
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
