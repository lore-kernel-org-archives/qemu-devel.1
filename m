Received: from eggs.gnu.org ([2001:4830:134:3::10]:54869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXQNu-00050V-3w
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXQNs-0006hF-H1
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:09:46 -0400
Date: Tue, 18 Jul 2017 16:49:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170718064926.GF3140@umbus.fritz.box>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-21-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline
In-Reply-To: <20170718061005.29518-21-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 20/29] disas: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eric Blake <eblake@redhat.com>


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 03:09:56AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc parts,

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Although.. I note that this disas stuff is pulled in from binutils /
gas.  Are local changes going to make it harder to update from there
again?


> ---
>  disas/ia64.c |  4 ++--
>  disas/m68k.c |  5 ++---
>  disas/ppc.c  | 12 ++++--------
>  disas/s390.c |  3 +--
>  4 files changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/disas/ia64.c b/disas/ia64.c
> index 140754c944..a668a49f69 100644
> --- a/disas/ia64.c
> +++ b/disas/ia64.c
> @@ -385,7 +385,7 @@ struct ia64_operand
>  /* Disassemble as unsigned decimal (instead of hex): */
>  #define IA64_OPND_FLAG_DECIMAL_UNSIGNED	(1<<1)
> =20
> -#define NELEMS(a)	((int) (sizeof (a) / sizeof (a[0])))
> +#define NELEMS(a) ((int) ARRAY_SIZE(a))
> =20
>  static const char*
>  ins_rsvd (const struct ia64_operand *self ATTRIBUTE_UNUSED,
> @@ -2857,7 +2857,7 @@ static const unsigned short dep257[] =3D {
>    2170, 2173, 2274, 2284, 2327, 4135, 20616, 28866, 29018,
>  };
> =20
> -#define NELS(X) (sizeof(X)/sizeof(X[0]))
> +#define NELS(X) ARRAY_SIZE(X)
>  static const struct ia64_opcode_dependency
>  op_dependencies[] =3D {
>    { NELS(dep1), dep1, NELS(dep0), dep0, },
> diff --git a/disas/m68k.c b/disas/m68k.c
> index 61b689ef3e..9989989e02 100644
> --- a/disas/m68k.c
> +++ b/disas/m68k.c
> @@ -4197,7 +4197,7 @@ TBL("tblunb", "tblunw", "tblunl", 0, 0),
>  {"wdebug", 4,	two(0175750, 03),	two(0177770, 0xffff), "ds", mcfisa_a },
>  };
> =20
> -const int m68k_numopcodes =3D sizeof m68k_opcodes / sizeof m68k_opcodes[=
0];
> +const int m68k_numopcodes =3D ARRAY_SIZE(m68k_opcodes);
> =20
>  /* These aliases used to be in the above table, each one duplicating
>     all of the entries for its primary exactly.  This table was
> @@ -4450,8 +4450,7 @@ const struct m68k_opcode_alias m68k_opcode_aliases[=
] =3D
> =20
>  };
> =20
> -const int m68k_numaliases =3D
> -  sizeof m68k_opcode_aliases / sizeof m68k_opcode_aliases[0];
> +const int m68k_numaliases =3D ARRAY_SIZE(m68k_opcode_aliases);
>  /* **** End of m68k-opc.c */
>  /* **** floatformat.c from sourceware.org CVS 2005-08-14.  */
>  /* IEEE floating point support routines, for GDB, the GNU Debugger.
> diff --git a/disas/ppc.c b/disas/ppc.c
> index 5ab9c35a84..337415b887 100644
> --- a/disas/ppc.c
> +++ b/disas/ppc.c
> @@ -893,8 +893,7 @@ const struct powerpc_operand powerpc_operands[] =3D
>    { 0x1, 25, NULL, NULL, PPC_OPERAND_OPTIONAL},
>  };
> =20
> -const unsigned int num_powerpc_operands =3D (sizeof (powerpc_operands)
> -					   / sizeof (powerpc_operands[0]));
> +const unsigned int num_powerpc_operands =3D ARRAY_SIZE(powerpc_operands);
> =20
>  /* The functions used to insert and extract complicated operands.  */
> =20
> @@ -5029,10 +5028,8 @@ const struct powerpc_opcode powerpc_opcodes[] =3D {
> =20
>  };
> =20
> -const int powerpc_num_opcodes =3D
> -  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
> -=0C
> -/* The macro table.  This is only used by the assembler.  */
> +const int powerpc_num_opcodes =3D ARRAY_SIZE(powerpc_opcodes);
> +/* The macro table.  This is only used by the assembler. */
> =20
>  /* The expressions of the form (-x ! 31) & (x | 31) have the value 0
>     when x=3D0; 32-x when x is between 1 and 31; are negative if x is
> @@ -5086,8 +5083,7 @@ const struct powerpc_macro powerpc_macros[] =3D {
>  { "clrlslwi.",4,  PPCCOM,	"rlwinm. %0,%1,%3,(%2)-(%3),31-(%3)" },
>  };
> =20
> -const int powerpc_num_macros =3D
> -  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
> +const int powerpc_num_macros =3D ARRAY_SIZE(powerpc_macros);
> =20
> =20
>  /* This file provides several disassembler functions, all of which use
> diff --git a/disas/s390.c b/disas/s390.c
> index 1f167d2eaa..ffa1519622 100644
> --- a/disas/s390.c
> +++ b/disas/s390.c
> @@ -1893,5 +1893,4 @@ static const struct s390_opcode s390_opcodes[] =3D
>    { "pr", OP16(0x0101LL), MASK_E, INSTR_E, 3, 0},
>  };
> =20
> -static const int s390_num_opcodes =3D
> -  sizeof (s390_opcodes) / sizeof (s390_opcodes[0]);
> +static const int s390_num_opcodes =3D ARRAY_SIZE(s390_opcodes);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlltr3QACgkQbDjKyiDZ
s5JXlw//YLa6i6IsWcOY6TKjkjxUpyDSn5ncSaXV+4VGAf1RgWvWSnV/7MxCGha7
1VadlqXYxR+iJfugsfztsWkAUy3ossbNZNkzlhJsIXxFvF7KLhjM8Q/FNYDaTs6n
oXa/axu17h5/16mWkQGY0xqOA+7HHV1UPcRvuo6GQTTnycpwcu9x69c6WfbQ/8ht
WmDf5qt5bsSfXFyqY40DcTRtl6FV4Jxt2r9RrM0pa/W0/6SYC0HQZMSY+9c3aHsf
t6Db8b8eFkM/cN/Rg7vDXj6Zt+jvGjNAXqrUKEeJF1RD6HH4d2t9QBnqZWGux/8y
Ts7C/f3C7kKmdkMl3thLwbfhXuBrVwJoY5mQaBsMsMOGF4dme8fZYK++67OMS1JP
wwvWtuD9b1jsvznYB8BfJdZ0PofoNo2AB0OkYfdnUOWx4e0vuRoP0daLzbi30Vva
vMzy4KquiGJnvEKiS0+ahMpTbtWlvIOU4W2Sky6uhr6xOjNHglVH6JvQmcGpRV2G
1A/xYhgRPBpWrW9dpZdEKKjG83Uf8T8dte563yk3axsHkEYdU5zm+qQUjoJkX/HB
RkuBbweXqZCimLoQdVpoi3Fz5BK5DAwVrYGzjhSyVg0ye0duzVLJyQK4is+w/Cf6
bCHxyeKv9tkRwOd6jqjvLbZHsTaDYvdjhux218LQPC5SvEpIQjo=
=phTV
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--
