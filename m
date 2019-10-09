Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645ABC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C4720679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C4720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHme-0006Hy-76
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iIELH-0006Cp-EU
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iIELF-0006Et-QP
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:57:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28970
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iIELF-0006Eg-Le
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:57:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x99FiqmJ136023
 for <qemu-devel@nongnu.org>; Wed, 9 Oct 2019 11:57:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vhj1r1gjk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 11:57:32 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 9 Oct 2019 16:57:30 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Oct 2019 16:57:26 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x99Futk136569410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2019 15:56:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B6CBAE051;
 Wed,  9 Oct 2019 15:57:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFF16AE045;
 Wed,  9 Oct 2019 15:57:24 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Oct 2019 15:57:24 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-2-100.uk.ibm.com [9.145.2.100])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 19A65220121;
 Wed,  9 Oct 2019 17:57:24 +0200 (CEST)
Subject: Re: [PATCH v4 14/19] spapr, xics, xive: Move SpaprIrq::post_load hook
 to backends
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-15-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Wed, 9 Oct 2019 17:57:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009060818.29719-15-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19100915-0020-0000-0000-00000377886F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100915-0021-0000-0000-000021CD9098
Message-Id: <8fd79a72-335b-49d2-2a36-256f02a07bf1@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-09_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090144
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x99FiqmJ136023
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
> The remaining logic in the post_load hook really belongs to the interru=
pt
> controller backends, and just needs to be called on the active controll=
er
> (after the active controller is set to the right thing based on the
> incoming migration in the generic spapr_irq_post_load() logic).
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/spapr_xive.c        |  5 +++--
>  hw/intc/xics_spapr.c        | 13 +++++++++++
>  hw/ppc/spapr_irq.c          | 45 ++++---------------------------------
>  include/hw/ppc/spapr_irq.h  |  3 +--
>  include/hw/ppc/spapr_xive.h |  1 -
>  5 files changed, 21 insertions(+), 46 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 1811653aac..ba32d2cc5b 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -462,10 +462,10 @@ static int vmstate_spapr_xive_pre_save(void *opaq=
ue)
>   * Called by the sPAPR IRQ backend 'post_load' method at the machine
>   * level.
>   */
> -int spapr_xive_post_load(SpaprXive *xive, int version_id)
> +static int spapr_xive_post_load(SpaprInterruptController *intc, int ve=
rsion_id)
>  {
>      if (kvm_irqchip_in_kernel()) {
> -        return kvmppc_xive_post_load(xive, version_id);
> +        return kvmppc_xive_post_load(SPAPR_XIVE(intc), version_id);
>      }
> =20
>      return 0;
> @@ -702,6 +702,7 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
>      sicc->set_irq =3D spapr_xive_set_irq;
>      sicc->print_info =3D spapr_xive_print_info;
>      sicc->dt =3D spapr_xive_dt;
> +    sicc->post_load =3D spapr_xive_post_load;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 90b4d48877..4f64b9a9fc 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -395,6 +395,18 @@ static void xics_spapr_print_info(SpaprInterruptCo=
ntroller *intc, Monitor *mon)
>      ics_pic_print_info(ics, mon);
>  }
> =20
> +static int xics_spapr_post_load(SpaprInterruptController *intc, int ve=
rsion_id)
> +{
> +    if (!kvm_irqchip_in_kernel()) {
> +        CPUState *cs;
> +        CPU_FOREACH(cs) {
> +            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +            icp_resend(spapr_cpu_state(cpu)->icp);
> +        }
> +    }
> +    return 0;
> +}
> +
>  static int xics_spapr_activate(SpaprInterruptController *intc, Error *=
*errp)
>  {
>      if (kvm_enabled()) {
> @@ -426,6 +438,7 @@ static void ics_spapr_class_init(ObjectClass *klass=
, void *data)
>      sicc->set_irq =3D xics_spapr_set_irq;
>      sicc->print_info =3D xics_spapr_print_info;
>      sicc->dt =3D xics_spapr_dt;
> +    sicc->post_load =3D xics_spapr_post_load;
>  }
> =20
>  static const TypeInfo ics_spapr_info =3D {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index f70b331f44..f3d18b1dad 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -100,43 +100,22 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptCo=
ntroller *, Error **),
>   * XICS IRQ backend.
>   */
> =20
> -static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int vers=
ion_id)
> -{
> -    if (!kvm_irqchip_in_kernel()) {
> -        CPUState *cs;
> -        CPU_FOREACH(cs) {
> -            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -            icp_resend(spapr_cpu_state(cpu)->icp);
> -        }
> -    }
> -    return 0;
> -}
> -
>  SpaprIrq spapr_irq_xics =3D {
>      .nr_xirqs    =3D SPAPR_NR_XIRQS,
>      .nr_msis     =3D SPAPR_NR_MSIS,
>      .xics        =3D true,
>      .xive        =3D false,
> -
> -    .post_load   =3D spapr_irq_post_load_xics,
>  };
> =20
>  /*
>   * XIVE IRQ backend.
>   */
> =20
> -static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int vers=
ion_id)
> -{
> -    return spapr_xive_post_load(spapr->xive, version_id);
> -}
> -
>  SpaprIrq spapr_irq_xive =3D {
>      .nr_xirqs    =3D SPAPR_NR_XIRQS,
>      .nr_msis     =3D SPAPR_NR_MSIS,
>      .xics        =3D false,
>      .xive        =3D true,
> -
> -    .post_load   =3D spapr_irq_post_load_xive,
>  };
> =20
>  /*
> @@ -148,21 +127,6 @@ SpaprIrq spapr_irq_xive =3D {
>   * activated after an extra machine reset.
>   */
> =20
> -/*
> - * Returns the sPAPR IRQ backend negotiated by CAS. XICS is the
> - * default.
> - */
> -static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
> -{
> -    return spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ?
> -        &spapr_irq_xive : &spapr_irq_xics;
> -}
> -
> -static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int vers=
ion_id)
> -{
> -    return spapr_irq_current(spapr)->post_load(spapr, version_id);
> -}
> -
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -171,8 +135,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .nr_msis     =3D SPAPR_NR_MSIS,
>      .xics        =3D true,
>      .xive        =3D true,
> -
> -    .post_load   =3D spapr_irq_post_load_dual,
>  };
> =20
> =20
> @@ -447,8 +409,11 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int =
irq)
> =20
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
>  {
> +    SpaprInterruptControllerClass *sicc;
> +
>      spapr_irq_update_active_intc(spapr);
> -    return spapr->irq->post_load(spapr, version_id);
> +    sicc =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +    return sicc->post_load(spapr->active_intc, version_id);
>  }
> =20
>  void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
> @@ -589,8 +554,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .xics        =3D true,
>      .xive        =3D false,
> -
> -    .post_load   =3D spapr_irq_post_load_xics,
>  };
> =20
>  static void spapr_irq_register_types(void)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index e02e44624b..08173e714c 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -62,6 +62,7 @@ typedef struct SpaprInterruptControllerClass {
>      void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
>      void (*dt)(SpaprInterruptController *intc, uint32_t nr_servers,
>                 void *fdt, uint32_t phandle);
> +    int (*post_load)(SpaprInterruptController *intc, int version_id);
>  } SpaprInterruptControllerClass;
> =20
>  void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> @@ -82,8 +83,6 @@ typedef struct SpaprIrq {
>      uint32_t    nr_msis;
>      bool        xics;
>      bool        xive;
> -
> -    int (*post_load)(SpaprMachineState *spapr, int version_id);
>  } SpaprIrq;
> =20
>  extern SpaprIrq spapr_irq_xics;
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 64972754f9..d84bd5c229 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -55,7 +55,6 @@ typedef struct SpaprXive {
>  #define SPAPR_XIVE_BLOCK_ID 0x0
> =20
>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
> -int spapr_xive_post_load(SpaprXive *xive, int version_id);
> =20
>  void spapr_xive_hcall_init(SpaprMachineState *spapr);
>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>=20


