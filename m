Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4104C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867EE2177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L299jsLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867EE2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIl4-0005dh-PB
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBIkU-0005EL-DG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:19:30 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBIkS-0002iH-Il
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:19:29 -0400
Received: by mail-ej1-x642.google.com with SMTP id a26so7912786ejc.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yxXFspISz8wQfQ7IGKs2OhkW+npxZHZYc5jn5H3h0wk=;
 b=L299jsLAjeKXnCkw/BoKr/07xDmxKsiKdyjPUfXpSEQeb9pnmqDaeakCv07HYbZqhV
 RDExGAvXaXI2edYqVaUtZMD/D6O63ghXq+TrnQ1MxyrkrQawHfx0ikHaXEhT4RZ2ZfyU
 hpE8oAAdrLxRD0mH9lEiMhV6/ey6DZBoI29Jl0IqAz7UEaapdMvfRnq1y8xPCcySy2DS
 7yyrOsUBclsWzxFJR+XbKx55YQPiLSa8RJo+tQTePghPcaARjVLK/HRQx4pCEOvZ95gi
 hRFPdn7SpJC9dftd6H0V/SqNxSGhw85sk0BlQGmoBwytdLprC4voENTyakF/uSs+fIUS
 D2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yxXFspISz8wQfQ7IGKs2OhkW+npxZHZYc5jn5H3h0wk=;
 b=nuYK2kI3n1GLhZzQP/4gz+w65/l2FgbmSR6v9h1ry73SqBErsSUjccTJqKAZyuj4wb
 7KKZDJAxN4Rz0OUTJjnC+iaYwZpoxKwpaWazLgdIpEw4cbOTRz76qF1SLCczL7zIgKPU
 2kV+k3Dv2x/1CtLWSdTMJ437rRF6mKEsb3alnwc/fF3C/ptDKzA/zE+V5wubd6ING1lA
 K8A7T0RjMmGkLPuBz5jmg+5sNwL7SDpd40VgXpXqTvLuHeS8zOlQBoeD0m2zU51do/bI
 S5CKeCKoKm3lxt47hO6IJlxLAmyc7lZ6hRRDTJCVUzs0tsyBzCaVJ20L81vCZFZhMoH4
 bsZQ==
X-Gm-Message-State: AOAM530Sg7NR7dmZVwgSquwiK1yxMu26Sir2w3MGZN2BXQ+ArghpLccn
 dUzm3do+Gm6U4iJV3k0ridivZrmsd9PRqJN+TGEI4w==
X-Google-Smtp-Source: ABdhPJzbx5RIylTBuEBq4wRl7NH9cpo7kFKtARTIsDursTaehrApPvXMZVYJZIFS1sfn71Fvbsrg4nUTX+n8AObfyGc=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr20412061ejb.382.1598537966893; 
 Thu, 27 Aug 2020 07:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200827113259.25064-1-peter.maydell@linaro.org>
 <8385e0cf-b955-e62d-dfdc-51380b7c5433@redhat.com>
In-Reply-To: <8385e0cf-b955-e62d-dfdc-51380b7c5433@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 15:19:15 +0100
Message-ID: <CAFEAcA_3fiQ86aby8PALZNUukPE1RhgV+1+hjoEF+aCfCp3mbw@mail.gmail.com>
Subject: Re: [PATCH] Deprecate lm32 port
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 14:52, Thomas Huth <thuth@redhat.com> wrote:
> What's next? moxie? ... apart from the tree-wide clean-ups and trivial
> fixes, moxie did not have any major updates since 2013 when it has been
> added, as far as I can see ... is anybody still using it?

I was never very clear on how much use moxie had to start with...

An extremely rough-and-ready guide to how well-loved a target
is might be "did it get converted to TranslatorOps?". Unconverted:
 * avr
 * cris
 * lm32 (deprecation in progress)
 * microblaze (rth just posted patches for this)
 * moxie
 * nios2
 * tilegx (deprecation in progress)
 * unicore32 (deprecation in progress)

As I say, very rough-and-ready: we have had recent interest in nios2;
avr has just got into the tree so hopefully the maintainer will have
a look at TranslatorOps conversion; Edgar is still around for cris.

I think dropping the moxie maintainer an email to ask about the
architecture's status wouldn't be a bad idea if you wanted to start
that ball rolling.

thanks
-- PMM

