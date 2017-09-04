Received: from eggs.gnu.org ([2001:4830:134:3::10]:33966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1doqqD-0007ay-70
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1doqq6-0005kY-IQ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:50:59 -0400
Date: Mon, 4 Sep 2017 21:10:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170904111054.GB2735@umbus.fritz.box>
References: <1504099475-241036-9-git-send-email-imammedo@redhat.com>
	<1504103170-259479-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <1504103170-259479-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 9/8] fixup! ppc: remove non implemented
 cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2017 at 04:26:10PM +0200, Igor Mammedov wrote:
> only TODO escaped defines were meant to be removed,
> but not TODO_USER_ONLY which are compiled in case of
> *-user targets.
>=20
> So retirn back "440" model removed by mistake
>=20
> Spotted-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

I've applied patch 8 with this change folded in, so as not to break
bisect.

> ---
>  target/ppc/cpu-models.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 611fc1b..08fb34b 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -150,6 +150,10 @@
>      POWERPC_DEF("x2vp20",        CPU_POWERPC_X2VP20,                 405,
>                  NULL)
>      /* PowerPC 440 family                                               =
     */
> +#if defined(TODO_USER_ONLY)
> +    POWERPC_DEF("440",           CPU_POWERPC_440,                    440=
GP,
> +                "Generic PowerPC 440")
> +#endif
>      /* PowerPC 440 cores                                                =
     */
>      POWERPC_DEF("440-xilinx",    CPU_POWERPC_440_XILINX,             440=
x5,
>                  "PowerPC 440 Xilinx 5")

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmtNL4ACgkQbDjKyiDZ
s5LPYg/+Nn3sUAGmao/89e2w1rVyNZzsPI2NGS8cdGPXLRW8J8rkePrt/qVY2I8p
JPswCg3IP1ikDBkSJCwOpPU5S+iZeWbiUpVrMa9DR3Ph8qgxXNyiBc19eYEDy3WL
ZG3YXfmQJYFTU/Bkpm5kXEuDgW57/hHfH0IFvIgjx5w3OLfOl8YaI1Mbq0tN2wTq
rWG1+oJeApHpGdWZ6CZ/aH4bJoA1AeIJ3j01DK27aOwyLR/1htnxjdJFIcCnnh5/
Q1tii7WQfY/lgohLDpgfdPJAfA6Ge0ccRUDV1rJlQVE68CXKF5Cd8qQpCdSP+zI5
K3hr/TyDW7aBe0s3OxYorG/owlqihE99/6cg5KRtvP6pLLXY2Uyi0VQMV3PeFArr
RGMrDjN8+QnXMOepFi0juvAFGMVmZkkb0OUQIM591THkjVsTZePlLrp4++FwiL+/
WYNTAhWQXv2q+dXg8VBqhZ0WLQsyqpg8yJwrDmE0hckwSqL5lJF99oLl17uWG0P8
rbxM1S+PmyJYg2vyt4LFr0XVzmBKVKX9+CuDNzwAJG36KT41GC1v6vytg7qOQgqJ
comczsZLS8/hV+XNvlvkp7FPYWzAZoTaZ2WUmXkK9X70231Wr6ST+z85wmKTcIRY
Lmh9+BQ+FE945BbLUO+U9DmwoBr8lCqgRC/JEc6ZbbbHiIaXOls=
=Zhj/
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
