Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A6C7619D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 03:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3888321D56
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 03:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HDPlbRAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3888321D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4cTp-0001ks-Co
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 22:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4cR3-0004aj-Ro
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 22:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4cR2-0008Hd-Dk
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 22:23:33 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54391 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4cR1-0008Dj-OT; Wed, 19 Feb 2020 22:23:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NKfz6Qylz9sRm; Thu, 20 Feb 2020 14:23:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582169003;
 bh=mzDqtZXYOoauxsi4ZFqYpnRbWcspdL3Pg1MBrJCsmWI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HDPlbRAe7xFz3L/3fqWQDcu1enGpgyN3ZkMxn/RKBJkGWDtMLEegvcHK9OHGlu72F
 nFyxXahnF6xnvOHi6bU4v95cnDCl8sRR/NyGgZGVvYHKl6ArRdaEddz37jGR6hK5Le
 knTETJ7yVLyvYvF0iKgdV8iiFDCQ1Xe2hnpLSRaQ=
Date: Thu, 20 Feb 2020 14:10:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH v3 04/12] target/ppc: Introduce ppc_hash64_use_vrma()
 helper
Message-ID: <20200220031048.GM1764@umbus.fritz.box>
References: <20200219005414.15635-1-david@gibson.dropbear.id.au>
 <20200219005414.15635-5-david@gibson.dropbear.id.au>
 <87blpud63n.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OGW1Z2JKiS9bXo17"
Content-Disposition: inline
In-Reply-To: <87blpud63n.fsf@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org,
 clg@kaod.org, qemu-ppc@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OGW1Z2JKiS9bXo17
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 11:06:20AM -0300, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > When running guests under a hypervisor, the hypervisor obviously needs =
to
> > be protected from guest accesses even if those are in what the guest
> > considers real mode (translation off).  The POWER hardware provides two
> > ways of doing that: The old way has guest real mode accesses simply off=
set
> > and bounds checked into host addresses.  It works, but requires that a
> > significant chunk of the guest's memory - the RMA - be physically
> > contiguous in the host, which is pretty inconvenient.  The new way, kno=
wn
> > as VRMA, has guest real mode accesses translated in roughly the normal =
way
> > but with some special parameters.
> >
> > In POWER7 and POWER8 the LPCR[VPM0] bit selected between the two modes,=
 but
> > in POWER9 only VRMA mode is supported
>=20
> ... when translation is off, right? Because I see in the 3.0 ISA that
> LPCR[VPM1] is still there.

Right.  This whole patch (and the whole series) is about when the
guest is in translation off mode.

>=20
> > and LPCR[VPM0] no longer exists.  We
> > handle that difference in behaviour in ppc_hash64_set_isi().. but not in
> > other places that we blindly check LPCR[VPM0].
> >
> > Correct those instances with a new helper to tell if we should be in VR=
MA
> > mode.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  target/ppc/mmu-hash64.c | 41 +++++++++++++++++++----------------------
> >  1 file changed, 19 insertions(+), 22 deletions(-)
> >
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index 5fabd93c92..d878180df5 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -668,6 +668,19 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCC=
PU *cpu,
> >      return 0;
> >  }
> > =20
> > +static bool ppc_hash64_use_vrma(CPUPPCState *env)
> > +{
> > +    switch (env->mmu_model) {
> > +    case POWERPC_MMU_3_00:
> > +        /* ISAv3.0 (POWER9) always uses VRMA, the VPM0 field and RMOR
> > +         * register no longer exist */
> > +        return true;
> > +
> > +    default:
> > +        return !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> > +    }
> > +}
> > +
> >  static void ppc_hash64_set_isi(CPUState *cs, uint64_t error_code)
> >  {
> >      CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
> > @@ -676,15 +689,7 @@ static void ppc_hash64_set_isi(CPUState *cs, uint6=
4_t error_code)
> >      if (msr_ir) {
> >          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
> >      } else {
> > -        switch (env->mmu_model) {
> > -        case POWERPC_MMU_3_00:
> > -            /* Field deprecated in ISAv3.00 - interrupts always go to =
hyperv */
> > -            vpm =3D true;
> > -            break;
> > -        default:
> > -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> > -            break;
> > -        }
> > +        vpm =3D ppc_hash64_use_vrma(env);
> >      }
> >      if (vpm && !msr_hv) {
> >          cs->exception_index =3D POWERPC_EXCP_HISI;
> > @@ -702,15 +707,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint6=
4_t dar, uint64_t dsisr)
> >      if (msr_dr) {
> >          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
> >      } else {
> > -        switch (env->mmu_model) {
> > -        case POWERPC_MMU_3_00:
> > -            /* Field deprecated in ISAv3.00 - interrupts always go to =
hyperv */
> > -            vpm =3D true;
> > -            break;
> > -        default:
> > -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> > -            break;
> > -        }
> > +        vpm =3D ppc_hash64_use_vrma(env);
> >      }
> >      if (vpm && !msr_hv) {
> >          cs->exception_index =3D POWERPC_EXCP_HDSI;
> > @@ -799,7 +796,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr,
> >              if (!(eaddr >> 63)) {
> >                  raddr |=3D env->spr[SPR_HRMOR];
> >              }
> > -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> > +        } else if (ppc_hash64_use_vrma(env)) {
> >              /* Emulated VRMA mode */
> >              slb =3D &env->vrma_slb;
> >              if (!slb->sps) {
> > @@ -967,7 +964,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong addr)
> >          } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
> >              /* In HV mode, add HRMOR if top EA bit is clear */
> >              return raddr | env->spr[SPR_HRMOR];
> > -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> > +        } else if (ppc_hash64_use_vrma(env)) {
> >              /* Emulated VRMA mode */
> >              slb =3D &env->vrma_slb;
> >              if (!slb->sps) {
> > @@ -1056,8 +1053,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cp=
u)
> >      slb->sps =3D NULL;
> > =20
> >      /* Is VRMA enabled ? */
> > -    lpcr =3D env->spr[SPR_LPCR];
> > -    if (!(lpcr & LPCR_VPM0)) {
> > +    if (ppc_hash64_use_vrma(env)) {
>=20
> Shouldn't this be !ppc_hash64_use_vrma(env)?
>=20
> And a comment about the original code: all other places that check
> LPCR_VPM0 do it after verifying that translation is off, except here
> (ppc_hash64_update_vrma). Could that be an issue?
>=20
> >          return;
> >      }
> > =20
> > @@ -1065,6 +1061,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cp=
u)
> >       * Make one up. Mostly ignore the ESID which will not be needed
> >       * for translation
> >       */
> > +    lpcr =3D env->spr[SPR_LPCR];
> >      vsid =3D SLB_VSID_VRMA;
> >      vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> >      vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OGW1Z2JKiS9bXo17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5N+LgACgkQbDjKyiDZ
s5JMwBAAiBxpuU5doGtudLB0JaRdIX5o9YSs093uRRbqx36Q5yfwCUQCwBS+ai7M
IXyPVfcCYhROoTkjWiMZOx2UxdYQMNanxpf41IOp22zuisN6os+UlI7lQXi88rNU
iLoB+tSpqtAElRL7rjWYDceEt4cmLrK0SIInaI8QEy/QjnqXxlvQDeZMOK9uQrVv
K/hjcEAzE5Du80Pj16DIT9qpOT0OAuCPCP5KZZrBVmwmMxA1qkd3YhCD3l4Tca+T
77x9Tfs3eNjj+Ngc30cMhXmtFBPC4vV90nMjVv4h9fIh2sk+2eAbSSnoA2l+rwjr
fqag3ix5lZKHWtO5x5PKcVtU5vJryjFJMNYDoDFrlcM50al4Pn3xzhUOgvoBFKOB
MqK2cV8d2lEd/qy3S+LwpNTkqr4iqAAfETbBj2KVLGpBCtgbCiIGbIjqPOsZQKnr
GW8rtNOieHm7acj4YLnMck+5SXhWZuQU/1wzF30J2mzV0OtbC3Ixga9hhCpLyrW2
vAxAAUFR0p9alD3Dc20F1sHh58h+GjGrYl3Gou9cAIU6RO6rrAqS04KGcY2dmccB
7o3/oupVfvW6Lw7D4QYzKfiBYqwJB6xHOppAjH+d8tOIkGMtRmTA1/yxVc36hnfJ
LJHSVYeEkfz9GnzbiYnhXiMHJ8CBM0pmld9Fh0NTMhbGm18PXcY=
=shsw
-----END PGP SIGNATURE-----

--OGW1Z2JKiS9bXo17--

