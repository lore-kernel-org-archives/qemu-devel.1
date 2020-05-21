Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6BBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 06:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2EA207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 06:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2EA207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbeYj-0005z5-1F
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 02:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jbeYA-0005Yl-Lm; Thu, 21 May 2020 02:19:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21196
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jbeY9-0007cQ-EU; Thu, 21 May 2020 02:19:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04L62CEi098183; Thu, 21 May 2020 02:19:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 314ua55w3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2020 02:19:22 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04L65PHQ108417;
 Thu, 21 May 2020 02:19:22 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 314ua55w36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2020 02:19:22 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04L6EoTK012751;
 Thu, 21 May 2020 06:19:21 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04dal.us.ibm.com with ESMTP id 314wxp6s6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2020 06:19:21 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04L6IKJ314287482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2020 06:18:20 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AF3DAC05B;
 Thu, 21 May 2020 06:18:20 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AD5EAC062;
 Thu, 21 May 2020 06:18:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.205.15])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 21 May 2020 06:18:20 +0000 (GMT)
Subject: Re: [PATCH v2 8/8] s390: guest support for diagnose 0x318
To: Cornelia Huck <cohuck@redhat.com>
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-9-walling@linux.ibm.com>
 <20200520133012.1ad60b71.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <950fc1b2-ef0b-d7d5-37c1-dc9a6974e9a0@linux.ibm.com>
Date: Thu, 21 May 2020 02:18:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520133012.1ad60b71.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-21_02:2020-05-20,
 2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 cotscore=-2147483648 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005210035
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 02:19:23
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:30 AM, Cornelia Huck wrote:
> On Fri, 15 May 2020 18:20:32 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> DIAGNOSE 0x318 (diag 318) allows the storage of diagnostic data that
>> is collected by the firmware in the case of hardware/firmware service
>> events.
>>
>> The instruction is invoked in the Linux kernel and is handled,
>> migrated, and reset (modified clear and load normal) by QEMU.
>> KVM assists with the get/set of the relevent data via IOCTLs.
>>
>> This feature depends on the Extended-Length SCCB (els) feature. If
>> els is not present, then a warning will be printed and the SCLP bit
>> that allows the Linux kernel to execute the instruction will not be
>> set.
>>
>> Availability of this instruction is determined by byte 134 (aka fac134)
>> bit 0 of the SCLP Read Info block. This coincidentally expands into the
>> space used for CPU entries, which means VMs running with the diag 318
>> capability may not be able to read information regarding all CPUs
>> unless the guest kernel supports an extended-length SCCB.
>>
>> This feature is not supported in protected virtualization mode.
> 
> I think it should be easy enough to wire it up for !kvm as well
> (although I'm not sure how useful it would be there -- mostly for
> seeing what a guest does with it, I guess.)
> 

I suppose we could. I'm working with the sync_regs idea that was
mentioned, and if it works the way I think it does, a lot the code on
the QEMU side will be disappearing.

Otherwise, I'll look into this. It should be rather harmless if QEMU
holds onto the data, but doesn't do anything with it.

>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c          | 45 +++++++++++++++++++++++++++++
>>  hw/s390x/sclp.c                     |  5 ++++
>>  include/hw/s390x/s390-virtio-ccw.h  |  1 +
>>  include/hw/s390x/sclp.h             |  3 ++
>>  target/s390x/cpu.c                  | 23 +++++++++++++++
>>  target/s390x/cpu.h                  |  4 +++
>>  target/s390x/cpu_features.h         |  1 +
>>  target/s390x/cpu_features_def.inc.h |  3 ++
>>  target/s390x/cpu_models.c           |  1 +
>>  target/s390x/gen-features.c         |  1 +
>>  target/s390x/kvm-stub.c             | 10 +++++++
>>  target/s390x/kvm.c                  | 40 +++++++++++++++++++++++++
>>  target/s390x/kvm_s390x.h            |  2 ++
>>  13 files changed, 139 insertions(+)
>>
> 
> (...)
> 
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index f2ccf0a06a..367a54c173 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -446,6 +446,29 @@ void s390_enable_css_support(S390CPU *cpu)
>>          kvm_s390_enable_css_support(cpu);
>>      }
>>  }
>> +
>> +void s390_get_diag_318_info(uint64_t *info)
>> +{
>> +    if (kvm_enabled()) {
>> +        kvm_s390_get_diag_318_info(info);
>> +    }
>> +}
>> +
>> +void s390_set_diag_318_info(uint64_t info)
>> +{
>> +    if (kvm_enabled()) {
>> +        kvm_s390_set_diag_318_info(info);
>> +    }
>> +}
>> +
>> +bool s390_diag_318_is_allowed(void)
>> +{
>> +    if (kvm_enabled()) {
> 
> I would recommend not tying this explicitly to kvm -- assuming that the
> feature checks should be enough.
> 

True. If I understand how the sync_regs approach works, then vmstate
stuff should be going away, and the reset code will also be handled in KVM.

Otherwise, I'll make the change.

>> +        return s390_has_feat(S390_FEAT_DIAG_318) &&
>> +               s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB);
>> +    }
>> +    return false;
>> +}
>>  #endif
>>  
>>  static gchar *s390_gdb_arch_name(CPUState *cs)
> 
> (...)
> 
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 380fb81822..5d7dc60c85 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -105,6 +105,7 @@
>>  
>>  #define DIAG_TIMEREVENT                 0x288
>>  #define DIAG_IPL                        0x308
>> +#define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
>>  #define DIAG_KVM_HYPERCALL              0x500
>>  #define DIAG_KVM_BREAKPOINT             0x501
>>  
>> @@ -814,6 +815,28 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
>>      return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>>  }
>>  
>> +int kvm_s390_get_diag_318_info(uint64_t *info)
>> +{
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_S390_VM_MISC,
>> +        .attr = KVM_S390_VM_MISC_DIAG_318,
>> +        .addr = (uint64_t)info,
>> +    };
>> +
>> +    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
>> +}
>> +
>> +int kvm_s390_set_diag_318_info(uint64_t info)
>> +{
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_S390_VM_MISC,
>> +        .attr = KVM_S390_VM_MISC_DIAG_318,
>> +        .addr = (uint64_t)&info,
>> +    };
>> +
>> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>> +}
>> +
>>  /**
>>   * kvm_s390_mem_op:
>>   * @addr:      the logical start address in guest memory
>> @@ -1601,6 +1624,14 @@ static int handle_sw_breakpoint(S390CPU *cpu, struct kvm_run *run)
>>      return -ENOENT;
>>  }
>>  
>> +static void kvm_handle_diag_318(struct kvm_run *run)
>> +{
>> +    uint64_t reg = (run->s390_sieic.ipa & 0x00f0) >> 4;
>> +    uint64_t info = run->s.regs.gprs[reg];
>> +
>> +    kvm_s390_set_diag_318_info(info);
> 
> Follow the other diag handlers and rather call a common
> handle_diag_318() function, which will in turn call
> s390_set_diag_318_info()? While that feels like a bit of extra churn at
> a glance, it allows non-kvm access to this diag more easily.
> 

Can do.

>> +}
>> +
>>  #define DIAG_KVM_CODE_MASK 0x000000000000ffff
>>  
>>  static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
>> @@ -1620,6 +1651,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
>>      case DIAG_IPL:
>>          kvm_handle_diag_308(cpu, run);
>>          break;
>> +    case DIAG_SET_CONTROL_PROGRAM_CODES:
>> +        kvm_handle_diag_318(run);
>> +        break;
>>      case DIAG_KVM_HYPERCALL:
>>          r = handle_hypercall(cpu, run);
>>          break;
>> @@ -2460,6 +2494,12 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>      /* Extended-Length SCCB is handled entirely within QEMU */
>>      set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
>>  
>> +    /* Allow diag 0x318 iff KVM supported and not in PV mode */
> 
> "iff supported by KVM" ?
>

That sounds a bit better :)


>> +    if (!s390_is_pv() && kvm_vm_check_attr(kvm_state,
>> +        KVM_S390_VM_MISC, KVM_S390_VM_MISC_DIAG_318)) {
>> +        set_bit(S390_FEAT_DIAG_318, model->features);
>> +    }
>> +
>>      /* strip of features that are not part of the maximum model */
>>      bitmap_and(model->features, model->features, model->def->full_feat,
>>                 S390_FEAT_MAX);
> 
> (...)
> 
> 

Thanks for the review!

-- 
Regards,
Collin

Stay safe and stay healthy

