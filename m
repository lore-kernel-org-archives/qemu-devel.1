Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE2C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A169206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A169206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFmJ-00048f-VD
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iI87a-0003Qn-7p
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iI87Y-0006r7-Kw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:19:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31588
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iI87Y-0006qV-Fs
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:19:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x999FOwI127565
 for <qemu-devel@nongnu.org>; Wed, 9 Oct 2019 05:18:59 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vh8m80eq1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 05:18:59 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 9 Oct 2019 10:18:57 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Oct 2019 10:18:53 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x999IMfH20251042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2019 09:18:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 221DC4C058;
 Wed,  9 Oct 2019 09:18:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0262C4C040;
 Wed,  9 Oct 2019 09:18:52 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Oct 2019 09:18:51 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-55-18.uk.ibm.com [9.145.55.18])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 23B0A220198;
 Wed,  9 Oct 2019 11:18:51 +0200 (CEST)
Subject: Re: [PATCH v4 08/19] spapr, xics, xive: Move set_irq from SpaprIrq to
 SpaprInterruptController
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-9-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Wed, 9 Oct 2019 11:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009060818.29719-9-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19100909-0020-0000-0000-0000037763EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100909-0021-0000-0000-000021CD699A
Message-Id: <557433c3-8239-85b5-dc7e-4ffc8be18dd4@kaod.org>
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
 mx0a-001b2d01.pphosted.com id x999FOwI127565
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
> This method depends only on the active irq controller.  Now that we've
> formalized the notion of active controller we can dispatch directly thr=
ough
> that, rather than dispatching via SpaprIrq with the dual version having
> to do a second conditional dispatch.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c       | 12 +++++++++++
>  hw/intc/xics_spapr.c       |  9 +++++++++
>  hw/ppc/spapr_irq.c         | 41 ++++++++++----------------------------
>  include/hw/ppc/spapr_irq.h |  4 +++-
>  4 files changed, 34 insertions(+), 32 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index ff1a175b44..52d5e71793 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -553,6 +553,17 @@ static int spapr_xive_cpu_intc_create(SpaprInterru=
ptController *intc,
>      return 0;
>  }
> =20
> +static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq=
, int val)
> +{
> +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        kvmppc_xive_source_set_irq(&xive->source, irq, val);
> +    } else {
> +        xive_source_set_irq(&xive->source, irq, val);
> +    }
> +}
> +
>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -574,6 +585,7 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
>      sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
>      sicc->claim_irq =3D spapr_xive_claim_irq;
>      sicc->free_irq =3D spapr_xive_free_irq;
> +    sicc->set_irq =3D spapr_xive_set_irq;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 224fe1efcd..02372697f6 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -373,6 +373,14 @@ static void xics_spapr_free_irq(SpaprInterruptCont=
roller *intc, int irq)
>      memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
>  }
> =20
> +static void xics_spapr_set_irq(SpaprInterruptController *intc, int irq=
, int val)
> +{
> +    ICSState *ics =3D ICS_SPAPR(intc);
> +    uint32_t srcno =3D irq - ics->offset;
> +
> +    ics_set_irq(ics, srcno, val);
> +}
> +
>  static void ics_spapr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -384,6 +392,7 @@ static void ics_spapr_class_init(ObjectClass *klass=
, void *data)
>      sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
>      sicc->claim_irq =3D xics_spapr_claim_irq;
>      sicc->free_irq =3D xics_spapr_free_irq;
> +    sicc->set_irq =3D xics_spapr_set_irq;
>  }
> =20
>  static const TypeInfo ics_spapr_info =3D {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 249a2688ac..bfccb815ed 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -123,14 +123,6 @@ static int spapr_irq_post_load_xics(SpaprMachineSt=
ate *spapr, int version_id)
>      return 0;
>  }
> =20
> -static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
> -{
> -    SpaprMachineState *spapr =3D opaque;
> -    uint32_t srcno =3D irq - spapr->ics->offset;
> -
> -    ics_set_irq(spapr->ics, srcno, val);
> -}
> -
>  static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **err=
p)
>  {
>      Error *local_err =3D NULL;
> @@ -159,7 +151,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .dt_populate =3D spapr_dt_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
> -    .set_irq     =3D spapr_irq_set_irq_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>  };
> =20
> @@ -208,17 +199,6 @@ static void spapr_irq_reset_xive(SpaprMachineState=
 *spapr, Error **errp)
>      spapr_xive_mmio_set_enabled(spapr->xive, true);
>  }
> =20
> -static void spapr_irq_set_irq_xive(void *opaque, int irq, int val)
> -{
> -    SpaprMachineState *spapr =3D opaque;
> -
> -    if (kvm_irqchip_in_kernel()) {
> -        kvmppc_xive_source_set_irq(&spapr->xive->source, irq, val);
> -    } else {
> -        xive_source_set_irq(&spapr->xive->source, irq, val);
> -    }
> -}
> -
>  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **=
errp)
>  {
>      if (kvm_enabled()) {
> @@ -236,7 +216,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .dt_populate =3D spapr_dt_xive,
>      .post_load   =3D spapr_irq_post_load_xive,
>      .reset       =3D spapr_irq_reset_xive,
> -    .set_irq     =3D spapr_irq_set_irq_xive,
>      .init_kvm    =3D spapr_irq_init_kvm_xive,
>  };
> =20
> @@ -316,13 +295,6 @@ static void spapr_irq_reset_dual(SpaprMachineState=
 *spapr, Error **errp)
>      spapr_irq_current(spapr)->reset(spapr, errp);
>  }
> =20
> -static void spapr_irq_set_irq_dual(void *opaque, int irq, int val)
> -{
> -    SpaprMachineState *spapr =3D opaque;
> -
> -    spapr_irq_current(spapr)->set_irq(spapr, irq, val);
> -}
> -
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -336,7 +308,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .dt_populate =3D spapr_irq_dt_populate_dual,
>      .post_load   =3D spapr_irq_post_load_dual,
>      .reset       =3D spapr_irq_reset_dual,
> -    .set_irq     =3D spapr_irq_set_irq_dual,
>      .init_kvm    =3D NULL, /* should not be used */
>  };
> =20
> @@ -424,6 +395,15 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *s=
papr,
>      return 0;
>  }
> =20
> +static void spapr_set_irq(void *opaque, int irq, int level)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
> +    SpaprInterruptControllerClass *sicc
> +        =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +
> +    sicc->set_irq(spapr->active_intc, irq, level);
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -513,7 +493,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
>          spapr_xive_hcall_init(spapr);
>      }
> =20
> -    spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
> +    spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
>                                        spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
>  }
> =20
> @@ -737,7 +717,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .dt_populate =3D spapr_dt_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
> -    .set_irq     =3D spapr_irq_set_irq_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>  };
> =20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 593059eff5..ece8d2ea48 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -56,6 +56,9 @@ typedef struct SpaprInterruptControllerClass {
>      int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi=
,
>                       Error **errp);
>      void (*free_irq)(SpaprInterruptController *intc, int irq);
> +
> +    /* These methods should only be called on the active intc */
> +    void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
>  } SpaprInterruptControllerClass;
> =20
>  void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> @@ -80,7 +83,6 @@ typedef struct SpaprIrq {
>                          void *fdt, uint32_t phandle);
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
> -    void (*set_irq)(void *opaque, int srcno, int val);
>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
>  } SpaprIrq;
> =20
>=20


