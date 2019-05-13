Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41861C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0264520879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0264520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ3kt-0002xl-Gd
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 01:44:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hQ3jv-0002ZG-Ic
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hQ3hm-0004mD-5b
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:40:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hQ3hk-0004kk-DF; Mon, 13 May 2019 01:40:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4D5cPrq040934; Mon, 13 May 2019 01:40:34 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
	[169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sf2cmghbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Mon, 13 May 2019 01:40:34 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x4CNc5nE009401; Sun, 12 May 2019 23:44:52 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
	(b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma01dal.us.ibm.com with ESMTP id 2sdp14c06b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Sun, 12 May 2019 23:44:52 +0000
Received: from b03ledav001.gho.boulder.ibm.com
	(b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4D5eWng9961946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 13 May 2019 05:40:32 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 047D26E05B;
	Mon, 13 May 2019 05:40:32 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15D066E052;
	Mon, 13 May 2019 05:40:29 +0000 (GMT)
Received: from [9.124.31.31] (unknown [9.124.31.31])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 13 May 2019 05:40:29 +0000 (GMT)
To: Greg Kurz <groug@kaod.org>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591659639.20338.6078212293519133016.stgit@aravinda>
	<20190510182541.1c2e81ac@bahia.lab.toulouse-stg.fr.ibm.com>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <2faeefbb-2628-060f-9bd7-996e1f6a1af6@linux.vnet.ibm.com>
Date: Mon, 13 May 2019 11:10:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190510182541.1c2e81ac@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-13_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905130041
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 3/6] target/ppc: Handle NMI
 guest exit
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Friday 10 May 2019 09:55 PM, Greg Kurz wrote:
> On Mon, 22 Apr 2019 12:33:16 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 
>> Memory error such as bit flips that cannot be corrected
>> by hardware are passed on to the kernel for handling.
>> If the memory address in error belongs to guest then
>> the guest kernel is responsible for taking suitable action.
>> Patch [1] enhances KVM to exit guest with exit reason
>> set to KVM_EXIT_NMI in such cases. This patch handles
>> KVM_EXIT_NMI exit.
>>
>> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
>>     (e20bbd3d and related commits)
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr.c          |    3 +++
>>  hw/ppc/spapr_events.c   |   22 ++++++++++++++++++++++
>>  hw/ppc/spapr_rtas.c     |    5 +++++
>>  include/hw/ppc/spapr.h  |    6 ++++++
>>  target/ppc/kvm.c        |   16 ++++++++++++++++
>>  target/ppc/kvm_ppc.h    |    2 ++
>>  target/ppc/trace-events |    2 ++
>>  7 files changed, 56 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 6642cb5..2779efe 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1806,6 +1806,7 @@ static void spapr_machine_reset(void)
>>  
>>      spapr->cas_reboot = false;
>>  
>> +    spapr->mc_status = -1;
>>      spapr->guest_machine_check_addr = -1;
>>  
>>      /* Signal all vCPUs waiting on this condition */
>> @@ -2106,6 +2107,7 @@ static const VMStateDescription vmstate_spapr_machine_check = {
>>      .minimum_version_id = 1,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
>> +        VMSTATE_INT32(mc_status, SpaprMachineState),
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
>> @@ -3085,6 +3087,7 @@ static void spapr_machine_init(MachineState *machine)
>>          kvmppc_spapr_enable_inkernel_multitce();
>>      }
>>  
>> +    spapr->mc_status = -1;
> 
> Since this is done at reset, do we need it here ?

Yes, because we need to initialize this on a fresh boot. I need to
check, but if spapr_machine_reset() is called every time a system boots
then we don't need qemu_cond_init() here as well.

> 
>>      qemu_cond_init(&spapr->mc_delivery_cond);
>>  }
>>  
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index ae0f093..9922a23 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -620,6 +620,28 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>>  }
>>  
>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +
>> +    while (spapr->mc_status != -1) {
>> +        /*
>> +         * Check whether the same CPU got machine check error
>> +         * while still handling the mc error (i.e., before
>> +         * that CPU called "ibm,nmi-interlock"
> 
> Missing )

ok.

> 
>> +         */
>> +        if (spapr->mc_status == cpu->vcpu_id) {
>> +            qemu_system_guest_panicked(NULL);
> 
> If we don't also return, is there a chance we end up stuck in
> qemu_cond_wait_iothread() below ?

I think I need to return here


> 
>> +        }
>> +        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
>> +        /* Meanwhile if the system is reset, then just return */
>> +        if (spapr->guest_machine_check_addr == -1) {
>> +            return;
>> +        }
>> +    }
>> +    spapr->mc_status = cpu->vcpu_id;
>> +}
>> +
>>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>                              uint32_t token, uint32_t nargs,
>>                              target_ulong args,
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index c2f3991..d3499f9 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -375,6 +375,11 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>          /* NMI register not called */
>>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>      } else {
>> +        /*
>> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
>> +         * hence unset mc_status.
>> +         */
>> +        spapr->mc_status = -1;
>>          qemu_cond_signal(&spapr->mc_delivery_cond);
>>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>      }
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index ec6f33e..f7204d0 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -189,6 +189,11 @@ struct SpaprMachineState {
>>  
>>      /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
>>      target_ulong guest_machine_check_addr;
>> +    /*
>> +     * mc_status is set to -1 if mc is not in progress, else is set to the CPU
>> +     * handling the mc.
>> +     */
>> +    int mc_status;
>>      QemuCond mc_delivery_cond;
>>  
>>      /*< public >*/
>> @@ -792,6 +797,7 @@ void spapr_clear_pending_events(SpaprMachineState *spapr);
>>  int spapr_max_server_number(SpaprMachineState *spapr);
>>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>>                        uint64_t pte0, uint64_t pte1);
>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
>>  
>>  /* DRC callbacks. */
>>  void spapr_core_release(DeviceState *dev);
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 9e86db0..5eedce8 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -1759,6 +1759,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>>          ret = 0;
>>          break;
>>  
>> +    case KVM_EXIT_NMI:
>> +        trace_kvm_handle_nmi_exception();
>> +        ret = kvm_handle_nmi(cpu, run);
>> +        break;
>> +
>>      default:
>>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
>>          ret = -1;
>> @@ -2837,6 +2842,17 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>>      return data & 0xffff;
>>  }
>>  
>> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
>> +{
>> +    bool recovered = run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
>> +
>> +    cpu_synchronize_state(CPU(cpu));
>> +
>> +    spapr_mce_req_event(cpu, recovered);
>> +
>> +    return 0;
>> +}
>> +
>>  int kvmppc_enable_hwrng(void)
>>  {
>>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HWRNG)) {
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index 2238513..6edc42f 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -80,6 +80,8 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void);
>>  void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
>>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
>>  
>> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
>> +
>>  #else
>>  
>>  static inline uint32_t kvmppc_get_tbfreq(void)
>> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
>> index 7b3cfe1..d5691d2 100644
>> --- a/target/ppc/trace-events
>> +++ b/target/ppc/trace-events
>> @@ -28,3 +28,5 @@ kvm_handle_papr_hcall(void) "handle PAPR hypercall"
>>  kvm_handle_epr(void) "handle epr"
>>  kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
>>  kvm_handle_debug_exception(void) "handle debug exception"
>> +kvm_handle_nmi_exception(void) "handle NMI exception"
>> +
> 
> new blank line at EOF.

ok

> 
>>
>>
> 
> 

-- 
Regards,
Aravinda

