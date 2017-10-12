Received: from eggs.gnu.org ([2001:4830:134:3::10]:48444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2mfp-00008G-6i
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2mfo-0000zj-0F
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:13:53 -0400
Date: Fri, 13 Oct 2017 09:24:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171012222409.GE28032@umbus.fritz.box>
References: <1507578671-158758-19-git-send-email-imammedo@redhat.com>
	<1507823408-270386-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <1507823408-270386-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 18/24] fixup! ppc: spapr: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, agraf@suse.de


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 05:50:08PM +0200, Igor Mammedov wrote:
> inot sure how it managed to compile locally and on travis

Because target/ppc/kvm.c is only compiled on a ppc _host_.

> but build fails with type mismatch on PPC host, fixup it
> by casting to expected type

I already hit this one and fixed it up in place.

>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/ppc/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 48dc3f7..9d57deb 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2505,7 +2505,7 @@ static int kvm_ppc_register_host_cpu_type(MachineSt=
ate *ms)
>      }
>      type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
>      type_register(&type_info);
> -    if (object_dynamic_cast(ms, TYPE_SPAPR_MACHINE)) {
> +    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
>          /* override TCG default cpu type with 'host' cpu model */
>          mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnf64gACgkQbDjKyiDZ
s5Ln0xAAxpfhygwPDHd6lTq7ZbFWZY8HZhBsj5okk1O7zjv71m7JJktWfaoDzKFi
tA9wRGxo9GMoY2jIGOBOD/9N8U9a4X05Ba3wgSgFoFJ9NDQJCl5KLs2rtC29qYWu
rBhY8+5LzB10LC97l2e9ld679u97LvffJy8rMDqrAmFvCNVsIfcf4Va0wfoBm7g7
aKqp0GpZXd1Y4NcdDaYosqVvvP2JcyotBzjjVCcRTd9cXr+6UTITvwcoNXi17cUw
cMwP2ANDC/mYbf1hTDNCM3hohFxO+dC6EKRT7XqHpyI9AO986oGTgcJLcIKpXdhN
/5c5Z7AtHO4z+K3B24yysQczOaHL3RB6G832cgc0IusAP4t8WCdPnEUsZc6REeTY
37H0X0RaLdTxa/CF6klvFRcdCQyzXIyMoejfAN/+k/g6tpp7ILc3Xt6YvgLraP8O
hQJo9/zoEzVv+ZTTFjod0zfqaR9my8PwicQFy8pLBAnwr7VJmdQp+xj+LY/F1cBU
nl3fIP7q5eV1VF5wj/qH6ruSSPm8u9We5ciPzSvQ9vzkohVHxBYy8wGOkWw4CQgd
QM8JthRmNV0HbPYIXlpRBtSS3qwFBp31oBVJ6fHH+NsyFsCi7EzCVdCKdcgcp4yS
72VKEJwTmWEUDqyCoJkDqwZoqltMFO9sTNtO7K3Ek7ix+JA7+Cw=
=JStO
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
