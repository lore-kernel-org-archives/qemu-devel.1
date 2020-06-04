Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056F8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A26206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOumfR1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A26206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpeS-0004yf-SA
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgpdW-0004Ik-39
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:10:22 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgpdV-0000xk-0d
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:10:21 -0400
Received: by mail-oi1-x244.google.com with SMTP id i74so5027288oib.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PWjEg59kz2CoeitEapTrGuAHI86fvdYOTJhTalufixQ=;
 b=pOumfR1HLk3zksbPDnaGI5DJbg4WgBxhcTkqidpFjTtNDff2w4FJZ6Nmkw3n1RUWfw
 iky4f/s4LzebF7TienA03dWTVldL/amvlMN0iwgRdyrjpoS60HYGEoYx6a/Bz5gxPcWP
 mayiTtPw8v/woGruUAbkzI6URvNP+1WjQFwUP3HBl0W7DdwuRMIE8sfgo6oSoImhh4G7
 0eIx2OFUnlHa9W/2L6vfKBWBhLH0vDX0CvFhcRJqQy4d4xtkNYHHZjMmuWgCeOy4u5Zv
 pB/MQmn2Hbb3DHqLwU8J/u0xhoAEc+FVXB050caiikWx9oLVzZjq+tmnEdBKi9AJp6Pq
 stDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PWjEg59kz2CoeitEapTrGuAHI86fvdYOTJhTalufixQ=;
 b=Z0WkQxj5xK5374LldQfwBwDQMTx2nqnf62AloPfYIAadp7lj8ATTE6wciYPSbgnv3v
 Y15+RdtkRYvwk2D2wWXOr8UGX6dIbvpuM7Y6ec0q0Nekn1hoQnxvJv6cZaMPWMaMf/X6
 xNAT/xzsWI8MeWIGYLk0V+j/3oJUBzO7BGwQrWuzRuDoCWn9XVUpT6xAigWThuJlZxpF
 2RHuPXLuiFOECtwpNaU6O3Y2KhoKAA4vistPRohjnB0EhVf5Cf/RKS8FhQNHMtkRhvzu
 nkjcY5MNO9FDCMcLnFjcPbG0P+ZEXymlCq3jS6uGvPa2qT/9PhYLXgzUmabc02z6dfo0
 GkXw==
X-Gm-Message-State: AOAM530tBB8VPvZhT968yXvwU6fac0YlS/cmPdEEQ/1zurv4r4wEw7Z7
 DByMsORXFj7htPtcOxoOimJwdzuPXyzdBpFT4jUsSw==
X-Google-Smtp-Source: ABdhPJxQK0brocuY/yk5yNQAhXiKBQWL1O57vMjoG5tbK+9HVP5RNwgfK7m5WStVPn5PL8PsFRO4dxBbKMdE0Xah7Gw=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2826760oib.48.1591276219324; 
 Thu, 04 Jun 2020 06:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200604125544.GW28566@vanye>
In-Reply-To: <20200604125544.GW28566@vanye>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 14:10:08 +0100
Message-ID: <CAFEAcA-ACvx19HZBk-nusMCOkr-D3KReUJRTouL02rLEXOUanQ@mail.gmail.com>
Subject: Re: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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

[added kvm-arm to the cc list; the kernel folks tend to hang out
there, not on qemu-devel, so KVM related questions are usually
worth raising there as well.]

On Thu, 4 Jun 2020 at 13:55, Leif Lindholm <leif@nuviainc.com> wrote:
> However, while looking at this, I noticed aarch64_a72_initfn doesn't
> initialise kvm_target at all.

Yep. The kernel doesn't support "give me a CPU that looks like
a Cortex-A72".

> So, then I decided to actually test things, and found that
> (with -enable-kvm):
> - on Cortex-A53 hardware
>   - "max" kvm_target gets initialized to 4 (KVM_ARM_TARGET_CORTEX_A53)
>     by kvm_arm_get_host_cpu_features (as returned from the kernel for
>     vm_arm_create_scratch_host_vcpu)
>   - cortex-A72 fails to start with "KVM is not supported for this guest
>     CPU type"
>   (fair enough, it's later than A53)

Untested, but I assume that -cpu cortex-a53 works on the A53...

> - on Cortex-A72 hardware
>   - "max" kvm_target gets initialized to 5 (KVM_ARM_TARGET_GENERIC_V8)
>     by kvm_arm_get_host_cpu_features
>   - "cortex-A72" fails to start (umm...)

...and fails on the A72 host.

> However ... if I haven't managed to confuse myself somewhere in here
> (which is completely possible), would it be OK if I submitted a set of
> patches that:
> - add a QEMU_KVM_ARM_TARGET_GENERIC_V8 to match the kernel one
> - set kvm_target for Cortex-A72 to QEMU_KVM_ARM_TARGET_GENERIC_V8

This would be wrong -- it would mean that you could tell QEMU "give
me a guest CPU that's a Cortex-A72" and it would not error on
non-A72 hardware but not actually give a guest CPU that looks
like a Cortex-A72.

 * If what you want is "give me something that works" then that's
   -cpu host or -cpu max.

 * If what you want is "give me something that's always this kind of
   CPU regardless of the host hardware" then that's a lot of kernel
   dev work nobody's been enthusiastic enough to undertake yet
   (notably the "what do we do about CPU errata workarounds" question
   would need to be solved...)

 * If what you want is "allow me to say '-cpu cortex-a72' and have
   it work on an A72 host and not anywhere else" then I guess we could
   implement that on the QEMU side by querying the MIDR and checking
   whether it was what we expected.

>   - alternatively drop the explicit settings for A57/A53

These explicit settings are correct, because for these CPUs
the kernel does have a "give me what I want in particular"
setting (which it will fail on the wrong h/w), and also as
back-compat for older kernels that predate the GENERIC_V8
define and only recognize the explicit "give me an A53" value.

> - drop the call from aarch64_max_initfn to aarch64_a57_initfn, and
>   copy the relevant bits into the former for the !kvm case

Not sure why you care about this -- it's an implementation
detail of the TCG handling of the 'max' CPU. There's an argument
for disentangling TCG 'max' so it's not literally implemented
as "a57 plus newer stuff", granted.

thanks
-- PMM

