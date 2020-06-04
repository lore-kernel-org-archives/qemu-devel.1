Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A25C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E348D20772
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DA0y86VT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E348D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgsJ2-00056H-Te
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgsHD-0004DB-A1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:59:31 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgsHC-0002UX-0N
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:59:30 -0400
Received: by mail-oi1-x242.google.com with SMTP id j189so5495046oih.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5mnHsKgYgyPRbTKqgtT7/UZM0+pF2Q/0sYBJXit37Mo=;
 b=DA0y86VTfMA7Ccq120t0nnCUtpKgjnpttBV62BElyhiG9Pxv+XeVVtCql1787LC5QG
 DmtDEqSBZWc+TXsQESn8ytEcKhzX7bjIqASPuSeQ5hzn1J2VeLpQEU5tEE5eV3KoenQB
 B8vwAIjjn/qrARHgxpw6y8Sjrh4wkIHLVUSIdLFwQa3noePPvgWEIWLsXqoj6VGiS7Ge
 gZ+XT5kXsOivUzU4QwPArPqyFRft3oS9UmxYrkcIi/Y/SDBIWoesxH8+qJjTUZlPBfpe
 bvOs/WQE/tDFfI9TgTmFeEWWq8noxvQ/fpaxRBmNGXM5ck6sTNy0mH2ZNnDed2LDopXA
 prOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5mnHsKgYgyPRbTKqgtT7/UZM0+pF2Q/0sYBJXit37Mo=;
 b=F8mpUuZ7ybOhRZQ4WqLZUoNI4SYm9fOVcYxa2lq4THwWGjCOOwAzP475FqETzVIeOV
 jqk88qKcRcw+K3W1jmshsl27sGFVu3epi9uIREdFV/16ZLPNhKDOgPnB0xdAvQxKQlbj
 1DSjwwcmcATxJzXQDRKZNODCeH2i/hKyporUYmWf6fCKE1i2qO125G0Z+PgZEzLo+aBv
 //w9QtEMns/P+gUOo8/F8zX/r5XEE7b3l1MyiWJRrfjkVqMSTp7TiQnnLVjKbslNoFeS
 h3Yk08a/qm2zlJ8Z3r+Il+abi1PdlBb2Cv9HRESFbY0bSsGavPINWPfdrTHF6oJTzkJQ
 fXWw==
X-Gm-Message-State: AOAM533Oy0hF9cOCgsMWy24/jW0iDENDPjNeN5f0H6AZKrJHH1sOaKUn
 71hHMCO19LnHeFDsuxeIP7obAsDqTeyhbatkTYUhfg==
X-Google-Smtp-Source: ABdhPJzRr1gR0+PBoF2g2QdQz253XpCjPfcZYCJf7UST/SryLRh+njb0feZXzeAIdU879PCo8gHu/Zqah36YdKCizLo=
X-Received: by 2002:a54:469a:: with SMTP id k26mr3579724oic.163.1591286368617; 
 Thu, 04 Jun 2020 08:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200604125544.GW28566@vanye>
 <CAFEAcA-ACvx19HZBk-nusMCOkr-D3KReUJRTouL02rLEXOUanQ@mail.gmail.com>
 <20200604153846.GA28566@vanye>
In-Reply-To: <20200604153846.GA28566@vanye>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 16:59:17 +0100
Message-ID: <CAFEAcA8QKfR_fb+evC3DkH_cqYK5oOemPxy8VgcaOdCnhfwzAw@mail.gmail.com>
Subject: Re: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 16:38, Leif Lindholm <leif@nuviainc.com> wrote:
> On Thu, Jun 04, 2020 at 14:10:08 +0100, Peter Maydell wrote:
> > On Thu, 4 Jun 2020 at 13:55, Leif Lindholm <leif@nuviainc.com> wrote:
> > > So, then I decided to actually test things, and found that
> > > (with -enable-kvm):
> > > - on Cortex-A53 hardware
> > >   - "max" kvm_target gets initialized to 4 (KVM_ARM_TARGET_CORTEX_A53)
> > >     by kvm_arm_get_host_cpu_features (as returned from the kernel for
> > >     vm_arm_create_scratch_host_vcpu)
> > >   - cortex-A72 fails to start with "KVM is not supported for this guest
> > >     CPU type"
> > >   (fair enough, it's later than A53)
> >
> > Untested, but I assume that -cpu cortex-a53 works on the A53...
>
> Yes.
>
> > > - on Cortex-A72 hardware
> > >   - "max" kvm_target gets initialized to 5 (KVM_ARM_TARGET_GENERIC_V8)
> > >     by kvm_arm_get_host_cpu_features
> > >   - "cortex-A72" fails to start (umm...)
> >
> > ...and fails on the A72 host.
>
> From an explicit software test. If I initialize kvm_target to
> KVM_ARM_TARGET_GENERIC_V8, I can certainly run EDK2.

That would be asking for a -cpu max, though, not for an A53.

> > > However ... if I haven't managed to confuse myself somewhere in here
> > > (which is completely possible), would it be OK if I submitted a set of
> > > patches that:
> > > - add a QEMU_KVM_ARM_TARGET_GENERIC_V8 to match the kernel one
> > > - set kvm_target for Cortex-A72 to QEMU_KVM_ARM_TARGET_GENERIC_V8
> >
> > This would be wrong -- it would mean that you could tell QEMU "give
> > me a guest CPU that's a Cortex-A72" and it would not error on
> > non-A72 hardware but not actually give a guest CPU that looks
> > like a Cortex-A72.
> >
> >  * If what you want is "give me something that works" then that's
> >    -cpu host or -cpu max.
>
> That's what I thought until I saw the manual A57/A53 setting of
> kvm_target.

> > >   - alternatively drop the explicit settings for A57/A53
> >
> > These explicit settings are correct, because for these CPUs
> > the kernel does have a "give me what I want in particular"
> > setting (which it will fail on the wrong h/w), and also as
> > back-compat for older kernels that predate the GENERIC_V8
> > define and only recognize the explicit "give me an A53" value.
>
> Right. But then I got somewhat confused also by how
> https://git.qemu.org/?p=qemu.git;a=blob;f=target/arm/kvm64.c#l494
> doesn't explicitly list KVM_ARM_TARGET_CORTEX_A53.

That list is supposed to contain "all CPUs which might be
present on a host kernel which doesn't support the
PREFERRED_TARGET ioctl". That ioctl went in in Linux kernel
commit 42c4e0c77ac91, and in a kernel source tree
"git show 42c4e0c77ac91:arch/arm64/include/uapi/asm/kvm.h"
tells us that indeed at that point the only 3 CPUs supported
were AEM_V8, FOUNDATION_V8 and CORTEX_A57. Once the host
kernel supported the PREFERRED_TARGET ioctl, we could query
it to ask "what kind of CPU are you?" in that function rather
than having to guess.

> So ... the reason I care is because I'm adding a new cpu in my local
> branch, figured cpu64.c was a good starting point, and then followed a
> long string of repeating the questions "why?" and "why not?" while
> trying to understand why things were set up the way they are.
>
> And I ended up in a state where it looks like we do some things for
> A57 that we don't do for A53, and we do even fewer things for A72, but
> then we do (end up doing) all of the A57 bits again for max (for TCG
> only), and then overwriting them.

(we don't overwrite them, we augment them.)

> Then I tried to build some sort of consistent working model in my head
> and send some questions off to the list rather than try to send out
> patches straight away as I figured the likelihood was high I had
> missed or misunderstood something.
>
> I guess what I'm really asking is if there is some legacy in here
> that can be cleaned up to make the expected behaviour for a new CPU
> more clear from looking at available code? And if there are specific
> legacy things that need to be kept around for compatibility that
> should not be implemented by new CPUs, if they could have some nice
> warnings attached.

At this point I'd take another step backwards and ask
"why are you trying to add a new CPU?". Are you after a
TCG emulation of it, or are you trying to use KVM? If you're
using KVM, generally QEMU is set up so you don't need to tell
it about new CPU types at all. Mostly the cpu definitions for
specific CPUs in cpu64.c are there because we want them for TCG.

thanks
-- PMM

