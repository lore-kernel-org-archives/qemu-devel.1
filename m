Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECB2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D99920723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D99920723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdal2-00007b-Bf
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jdaii-0006vp-TP; Tue, 26 May 2020 10:38:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jdaid-0002S5-Kn; Tue, 26 May 2020 10:38:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04QEVtPS153926; Tue, 26 May 2020 10:38:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316ywmx36v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 10:38:11 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04QEaT0j185570;
 Tue, 26 May 2020 10:38:11 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316ywmx36c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 10:38:11 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04QEUs4q022696;
 Tue, 26 May 2020 14:38:10 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01dal.us.ibm.com with ESMTP id 316uf9wf99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 14:38:10 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04QEc9Dt31588728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 May 2020 14:38:09 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74A4E11207E;
 Tue, 26 May 2020 14:38:09 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31DCE11208A;
 Tue, 26 May 2020 14:38:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.161.126])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue, 26 May 2020 14:38:09 +0000 (GMT)
Subject: Re: [PATCH v2 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-7-walling@linux.ibm.com>
 <d72f56c0-fed0-12ea-dfa6-f3441952a30e@linux.ibm.com>
 <ae819a26-2436-ec4d-3476-1a1fdca07d4b@linux.ibm.com>
 <a530a9e4-86d7-8e86-5bd3-d2b033d5371f@linux.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <9f70e4ee-c565-2df2-f502-8cc2eb6765f2@linux.ibm.com>
Date: Tue, 26 May 2020 10:38:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a530a9e4-86d7-8e86-5bd3-d2b033d5371f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-26_02:2020-05-26,
 2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:38:12
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mst@redhat.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 6:50 AM, Janosch Frank wrote:
> On 5/18/20 4:31 PM, Collin Walling wrote:
>> On 5/18/20 4:55 AM, Janosch Frank wrote:
>>> On 5/16/20 12:20 AM, Collin Walling wrote:
>>>> As more features and facilities are added to the Read SCP Info (RSCPI)
>>>> response, more space is required to store them. The space used to store
>>>> these new features intrudes on the space originally used to store CPU
>>>> entries. This means as more features and facilities are added to the
>>>> RSCPI response, less space can be used to store CPU entries.
>>>>
>>>> With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
>>>> the RSCPI command and determine if the SCCB is large enough to store a
>>>> complete reponse. If it is not large enough, then the required length
>>>> will be set in the SCCB header.
>>>>
>>>> The caller of the SCLP command is responsible for creating a
>>>> large-enough SCCB to store a complete response. Proper checking should
>>>> be in place, and the caller should execute the command once-more with
>>>> the large-enough SCCB.
>>>>
>>>> This facility also enables an extended SCCB for the Read CPU Info
>>>> (RCPUI) command.
>>>>
>>>> When this facility is enabled, the boundary violation response cannot
>>>> be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
>>>>
>>>> In order to tolerate kernels that do not yet have full support for this
>>>> feature, a "fixed" offset to the start of the CPU Entries within the
>>>> Read SCP Info struct is set to allow for the original 248 max entries
>>>> when this feature is disabled.
>>>>
>>>> Additionally, this is introduced as a CPU feature to protect the guest
>>>> from migrating to a machine that does not support storing an extended
>>>> SCCB. This could otherwise hinder the VM from being able to read all
>>>> available CPU entries after migration (such as during re-ipl).
>>>>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>  hw/s390x/sclp.c                     | 21 ++++++++++++++++++++-
>>>>  include/hw/s390x/sclp.h             |  1 +
>>>>  target/s390x/cpu_features_def.inc.h |  1 +
>>>>  target/s390x/gen-features.c         |  1 +
>>>>  target/s390x/kvm.c                  |  4 ++++
>>>>  5 files changed, 27 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>>> index 755f5f3fab..bde4c5420e 100644
>>>> --- a/hw/s390x/sclp.c
>>>> +++ b/hw/s390x/sclp.c
>>>> @@ -56,6 +56,18 @@ static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
>>>>      uint64_t allowed_len = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
>>>>  
>>>>      switch (code & SCLP_CMD_CODE_MASK) {
>>>> +    case SCLP_CMDW_READ_SCP_INFO:
>>>> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
>>>> +    case SCLP_CMDW_READ_CPU_INFO:
>>>> +        /*
>>>> +         * An extended-length SCCB is only allowed for RSCPI and RSCPU and is
>>>> +         * allowed to exceed the 4k boundary. The respective commands will
>>>> +         * set the length field to the required length if an insufficient
>>>> +         * SCCB length is provided.
>>>> +         */
>>>> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
>>>> +            return true;
>>>> +        }
>>>>      default:
>>>>          if (current_len <= allowed_len) {
>>>>              return true;
>>>> @@ -72,6 +84,10 @@ static bool sccb_has_sufficient_len(SCCB *sccb, int num_cpus, int data_len)
>>>>  
>>>>      if (be16_to_cpu(sccb->h.length) < required_len) {
>>>>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>>>> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) &&
>>>> +            sccb->h.control_mask[2] & SCLP_VARIABLE_LENGTH_RESPONSE) {
>>>> +            sccb->h.length = required_len;
>>>> +        }
>>>>          return false;
>>>>      }
>>>>      return true;
>>>> @@ -101,7 +117,9 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>>>>   */
>>>>  static int get_read_scp_info_data_len(void)
>>>>  {
>>>> -    return offsetof(ReadInfo, entries);
>>>> +    return s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
>>>> +           offsetof(ReadInfo, entries) :
>>>> +           SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET;
>>>>  }
>>>>  
>>>>  /* Provide information about the configuration, CPUs and storage */
>>>> @@ -116,6 +134,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>>>      CPUEntry *entries_start = (void *)sccb + data_len;
>>>>  
>>>>      if (!sccb_has_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
>>>> +        warn_report("insufficient sccb size to store full read scp info response");
>>>>          return;
>>>>      }
>>>>  
>>>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>>>> index 822eff4396..ef2d63eae9 100644
>>>> --- a/include/hw/s390x/sclp.h
>>>> +++ b/include/hw/s390x/sclp.h
>>>> @@ -110,6 +110,7 @@ typedef struct CPUEntry {
>>>>      uint8_t reserved1;
>>>>  } QEMU_PACKED CPUEntry;
>>>>  
>>>> +#define SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET     128
>>>>  typedef struct ReadInfo {
>>>>      SCCBHeader h;
>>>>      uint16_t rnmax;
>>>> diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
>>>> index 60db28351d..3548d65a69 100644
>>>> --- a/target/s390x/cpu_features_def.inc.h
>>>> +++ b/target/s390x/cpu_features_def.inc.h
>>>> @@ -97,6 +97,7 @@ DEF_FEAT(GUARDED_STORAGE, "gs", STFL, 133, "Guarded-storage facility")
>>>>  DEF_FEAT(VECTOR_PACKED_DECIMAL, "vxpd", STFL, 134, "Vector packed decimal facility")
>>>>  DEF_FEAT(VECTOR_ENH, "vxeh", STFL, 135, "Vector enhancements facility")
>>>>  DEF_FEAT(MULTIPLE_EPOCH, "mepoch", STFL, 139, "Multiple-epoch facility")
>>>> +DEF_FEAT(EXTENDED_LENGTH_SCCB, "els", STFL, 140, "Extended-length SCCB facility")
>>>>  DEF_FEAT(TEST_PENDING_EXT_INTERRUPTION, "tpei", STFL, 144, "Test-pending-external-interruption facility")
>>>>  DEF_FEAT(INSERT_REFERENCE_BITS_MULT, "irbm", STFL, 145, "Insert-reference-bits-multiple facility")
>>>>  DEF_FEAT(MSA_EXT_8, "msa8-base", STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)")
>>>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>>>> index 8ddeebc544..6857f657fb 100644
>>>> --- a/target/s390x/gen-features.c
>>>> +++ b/target/s390x/gen-features.c
>>>> @@ -522,6 +522,7 @@ static uint16_t full_GEN12_GA1[] = {
>>>>      S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
>>>>      S390_FEAT_AP_FACILITIES_TEST,
>>>>      S390_FEAT_AP,
>>>> +    S390_FEAT_EXTENDED_LENGTH_SCCB,
>>>>  };
>>>>  
>>>>  static uint16_t full_GEN12_GA2[] = {
>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>> index 69881a0da0..380fb81822 100644
>>>> --- a/target/s390x/kvm.c
>>>> +++ b/target/s390x/kvm.c
>>>> @@ -2456,6 +2456,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>>>          KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
>>>>          set_bit(S390_FEAT_AP, model->features);
>>>>      }
>>>> +
>>>> +    /* Extended-Length SCCB is handled entirely within QEMU */
>>>> +    set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
>>>> +
>>>
>>> We need to fence this for secure guests as the SIDA is only 4k at the
>>> moment.
>>>
>>
>> I don't know much about the SE stuff, so I'll take your word for it.
>> Should this follow the same fencing as diag 318 and simply check for pv
>> mode?
> 
> So I had another look into it and I take everything back I said:
> * The stfle bit is controlled by the UV, so it's not indicated to the
> guest in PV mode
> * If the guest tries to execute a long SCCB the UV will return a
> boundary violation error on its own (well after a notification exit anyway).
> 
> Let's therefore throw in a comment:
> For PV guests this is completely fenced by the Ultravisor as Service
> Call error checking and STFLE interpretation are handled by SIE.
> 
> 

Very cool. This is a much easier approach. Thanks for looking into it!

>>
>>> Do we need to take extra steps for migration safety?
>>> I guess this is only available with host-passthrough or -model?
>>>
>>>>      /* strip of features that are not part of the maximum model */
>>>>      bitmap_and(model->features, model->features, model->def->full_feat,
>>>>                 S390_FEAT_MAX);
>>>>
>>>
>>>
>>
>>
> 
> 


-- 
Regards,
Collin

Stay safe and stay healthy

