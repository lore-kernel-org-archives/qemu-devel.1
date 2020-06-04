Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FACFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE04206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqgYANN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE04206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jguqL-0007RW-PD
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgupk-0006uy-Qz
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:43:20 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgupj-0001p4-Pu
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:43:20 -0400
Received: by mail-ot1-x342.google.com with SMTP id m2so5566873otr.12
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V+tqJ4we1CwKNF7vfPzsSSNsnmnzFHhUB3cgyBqkxgk=;
 b=JqgYANN6wCRpfWlLBsko7YwgwNfwEaWNit+i2c5alu3KgyDbJVujVZkxQFwQkH46Wf
 7OVXpwcwfGe/EcYpm0heZcAtrB636jHZz3jtv5xdDxNtG8xoVrDASEVXZrWkRMgSo9lN
 YMJIoJUT+PA0WAKUR723LbTufO6g7MUD6Ea5tvU5vli1KhV5ddWMe518xwMxwsrnz8Mk
 fE3NjREHwI0OJjuY0tE7L573hdV3H94jcczLbleQlC/I6+hlHyv5vwycstK4ZWTGPqcX
 ar3SsGoapFv2eqcfhNECk+JtIp+PZtrG+7DA2aFTbeZjcXWQ5VOjwtcEtAsEsz9F1hje
 4y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V+tqJ4we1CwKNF7vfPzsSSNsnmnzFHhUB3cgyBqkxgk=;
 b=hNtBg0oNBXvQO1p4O7xA6A6NXxuawHL4cFH0iTWPKBkSMhEuQPalOhpRaHRHI5ALQr
 yhf2wDe3A1FZn6nSI+LdD13Sco5EKArp+wwPdi4sQcsy25pDSTmlqMcuNOtZ4qjosk1r
 rMSrhOB+7hM1fUI3Wr8Iv5DqMx8n3pmWkNJNFBSrYereU8illJEyYxH0vgJ0TXLEorJb
 wanMGte4NNNZSSx9OJvu+ASWeUjpIXpOQV5+O8Cti8ocY9Ir1pLLtOd3UnT4kLaNpqpz
 BDodAwStu8T//8FU1pCBY+A0Fem6T4ahKku1kVG2HVjkRNZfYducvTdNC2boqY8tfe4D
 uCmA==
X-Gm-Message-State: AOAM533ASY2cmMy4pc5ultXr3PV1t7o573rkhBpqT0XfB/FXsrouCFN1
 ULRX7mKxFudT9TKrwU0kF3A+P2gw+paog7l/fKOHfg==
X-Google-Smtp-Source: ABdhPJzggb5WUf1cNMSoUQ6SGQdBpjYQ57LzrsgBqMUD5mPPkWKFtZd7PEnRXVX8xT4+od4o78BlELhc9OFUKlvGyug=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr4528725oth.221.1591296197806;
 Thu, 04 Jun 2020 11:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200604125544.GW28566@vanye>
 <20200604131802.7w4hncgq2gopbw6z@kamzik.brq.redhat.com>
 <20200604160300.GB28566@vanye>
 <CAFEAcA8MTB5VQQbMuSfkGc9JcGeawL_GUY8Pcs3yxT9kdncZJw@mail.gmail.com>
 <20200604162607.GC28566@vanye>
In-Reply-To: <20200604162607.GC28566@vanye>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 19:43:06 +0100
Message-ID: <CAFEAcA-wX-vKek_Zt5hmjiQNP1utCO7yGJQPcuny1M7xncYsQg@mail.gmail.com>
Subject: Re: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 17:26, Leif Lindholm <leif@nuviainc.com> wrote:
>
> On Thu, Jun 04, 2020 at 17:09:30 +0100, Peter Maydell wrote:
> > On Thu, 4 Jun 2020 at 17:03, Leif Lindholm <leif@nuviainc.com> wrote:
> > > But there's also things like:
> > > - a57_initfn explicitly setting kvm_target, then only being called
> > >   from max_initfn for !kvm_enabled()
> >
> > Expected -- a KVM 'max' is nothing to do with a TCG 'max':
> >  * for KVM, -cpu max means "same as -cpu host"
> >  * for TCG, -cpu max means "start with an A57, then add in all the
> >    extra architectural features that have been added since then".
>
> Sure. But why are we setting the kvm_target at all for the
> !kvm_enabled() case?

Because it happens to be set in the a57 initfn, and it's harmless
if we're not using TCG. I feel like some of your take on this set of
functions comes from thinking of max_initfn as in some sense the
'primary' function here, when it's the other way around : a57_initfn
is the standard kind of CPU initfn (behaving in and written the same
way as a53_initfn and a72_initfn), whereas max_initfn is an odd
special case which happens for convenience-of-implementation
to piggyback on the a57 implementation.

> > kvm_target being set by a57_initfn is specifically for the case
> > where a KVM user is using "-cpu cortex-a57".
> >
> > > - a57_initfn setting cpu->dtb_compatible to "arm,cortex-a57"
> >
> > What else would it set it to?
>
> Hmm, I had been hoping there was a generic v8a one - kvm64.c kind of
> got my hopes up with "arm,arm-v8".

Ah, that's the other way around -- yes, for 'max' we should be using a
more generic value, not accidentally using 'cortex-a57'. (Linux doesn't
in practice care IIRC, which is why this bug hasn't been noticed.) But
for an actual cortex-a57 model we should report as arm,cortex-a57.

https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/cpus.yaml
is the official list of permitted strings, incidentally.

> > > - a57 initfn setting cpu->midr, max_initfn overwriting parts of it
> >
> > Also expected, TCG's -cpu max is "A57 with lots of extras".
>
> Maybe I'm being too rigid in my thinking here, but it does kind of jar
> to see code call a function called aarch64_a57_initfn to have it write
> a value where it then throws away the only thing in the value that
> made it a57.

The things that make it an A57 are all the feature flag and ID
register values (which is is what tells the TCG implementation
how the CPU should behave). The MIDR value is the least interesting
bit of the a57_initfn in some ways: it doesn't change the QEMU
emulation's behaviour and mostly guests don't care what the value
is except for purposes of installing errata workarounds that don't
matter for QEMU: your average guest would work just as well with
any MIDR...

> Not entirely unrelated question:
> Would you take added field definitions in target/arm/cpu.h for
> features not yet emulated in QEMU but defined in released versions of
> ARM ARM?

Yes in theory (you'll see that we have a bunch of field definitions already
which we don't yet implement, because we tend to define all the fields
for an ID register at the point where we want to access one field), but
on the other hand there's usually no need to actually use them unless
we're adding the emulation for the feature, so the question is: what would
you do with them if you added them?

thanks
-- PMM

