Received: from eggs.gnu.org ([209.51.188.92]:47666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCth-0000SX-AI
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 23:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCtf-0004OS-U3
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 23:02:13 -0500
Received: from ozlabs.org ([203.11.71.1]:38247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gzCtd-0004B6-0T
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 23:02:11 -0500
Date: Thu, 28 Feb 2019 15:01:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190228040157.GD27799@umbus.fritz.box>
References: <20190222055950.17403-1-richard.henderson@linaro.org>
	<a46631f2-fc78-2f06-09f0-25b2563af52d@ilande.co.uk>
	<20190224233142.GC7668@umbus.fritz.box>
	<bf117507-a3da-9dcd-e2c1-031312b7d89e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <bf117507-a3da-9dcd-e2c1-031312b7d89e@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: Add vector opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 04:47:30PM -0800, Richard Henderson wrote:
> On 2/24/19 3:31 PM, David Gibson wrote:
> > I have access to POWER8 and POWER9 machines, but I haven't worked with
> > RISU before.  If you can give me a straightforward recipe I can try
> > running the tests.
>=20
> From
>=20
>   https://git.linaro.org/people/peter.maydell/risu.git

And I assume build it, at which point I hit this:

$ make
gcc  -Wall -D_GNU_SOURCE -DARCH=3Dppc64 -I /home/dwg/risu/risu -g  -o risu_=
ppc64.o -c risu_ppc64.c
risu_ppc64.c: In function =E2=80=98advance_pc=E2=80=99:
risu_ppc64.c:19:25: error: dereferencing pointer to incomplete type =E2=80=
=98struct pt_regs=E2=80=99
     uc->uc_mcontext.regs->nip +=3D 4;
                         ^~
make: *** [Makefile:44: risu_ppc64.o] Error 1


I'm running on ppc64le (as I usually do nowadays), so I'm not sure if
this is due to a difference between the ppc64 and ppc64le ABIs (and
mcontext structures) or something else.

> First you need to generate the test cases.  It looks like the current
> ppc64.risu file is fairly complete, at least to some level.  So:
>=20
> mkdir ../risu-testcases-ppc64
> ./scripts/generate_all.sh ppc64.risu ../risu-testcases-ppc64
>=20
> Then record traces from real hardware to compare against:
>=20
> RISU=3D`pwd`/risu ./scripts/record_traces.sh ../risu-testcases-ppc64/*.bin
>=20
> Now compare QEMU against hardware:
>=20
> QEMU=3Dqemu-ppc64 RISU=3D`pwd`/risu \
> ./scripts/run_risu ../risu-testcases-ppc64/*.bin
>=20
> Which is all hunky dory until something fails.  At which point it's a mat=
ter of
> using qemu's -d and -dfilter options judiciously, and "objdump -b binary =
-m
> ppc64 -D foo.bin".
>=20
>=20
> r~
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3XTQACgkQbDjKyiDZ
s5JGNg/+OLFxZT4hMfZYCPFJbMJ0lBFLWGQhALP6uZX4iYBITDHy0hvAt3blKvEr
XkUkzkw3ixl1LRU45m/m6UsxNQvU39SGTXC4fSF193kmt6hV6sZCLJxZaTrt7srK
oiPbIX33/DYMkGqPA0RlKmdCy98prUjWVJf6t2klBQN6mJiMS9P2VprVdCakijpx
8qp83dd4yFGu+6hCibWkUYOCNwKyIkVjLYHTZYOnSjluDACoI9SCZnNl+MdT9Sx7
pHwZcQJXle0nooY0MvnipNtGfQ8FvMRl3KCgyoyS94z0E7bkiCITSgMugaMnSimv
S33VVwxNVeu4twaqc4BB943VGhsiXDvTdZwBjhQQ53sc0Jqh25P7U3J4WhrQtfJa
ZyxNREQ8Wt0mkM+WsXGlSm+PjKtRvOwYAYj1EMrAzd9neetml24SRnYUT/9GKUWv
Q0sFj3wRViQ6tivrpBAmQPEX7xtZU+oZzKJQTiNU0hU7vVHs7zyGexngHnYkw45N
xERuIBLAhasdnGrWFA/gj+uIcM5uOLdJpWRBb3yXSSZsQ5dWxP+SGE166+5VaVlQ
uKaW4Vosl8KIDwEORvd11dlAXRV95uq2cg4YCcvZ6jjQcp4GaR6jaMPBrY0RmBzB
NBYP2qjlRDb/T/o0MzU7mXuCi8cH28PfdAjB6CJYCqSWpDK+zoA=
=O6d/
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
