Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73C5C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBA2224D2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBA2224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEztr-0001Wq-N3
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 13:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iEzsr-0000xU-O8
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iEzsq-0002KZ-0s
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45270)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iEzsp-0002KJ-P0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:54:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6ADC3066FD9;
 Mon, 30 Sep 2019 17:54:50 +0000 (UTC)
Received: from localhost (ovpn-116-88.gru2.redhat.com [10.97.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3954F5D9C9;
 Mon, 30 Sep 2019 17:54:50 +0000 (UTC)
Date: Mon, 30 Sep 2019 14:54:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] x86: Add CPUID KVM support for new instruction WBNOINVD
Message-ID: <20190930175449.GB4084@habkost.net>
References: <1545227503-214403-1-git-send-email-robert.hu@linux.intel.com>
 <CALMp9eRZCoZbeyttZdvaCUpOFKygTNVF_x7+TWh6MktmF-ZK9A@mail.gmail.com>
 <263d31d9-b21e-ceb9-b47c-008e30bbd94f@redhat.com>
 <CALMp9eRFWq+F1Dwb8NcBd-Bo-YbT6KMOLo8DoinQQfK9hEi5Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eRFWq+F1Dwb8NcBd-Bo-YbT6KMOLo8DoinQQfK9hEi5Qg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 30 Sep 2019 17:54:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Robert Hu <robert.hu@intel.com>,
 qemu-devel@nongnu.org, kvm list <kvm@vger.kernel.org>,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing qemu-devel.

On Tue, Sep 24, 2019 at 01:30:04PM -0700, Jim Mattson wrote:
> On Wed, Dec 19, 2018 at 1:02 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 19/12/18 18:39, Jim Mattson wrote:
> > > Is this an instruction that kvm has to be able to emulate before it
> > > can enumerate its existence?
> >
> > It doesn't have any operands, so no.
> >
> > Paolo
> >
> > > On Wed, Dec 19, 2018 at 5:51 AM Robert Hoo <robert.hu@linux.intel.com> wrote:
> > >>
> > >> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > >> ---
> > >>  arch/x86/include/asm/cpufeatures.h | 1 +
> > >>  arch/x86/kvm/cpuid.c               | 2 +-
> > >>  2 files changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > >> index 28c4a50..932b19f 100644
> > >> --- a/arch/x86/include/asm/cpufeatures.h
> > >> +++ b/arch/x86/include/asm/cpufeatures.h
> > >> @@ -280,6 +280,7 @@
> > >>  /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
> > >>  #define X86_FEATURE_CLZERO             (13*32+ 0) /* CLZERO instruction */
> > >>  #define X86_FEATURE_IRPERF             (13*32+ 1) /* Instructions Retired Count */
> > >> +#define X86_FEATURE_WBNOINVD           (13*32+ 9) /* Writeback and Don't invalid cache */
> > >>  #define X86_FEATURE_XSAVEERPTR         (13*32+ 2) /* Always save/restore FP error pointers */
> > >>  #define X86_FEATURE_AMD_IBPB           (13*32+12) /* "" Indirect Branch Prediction Barrier */
> > >>  #define X86_FEATURE_AMD_IBRS           (13*32+14) /* "" Indirect Branch Restricted Speculation */
> > >> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > >> index cc6dd65..763e115 100644
> > >> --- a/arch/x86/kvm/cpuid.c
> > >> +++ b/arch/x86/kvm/cpuid.c
> > >> @@ -380,7 +380,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
> > >>
> > >>         /* cpuid 0x80000008.ebx */
> > >>         const u32 kvm_cpuid_8000_0008_ebx_x86_features =
> > >> -               F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
> > >> +               F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
> > >>                 F(AMD_SSB_NO) | F(AMD_STIBP);
> > >>
> > >>         /* cpuid 0xC0000001.edx */
> > >> --
> > >> 1.8.3.1
> > >>
> 
> What is the point of enumerating support for WBNOINVD if kvm is going
> to implement it as WBINVD?

I expect GET_SUPPORTED_CPUID to return WBNOINVD, because it
indicates to userspace what is supported by KVM.  Are there any
expectations that GET_SUPPORTED_CPUID will also dictate what is
enabled by default in some cases?

In either case, your question applies to QEMU: why do we want
WBNOINVD to be enabled by "-cpu host" by default and be part of
QEMU's Icelake-* CPU model definitions?

-- 
Eduardo

