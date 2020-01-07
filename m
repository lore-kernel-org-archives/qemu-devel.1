Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C12C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DC12072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DC12072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioof8-0005tC-EO
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1ion5b-0002wI-JD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1ion5Z-0002rO-U9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:31:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13102
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1ion5Z-0002qx-Ox
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:31:57 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 007BVtbZ124846
 for <qemu-devel@nongnu.org>; Tue, 7 Jan 2020 06:31:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xb97cnabc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:31:57 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Tue, 7 Jan 2020 11:31:55 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 7 Jan 2020 11:31:50 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 007BVnJ358654792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2020 11:31:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3720A4057;
 Tue,  7 Jan 2020 11:31:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C5D8A404D;
 Tue,  7 Jan 2020 11:31:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.97])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2020 11:31:48 +0000 (GMT)
Subject: Re: [PATCH v18 2/7] ppc: spapr: Introduce FWNMI capability
To: Greg Kurz <groug@kaod.org>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
 <20200102075111.25308-3-ganeshgr@linux.ibm.com>
 <20200106100721.70d40d27@bahia.lan>
From: Ganesh <ganeshgr@linux.ibm.com>
Date: Tue, 7 Jan 2020 17:01:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20200106100721.70d40d27@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20010711-0008-0000-0000-000003472A50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010711-0009-0000-0000-00004A676B51
Message-Id: <525de7cf-9a2a-2b98-eb37-39b474a49c6c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=981 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001070095
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/6/20 2:37 PM, Greg Kurz wrote:
> On Thu,  2 Jan 2020 13:21:06 +0530
> Ganesh Goudar <ganeshgr@linux.ibm.com> wrote:
>
>> From: Aravinda Prasad <arawinda.p@gmail.com>
>>
>> Introduce fwnmi an spapr capability and validate it against
>> the kernels existing capability by trying to enable it.
> I see this patch indeed adds a KVM helper to do that but it isn't
> called before some later patch in this series. Please update the
> changelog to make it clear this is just a preparatory patch that
> doesn't change any existing behavior.
Ok, ill update the commit message
>
>> [eliminate cap_ppc_fwnmi, add fwnmi cap to migration state
>>   and reprhase the commit message]
>> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> Personal changes and S-o-b are usually appended to the existing
> ones...
>
>> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> ... i.e. here.
ok
>
>> ---
>>   hw/ppc/spapr.c         |  2 ++
>>   hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
>>   include/hw/ppc/spapr.h |  5 ++++-
>>   target/ppc/kvm.c       |  8 ++++++++
>>   target/ppc/kvm_ppc.h   |  6 ++++++
>>   5 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index f11422fc41..c91e64aad0 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1994,6 +1994,7 @@ static const VMStateDescription vmstate_spapr = {
>>           &vmstate_spapr_dtb,
>>           &vmstate_spapr_cap_large_decr,
>>           &vmstate_spapr_cap_ccf_assist,
>> +        &vmstate_spapr_cap_fwnmi,
>>           NULL
>>       }
>>   };
>> @@ -4400,6 +4401,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>       smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>       smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>       smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>>       spapr_caps_add_properties(smc, &error_abort);
>>       smc->irq = &spapr_irq_dual;
>>       smc->dr_phb_enabled = true;
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index 481dfd2a27..3001098601 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -496,6 +496,14 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>>       }
>>   }
>>   
>> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
>> +                                Error **errp)
>> +{
>> +    if (!val) {
>> +        return; /* Disabled by default */
>> +    }
>> +}
>> +
>>   SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>       [SPAPR_CAP_HTM] = {
>>           .name = "htm",
>> @@ -595,6 +603,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>           .type = "bool",
>>           .apply = cap_ccf_assist_apply,
>>       },
>> +    [SPAPR_CAP_FWNMI_MCE] = {
>> +        .name = "fwnmi-mce",
>> +        .description = "Handle fwnmi machine check exceptions",
>> +        .index = SPAPR_CAP_FWNMI_MCE,
>> +        .get = spapr_cap_get_bool,
>> +        .set = spapr_cap_set_bool,
>> +        .type = "bool",
>> +        .apply = cap_fwnmi_mce_apply,
>> +    },
>>   };
>>   
>>   static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
>> @@ -734,6 +751,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>>   SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>>   SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>   SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
>>   
>>   void spapr_caps_init(SpaprMachineState *spapr)
>>   {
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 61f005c6f6..7bc5fc3a9e 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -79,8 +79,10 @@ typedef enum {
>>   #define SPAPR_CAP_LARGE_DECREMENTER     0x08
>>   /* Count Cache Flush Assist HW Instruction */
>>   #define SPAPR_CAP_CCF_ASSIST            0x09
>> +/* FWNMI machine check handling */
>> +#define SPAPR_CAP_FWNMI_MCE             0x0A
>>   /* Num Caps */
>> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
>> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
>>   
>>   /*
>>    * Capability Values
>> @@ -869,6 +871,7 @@ extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>>   extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>>   extern const VMStateDescription vmstate_spapr_cap_large_decr;
>>   extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>> +extern const VMStateDescription vmstate_spapr_cap_fwnmi;
>>   
>>   static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
>>   {
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index d1c334f0e3..518de7e4b7 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -2060,6 +2060,14 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>>       }
>>   }
>>   
>> +int kvmppc_set_fwnmi(void)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>> +    CPUState *cs = CPU(cpu);
>> +
>> +    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
>> +}
>> +
>>   int kvmppc_smt_threads(void)
>>   {
>>       return cap_ppc_smt ? cap_ppc_smt : 1;
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index f22daabf51..eedb15d48e 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
>>   void kvmppc_set_papr(PowerPCCPU *cpu);
>>   int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>>   void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>> +int kvmppc_set_fwnmi(void);
>>   int kvmppc_smt_threads(void);
>>   void kvmppc_error_append_smt_possible_hint(Error *const *errp);
>>   int kvmppc_set_smt_threads(int smt);
>> @@ -159,6 +160,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>>   {
>>   }
>>   
>> +static inline int kvmppc_set_fwnmi(void)
>> +{
>> +    return -1;
>> +}
>> +
>>   static inline int kvmppc_smt_threads(void)
>>   {
>>       return 1;


