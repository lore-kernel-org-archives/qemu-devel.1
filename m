Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC902206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC902206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd9zT-0007WQ-OM
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jd9yC-0006Nc-Tf
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:04:32 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:49736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jd9yB-0003PE-Ao
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:04:32 -0400
Received: from player746.ha.ovh.net (unknown [10.108.57.211])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id C5351283432
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 12:04:20 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id AEBD512BEEC64;
 Mon, 25 May 2020 10:04:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003e2ae6bcf-1478-4e1a-b992-299b210d8a9b,26835B9205782E90874D777227A1F0DDBFD0E061)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 2/2] ppc/xive: Add support for PQ state bits offload
To: Greg Kurz <groug@kaod.org>
References: <20200401164653.28231-1-clg@kaod.org>
 <20200401164653.28231-3-clg@kaod.org> <20200402125155.3485c78c@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1340e631-9a3c-dc52-f3f8-5107f5af43af@kaod.org>
Date: Mon, 25 May 2020 12:04:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200402125155.3485c78c@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10962887395188116288
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvtddgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejgeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.51.82; envelope-from=clg@kaod.org;
 helo=14.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:04:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 12:51 PM, Greg Kurz wrote:
> On Wed,  1 Apr 2020 18:46:53 +0200
> Cédric Le Goater <clg@kaod.org> wrote:
> 
>> The trigger message coming from a HW source contains a special bit
>> informing the XIVE interrupt controller that the PQ bits have been
>> checked at the source or not. Depending on the value, the IC can
>> perform the check and the state transition locally using its own PQ
>> state bits.
>>
>> The following changes add new accessors to the XiveRouter required to
>> query and update the PQ state bits. This is only applies to the
>> PowerNV machine, sPAPR is not concerned by such complex configuration.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive.h  |  8 +++++--
>>  hw/intc/pnv_xive.c     | 37 +++++++++++++++++++++++++++++---
>>  hw/intc/xive.c         | 48 ++++++++++++++++++++++++++++++++++++------
>>  hw/pci-host/pnv_phb4.c |  9 ++++++--
>>  hw/ppc/pnv_psi.c       |  8 +++++--
>>  5 files changed, 94 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 112fb6fb6dbe..050e49c14fd9 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -160,7 +160,7 @@ typedef struct XiveNotifier XiveNotifier;
>>  
>>  typedef struct XiveNotifierClass {
>>      InterfaceClass parent;
>> -    void (*notify)(XiveNotifier *xn, uint32_t lisn);
>> +    void (*notify)(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
>>  } XiveNotifierClass;
>>  
>>  /*
>> @@ -354,6 +354,10 @@ typedef struct XiveRouterClass {
>>      /* XIVE table accessors */
>>      int (*get_eas)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>>                     XiveEAS *eas);
>> +    int (*get_pq)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>> +                  uint8_t *pq);
>> +    int (*set_pq)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>> +                  uint8_t *pq);
>>      int (*get_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
>>                     XiveEND *end);
>>      int (*write_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
>> @@ -375,7 +379,7 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
>>                          XiveNVT *nvt);
>>  int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
>>                            XiveNVT *nvt, uint8_t word_number);
>> -void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
>> +void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
>>  
>>  /*
>>   * XIVE Presenter
>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>> index 77cacdd6c623..bcfe9dc54e3b 100644
>> --- a/hw/intc/pnv_xive.c
>> +++ b/hw/intc/pnv_xive.c
>> @@ -373,6 +373,34 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
>>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>>  }
>>  
>> +static int pnv_xive_get_pq(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
>> +                           uint8_t *pq)
>> +{
>> +    PnvXive *xive = PNV_XIVE(xrtr);
>> +
>> +    if (pnv_xive_block_id(xive) != blk) {
>> +        xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx));
>> +        return -1;
>> +    }
>> +
>> +    *pq = xive_source_esb_get(&xive->ipi_source, idx);
>> +    return 0;
>> +}
>> +
>> +static int pnv_xive_set_pq(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
>> +                           uint8_t *pq)
>> +{
>> +    PnvXive *xive = PNV_XIVE(xrtr);
>> +
>> +    if (pnv_xive_block_id(xive) != blk) {
>> +        xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx));
>> +        return -1;
>> +    }
>> +
>> +    *pq = xive_source_esb_set(&xive->ipi_source, idx, *pq);
>> +    return 0;
>> +}
>> +
>>  /*
>>   * One bit per thread id. The first register PC_THREAD_EN_REG0 covers
>>   * the first cores 0-15 (normal) of the chip or 0-7 (fused). The
>> @@ -469,12 +497,12 @@ static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
>>   * event notification to the Router. This is required on a multichip
>>   * system.
>>   */
>> -static void pnv_xive_notify(XiveNotifier *xn, uint32_t srcno)
>> +static void pnv_xive_notify(XiveNotifier *xn, uint32_t srcno, bool pq_checked)
>>  {
>>      PnvXive *xive = PNV_XIVE(xn);
>>      uint8_t blk = pnv_xive_block_id(xive);
>>  
>> -    xive_router_notify(xn, XIVE_EAS(blk, srcno));
>> +    xive_router_notify(xn, XIVE_EAS(blk, srcno), pq_checked);
>>  }
>>  
>>  /*
>> @@ -1316,7 +1344,8 @@ static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t val)
>>      blk = XIVE_EAS_BLOCK(val);
>>      idx = XIVE_EAS_INDEX(val);
>>  
>> -    xive_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx));
>> +    xive_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx),
>> +                       !!(val & XIVE_TRIGGER_PQ));
>>  }
>>  
>>  static void pnv_xive_ic_notify_write(void *opaque, hwaddr addr, uint64_t val,
>> @@ -1944,6 +1973,8 @@ static void pnv_xive_class_init(ObjectClass *klass, void *data)
>>      device_class_set_props(dc, pnv_xive_properties);
>>  
>>      xrc->get_eas = pnv_xive_get_eas;
>> +    xrc->get_pq = pnv_xive_get_pq;
>> +    xrc->set_pq = pnv_xive_set_pq;
>>      xrc->get_end = pnv_xive_get_end;
>>      xrc->write_end = pnv_xive_write_end;
>>      xrc->get_nvt = pnv_xive_get_nvt;
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index b8825577f719..894be4b49ba4 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -927,7 +927,7 @@ static void xive_source_notify(XiveSource *xsrc, int srcno)
>>      XiveNotifierClass *xnc = XIVE_NOTIFIER_GET_CLASS(xsrc->xive);
>>  
>>      if (xnc->notify) {
>> -        xnc->notify(xsrc->xive, srcno);
>> +        xnc->notify(xsrc->xive, srcno, true);
>>      }
>>  }
>>  
>> @@ -1343,6 +1343,24 @@ int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>>      return xrc->get_eas(xrtr, eas_blk, eas_idx, eas);
>>  }
>>  
>> +static
>> +int xive_router_get_pq(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>> +                       uint8_t *pq)
>> +{
>> +    XiveRouterClass *xrc = XIVE_ROUTER_GET_CLASS(xrtr);
>> +
>> +    return xrc->get_pq(xrtr, eas_blk, eas_idx, pq);
>> +}
>> +
>> +static
>> +int xive_router_set_pq(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>> +                       uint8_t *pq)
>> +{
>> +    XiveRouterClass *xrc = XIVE_ROUTER_GET_CLASS(xrtr);
>> +
>> +    return xrc->set_pq(xrtr, eas_blk, eas_idx, pq);
>> +}
>> +
> 
> Only the powernv machine implements the PQ bits hooks. I understand
> that pseries doesn't need them because it cannot execute the helpers
> above in practice, since xive_router_notify() is always called with
> pq_checked == true :
> 
> spapr_xive_set_irq()
>  xive_source_set_irq()
>   xive_source_notify()
>   {
>      xnc->notify(xsrc->xive, srcno, true);
>   }
> 
> IMHO the XIVE code is complex enough that we should maybe make
> this really explicit with a comment and assert(xrc->[sg]et_pq)
> in the PQ bits helpers.

I will simply implement the hooks for pseries. No big deal.

> 
>>  int xive_router_get_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
>>                          XiveEND *end)
>>  {
>> @@ -1686,7 +1704,7 @@ do_escalation:
>>                             xive_get_field32(END_W5_ESC_END_DATA,  end.w5));
>>  }
>>  
>> -void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
>> +void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
>>  {
>>      XiveRouter *xrtr = XIVE_ROUTER(xn);
>>      uint8_t eas_blk = XIVE_EAS_BLOCK(lisn);
>> @@ -1699,11 +1717,27 @@ void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
>>          return;
>>      }
>>  
>> -    /*
>> -     * The IVRE checks the State Bit Cache at this point. We skip the
>> -     * SBC lookup because the state bits of the sources are modeled
>> -     * internally in QEMU.
>> -     */
>> +    if (!pq_checked) {
>> +        bool notify;
>> +        uint8_t pq;
>> +
>> +        /* PQ cache lookup */
>> +        if (xive_router_get_pq(xrtr, eas_blk, eas_idx, &pq)) {
>> +            /* Set FIR */
>> +            g_assert_not_reached();
> 
> I'm not sure about the intent of this assert... Actual QEMU
> bug that should never happen ever 


It should never happen because the call above to xive_router_get_eas() would
have errored.

C.


> or guest misuse of XIVE
> that we might try to handle one day ?
> 
> In the former case, I'd rather assert() in the PQ bits
> machine hooks when the error condition is first detected.
> 
> Apart from that, rest looks good.
> 
>> +        }
>> +
>> +        notify = xive_esb_trigger(&pq);
>> +
>> +        if (xive_router_set_pq(xrtr, eas_blk, eas_idx, &pq)) {
>> +            /* Set FIR */
>> +            g_assert_not_reached();
>> +        }
>> +
>> +        if (!notify) {
>> +            return;
>> +        }
>> +    }
>>  
>>      if (!xive_eas_is_valid(&eas)) {
>>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lisn);
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index ac824f877cf1..c451819bfd52 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -1241,14 +1241,19 @@ static const char *pnv_phb4_root_bus_path(PCIHostState *host_bridge,
>>      return phb->bus_path;
>>  }
>>  
>> -static void pnv_phb4_xive_notify(XiveNotifier *xf, uint32_t srcno)
>> +static void pnv_phb4_xive_notify(XiveNotifier *xf, uint32_t srcno,
>> +                                 bool pq_checked)
>>  {
>>      PnvPHB4 *phb = PNV_PHB4(xf);
>>      uint64_t notif_port = phb->regs[PHB_INT_NOTIFY_ADDR >> 3];
>>      uint32_t offset = phb->regs[PHB_INT_NOTIFY_INDEX >> 3];
>> -    uint64_t data = XIVE_TRIGGER_PQ | offset | srcno;
>> +    uint64_t data = offset | srcno;
>>      MemTxResult result;
>>  
>> +    if (pq_checked) {
>> +        data |= XIVE_TRIGGER_PQ;
>> +    }
>> +
>>      address_space_stq_be(&address_space_memory, notif_port, data,
>>                           MEMTXATTRS_UNSPECIFIED, &result);
>>      if (result != MEMTX_OK) {
>> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
>> index c34a49b000f2..63804f28f45e 100644
>> --- a/hw/ppc/pnv_psi.c
>> +++ b/hw/ppc/pnv_psi.c
>> @@ -652,7 +652,7 @@ static const TypeInfo pnv_psi_power8_info = {
>>  #define   PSIHB9_IRQ_STAT_DIO           PPC_BIT(12)
>>  #define   PSIHB9_IRQ_STAT_PSU           PPC_BIT(13)
>>  
>> -static void pnv_psi_notify(XiveNotifier *xf, uint32_t srcno)
>> +static void pnv_psi_notify(XiveNotifier *xf, uint32_t srcno, bool pq_checked)
>>  {
>>      PnvPsi *psi = PNV_PSI(xf);
>>      uint64_t notif_port = psi->regs[PSIHB_REG(PSIHB9_ESB_NOTIF_ADDR)];
>> @@ -661,9 +661,13 @@ static void pnv_psi_notify(XiveNotifier *xf, uint32_t srcno)
>>  
>>      uint32_t offset =
>>          (psi->regs[PSIHB_REG(PSIHB9_IVT_OFFSET)] >> PSIHB9_IVT_OFF_SHIFT);
>> -    uint64_t data = XIVE_TRIGGER_PQ | offset | srcno;
>> +    uint64_t data = offset | srcno;
>>      MemTxResult result;
>>  
>> +    if (pq_checked) {
>> +        data |= XIVE_TRIGGER_PQ;
>> +    }
>> +
>>      if (!valid) {
>>          return;
>>      }
> 


