Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2069FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACAB20738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7oOFFjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACAB20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgsRi-0005c1-4n
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgsR6-000563-CB
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:09:44 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:43972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgsR4-000405-Mv
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:09:43 -0400
Received: by mail-ot1-x333.google.com with SMTP id u23so5168620otq.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VBs6iE9+n8Kqp1wKypzu3gJAncF/teohACQrm2k8vFY=;
 b=Z7oOFFjvippx3Wxho5UoW9OupQbElYrQsGc+kzcQHHCvEbXd2DaE8lF/YQvF0XUpmB
 QWtTXIoeKRh7ciR+Fm9MzREgxylWffAJ9rHd1aA16cebqAwTU18jOQJR+jAEoLXaqY2Z
 0lBQNgl1DegMbqFASDA0QzMsUEP/KBgb3Y8MF68HepBd8BRkIp8yK6/EvYmAj4uY0Y0U
 uFmmdGzpNYhDdYYBT+s391PeIh90tvfkydr+jrmRJCOcwSH0LRxyj/EF4V8ovG6Plo7d
 gMA8BMY0m5seMBA7H7c8n262aILYdyGxt4kHVcJxyDCakVsE0/2/hyw+vVm180BX8Dpk
 50kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VBs6iE9+n8Kqp1wKypzu3gJAncF/teohACQrm2k8vFY=;
 b=R9DBBOVHhCzema1uSZgYs26IOAyF7Bx5kkyzqhk5gTGJL3uyc2jgwOu6DH/iaCTy62
 9n1d9z2EDnCExPP+2pJkQDwMTECIBmSzLCN4/YpK943qote1mtZ//cMURucAH0dwLfQM
 5fiuQKnugGbZkxppRVhY4TOwFEwNi51p63QC3nj+XrdFVZtR7LEVrU9fibPxzon8AJuU
 7ymaChj6Bo3a83LJnovTDYJxHClHHni7LzBLeItENLPBVhU4/lX0mkGJ3nqi0TgXL0gD
 4y03mrsFjOMpmHuq/lNDpYHNkpuacKUmrk6HTLYiTHjXPNv6MU989e7VZwt5bVud0lh6
 uKZw==
X-Gm-Message-State: AOAM530AAAxQhWGflP9hQiNKVIk9P9/ABSkhqCddCyl1vg4da7Maenko
 3GPZ0oRCbB5srfiecpUlMGI3DGSNd0D31YY5dTb4hQ==
X-Google-Smtp-Source: ABdhPJyZM09oWZUP3UWjYQpBSJ8Ro5Yyneq/K6M6P0yAKoFcyRiWxB1WZcT5AN9W5h8rZMRnAL3VgCRebgzMjRIh6Ic=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr4387698ote.135.1591286981629; 
 Thu, 04 Jun 2020 09:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200604125544.GW28566@vanye>
 <20200604131802.7w4hncgq2gopbw6z@kamzik.brq.redhat.com>
 <20200604160300.GB28566@vanye>
In-Reply-To: <20200604160300.GB28566@vanye>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 17:09:30 +0100
Message-ID: <CAFEAcA8MTB5VQQbMuSfkGc9JcGeawL_GUY8Pcs3yxT9kdncZJw@mail.gmail.com>
Subject: Re: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
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

On Thu, 4 Jun 2020 at 17:03, Leif Lindholm <leif@nuviainc.com> wrote:
> But there's also things like:
> - a57_initfn explicitly setting kvm_target, then only being called
>   from max_initfn for !kvm_enabled()

Expected -- a KVM 'max' is nothing to do with a TCG 'max':
 * for KVM, -cpu max means "same as -cpu host"
 * for TCG, -cpu max means "start with an A57, then add in all the
   extra architectural features that have been added since then".

kvm_target being set by a57_initfn is specifically for the case
where a KVM user is using "-cpu cortex-a57".

> - a57_initfn setting cpu->dtb_compatible to "arm,cortex-a57"

What else would it set it to?

> - a57 initfn setting cpu->midr, max_initfn overwriting parts of it

Also expected, TCG's -cpu max is "A57 with lots of extras".

The way we create a TCG -cpu max is a bit odd, as the code was
originally written in a situation where A57 was the most advanced
TCG CPU we had and there were no extra architectural features
supported by our CPU emulation. Today we have an A72 model as
well and a lot of extra architectural features, so the "code
borrowed" to "extras added" ratio looks a bit unbalanced.
Cleaning it up would not be a bad idea.

thanks
-- PMM

