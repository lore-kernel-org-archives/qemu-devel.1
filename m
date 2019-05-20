Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A5C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBCA20851
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j95ZtClv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBCA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSbry-0004Rc-Qb
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:33:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbqd-0003qo-F0
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbqb-000064-Gx
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:32:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44481 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSbqZ-0008VO-0U; Mon, 20 May 2019 02:32:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 456pwR0X9Zz9s6w; Mon, 20 May 2019 16:32:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558333943;
	bh=HgNto38wpI5YzMXewdgS06gCrnfcvkroM6usRCCnbRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j95ZtClv2mQNHpEE2PEmTJ8DziQOgwa31ySaV65NH/sKF61h9aYk/atY1R8yN/+Jd
	OY/VCooAJKS9V1zDzKV6H1E3NDofCiglEW21PKqsKF7NpqIxV+Rte7ifMb527CF/rF
	KY7a+P5tOY82tJDzzL6Fsyq/fqHSVWspYCefuXfM=
Date: Mon, 20 May 2019 16:14:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190520061432.GC27407@umbus.fritz.box>
References: <20190517041823.23871-1-david@gibson.dropbear.id.au>
	<20190517191430.7daa11be@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20190517191430.7daa11be@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
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


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 07:14:30PM +0200, Greg Kurz wrote:
> On Fri, 17 May 2019 14:18:23 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > spapr machine capabilities are supposed to be sent in the migration str=
eam
> > so that we can sanity check the source and destination have compatible
> > configuration.  Unfortunately, when we added the hpt-max-page-size
> > capability, we forgot to add it to the migration state.  This means tha=
t we
> > can generate spurious warnings when both ends are configured for large
> > pages, or potentially fail to warn if the source is configured for huge
> > pages, but the destination is not.
> >=20
> > Fixes: 2309832afda "spapr: Maximum (HPT) pagesize property"
> >=20
>=20
> Sorry I didn't spot that during review :-\
>=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> This breaks backward migration if the cap is set to a non-default
> value, since older QEMUs don't expect the "spapr/cap/hpt_maxpagesize"
> subsection.

Ah, crud, that's a serious pain.

> This being said, I'm not sure any other value but the current default (16)
> actually works, so maybe we don't care. If so,

Alas, it really does work with value 24 (giving you POWER8 16MiB
pages).  And migration even works as long as it's 24 at both ends,
although it emits a bogus warning.

> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> Otherwise, I was thinking about something like this:

Yeah, I think something like the below is the best we can do.

> 8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9fc91c8f5eac..4f5becf1f3cc 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -119,6 +119,7 @@ struct SpaprMachineClass {
>      bool pre_2_10_has_unused_icps;
>      bool legacy_irq_allocation;
>      bool broken_host_serial_model; /* present real host info to the gues=
t */
> +    bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
> =20
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bcae30ad26c3..c8b3cccd5375 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4413,8 +4413,12 @@ DEFINE_SPAPR_MACHINE(4_1, "4.1", true);
>   */
>  static void spapr_machine_4_0_class_options(MachineClass *mc)
>  {
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_4_1_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
> +
> +    smc->pre_4_1_migration =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 658eb15a147b..8a77bbdcf322 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -64,6 +64,7 @@ typedef struct SpaprCapabilityInfo {
>      void (*apply)(SpaprMachineState *spapr, uint8_t val, Error **errp);
>      void (*cpu_apply)(SpaprMachineState *spapr, PowerPCCPU *cpu,
>                        uint8_t val, Error **errp);
> +    bool (*migrate_needed)(void *opaque);
>  } SpaprCapabilityInfo;
> =20
>  static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
> @@ -350,6 +351,11 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineSt=
ate *spapr,
>      spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
>  }
> =20
> +static bool cap_hpt_maxpagesize_migrate_needed(void *opaque)
> +{
> +    return SPAPR_MACHINE_CLASS(opaque)->pre_4_1_migration;
> +}
> +
>  static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
>                                uint32_t pshift)
>  {
> @@ -542,6 +548,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "int",
>          .apply =3D cap_hpt_maxpagesize_apply,
>          .cpu_apply =3D cap_hpt_maxpagesize_cpu_apply,
> +        .migrate_needed =3D cap_hpt_maxpagesize_migrate_needed,
>      },
>      [SPAPR_CAP_NESTED_KVM_HV] =3D {
>          .name =3D "nested-hv",
> @@ -679,8 +686,11 @@ int spapr_caps_post_migration(SpaprMachineState *spa=
pr)
>  static bool spapr_cap_##sname##_needed(void *opaque)    \
>  {                                                       \
>      SpaprMachineState *spapr =3D opaque;                  \
> +    bool (*needed)(void *opaque) =3D                      \
> +        capability_table[cap].migrate_needed;           \
>                                                          \
> -    return spapr->cmd_line_caps[cap] &&                 \
> +    return needed ? needed(opaque) : true &&            \
> +           spapr->cmd_line_caps[cap] &&                 \
>             (spapr->eff.caps[cap] !=3D                     \
>              spapr->def.caps[cap]);                      \
>  }                                                       \
> 8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>=20
>=20
> >  hw/ppc/spapr.c         | 1 +
> >  hw/ppc/spapr_caps.c    | 1 +
> >  include/hw/ppc/spapr.h | 1 +
> >  3 files changed, 3 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 8580a8dc67..bcae30ad26 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2125,6 +2125,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
> >          &vmstate_spapr_cap_cfpc,
> >          &vmstate_spapr_cap_sbbc,
> >          &vmstate_spapr_cap_ibs,
> > +        &vmstate_spapr_cap_hpt_maxpagesize,
> >          &vmstate_spapr_irq_map,
> >          &vmstate_spapr_cap_nested_kvm_hv,
> >          &vmstate_spapr_dtb,
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 9b1c10baa6..658eb15a14 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -703,6 +703,7 @@ SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
> >  SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
> >  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
> >  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> > +SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
> >  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> >  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> >  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 7e32f309c2..9fc91c8f5e 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -849,6 +849,7 @@ extern const VMStateDescription vmstate_spapr_cap_d=
fp;
> >  extern const VMStateDescription vmstate_spapr_cap_cfpc;
> >  extern const VMStateDescription vmstate_spapr_cap_sbbc;
> >  extern const VMStateDescription vmstate_spapr_cap_ibs;
> > +extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
> >  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> >  extern const VMStateDescription vmstate_spapr_cap_large_decr;
> >  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlziRcgACgkQbDjKyiDZ
s5INbg/+NXnHCv2XALuHFc0v6bhJF61zxrDW8qUcb5PWTxzk3eVJlrOdB60ZRw+Z
ilSsvlyUkvzyyiwQ7Yd863NSX7o/MIgwzHUHLkV0mHp+s4v3FooH4rLY7kqIkW0G
FvlhX8JCpHB3JkWJQ6J9Ww2kLcH+fYblspWVsZWznroiSqtS1H/yXWmTsgWmgdgv
bx0lfc+diu2XBCRhIULr1LUVYrSTa2Q5KRz+yt3L4Ct4cgawgheLSQqd/kFbkuVD
a0ymsxnGc+NJzPJRw+N7XK0vpsfngZGDsYpYoblcl3RYDerttFIyeotYkH+82cRx
bSbeo7o8Rm0OjHdo/D6nd+0mpSP81D3NnSAntNXUxEgSGXnAQUxqrz3QyiP68MHy
Pw7j2K/QuVZIJY9w8Uo2k8IRqi2QWqSDbbDJUlZ8OMWP98cT1OxcvvUMTdXImfAQ
elXNkOBwlgnhb61AFiyE66StzOxYQLJcBXssDkTZCGrQC3oWfqDEMMPWvxAs8RZ0
05MgcK30e+PNigwFh++vfPswQ0cYSpHnR2WMNo6PBc+PGzauNN+6AiO3hrVsDBvr
4jJNTu0lYxX2qpvCHLTmJiAFGs9Vo8tEeufoQA+38zdrM8FVzHx1vhWE7wFcJofX
is0S+AUlKtBwmA1ylslUPf1gJ2pgbfHFPlRo0VcFHrwkUMfMEy8=
=j8Md
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

