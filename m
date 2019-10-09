Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D92C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF4C218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF4C218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHLA-0001Oo-6R
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iIEN4-0008GJ-82
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iIEN2-0006tG-Du
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:59:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iIEN2-0006sn-5i
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:59:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x99Fh2QD137178
 for <qemu-devel@nongnu.org>; Wed, 9 Oct 2019 11:59:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vhj8j90yc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 11:59:22 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 9 Oct 2019 16:59:19 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Oct 2019 16:59:15 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x99FxErV47775834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2019 15:59:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71F0942042;
 Wed,  9 Oct 2019 15:59:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51F8742041;
 Wed,  9 Oct 2019 15:59:14 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Oct 2019 15:59:14 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-2-100.uk.ibm.com [9.145.2.100])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 77CA5220121;
 Wed,  9 Oct 2019 17:59:13 +0200 (CEST)
Subject: Re: [PATCH v4 15/19] spapr: Remove SpaprIrq::nr_msis
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-16-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Wed, 9 Oct 2019 17:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009060818.29719-16-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19100915-0012-0000-0000-000003568B38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100915-0013-0000-0000-000021919128
Message-Id: <cbf330ce-2f95-5af1-aff5-8bed120c7317@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-09_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090144
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x99Fh2QD137178
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
> The nr_msis value we use here has to line up with whether we're using
> legacy or modern irq allocation.  Therefore it's safer to derive it bas=
ed
> on legacy_irq_allocation rather than having SpaprIrq contain a canned
> value.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

one minor typo below,

> ---
>  hw/ppc/spapr.c              |  5 ++---
>  hw/ppc/spapr_irq.c          | 26 +++++++++++++++++---------
>  hw/ppc/spapr_pci.c          |  7 ++++---
>  include/hw/pci-host/spapr.h |  4 ++--
>  include/hw/ppc/spapr_irq.h  |  4 +---
>  5 files changed, 26 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e880db5d38..153cc54354 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1275,7 +1275,7 @@ static void *spapr_build_fdt(SpaprMachineState *s=
papr)
>      }
> =20
>      QLIST_FOREACH(phb, &spapr->phbs, list) {
> -        ret =3D spapr_dt_phb(phb, PHANDLE_INTC, fdt, spapr->irq->nr_ms=
is, NULL);
> +        ret =3D spapr_dt_phb(spapr, phb, PHANDLE_INTC, fdt, NULL);
>          if (ret < 0) {
>              error_report("couldn't setup PCI devices in fdt");
>              exit(1);
> @@ -3910,8 +3910,7 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMac=
hineState *spapr,
>          return -1;
>      }
> =20
> -    if (spapr_dt_phb(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
> -                     fdt_start_offset)) {
> +    if (spapr_dt_phb(spapr, sphb, intc_phandle, fdt, fdt_start_offset)=
) {
>          error_setg(errp, "unable to create FDT node for PHB %d", sphb-=
>index);
>          return -1;
>      }
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index f3d18b1dad..076da31501 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -29,9 +29,14 @@ static const TypeInfo spapr_intc_info =3D {
>      .class_size =3D sizeof(SpaprInterruptControllerClass),
>  };
> =20
> -void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis)
> +static void spapr_irq_msi_init(SpaprMachineState *spapr)
>  {
> -    spapr->irq_map_nr =3D nr_msis;
> +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        /* Legacy mode doesn't use this allocater */

allocater -> allocator

> +        return;
> +    }
> +
> +    spapr->irq_map_nr =3D spapr_irq_nr_msis(spapr);
>      spapr->irq_map =3D bitmap_new(spapr->irq_map_nr);
>  }
> =20
> @@ -102,7 +107,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptCont=
roller *, Error **),
> =20
>  SpaprIrq spapr_irq_xics =3D {
>      .nr_xirqs    =3D SPAPR_NR_XIRQS,
> -    .nr_msis     =3D SPAPR_NR_MSIS,
>      .xics        =3D true,
>      .xive        =3D false,
>  };
> @@ -113,7 +117,6 @@ SpaprIrq spapr_irq_xics =3D {
> =20
>  SpaprIrq spapr_irq_xive =3D {
>      .nr_xirqs    =3D SPAPR_NR_XIRQS,
> -    .nr_msis     =3D SPAPR_NR_MSIS,
>      .xics        =3D false,
>      .xive        =3D true,
>  };
> @@ -132,7 +135,6 @@ SpaprIrq spapr_irq_xive =3D {
>   */
>  SpaprIrq spapr_irq_dual =3D {
>      .nr_xirqs    =3D SPAPR_NR_XIRQS,
> -    .nr_msis     =3D SPAPR_NR_MSIS,
>      .xics        =3D true,
>      .xive        =3D true,
>  };
> @@ -247,6 +249,15 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32=
_t nr_servers,
>      sicc->dt(spapr->active_intc, nr_servers, fdt, phandle);
>  }
> =20
> +uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
> +{
> +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        return spapr->irq->nr_xirqs;
> +    } else {
> +        return SPAPR_XIRQ_BASE + spapr->irq->nr_xirqs - SPAPR_IRQ_MSI;
> +    }
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -267,9 +278,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
>      }
> =20
>      /* Initialize the MSI IRQ allocator. */
> -    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
> -    }
> +    spapr_irq_msi_init(spapr);
> =20
>      if (spapr->irq->xics) {
>          Error *local_err =3D NULL;
> @@ -551,7 +560,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int nu=
m, bool align, Error **errp)
> =20
>  SpaprIrq spapr_irq_xics_legacy =3D {
>      .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
> -    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .xics        =3D true,
>      .xive        =3D false,
>  };
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 01ff41d4c4..cc0e7829b6 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2277,8 +2277,8 @@ static void spapr_phb_pci_enumerate(SpaprPhbState=
 *phb)
> =20
>  }
> =20
> -int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
> -                 uint32_t nr_msis, int *node_offset)
> +int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
> +                 uint32_t intc_phandle, void *fdt, int *node_offset)
>  {
>      int bus_off, i, j, ret;
>      uint32_t bus_range[] =3D { cpu_to_be32(0), cpu_to_be32(0xff) };
> @@ -2343,7 +2343,8 @@ int spapr_dt_phb(SpaprPhbState *phb, uint32_t int=
c_phandle, void *fdt,
>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0=
x1));
> -    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", nr_msis))=
;
> +    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
> +                          spapr_irq_nr_msis(spapr)));
> =20
>      /* Dynamic DMA window */
>      if (phb->ddw_enabled) {
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 23506f05d9..8877ff51fb 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -128,8 +128,8 @@ struct SpaprPhbState {
>  #define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS =
* \
>                                        64 * KiB)
> =20
> -int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
> -                 uint32_t nr_msis, int *node_offset);
> +int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
> +                 uint32_t intc_phandle, void *fdt, int *node_offset);
> =20
>  void spapr_pci_rtas_init(void);
> =20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 08173e714c..befe8e01dc 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -27,7 +27,6 @@
>  #define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
> =20
>  #define SPAPR_NR_XIRQS       0x1000
> -#define SPAPR_NR_MSIS        (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR=
_IRQ_MSI)
> =20
>  typedef struct SpaprMachineState SpaprMachineState;
> =20
> @@ -73,14 +72,13 @@ void spapr_irq_print_info(SpaprMachineState *spapr,=
 Monitor *mon);
>  void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>                    void *fdt, uint32_t phandle);
> =20
> -void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
> +uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
>                          Error **errp);
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t nu=
m);
> =20
>  typedef struct SpaprIrq {
>      uint32_t    nr_xirqs;
> -    uint32_t    nr_msis;
>      bool        xics;
>      bool        xive;
>  } SpaprIrq;
>=20


