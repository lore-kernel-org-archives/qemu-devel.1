Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6AEC46470
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0D120675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0D120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSeML-000487-1o
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 05:13:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hSeLO-0003jZ-Go
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hSeLN-0007nt-2w
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:12:30 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:57772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hSeLM-0007mg-Rl
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:12:29 -0400
Received: from player697.ha.ovh.net (unknown [10.109.143.209])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 171DF213A75
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 11:12:25 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player697.ha.ovh.net (Postfix) with ESMTPSA id 61C7F5F49F5C;
	Mon, 20 May 2019 09:12:21 +0000 (UTC)
Date: Mon, 20 May 2019 11:12:20 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190520111220.2006bdac@bahia.lan>
In-Reply-To: <20190520061432.GC27407@umbus.fritz.box>
References: <20190517041823.23871-1-david@gibson.dropbear.id.au>
	<20190517191430.7daa11be@bahia.lan>
	<20190520061432.GC27407@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/PEC=DXMtw90ggf8LYf04mMe";
	protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 8032451411610343910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtkedgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.165.232
Subject: Re: [Qemu-devel] [PATCH] spapr: Add forgotten capability to
 migration stream
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/PEC=DXMtw90ggf8LYf04mMe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 May 2019 16:14:32 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, May 17, 2019 at 07:14:30PM +0200, Greg Kurz wrote:
> > On Fri, 17 May 2019 14:18:23 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > spapr machine capabilities are supposed to be sent in the migration s=
tream
> > > so that we can sanity check the source and destination have compatible
> > > configuration.  Unfortunately, when we added the hpt-max-page-size
> > > capability, we forgot to add it to the migration state.  This means t=
hat we
> > > can generate spurious warnings when both ends are configured for large
> > > pages, or potentially fail to warn if the source is configured for hu=
ge
> > > pages, but the destination is not.
> > >=20
> > > Fixes: 2309832afda "spapr: Maximum (HPT) pagesize property"
> > >  =20
> >=20
> > Sorry I didn't spot that during review :-\
> >  =20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > --- =20
> >=20
> > This breaks backward migration if the cap is set to a non-default
> > value, since older QEMUs don't expect the "spapr/cap/hpt_maxpagesize"
> > subsection. =20
>=20
> Ah, crud, that's a serious pain.
>=20
> > This being said, I'm not sure any other value but the current default (=
16)
> > actually works, so maybe we don't care. If so, =20
>=20
> Alas, it really does work with value 24 (giving you POWER8 16MiB

My bad... you're right :)

> pages).  And migration even works as long as it's 24 at both ends,
> although it emits a bogus warning.
>=20

Yeah I saw that... no big deal I guess. BTW, since dst >=3D src is legal,
do we really need to keep this warning around for future releases ?

> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > Otherwise, I was thinking about something like this: =20
>=20
> Yeah, I think something like the below is the best we can do.
>=20
> > 8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 9fc91c8f5eac..4f5becf1f3cc 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -119,6 +119,7 @@ struct SpaprMachineClass {
> >      bool pre_2_10_has_unused_icps;
> >      bool legacy_irq_allocation;
> >      bool broken_host_serial_model; /* present real host info to the gu=
est */
> > +    bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
> > =20
> >      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
> >                            uint64_t *buid, hwaddr *pio,=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index bcae30ad26c3..c8b3cccd5375 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4413,8 +4413,12 @@ DEFINE_SPAPR_MACHINE(4_1, "4.1", true);
> >   */
> >  static void spapr_machine_4_0_class_options(MachineClass *mc)
> >  {
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +
> >      spapr_machine_4_1_class_options(mc);
> >      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_le=
n);
> > +
> > +    smc->pre_4_1_migration =3D true;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 658eb15a147b..8a77bbdcf322 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -64,6 +64,7 @@ typedef struct SpaprCapabilityInfo {
> >      void (*apply)(SpaprMachineState *spapr, uint8_t val, Error **errp);
> >      void (*cpu_apply)(SpaprMachineState *spapr, PowerPCCPU *cpu,
> >                        uint8_t val, Error **errp);
> > +    bool (*migrate_needed)(void *opaque);
> >  } SpaprCapabilityInfo;
> > =20
> >  static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *na=
me,
> > @@ -350,6 +351,11 @@ static void cap_hpt_maxpagesize_apply(SpaprMachine=
State *spapr,
> >      spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
> >  }
> > =20
> > +static bool cap_hpt_maxpagesize_migrate_needed(void *opaque)
> > +{
> > +    return SPAPR_MACHINE_CLASS(opaque)->pre_4_1_migration;

And, of course, this should rather be:

    return !SPAPR_MACHINE_GET_CLASS(opaque)->pre_4_1_migration;

> > +}
> > +
> >  static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
> >                                uint32_t pshift)
> >  {
> > @@ -542,6 +548,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .type =3D "int",
> >          .apply =3D cap_hpt_maxpagesize_apply,
> >          .cpu_apply =3D cap_hpt_maxpagesize_cpu_apply,
> > +        .migrate_needed =3D cap_hpt_maxpagesize_migrate_needed,
> >      },
> >      [SPAPR_CAP_NESTED_KVM_HV] =3D {
> >          .name =3D "nested-hv",
> > @@ -679,8 +686,11 @@ int spapr_caps_post_migration(SpaprMachineState *s=
papr)
> >  static bool spapr_cap_##sname##_needed(void *opaque)    \
> >  {                                                       \
> >      SpaprMachineState *spapr =3D opaque;                  \
> > +    bool (*needed)(void *opaque) =3D                      \
> > +        capability_table[cap].migrate_needed;           \
> >                                                          \
> > -    return spapr->cmd_line_caps[cap] &&                 \
> > +    return needed ? needed(opaque) : true &&            \
> > +           spapr->cmd_line_caps[cap] &&                 \
> >             (spapr->eff.caps[cap] !=3D                     \
> >              spapr->def.caps[cap]);                      \
> >  }                                                       \
> > 8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >=20
> >  =20
> > >  hw/ppc/spapr.c         | 1 +
> > >  hw/ppc/spapr_caps.c    | 1 +
> > >  include/hw/ppc/spapr.h | 1 +
> > >  3 files changed, 3 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 8580a8dc67..bcae30ad26 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2125,6 +2125,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> > >          &vmstate_spapr_cap_cfpc,
> > >          &vmstate_spapr_cap_sbbc,
> > >          &vmstate_spapr_cap_ibs,
> > > +        &vmstate_spapr_cap_hpt_maxpagesize,
> > >          &vmstate_spapr_irq_map,
> > >          &vmstate_spapr_cap_nested_kvm_hv,
> > >          &vmstate_spapr_dtb,
> > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > index 9b1c10baa6..658eb15a14 100644
> > > --- a/hw/ppc/spapr_caps.c
> > > +++ b/hw/ppc/spapr_caps.c
> > > @@ -703,6 +703,7 @@ SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
> > >  SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
> > >  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
> > >  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> > > +SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
> > >  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> > >  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> > >  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index 7e32f309c2..9fc91c8f5e 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -849,6 +849,7 @@ extern const VMStateDescription vmstate_spapr_cap=
_dfp;
> > >  extern const VMStateDescription vmstate_spapr_cap_cfpc;
> > >  extern const VMStateDescription vmstate_spapr_cap_sbbc;
> > >  extern const VMStateDescription vmstate_spapr_cap_ibs;
> > > +extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
> > >  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> > >  extern const VMStateDescription vmstate_spapr_cap_large_decr;
> > >  extern const VMStateDescription vmstate_spapr_cap_ccf_assist; =20
> >  =20
>=20


--Sig_/PEC=DXMtw90ggf8LYf04mMe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlzib3QACgkQcdTV5YIv
c9bt/g//YWl246trvn1mUFBGGNLop146twIq2MuT9xNFOL9psoJQD520AurFq/30
msGuhG2LqUtVjaizhGoMYUSZ0PL6lF1EN+MwVLXblxBHW92Rxz6FUecpxFlTMmYG
kJKTRQslY8k/Et5hEVujBlKvaL/cdflSDmTjcMwJ1Po/xzsmXYmYJtTqtWPH1IXi
wa8Ozu6cHm0gavWyvL9Jq1VGI76nlvpVWz0xsMkDvt0g1gS7y7lC1KzpCQFz9XHR
Z7drSRiu35EMWqLYwUCXK/hZLrqIjieodJhFAORzWljHQRmLUbkS4LvvwQQ9fn2h
+IXs/tz5Lw9qodoiOsOR/prXGCEjUplz0s4vLHJi7kaVsXatPK1jNBT1clRZimQY
89/gJ4K8/4PIQImCtvcaF5CD8NW3q+XC8LsFS4uMPPehnRT/ywp/TUyjsac8hhyv
R1p+Csz3CM0tFNW2KL6XqLQsHEpn2AKi6sQSZZ9JLWNDS4yTMOOC7O4XTt6XwYE9
fnDHl3l4GiPysHACWP5bEfRWU9sF+ODcq6RobL0VkeEoZN5usVD1Ci0GPmH+Ofwr
nE9nY2FmCV0QHUp1rmanoMomo4eeFPCH0Bb6LQ53snuDfzKS2OhqxE/at1oym/vm
vOQ+Xx6mBSnn5vCWgRDpRMoiptqRQCiVtR0wn0LqbcMaATA1DTA=
=/4cp
-----END PGP SIGNATURE-----

--Sig_/PEC=DXMtw90ggf8LYf04mMe--

