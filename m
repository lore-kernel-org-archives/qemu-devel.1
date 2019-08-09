Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838CEC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 05:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF5B214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 05:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HNLk3PVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF5B214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvx1x-0008Vm-Ce
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 01:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvx0o-00082y-Nd
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 01:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvx0n-0008RS-4y
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 01:00:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59577)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hvx0m-0008OG-En; Fri, 09 Aug 2019 01:00:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464Y2n614kz9sN4; Fri,  9 Aug 2019 15:00:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565326817;
 bh=nKbb1o5NWpU+Q0sxeXxTwUPM/I28n5Y9KyzOHTXHarM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HNLk3PVLlkuMXy7c8YX1+bLsJavbk1uu+Go85s22RWjwJ4tfmcEo8ZtKdhzDqYPBr
 FqeIyOnXUGxnOF8mV4LsFm8lKAiRYaxjthcV384iPPwvy7Xh1NovGoxZtidabGR6HI
 cBcyXVfWmnTfd3vU6+xoLuRuhYEMboLdGUd/QNBc=
Date: Fri, 9 Aug 2019 14:58:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Black <daniel@linux.ibm.com>
Message-ID: <20190809045825.GQ5465@umbus.fritz.box>
References: <20190805050959.19935-1-daniel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oDto3OTLsk6uOlQH"
Content-Disposition: inline
In-Reply-To: <20190805050959.19935-1-daniel@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3] spapr: quantify error messages
 regarding capability settings
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
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oDto3OTLsk6uOlQH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 03:09:58PM +1000, Daniel Black wrote:
> Its not immediately obvious how cap-X=3DY setting need to be applied
> to the command line so, for spapr capability hints, this has been clarifi=
ed to:
>=20
>   ..try appending -machine cap-X=3DY
>=20
> The wrong value messages have been left as is, as the user has found the =
right
> location.
>=20
> Warning messages have been left as is for now.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Daniel Black <daniel@linux.ibm.com>

So, I'm sorry to nitpick, but..
[snip]
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index bbb001f84a..b06faee7f6 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -37,6 +37,8 @@
> =20
>  #include "hw/ppc/spapr.h"
> =20
> +#define CAPABILITY_HINT(X) " try appending -machine " X

=2E. I'd prefer to see the new messages just written inline rather than
this macro.  I think the increased duplication is less important than
the reduced greppability that the macro introduces.

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
> +                   "No Transactional Memory support in TCG,"
> +                   CAPABILITY_HINT("cap-htm=3Doff"));
>      } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
>          error_setg(errp,
> -"KVM implementation does not support Transactional Memory, try cap-htm=
=3Doff"
> +"KVM implementation does not support Transactional Memory,"
> +                   CAPABILITY_HINT("cap-htm=3Doff")
>              );
>      }
>  }
> @@ -215,7 +219,8 @@ static void cap_vsx_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
>       * rid of anything that doesn't do VMX */
>      g_assert(env->insns_flags & PPC_ALTIVEC);
>      if (!(env->insns_flags2 & PPC2_VSX)) {
> -        error_setg(errp, "VSX support not available, try cap-vsx=3Doff");
> +        error_setg(errp, "VSX support not available,"
> +                   CAPABILITY_HINT("cap-vsx=3Doff"));
>      }
>  }
> =20
> @@ -229,7 +234,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
>          return;
>      }
>      if (!(env->insns_flags2 & PPC2_DFP)) {
> -        error_setg(errp, "DFP support not available, try cap-dfp=3Doff");
> +        error_setg(errp, "DFP support not available,"
> +                   CAPABILITY_HINT("cap-dfp=3Doff"));
>      }
>  }
> =20
> @@ -253,7 +259,8 @@ static void cap_safe_cache_apply(SpaprMachineState *s=
papr, uint8_t val,
>                     cap_cfpc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe cache capability level not supported by kvm, try cap-cfp=
c=3D%s",
> +                   "Requested safe cache capability level not supported =
by kvm,"
> +                   CAPABILITY_HINT("cap-cfpc=3D%s"),
>                     cap_cfpc_possible.vals[kvm_val]);
>      }
> =20
> @@ -281,7 +288,8 @@ static void cap_safe_bounds_check_apply(SpaprMachineS=
tate *spapr, uint8_t val,
>                     cap_sbbc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe bounds check capability level not supported by kvm, try =
cap-sbbc=3D%s",
> +"Requested safe bounds check capability level not supported by kvm,"
> +                   CAPABILITY_HINT("cap-sbbc=3D%s"),
>                     cap_sbbc_possible.vals[kvm_val]);
>      }
> =20
> @@ -312,7 +320,8 @@ static void cap_safe_indirect_branch_apply(SpaprMachi=
neState *spapr,
>                     cap_ibs_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe indirect branch capability level not supported by kvm, t=
ry cap-ibs=3D%s",
> +"Requested safe indirect branch capability level not supported by kvm,"
> +                   CAPABILITY_HINT("cap-ibs=3D%s"),
>                     cap_ibs_possible.vals[kvm_val]);
>      }
> =20
> @@ -401,11 +410,13 @@ static void cap_nested_kvm_hv_apply(SpaprMachineSta=
te *spapr,
> =20
>      if (tcg_enabled()) {
>          error_setg(errp,
> -                   "No Nested KVM-HV support in tcg, try cap-nested-hv=
=3Doff");
> +                   "No Nested KVM-HV support in tcg,"
> +                   CAPABILITY_HINT("cap-nested-hv=3Doff"));
>      } else if (kvm_enabled()) {
>          if (!kvmppc_has_cap_nested_kvm_hv()) {
>              error_setg(errp,
> -"KVM implementation does not support Nested KVM-HV, try cap-nested-hv=3D=
off");
> +"KVM implementation does not support Nested KVM-HV,"
> +                       CAPABILITY_HINT("cap-nested-hv=3Doff"));
>          } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
>                  error_setg(errp,
>  "Error enabling cap-nested-hv with KVM, try cap-nested-hv=3Doff");
> @@ -435,10 +446,12 @@ static void cap_large_decr_apply(SpaprMachineState =
*spapr,
> =20
>          if (!kvm_nr_bits) {
>              error_setg(errp,
> -                       "No large decrementer support, try cap-large-decr=
=3Doff");
> +                       "No large decrementer support,"
> +                        CAPABILITY_HINT("cap-large-decr=3Doff"));
>          } else if (pcc->lrg_decr_bits !=3D kvm_nr_bits) {
>              error_setg(errp,
> -"KVM large decrementer size (%d) differs to model (%d), try -cap-large-d=
ecr=3Doff",
> +"KVM large decrementer size (%d) differs to model (%d),"
> +                CAPABILITY_HINT("cap-large-decr=3Doff"),
>                  kvm_nr_bits, pcc->lrg_decr_bits);
>          }
>      }
> @@ -454,7 +467,8 @@ static void cap_large_decr_cpu_apply(SpaprMachineStat=
e *spapr,
>      if (kvm_enabled()) {
>          if (kvmppc_enable_cap_large_decr(cpu, val)) {
>              error_setg(errp,
> -                       "No large decrementer support, try cap-large-decr=
=3Doff");
> +                       "No large decrementer support,"
> +                       CAPABILITY_HINT("cap-large-decr=3Doff"));
>          }
>      }
> =20
> @@ -474,10 +488,12 @@ static void cap_ccf_assist_apply(SpaprMachineState =
*spapr, uint8_t val,
>      if (tcg_enabled() && val) {
>          /* TODO - for now only allow broken for TCG */
>          error_setg(errp,
> -"Requested count cache flush assist capability level not supported by tc=
g, try cap-ccf-assist=3Doff");
> +"Requested count cache flush assist capability level not supported by tc=
g,"
> +                   CAPABILITY_HINT("cap-ccf-assist=3Doff"));
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested count cache flush assist capability level not supported by kv=
m, try cap-ccf-assist=3Doff");
> +"Requested count cache flush assist capability level not supported by kv=
m,"
> +                   CAPABILITY_HINT("cap-ccf-assist=3Doff"));
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oDto3OTLsk6uOlQH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1M/XEACgkQbDjKyiDZ
s5I43A//QBlVZRhtAN9zRe4D4XOcb4Ju9KLjhNhj6vzS+rphBSX0NI6Z5ZlFhwlB
RDwxImxqleUspmFplrdpHIXIRjyQgYHaEhN8nzOfS5ztEIcXYwgTOK2olnn1nya3
WhXu34Q6jh+JieEykgH0r6lP7oK51n9E5J1ILjuxntlXaiDLbNobBOv6ZhHY2kgb
5pnw/NF4PSGBxMGqNZlOc9vJtbt0Xp4Kdz7VkQEaYnlNReOwRFY9vVl68DPHNYsN
MdEsCudNDMASkQeP+JlIIabJf2RKj05nSRMpZyok6VfkJNhVVpEd1J5vK9nimfJB
ZG5RGUPHG9yJQXGQCaj3XKgH1O/8HwA2r/0/Wgc3haGlVxLMKz6ZN/qFpFADSDn3
YkEkbRVpSJfIROWTEhFC3A58kbeey1uf4FP7opT+W7wYXSUv9+jHmWk9aeE2RXez
vXnt7hAJbp5XP5oRA9PH6/rIKd96vHS/vnB/sKERqkm5FO65I0pQfm0I3lQ4DvYd
kbnG4AihR3DBPzv5TE8hKAGMbtIvgWtW57fmz/Lv7KLlJH01AUP9WUBapIL+7kqo
wVtBKd/EKYhrYHbQBP2wbDAFSVlYYVVURzizNs3SCDB7b/7zh5XQm1ruym1aktUC
0eLQKNw46UQhLFEXIsk0ts5mysmocc5aUEE1xUCCzo1dX05/STA=
=wesd
-----END PGP SIGNATURE-----

--oDto3OTLsk6uOlQH--

