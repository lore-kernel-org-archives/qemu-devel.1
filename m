Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96187C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5995521855
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SghKJhyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5995521855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFJ1i-0002iq-JE
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jmattson@google.com>) id 1iFJ0u-0002Gm-JD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jmattson@google.com>) id 1iFJ0t-0004bN-82
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:20:28 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jmattson@google.com>) id 1iFJ0t-0004af-1q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:20:27 -0400
Received: by mail-io1-xd43.google.com with SMTP id c6so48211904ioo.13
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D/xSwAO+ZHPX/90H8l9qiIZ/X2lvmU5qlfHvvHmawI8=;
 b=SghKJhyuubfUZGba9D/J3HbXP788J5my0wVH+70DG65wZCi0tD81arck0qSRRFOc5p
 ROa9DY+5OQiLSKDAWgz9ZxOOuqyecT5SZbjarSpZVJMrrdM2v5xstDXZM6r6LEQTSsy/
 JpL8w/eYqsOdhP5mA84yBexYXyNIQwHqIwjzkfoca8hTjwFuedCv0SB33LDnjB9km3Wu
 pgCtd4C6zReX7mKSHIBbt8fgv6+5j8aPfNLW+RRBBo3nndV+5oiGzjypuYfC3EIw9lb1
 sdQioFkHVeVershGm9BJ9HH37tou059WCQ7erjx2tv9vmrk0z2lCyIN2US01DrdWmPT5
 Ls2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D/xSwAO+ZHPX/90H8l9qiIZ/X2lvmU5qlfHvvHmawI8=;
 b=loonE2og0fAPsbYAXAqbEId4DHtIcIOoDuc0geELJnRlhlEPcjnPCvNRPhszJ7Nl+z
 U79Ld+2TxPwk3tHJtfO7mIW1MGtQ4FwWVVoNtn87ZNfKIWRjBbMHoTNfelhuiylf1BGU
 4RC3yMS0LS17dHN/sTqRMgFDEJPtzrMlL0e5wjHDwXR+jU8vT1EbUMAqKu8DZfpaZGa1
 GAZkEdq5pHS00hlfkCWngrrHPvCmhGxRh1x6bDUvr15fZKMTe0YCNaM3IFDphU7nWGKa
 DrGEIVZJVwAyqhHQZA5DCDfx0exBR3AGT5enG+RtKuIm/j9LoCwrJsK2gI0uaSuNF/SW
 vkWA==
X-Gm-Message-State: APjAAAVih3RZfGdNIU0KcIqL69Y6g/H3PxG4RRpLNrCTlgxocGRoTYy/
 4OHnYA43F04lWx0Ak31IGbDRtwNIjUqqEXVGtQBgSQ==
X-Google-Smtp-Source: APXvYqxcvuQbyQ2lsmmk9D+terHcutbpXWHXy3e3XC8Gq2nJlGu4QIv5X/u+eSgAAB6aXCYaaTBZIAtbRCY3Lz4mxfI=
X-Received: by 2002:a92:5ad1:: with SMTP id b78mr26611534ilg.118.1569939625754; 
 Tue, 01 Oct 2019 07:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <1545227503-214403-1-git-send-email-robert.hu@linux.intel.com>
 <CALMp9eRZCoZbeyttZdvaCUpOFKygTNVF_x7+TWh6MktmF-ZK9A@mail.gmail.com>
 <263d31d9-b21e-ceb9-b47c-008e30bbd94f@redhat.com>
 <CALMp9eRFWq+F1Dwb8NcBd-Bo-YbT6KMOLo8DoinQQfK9hEi5Qg@mail.gmail.com>
 <20190930175449.GB4084@habkost.net>
 <CALMp9eR88jE7YV-TmZSSD2oJhEpbsgo-LCgsWHkyFtHcHTmnzw@mail.gmail.com>
 <9bbe864ab8fb16d9e64745b930c89b1db24ccc3a.camel@intel.com>
In-Reply-To: <9bbe864ab8fb16d9e64745b930c89b1db24ccc3a.camel@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 1 Oct 2019 07:20:17 -0700
Message-ID: <CALMp9eSe_7on+F=ng05DkvvBpnWhSirEpSVz9Bua4Sy606xJnw@mail.gmail.com>
Subject: Re: [PATCH] x86: Add CPUID KVM support for new instruction WBNOINVD
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, 
 "robert.hu@linux.intel.com" <robert.hu@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hu, Robert" <robert.hu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 30, 2019 at 5:45 PM Huang, Kai <kai.huang@intel.com> wrote:
>
> On Mon, 2019-09-30 at 12:23 -0700, Jim Mattson wrote:
> > On Mon, Sep 30, 2019 at 10:54 AM Eduardo Habkost <ehabkost@redhat.com> =
wrote:
> > > CCing qemu-devel.
> > >
> > > On Tue, Sep 24, 2019 at 01:30:04PM -0700, Jim Mattson wrote:
> > > > On Wed, Dec 19, 2018 at 1:02 PM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> > > > > On 19/12/18 18:39, Jim Mattson wrote:
> > > > > > Is this an instruction that kvm has to be able to emulate befor=
e it
> > > > > > can enumerate its existence?
> > > > >
> > > > > It doesn't have any operands, so no.
> > > > >
> > > > > Paolo
> > > > >
> > > > > > On Wed, Dec 19, 2018 at 5:51 AM Robert Hoo <robert.hu@linux.int=
el.com>
> > > > > > wrote:
> > > > > > > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > > > > > > ---
> > > > > > >  arch/x86/include/asm/cpufeatures.h | 1 +
> > > > > > >  arch/x86/kvm/cpuid.c               | 2 +-
> > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/arch/x86/include/asm/cpufeatures.h
> > > > > > > b/arch/x86/include/asm/cpufeatures.h
> > > > > > > index 28c4a50..932b19f 100644
> > > > > > > --- a/arch/x86/include/asm/cpufeatures.h
> > > > > > > +++ b/arch/x86/include/asm/cpufeatures.h
> > > > > > > @@ -280,6 +280,7 @@
> > > > > > >  /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), w=
ord 13
> > > > > > > */
> > > > > > >  #define X86_FEATURE_CLZERO             (13*32+ 0) /* CLZERO
> > > > > > > instruction */
> > > > > > >  #define X86_FEATURE_IRPERF             (13*32+ 1) /* Instruc=
tions
> > > > > > > Retired Count */
> > > > > > > +#define X86_FEATURE_WBNOINVD           (13*32+ 9) /* Writeba=
ck and
> > > > > > > Don't invalid cache */
> > > > > > >  #define X86_FEATURE_XSAVEERPTR         (13*32+ 2) /* Always
> > > > > > > save/restore FP error pointers */
> > > > > > >  #define X86_FEATURE_AMD_IBPB           (13*32+12) /* "" Indi=
rect
> > > > > > > Branch Prediction Barrier */
> > > > > > >  #define X86_FEATURE_AMD_IBRS           (13*32+14) /* "" Indi=
rect
> > > > > > > Branch Restricted Speculation */
> > > > > > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > > > > > index cc6dd65..763e115 100644
> > > > > > > --- a/arch/x86/kvm/cpuid.c
> > > > > > > +++ b/arch/x86/kvm/cpuid.c
> > > > > > > @@ -380,7 +380,7 @@ static inline int __do_cpuid_ent(struct
> > > > > > > kvm_cpuid_entry2 *entry, u32 function,
> > > > > > >
> > > > > > >         /* cpuid 0x80000008.ebx */
> > > > > > >         const u32 kvm_cpuid_8000_0008_ebx_x86_features =3D
> > > > > > > -               F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) |
> > > > > > > F(VIRT_SSBD) |
> > > > > > > +               F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) |
> > > > > > > F(AMD_SSBD) | F(VIRT_SSBD) |
> > > > > > >                 F(AMD_SSB_NO) | F(AMD_STIBP);
> > > > > > >
> > > > > > >         /* cpuid 0xC0000001.edx */
> > > > > > > --
> > > > > > > 1.8.3.1
> > > > > > >
> > > >
> > > > What is the point of enumerating support for WBNOINVD if kvm is goi=
ng
> > > > to implement it as WBINVD?
> > >
> > > I expect GET_SUPPORTED_CPUID to return WBNOINVD, because it
> > > indicates to userspace what is supported by KVM.  Are there any
> > > expectations that GET_SUPPORTED_CPUID will also dictate what is
> > > enabled by default in some cases?
> > >
> > > In either case, your question applies to QEMU: why do we want
> > > WBNOINVD to be enabled by "-cpu host" by default and be part of
> > > QEMU's Icelake-* CPU model definitions?
> >
> > I had only looked at the SVM implementation of WBNOINVD, which is
> > exactly the same as the SVM implementation of WBINVD. So, the question
> > is, "why enumerate WBNOINVD if its implementation is exactly the same
> > as WBINVD?"
> >
> > WBNOINVD appears to be only partially documented in Intel document
> > 319433-037, "Intel=C2=AE Architecture Instruction Set Extensions and Fu=
ture
> > Features Programming Reference." In particular, there is no
> > documentation regarding the instruction's behavior in VMX non-root
> > mode. Does WBNOINVD cause a VM-exit when the VM-execution control,
> > "WBINVD exiting," is set? If so, does it have the same VM-exit reason
> > as WBINVD (54), or a different one? If it does have the same VM-exit
> > reason (a la SVM), how does one distinguish a WBINVD VM-exit from a
> > WBNOINVD VM-exit? If one can't distinguish (a la SVM), then it would
> > seem that the VMX implementation also implements WBNOINVD as WBINVD.
> > If that's the case, the question for VMX is the same as for SVM.
>
> Unfortunately WBNOINVD interaction with VMX has not been made to public y=
et. I
> am reaching out internally to see when it can be done. I agree it may not=
 be
> necessary to expose WBNOINVD if its implementation is exactly the same as
> WBINVD, but it also doesn't have any harm, right?

If nested VMX changes are necessary to be consistent with hardware,
then enumerating WBNOINVD support in the guest CPUID information at
this time--without the attendant nested VMX changes--is premature. No
changes to nested SVM are necessary, so it's fine for AMD systems.

If no changes to nested VMX are necessary, then it is true that
WBNOINVD can be emulated by WBINVD. However, it provides no value to
specifically enumerate the instruction.

If there is some value that I'm missing, then why make guest support
for the instruction contingent on host support for the instruction?
KVM can implement WBNOINVD as WBINVD on any host with WBINVD,
regardless of whether or not the host supports WBNOINVD.

> Thanks,
> -Kai

