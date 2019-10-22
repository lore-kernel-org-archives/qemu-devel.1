Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56606CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2C2207FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2C2207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsbK-0007dd-7w
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMsaH-0006rg-1H
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMsaE-0001bg-LU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:44:16 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:54942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMsaD-0001Xi-SW
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:44:14 -0400
Received: from player732.ha.ovh.net (unknown [10.108.54.87])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 469F81B08CB
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 13:44:03 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id 079BEB26BD8F;
 Tue, 22 Oct 2019 11:43:57 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] ppc: reset the interrupt presenter from the CPU
 reset handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191022072246.9200-1-clg@kaod.org>
 <20191022072246.9200-4-clg@kaod.org>
 <acd04341-45dc-aa67-2412-f428f9f06054@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2b4bf242-48f0-79bb-c69e-b53bdaf0b0c9@kaod.org>
Date: Tue, 22 Oct 2019 13:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <acd04341-45dc-aa67-2412-f428f9f06054@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16970126346481535897
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgdegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.53.149
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

On 22/10/2019 11:08, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> On 10/22/19 9:22 AM, C=C3=A9dric Le Goater wrote:
>> On the sPAPR machine and PowerNV machine, the interrupt presenters are
>> created by a machine handler at the core level and are reseted
>=20
> Typo "reset"
>=20
>> independently. This is not consistent and it raises issues when it
>> comes to handle hot-plugged CPUs. In that case, the presenters are not
>> reseted. This is less of an issue in XICS, although a zero MFFR could
>=20
> Same typo.
>=20
>> be a concern, but in XIVE, the OS CAM line is not set and this breaks
>> the presenting algorithm. The current code has workarounds which need
>> a global cleanup.
>>
>> Extend the sPAPR IRQ backend and the PowerNV Chip class with a new
>> cpu_intc_reset() handler called by the CPU reset handler and remove
>> the XiveTCTX reset handler which is now redundant.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>> =C2=A0 include/hw/ppc/pnv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 1 +
>> =C2=A0 include/hw/ppc/spapr_irq.h |=C2=A0 2 ++
>> =C2=A0 include/hw/ppc/xics.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 include/hw/ppc/xive.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 hw/intc/spapr_xive.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 9 +++++++++
>> =C2=A0 hw/intc/xics.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++------
>> =C2=A0 hw/intc/xics_spapr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 7 +++++++
>> =C2=A0 hw/intc/xive.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 12 +-----------
>> =C2=A0 hw/ppc/pnv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++++++++++++
>> =C2=A0 hw/ppc/pnv_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 8 ++++++++
>> =C2=A0 hw/ppc/spapr_cpu_core.c=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++++-
>> =C2=A0 hw/ppc/spapr_irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 14 ++++++++++++++
>> =C2=A0 12 files changed, 68 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index 1cdbe55bf86c..2a780e633f23 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -111,6 +111,7 @@ typedef struct PnvChipClass {
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t (*core_pir)(PnvChip *ch=
ip, uint32_t core_id);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*intc_create)(PnvChip *chip, Powe=
rPCCPU *cpu, Error **errp);
>> +=C2=A0=C2=A0=C2=A0 void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISABus *(*isa_create)(PnvChip *chip, Er=
ror **errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*dt_populate)(PnvChip *chip, void=
 *fdt);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*pic_print_info)(PnvChip *chip, M=
onitor *mon);
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 5e150a667902..09232999b07e 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -52,6 +52,7 @@ typedef struct SpaprInterruptControllerClass {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*cpu_intc_create)(SpaprInterruptCo=
ntroller *intc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 PowerPCCPU *cpu, Error **errp);
>> +=C2=A0=C2=A0=C2=A0 void (*cpu_intc_reset)(SpaprInterruptController *i=
ntc, PowerPCCPU *cpu);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*claim_irq)(SpaprInterruptControll=
er *intc, int irq, bool lsi,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*free_irq)(SpaprInterruptControll=
er *intc, int irq);
>> @@ -68,6 +69,7 @@ void spapr_irq_update_active_intc(SpaprMachineState =
*spapr);
>> =C2=A0 =C2=A0 int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PowerPCCPU *cpu, Error **errp);
>> +void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *c=
pu);
>> =C2=A0 void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mo=
n);
>> =C2=A0 void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *fdt, uint32_t phandle);
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 1e6a9300eb2b..602173c12250 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -161,6 +161,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
>> =C2=A0 uint32_t icp_accept(ICPState *ss);
>> =C2=A0 uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
>> =C2=A0 void icp_eoi(ICPState *icp, uint32_t xirr);
>> +void icp_reset(ICPState *icp);
>> =C2=A0 =C2=A0 void ics_write_xive(ICSState *ics, int nr, int server,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t priority, =
uint8_t saved_priority);
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index fd3319bd3202..99381639f50c 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -415,6 +415,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr =
offset, unsigned size);
>> =C2=A0 =C2=A0 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *m=
on);
>> =C2=A0 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error *=
*errp);
>> +void xive_tctx_reset(XiveTCTX *tctx);
>> =C2=A0 =C2=A0 static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk=
, uint32_t nvt_idx)
>> =C2=A0 {
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index ba32d2cc5b0f..20a8d8285f64 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -553,6 +553,14 @@ static int spapr_xive_cpu_intc_create(SpaprInterr=
uptController *intc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static void spapr_xive_cpu_intc_reset(SpaprInterruptController=
 *intc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
PowerPCCPU *cpu)
>> +{
>> +=C2=A0=C2=A0=C2=A0 XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
>> +
>> +=C2=A0=C2=A0=C2=A0 xive_tctx_reset(tctx);
>> +}
>> +
>> =C2=A0 static void spapr_xive_set_irq(SpaprInterruptController *intc, =
int irq, int val)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SpaprXive *xive =3D SPAPR_XIVE(intc);
>> @@ -697,6 +705,7 @@ static void spapr_xive_class_init(ObjectClass *kla=
ss, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->activate =3D spapr_xive_activate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->deactivate =3D spapr_xive_deactiv=
ate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->cpu_intc_create =3D spapr_xive_cp=
u_intc_create;
>> +=C2=A0=C2=A0=C2=A0 sicc->cpu_intc_reset =3D spapr_xive_cpu_intc_reset=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->claim_irq =3D spapr_xive_claim_ir=
q;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->free_irq =3D spapr_xive_free_irq;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->set_irq =3D spapr_xive_set_irq;
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index b5ac408f7b74..6da05763f9db 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -274,10 +274,8 @@ static const VMStateDescription vmstate_icp_serve=
r =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 };
>> =C2=A0 -static void icp_reset_handler(void *dev)
>> +void icp_reset(ICPState *icp)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 ICPState *icp =3D ICP(dev);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 icp->xirr =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 icp->pending_priority =3D 0xff;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 icp->mfrr =3D 0xff;
>> @@ -288,7 +286,7 @@ static void icp_reset_handler(void *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_irqchip_in_kernel()) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_er=
r =3D NULL;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 icp_set_kvm_state(I=
CP(dev), &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 icp_set_kvm_state(icp, &lo=
cal_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) =
{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report_err(local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -351,7 +349,6 @@ static void icp_realize(DeviceState *dev, Error **=
errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 qemu_register_reset(icp_reset_handler, dev)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmstate_register(NULL, icp->cs->cpu_ind=
ex, &vmstate_icp_server, icp);
>> =C2=A0 }
>> =C2=A0 @@ -360,7 +357,6 @@ static void icp_unrealize(DeviceState *dev,=
 Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ICPState *icp =3D ICP(dev);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmstate_unregister(NULL, &vmstat=
e_icp_server, icp);
>> -=C2=A0=C2=A0=C2=A0 qemu_unregister_reset(icp_reset_handler, dev);
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void icp_class_init(ObjectClass *klass, void *dat=
a)
>> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
>> index 4f64b9a9fc66..7418fb9f370c 100644
>> --- a/hw/intc/xics_spapr.c
>> +++ b/hw/intc/xics_spapr.c
>> @@ -346,6 +346,12 @@ static int xics_spapr_cpu_intc_create(SpaprInterr=
uptController *intc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static void xics_spapr_cpu_intc_reset(SpaprInterruptController=
 *intc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
PowerPCCPU *cpu)
>> +{
>> +=C2=A0=C2=A0=C2=A0 icp_reset(spapr_cpu_state(cpu)->icp);
>> +}
>> +
>> =C2=A0 static int xics_spapr_claim_irq(SpaprInterruptController *intc,=
 int irq,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool lsi, Error **err=
p)
>> =C2=A0 {
>> @@ -433,6 +439,7 @@ static void ics_spapr_class_init(ObjectClass *klas=
s, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->activate =3D xics_spapr_activate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->deactivate =3D xics_spapr_deactiv=
ate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->cpu_intc_create =3D xics_spapr_cp=
u_intc_create;
>> +=C2=A0=C2=A0=C2=A0 sicc->cpu_intc_reset =3D xics_spapr_cpu_intc_reset=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->claim_irq =3D xics_spapr_claim_ir=
q;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->free_irq =3D xics_spapr_free_irq;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sicc->set_irq =3D xics_spapr_set_irq;
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index d420c6571e14..f066be5eb5e3 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -547,10 +547,8 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Mon=
itor *mon)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 -static void xive_tctx_reset(void *dev)
>> +void xive_tctx_reset(XiveTCTX *tctx)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 XiveTCTX *tctx =3D XIVE_TCTX(dev);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(tctx->regs, 0, sizeof(tctx->regs=
));
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Set some defaults */
>> @@ -607,13 +605,6 @@ static void xive_tctx_realize(DeviceState *dev, E=
rror **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 qemu_register_reset(xive_tctx_reset, dev);
>> -}
>> -
>> -static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
>> -{
>> -=C2=A0=C2=A0=C2=A0 qemu_unregister_reset(xive_tctx_reset, dev);
>> =C2=A0 }
>> =C2=A0 =C2=A0 static int vmstate_xive_tctx_pre_save(void *opaque)
>> @@ -668,7 +659,6 @@ static void xive_tctx_class_init(ObjectClass *klas=
s, void *data)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->desc =3D "XIVE Interrupt Thr=
ead Context";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->realize =3D xive_tctx_realize;
>> -=C2=A0=C2=A0=C2=A0 dc->unrealize =3D xive_tctx_unrealize;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->vmsd =3D &vmstate_xive_tctx;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Reason: part of XIVE interrupt =
controller, needs to be wired up
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 7cf64b6d2533..4a51fb65a834 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -778,6 +778,13 @@ static void pnv_chip_power8_intc_create(PnvChip *=
chip, PowerPCCPU *cpu,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pnv_cpu->intc =3D obj;
>> =C2=A0 }
>> =C2=A0 +static void pnv_chip_power8_intc_reset(PnvChip *chip, PowerPCC=
PU *cpu)
>> +{
>> +=C2=A0=C2=A0=C2=A0 PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
>> +
>> +=C2=A0=C2=A0=C2=A0 icp_reset(ICP(pnv_cpu->intc));
>> +}
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 0:48=C2=A0 Reserved - Read as zeroes
>> =C2=A0=C2=A0 *=C2=A0=C2=A0 49:52=C2=A0 Node ID
>> @@ -815,6 +822,13 @@ static void pnv_chip_power9_intc_create(PnvChip *=
chip, PowerPCCPU *cpu,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pnv_cpu->intc =3D obj;
>> =C2=A0 }
>> =C2=A0 +static void pnv_chip_power9_intc_reset(PnvChip *chip, PowerPCC=
PU *cpu)
>> +{
>> +=C2=A0=C2=A0=C2=A0 PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
>> +
>> +=C2=A0=C2=A0=C2=A0 xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
>> +}
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Allowed core identifiers on a POWER8 Processor Chip :
>> =C2=A0=C2=A0 *
>> @@ -984,6 +998,7 @@ static void pnv_chip_power8e_class_init(ObjectClas=
s *klass, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->cores_mask =3D POWER8E_CORE_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->core_pir =3D pnv_chip_core_pir_p8;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->intc_create =3D pnv_chip_power8_intc=
_create;
>> +=C2=A0=C2=A0=C2=A0 k->intc_reset =3D pnv_chip_power8_intc_reset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->isa_create =3D pnv_chip_power8_isa_c=
reate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->dt_populate =3D pnv_chip_power8_dt_p=
opulate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->pic_print_info =3D pnv_chip_power8_p=
ic_print_info;
>> @@ -1003,6 +1018,7 @@ static void pnv_chip_power8_class_init(ObjectCla=
ss *klass, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->cores_mask =3D POWER8_CORE_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->core_pir =3D pnv_chip_core_pir_p8;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->intc_create =3D pnv_chip_power8_intc=
_create;
>> +=C2=A0=C2=A0=C2=A0 k->intc_reset =3D pnv_chip_power8_intc_reset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->isa_create =3D pnv_chip_power8_isa_c=
reate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->dt_populate =3D pnv_chip_power8_dt_p=
opulate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->pic_print_info =3D pnv_chip_power8_p=
ic_print_info;
>> @@ -1022,6 +1038,7 @@ static void pnv_chip_power8nvl_class_init(Object=
Class *klass, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->cores_mask =3D POWER8_CORE_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->core_pir =3D pnv_chip_core_pir_p8;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->intc_create =3D pnv_chip_power8_intc=
_create;
>> +=C2=A0=C2=A0=C2=A0 k->intc_reset =3D pnv_chip_power8_intc_reset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->isa_create =3D pnv_chip_power8nvl_is=
a_create;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->dt_populate =3D pnv_chip_power8_dt_p=
opulate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->pic_print_info =3D pnv_chip_power8_p=
ic_print_info;
>> @@ -1191,6 +1208,7 @@ static void pnv_chip_power9_class_init(ObjectCla=
ss *klass, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->cores_mask =3D POWER9_CORE_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->core_pir =3D pnv_chip_core_pir_p9;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->intc_create =3D pnv_chip_power9_intc=
_create;
>> +=C2=A0=C2=A0=C2=A0 k->intc_reset =3D pnv_chip_power9_intc_reset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->isa_create =3D pnv_chip_power9_isa_c=
reate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->dt_populate =3D pnv_chip_power9_dt_p=
opulate;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->pic_print_info =3D pnv_chip_power9_p=
ic_print_info;
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index b1a7489e7abf..f36cb39dbf77 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -45,6 +45,8 @@ static void pnv_cpu_reset(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PowerPCCPU *cpu =3D opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUState *cs =3D CPU(cpu);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUPPCState *env =3D &cpu->env;
>> +=C2=A0=C2=A0=C2=A0 PnvChipClass *pcc;
>> +=C2=A0=C2=A0=C2=A0 Object *chip;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_reset(cs);
>> =C2=A0 @@ -55,6 +57,10 @@ static void pnv_cpu_reset(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->gpr[3] =3D PNV_FDT_ADDR;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->nip =3D 0x10;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->msr |=3D MSR_HVB; /* Hypervisor mo=
de */
>> +
>> +=C2=A0=C2=A0=C2=A0 chip =3D object_property_get_link(OBJECT(cpu), "ch=
ip", &error_fatal);
>=20
> Why not add a PnvChip *chip field in PnvCore?

because this is a PowerPCCPU object and not a PnvCore.=20

Your remark is good and I think I will follow the same pattern for PowerN=
V=20
that Greg has introduced for sPAPR in patch 2.=20

Thanks,

C.


> Then you only get it in realize() and it is available in reset().
>
> Rest of your patch looks OK from a QOM PoV.
>=20
>> +=C2=A0=C2=A0=C2=A0 pcc =3D PNV_CHIP_GET_CLASS(chip);
>> +=C2=A0=C2=A0=C2=A0 pcc->intc_reset(PNV_CHIP(chip), cpu);
>> =C2=A0 }
>> =C2=A0 =C2=A0 /*
>> @@ -169,6 +175,8 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvC=
hip *chip, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PnvChipClass *pcc =3D PNV_CHIP_GET_CLAS=
S(chip);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 object_property_add_const_link(OBJECT(cpu),=
 "chip",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT(chip)=
, &error_fatal);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(cpu), t=
rue, "realized", &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate=
(errp, local_err);
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 5947e39b36ad..d2903c2d0f22 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -32,6 +32,7 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PowerPCCPUClass *pcc =3D POWERPC_CPU_GE=
T_CLASS(cpu);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SpaprCpuState *spapr_cpu =3D spapr_cpu_=
state(cpu);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong lpcr;
>> +=C2=A0=C2=A0=C2=A0 SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_ge=
t_machine());
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_reset(cs);
>> =C2=A0 @@ -76,9 +77,11 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spapr_cpu->dtl_addr =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spapr_cpu->dtl_size =3D 0;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get=
_machine()), cpu);
>> +=C2=A0=C2=A0=C2=A0 spapr_caps_cpu_apply(spapr, cpu);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_check_mmu(cpu, &error_fatal)=
;
>> +
>> +=C2=A0=C2=A0=C2=A0 spapr_irq_cpu_intc_reset(spapr, cpu);
>> =C2=A0 }
>> =C2=A0 =C2=A0 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_u=
long nip, target_ulong r3)
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 234d1073e518..b941608b69ba 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -220,6 +220,20 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *=
spapr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerP=
CCPU *cpu)
>> +{
>> +=C2=A0=C2=A0=C2=A0 SpaprInterruptController *intcs[] =3D ALL_INTCS(sp=
apr);
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SpaprInterruptController *=
intc =3D intcs[i];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (intc) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sp=
aprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(intc);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
cc->cpu_intc_reset(intc, cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> =C2=A0 static void spapr_set_irq(void *opaque, int irq, int level)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SpaprMachineState *spapr =3D SPAPR_MACH=
INE(opaque);
>>
>=20


