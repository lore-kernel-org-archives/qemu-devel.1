Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D42C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187572083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PeM1f/HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187572083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJc8-0002eN-Ac
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ixJb8-0001Kw-Su
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ixJb7-0000Bl-AD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:51:46 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52261 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ixJb6-00006T-6k; Thu, 30 Jan 2020 18:51:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 487xvw6KRdz9sPK; Fri, 31 Jan 2020 10:51:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580428300;
 bh=e57HoC3aVPGjoH1pP3Gic6kHd8jS4U06Ue9NDAEfA/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PeM1f/HVfaES1VzFWAl/lAcRV9u2WYezTyJUJW5rGRb1c6VtXF1BkQYrcupHzftH7
 90kzFxklIMNBAObR06ERRQFn6kRg6Ltad6bs92CTEgGqLKoLiN1cZNSf7mhg3wNzSN
 8oAv9yRIzZCvnTkX7g1PF1QFhSVtX1/jQ6uEn/R0=
Date: Fri, 31 Jan 2020 10:47:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Enable DD2.3 accelerated count cache flush in
 pseries-5.0 machine
Message-ID: <20200130234705.GB15210@umbus.fritz.box>
References: <20200130012622.8564-1-david@gibson.dropbear.id.au>
 <20200130094849.03194668@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20200130094849.03194668@bahia.lan>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mpe@ellerman.id.au,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 09:48:49AM +0100, Greg Kurz wrote:
> On Thu, 30 Jan 2020 12:26:22 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > For POWER9 DD2.2 cpus, the best current Spectre v2 indirect branch
> > mitigation is "count cache disabled", which is configured with:
> >     -machine cap-ibs=3Dfixed-ccd
> > However, this option isn't available on DD2.3 CPUs with KVM, because th=
ey
> > don't have the count cache disabled.
> >=20
> > For POWER9 DD2.3 cpus, it is "count cache flush with assist", configured
> > with:
> >     -machine cap-ibs=3Dworkaround,cap-ccf-assist=3Don
> > However this option isn't available on DD2.2 CPUs with KVM, because they
> > don't have the special CCF assist instruction this relies on.
> >=20
> > On current machine types, we default to "count cache flush w/o assist",
> > that is:
> >     -machine cap-ibs=3Dworkaround,cap-ccf-assist=3Doff
> > This runs, with mitigation on both DD2.2 and DD2.3 host cpus, but has a
> > fairly significant performance impact.
> >=20
> > It turns out we can do better.  The special instruction that CCF assist
> > uses to trigger a count cache flush is a no-op on earlier CPUs, rather =
than
> > trapping or causing other badness.  It doesn't, of itself, implement the
> > mitigation, but *if* we have count-cache-disabled, then the count cache
> > flush is unnecessary, and so using the count cache flush mitigation is
> > harmless.
> >=20
> > Therefore for the new pseries-5.0 machine type, enable cap-ccf-assist by
> > default.  Along with that, suppress throwing an error if cap-ccf-assist
> > is selected but KVM doesn't support it, as long as KVM *is* giving us
> > count-cache-disabled.  To allow TCG to work out of the box, even though=
 it
> > doesn't implement the ccf flush assist, downgrade the error in that cas=
e to
> > a warning.  This matches several Spectre mitigations where we allow TCG
> > to operate for debugging, since we don't really make guarantees about T=
CG
> > security properties anyway.
> >=20
> > While we're there, make the TCG warning for this case match that for ot=
her
> > mitigations.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c      |  5 ++++-
> >  hw/ppc/spapr_caps.c | 26 ++++++++++++++++++++++----
> >  2 files changed, 26 insertions(+), 5 deletions(-)
> >=20
> > I have put this into my ppc-for-5.0 tree already, and hope to send a
> > pull request tomorrow (Jan 31).
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 02cf53fc5b..deaa44f1ab 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4397,7 +4397,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB=
 */
> >      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> >      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_=
ON;
> > -    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> > +    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
> >      spapr_caps_add_properties(smc, &error_abort);
> >      smc->irq =3D &spapr_irq_dual;
> >      smc->dr_phb_enabled =3D true;
> > @@ -4465,8 +4465,11 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
> >   */
> >  static void spapr_machine_4_2_class_options(MachineClass *mc)
> >  {
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +
> >      spapr_machine_5_0_class_options(mc);
> >      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_le=
n);
> > +    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 481dfd2a27..d0d4b32a40 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -482,18 +482,36 @@ static void cap_large_decr_cpu_apply(SpaprMachine=
State *spapr,
> >  static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
> >                                   Error **errp)
> >  {
> > +    Error *local_err =3D NULL;
> >      uint8_t kvm_val =3D kvmppc_get_cap_count_cache_flush_assist();
> > =20
> >      if (tcg_enabled() && val) {
> > -        /* TODO - for now only allow broken for TCG */
> > -        error_setg(errp,
> > -"Requested count cache flush assist capability level not supported by =
tcg,"
> > -                   " try appending -machine cap-ccf-assist=3Doff");
> > +        /* TCG doesn't implement anything here, but allow with a warni=
ng */
> > +        error_setg(&local_err,
> > +                   "TCG doesn't support requested feature, cap-ccf-ass=
ist=3Don");
>=20
> The only user for local_err is warn_report_err() below. It would be simpl=
er to
> simply call warn_report() here.

Yeah, fair enough.  I was doing it this way for consistency with some
of the other cases where we warn only on TCG, but there's not really
any point.  Revised in my tree.

>=20
> >      } else if (kvm_enabled() && (val > kvm_val)) {
> > +        uint8_t kvm_ibs =3D kvmppc_get_cap_safe_indirect_branch();
> > +
> > +        if (kvm_ibs =3D=3D SPAPR_CAP_FIXED_CCD) {
> > +            /*
> > +             * If we don't have CCF assist on the host, the assist
> > +             * instruction is a harmless no-op.  It won't correctly
> > +             * implement the cache count flush *but* if we have
> > +             * count-cache-disabled in the host, that flush is
> > +             * unnnecessary.  So, specifically allow this case.  This
> > +             * allows us to have better performance on POWER9 DD2.3,
> > +             * while still working on POWER9 DD2.2 and POWER8 host
> > +             * cpus.
> > +             */
> > +            return;
> > +        }
> >          error_setg(errp,
> >  "Requested count cache flush assist capability level not supported by =
kvm,"
> >                     " try appending -machine cap-ccf-assist=3Doff");
> >      }
> > +
> > +    if (local_err !=3D NULL)
> > +        warn_report_err(local_err);
> >  }
> > =20
> >  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4zavkACgkQbDjKyiDZ
s5ITJw/+NDxZw24to5zFivls10qS5j7DYXzZQgrLdgqcfR8ks//7CDAEVQAA9fym
9MEUKR0kUqjNwImVYvt2wNW5Zskp1287IIRb3uFGFKFN+F1zCN7Pur1aOuG4K/86
mZ95Tka08hwnD9E4xO5suWJ2//D2mIPc8MwcrO8QPWRTxLSDZWFrwaCx4rIvQTNx
nNCtlhmHRyT6S8OtLU5c/8768gCtaj6UoGeK+I79JiHzcEuv44464gGavnMF7lDh
qgLAyhMlHvG7tDuUH4DwCbxy6sUnPx0tMO1ppxqDXXhF+eLtlssB68GOkFatxTay
sB+Au3GD4aE2qwGAUxrKZ0S/HFU3k6Mnp01n0ONSdoImyoJqdroXEAtIkM85E+Cf
3ADkdxjxqeZ3zQZNsKMcanUCo0ljUwrRWevYvTkVB3ydg7soCbjgwMvtmPFGnMb7
dHR3/RJxXwY0hVps7ywltjt0w/a6V1Cbcpu4SHuswrAegKEWoj/+/VdpKfIANMwy
vkw62FtG+PI/Qx83B3QaojDQRz5iXzPLGc15z1sI7uBF3eP2EHyNaXfQCyrLOqn8
nj+aP3myLmxdDOUFy1vOOhSrCUBLq+yqfsoBC3SMKWc9KWeGR15cTirebl7S15wb
s+jHqrvwzMzZpR1JIVlXkwyafbX8kXAfzp8SF3E2cugdikyTqMg=
=nwTO
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

