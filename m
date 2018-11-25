Received: from eggs.gnu.org ([2001:4830:134:3::10]:55071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQpgN-0000VV-Rf
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 03:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQpgN-0000wM-3D
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 03:22:23 -0500
Date: Sun, 25 Nov 2018 19:22:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181125082210.GD2251@umbus.fritz.box>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
	<20181108121646.26173-2-david@gibson.dropbear.id.au>
	<CAFEAcA9XbnnpTKDJQMHqxfChBaKp5j71gsxUYOCo2SQXkOZ9DQ@mail.gmail.com>
	<CAFEAcA_=jkQjVbZEvNd_5wboHo2poHUwiVSC66u9v5JGQDB6cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_=jkQjVbZEvNd_5wboHo2poHUwiVSC66u9v5JGQDB6cw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 01/22] target/ppc: add external PID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Alexander Graf <agraf@suse.de>, Laurent Vivier <lvivier@redhat.com>, Roman Kapl <rka@sysgo.com>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 04:39:29PM +0000, Peter Maydell wrote:
> On 15 November 2018 at 10:22, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> > Hi; Coverity reports an issue (CID1396864) with this function:
> >
> >> +/* dcbfep (external PID dcbf) */
> >> +static void gen_dcbfep(DisasContext *ctx)
> >> +{
> >> +    /* XXX: specification says this is treated as a load by the MMU */
> >> +    TCGv t0;
> >> +    CHK_SV;
> >> +    gen_set_access_type(ctx, ACCESS_CACHE);
> >> +    t0 =3D tcg_temp_new();
> >> +    gen_addr_reg_index(ctx, t0);
> >> +    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
> >> +    tcg_temp_free(t0);
> >> +}
> >
> > It says that the gen_set_access_type() call is unreachable. I think
> > this is a false positive (the code is unreachable, but only if
> > CONFIG_USER_ONLY is defined). On the other hand, all the other
> > similar gen_* functions in this file that use CHK_SV seem to have
> > a pattern of
> >
> > #if defined(CONFIG_USER_ONLY)
> >     GEN_PRIV;
> > #else
> >     TCGv t0;
> >     CHK_SV;
> >     [etc]
> > #endif
> >
> > so maybe we should do that here too for consistency?
>=20
> I've marked the issue as a false-positive in Coverity (since it is,
> and that's what we've done with some equivalent target/ppc Coverity
> issues with other functions previously). I'll let you decide whether
> you want to prefer "with ifdefs" or "without". (TBH I think the
> "without" style is better here.)

I tend to agree, but are you ok dealing with the whole slew of
Coverity false positives it will create if we move to that style?
AFAIK, I don't have the power to deal with it from my end.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv6W68ACgkQbDjKyiDZ
s5Jpfg//ahMEgv046/BrBWw4M+AvfCXrywyPo5wi8OXh5bwUcxr5qUsiOXwSra91
TRC6XX+zBGZMlljoC3O6T0ZjXSMEEg29OUEHyvi6FxA0dvRMuBE4w0xSxZ5ztUtz
OU2ysDhTg6KkcuiyhhdaTQ6j8Tdb4nUGi4orgABZoAv4d5YbgfZewGSIgYYPba/R
TKvYg88nRf4EqW4qhHaxJYe2EomL2+CtYIzeqy8vdikzJkPGKDO1bYhGajXopi4J
IBdrAE3MdRMR55cPf2dLlxwIForEw9q9cV8XdEj2Ehh24Y+tDl04Hmwhj9aZsTpl
fov9N2k11bs3CyUKc+sysjs6hlDF5YTnNtirxgNfcgZlkyAPYSXo/afH/PggXgPJ
IHwtkM/rudm6oqln+IZ8zkxjq9HDGEowiW1O+MqpsAThDpNprTbZ/G81RLqMSUgZ
blDcYTiVl4sF92DT2HBd31U/eOq6dJC9VK/oZuGN2ff16g3UesaquzE700RTREAN
rqhsbBmUhWnmyTOFjUWH2CrdodmyBMlIweWOvj8GlW/UUAueF+pI/Ou7cwYKqH4q
90W13hmpeoRGe0T7p3AL3dRs5bUBjKnkonUp0wj97h3oeS5Bqtch4K6rgv1kithJ
6NcD6cQiVHzfmVScr6tmmVxd3UGPYq6CSuKcPYhkLQca2Sv8qJc=
=GXFU
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
