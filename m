Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05024C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5436820776
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5436820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSUMP-0003VH-Ec
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 20:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kSULr-00034B-G6
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 20:09:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:48420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kSULo-0001un-Iy
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 20:09:07 -0400
IronPort-SDR: +hbGnNFY7AzMZDndeP2400sxLAaeFI1h42DMZ1TlmBVjBp8+rkz5m1WqgXJ7myuR6o9zZdmMgw
 ATImpXBOpyzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166119859"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; d="scan'208";a="166119859"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 17:08:56 -0700
IronPort-SDR: 4iXgspfu3Ff4Tjf9ogXjyzAwetkwOUJDivWHpwsWCzCwrXAj/0PtJngTcVJ+J6rJRDlttW3yNd
 IDXFL5lZ5ipQ==
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; d="scan'208";a="530616499"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.160])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 17:08:55 -0700
Date: Tue, 13 Oct 2020 17:08:54 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Subject: Re: [Qemu-devel][PATCH v6 1/6] x86/cpu: Rename XSAVE related feature
 words.
Message-ID: <20201014000854.GB16347@linux.intel.com>
References: <20201013051935.6052-1-weijiang.yang@intel.com>
 <20201013051935.6052-2-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013051935.6052-2-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=sean.j.christopherson@intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 20:08:57
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
Cc: ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 01:19:30PM +0800, Yang Weijiang wrote:
> With more components in XSS being developed on Intel platform,
> it's necessary to clean up existing XSAVE related feature words to
> make the name clearer. It's to prepare for adding CET related support
> in following patches.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  target/i386/cpu.c        | 60 ++++++++++++++++++++--------------------
>  target/i386/cpu.h        |  6 ++--
>  target/i386/fpu_helper.c |  2 +-
>  target/i386/translate.c  |  2 +-
>  4 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 588f32e136..e2891740f1 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1050,7 +1050,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .tcg_features = 0,
>          .unmigratable_flags = 0,
>      },
> -    [FEAT_XSAVE] = {
> +    [FEAT_XSAVE_INSTRUCTION] = {

The COMP->XCRO change is great, but I don't think XSAVE->XSAVE_INSTRUCTION
makes sense.  There is no guarantee the word will only be used for
instructions; it already blurs the line, e.g. XSAVEC also changes the behavior
of XRSTOR, and XSAVES also means the XSS MSR is available.

FWIW, I also don't find FEAT_XSAVE to be confusing.

>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
>              "xsaveopt", "xsavec", "xgetbv1", "xsaves",
> @@ -1084,7 +1084,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .cpuid = { .eax = 6, .reg = R_EAX, },
>          .tcg_features = TCG_6_EAX_FEATURES,
>      },
> -    [FEAT_XSAVE_COMP_LO] = {
> +    [FEAT_XSAVE_XCR0_LO] = {
>          .type = CPUID_FEATURE_WORD,
>          .cpuid = {
>              .eax = 0xD,

