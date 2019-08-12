Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3580C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC162085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KBkCH3YT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC162085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx6QE-0006wJ-NB
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 05:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hx6P3-0005xb-AW
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hx6P1-00043a-OM
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:14:09 -0400
Received: from ozlabs.org ([203.11.71.1]:56177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hx6P0-0003xt-8V; Mon, 12 Aug 2019 05:14:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 466VX81zp4z9sNF; Mon, 12 Aug 2019 19:14:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565601240;
 bh=EVzNSEWRnzRDGYWDHfM6BNGsVEnexdpQppL+IqF2Thg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KBkCH3YTucKJS4F1cke4CUgnc1TQ2htuX7DrL77UatCdVmX//aeIp000qknhAHWBq
 HhwEZIgJrkYuHkkX948wgbRPK6lRgii7hoolcQwv5kwZmLtE8lMaqlk+SAh8a/+ydb
 NrvXbyeGV8hMBGHT8IWXSwtR6BGyQxKWHK4s+COI=
Date: Mon, 12 Aug 2019 18:00:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Black <daniel@linux.ibm.com>
Message-ID: <20190812080034.GB3947@umbus.fritz.box>
References: <20190812071044.30806-1-daniel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20190812071044.30806-1-daniel@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v4] spapr: quantify error messages
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
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 05:10:44PM +1000, Daniel Black wrote:
> Its not immediately obvious how cap-X=3DY setting need to be applied
> to the command line so, for spapr capability error messages, this
> has been clarified to:
>=20
>  appending -machine cap-X=3DY
>=20
> The wrong value messages have been left as is, as the user has found
> the right location.

Applied to ppc-for-4.2.

>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Daniel Black <daniel@linux.ibm.com>
> ---
> v4 Message inline rather than macro. greppability nitpick accepted with
> grace and the magic of %s/CAPABILITY_HINT("\([^"]*\)")/" try appending -m=
achine \1"/g.
> v3 Hint, and not all messages, (can't use error_append_hint on
> error_fatal) from Greg Kurz
> v2 Improved error message thanks David Gibson
>=20
> Left the "appending" as its not obvious more that one -machine
> arguement is allowed.
>=20
>  hw/ppc/spapr_caps.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index bbb001f84a..405286db6f 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -194,10 +194,12 @@ static void cap_htm_apply(SpaprMachineState *spapr,=
 uint8_t val, Error **errp)
>      }
>      if (tcg_enabled()) {
>          error_setg(errp,
> -                   "No Transactional Memory support in TCG, try cap-htm=
=3Doff");
> +                   "No Transactional Memory support in TCG,"
> +                   " try appending -machine cap-htm=3Doff");
>      } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
>          error_setg(errp,
> -"KVM implementation does not support Transactional Memory, try cap-htm=
=3Doff"
> +"KVM implementation does not support Transactional Memory,"
> +                   " try appending -machine cap-htm=3Doff"
>              );
>      }
>  }
> @@ -215,7 +217,8 @@ static void cap_vsx_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
>       * rid of anything that doesn't do VMX */
>      g_assert(env->insns_flags & PPC_ALTIVEC);
>      if (!(env->insns_flags2 & PPC2_VSX)) {
> -        error_setg(errp, "VSX support not available, try cap-vsx=3Doff");
> +        error_setg(errp, "VSX support not available,"
> +                   " try appending -machine cap-vsx=3Doff");
>      }
>  }
> =20
> @@ -229,7 +232,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
>          return;
>      }
>      if (!(env->insns_flags2 & PPC2_DFP)) {
> -        error_setg(errp, "DFP support not available, try cap-dfp=3Doff");
> +        error_setg(errp, "DFP support not available,"
> +                   " try appending -machine cap-dfp=3Doff");
>      }
>  }
> =20
> @@ -253,7 +257,8 @@ static void cap_safe_cache_apply(SpaprMachineState *s=
papr, uint8_t val,
>                     cap_cfpc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe cache capability level not supported by kvm, try cap-cfp=
c=3D%s",
> +                   "Requested safe cache capability level not supported =
by kvm,"
> +                   " try appending -machine cap-cfpc=3D%s",
>                     cap_cfpc_possible.vals[kvm_val]);
>      }
> =20
> @@ -281,7 +286,8 @@ static void cap_safe_bounds_check_apply(SpaprMachineS=
tate *spapr, uint8_t val,
>                     cap_sbbc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe bounds check capability level not supported by kvm, try =
cap-sbbc=3D%s",
> +"Requested safe bounds check capability level not supported by kvm,"
> +                   " try appending -machine cap-sbbc=3D%s",
>                     cap_sbbc_possible.vals[kvm_val]);
>      }
> =20
> @@ -312,7 +318,8 @@ static void cap_safe_indirect_branch_apply(SpaprMachi=
neState *spapr,
>                     cap_ibs_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe indirect branch capability level not supported by kvm, t=
ry cap-ibs=3D%s",
> +"Requested safe indirect branch capability level not supported by kvm,"
> +                   " try appending -machine cap-ibs=3D%s",
>                     cap_ibs_possible.vals[kvm_val]);
>      }
> =20
> @@ -401,11 +408,13 @@ static void cap_nested_kvm_hv_apply(SpaprMachineSta=
te *spapr,
> =20
>      if (tcg_enabled()) {
>          error_setg(errp,
> -                   "No Nested KVM-HV support in tcg, try cap-nested-hv=
=3Doff");
> +                   "No Nested KVM-HV support in tcg,"
> +                   " try appending -machine cap-nested-hv=3Doff");
>      } else if (kvm_enabled()) {
>          if (!kvmppc_has_cap_nested_kvm_hv()) {
>              error_setg(errp,
> -"KVM implementation does not support Nested KVM-HV, try cap-nested-hv=3D=
off");
> +"KVM implementation does not support Nested KVM-HV,"
> +                       " try appending -machine cap-nested-hv=3Doff");
>          } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
>                  error_setg(errp,
>  "Error enabling cap-nested-hv with KVM, try cap-nested-hv=3Doff");
> @@ -435,10 +444,12 @@ static void cap_large_decr_apply(SpaprMachineState =
*spapr,
> =20
>          if (!kvm_nr_bits) {
>              error_setg(errp,
> -                       "No large decrementer support, try cap-large-decr=
=3Doff");
> +                       "No large decrementer support,"
> +                        " try appending -machine cap-large-decr=3Doff");
>          } else if (pcc->lrg_decr_bits !=3D kvm_nr_bits) {
>              error_setg(errp,
> -"KVM large decrementer size (%d) differs to model (%d), try -cap-large-d=
ecr=3Doff",
> +"KVM large decrementer size (%d) differs to model (%d),"
> +                " try appending -machine cap-large-decr=3Doff",
>                  kvm_nr_bits, pcc->lrg_decr_bits);
>          }
>      }
> @@ -454,7 +465,8 @@ static void cap_large_decr_cpu_apply(SpaprMachineStat=
e *spapr,
>      if (kvm_enabled()) {
>          if (kvmppc_enable_cap_large_decr(cpu, val)) {
>              error_setg(errp,
> -                       "No large decrementer support, try cap-large-decr=
=3Doff");
> +                       "No large decrementer support,"
> +                       " try appending -machine cap-large-decr=3Doff");
>          }
>      }
> =20
> @@ -474,10 +486,12 @@ static void cap_ccf_assist_apply(SpaprMachineState =
*spapr, uint8_t val,
>      if (tcg_enabled() && val) {
>          /* TODO - for now only allow broken for TCG */
>          error_setg(errp,
> -"Requested count cache flush assist capability level not supported by tc=
g, try cap-ccf-assist=3Doff");
> +"Requested count cache flush assist capability level not supported by tc=
g,"
> +                   " try appending -machine cap-ccf-assist=3Doff");
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested count cache flush assist capability level not supported by kv=
m, try cap-ccf-assist=3Doff");
> +"Requested count cache flush assist capability level not supported by kv=
m,"
> +                   " try appending -machine cap-ccf-assist=3Doff");
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1RHKIACgkQbDjKyiDZ
s5Jj2g//aNn2hy+xvNmu0JblEO+Z7+SV/fXYBuI8PUEfy0KkSnq5y4foh8yhGP6Q
ldxhw6XOJmZtM5J7+apwz8yfdq9wnwSKwqBMiMCoi8wXjPBd0bX5YoMBohGtZLAJ
n1EcxHF71kx9OwyNZoq1Co6WvVaU/L+B46A+13lIK2Owp+jJtkA/Uy0cKbFy9eR5
euTAlkRW0BetJFvPXHPr3uhgyDuhWSgvhXzWgxWGCXjh+BvToKa6BtmrVrq1OZBp
aNr3HcesKT3Mvz1gqm1ICfOk2zwVC+ebn+pFeFvHlbzbsY91+VsOmRBsv3nZIKIe
FdxaeltIsPr+R25nwZh06TnhKZD1uTpKJCz1kKKVrp2iL2gV+NZPVleQTbtWrmzA
H1GFYHXHskJ2amO8N7Olg/xD6lSlnT9D4pH1uny/FRv7vjv/Ki3RznnDYFqf1kHb
Bo8tKcRtq6NhSvIYHeWIf24T0V78vDlQEzTnOnpWrguQScnJTT2wgrhCYF3dv70i
1PG8QuwOF/w1qjoaZLxsJuQp42JbarfKlSmKX5X9RLAIYPnyEjtfM4KFaSUyH37U
J98Jyy8fMuxVrGbl1ucHtNHu12hnpFOy+yYVpnBrEAqKbyEPKkTwvybzxUmvbSJh
qrv9Uos6vZNaZ5X0wZqd83NJnB4yWiks9g04Yxx6rFIKYRHjTnw=
=PyPV
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

