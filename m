Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214AECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3EB206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3EB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHSj-0001SK-MK
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iIEPT-00029j-8T
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iIEPQ-0007ea-TL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:01:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iIEPQ-0007dt-FS
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:01:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x99FhIvN060014
 for <qemu-devel@nongnu.org>; Wed, 9 Oct 2019 12:01:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vhg87xgfu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:01:48 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 9 Oct 2019 17:01:45 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Oct 2019 17:01:42 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x99G1feb42008678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2019 16:01:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8469E4C052;
 Wed,  9 Oct 2019 16:01:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6320E4C050;
 Wed,  9 Oct 2019 16:01:41 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Oct 2019 16:01:41 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-2-100.uk.ibm.com [9.145.2.100])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 853F2220121;
 Wed,  9 Oct 2019 18:01:40 +0200 (CEST)
Subject: Re: [PATCH v4 16/19] spapr: Move SpaprIrq::nr_xirqs to
 SpaprMachineClass
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-17-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Wed, 9 Oct 2019 18:01:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009060818.29719-17-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19100916-0020-0000-0000-0000037788B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100916-0021-0000-0000-000021CD90DE
Message-Id: <5cc759a5-43ef-a453-82cb-5cd162494e35@kaod.org>
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
 mx0a-001b2d01.pphosted.com id x99FhIvN060014
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
> For the benefit of peripheral device allocation, the number of availabl=
e
> irqs really wants to be the same on a given machine type version,
> regardless of what irq backends we are using.  That's the case now, but
> only because we make sure the different SpaprIrq instances have the sam=
e
> value except for the special legacy one.
>=20
> Since this really only depends on machine type version, move the value =
to
> SpaprMachineClass instead of SpaprIrq.  This also puts the code to set =
it
> to the lower value on old machine types right next to setting
> legacy_irq_allocation, which needs to go hand in hand.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr.c             |  2 ++
>  hw/ppc/spapr_irq.c         | 33 ++++++++++++++++-----------------
>  include/hw/ppc/spapr.h     |  1 +
>  include/hw/ppc/spapr_irq.h |  1 -
>  4 files changed, 19 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 153cc54354..e1ff03152e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4443,6 +4443,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
>      smc->linux_pci_probe =3D true;
> +    smc->nr_xirqs =3D SPAPR_NR_XIRQS;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> @@ -4578,6 +4579,7 @@ static void spapr_machine_3_0_class_options(Machi=
neClass *mc)
>      compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_le=
n);
> =20
>      smc->legacy_irq_allocation =3D true;
> +    smc->nr_xirqs =3D 0x400;
>      smc->irq =3D &spapr_irq_xics_legacy;

yes. this is clearly better to this constant at the machine level.

c.=20


>  }
> =20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 076da31501..2768f9a765 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -106,7 +106,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptCont=
roller *, Error **),
>   */
> =20
>  SpaprIrq spapr_irq_xics =3D {
> -    .nr_xirqs    =3D SPAPR_NR_XIRQS,
>      .xics        =3D true,
>      .xive        =3D false,
>  };
> @@ -116,7 +115,6 @@ SpaprIrq spapr_irq_xics =3D {
>   */
> =20
>  SpaprIrq spapr_irq_xive =3D {
> -    .nr_xirqs    =3D SPAPR_NR_XIRQS,
>      .xics        =3D false,
>      .xive        =3D true,
>  };
> @@ -134,7 +132,6 @@ SpaprIrq spapr_irq_xive =3D {
>   * Define values in sync with the XIVE and XICS backend
>   */
>  SpaprIrq spapr_irq_dual =3D {
> -    .nr_xirqs    =3D SPAPR_NR_XIRQS,
>      .xics        =3D true,
>      .xive        =3D true,
>  };
> @@ -251,16 +248,19 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint3=
2_t nr_servers,
> =20
>  uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
>  {
> -    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        return spapr->irq->nr_xirqs;
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    if (smc->legacy_irq_allocation) {
> +        return smc->nr_xirqs;
>      } else {
> -        return SPAPR_XIRQ_BASE + spapr->irq->nr_xirqs - SPAPR_IRQ_MSI;
> +        return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
>      }
>  }
> =20
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> =20
>      if (machine_kernel_irqchip_split(machine)) {
>          error_setg(errp, "kernel_irqchip split mode not supported on p=
series");
> @@ -298,8 +298,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
>              return;
>          }
> =20
> -        object_property_set_int(obj, spapr->irq->nr_xirqs, "nr-irqs",
> -                                &local_err);
> +        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_=
err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
> @@ -320,8 +319,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
>          int i;
> =20
>          dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> -        qdev_prop_set_uint32(dev, "nr-irqs",
> -                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> +        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIR=
Q_BASE);
>          /*
>           * 8 XIVE END structures per CPU. One for each available
>           * priority
> @@ -346,17 +344,18 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
>      }
> =20
>      spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
> -                                      spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
> +                                      smc->nr_xirqs + SPAPR_XIRQ_BASE)=
;
>  }
> =20
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
>  {
>      SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
>      int i;
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      int rc;
> =20
>      assert(irq >=3D SPAPR_XIRQ_BASE);
> -    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
> =20
>      for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
>          SpaprInterruptController *intc =3D intcs[i];
> @@ -376,9 +375,10 @@ void spapr_irq_free(SpaprMachineState *spapr, int =
irq, int num)
>  {
>      SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
>      int i, j;
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> =20
>      assert(irq >=3D SPAPR_XIRQ_BASE);
> -    assert((irq + num) <=3D (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +    assert((irq + num) <=3D (smc->nr_xirqs + SPAPR_XIRQ_BASE));
> =20
>      for (i =3D irq; i < (irq + num); i++) {
>          for (j =3D 0; j < ARRAY_SIZE(intcs); j++) {
> @@ -395,6 +395,8 @@ void spapr_irq_free(SpaprMachineState *spapr, int i=
rq, int num)
> =20
>  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
>  {
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
>      /*
>       * This interface is basically for VIO and PHB devices to find the
>       * right qemu_irq to manipulate, so we only allow access to the
> @@ -403,7 +405,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int i=
rq)
>       * interfaces, we can change this if we need to in future.
>       */
>      assert(irq >=3D SPAPR_XIRQ_BASE);
> -    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
> =20
>      if (spapr->ics) {
>          assert(ics_valid_irq(spapr->ics, irq));
> @@ -556,10 +558,7 @@ int spapr_irq_find(SpaprMachineState *spapr, int n=
um, bool align, Error **errp)
>      return first + ics->offset;
>  }
> =20
> -#define SPAPR_IRQ_XICS_LEGACY_NR_XIRQS     0x400
> -
>  SpaprIrq spapr_irq_xics_legacy =3D {
> -    .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .xics        =3D true,
>      .xive        =3D false,
>  };
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 763da757f0..623e8e3f93 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -119,6 +119,7 @@ struct SpaprMachineClass {
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      bool pre_2_10_has_unused_icps;
>      bool legacy_irq_allocation;
> +    uint32_t nr_xirqs;
>      bool broken_host_serial_model; /* present real host info to the gu=
est */
>      bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
>      bool linux_pci_probe;
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index befe8e01dc..5e150a6679 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -78,7 +78,6 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uin=
t32_t num, bool align,
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t nu=
m);
> =20
>  typedef struct SpaprIrq {
> -    uint32_t    nr_xirqs;
>      bool        xics;
>      bool        xive;
>  } SpaprIrq;
>=20


