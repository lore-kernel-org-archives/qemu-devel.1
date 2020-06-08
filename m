Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24D7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B038204EF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="eOilio8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B038204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGWf-0006R5-Q4
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiGU8-0003zK-Bw
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:02:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiGU7-0006zr-0k
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:02:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id e1so17111105wrt.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ts5g2uev+1ISzrsi03Mun9L4h8pAwmrrs0sUoELtLg8=;
 b=eOilio8Sg5WpnNGonExnXEscVLYs7UepYzOw+3c++gvDAZANEAnLPgQ9DXmCl/lO0s
 vP6g47kQ6/bFLi6Szb5gZPoFkid1XNeJTA5Zu/yQdmKceuyDF9f/q1KJlbGhLlnGBr1B
 U60DKFPBxJjK50Y62DiRzK9eSpRmHYv9KBHIsuR09shXKdEZKE6vMG967awUwpewoLNz
 w91mZL5Jh4WaLHvnU2tE3XQk3pQ7KKFGXm8VS+VB8xRU3qOdUq5Mn/viEy9Ky2SNujKG
 ItBSdZalIxeDb5TwnCw3iFijfkTARIp3DdSN4Zl7qBRK9W+yOzCuGbNz2OeYkf4jUgQl
 PV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ts5g2uev+1ISzrsi03Mun9L4h8pAwmrrs0sUoELtLg8=;
 b=G02KBR6RoG7ntWSiKYywHX7I7B7fQEXzpYU1WBkHZMJT+k3XbW1CW7iNcTnh2L6wuc
 wRmkmt0uJxxWAe+lrqfqStjk5rUCOfmS3K/fBc2luMPlzRBmZgtwpPKaxiifYcK/44dz
 l3E5JL7XTmpCE9sP2UTUtRF1mJu+pvXRJX6iJWFpfSTymHCxXcXPBNYWCiL34xLKTaNr
 13eU11vFXQ0U38jAueCr7skOFdJxnxyXpFB1OBysHd5kQgHI9wOdmzWkrS3d10InL/k4
 yJMvpWoE9PMmO+O3EAe/Pm1y6xDVs7tuTdLFtvWLBeiWUvOrD/xKQq7FTUal5sR3CeF8
 bNZA==
X-Gm-Message-State: AOAM5308npPc/4Ml1lRls1WSdUzr2lIjUJAU35RJe0/HVkBFZX+8R74P
 NVlhH5ui1HABHJB/r8OyuxS4SA==
X-Google-Smtp-Source: ABdhPJxaJ+/GIfvfWpmZlty/GP+6wYjK/YYWlrt5dB0xkfdztldmoQFM4G5ndeSPjZsmkCAzfH8/9Q==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr23383600wrr.264.1591617749599; 
 Mon, 08 Jun 2020 05:02:29 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id t189sm22484693wma.4.2020.06.08.05.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 05:02:29 -0700 (PDT)
Date: Mon, 8 Jun 2020 13:02:26 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
Message-ID: <20200608120226.GM28566@vanye>
References: <20200604125544.GW28566@vanye>
 <20200604131802.7w4hncgq2gopbw6z@kamzik.brq.redhat.com>
 <20200604160300.GB28566@vanye>
 <CAFEAcA8MTB5VQQbMuSfkGc9JcGeawL_GUY8Pcs3yxT9kdncZJw@mail.gmail.com>
 <20200604162607.GC28566@vanye>
 <CAFEAcA-wX-vKek_Zt5hmjiQNP1utCO7yGJQPcuny1M7xncYsQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-wX-vKek_Zt5hmjiQNP1utCO7yGJQPcuny1M7xncYsQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

Hmm ... I managed to accidentally mark this one as read.

Anyway, I spent the Friday writing the RFC I just sent out instead.

On Thu, Jun 04, 2020 at 19:43:06 +0100, Peter Maydell wrote:
> On Thu, 4 Jun 2020 at 17:26, Leif Lindholm <leif@nuviainc.com> wrote:
> >
> > On Thu, Jun 04, 2020 at 17:09:30 +0100, Peter Maydell wrote:
> > > On Thu, 4 Jun 2020 at 17:03, Leif Lindholm <leif@nuviainc.com> wrote:
> > > > But there's also things like:
> > > > - a57_initfn explicitly setting kvm_target, then only being called
> > > >   from max_initfn for !kvm_enabled()
> > >
> > > Expected -- a KVM 'max' is nothing to do with a TCG 'max':
> > >  * for KVM, -cpu max means "same as -cpu host"
> > >  * for TCG, -cpu max means "start with an A57, then add in all the
> > >    extra architectural features that have been added since then".
> >
> > Sure. But why are we setting the kvm_target at all for the
> > !kvm_enabled() case?
> 
> Because it happens to be set in the a57 initfn, and it's harmless
> if we're not using TCG. I feel like some of your take on this set of
> functions comes from thinking of max_initfn as in some sense the
> 'primary' function here, when it's the other way around : a57_initfn
> is the standard kind of CPU initfn (behaving in and written the same
> way as a53_initfn and a72_initfn), whereas max_initfn is an odd
> special case which happens for convenience-of-implementation
> to piggyback on the a57 implementation.

Well, my take is more looking at a part of the codebase that I was not
previously familiar with, seeing things that seemed redundant, but not
being confident enough to dismiss them outright so having to spend
time investigating (and asking silly questions on list).

> > > kvm_target being set by a57_initfn is specifically for the case
> > > where a KVM user is using "-cpu cortex-a57".
> > >
> > > > - a57_initfn setting cpu->dtb_compatible to "arm,cortex-a57"
> > >
> > > What else would it set it to?
> >
> > Hmm, I had been hoping there was a generic v8a one - kvm64.c kind of
> > got my hopes up with "arm,arm-v8".
> 
> Ah, that's the other way around -- yes, for 'max' we should be using a
> more generic value, not accidentally using 'cortex-a57'. (Linux doesn't
> in practice care IIRC, which is why this bug hasn't been noticed.) But
> for an actual cortex-a57 model we should report as arm,cortex-a57.

Well, I think any OS that tries to be generically bootable *has* to
ignore that value, although it could be useful for informational
purposes.

> https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/cpus.yaml
> is the official list of permitted strings, incidentally.

My feeling is none of the values there are appropriate (arm,armv8
indicates ARM ltd, but not aarch64 support). I made something up for
the RFC set. We could always send a patch adding some qemu, or
generic, target.

> > Not entirely unrelated question:
> > Would you take added field definitions in target/arm/cpu.h for
> > features not yet emulated in QEMU but defined in released versions of
> > ARM ARM?
> 
> Yes in theory (you'll see that we have a bunch of field definitions already
> which we don't yet implement, because we tend to define all the fields
> for an ID register at the point where we want to access one field), but
> on the other hand there's usually no need to actually use them unless
> we're adding the emulation for the feature, so the question is: what would
> you do with them if you added them?

Reduce the delta between internal development and upstream.

This is not a suggestion NUVIA has a vast army of qemu developers
ready to implement all features supported by ARMv8.whatever.
But sometimes all we need is an instruction trace, and for that we
need to make sure any selection sequences pick the optimal ones we do
intend to implement.

Best Regards,

Leif

