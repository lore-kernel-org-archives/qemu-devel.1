Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5232FC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A778217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A778217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxlY-00014A-9n
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFxkh-000096-7s
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFxkf-0003aw-NF
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:50:27 -0400
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:53362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFxkf-0003aF-FS
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:50:25 -0400
Received: from player157.ha.ovh.net (unknown [10.109.146.175])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id E6243191770
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 11:50:22 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 6CAA0A75F25A;
 Thu,  3 Oct 2019 09:50:17 +0000 (UTC)
Subject: Re: [PATCH v4 07/25] ppc/spapr: Implement the XiveFabric interface
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-8-clg@kaod.org>
 <20191003015815.GI11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dc2ba71b-8783-297c-76e1-22607be4bf94@kaod.org>
Date: Thu, 3 Oct 2019 11:50:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003015815.GI11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 14149747082463906713
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.48.29
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/2019 03:58, David Gibson wrote:
> On Wed, Sep 18, 2019 at 06:06:27PM +0200, C=E9dric Le Goater wrote:
>> The CAM line matching sequence in the pseries machine does not change
>> much apart from the use of the new QOM interfaces. There is an extra
>> indirection because of the sPAPR IRQ backend of the machine. Only the
>> XIVE backend implements the new 'match_nvt' handler.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_irq.h |  6 ++++++
>>  hw/ppc/spapr.c             | 34 ++++++++++++++++++++++++++++++++++
>>  hw/ppc/spapr_irq.c         | 25 +++++++++++++++++++++++++
>>  3 files changed, 65 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 5db305165ce2..859780efaf95 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -31,6 +31,8 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, ui=
nt32_t num, bool align,
>>                          Error **errp);
>>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t n=
um);
>> =20
>> +struct XiveTCTXMatch;
>> +
>>  typedef struct SpaprIrq {
>>      uint32_t    nr_irqs;
>>      uint32_t    nr_msis;
>> @@ -50,6 +52,10 @@ typedef struct SpaprIrq {
>>      void (*set_irq)(void *opaque, int srcno, int val);
>>      const char *(*get_nodename)(SpaprMachineState *spapr);
>>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
>> +    int (*match_nvt)(SpaprMachineState *spapr, uint8_t format,
>> +                     uint8_t nvt_blk, uint32_t nvt_idx,
>> +                     bool cam_ignore, uint8_t priority,
>> +                     uint32_t logic_serv, struct XiveTCTXMatch *match=
);
>=20
> Obviously this will need some rework against my stuff.
>=20
> But more importantly, I don't see the point of indirecting via here,
> when the method is only relevant for the xive case.  Why not just
> assert that XIVE is in use in the XiveFabric hook, and go directly  to
> the XIVE matching code.

Yes you might be right. I had to introduce this helper to cover dual=20
and xive mode for some reason. I will rebase when your code is merged and=
=20
see how things fit together. I am not worried.

C.


>=20
>>  } SpaprIrq;
>> =20
>>  extern SpaprIrq spapr_irq_xics;
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 2725b139a7f0..90f6f5fb9536 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4360,6 +4360,37 @@ static void spapr_pic_print_info(InterruptStats=
Provider *obj,
>>                     kvm_irqchip_in_kernel() ? "in-kernel" : "emulated"=
);
>>  }
>> =20
>> +static int spapr_xive_match_nvt(XiveFabric *xfb, uint8_t format,
>> +                                uint8_t nvt_blk, uint32_t nvt_idx,
>> +                                bool cam_ignore, uint8_t priority,
>> +                                uint32_t logic_serv, XiveTCTXMatch *m=
atch)
>> +{
>> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
>> +    int count;
>> +
>> +    count =3D spapr->irq->match_nvt(spapr, format, nvt_blk, nvt_idx, =
cam_ignore,
>> +                                  priority, logic_serv, match);
>> +    if (count < 0) {
>> +        return count;
>> +    }
>> +
>> +    /*
>> +     * When we implement the save and restore of the thread interrupt
>> +     * contexts in the enter/exit CPU handlers of the machine and the
>> +     * escalations in QEMU, we should be able to handle non dispatche=
d
>> +     * vCPUs.
>> +     *
>> +     * Until this is done, the sPAPR machine should find at least one
>> +     * matching context always.
>> +     */
>> +    if (count =3D=3D 0) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispat=
ched\n",
>> +                      nvt_blk, nvt_idx);
>> +    }
>> +
>> +    return count;
>> +}
>> +
>>  int spapr_get_vcpu_id(PowerPCCPU *cpu)
>>  {
>>      return cpu->vcpu_id;
>> @@ -4456,6 +4487,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
>>      PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(o=
c);
>>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CL=
ASS(oc);
>> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
>> =20
>>      mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
>>      mc->ignore_boot_device_suffixes =3D true;
>> @@ -4514,6 +4546,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
>>       */
>>      mc->numa_mem_align_shift =3D 28;
>>      mc->numa_mem_supported =3D true;
>> +    xfc->match_nvt =3D spapr_xive_match_nvt;
>> =20
>>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
>> @@ -4547,6 +4580,7 @@ static const TypeInfo spapr_machine_info =3D {
>>          { TYPE_PPC_VIRTUAL_HYPERVISOR },
>>          { TYPE_XICS_FABRIC },
>>          { TYPE_INTERRUPT_STATS_PROVIDER },
>> +        { TYPE_XIVE_FABRIC },
>>          { }
>>      },
>>  };
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index d8f46b6797f8..8a6d79a59af2 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -257,6 +257,7 @@ SpaprIrq spapr_irq_xics =3D {
>>      .set_irq     =3D spapr_irq_set_irq_xics,
>>      .get_nodename =3D spapr_irq_get_nodename_xics,
>>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>> +    .match_nvt   =3D NULL, /* should not be used */
>>  };
>> =20
>>  /*
>> @@ -406,6 +407,18 @@ static void spapr_irq_init_kvm_xive(SpaprMachineS=
tate *spapr, Error **errp)
>>      }
>>  }
>> =20
>> +static int spapr_irq_match_nvt_xive(SpaprMachineState *spapr, uint8_t=
 format,
>> +                                    uint8_t nvt_blk, uint32_t nvt_idx=
,
>> +                                    bool cam_ignore, uint8_t priority=
,
>> +                                    uint32_t logic_serv, XiveTCTXMatc=
h *match)
>> +{
>> +    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
>> +    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
>> +
>> +    return xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
>> +                          priority, logic_serv, match);
>> +}
>> +
>>  /*
>>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>>   * with XICS.
>> @@ -431,6 +444,7 @@ SpaprIrq spapr_irq_xive =3D {
>>      .set_irq     =3D spapr_irq_set_irq_xive,
>>      .get_nodename =3D spapr_irq_get_nodename_xive,
>>      .init_kvm    =3D spapr_irq_init_kvm_xive,
>> +    .match_nvt   =3D spapr_irq_match_nvt_xive,
>>  };
>> =20
>>  /*
>> @@ -585,6 +599,15 @@ static const char *spapr_irq_get_nodename_dual(Sp=
aprMachineState *spapr)
>>      return spapr_irq_current(spapr)->get_nodename(spapr);
>>  }
>> =20
>> +static int spapr_irq_match_nvt_dual(SpaprMachineState *spapr, uint8_t=
 format,
>> +                                    uint8_t nvt_blk, uint32_t nvt_idx=
,
>> +                                    bool cam_ignore, uint8_t priority=
,
>> +                                    uint32_t logic_serv, XiveTCTXMatc=
h *match)
>> +{
>> +    return spapr_irq_current(spapr)->match_nvt(spapr, format, nvt_blk=
, nvt_idx,
>> +                                     cam_ignore, priority, logic_serv=
, match);
>> +}
>> +
>>  /*
>>   * Define values in sync with the XIVE and XICS backend
>>   */
>> @@ -608,6 +631,7 @@ SpaprIrq spapr_irq_dual =3D {
>>      .set_irq     =3D spapr_irq_set_irq_dual,
>>      .get_nodename =3D spapr_irq_get_nodename_dual,
>>      .init_kvm    =3D NULL, /* should not be used */
>> +    .match_nvt   =3D spapr_irq_match_nvt_dual,
>>  };
>> =20
>> =20
>> @@ -825,4 +849,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>>      .set_irq     =3D spapr_irq_set_irq_xics,
>>      .get_nodename =3D spapr_irq_get_nodename_xics,
>>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>> +    .match_nvt   =3D NULL, /* should not be used */
>>  };
>=20


