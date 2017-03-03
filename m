Received: from eggs.gnu.org ([2001:4830:134:3::10]:54338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjee8-0001Kn-H3
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjee5-0002lq-A3
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:16:48 -0500
Date: Fri, 3 Mar 2017 14:52:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170303035216.GQ4067@umbus.fritz.box>
References: <1488463829-26839-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<18786e9b-277c-2a66-1662-55a9325a9d2c@twiddle.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ItYuPQ2o89VkWXjV"
Content-Disposition: inline
In-Reply-To: <18786e9b-277c-2a66-1662-55a9325a9d2c@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: rewrite f[n]m[add,
 sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--ItYuPQ2o89VkWXjV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 02:31:38PM +1100, Richard Henderson wrote:
> On 03/03/2017 01:10 AM, Nikunj A Dadhania wrote:
> > +static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
> > +                                        float64 arg2, float64 arg3,
> > +                                        unsigned int madd_flags)
> >  {
> > +    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) =
||
> > +                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))=
) {
> >          /* Multiplication of zero by infinity */
> > +        arg1 =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
> > +    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status=
) ||
> > +                        float64_is_signaling_nan(arg2, &env->fp_status=
) ||
> > +                        float64_is_signaling_nan(arg3, &env->fp_status=
))) {
> > +        /* sNaN operation */
> > +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
>=20
> Are you sure you shouldn't be testing for NaN first?
> Do you really get VXIMZ if arg3 (the addend) is (S)NaN?
>=20
> You should probably eliminate QNaN as well, before the other checks.

Oh.. I've already merged and pull requested this.  I'm afraid any
further corrections will have to be done as followup patches.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ItYuPQ2o89VkWXjV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYuOhuAAoJEGw4ysog2bOSljAQALhB+gRv6JoOO65W/aX7kPJU
2+ogLfE0AdTP9f3lS7AunwZRg9GoF4f3vSDNm21MqKmgDIdKqyfLintnwNP3sUYj
hdQZ0D02AIn3CtUIqSgy06RqC8AIRF2kMYAh3Tf8JHBq+j2MqbzxG0Pr3Ai4yBp6
0tX5AUHyBx5/V4LIXRV4NsA+fNUc7au/ceBHAU7Ndp9cWbo9Dz4YHPpKCVMUoxW7
b54YpOK+G3UELaAWBBelu/ynFeGtI07NdpJLCM+tnwT33KbhT11V/cf6/V3RLX+b
1BNUZ8NTFduVd8nKFc5t+fMwWdUzyKGdm78G14NrDCaFgEOfDXxMrsOXkuh7GC0N
q1ayopX5vx3HSYlswELlhQaXVVHGfxM312SOC/GKx4KyRM9sH3ok0v26DvAlkmWQ
JRo1guvSxowdm5A2OGJXV2K+qO/5B09h0v8y/LoVfOinp8tJt9iaJo2JiT2mlQiM
mB72aruFkiBA0nwzb/BAFOa0BATZJYjUr0MkD3EDMxDRVbvL13BcFAly7EeJN75k
53LPVwBFRq0bIWEqdOVy3xUUGRlrSdOJKMOFu973lzPCLgVc6KkH8davj8rCdnht
I8XbfDNDXHBiNELzVWTakiwZnt+qxA7SUXyYEqqSOL5jFtab58H1pBTUQaVU+yvg
TDe6vrQwDHCgxlxwMehs
=4RRJ
-----END PGP SIGNATURE-----

--ItYuPQ2o89VkWXjV--
