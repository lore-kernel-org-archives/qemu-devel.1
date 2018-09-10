Received: from eggs.gnu.org ([2001:4830:134:3::10]:33670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDpp-000287-O2
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDm5-0005z4-7T
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:26:12 -0400
Date: Mon, 10 Sep 2018 10:46:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180910004624.GF26021@umbus.fritz.box>
References: <1536326394-6466-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline
In-Reply-To: <1536326394-6466-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc/cpu-models: Re-group the 970
 CPUs together again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 03:19:54PM +0200, Thomas Huth wrote:
> The addition of the POWER9 CPUs divided the entries for the 970 CPUs,
> which is a little bit confusing when you look at the code. So let's
> re-group the 970 CPUs together again, and since these chips have been
> based on the POWER4 processor, move them also in front of the POWER5
> chips now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-3.1, thanks.

> ---
>  target/ppc/cpu-models.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>=20
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 6c9bfde..7c75963 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -741,26 +741,8 @@
>                  "PowerPC 7457A v1.2 (G4)")
>      /* 64 bits PowerPC                                                  =
     */
>  #if defined (TARGET_PPC64)
> -    POWERPC_DEF("power5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POW=
ER5P,
> -                "POWER5+ v2.1")
> -    POWERPC_DEF("power7_v2.3",   CPU_POWERPC_POWER7_v23,             POW=
ER7,
> -                "POWER7 v2.3")
> -    POWERPC_DEF("power7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POW=
ER7,
> -                "POWER7+ v2.1")
> -    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POW=
ER8,
> -                "POWER8E v2.1")
> -    POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POW=
ER8,
> -                "POWER8 v2.0")
> -    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POW=
ER8,
> -                "POWER8NVL v1.0")
>      POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                970,
>                  "PowerPC 970 v2.2")
> -
> -    POWERPC_DEF("power9_v1.0",   CPU_POWERPC_POWER9_DD1,             POW=
ER9,
> -                "POWER9 v1.0")
> -    POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POW=
ER9,
> -                "POWER9 v2.0")
> -
>      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              970,
>                  "PowerPC 970FX v1.0 (G5)")
>      POWERPC_DEF("970fx_v2.0",    CPU_POWERPC_970FX_v20,              970,
> @@ -775,6 +757,22 @@
>                  "PowerPC 970MP v1.0")
>      POWERPC_DEF("970mp_v1.1",    CPU_POWERPC_970MP_v11,              970,
>                  "PowerPC 970MP v1.1")
> +    POWERPC_DEF("power5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POW=
ER5P,
> +                "POWER5+ v2.1")
> +    POWERPC_DEF("power7_v2.3",   CPU_POWERPC_POWER7_v23,             POW=
ER7,
> +                "POWER7 v2.3")
> +    POWERPC_DEF("power7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POW=
ER7,
> +                "POWER7+ v2.1")
> +    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POW=
ER8,
> +                "POWER8E v2.1")
> +    POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POW=
ER8,
> +                "POWER8 v2.0")
> +    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POW=
ER8,
> +                "POWER8NVL v1.0")
> +    POWERPC_DEF("power9_v1.0",   CPU_POWERPC_POWER9_DD1,             POW=
ER9,
> +                "POWER9 v1.0")
> +    POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POW=
ER9,
> +                "POWER9 v2.0")
>  #endif /* defined (TARGET_PPC64) */
> =20
>  /***********************************************************************=
****/
> @@ -940,6 +938,9 @@ PowerPCCPUAlias ppc_cpu_aliases[] =3D {
>      { "7457a", "7457a_v1.2" },
>      { "apollo7pm", "7457a_v1.0" },
>  #if defined(TARGET_PPC64)
> +    { "970", "970_v2.2" },
> +    { "970fx", "970fx_v3.1" },
> +    { "970mp", "970mp_v1.1" },
>      { "power5+", "power5+_v2.1" },
>      { "power5gs", "power5+_v2.1" },
>      { "power7", "power7_v2.3" },
> @@ -948,9 +949,6 @@ PowerPCCPUAlias ppc_cpu_aliases[] =3D {
>      { "power8", "power8_v2.0" },
>      { "power8nvl", "power8nvl_v1.0" },
>      { "power9", "power9_v2.0" },
> -    { "970", "970_v2.2" },
> -    { "970fx", "970fx_v3.1" },
> -    { "970mp", "970mp_v1.1" },
>  #endif
> =20
>      /* Generic PowerPCs */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluVvt4ACgkQbDjKyiDZ
s5LW8hAA5xQ9oS4DhHDlHGai20zhgt5yjJIy8rzhFyAo+yA6Mm0in7eNQAXESbEx
bSjFJ/je7D9Dbmzt4XXJuk8mW1RSG0g9npGtEo0vo+qIr/nn0Wo/VWS41W0aA8po
mQFfnA+2fZAtXczDFysX04C2XfYS3NXMHhgy40qvYOrkbBWX7FDm9gb+ifswd6+Y
UIT5jGFaC2KcT7h+uPlTjVNd5BpuRaZH6SYAGHCcq6OXomSB1CWM3DzxvAaGKXf9
egyw8WtLPzMkR+68Pl4sVVs0D6dSmxGTUCoODWQmVXydiHpSuEtzEaMcOhi6m/bl
smLafu/nVrGoNTrzsM/0F77uQ7OSBY3Ss4yOyZ8ZfcW6kLDbAGqFvFBl8OKyzrmc
2OhJFgEgJXkquYy60IWJ7SostXroKSff+lDys9+u2gjds0pkJuR1j+wyMudEY9YV
+n6OpOav49pA+YHZ18ikcsa8zFh2lF9B5HSPd5VzQ+USIi0XY4RfSaP6a6uOyNUF
ddYmTvhCSrWShOtXQCttjwjEjK3TcakZKOq3epDONB5d5vMTtR6p4qYv3HruBbJZ
By6Q2ZJcTja3ms/wVKNPSdvPLBLNU3Aze43bcdEJC6W7VUqNYN0nbvSsVh2cjwAZ
AQxrJXpnapY9mE9biLyixCp64M0kfWkoY1PIml9LWJ/KRYUsxBY=
=xTiD
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
