Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C07C31E45
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F6E208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lNChNfch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F6E208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbbN8-0004ui-4V
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 21:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56946)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbL1-0003Hw-Jc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbL0-0003Q6-1t
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59451 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hbbKz-0003M5-EA; Thu, 13 Jun 2019 21:49:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45Q3Rt2rlYz9sNT; Fri, 14 Jun 2019 11:48:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560476938;
 bh=cyk3Iv3vnxadv7kweWr/mBcyrOrZq+vuMlne5OBRwpg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lNChNfchUTcyP4Rgs0GTPMXIeehFopSxw+P6Ffv3zjm3yGGDusM/N7b34rOjTRmxC
 lGF2OfvPCGuyrG+J7vIv9JuIQtSLa+Yz1Nwzr5sCB4SdHS3acpX3fm5owpEGrFIHKH
 fVh/Dpow9swnxikp33iH2gfLkaOIVIiX+NF8Et10=
Date: Fri, 14 Jun 2019 11:34:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190614013459.GA11158@umbus.fritz.box>
References: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <156044429419.125694.507569071972451514.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <156044429419.125694.507569071972451514.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 1/3] xics/spapr: Prevent RTAS/hypercalls
 emulation to be used by in-kernel XICS
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


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 06:44:54PM +0200, Greg Kurz wrote:
> The XICS-related RTAS calls and hypercalls in QEMU are supposed to be
> called only when the KVM in-kernel XICS is in use.

I've applied this, but reversed the sense of the sentence above, which
appears to be the intent.

>=20
> Add some explicit checks to detect that, print an error message and report
> an hardware error to the guest.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics_spapr.c |   46 ++++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 5a1835e8b1ed..d470ab5f7a2a 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -41,11 +41,31 @@
>   * Guest interfaces
>   */
> =20
> +static bool check_in_kernel_xics(const char *func)
> +{
> +    if (kvm_irqchip_in_kernel()) {
> +        error_report("pseries: %s must never be called for in-kernel XIC=
S",
> +                     func);
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +#define CHECK_IN_KERNEL_XICS_HCALL              \
> +    do {                                        \
> +        if (check_in_kernel_xics(__func__)) {   \
> +            return H_HARDWARE;                  \
> +        }                                       \
> +    } while (0)
> +
>  static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
>      target_ulong cppr =3D args[0];
> =20
> +    CHECK_IN_KERNEL_XICS_HCALL;
> +
>      icp_set_cppr(spapr_cpu_state(cpu)->icp, cppr);
>      return H_SUCCESS;
>  }
> @@ -56,6 +76,8 @@ static target_ulong h_ipi(PowerPCCPU *cpu, SpaprMachine=
State *spapr,
>      target_ulong mfrr =3D args[1];
>      ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
> =20
> +    CHECK_IN_KERNEL_XICS_HCALL;
> +
>      if (!icp) {
>          return H_PARAMETER;
>      }
> @@ -69,6 +91,8 @@ static target_ulong h_xirr(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
>  {
>      uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> =20
> +    CHECK_IN_KERNEL_XICS_HCALL;
> +
>      args[0] =3D xirr;
>      return H_SUCCESS;
>  }
> @@ -78,6 +102,8 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
>  {
>      uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> =20
> +    CHECK_IN_KERNEL_XICS_HCALL;
> +
>      args[0] =3D xirr;
>      args[1] =3D cpu_get_host_ticks();
>      return H_SUCCESS;
> @@ -88,6 +114,8 @@ static target_ulong h_eoi(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
>  {
>      target_ulong xirr =3D args[0];
> =20
> +    CHECK_IN_KERNEL_XICS_HCALL;
> +
>      icp_eoi(spapr_cpu_state(cpu)->icp, xirr);
>      return H_SUCCESS;
>  }
> @@ -99,6 +127,8 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>      uint32_t mfrr;
>      uint32_t xirr;
> =20
> +    CHECK_IN_KERNEL_XICS_HCALL;
> +
>      if (!icp) {
>          return H_PARAMETER;
>      }
> @@ -111,6 +141,14 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +#define CHECK_IN_KERNEL_XICS_RTAS(rets)                 \
> +    do {                                                \
> +        if (check_in_kernel_xics(__func__)) {           \
> +            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);      \
> +            return;                                     \
> +        }                                               \
> +    } while (0)
> +
>  static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                            uint32_t token,
>                            uint32_t nargs, target_ulong args,
> @@ -119,6 +157,8 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno, server, priority;
> =20
> +    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +
>      if ((nargs !=3D 3) || (nret !=3D 1)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
> @@ -152,6 +192,8 @@ static void rtas_get_xive(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno;
> =20
> +    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +
>      if ((nargs !=3D 1) || (nret !=3D 3)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
> @@ -182,6 +224,8 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno;
> =20
> +    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +
>      if ((nargs !=3D 1) || (nret !=3D 1)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
> @@ -213,6 +257,8 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachine=
State *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno;
> =20
> +    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +
>      if ((nargs !=3D 1) || (nret !=3D 1)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0C+cMACgkQbDjKyiDZ
s5K9ZQ/+NchYHbNNvIqlnrUR6FIm2LO+JQl1l0EKJK0jEXQh/Fws86L+fGbuEPit
b9OWAluntlPztbh8pE5hpo/tJEYqkloEwh2a8pB0igk8nxcffuXhPkI8YnXfj25u
YitlwvSXAQJbIwKKKHEK1POXd8dQte3HVyqCBe+e1GY/0keU7ce+rEzf/8vXl/yC
RElIcDxKfQqTdXBvFpo76Kgak4m5TNEcEr8oliOYbVY8vkAJspCmyTLfM7xo7efx
OlutsJsDKMUJfpwdSsPJD8wZyi6OMHrM40UNvHMvLbe5xu3MPA6X2lilkO0zEVdy
VB75L9hPVO9DfJBGGcWqLtSJGPinCDarkAclvmKpbYcNXSMBR89LIxkB7oSXrvNT
r2dfDKExks0Hm7aQ1bjWCgEHEmZKhhx1CdIaY0bgVzzM5IHQ5lE2FS8vmNRGAWCz
BSV7X+24ybU8FgCYCyjXW3PW5OFuEN6+Q9D6pdgSKLqGqrwv0lQGO1opXbnbP8a3
CvmeHZ8o+sg+b3IZQicRsbkOenGyF6StoljDINkF6voMq3o2uKnIpcRPywBAUBPd
2o9EForhESOrMG2/WYKkKKRDAK57mT5ikjJEQ8kkqtN+JbRmAJLy5RY+wWjkdb3N
R7y/ziskeq4OCo25MhAdfuaFdf8VVDo+qOudkY4hhQ0oz2iXRPQ=
=0ayo
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

