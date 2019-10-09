Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02686ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88D5206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88D5206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGE8-0000Xn-35
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iI88f-0003VJ-3Q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iI88d-00074P-Fm
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:20:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iI88d-00074D-8K
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:20:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x999DuD8050721
 for <qemu-devel@nongnu.org>; Wed, 9 Oct 2019 05:20:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vhcq909c0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 05:20:06 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 9 Oct 2019 10:20:03 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Oct 2019 10:19:53 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x999JqBB33489090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2019 09:19:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B2564C04E;
 Wed,  9 Oct 2019 09:19:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B0094C046;
 Wed,  9 Oct 2019 09:19:52 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Oct 2019 09:19:52 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-55-18.uk.ibm.com [9.145.55.18])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 68B23220198;
 Wed,  9 Oct 2019 11:19:51 +0200 (CEST)
Subject: Re: [PATCH v4 09/19] spapr, xics, xive: Move print_info from SpaprIrq
 to SpaprInterruptController
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-10-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Wed, 9 Oct 2019 11:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009060818.29719-10-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19100909-4275-0000-0000-000003706438
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100909-4276-0000-0000-0000388367D5
Message-Id: <a8f3f050-d5e7-8099-b9b2-c84154a7eb8e@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-09_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090087
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x999DuD8050721
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/2019 08:08, David Gibson wrote:
> This method depends only on the active irq controller.  Now that we've
> formalized the notion of active controller we can dispatch directly
> through that, rather than dispatching via SpaprIrq with the dual
> version having to do a second conditional dispatch.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/spapr_xive.c       | 15 +++++++++++++
>  hw/intc/xics_spapr.c       | 15 +++++++++++++
>  hw/ppc/spapr.c             |  2 +-
>  hw/ppc/spapr_irq.c         | 44 +++++++-------------------------------
>  include/hw/ppc/spapr_irq.h |  4 ++--
>  5 files changed, 41 insertions(+), 39 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 52d5e71793..700ec5c9c1 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -564,6 +564,20 @@ static void spapr_xive_set_irq(SpaprInterruptContr=
oller *intc, int irq, int val)
>      }
>  }
> =20
> +static void spapr_xive_print_info(SpaprInterruptController *intc, Moni=
tor *mon)
> +{
> +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
> +    }
> +
> +    spapr_xive_pic_print_info(xive, mon);
> +}
> +
>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -586,6 +600,7 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
>      sicc->claim_irq =3D spapr_xive_claim_irq;
>      sicc->free_irq =3D spapr_xive_free_irq;
>      sicc->set_irq =3D spapr_xive_set_irq;
> +    sicc->print_info =3D spapr_xive_print_info;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 02372697f6..415defe394 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -381,6 +381,20 @@ static void xics_spapr_set_irq(SpaprInterruptContr=
oller *intc, int irq, int val)
>      ics_set_irq(ics, srcno, val);
>  }
> =20
> +static void xics_spapr_print_info(SpaprInterruptController *intc, Moni=
tor *mon)
> +{
> +    ICSState *ics =3D ICS_SPAPR(intc);
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
> +    }
> +
> +    ics_pic_print_info(ics, mon);
> +}
> +
>  static void ics_spapr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -393,6 +407,7 @@ static void ics_spapr_class_init(ObjectClass *klass=
, void *data)
>      sicc->claim_irq =3D xics_spapr_claim_irq;
>      sicc->free_irq =3D xics_spapr_free_irq;
>      sicc->set_irq =3D xics_spapr_set_irq;
> +    sicc->print_info =3D xics_spapr_print_info;
>  }
> =20
>  static const TypeInfo ics_spapr_info =3D {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 514a17ae74..6c38de5927 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4271,7 +4271,7 @@ static void spapr_pic_print_info(InterruptStatsPr=
ovider *obj,
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> =20
> -    spapr->irq->print_info(spapr, mon);
> +    spapr_irq_print_info(spapr, mon);
>      monitor_printf(mon, "irqchip: %s\n",
>                     kvm_irqchip_in_kernel() ? "in-kernel" : "emulated")=
;
>  }
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index bfccb815ed..a29b527232 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -98,19 +98,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *sp=
apr,
>   * XICS IRQ backend.
>   */
> =20
> -static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monito=
r *mon)
> -{
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -
> -        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
> -    }
> -
> -    ics_pic_print_info(spapr->ics, mon);
> -}
> -
>  static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int vers=
ion_id)
>  {
>      if (!kvm_irqchip_in_kernel()) {
> @@ -147,7 +134,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .xics        =3D true,
>      .xive        =3D false,
> =20
> -    .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_dt_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
> @@ -158,20 +144,6 @@ SpaprIrq spapr_irq_xics =3D {
>   * XIVE IRQ backend.
>   */
> =20
> -static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
> -                                      Monitor *mon)
> -{
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -
> -        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
> -    }
> -
> -    spapr_xive_pic_print_info(spapr->xive, mon);
> -}
> -
>  static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int vers=
ion_id)
>  {
>      return spapr_xive_post_load(spapr->xive, version_id);
> @@ -212,7 +184,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .xics        =3D false,
>      .xive        =3D true,
> =20
> -    .print_info  =3D spapr_irq_print_info_xive,
>      .dt_populate =3D spapr_dt_xive,
>      .post_load   =3D spapr_irq_post_load_xive,
>      .reset       =3D spapr_irq_reset_xive,
> @@ -238,11 +209,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineSta=
te *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
> =20
> -static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monito=
r *mon)
> -{
> -    spapr_irq_current(spapr)->print_info(spapr, mon);
> -}
> -
>  static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
>                                         uint32_t nr_servers, void *fdt,
>                                         uint32_t phandle)
> @@ -304,7 +270,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .xics        =3D true,
>      .xive        =3D true,
> =20
> -    .print_info  =3D spapr_irq_print_info_dual,
>      .dt_populate =3D spapr_irq_dt_populate_dual,
>      .post_load   =3D spapr_irq_post_load_dual,
>      .reset       =3D spapr_irq_reset_dual,
> @@ -404,6 +369,14 @@ static void spapr_set_irq(void *opaque, int irq, i=
nt level)
>      sicc->set_irq(spapr->active_intc, irq, level);
>  }
> =20
> +void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon)
> +{
> +    SpaprInterruptControllerClass *sicc
> +        =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +
> +    sicc->print_info(spapr->active_intc, mon);
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -713,7 +686,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .xics        =3D true,
>      .xive        =3D false,
> =20
> -    .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_dt_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index ece8d2ea48..bdfeb3b107 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -59,13 +59,14 @@ typedef struct SpaprInterruptControllerClass {
> =20
>      /* These methods should only be called on the active intc */
>      void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
> +    void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
>  } SpaprInterruptControllerClass;
> =20
>  void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> =20
>  int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>                                PowerPCCPU *cpu, Error **errp);
> -
> +void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
> =20
>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
> @@ -78,7 +79,6 @@ typedef struct SpaprIrq {
>      bool        xics;
>      bool        xive;
> =20
> -    void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>=20


