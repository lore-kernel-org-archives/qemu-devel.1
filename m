Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF07C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 02:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863E722255
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 02:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863E722255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSslA-0007p3-L9
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 22:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSskF-0007NC-7X
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 22:11:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:26408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSskC-0002k2-EH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 22:11:54 -0400
IronPort-SDR: 5Zpcgr5ukijJxEfQ6fnPpzNbYU8DU53O61PTDtzPyZoY7rBl56jTzZspr1pDtt84mhvxASPL4Q
 WCLSTzRn6Ytw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="250927054"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; d="scan'208";a="250927054"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 19:11:46 -0700
IronPort-SDR: CfjESTNFk3ChXNjKSU3j6FmhHkecc0xsjDttObrKqnhA76zfQ4DlKO24eVCSSxj+BMB3jgAYyl
 3ZyoYzC68Ksg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; d="scan'208";a="521662742"
Received: from unknown (HELO localhost) ([10.239.159.128])
 by fmsmga005.fm.intel.com with ESMTP; 14 Oct 2020 19:11:44 -0700
Date: Thu, 15 Oct 2020 10:20:53 +0800
From: Yang Weijiang <weijiang.yang@intel.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [Qemu-devel][PATCH v6 1/6] x86/cpu: Rename XSAVE related feature
 words.
Message-ID: <20201015022053.GA12192@local-michael-cet-test>
References: <20201013051935.6052-1-weijiang.yang@intel.com>
 <20201013051935.6052-2-weijiang.yang@intel.com>
 <20201014000854.GB16347@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014000854.GB16347@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=weijiang.yang@intel.com; helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 22:11:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com, hao.wu@intel.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 05:08:54PM -0700, Sean Christopherson wrote:
> On Tue, Oct 13, 2020 at 01:19:30PM +0800, Yang Weijiang wrote:
> > With more components in XSS being developed on Intel platform,
> > it's necessary to clean up existing XSAVE related feature words to
> > make the name clearer. It's to prepare for adding CET related support
> > in following patches.
> > 
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > ---
> >  target/i386/cpu.c        | 60 ++++++++++++++++++++--------------------
> >  target/i386/cpu.h        |  6 ++--
> >  target/i386/fpu_helper.c |  2 +-
> >  target/i386/translate.c  |  2 +-
> >  4 files changed, 35 insertions(+), 35 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 588f32e136..e2891740f1 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1050,7 +1050,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >          .tcg_features = 0,
> >          .unmigratable_flags = 0,
> >      },
> > -    [FEAT_XSAVE] = {
> > +    [FEAT_XSAVE_INSTRUCTION] = {
> 
> The COMP->XCRO change is great, but I don't think XSAVE->XSAVE_INSTRUCTION
> makes sense.  There is no guarantee the word will only be used for
> instructions; it already blurs the line, e.g. XSAVEC also changes the behavior
> of XRSTOR, and XSAVES also means the XSS MSR is available.
> 
> FWIW, I also don't find FEAT_XSAVE to be confusing.
>
Thanks for the feedback! I also found it's hard to rename it with a
precise one, just wanted to make all XSAVE related feature words more
specific. I'll revert it in next version.

> >          .type = CPUID_FEATURE_WORD,
> >          .feat_names = {
> >              "xsaveopt", "xsavec", "xgetbv1", "xsaves",
> > @@ -1084,7 +1084,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >          .cpuid = { .eax = 6, .reg = R_EAX, },
> >          .tcg_features = TCG_6_EAX_FEATURES,
> >      },
> > -    [FEAT_XSAVE_COMP_LO] = {
> > +    [FEAT_XSAVE_XCR0_LO] = {
> >          .type = CPUID_FEATURE_WORD,
> >          .cpuid = {
> >              .eax = 0xD,

