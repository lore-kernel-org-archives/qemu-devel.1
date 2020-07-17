Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D80CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B7B2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GCM5ZlKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B7B2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJcX-00035Y-Dp
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwJVQ-0007ff-Is; Fri, 17 Jul 2020 02:06:00 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwJVN-0005zQ-Ka; Fri, 17 Jul 2020 02:06:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B7LG84fFXz9sRR; Fri, 17 Jul 2020 16:05:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594965952;
 bh=drDjIusGUjuk1Sr1Hr0Ih9PzZvCsfpuzBLOHSajWzUo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GCM5ZlKzo+8haBC/RS6x5GNXFNzrc1YLMYstiDGDZLtLu2Ros2GcIUqA5zYHbjGIm
 bVLN/m066rW80cTm5AOBsQIofar6a7+Tlgi4N9FOd7ZAw8SnIqGno6PN2Wz8hGErdh
 W8BT2aDbTcWp4MPgVgDbK9Wiwc8SQvrKCIpOj6kU=
Date: Fri, 17 Jul 2020 15:57:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 for-5.2 1/2] spapr: Use error_append_hint() in
 spapr_caps.c
Message-ID: <20200717055720.GH5607@umbus.fritz.box>
References: <159491945918.188975.4358645698778061430.stgit@bahia.lan>
 <159491947184.188975.5055299566400098290.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
In-Reply-To: <159491947184.188975.5055299566400098290.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 07:11:11PM +0200, Greg Kurz wrote:
> We have a dedicated error API for hints. Use it instead of embedding
> the hint in the error message, as recommanded in the "qapi/error.h"
> header file.
>=20
> Since spapr_caps_apply() passes &error_fatal, all functions must
> also call the ERRP_GUARD() macro for error_append_hint() to be
> functional.
>=20
> While here, have cap_fwnmi_apply(), which already uses
> error_append_hint(), to call ERRP_GUARD() as well.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-5.2.

> ---
>  hw/ppc/spapr_caps.c |   89 +++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 50 insertions(+), 39 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 3225fc5a2edc..275f5bd0342c 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -180,24 +180,24 @@ static void spapr_cap_set_pagesize(Object *obj, Vis=
itor *v, const char *name,
> =20
>  static void cap_htm_apply(SpaprMachineState *spapr, uint8_t val, Error *=
*errp)
>  {
> +    ERRP_GUARD();
>      if (!val) {
>          /* TODO: We don't support disabling htm yet */
>          return;
>      }
>      if (tcg_enabled()) {
> -        error_setg(errp,
> -                   "No Transactional Memory support in TCG,"
> -                   " try appending -machine cap-htm=3Doff");
> +        error_setg(errp, "No Transactional Memory support in TCG");
> +        error_append_hint(errp, "Try appending -machine cap-htm=3Doff\n"=
);
>      } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
>          error_setg(errp,
> -"KVM implementation does not support Transactional Memory,"
> -                   " try appending -machine cap-htm=3Doff"
> -            );
> +                   "KVM implementation does not support Transactional Me=
mory");
> +        error_append_hint(errp, "Try appending -machine cap-htm=3Doff\n"=
);
>      }
>  }
> =20
>  static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error *=
*errp)
>  {
> +    ERRP_GUARD();
>      PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
> @@ -209,13 +209,14 @@ static void cap_vsx_apply(SpaprMachineState *spapr,=
 uint8_t val, Error **errp)
>       * rid of anything that doesn't do VMX */
>      g_assert(env->insns_flags & PPC_ALTIVEC);
>      if (!(env->insns_flags2 & PPC2_VSX)) {
> -        error_setg(errp, "VSX support not available,"
> -                   " try appending -machine cap-vsx=3Doff");
> +        error_setg(errp, "VSX support not available");
> +        error_append_hint(errp, "Try appending -machine cap-vsx=3Doff\n"=
);
>      }
>  }
> =20
>  static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error *=
*errp)
>  {
> +    ERRP_GUARD();
>      PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
> @@ -224,8 +225,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
>          return;
>      }
>      if (!(env->insns_flags2 & PPC2_DFP)) {
> -        error_setg(errp, "DFP support not available,"
> -                   " try appending -machine cap-dfp=3Doff");
> +        error_setg(errp, "DFP support not available");
> +        error_append_hint(errp, "Try appending -machine cap-dfp=3Doff\n"=
);
>      }
>  }
> =20
> @@ -239,6 +240,7 @@ SpaprCapPossible cap_cfpc_possible =3D {
>  static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>                                   Error **errp)
>  {
> +    ERRP_GUARD();
>      uint8_t kvm_val =3D  kvmppc_get_cap_safe_cache();
> =20
>      if (tcg_enabled() && val) {
> @@ -247,9 +249,9 @@ static void cap_safe_cache_apply(SpaprMachineState *s=
papr, uint8_t val,
>                      cap_cfpc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -                   "Requested safe cache capability level not supported =
by kvm,"
> -                   " try appending -machine cap-cfpc=3D%s",
> -                   cap_cfpc_possible.vals[kvm_val]);
> +                   "Requested safe cache capability level not supported =
by KVM");
> +        error_append_hint(errp, "Try appending -machine cap-cfpc=3D%s\n",
> +                          cap_cfpc_possible.vals[kvm_val]);
>      }
>  }
> =20
> @@ -263,6 +265,7 @@ SpaprCapPossible cap_sbbc_possible =3D {
>  static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_=
t val,
>                                          Error **errp)
>  {
> +    ERRP_GUARD();
>      uint8_t kvm_val =3D  kvmppc_get_cap_safe_bounds_check();
> =20
>      if (tcg_enabled() && val) {
> @@ -271,9 +274,9 @@ static void cap_safe_bounds_check_apply(SpaprMachineS=
tate *spapr, uint8_t val,
>                      cap_sbbc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe bounds check capability level not supported by kvm,"
> -                   " try appending -machine cap-sbbc=3D%s",
> -                   cap_sbbc_possible.vals[kvm_val]);
> +"Requested safe bounds check capability level not supported by KVM");
> +        error_append_hint(errp, "Try appending -machine cap-sbbc=3D%s\n",
> +                          cap_sbbc_possible.vals[kvm_val]);
>      }
>  }
> =20
> @@ -290,6 +293,7 @@ SpaprCapPossible cap_ibs_possible =3D {
>  static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
>                                             uint8_t val, Error **errp)
>  {
> +    ERRP_GUARD();
>      uint8_t kvm_val =3D kvmppc_get_cap_safe_indirect_branch();
> =20
>      if (tcg_enabled() && val) {
> @@ -298,9 +302,9 @@ static void cap_safe_indirect_branch_apply(SpaprMachi=
neState *spapr,
>                      cap_ibs_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe indirect branch capability level not supported by kvm,"
> -                   " try appending -machine cap-ibs=3D%s",
> -                   cap_ibs_possible.vals[kvm_val]);
> +"Requested safe indirect branch capability level not supported by KVM");
> +        error_append_hint(errp, "Try appending -machine cap-ibs=3D%s\n",
> +                          cap_ibs_possible.vals[kvm_val]);
>      }
>  }
> =20
> @@ -377,23 +381,25 @@ static void cap_hpt_maxpagesize_cpu_apply(SpaprMach=
ineState *spapr,
>  static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>                                      uint8_t val, Error **errp)
>  {
> +    ERRP_GUARD();
>      if (!val) {
>          /* capability disabled by default */
>          return;
>      }
> =20
>      if (tcg_enabled()) {
> -        error_setg(errp,
> -                   "No Nested KVM-HV support in tcg,"
> -                   " try appending -machine cap-nested-hv=3Doff");
> +        error_setg(errp, "No Nested KVM-HV support in TCG");
> +        error_append_hint(errp, "Try appending -machine cap-nested-hv=3D=
off\n");
>      } else if (kvm_enabled()) {
>          if (!kvmppc_has_cap_nested_kvm_hv()) {
>              error_setg(errp,
> -"KVM implementation does not support Nested KVM-HV,"
> -                       " try appending -machine cap-nested-hv=3Doff");
> +                       "KVM implementation does not support Nested KVM-H=
V");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-nested-hv=3Dof=
f\n");
>          } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
> -                error_setg(errp,
> -"Error enabling cap-nested-hv with KVM, try cap-nested-hv=3Doff");
> +                error_setg(errp, "Error enabling cap-nested-hv with KVM"=
);
> +                error_append_hint(errp,
> +                                  "Try appending -machine cap-nested-hv=
=3Doff\n");
>          }
>      }
>  }
> @@ -401,6 +407,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState=
 *spapr,
>  static void cap_large_decr_apply(SpaprMachineState *spapr,
>                                   uint8_t val, Error **errp)
>  {
> +    ERRP_GUARD();
>      PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
> @@ -411,22 +418,23 @@ static void cap_large_decr_apply(SpaprMachineState =
*spapr,
>      if (tcg_enabled()) {
>          if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
>                                spapr->max_compat_pvr)) {
> -            error_setg(errp,
> -                "Large decrementer only supported on POWER9, try -cpu PO=
WER9");
> +            error_setg(errp, "Large decrementer only supported on POWER9=
");
> +            error_append_hint(errp, "Try -cpu POWER9\n");
>              return;
>          }
>      } else if (kvm_enabled()) {
>          int kvm_nr_bits =3D kvmppc_get_cap_large_decr();
> =20
>          if (!kvm_nr_bits) {
> -            error_setg(errp,
> -                       "No large decrementer support,"
> -                        " try appending -machine cap-large-decr=3Doff");
> +            error_setg(errp, "No large decrementer support");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-large-decr=3Do=
ff\n");
>          } else if (pcc->lrg_decr_bits !=3D kvm_nr_bits) {
>              error_setg(errp,
> -"KVM large decrementer size (%d) differs to model (%d),"
> -                " try appending -machine cap-large-decr=3Doff",
> -                kvm_nr_bits, pcc->lrg_decr_bits);
> +                       "KVM large decrementer size (%d) differs to model=
 (%d)",
> +                       kvm_nr_bits, pcc->lrg_decr_bits);
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-large-decr=3Do=
ff\n");
>          }
>      }
>  }
> @@ -435,14 +443,15 @@ static void cap_large_decr_cpu_apply(SpaprMachineSt=
ate *spapr,
>                                       PowerPCCPU *cpu,
>                                       uint8_t val, Error **errp)
>  {
> +    ERRP_GUARD();
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong lpcr =3D env->spr[SPR_LPCR];
> =20
>      if (kvm_enabled()) {
>          if (kvmppc_enable_cap_large_decr(cpu, val)) {
> -            error_setg(errp,
> -                       "No large decrementer support,"
> -                       " try appending -machine cap-large-decr=3Doff");
> +            error_setg(errp, "No large decrementer support");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-large-decr=3Do=
ff\n");
>          }
>      }
> =20
> @@ -457,6 +466,7 @@ static void cap_large_decr_cpu_apply(SpaprMachineStat=
e *spapr,
>  static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>                                   Error **errp)
>  {
> +    ERRP_GUARD();
>      uint8_t kvm_val =3D kvmppc_get_cap_count_cache_flush_assist();
> =20
>      if (tcg_enabled() && val) {
> @@ -479,14 +489,15 @@ static void cap_ccf_assist_apply(SpaprMachineState =
*spapr, uint8_t val,
>              return;
>          }
>          error_setg(errp,
> -"Requested count cache flush assist capability level not supported by kv=
m,"
> -                   " try appending -machine cap-ccf-assist=3Doff");
> +                   "Requested count cache flush assist capability level =
not supported by KVM");
> +        error_append_hint(errp, "Try appending -machine cap-ccf-assist=
=3Doff\n");
>      }
>  }
> =20
>  static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
>                                  Error **errp)
>  {
> +    ERRP_GUARD();
>      if (!val) {
>          return; /* Disabled by default */
>      }
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8RPcAACgkQbDjKyiDZ
s5Kfsg//YyVTw54B3bZsQPAh5FL8vm1mrfAlHUJ0KF/XyLiL/kRExuk1yxp23RHb
gaenuTnoqIml0s9vBzjYdcHtqhWSxM/pn3vUX/5GZzZ66ao97TG4Tz/FXMnSP+Bt
q9+AZMvt+WQsABnxeJ+qRXVioFdGxjGuIpOkadFWdgE7XKKGpxIMAX60zphuBno+
c8Tnjomsc9iW/cZ8GP5Q6cbzu/gmnNasIukBceyOP/cGYmYWWAFtQAciSk83bQe/
IwFeVaYBj1mi3CUnw8ymBE4xozfjeBtDpR9ebCb7HnJC/58SFuSNAhuW6t4AHLoh
OMM2VOiDGgthckF//wXh81fYUtMT5aNe5aNJcrM+ltoyLIDEClV82OHP2MOT4ep8
ey13ajfStsiS1VqpP4ZnsawqWt8VMob+EvOUUtbQzx4+nkhktxZZSSlUzuaKFVfd
iAz3WSpDbPNPKBi/BrLta9PEuDkv9uPPJgoJJA2Z1OGfF5LfSwoSYiCdZTBB82qU
8B+4CUu86TTrUub+cnc3uCuj0mKTCsRWl5Iz6b5Toe2CCxX7pyvzb95OqSHvgKCz
uefLLRg1A4kYykx9DdkWoxjtQrWBr3X4ZRhZLeyCn2uFDVRul88D2IQ2ZP2uCWyb
H/eb2GvfeYMwAIvNt9wNYBtgpIvcSnNKQU+UAlXL6P4xsSts3lk=
=xmNv
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--

