Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D3C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 01:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED062085A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 01:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED062085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdP9m-0001xx-NH
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 21:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52209)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hdP8w-0001WY-7K
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 21:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hdP8v-0002Az-60
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 21:12:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:45596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hdP8t-00024N-Uf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 21:12:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2019 18:11:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,391,1557212400"; d="scan'208";a="170412612"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.224])
 ([10.239.196.224])
 by orsmga002.jf.intel.com with ESMTP; 18 Jun 2019 18:11:49 -0700
To: Xiaoyao Li <xiaoyao.li@linux.intel.com>, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com
References: <20190616153525.27072-1-tao3.xu@intel.com>
 <20190616153525.27072-3-tao3.xu@intel.com>
 <94f9e831-38a0-3cc3-f566-6c8e5909d0fd@linux.intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <1bbe0308-6479-2a76-ba4e-f38203c975f7@intel.com>
Date: Wed, 19 Jun 2019 09:11:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <94f9e831-38a0-3cc3-f566-6c8e5909d0fd@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH v3 2/2] target/i386: Add support for
 save/load IA32_UMWAIT_CONTROL MSR
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
Cc: cohuck@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 jingqi.liu@intel.com, mtosatti@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/2019 11:39 AM, Xiaoyao Li wrote:
> 
> 
> On 6/16/2019 11:35 PM, Tao Xu wrote:
>> UMWAIT and TPAUSE instructions use IA32_UMWAIT_CONTROL at MSR index
>> E1H to determines the maximum time in TSC-quanta that the processor
>> can reside in either C0.1 or C0.2.
>>
>> This patch is to Add support for save/load IA32_UMWAIT_CONTROL MSR in
>> guest.
>>
>> Co-developed-by: Jingqi Liu <jingqi.liu@intel.com>
>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> no changes in v3:
>> ---
>>   target/i386/cpu.h     |  2 ++
>>   target/i386/kvm.c     | 13 +++++++++++++
>>   target/i386/machine.c | 20 ++++++++++++++++++++
>>   3 files changed, 35 insertions(+)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 2f7c57a3c2..eb98b2e54a 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -450,6 +450,7 @@ typedef enum X86Seg {
>>   #define MSR_IA32_BNDCFGS                0x00000d90
>>   #define MSR_IA32_XSS                    0x00000da0
>> +#define MSR_IA32_UMWAIT_CONTROL         0xe1
>>   #define XSTATE_FP_BIT                   0
>>   #define XSTATE_SSE_BIT                  1
>> @@ -1348,6 +1349,7 @@ typedef struct CPUX86State {
>>       uint16_t fpregs_format_vmstate;
>>       uint64_t xss;
>> +    uint64_t umwait;
>>       TPRAccess tpr_access_type;
>>   } CPUX86State;
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 3efdb90f11..506c7cd038 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -91,6 +91,7 @@ static bool has_msr_hv_stimer;
>>   static bool has_msr_hv_frequencies;
>>   static bool has_msr_hv_reenlightenment;
>>   static bool has_msr_xss;
>> +static bool has_msr_umwait;
>>   static bool has_msr_spec_ctrl;
>>   static bool has_msr_virt_ssbd;
>>   static bool has_msr_smi_count;
>> @@ -1486,6 +1487,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>>                   case MSR_IA32_XSS:
>>                       has_msr_xss = true;
>>                       break;
>> +                case MSR_IA32_UMWAIT_CONTROL:
>> +                    has_msr_umwait = true;
>> +                    break;
> 
> Need to add MSR_IA32_UMWAIT_CONTROL into msrs_to_save[] in your kvm 
> patches, otherwise qemu never goes into this case.
> 
OK, thank you for your suggestion. I will add it in the next version.


