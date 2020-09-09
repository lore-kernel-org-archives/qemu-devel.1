Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709E4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA06A20639
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RfcRjoln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA06A20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2Q2-00049n-Cp
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG2PN-0003SQ-I5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:53:17 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG2PL-0001vz-8Y
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:53:17 -0400
Received: by mail-ed1-x542.google.com with SMTP id l63so3154791edl.9
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tYTAx4l6f2u8KbHrEy5Rn6tgANLlely6K9NrAKkKaD4=;
 b=RfcRjolnslna7osjOO1TXCoghzNi2fKgyFZPEMSQax8YEU8v4535p5x6dM2zbOIX8K
 aGJX4vT0l4XB4cYXiNDKH+3JzRNjm3eijcTc7SfI9q1BpSt79VwY8JZjA17Leq2ZJjYD
 tOpHiKVDtUz2jt2C6HN0AItE24CYkZLmi72A1fJlHm2sL3JbaocWOehxQ156RbPQE4DY
 LBdCPb63BwhCd9tiQqsumCNyOc414IoPmrhnv6Dx6RngxPr4gNNW9DYbjhlC3gMkccSL
 0WNDOoOdeaTUr5BMaP0jEDoAul/y2Yq5eI7X8LXVuiR4Tsj+mAF5IlR5CJZySYjOgH/B
 gTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tYTAx4l6f2u8KbHrEy5Rn6tgANLlely6K9NrAKkKaD4=;
 b=Ky0puWFKTvnPV8NKAMS8gvnNTN/UozHAhLvPrpUFjB69e8+3Fm6u6N1y1aWnRlKmxO
 iwWhNGfrfhWIQCKLXHKfY+/b7JRJaUJ18ypHkHNwZGrcqYgG48zU8vOEPWxl2dFBi/tC
 ASou08z22NFQFkMs1bBm2bgOClYen8r+sq0u8idF2soPVfiWfFeem28kR8UfNW2PRgo/
 9eNMQ6w/51supsuI23/WqkW1ZPWxX+GJTV0bwD+MDCoDqtTIEvq9BQYhj5IJ9vlXRt8i
 tPT4Oxs2s7zAkw1yWA2LGd13EZinCnHttev6vsjzxSBN2c5BgmG/2BdYy7qMFSJADPQm
 pAZg==
X-Gm-Message-State: AOAM531ZnwRGIa5eHoMJLl1vdt9TwDMEjc0asZ/wDufGj+wyRPo86uZ0
 OgHdxem7TI30kDNoIF2pDAkjiXPChfkOgHlrVLkIWA==
X-Google-Smtp-Source: ABdhPJw/klL8m+jTWg8TN2b2YPUs5PNhV2M3PAJmM/yRQZlC76+0uLWD3k61ammc5irNXocl1b/iC7V5ejqeyp86R9g=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr4647541edw.251.1599666793751; 
 Wed, 09 Sep 2020 08:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200904160018.29481-3-steven.price@arm.com>
 <20200909154804.mide6szbzgdy7jju@kamzik.brq.redhat.com>
In-Reply-To: <20200909154804.mide6szbzgdy7jju@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2020 16:53:02 +0100
Message-ID: <CAFEAcA_1YnBg3HVmtrSMP8u7GqHY8mtDAJwVcZuNUhwA+q9q=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: kvm: Introduce MTE VCPU feature
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <Peter.Maydell@arm.com>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Juan Quintela <quintela@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Steven Price <steven.price@arm.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 at 16:48, Andrew Jones <drjones@redhat.com> wrote:
> We either need a KVM cap or a new CPU feature probing interface to avoid
> making userspace try features one at a time. It's too bad that VCPU_INIT
> doesn't clear all offending features from the feature set when returning
> EINVAL, because then userspace could create a scratch VCPU with everything
> it supports in order to see what KVM also supports in one go.

You could add one if you wanted -- add a new feature bit
TELL_ME_WHAT_YOU_HAVE. If the kernel sees that then on filure
it clears out feature bits it doesn't support and also clears
TELL_ME_WHAT_YOU_HAVE. If QEMU sees EINVAL and TELL_ME_WHAT_YOU_HAVE
is still set, then it knows it's dealing with an old kernel
and has to do one-at-a-time probing. If it sees EINVAL but not
TELL_ME_WHAT_YOU_HAVE then it knows it has a new kernel and
has just got all the info.

-- PMM

