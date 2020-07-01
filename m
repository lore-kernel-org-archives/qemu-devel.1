Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBE5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF0420853
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+jY0ppJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF0420853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqjer-0000Li-DD
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 16:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqjdc-0008Ew-2t
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 16:47:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqjdZ-0000lu-2X
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 16:47:23 -0400
Received: by mail-ot1-x341.google.com with SMTP id t18so9676995otq.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NS99qhyL/fdn4mBR75hJsxF0sNVyQqI7PaTGFtqZkfA=;
 b=B+jY0ppJQkHbJxcziqEhjiUqZmmFJgHsUhPYe45EHt+08bM0N1zgvNCCf46Y/tJAIu
 G4JvY9uGrW3W+XBDXdruy5rVALEZHeWvgQvsQUnTRucgzkkN9Gc7eGviQkWJBmDdg48G
 xhv1QUdKQn+UD1RPlprqIKuQZbze5HC4YnfiAHdArk1OWOz6eCxZ+URFhwbyMi12lUxc
 OQwP70/2HWXR0NXW6HNJ1vTLF5yD7y55Sup+XIw6/KHVH+eryh9FSwTcCusA7rjooEeC
 SkjVR2rXNrtQLicl+43So0KO9hkyqIrAR9Qx4bYzPXdZpzlVMTQceHW9KvIx9FLpPOcW
 5kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NS99qhyL/fdn4mBR75hJsxF0sNVyQqI7PaTGFtqZkfA=;
 b=W5NOh17Unz2jGYB2nzm1KV6Y9ZW6VOU5vuo4VHvRMBZX2i6ZiayXNisKSfa2tY6KiY
 GcUAk95B6jcg39T0yJJJAcz2RS0W94KMLGO5yb5aFHZRlpnQvYOxUqCJhi++NgP+JdZt
 h6VlMe+lFJ9j1rXPFOGjmoQY7rKiB0MqYYmWKH6EN2YrguimteAXA245lP17neAWf5RH
 6VnhbDN+JT0GRl4FgNHbPs0PsJr4m8aLhFBmL+IL6HSkQgqBmyVI20BPzWZs/gWSUp/5
 wlJ7TQb9Xv6Fszkhkp1YVjHLrVLr3kROu4V0Ofjrx+xvZC22isTG7q2gYLkdiCs1jE1W
 YUUQ==
X-Gm-Message-State: AOAM532viKSbhdZeishJz+Xj6XUCTSpLxUOLZM8aBAWJVpQMXZXGuIVo
 o0xpA0rLM/kPAkWjr5EubtXH0Rza0K7yZtQ5RLdvpw==
X-Google-Smtp-Source: ABdhPJwaN8ZebAef5emBG204pfVdkXZqfjiPamo/sGFafI237deS+C9vAj+UbJs84M/rQxjTRESXSny+yF78fazKevE=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr16178878oto.135.1593636439510; 
 Wed, 01 Jul 2020 13:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200701200848.26746-1-agraf@csgraf.de>
In-Reply-To: <20200701200848.26746-1-agraf@csgraf.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Jul 2020 21:47:08 +0100
Message-ID: <CAFEAcA9S5v0LHMNc4fu9JGUzecbg8DsogZuCEv_aGNqVxRAcDQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Treat unknown SMC calls as NOP
To: Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Jul 2020 at 21:08, Alexander Graf <agraf@csgraf.de> wrote:
>
> We currently treat unknown SMC calls as UNDEF. This behavior is different
> from KVM, which treats them as NOP.
>
> Unfortunately, the UNDEF exception breaks running Windows for ARM in QEMU,
> as that probes an OEM SMCCC call on boot, but does not expect to receive
> an UNDEF exception as response.
>
> So instead, let's follow the KVM path and ignore SMC calls that we don't
> handle. This fixes booting the Windows 10 for ARM preview in TCG for me.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>

> +    if (cs->exception_index == EXCP_SMC &&
> +        !arm_feature(env, ARM_FEATURE_EL3) &&
> +        cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {

This condition says: "we got an SMC, and this CPU doesn't
have EL3, and we're not imitating real EL3 firmware".
The architecturally correct behaviour here (since we don't
implement nested-virt yet, which might allow it to trap
to guest EL2) is to UNDEF, as far as I can see from a quick
look at the AArch64.CheckForSMCUndefOrTrap().

I'm not sure why KVM makes these NOP; if I'm right about the
architectural behaviour then making them NOP would be a KVM bug.

If Windows makes an SMC call on boot that seems like a guest
bug: it would crash on a real CPU without EL2/EL3 as well.

      *  Conduit SMC, valid call  Trap to EL2         PSCI Call
      *  Conduit SMC, inval call  Trap to EL2         Undef insn
-     *  Conduit not SMC          Undef insn          Undef insn
+     *  Conduit not SMC          nop                 nop

The line in this table that your commit message says you're
fixing is "Conduit SMC, inval call"; the line your code
change affects is "Conduit not SMC", which is not the same
thing. (I'd have to look at the PSCI spec to see what it
requires for SMCs that aren't valid PSCI calls.)

thanks
-- PMM

