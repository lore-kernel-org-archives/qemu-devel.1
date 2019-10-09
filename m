Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7FCC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFACF20679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFACF20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHsp-0004NN-7f
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iIEKA-0004j4-BO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iIEK7-0005wf-QR
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:56:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26652
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iIEK7-0005wD-Li
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:56:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x99Fh2Yj142822
 for <qemu-devel@nongnu.org>; Wed, 9 Oct 2019 11:56:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vhhajbfhc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 11:56:21 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 9 Oct 2019 16:56:19 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Oct 2019 16:56:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x99FtitL36569538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2019 15:55:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 478164C052;
 Wed,  9 Oct 2019 15:56:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27A964C044;
 Wed,  9 Oct 2019 15:56:14 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Oct 2019 15:56:14 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-2-100.uk.ibm.com [9.145.2.100])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 4E2E5220121;
 Wed,  9 Oct 2019 17:56:13 +0200 (CEST)
Subject: Re: [PATCH v4 13/19] spapr, xics, xive: Move SpaprIrq::reset hook
 logic into activate/deactivate
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-14-david@gibson.dropbear.id.au>
 <20191009162534.4566b86b@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Wed, 9 Oct 2019 17:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009162534.4566b86b@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100915-0008-0000-0000-0000032087FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100915-0009-0000-0000-00004A3F8D8F
Message-Id: <76c7cbdd-f01e-b36e-8790-1129d216998a@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-09_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090144
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
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/2019 16:25, Greg Kurz wrote:
> On Wed,  9 Oct 2019 17:08:12 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> It turns out that all the logic in the SpaprIrq::reset hooks (and some in
>> the SpaprIrq::post_load hooks) isn't really related to resetting the irq
>> backend (that's handled by the backends' own reset routines).  Rather its
>> about getting the backend ready to be the active interrupt controller or
>> stopping being the active interrupt controller - reset (and post_load) is
>> just the only time that changes at present.
>>
>> To make this flow clearer, move the logic into the explicit backend
>> activate and deactivate hooks.
>>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/intc/spapr_xive.c       | 38 +++++++++++++++++++++
>>  hw/intc/xics_spapr.c       | 17 ++++++++++
>>  hw/ppc/spapr_irq.c         | 67 ++------------------------------------
>>  include/hw/ppc/spapr_irq.h |  4 ++-
>>  4 files changed, 61 insertions(+), 65 deletions(-)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 37ffb74ca5..1811653aac 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -640,6 +640,42 @@ static void spapr_xive_dt(SpaprInterruptController *intc, uint32_t nr_servers,
>>                       plat_res_int_priorities, sizeof(plat_res_int_priorities)));
>>  }
>>  
>> +static int spapr_xive_activate(SpaprInterruptController *intc, Error **errp)
>> +{
>> +    SpaprXive *xive = SPAPR_XIVE(intc);
>> +    CPUState *cs;
>> +
>> +    CPU_FOREACH(cs) {
>> +        PowerPCCPU *cpu = POWERPC_CPU(cs);
>> +
>> +        /* (TCG) Set the OS CAM line of the thread interrupt context. */
>> +        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
>> +    }
>> +
>> +    if (kvm_enabled()) {
>> +        int rc = spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp);
>> +        if (rc < 0) {
>> +            return rc;
>> +        }
>> +    }
>> +
>> +    /* Activate the XIVE MMIOs */
>> +    spapr_xive_mmio_set_enabled(xive, true);
>> +
>> +    return 0;
>> +}
>> +
>> +static void spapr_xive_deactivate(SpaprInterruptController *intc)
>> +{
>> +    SpaprXive *xive = SPAPR_XIVE(intc);
>> +
>> +    spapr_xive_mmio_set_enabled(xive, false);
>> +
>> +    if (kvm_irqchip_in_kernel()) {
>> +        kvmppc_xive_disconnect(intc);
>> +    }
>> +}
>> +
>>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -658,6 +694,8 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>>      xrc->write_nvt = spapr_xive_write_nvt;
>>      xrc->get_tctx = spapr_xive_get_tctx;
>>  
>> +    sicc->activate = spapr_xive_activate;
>> +    sicc->deactivate = spapr_xive_deactivate;
>>      sicc->cpu_intc_create = spapr_xive_cpu_intc_create;
>>      sicc->claim_irq = spapr_xive_claim_irq;
>>      sicc->free_irq = spapr_xive_free_irq;
>> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
>> index 4eabafc7e1..90b4d48877 100644
>> --- a/hw/intc/xics_spapr.c
>> +++ b/hw/intc/xics_spapr.c
>> @@ -395,6 +395,21 @@ static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
>>      ics_pic_print_info(ics, mon);
>>  }
>>  
>> +static int xics_spapr_activate(SpaprInterruptController *intc, Error **errp)
>> +{
>> +    if (kvm_enabled()) {
>> +        return spapr_irq_init_kvm(xics_kvm_connect, intc, errp);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void xics_spapr_deactivate(SpaprInterruptController *intc)
>> +{
>> +    if (kvm_irqchip_in_kernel()) {
>> +        xics_kvm_disconnect(intc);
>> +    }
>> +}
>> +
>>  static void ics_spapr_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -403,6 +418,8 @@ static void ics_spapr_class_init(ObjectClass *klass, void *data)
>>  
>>      device_class_set_parent_realize(dc, ics_spapr_realize,
>>                                      &isc->parent_realize);
>> +    sicc->activate = xics_spapr_activate;
>> +    sicc->deactivate = xics_spapr_deactivate;
>>      sicc->cpu_intc_create = xics_spapr_cpu_intc_create;
>>      sicc->claim_irq = xics_spapr_claim_irq;
>>      sicc->free_irq = xics_spapr_free_irq;
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 7cd18e5b15..f70b331f44 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -65,9 +65,9 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)
>>      bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
>>  }
>>  
>> -static int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
>> -                              SpaprInterruptController *intc,
>> -                              Error **errp)
>> +int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
>> +                       SpaprInterruptController *intc,
>> +                       Error **errp)
>>  {
>>      MachineState *machine = MACHINE(qdev_get_machine());
>>      Error *local_err = NULL;
>> @@ -112,11 +112,6 @@ static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int version_id)
>>      return 0;
>>  }
>>  
>> -static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
>> -{
>> -    spapr_irq_init_kvm(xics_kvm_connect, SPAPR_INTC(spapr->ics), errp);
>> -}
>> -
>>  SpaprIrq spapr_irq_xics = {
>>      .nr_xirqs    = SPAPR_NR_XIRQS,
>>      .nr_msis     = SPAPR_NR_MSIS,
>> @@ -124,7 +119,6 @@ SpaprIrq spapr_irq_xics = {
>>      .xive        = false,
>>  
>>      .post_load   = spapr_irq_post_load_xics,
>> -    .reset       = spapr_irq_reset_xics,
>>  };
>>  
>>  /*
>> @@ -136,26 +130,6 @@ static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int version_id)
>>      return spapr_xive_post_load(spapr->xive, version_id);
>>  }
>>  
>> -static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
>> -{
>> -    CPUState *cs;
>> -
>> -    CPU_FOREACH(cs) {
>> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
>> -
>> -        /* (TCG) Set the OS CAM line of the thread interrupt context. */
>> -        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
>> -    }
>> -
>> -    if (spapr_irq_init_kvm(kvmppc_xive_connect,
>> -                           SPAPR_INTC(spapr->xive), errp) < 0) {
>> -        return;
>> -    }
>> -
>> -    /* Activate the XIVE MMIOs */
>> -    spapr_xive_mmio_set_enabled(spapr->xive, true);
>> -}
>> -
>>  SpaprIrq spapr_irq_xive = {
>>      .nr_xirqs    = SPAPR_NR_XIRQS,
>>      .nr_msis     = SPAPR_NR_MSIS,
>> @@ -163,7 +137,6 @@ SpaprIrq spapr_irq_xive = {
>>      .xive        = true,
>>  
>>      .post_load   = spapr_irq_post_load_xive,
>> -    .reset       = spapr_irq_reset_xive,
>>  };
>>  
>>  /*
>> @@ -187,37 +160,9 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
>>  
>>  static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int version_id)
>>  {
>> -    /*
>> -     * Force a reset of the XIVE backend after migration. The machine
>> -     * defaults to XICS at startup.
>> -     */
>> -    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>> -        if (kvm_irqchip_in_kernel()) {
>> -            xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
>> -        }
>> -        spapr_irq_xive.reset(spapr, &error_fatal);
>> -    }
>> -
>>      return spapr_irq_current(spapr)->post_load(spapr, version_id);
>>  }
>>  
>> -static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **errp)
>> -{
>> -    /*
>> -     * Deactivate the XIVE MMIOs. The XIVE backend will reenable them
>> -     * if selected.
>> -     */
>> -    spapr_xive_mmio_set_enabled(spapr->xive, false);
>> -
>> -    /* Destroy all KVM devices */
>> -    if (kvm_irqchip_in_kernel()) {
>> -        xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
>> -        kvmppc_xive_disconnect(SPAPR_INTC(spapr->xive));
> 
> With this going away, we don't need to check the KVM device fd is valid in
> xics_kvm_disconnect() and spapr_xive_disconnect() anymore. Cool !

Yes. That was ugly-hacky. 

C. 

> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
>> -    }
>> -
>> -    spapr_irq_current(spapr)->reset(spapr, errp);
>> -}
>> -
>>  /*
>>   * Define values in sync with the XIVE and XICS backend
>>   */
>> @@ -228,7 +173,6 @@ SpaprIrq spapr_irq_dual = {
>>      .xive        = true,
>>  
>>      .post_load   = spapr_irq_post_load_dual,
>> -    .reset       = spapr_irq_reset_dual,
>>  };
>>  
>>  
>> @@ -512,10 +456,6 @@ void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
>>      assert(!spapr->irq_map || bitmap_empty(spapr->irq_map, spapr->irq_map_nr));
>>  
>>      spapr_irq_update_active_intc(spapr);
>> -
>> -    if (spapr->irq->reset) {
>> -        spapr->irq->reset(spapr, errp);
>> -    }
>>  }
>>  
>>  int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **errp)
>> @@ -651,7 +591,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>>      .xive        = false,
>>  
>>      .post_load   = spapr_irq_post_load_xics,
>> -    .reset       = spapr_irq_reset_xics,
>>  };
>>  
>>  static void spapr_irq_register_types(void)
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 06179b271f..e02e44624b 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -84,7 +84,6 @@ typedef struct SpaprIrq {
>>      bool        xive;
>>  
>>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>> -    void (*reset)(SpaprMachineState *spapr, Error **errp);
>>  } SpaprIrq;
>>  
>>  extern SpaprIrq spapr_irq_xics;
>> @@ -99,6 +98,9 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
>>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
>>  void spapr_irq_reset(SpaprMachineState *spapr, Error **errp);
>>  int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **errp);
>> +int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
>> +                       SpaprInterruptController *intc,
>> +                       Error **errp);
>>  
>>  /*
>>   * XICS legacy routines
> 


