Received: from eggs.gnu.org ([2001:4830:134:3::10]:48019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faCAE-00026h-Qc
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faCAD-0006My-Rv
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:39:38 -0400
Date: Tue, 3 Jul 2018 13:31:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180703033156.GK3422@umbus.fritz.box>
References: <1530568927-4738-1-git-send-email-cota@braap.org>
	<20180703010348.GG3422@umbus.fritz.box>
	<20180703032257.GA29222@flamenco>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GwwLvQJ0l3HSwfoE"
Content-Disposition: inline
In-Reply-To: <20180703032257.GA29222@flamenco>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: set is_jmp on
 ppc_tr_breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


--GwwLvQJ0l3HSwfoE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 11:22:57PM -0400, Emilio G. Cota wrote:
> On Tue, Jul 03, 2018 at 11:03:48 +1000, David Gibson wrote:
> > On Mon, Jul 02, 2018 at 06:02:07PM -0400, Emilio G. Cota wrote:
> > > The use of GDB breakpoints was broken by b0c2d52 ("target/ppc: convert
> > > to TranslatorOps", 2018-02-16).
> > >=20
> > > Fix it by setting is_jmp, so that we break from the translation loop
> > > as originally intended.
> > >=20
> > > Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > > ---
> > > (I'll send this to qemu-stable (for 2.12) once it's on master.)
> >=20
> > Applied to ppc-for-3.0.  It's kind of lucky I happened to pick this up
> > on qemu-ppc - I'm not able to read that all the time.  Things will get
> > merged much faster if you CC me directly on things to go through the
> > ppc tree.
>=20
> Sorry I forgot to Cc you -- will do better next time.

Great, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GwwLvQJ0l3HSwfoE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls67ioACgkQbDjKyiDZ
s5Lp3BAAtgm+kdkbWZ2EMz5ETMvNdy8wZR9oIdzbbs81kirVDAaSK+y1GoteL9PK
8RBEqraYkKfkTDhnYP6DC6mja+uxWBkBLVC6jJvEr0Hu6dp/HDuf6TToKnkWa2Hi
sU0LDcZEsjomgiLxuWt3+yQ/gcuthcD3lesXvtotNToYkowNMXtjtvu60+wK8tRc
RsxfdFzEuQkBlKOwmK6tGr4al1UdKVbZ0dUny9BZomxqAfBn0GGVPh8XQUbgO1mw
NnAJygq/RI8xdJy+UPVJTUh1xMUbu1Cnwl9NzehDQJF8fFL2ufERVd13BrqgI48n
Glta4v9Tq7JhOEDCNspi3uRl5MvnFqAhE2zKhG5aIul1SodFg8ZvM3LW+xHyD5+S
qVHiOAm1evuw9IwaSjP7E4edyFNHcBvhAJ1S/deE7l1y1McyBoP+FlBiZeS17Cmo
jHu5CEfnhamGqTWd10aqe4crRffgl35s8pSpjZTcs/CpvNEMwDTgJGv7OXKuHL5n
dnvnfR8ssflH/Ox0iHArRno4FyT3MdQUxbZn9XWH+elzCEnLzIgOQ6Bi397gLM9l
ej5naMsaxWAQHsRdW0ib3/ihp945RuT97f1+S28XfsjaGmqWWV5vh26WSko8JJ0v
Lnys5xD5o1W+e5MmFBOFXAGd+kC5lMixxukzGuvVkkr0KVBGs84=
=oDt7
-----END PGP SIGNATURE-----

--GwwLvQJ0l3HSwfoE--
