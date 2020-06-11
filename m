Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF49BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8723A2072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8723A2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIfZ-0002rr-PS
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjIeo-0002BG-A5
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:33:54 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:42223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjIel-0000n6-J5
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:33:54 -0400
Received: from player157.ha.ovh.net (unknown [10.108.42.23])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id A711D16B2F3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 10:33:48 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 773C31345895A;
 Thu, 11 Jun 2020 08:33:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006d97da734-53f4-4f52-a513-fc7c860fefaa,8E3DA20A17A7E5167CC729B80B53FA75D16C5C19)
 smtp.auth=groug@kaod.org
Date: Thu, 11 Jun 2020 10:33:41 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/3] spapr: Use error_append_hint() in spapr_caps.c
Message-ID: <20200611103341.3e84e565@bahia.lan>
In-Reply-To: <3bbcf90e-13c3-1c45-b100-69e0e5bcb0ef@virtuozzo.com>
References: <159180935807.29090.16079635439548762534.stgit@bahia.lan>
 <159180945454.29090.15222636045973363294.stgit@bahia.lan>
 <3bbcf90e-13c3-1c45-b100-69e0e5bcb0ef@virtuozzo.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17035991493948971347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudehkedgtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveefteefgfeikedtgfetiedvveeggfeggeeileeuffeggfffieetfefgkedttdejnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.52.162; envelope-from=groug@kaod.org;
 helo=2.mo68.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 04:33:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jun 2020 21:03:15 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 10.06.2020 20:17, Greg Kurz wrote:
> > We have a dedicated error API for hints. Use it instead of embedding
> > the hint in the error message, as recommanded in the "qapi/error.h"
> > header file.
> >=20
> > Since spapr_caps_apply() passes &error_fatal, all functions must
> > also call the ERRP_AUTO_PROPAGATE() macro for error_append_hint()
> > to be functional.
> >=20
> > While here, add some missing braces around one line statements that
> > are part of the patch context. Also have cap_fwnmi_apply(), which
> > already uses error_append_hint() to call ERRP_AUTO_PROPAGATE() as
> > well.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   hw/ppc/spapr_caps.c |   93 +++++++++++++++++++++++++++++-------------=
---------
> >   1 file changed, 52 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index efdc0dbbcfc0..0c3d3b64a508 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -189,24 +189,24 @@ static void spapr_cap_set_pagesize(Object *obj, V=
isitor *v, const char *name,
> >  =20
> >   static void cap_htm_apply(SpaprMachineState *spapr, uint8_t val, Erro=
r **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       if (!val) {
> >           /* TODO: We don't support disabling htm yet */
> >           return;
> >       }
> >       if (tcg_enabled()) {
> > -        error_setg(errp,
> > -                   "No Transactional Memory support in TCG,"
> > -                   " try appending -machine cap-htm=3Doff");
> > +        error_setg(errp, "No Transactional Memory support in TCG");
> > +        error_append_hint(errp, "Try appending -machine cap-htm=3Doff\=
n");
> >       } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
> >           error_setg(errp,
> > -"KVM implementation does not support Transactional Memory,"
> > -                   " try appending -machine cap-htm=3Doff"
> > -            );
> > +"KVM implementation does not support Transactional Memory");
>=20
> Should be indented after opening '('
>=20

Many error_setg() lines in this file follow the same style of tweaking
indentation to stay below the 80 character limit. I've just kept the
existing style.

> > +        error_append_hint(errp, "Try appending -machine cap-htm=3Doff\=
n");
> >       }
> >   }
> >  =20
> >   static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Erro=
r **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> >       CPUPPCState *env =3D &cpu->env;
> >  =20
> > @@ -218,13 +218,14 @@ static void cap_vsx_apply(SpaprMachineState *spap=
r, uint8_t val, Error **errp)
> >        * rid of anything that doesn't do VMX */
> >       g_assert(env->insns_flags & PPC_ALTIVEC);
> >       if (!(env->insns_flags2 & PPC2_VSX)) {
> > -        error_setg(errp, "VSX support not available,"
> > -                   " try appending -machine cap-vsx=3Doff");
> > +        error_setg(errp, "VSX support not available");
> > +        error_append_hint(errp, "Try appending -machine cap-vsx=3Doff\=
n");
> >       }
> >   }
> >  =20
> >   static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Erro=
r **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> >       CPUPPCState *env =3D &cpu->env;
> >  =20
> > @@ -233,8 +234,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr,=
 uint8_t val, Error **errp)
> >           return;
> >       }
> >       if (!(env->insns_flags2 & PPC2_DFP)) {
> > -        error_setg(errp, "DFP support not available,"
> > -                   " try appending -machine cap-dfp=3Doff");
> > +        error_setg(errp, "DFP support not available");
> > +        error_append_hint(errp, "Try appending -machine cap-dfp=3Doff\=
n");
> >       }
> >   }
> >  =20
> > @@ -248,6 +249,7 @@ SpaprCapPossible cap_cfpc_possible =3D {
> >   static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t va=
l,
> >                                    Error **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       Error *local_err =3D NULL;
> >       uint8_t kvm_val =3D  kvmppc_get_cap_safe_cache();
> >  =20
> > @@ -258,13 +260,14 @@ static void cap_safe_cache_apply(SpaprMachineStat=
e *spapr, uint8_t val,
> >                      cap_cfpc_possible.vals[val]);
> >       } else if (kvm_enabled() && (val > kvm_val)) {
> >           error_setg(errp,
> > -                   "Requested safe cache capability level not supporte=
d by kvm,"
> > -                   " try appending -machine cap-cfpc=3D%s",
> > -                   cap_cfpc_possible.vals[kvm_val]);
> > +"Requested safe cache capability level not supported by KVM");
>=20
> Hmm you do this intentionally.. OK, than, it's a kind of taste.
>=20

Yes, but as said above, there's precedence in this file.

I'm okay with fixing the indent. It is acceptable to have error_setg()
lines span over 80 characters for the sake of being able to grep error
strings in the code base.

> > +        error_append_hint(errp, "Try appending -machine cap-cfpc=3D%s\=
n",
> > +                          cap_cfpc_possible.vals[kvm_val]);
> >       }
> >  =20
> > -    if (local_err !=3D NULL)
> > +    if (local_err !=3D NULL) {
> >           warn_report_err(local_err);
> > +    }
> >   }
> >  =20
> >   SpaprCapPossible cap_sbbc_possible =3D {
> > @@ -277,6 +280,7 @@ SpaprCapPossible cap_sbbc_possible =3D {
> >   static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uin=
t8_t val,
> >                                           Error **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       Error *local_err =3D NULL;
> >       uint8_t kvm_val =3D  kvmppc_get_cap_safe_bounds_check();
> >  =20
> > @@ -287,13 +291,14 @@ static void cap_safe_bounds_check_apply(SpaprMach=
ineState *spapr, uint8_t val,
> >                      cap_sbbc_possible.vals[val]);
> >       } else if (kvm_enabled() && (val > kvm_val)) {
> >           error_setg(errp,
> > -"Requested safe bounds check capability level not supported by kvm,"
> > -                   " try appending -machine cap-sbbc=3D%s",
> > -                   cap_sbbc_possible.vals[kvm_val]);
> > +"Requested safe bounds check capability level not supported by KVM");
> > +        error_append_hint(errp, "Try appending -machine cap-sbbc=3D%s\=
n",
> > +                          cap_sbbc_possible.vals[kvm_val]);
> >       }
> >  =20
> > -    if (local_err !=3D NULL)
> > +    if (local_err !=3D NULL) {
> >           warn_report_err(local_err);
> > +    }
> >   }
> >  =20
> >   SpaprCapPossible cap_ibs_possible =3D {
> > @@ -309,6 +314,7 @@ SpaprCapPossible cap_ibs_possible =3D {
> >   static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
> >                                              uint8_t val, Error **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       Error *local_err =3D NULL;
> >       uint8_t kvm_val =3D kvmppc_get_cap_safe_indirect_branch();
> >  =20
> > @@ -319,9 +325,9 @@ static void cap_safe_indirect_branch_apply(SpaprMac=
hineState *spapr,
> >                      cap_ibs_possible.vals[val]);
> >       } else if (kvm_enabled() && (val > kvm_val)) {
> >           error_setg(errp,
> > -"Requested safe indirect branch capability level not supported by kvm,"
> > -                   " try appending -machine cap-ibs=3D%s",
> > -                   cap_ibs_possible.vals[kvm_val]);
> > +"Requested safe indirect branch capability level not supported by KVM"=
);
> > +        error_append_hint(errp, "Try appending -machine cap-ibs=3D%s\n=
",
> > +                          cap_ibs_possible.vals[kvm_val]);
> >       }
> >  =20
> >       if (local_err !=3D NULL) {
> > @@ -408,17 +414,17 @@ static void cap_nested_kvm_hv_apply(SpaprMachineS=
tate *spapr,
>=20
> You forget to add ERRP_AUTO_PROPAGATE
>=20

Oops, it's in the next patch... I've re-ordered the patches and
I simply forgot to move that hunk here. I will fix that in v2.

> >       }
> >  =20
> >       if (tcg_enabled()) {
> > -        error_setg(errp,
> > -                   "No Nested KVM-HV support in tcg,"
> > -                   " try appending -machine cap-nested-hv=3Doff");
> > +        error_setg(errp, "No Nested KVM-HV support in TCG");
> > +        error_append_hint(errp, "Try appending -machine cap-nested-hv=
=3Doff");
>=20
> Hmm, didn't you forget '\n' ? You consistantly add it in previous hints. =
(I do think that it's strange that we should add it by hand, but it seems a=
 common thing to add it)
>=20

Oops indeed I forgot. Good catch ! :)

=46rom the documentation of error_append_hint() in "qapi/error.h" :

 * May be called multiple times.  The resulting hint should end with a
 * newline.

> >       } else if (kvm_enabled()) {
> >           if (!kvmppc_has_cap_nested_kvm_hv()) {
> >               error_setg(errp,
> > -"KVM implementation does not support Nested KVM-HV,"
> > -                       " try appending -machine cap-nested-hv=3Doff");
> > +"KVM implementation does not support Nested KVM-HV");
> > +            error_append_hint(errp, "Try appending -machine cap-nested=
-hv=3Doff");
>=20
> and here
>=20

Oops

> >           } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
> > -                error_setg(errp,
> > -"Error enabling cap-nested-hv with KVM, try cap-nested-hv=3Doff");
> > +                error_setg(errp, "Error enabling cap-nested-hv with KV=
M");
> > +                error_append_hint(errp,
> > +                                  "Try appending -machine cap-nested-h=
v=3Doff");
>=20
> and here
>=20

Thanks for all the catches !

> >           }
> >       }
> >   }
> > @@ -426,6 +432,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineSta=
te *spapr,
> >   static void cap_large_decr_apply(SpaprMachineState *spapr,
> >                                    uint8_t val, Error **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> >       PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> >  =20
> > @@ -436,22 +443,23 @@ static void cap_large_decr_apply(SpaprMachineStat=
e *spapr,
> >       if (tcg_enabled()) {
> >           if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> >                                 spapr->max_compat_pvr)) {
> > -            error_setg(errp,
> > -                "Large decrementer only supported on POWER9, try -cpu =
POWER9");
> > +            error_setg(errp, "Large decrementer only supported on POWE=
R9");
> > +            error_append_hint(errp, "Try -cpu POWER9\n");
> >               return;
> >           }
> >       } else if (kvm_enabled()) {
> >           int kvm_nr_bits =3D kvmppc_get_cap_large_decr();
> >  =20
> >           if (!kvm_nr_bits) {
> > -            error_setg(errp,
> > -                       "No large decrementer support,"
> > -                        " try appending -machine cap-large-decr=3Doff"=
);
> > +            error_setg(errp, "No large decrementer support");
> > +            error_append_hint(errp,
> > +                              "Try appending -machine cap-large-decr=
=3Doff\n");
> >           } else if (pcc->lrg_decr_bits !=3D kvm_nr_bits) {
> >               error_setg(errp,
> > -"KVM large decrementer size (%d) differs to model (%d),"
> > -                " try appending -machine cap-large-decr=3Doff",
> > -                kvm_nr_bits, pcc->lrg_decr_bits);
> > +                       "KVM large decrementer size (%d) differs to mod=
el (%d)",
> > +                       kvm_nr_bits, pcc->lrg_decr_bits);
> > +            error_append_hint(errp,
> > +                              "Try appending -machine cap-large-decr=
=3Doff\n");
> >           }
> >       }
> >   }
> > @@ -460,14 +468,15 @@ static void cap_large_decr_cpu_apply(SpaprMachine=
State *spapr,
> >                                        PowerPCCPU *cpu,
> >                                        uint8_t val, Error **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       CPUPPCState *env =3D &cpu->env;
> >       target_ulong lpcr =3D env->spr[SPR_LPCR];
> >  =20
> >       if (kvm_enabled()) {
> >           if (kvmppc_enable_cap_large_decr(cpu, val)) {
> > -            error_setg(errp,
> > -                       "No large decrementer support,"
> > -                       " try appending -machine cap-large-decr=3Doff");
> > +            error_setg(errp, "No large decrementer support");
> > +            error_append_hint(errp,
> > +                              "Try appending -machine cap-large-decr=
=3Doff\n");
> >           }
> >       }
> >  =20
> > @@ -482,6 +491,7 @@ static void cap_large_decr_cpu_apply(SpaprMachineSt=
ate *spapr,
> >   static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t va=
l,
> >                                    Error **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       uint8_t kvm_val =3D kvmppc_get_cap_count_cache_flush_assist();
> >  =20
> >       if (tcg_enabled() && val) {
> > @@ -504,14 +514,15 @@ static void cap_ccf_assist_apply(SpaprMachineStat=
e *spapr, uint8_t val,
> >               return;
> >           }
> >           error_setg(errp,
> > -"Requested count cache flush assist capability level not supported by =
kvm,"
> > -                   " try appending -machine cap-ccf-assist=3Doff");
> > +"Requested count cache flush assist capability level not supported by =
KVM");
> > +        error_append_hint(errp, "Try appending -machine cap-ccf-assist=
=3Doff\n");
> >       }
> >   }
> >  =20
> >   static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
> >                                   Error **errp)
> >   {
> > +    ERRP_AUTO_PROPAGATE();
> >       if (!val) {
> >           return; /* Disabled by default */
> >       }
> >=20
> >=20
>=20
>=20


