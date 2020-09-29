Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE34C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A13208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A13208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6sN-0001Hc-Va
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kN6rK-0000Qc-Vb
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:03:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:13332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kN6rI-00067X-5V
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:03:22 -0400
IronPort-SDR: LFKIUWTPiMWP1QSp0vSuK6Ydhol9ADnlDHtg/0iJ7FLYiaP4ATph8q3HeFjSo2oW9Tew/K69Ke
 qLzyiorc56cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="162989297"
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; d="scan'208";a="162989297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 21:03:14 -0700
IronPort-SDR: H+A8gaOj84RpkZt74p+GjpzFAfHlGf+IYoh0enZRvL1fIkCabp2geqNngGtJ0RW1hP8m88adg4
 YJ7mfJIdYITg==
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; d="scan'208";a="350068368"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.160])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 21:03:13 -0700
Date: Mon, 28 Sep 2020 21:03:11 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Subject: Re: [PATCH 1/6 v3] KVM: x86: Change names of some of the kvm_x86_ops
 functions to make them more semantical and readable
Message-ID: <20200929040309.GI31514@linux.intel.com>
References: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
 <1595895050-105504-2-git-send-email-krish.sadhukhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595895050-105504-2-git-send-email-krish.sadhukhan@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=sean.j.christopherson@intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 00:03:14
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This needs a changelog.

I would also split the non-x86 parts, i.e. the kvm_arch_* renames, to a
separate patch.

On Tue, Jul 28, 2020 at 12:10:45AM +0000, Krish Sadhukhan wrote:
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> ---
> @@ -4016,15 +4016,15 @@ static int svm_vm_init(struct kvm *kvm)
>  	.tlb_flush_gva = svm_flush_tlb_gva,
>  	.tlb_flush_guest = svm_flush_tlb,
>  
> -	.run = svm_vcpu_run,
> +	.vcpu_run = svm_vcpu_run,
>  	.handle_exit = handle_exit,
>  	.skip_emulated_instruction = skip_emulated_instruction,
>  	.update_emulated_instruction = NULL,
>  	.set_interrupt_shadow = svm_set_interrupt_shadow,
>  	.get_interrupt_shadow = svm_get_interrupt_shadow,
>  	.patch_hypercall = svm_patch_hypercall,
> -	.set_irq = svm_set_irq,
> -	.set_nmi = svm_inject_nmi,
> +	.inject_irq = svm_set_irq,

I would strongly prefer these renames to be fully recursive within a single
patch, i.e. rename svm_set_irq() as well.

Ditto for the unsetup->teardown change.

> +	.inject_nmi = svm_inject_nmi,
>  	.queue_exception = svm_queue_exception,
>  	.cancel_injection = svm_cancel_injection,
>  	.interrupt_allowed = svm_interrupt_allowed,
> @@ -4080,8 +4080,8 @@ static int svm_vm_init(struct kvm *kvm)
>  	.enable_smi_window = enable_smi_window,
>  
>  	.mem_enc_op = svm_mem_enc_op,
> -	.mem_enc_reg_region = svm_register_enc_region,
> -	.mem_enc_unreg_region = svm_unregister_enc_region,
> +	.mem_enc_register_region = svm_register_enc_region,
> +	.mem_enc_unregister_region = svm_unregister_enc_region,
>  
>  	.need_emulation_on_page_fault = svm_need_emulation_on_page_fault,
>  

...

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4fdf303..cb6f153 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1469,15 +1469,15 @@ struct kvm_s390_ucas_mapping {
>  #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
>  #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
>  /* Memory Encryption Commands */
> -#define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
> +#define KVM_MEM_ENC_OP	            _IOWR(KVMIO, 0xba, unsigned long)

Renaming macros in uapi headers will break userspace.

We could do

  #define KVM_MEMORY_ENCRYPT_OP	KVM_MEM_ENC_OP

internally, but personally I think it would do more harm than good.

>  struct kvm_enc_region {
>  	__u64 addr;
>  	__u64 size;
>  };
>  
> -#define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
> -#define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
> +#define KVM_MEM_ENC_REGISTER_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
> +#define KVM_MEM_ENC_UNREGISTER_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
>  
>  /* Available with KVM_CAP_HYPERV_EVENTFD */
>  #define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)

