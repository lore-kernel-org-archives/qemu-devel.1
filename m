Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A959C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE0C206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE0C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiDCU-0003L2-3C
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33061)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hiCDn-0002kl-68
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hiCDk-0003Fq-Sq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:24:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hiCDd-0003Dm-5K; Tue, 02 Jul 2019 02:24:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x626Gerg027710; Tue, 2 Jul 2019 02:24:33 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tg12kj1h4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jul 2019 02:24:33 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x626JhlQ023680;
 Tue, 2 Jul 2019 06:24:32 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 2tdym6m4v3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jul 2019 06:24:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x626OV5N53936626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jul 2019 06:24:31 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C18178063;
 Tue,  2 Jul 2019 06:24:31 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B98B7805C;
 Tue,  2 Jul 2019 06:24:28 +0000 (GMT)
Received: from [9.102.27.232] (unknown [9.102.27.232])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  2 Jul 2019 06:24:27 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033126489.26635.3005245220857933178.stgit@aravinda>
 <20190702035105.GG6779@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <fa2b5983-7cad-9679-489f-c273bd8216fb@linux.vnet.ibm.com>
Date: Tue, 2 Jul 2019 11:54:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190702035105.GG6779@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-02_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020072
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v10 2/6] ppc: spapr: Introduce FWNMI
 capability
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tuesday 02 July 2019 09:21 AM, David Gibson wrote:
> On Wed, Jun 12, 2019 at 02:51:04PM +0530, Aravinda Prasad wrote:
>> Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
>> the KVM causes guest exit with NMI as exit reason
>> when it encounters a machine check exception on the
>> address belonging to a guest. Without this capability
>> enabled, KVM redirects machine check exceptions to
>> guest's 0x200 vector.
>>
>> This patch also introduces fwnmi-mce capability to
>> deal with the case when a guest with the
>> KVM_CAP_PPC_FWNMI capability enabled is attempted
>> to migrate to a host that does not support this
>> capability.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr.c         |    1 +
>>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |    4 +++-
>>  target/ppc/kvm.c       |   19 +++++++++++++++++++
>>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
>>  5 files changed, 61 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 6dd8aaa..2ef86aa 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4360,6 +4360,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>>      spapr_caps_add_properties(smc, &error_abort);
>>      smc->irq = &spapr_irq_dual;
>>      smc->dr_phb_enabled = true;
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index 31b4661..2e92eb6 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -479,6 +479,22 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>>      }
>>  }
>>  
>> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
>> +                                Error **errp)
>> +{
>> +    if (!val) {
>> +        return; /* Disabled by default */
>> +    }
>> +
>> +    if (tcg_enabled()) {
>> +        error_setg(errp,
>> +"No Firmware Assisted Non-Maskable Interrupts support in TCG, try cap-fwnmi-mce=off");
> 
> Not allowing this for TCG creates an awkward incompatibility between
> KVM and TCG guests.  I can't actually see any reason to ban it for TCG
> - with the current code TCG won't ever generate NMIs, but I don't see
> that anything will actually break.
> 
> In fact, we do have an nmi monitor command, currently wired to the
> spapr_nmi() function which resets each cpu, but it probably makes
> sense to wire it up to the fwnmi stuff when present.

Yes, but that nmi support is not enough to inject a synchronous error
into the guest kernel. For example, we should provide the faulty address
along with other information such as the type of error (slb multi-hit,
memory error, TLB multi-hit) and when the error occurred (load/store)
and whether the error was completely recovered or not. Without such
information we cannot build the error log and pass it on to the guest
kernel. Right now nmi monitor command takes cpu number as the only argument.

So I think TCG support should be a separate patch by itself.

Regards,
Aravinda

> 
>> +    } else if (kvm_enabled() && !kvmppc_has_cap_ppc_fwnmi()) {
>> +        error_setg(errp,
>> +"Firmware Assisted Non-Maskable Interrupts not supported by KVM, try cap-fwnmi-mce=off");
>> +    }
>> +}
>> +
>>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>      [SPAPR_CAP_HTM] = {
>>          .name = "htm",
>> @@ -578,6 +594,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>          .type = "bool",
>>          .apply = cap_ccf_assist_apply,
>>      },
>> +    [SPAPR_CAP_FWNMI_MCE] = {
>> +        .name = "fwnmi-mce",
>> +        .description = "Handle fwnmi machine check exceptions",
>> +        .index = SPAPR_CAP_FWNMI_MCE,
>> +        .get = spapr_cap_get_bool,
>> +        .set = spapr_cap_set_bool,
>> +        .type = "bool",
>> +        .apply = cap_fwnmi_mce_apply,
>> +    },
>>  };
>>  
>>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
>> @@ -717,6 +742,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
>>  
>>  void spapr_caps_init(SpaprMachineState *spapr)
>>  {
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 4f5becf..f891f8f 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -78,8 +78,10 @@ typedef enum {
>>  #define SPAPR_CAP_LARGE_DECREMENTER     0x08
>>  /* Count Cache Flush Assist HW Instruction */
>>  #define SPAPR_CAP_CCF_ASSIST            0x09
>> +/* FWNMI machine check handling */
>> +#define SPAPR_CAP_FWNMI_MCE             0x0A
>>  /* Num Caps */
>> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
>> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
>>  
>>  /*
>>   * Capability Values
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 3bf0a46..afef4cd 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -84,6 +84,7 @@ static int cap_ppc_safe_indirect_branch;
>>  static int cap_ppc_count_cache_flush_assist;
>>  static int cap_ppc_nested_kvm_hv;
>>  static int cap_large_decr;
>> +static int cap_ppc_fwnmi;
>>  
>>  static uint32_t debug_inst_opcode;
>>  
>> @@ -152,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      kvmppc_get_cpu_characteristics(s);
>>      cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
>>      cap_large_decr = kvmppc_get_dec_bits();
>> +    cap_ppc_fwnmi = kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
>>      /*
>>       * Note: setting it to false because there is not such capability
>>       * in KVM at this moment.
>> @@ -2114,6 +2116,18 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>>      }
>>  }
>>  
>> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
>> +{
>> +    CPUState *cs = CPU(cpu);
>> +
>> +    if (!cap_ppc_fwnmi) {
>> +        return 1;
>> +    }
>> +
>> +    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
>> +}
>> +
>> +
>>  int kvmppc_smt_threads(void)
>>  {
>>      return cap_ppc_smt ? cap_ppc_smt : 1;
>> @@ -2414,6 +2428,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>>      return cap_mmu_hash_v3;
>>  }
>>  
>> +bool kvmppc_has_cap_ppc_fwnmi(void)
>> +{
>> +    return cap_ppc_fwnmi;
>> +}
>> +
>>  static bool kvmppc_power8_host(void)
>>  {
>>      bool ret = false;
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index 45776ca..880cee9 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -27,6 +27,8 @@ void kvmppc_enable_h_page_init(void);
>>  void kvmppc_set_papr(PowerPCCPU *cpu);
>>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu);
>> +bool kvmppc_has_cap_ppc_fwnmi(void);
>>  int kvmppc_smt_threads(void);
>>  void kvmppc_hint_smt_possible(Error **errp);
>>  int kvmppc_set_smt_threads(int smt);
>> @@ -158,6 +160,16 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>>  {
>>  }
>>  
>> +static inline int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
>> +{
>> +    return 1;
>> +}
>> +
>> +static inline bool kvmppc_has_cap_ppc_fwnmi(void)
>> +{
>> +    return false;
>> +}
>> +
>>  static inline int kvmppc_smt_threads(void)
>>  {
>>      return 1;
>>
> 

-- 
Regards,
Aravinda

