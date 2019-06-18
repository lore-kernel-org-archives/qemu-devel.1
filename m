Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486EC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D81D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D81D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8Gk-0008Bm-Kb
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hd8Fl-0007VB-NS
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hd8Fj-0002TT-Nt
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:10:01 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:58944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hd8Fh-0002Qx-O0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:09:59 -0400
Received: from player168.ha.ovh.net (unknown [10.108.42.184])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id E681521A4C0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:09:51 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id C8BEE6D9E9A0;
 Tue, 18 Jun 2019 07:09:47 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156077253666.424706.6104557911104491047.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f634068c-9bda-e43a-acd2-00b553090985@kaod.org>
Date: Tue, 18 Jun 2019 09:09:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156077253666.424706.6104557911104491047.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10249911278037797696
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeikedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.202
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/2019 13:55, Greg Kurz wrote:
> Checking that we're not using the in-kernel XICS is ok with the "xics"
> interrupt controller mode, but it is definitely not enough with the
> other modes since the guest could be using XIVE.
>=20
> Ensure XIVE is not in use when emulated XICS RTAS/hypercalls are
> called.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I think we can find a better name for :

  CHECK_EMULATED_XICS_HCALL

but this is minor.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/xics_spapr.c |   53 +++++++++++++++++++++++++-----------------=
--------
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
> +static bool check_emulated_xics(SpaprMachineState *spapr, const char *=
func)
>  {
> -    if (kvm_irqchip_in_kernel()) {
> -        error_report("pseries: %s must never be called for in-kernel X=
ICS",
> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ||
> +        kvm_irqchip_in_kernel()) {
> +        error_report("pseries: %s must only be called for emulated XIC=
S",
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
> @@ -64,7 +65,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>  {
>      target_ulong cppr =3D args[0];
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      icp_set_cppr(spapr_cpu_state(cpu)->icp, cppr);
>      return H_SUCCESS;
> @@ -76,7 +77,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
>      target_ulong mfrr =3D args[1];
>      ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      if (!icp) {
>          return H_PARAMETER;
> @@ -91,7 +92,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>  {
>      uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      args[0] =3D xirr;
>      return H_SUCCESS;
> @@ -102,7 +103,7 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
>  {
>      uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      args[0] =3D xirr;
>      args[1] =3D cpu_get_host_ticks();
> @@ -114,7 +115,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
>  {
>      target_ulong xirr =3D args[0];
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      icp_eoi(spapr_cpu_state(cpu)->icp, xirr);
>      return H_SUCCESS;
> @@ -127,7 +128,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
>      uint32_t mfrr;
>      uint32_t xirr;
> =20
> -    CHECK_IN_KERNEL_XICS_HCALL;
> +    CHECK_EMULATED_XICS_HCALL(spapr);
> =20
>      if (!icp) {
>          return H_PARAMETER;
> @@ -141,12 +142,12 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
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
> @@ -157,7 +158,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno, server, priority;
> =20
> -    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +    CHECK_EMULATED_XICS_RTAS(spapr, rets);
> =20
>      if ((nargs !=3D 3) || (nret !=3D 1)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> @@ -192,7 +193,7 @@ static void rtas_get_xive(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno;
> =20
> -    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +    CHECK_EMULATED_XICS_RTAS(spapr, rets);
> =20
>      if ((nargs !=3D 1) || (nret !=3D 3)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> @@ -224,7 +225,7 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno;
> =20
> -    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +    CHECK_EMULATED_XICS_RTAS(spapr, rets);
> =20
>      if ((nargs !=3D 1) || (nret !=3D 1)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> @@ -257,7 +258,7 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
>      ICSState *ics =3D spapr->ics;
>      uint32_t nr, srcno;
> =20
> -    CHECK_IN_KERNEL_XICS_RTAS(rets);
> +    CHECK_EMULATED_XICS_RTAS(spapr, rets);
> =20
>      if ((nargs !=3D 1) || (nret !=3D 1)) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>=20


