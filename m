Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2DC33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B635620692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TzGwIozM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B635620692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0kA-0004YT-90
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 21:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip0ie-0002dD-GO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip0id-0007gT-1V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:05:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39365 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip0ic-0007ed-Bn; Tue, 07 Jan 2020 21:05:10 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ssyV5j43z9sS3; Wed,  8 Jan 2020 13:05:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578449106;
 bh=G/8ZO79i8I8MSGC1a+NeZazity1CH5fUjPjznyHl9Tc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TzGwIozM0ZdbE9fDt/pllhCzhXW5YMVgZR0zXSwIFnYtg8uPS8jn+JcmS8W7XICsw
 /+zy6yrQk67DYtTRXPX2zHX6YUlqwjKYqB/crFmGCwLJsQuwhKM2Jd00bK1Kw24+KN
 Br/Ni9x1EXHP6UAuNKSQYj3nlb8ZghHjhHJXacHU=
Date: Wed, 8 Jan 2020 12:08:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 02/10] ppc: Remove stub of PPC970 HID4 implementation
Message-ID: <20200108010850.GJ2137@umbus.fritz.box>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-3-david@gibson.dropbear.id.au>
 <20200107183215.09ce18c6@bahia.lan>
 <20200107183638.1c84f172@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
Content-Disposition: inline
In-Reply-To: <20200107183638.1c84f172@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 qemu-ppc@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 06:36:38PM +0100, Greg Kurz wrote:
> On Tue, 7 Jan 2020 18:32:15 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Tue,  7 Jan 2020 15:48:19 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > The PowerPC 970 CPU was a cut-down POWER4, which had hypervisor capab=
ility.
> > > However, it can be (and often was) strapped into "Apple mode", where =
the
> > > hypervisor capabilities were disabled (essentially putting it always =
in
> > > hypervisor mode).
>=20
> Isn't it supervisor mode instead of hypervisor mode ?

No; hypervisor is correct.  If the cpu was always in supervisor mode,
the boot OS couldn't access the hypervisor privileged registers that
are needed for basic setup (e.g. SDR1).  "Apple mode" means the cpu
doesn't have a supervisor mode that _isn't_ hypervisor privileged and
hence, can't run guests.

>=20
> > >=20
> > > That's actually the only mode of the 970 we support in qemu, and we're
> > > unlikely to change that any time soon.  However, we do have a partial
> > > implementation of the 970's HID4 register which affects things only
> > > relevant for hypervisor mode.
> > >=20
> > > That stub is also really ugly, since it attempts to duplicate the eff=
ects
> > > of HID4 by re-encoding it into the LPCR register used in newer CPUs, =
but
> > > in a really confusing way.
> > >=20
> > > Just get rid of it.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > >  target/ppc/mmu-hash64.c         | 28 +---------------------------
> > >  target/ppc/translate_init.inc.c | 17 ++++++-----------
> > >  2 files changed, 7 insertions(+), 38 deletions(-)
> > >=20
> > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > index da8966ccf5..a881876647 100644
> > > --- a/target/ppc/mmu-hash64.c
> > > +++ b/target/ppc/mmu-hash64.c
> > > @@ -1091,33 +1091,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ul=
ong val)
> > > =20
> > >      /* Filter out bits */
> > >      switch (env->mmu_model) {
> > > -    case POWERPC_MMU_64B: /* 970 */
> > > -        if (val & 0x40) {
> > > -            lpcr |=3D LPCR_LPES0;
> > > -        }
> > > -        if (val & 0x8000000000000000ull) {
> > > -            lpcr |=3D LPCR_LPES1;
> > > -        }
> > > -        if (val & 0x20) {
> > > -            lpcr |=3D (0x4ull << LPCR_RMLS_SHIFT);
> > > -        }
> > > -        if (val & 0x4000000000000000ull) {
> > > -            lpcr |=3D (0x2ull << LPCR_RMLS_SHIFT);
> > > -        }
> > > -        if (val & 0x2000000000000000ull) {
> > > -            lpcr |=3D (0x1ull << LPCR_RMLS_SHIFT);
> > > -        }
> > > -        env->spr[SPR_RMOR] =3D ((lpcr >> 41) & 0xffffull) << 26;
> > > -
> > > -        /*
> > > -         * XXX We could also write LPID from HID4 here
> > > -         * but since we don't tag any translation on it
> > > -         * it doesn't actually matter
> > > -         *
> > > -         * XXX For proper emulation of 970 we also need
> > > -         * to dig HRMOR out of HID5
> > > -         */
> > > -        break;
> > >      case POWERPC_MMU_2_03: /* P5p */
> > >          lpcr =3D val & (LPCR_RMLS | LPCR_ILE |
> > >                        LPCR_LPES0 | LPCR_LPES1 |
> > > @@ -1154,6 +1127,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulo=
ng val)
> > >          }
> > >          break;
> > >      default:
> > > +        g_assert_not_reached();
> > >          ;
> > >      }
> > >      env->spr[SPR_LPCR] =3D lpcr;
> > > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_i=
nit.inc.c
> > > index d33d65dff7..436d0d5a51 100644
> > > --- a/target/ppc/translate_init.inc.c
> > > +++ b/target/ppc/translate_init.inc.c
> > > @@ -7884,25 +7884,20 @@ static void spr_write_lpcr(DisasContext *ctx,=
 int sprn, int gprn)
> > >  {
> > >      gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
> > >  }
> > > -
> > > -static void spr_write_970_hid4(DisasContext *ctx, int sprn, int gprn)
> > > -{
> > > -#if defined(TARGET_PPC64)
> > > -    spr_write_generic(ctx, sprn, gprn);
> > > -    gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
> > > -#endif
> > > -}
> > > -
> > >  #endif /* !defined(CONFIG_USER_ONLY) */
> > > =20
> > >  static void gen_spr_970_lpar(CPUPPCState *env)
> > >  {
> > >  #if !defined(CONFIG_USER_ONLY)
> > >      /* Logical partitionning */
> > > -    /* PPC970: HID4 is effectively the LPCR */
> > > +    /* PPC970: HID4 covers things later controlled by the LPCR and
> > > +     * RMOR in later CPUs, but with a different encoding.  We only
> > > +     * support the 970 in "Apple mode" which has all hypervisor
> > > +     * facilities disabled by strapping, so we can basically just
> > > +     * ignore it */
> > >      spr_register(env, SPR_970_HID4, "HID4",
> > >                   SPR_NOACCESS, SPR_NOACCESS,
> > > -                 &spr_read_generic, &spr_write_970_hid4,
> > > +                 &spr_read_generic, &spr_write_generic,
> > >                   0x00000000);
> > >  #endif
> > >  }
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VK6IACgkQbDjKyiDZ
s5LDFBAAkBD+6t8YQRnVghcszIRLs9CrYM9WRD+BfWCkoyHvBIvtZpVt5octDMCD
nAJO4X61neW5h2uIN2mSRf4TuWgksvza9Ui5wn187s11G3yd8cDT95zOGtCJbtP7
dYdTcexnvvtq8gnH5dagrPAiEsJUH2mIowetTYxLke/PQV2YArw959Zqd5WzM654
I2vqzfukqbdoIvFypPiqaI0gUcOURBLmWq60DlynBmRaIZKpRpqLJeBzIjFuwulO
6Wc95pfTSD8dTHLe6ePz3qSN40/nL2egfxH7mHanOe215qGuIbiqEwu4FyjaJm1X
nwtCknvoKKq8XTHzhsGhIT7hX2VVSTFiJ2Fh+1dh9oMUwsnuOJPu7eV0Hkbk0t6C
OofOsISEt7wYMmcJxE8LPykypgRxTPGeVyt/POdwgogoyVfRwmYor1dFe9XRqaL8
4E7on9ysPylQnCqme6GHiIjPLojujmT50uufd27kzA6PPEh1BwHw0gc0uUzboXyC
gy+FA4eCLRiBc35ViQ/G1NjXywysEgXqVl4DiBmu2ggMRWlCMjHzQVY6g9LO3+dW
7ltFbnLQxDw3e//8lH7hr6PgLO2PudMoupKs/eVK5sVOfb6hH0R7V4VZMismtb4S
D3Bmm7/5YVPSBh8GPtHUUiHv+P49dQN4mysvZ3+tauUuIXg2iYk=
=zwgS
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--

