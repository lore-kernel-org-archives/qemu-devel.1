Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E94C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 02:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE22D20693
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 02:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZTS7PwH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE22D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht0vo-0006Kl-4B
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 22:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47755)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1ht0vN-0005nl-Fy
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 22:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ht0vM-0005l5-22
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 22:34:37 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44033 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ht0vK-0005iE-JW; Wed, 31 Jul 2019 22:34:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45zZBD4NPsz9sNF; Thu,  1 Aug 2019 12:34:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564626868;
 bh=2SCxjVtvUaxpNjIdAoz9KDAGhC0o9od6uTuug3ewizY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZTS7PwH0HV1WS8coV65FcPu1iI3PsvLm7JsahOSWt92ebja2G6+/vpJ/28ziF3OLR
 3nAUDqvnlVr1VUpbdeWRh5Pk9BYBI4iP3aH+1ZY9YyxlNyqkO6kpw0URrKqobCzAio
 D4Ipj4os3bNMgPF9/8fVxQcgXUNjyZnorzaNtrgg=
Date: Thu, 1 Aug 2019 12:14:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Black <daniel@linux.ibm.com>
Message-ID: <20190801021406.GA21024@umbus.fritz.box>
References: <20190731233438.483-1-daniel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20190731233438.483-1-daniel@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr: quantify error messages regarding
 capability settings
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
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2019 at 09:34:38AM +1000, Daniel Black wrote:
> Its not immediately obvious how cap-X=3Dy setting need to be applied
> to the command line so this has been clarified to "appending to the
> machine name" in spapr capability error messages.
>=20
> The wrong value messages have been left as is, as the user has found
> the right location.

Good idea, but I think it would be easier to follow if you just said
	"try -machine cap-whatever=3Don"
It's permitted to have multiple -machine options, so that works even
if you are currently using the default machine type.

>=20
> Signed-off-by: Daniel Black <daniel@linux.ibm.com>
> ---
>  hw/ppc/spapr_caps.c | 47 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index bbb001f84a..cf334fe595 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -37,6 +37,8 @@
> =20
>  #include "hw/ppc/spapr.h"
> =20
> +#define CAPABILITY_ERROR(X) "appending \"," X "\" to the machine name"
> +
>  typedef struct SpaprCapPossible {
>      int num;            /* size of vals array below */
>      const char *help;   /* help text for vals */
> @@ -194,10 +196,12 @@ static void cap_htm_apply(SpaprMachineState *spapr,=
 uint8_t val, Error **errp)
>      }
>      if (tcg_enabled()) {
>          error_setg(errp,
> -                   "No Transactional Memory support in TCG, try cap-htm=
=3Doff");
> +                   "No Transactional Memory support in TCG, try "
> +                   CAPABILITY_ERROR("cap-htm=3Doff"));
>      } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
>          error_setg(errp,
> -"KVM implementation does not support Transactional Memory, try cap-htm=
=3Doff"
> +"KVM implementation does not support Transactional Memory, try "
> +                   CAPABILITY_ERROR("cap-htm=3Doff")
>              );
>      }
>  }
> @@ -215,7 +219,8 @@ static void cap_vsx_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
>       * rid of anything that doesn't do VMX */
>      g_assert(env->insns_flags & PPC_ALTIVEC);
>      if (!(env->insns_flags2 & PPC2_VSX)) {
> -        error_setg(errp, "VSX support not available, try cap-vsx=3Doff");
> +        error_setg(errp, "VSX support not available, try "
> +                   CAPABILITY_ERROR("cap-vsx=3Doff"));
>      }
>  }
> =20
> @@ -229,7 +234,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
>          return;
>      }
>      if (!(env->insns_flags2 & PPC2_DFP)) {
> -        error_setg(errp, "DFP support not available, try cap-dfp=3Doff");
> +        error_setg(errp, "DFP support not available, try "
> +                   CAPABILITY_ERROR("cap-dfp=3Doff"));
>      }
>  }
> =20
> @@ -249,11 +255,13 @@ static void cap_safe_cache_apply(SpaprMachineState =
*spapr, uint8_t val,
>      if (tcg_enabled() && val) {
>          /* TCG only supports broken, allow other values and print a warn=
ing */
>          error_setg(&local_err,
> -                   "TCG doesn't support requested feature, cap-cfpc=3D%s=
",
> +                   "TCG doesn't support requested feature, use "
> +                   CAPABILITY_ERROR("cap-cfpc=3D%s"),
>                     cap_cfpc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe cache capability level not supported by kvm, try cap-cfp=
c=3D%s",
> +"Requested safe cache capability level not supported by kvm, try "
> +                   CAPABILITY_ERROR("cap-cfpc=3D%s"),
>                     cap_cfpc_possible.vals[kvm_val]);
>      }
> =20
> @@ -281,7 +289,8 @@ static void cap_safe_bounds_check_apply(SpaprMachineS=
tate *spapr, uint8_t val,
>                     cap_sbbc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe bounds check capability level not supported by kvm, try =
cap-sbbc=3D%s",
> +"Requested safe bounds check capability level not supported by kvm, try "
> +                   CAPABILITY_ERROR("cap-sbbc=3D%s"),
>                     cap_sbbc_possible.vals[kvm_val]);
>      }
> =20
> @@ -312,7 +321,8 @@ static void cap_safe_indirect_branch_apply(SpaprMachi=
neState *spapr,
>                     cap_ibs_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe indirect branch capability level not supported by kvm, t=
ry cap-ibs=3D%s",
> +"Requested safe indirect branch capability level not supported by kvm, t=
ry "
> +                   CAPABILITY_ERROR("cap-ibs=3D%s"),
>                     cap_ibs_possible.vals[kvm_val]);
>      }
> =20
> @@ -401,11 +411,13 @@ static void cap_nested_kvm_hv_apply(SpaprMachineSta=
te *spapr,
> =20
>      if (tcg_enabled()) {
>          error_setg(errp,
> -                   "No Nested KVM-HV support in tcg, try cap-nested-hv=
=3Doff");
> +                   "No Nested KVM-HV support in tcg, try "
> +                   CAPABILITY_ERROR("cap-nested-hv=3Doff"));
>      } else if (kvm_enabled()) {
>          if (!kvmppc_has_cap_nested_kvm_hv()) {
>              error_setg(errp,
> -"KVM implementation does not support Nested KVM-HV, try cap-nested-hv=3D=
off");
> +"KVM implementation does not support Nested KVM-HV, try "
> +                       CAPABILITY_ERROR("cap-nested-hv=3Doff"));
>          } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
>                  error_setg(errp,
>  "Error enabling cap-nested-hv with KVM, try cap-nested-hv=3Doff");
> @@ -435,10 +447,12 @@ static void cap_large_decr_apply(SpaprMachineState =
*spapr,
> =20
>          if (!kvm_nr_bits) {
>              error_setg(errp,
> -                       "No large decrementer support, try cap-large-decr=
=3Doff");
> +                       "No large decrementer support, try "
> +                        CAPABILITY_ERROR("cap-large-decr=3Doff"));
>          } else if (pcc->lrg_decr_bits !=3D kvm_nr_bits) {
>              error_setg(errp,
> -"KVM large decrementer size (%d) differs to model (%d), try -cap-large-d=
ecr=3Doff",
> +"KVM large decrementer size (%d) differs to model (%d), try "
> +                CAPABILITY_ERROR("cap-large-decr=3Doff"),
>                  kvm_nr_bits, pcc->lrg_decr_bits);
>          }
>      }
> @@ -454,7 +468,8 @@ static void cap_large_decr_cpu_apply(SpaprMachineStat=
e *spapr,
>      if (kvm_enabled()) {
>          if (kvmppc_enable_cap_large_decr(cpu, val)) {
>              error_setg(errp,
> -                       "No large decrementer support, try cap-large-decr=
=3Doff");
> +                       "No large decrementer support, try "
> +                       CAPABILITY_ERROR("cap-large-decr=3Doff"));
>          }
>      }
> =20
> @@ -474,10 +489,12 @@ static void cap_ccf_assist_apply(SpaprMachineState =
*spapr, uint8_t val,
>      if (tcg_enabled() && val) {
>          /* TODO - for now only allow broken for TCG */
>          error_setg(errp,
> -"Requested count cache flush assist capability level not supported by tc=
g, try cap-ccf-assist=3Doff");
> +"Requested count cache flush assist capability level not supported by tc=
g, try "
> +                   CAPABILITY_ERROR("cap-ccf-assist=3Doff"));
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested count cache flush assist capability level not supported by kv=
m, try cap-ccf-assist=3Doff");
> +"Requested count cache flush assist capability level not supported by kv=
m, try "
> +                   CAPABILITY_ERROR("cap-ccf-assist=3Doff"));
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1CSusACgkQbDjKyiDZ
s5LG4Q/8C7gMlc3gWzna7g/7GpYVsE5Vq5xcrPuFJltsF7A8yoSDo33uthMukYiH
lAFDpkS6aklCWyvOSlXcTlqJ7A2mKekMHy/PpCxi3X3bYTaO4w35Hk87aen9RoMG
XLSXqLzHTVgULDHMePTe+0iyrVpjjYtKxGC75K2TZ963LPJRW8SOT6tDu/VPKvl+
TQu+tVpdsPQ0K8LCeUG2Qhv4lVdorJeafgsq9jW9VMTI9Fjbb2NXPxLZIrSHFK77
+nrPaqbkdEqKmwwgm9E5jmYa/hgaNeMPABlVkebGFuzUAqCO8lqUtx3rGTrFFGDL
o58F7Arbgmdr0e4ywvulwOaXxIfu/T4dpPoM7MCd2nkLhkFwFG9E1/jaUfYUhZ9s
UmyeM2VKsxEQHAwtgHrKAjoD2dQkpaQHCwblXCP87MJrc4Um8WOiLleyCqX7uE/G
Cvji4u4E49XQeRM4XJjOy8uWv9GBBIRm6m/fkmV0/MY99cwvf7UvZ3VysyESIbtV
4zQ1PIaFdVev5pSfsKJGdWiiHs160nd0tYUI9gXvEsBG3eHZxZhBu3c/6xYvo09o
blYNKL7sA8CmxaUDKObL9d2Xg2krazC75TwYJdC2yPhUZXJxpc8Km9wBZ5TeGFK8
yLOwz3HxISL2zI2x7W6a781hgbkCxSG0fLiyUz0gESdqszrzfVA=
=IOq3
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

