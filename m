Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE5EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C43D21582
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C43D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIpH-0000QL-Sx
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.price@arm.com>)
 id 1kGIla-0005Pi-9Z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:21:18 -0400
Received: from foss.arm.com ([217.140.110.172]:51364)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steven.price@arm.com>) id 1kGIlX-0007zF-LE
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:21:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4612A1045;
 Thu, 10 Sep 2020 02:21:14 -0700 (PDT)
Received: from [192.168.1.79] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BD033F68F;
 Thu, 10 Sep 2020 02:21:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm64: kvm: Introduce MTE VCPU feature
To: Andrew Jones <drjones@redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200904160018.29481-3-steven.price@arm.com>
 <20200909154804.mide6szbzgdy7jju@kamzik.brq.redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <3a7e18af-84bd-cee3-d68f-e08f225fc166@arm.com>
Date: Thu, 10 Sep 2020 10:21:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909154804.mide6szbzgdy7jju@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=steven.price@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 05:21:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <Peter.Maydell@arm.com>, Juan Quintela <quintela@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/2020 16:48, Andrew Jones wrote:
> On Fri, Sep 04, 2020 at 05:00:18PM +0100, Steven Price wrote:
>> Add a new VCPU features 'KVM_ARM_VCPU_MTE' which enables memory tagging
>> on a VCPU. When enabled on any VCPU in the virtual machine this causes
>> all pages that are faulted into the VM to have the PG_mte_tagged flag
>> set (and the tag storage cleared if this is the first use).
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>   arch/arm64/include/asm/kvm_emulate.h |  3 +++
>>   arch/arm64/include/asm/kvm_host.h    |  5 ++++-
>>   arch/arm64/include/uapi/asm/kvm.h    |  1 +
>>   arch/arm64/kvm/mmu.c                 | 15 +++++++++++++++
>>   arch/arm64/kvm/reset.c               |  8 ++++++++
>>   arch/arm64/kvm/sys_regs.c            |  6 +++++-
>>   6 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>> index 49a55be2b9a2..0042323a4b7f 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -79,6 +79,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>>   	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
>>   	    vcpu_el1_is_32bit(vcpu))
>>   		vcpu->arch.hcr_el2 |= HCR_TID2;
>> +
>> +	if (test_bit(KVM_ARM_VCPU_MTE, vcpu->arch.features))
>> +		vcpu->arch.hcr_el2 |= HCR_ATA;
>>   }
>>   
>>   static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 4f4360dd149e..b1190366242b 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -37,7 +37,7 @@
>>   
>>   #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
>>   
>> -#define KVM_VCPU_MAX_FEATURES 7
>> +#define KVM_VCPU_MAX_FEATURES 8
>>   
>>   #define KVM_REQ_SLEEP \
>>   	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>> @@ -110,6 +110,9 @@ struct kvm_arch {
>>   	 * supported.
>>   	 */
>>   	bool return_nisv_io_abort_to_user;
>> +
>> +	/* If any VCPU has MTE enabled then all memory must be MTE enabled */
>> +	bool vcpu_has_mte;
> 
> It looks like this is unnecessary as it's only used once, where a feature
> check could be used.

It's used in user_mem_abort(), so every time we fault a page into the VM 
- so having to iterate over all VCPUs to check if any have the feature 
bit set seems too expensive.

Although perhaps I should just accept that this is realistically a VM 
setting and move it out of the VCPU.

>>   };
>>   
>>   struct kvm_vcpu_fault_info {
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index ba85bb23f060..2677e1ab8c16 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -106,6 +106,7 @@ struct kvm_regs {
>>   #define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
>>   #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
>>   #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
>> +#define KVM_ARM_VCPU_MTE		7 /* VCPU supports Memory Tagging */
>>   
>>   struct kvm_vcpu_init {
>>   	__u32 target;
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index ba00bcc0c884..e8891bacd76f 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -1949,6 +1949,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	if (vma_pagesize == PAGE_SIZE && !force_pte)
>>   		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>>   							   &pfn, &fault_ipa);
>> +	if (system_supports_mte() && kvm->arch.vcpu_has_mte && pfn_valid(pfn)) {
>> +		/*
>> +		 * VM will be able to see the page's tags, so we must ensure
>> +		 * they have been initialised.
>> +		 */
>> +		struct page *page = pfn_to_page(pfn);
>> +		long i, nr_pages = compound_nr(page);
>> +
>> +		/* if PG_mte_tagged is set, tags have already been initialised */
>> +		for (i = 0; i < nr_pages; i++, page++) {
>> +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
>> +				mte_clear_page_tags(page_address(page));
>> +		}
>> +	}
>> +
>>   	if (writable)
>>   		kvm_set_pfn_dirty(pfn);
>>   
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index ee33875c5c2a..82f3883d717f 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -274,6 +274,14 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>   		}
>>   	}
>>   
>> +	if (test_bit(KVM_ARM_VCPU_MTE, vcpu->arch.features)) {
>> +		if (!system_supports_mte()) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +		vcpu->kvm->arch.vcpu_has_mte = true;
>> +	}
> 
> We either need a KVM cap or a new CPU feature probing interface to avoid
> making userspace try features one at a time. It's too bad that VCPU_INIT
> doesn't clear all offending features from the feature set when returning
> EINVAL, because then userspace could create a scratch VCPU with everything
> it supports in order to see what KVM also supports in one go.

If Peter's TELL_ME_WHAT_YOU_HAVE idea works out then perhaps we don't 
need the cap? Or would it still be useful?

Thanks,

Steve

>> +
>>   	switch (vcpu->arch.target) {
>>   	default:
>>   		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index a655f172b5ad..6a971b201e81 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1132,7 +1132,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>>   			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>>   		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
>>   	} else if (id == SYS_ID_AA64PFR1_EL1) {
>> -		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>> +		if (!test_bit(KVM_ARM_VCPU_MTE, vcpu->arch.features))
>> +			val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>>   	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
>>   		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
>>   			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
>> @@ -1394,6 +1395,9 @@ static bool access_mte_regs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>>   static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>>   				   const struct sys_reg_desc *rd)
>>   {
>> +	if (test_bit(KVM_ARM_VCPU_MTE, vcpu->arch.features))
>> +		return 0;
>> +
>>   	return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
>>   }
>>   
>> -- 
>> 2.20.1
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm@lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>>
> 
> Thanks,
> drew
> 


