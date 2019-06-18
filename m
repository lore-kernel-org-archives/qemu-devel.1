Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD47DC31E51
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4EE52085A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SMqgoX8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EE52085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdQNt-0000rT-PB
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 22:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37453)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdQMx-0000K8-3F
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hdQMv-0001vR-NW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:30:39 -0400
Received: from ozlabs.org ([203.11.71.1]:53877)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hdQMr-0001ez-5F; Tue, 18 Jun 2019 22:30:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45T87C557yz9sN6; Wed, 19 Jun 2019 12:30:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560911415;
 bh=genMs38bLvjxVrGJEFYJpMBpB6ORD12A4TVdU/vrPbI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SMqgoX8pz0zGzvNVT6jHZHmQhXG0iLv5TIqQrDAkz2QWtFvOqM9TY42xV9wgiEYXN
 tDQWQLbbpacz0WLvXDQIQGAUhQaLbslXb1EkDq6TfH7jJTOEPr9PEsmuKZKm92r8hQ
 b+p9Crx+QmwxkcV6jBJaeKZ2+rrjnhsoYyDT5HD4=
Date: Tue, 18 Jun 2019 22:18:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190618121839.GE3673@umbus.BigPond>
References: <156077253666.424706.6104557911104491047.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <156077253666.424706.6104557911104491047.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] xics/spapr: Only emulated XICS should use
 RTAS/hypercalls emulation
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 01:55:36PM +0200, Greg Kurz wrote:
> Checking that we're not using the in-kernel XICS is ok with the "xics"
> interrupt controller mode, but it is definitely not enough with the
> other modes since the guest could be using XIVE.
>=20
> Ensure XIVE is not in use when emulated XICS RTAS/hypercalls are
> called.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics_spapr.c |   53 +++++++++++++++++++++++++-------------------=
------
>  1 file changed, 27 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 8d605b68a7a0..7cd3c93d719f 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -41,22 +41,23 @@
>   * Guest interfaces
>   */
> =20
> -static bool check_in_kernel_xics(const char *func)
> +static bool check_emulated_xics(SpaprMachineState *spapr, const char *fu=
nc)
>  {
> -    if (kvm_irqchip_in_kernel()) {
> -        error_report("pseries: %s must never be called for in-kernel XIC=
S",
> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ||
> +        kvm_irqchip_in_kernel()) {
> +        error_report("pseries: %s must only be called for emulated XICS",
>                       func);
> -        return true;
> +        return false;
>      }
> =20
> -    return false;
> +    return true;
>  }
> =20
> -#define CHECK_IN_KERNEL_XICS_HCALL              \
> -    do {                                        \
> -        if (check_in_kernel_xics(__func__)) {   \
> -            return H_HARDWARE;                  \
> -        }                                       \
> +#define CHECK_EMULATED_XICS_HCALL(spapr)               \
> +    do {                                               \
> +        if (!check_emulated_xics((spapr), __func__)) { \
> +            return H_HARDWARE;                         \
> +        }                                              \
>      } while (0)
> =20
>  static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachineState *spapr,
> @@ -64,7 +65,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
>  {
>      target_ulong cppr =3D args[0];
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      icp_set_cppr(spapr_cpu_state(cpu)->icp, cppr);
>      return H_SUCCESS;
> @@ -76,7 +77,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, SpaprMachine=
State *spapr,
>      target_ulong mfrr =3D args[1];
>      ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      if (!icp) {
>          return H_PARAMETER;
> @@ -91,7 +92,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
>  {
>      uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      args[0] =3D xirr;
>      return H_SUCCESS;
> @@ -102,7 +103,7 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
>  {
>      uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      args[0] =3D xirr;
>      args[1] =3D cpu_get_host_ticks();
> @@ -114,7 +115,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
>  {
>      target_ulong xirr =3D args[0];
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      icp_eoi(spapr_cpu_state(cpu)->icp, xirr);
>      return H_SUCCESS;
> @@ -127,7 +128,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
>      uint32_t mfrr;
>      uint32_t xirr;
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      if (!icp) {
>          return H_PARAMETER;
> @@ -141,12 +142,12 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> -#define CHECK_IN_KERNEL_XICS_RTAS(rets)                 \
> -    do {                                                \
> -        if (check_in_kernel_xics(__func__)) {           \
> -            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);      \
> -            return;                                     \
> -        }                                               \
> +#define CHECK_EMULATED_XICS_RTAS(spapr, rets)          \
> +    do {                                               \
> +        if (!check_emulated_xics((spapr), __func__)) { \
> +            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);     \
> +            return;                                    \
> +        }                                              \
>      } while (0)
> =20
>  static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
> @@ -157,7 +158,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno, server, priority;
> =20
> -    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +    CHECK_EMULATED_XICS_RTAS(spapr, rets);
> =20
>      if ((nargs !=3D 3) || (nret !=3D 1)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> @@ -192,7 +193,7 @@ static void rtas_get_xive(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno;
> =20
> -    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +    CHECK_EMULATED_XICS_RTAS(spapr, rets);
> =20
>      if ((nargs !=3D 1) || (nret !=3D 3)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> @@ -224,7 +225,7 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno;
> =20
> -    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +    CHECK_EMULATED_XICS_RTAS(spapr, rets);
> =20
>      if ((nargs !=3D 1) || (nret !=3D 1)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> @@ -257,7 +258,7 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachine=
State *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno;
> =20
> -    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +    CHECK_EMULATED_XICS_RTAS(spapr, rets);
> =20
>      if ((nargs !=3D 1) || (nret !=3D 1)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0I1p0ACgkQbDjKyiDZ
s5Ji+RAAjlK7zUBTWMXbyzi7qY4IPPAc4C0Z66yuD2ks0M+BpSLFPQG4SKnCo3Vh
FI/OdzsBiIA0eVoVZTTqRluOY1ocIBqHkaWSdTqGYUhEzFNqWsiktmj/EEr4BVCD
X/ZJmlayuuMFsgO8F9pMw1N7XTuPBIAktnZ3CvmH8caAE8fi6hxpGRm/1ofeeAcU
Z3X+ZkyBjQmgy1TviNbuScO2F64bTA9Vg8CN36Mys3BsKNUGX0kraqzVzdDWJXcd
Av3bK3EKye/ndjkSAiHy+vYsIA09H5ujOeyCpw3QLnUDhZ5Xoqvwe3kO8TvVXeAy
PBVoNQ21618rUd0I9WD/q7Q7isyaAbXctSfbVfthIdU3ulf+3Jn9S6Vihns3ZvQy
6hgGJS2xfWxNgst0EuSOeBPd3rj1SV3szJY//rlUSv67WsZnJ8YGHU2MK9WeoxmE
oKBP6Xa9shWHBtHBlAdbncq8l5bEkqL9vkZbOOg/FyGsiajt5MxdzdwsOMDrrKcS
OiQVzSy4jLFrxAvMyQldSbIPcq8XTaQI9RpAhrtLG5e4Akbz5tIScCqDhYBP68bG
VEzyuPeRDPxgJyhlDoPJHOsARS0qmKedoY0c3NrQ6/H8qtTBcl3qdFhhlsvPd103
C0RYE8UyeOuirsGMuvM5UNF8A6x4TpHatiOaBOc8tExKEFQRrFo=
=m4u0
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--

