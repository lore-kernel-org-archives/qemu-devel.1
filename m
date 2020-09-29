Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F007C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6C8214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6C8214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6xt-0003Qx-Ef
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kN6wi-0002zJ-Sa
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:08:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:28650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kN6wg-0006jH-To
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:08:56 -0400
IronPort-SDR: fkVt1NLpACKPwedP00zQdloVx/KO41Q1egoSN8eYn945yNAWIXK9zvBN9VcxwfjavESwizxFaB
 zqigqoMPKyew==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="149768316"
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; d="scan'208";a="149768316"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 21:08:52 -0700
IronPort-SDR: 9/lqPWIKpxzy8/gS/sXhO3UCBs8INbatRgMZDOkjh5VsDA4yAB02AKmukpGRteJDRzEXJHqgBX
 O3sJAQIZCNAw==
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; d="scan'208";a="312073844"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.160])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 21:08:52 -0700
Date: Mon, 28 Sep 2020 21:08:51 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Subject: Re: [PATCH 4/6 v3] KVM: VMX: Fill in conforming vmx_x86_ops via macro
Message-ID: <20200929040851.GK31514@linux.intel.com>
References: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
 <1595895050-105504-5-git-send-email-krish.sadhukhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595895050-105504-5-git-send-email-krish.sadhukhan@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=sean.j.christopherson@intel.com; helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:28:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

On Tue, Jul 28, 2020 at 12:10:48AM +0000, Krish Sadhukhan wrote:
> The names of some of the vmx_x86_ops functions do not have a corresponding
> 'vmx_' prefix. Generate the names using a macro so that the names are
> conformant. Fixing the naming will help in better readability and
> maintenance of the code.
> 
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> ---
>  arch/x86/kvm/vmx/nested.c |   2 +-
>  arch/x86/kvm/vmx/vmx.c    | 234 +++++++++++++++++++++++-----------------------
>  arch/x86/kvm/vmx/vmx.h    |   2 +-
>  3 files changed, 120 insertions(+), 118 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index d1af20b..a898b53 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3016,7 +3016,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
>  
>  	preempt_disable();
>  
> -	vmx_prepare_switch_to_guest(vcpu);
> +	vmx_prepare_guest_switch(vcpu);

I very strongly prefer the VMX version, i.e. rename kvm_x86_ops.prepare_guest_switch()
instead of renamed vmx_prepare_switch_to_guest().  prepare_guest_switch() can be
misinterpreted as switching to a different guest, and vmx_prepare_switch_to_guest()
explicitly pairs with vmx_prepare_switch_to_host().

>  
>  	/*
>  	 * Induce a consistency check VMExit by clearing bit 1 in GUEST_RFLAGS,

