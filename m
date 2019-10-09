Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4CBECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42000206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42000206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFq7-00087z-W2
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iI89b-0003hG-FX
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iI89Z-0007P6-Bq
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:21:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iI89Z-0007Om-3U
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:21:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x999E7mc137086
 for <qemu-devel@nongnu.org>; Wed, 9 Oct 2019 05:21:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vha7c5jpv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 05:21:03 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 9 Oct 2019 10:21:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Oct 2019 10:20:58 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x999KvVr14680142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2019 09:20:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FF3611C058;
 Wed,  9 Oct 2019 09:20:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F9FE11C052;
 Wed,  9 Oct 2019 09:20:57 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Oct 2019 09:20:57 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-55-18.uk.ibm.com [9.145.55.18])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 5105F220198;
 Wed,  9 Oct 2019 11:20:56 +0200 (CEST)
Subject: Re: [PATCH v4 10/19] spapr, xics, xive: Move dt_populate from
 SpaprIrq to SpaprInterruptController
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-11-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Wed, 9 Oct 2019 11:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009060818.29719-11-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19100909-0012-0000-0000-00000356657B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100909-0013-0000-0000-0000219169DB
Message-Id: <32772e52-7a5e-354e-8887-65946d4db971@kaod.org>
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
 mx0a-001b2d01.pphosted.com id x999E7mc137086
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
>  hw/intc/spapr_xive.c        | 125 ++++++++++++++++++------------------
>  hw/intc/xics_spapr.c        |   5 +-
>  hw/ppc/spapr.c              |   3 +-
>  hw/ppc/spapr_irq.c          |  20 +++---
>  include/hw/ppc/spapr_irq.h  |   6 +-
>  include/hw/ppc/spapr_xive.h |   2 -
>  include/hw/ppc/xics_spapr.h |   2 -
>  7 files changed, 80 insertions(+), 83 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 700ec5c9c1..37ffb74ca5 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -578,6 +578,68 @@ static void spapr_xive_print_info(SpaprInterruptCo=
ntroller *intc, Monitor *mon)
>      spapr_xive_pic_print_info(xive, mon);
>  }
> =20
> +static void spapr_xive_dt(SpaprInterruptController *intc, uint32_t nr_=
servers,
> +                          void *fdt, uint32_t phandle)
> +{
> +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> +    int node;
> +    uint64_t timas[2 * 2];
> +    /* Interrupt number ranges for the IPIs */
> +    uint32_t lisn_ranges[] =3D {
> +        cpu_to_be32(0),
> +        cpu_to_be32(nr_servers),
> +    };
> +    /*
> +     * EQ size - the sizes of pages supported by the system 4K, 64K,
> +     * 2M, 16M. We only advertise 64K for the moment.
> +     */
> +    uint32_t eq_sizes[] =3D {
> +        cpu_to_be32(16), /* 64K */
> +    };
> +    /*
> +     * The following array is in sync with the reserved priorities
> +     * defined by the 'spapr_xive_priority_is_reserved' routine.
> +     */
> +    uint32_t plat_res_int_priorities[] =3D {
> +        cpu_to_be32(7),    /* start */
> +        cpu_to_be32(0xf8), /* count */
> +    };
> +
> +    /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2=
) */
> +    timas[0] =3D cpu_to_be64(xive->tm_base +
> +                           XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
> +    timas[1] =3D cpu_to_be64(1ull << TM_SHIFT);
> +    timas[2] =3D cpu_to_be64(xive->tm_base +
> +                           XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
> +    timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
> +
> +    _FDT(node =3D fdt_add_subnode(fdt, 0, xive->nodename));
> +
> +    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
> +    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> +
> +    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe")=
);
> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
> +                     sizeof(eq_sizes)));
> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
> +                     sizeof(lisn_ranges)));
> +
> +    /* For Linux to link the LSIs to the interrupt controller. */
> +    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
> +    _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
> +
> +    /* For SLOF */
> +    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> +    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> +
> +    /*
> +     * The "ibm,plat-res-int-priorities" property defines the priority
> +     * ranges reserved by the hypervisor
> +     */
> +    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
> +                     plat_res_int_priorities, sizeof(plat_res_int_prio=
rities)));
> +}
> +
>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -601,6 +663,7 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
>      sicc->free_irq =3D spapr_xive_free_irq;
>      sicc->set_irq =3D spapr_xive_set_irq;
>      sicc->print_info =3D spapr_xive_print_info;
> +    sicc->dt =3D spapr_xive_dt;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> @@ -1601,65 +1664,3 @@ void spapr_xive_hcall_init(SpaprMachineState *sp=
apr)
>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>  }
> -
> -void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> -                   uint32_t phandle)
> -{
> -    SpaprXive *xive =3D spapr->xive;
> -    int node;
> -    uint64_t timas[2 * 2];
> -    /* Interrupt number ranges for the IPIs */
> -    uint32_t lisn_ranges[] =3D {
> -        cpu_to_be32(0),
> -        cpu_to_be32(nr_servers),
> -    };
> -    /*
> -     * EQ size - the sizes of pages supported by the system 4K, 64K,
> -     * 2M, 16M. We only advertise 64K for the moment.
> -     */
> -    uint32_t eq_sizes[] =3D {
> -        cpu_to_be32(16), /* 64K */
> -    };
> -    /*
> -     * The following array is in sync with the reserved priorities
> -     * defined by the 'spapr_xive_priority_is_reserved' routine.
> -     */
> -    uint32_t plat_res_int_priorities[] =3D {
> -        cpu_to_be32(7),    /* start */
> -        cpu_to_be32(0xf8), /* count */
> -    };
> -
> -    /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2=
) */
> -    timas[0] =3D cpu_to_be64(xive->tm_base +
> -                           XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
> -    timas[1] =3D cpu_to_be64(1ull << TM_SHIFT);
> -    timas[2] =3D cpu_to_be64(xive->tm_base +
> -                           XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
> -    timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
> -
> -    _FDT(node =3D fdt_add_subnode(fdt, 0, xive->nodename));
> -
> -    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
> -    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> -
> -    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe")=
);
> -    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
> -                     sizeof(eq_sizes)));
> -    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
> -                     sizeof(lisn_ranges)));
> -
> -    /* For Linux to link the LSIs to the interrupt controller. */
> -    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
> -    _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
> -
> -    /* For SLOF */
> -    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> -    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> -
> -    /*
> -     * The "ibm,plat-res-int-priorities" property defines the priority
> -     * ranges reserved by the hypervisor
> -     */
> -    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
> -                     plat_res_int_priorities, sizeof(plat_res_int_prio=
rities)));
> -}
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 415defe394..4eabafc7e1 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -308,8 +308,8 @@ static void ics_spapr_realize(DeviceState *dev, Err=
or **errp)
>      spapr_register_hypercall(H_IPOLL, h_ipoll);
>  }
> =20
> -void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> -                   uint32_t phandle)
> +static void xics_spapr_dt(SpaprInterruptController *intc, uint32_t nr_=
servers,
> +                          void *fdt, uint32_t phandle)
>  {
>      uint32_t interrupt_server_ranges_prop[] =3D {
>          0, cpu_to_be32(nr_servers),
> @@ -408,6 +408,7 @@ static void ics_spapr_class_init(ObjectClass *klass=
, void *data)
>      sicc->free_irq =3D xics_spapr_free_irq;
>      sicc->set_irq =3D xics_spapr_set_irq;
>      sicc->print_info =3D xics_spapr_print_info;
> +    sicc->dt =3D xics_spapr_dt;
>  }
> =20
>  static const TypeInfo ics_spapr_info =3D {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6c38de5927..e880db5d38 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1255,8 +1255,7 @@ static void *spapr_build_fdt(SpaprMachineState *s=
papr)
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt=
,
> -                          PHANDLE_INTC);
> +    spapr_irq_dt(spapr, spapr_max_server_number(spapr), fdt, PHANDLE_I=
NTC);
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index a29b527232..a8005072e6 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -134,7 +134,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .xics        =3D true,
>      .xive        =3D false,
> =20
> -    .dt_populate =3D spapr_dt_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
> @@ -184,7 +183,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .xics        =3D false,
>      .xive        =3D true,
> =20
> -    .dt_populate =3D spapr_dt_xive,
>      .post_load   =3D spapr_irq_post_load_xive,
>      .reset       =3D spapr_irq_reset_xive,
>      .init_kvm    =3D spapr_irq_init_kvm_xive,
> @@ -209,13 +207,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineSta=
te *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
> =20
> -static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
> -                                       uint32_t nr_servers, void *fdt,
> -                                       uint32_t phandle)
> -{
> -    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phan=
dle);
> -}
> -
>  static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int vers=
ion_id)
>  {
>      /*
> @@ -270,7 +261,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .xics        =3D true,
>      .xive        =3D true,
> =20
> -    .dt_populate =3D spapr_irq_dt_populate_dual,
>      .post_load   =3D spapr_irq_post_load_dual,
>      .reset       =3D spapr_irq_reset_dual,
>      .init_kvm    =3D NULL, /* should not be used */
> @@ -377,6 +367,15 @@ void spapr_irq_print_info(SpaprMachineState *spapr=
, Monitor *mon)
>      sicc->print_info(spapr->active_intc, mon);
>  }
> =20
> +void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
> +                  void *fdt, uint32_t phandle)
> +{
> +    SpaprInterruptControllerClass *sicc
> +        =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +
> +    sicc->dt(spapr->active_intc, nr_servers, fdt, phandle);
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -686,7 +685,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .xics        =3D true,
>      .xive        =3D false,
> =20
> -    .dt_populate =3D spapr_dt_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index bdfeb3b107..0df95e1b5a 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -60,6 +60,8 @@ typedef struct SpaprInterruptControllerClass {
>      /* These methods should only be called on the active intc */
>      void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
>      void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
> +    void (*dt)(SpaprInterruptController *intc, uint32_t nr_servers,
> +               void *fdt, uint32_t phandle);
>  } SpaprInterruptControllerClass;
> =20
>  void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> @@ -67,6 +69,8 @@ void spapr_irq_update_active_intc(SpaprMachineState *=
spapr);
>  int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>                                PowerPCCPU *cpu, Error **errp);
>  void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
> +void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
> +                  void *fdt, uint32_t phandle);
> =20
>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
> @@ -79,8 +83,6 @@ typedef struct SpaprIrq {
>      bool        xics;
>      bool        xive;
> =20
> -    void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> -                        void *fdt, uint32_t phandle);
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 8f875673f5..ebe156eb30 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -58,8 +58,6 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Monit=
or *mon);
>  int spapr_xive_post_load(SpaprXive *xive, int version_id);
> =20
>  void spapr_xive_hcall_init(SpaprMachineState *spapr);
> -void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> -                   uint32_t phandle);
>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
>  void spapr_xive_map_mmio(SpaprXive *xive);
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 0b35e85c26..8e4fb6adce 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -32,8 +32,6 @@
>  #define TYPE_ICS_SPAPR "ics-spapr"
>  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> =20
> -void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> -                   uint32_t phandle);
>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
>=20


