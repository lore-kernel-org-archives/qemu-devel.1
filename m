Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB57C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 00:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C3721D40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 00:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ys3084PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C3721D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGAW8-00029w-4q
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 20:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kGAV4-0001ap-MD
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 20:31:43 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:37806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kGAV2-0005GW-Q2
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 20:31:42 -0400
Received: by mail-il1-x142.google.com with SMTP id b17so4117708ilh.4
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 17:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K+30+VS0rk66ThWd4s4WgMggIckGxwoQaIhERxXO24I=;
 b=ys3084PJ00Laa6JOhR/f0dFohEBOIbDRcdHIt1oi5IlCg0KaR24VFqJmN1fKny9pw7
 Re54tfWbya6abnZIjAs0sFxSrdMLNSl6wSR2OauIEJp0JcgAd2iCfJl1rXwJxU8bNX6E
 gB+uo6rjuu4eYVMmZtgZGFeRzWsDtzAoMNKUQOCYo+mxhUQWvNigMntsEYyqfSHx1XC1
 xaCbLMd2T4qM0j4UBCeFGGnDlhofXDu5QMnL3Dzcdt4QB0APlVmXzw4PTtFf5W9CZ56i
 qiwcrOYh0gkW6JwyAfnBDvcL75NgQyOlXPMgEtdYXrzL0Hbeq57a21uSyZfcSXh0k6B6
 YYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K+30+VS0rk66ThWd4s4WgMggIckGxwoQaIhERxXO24I=;
 b=ZBuA+dRlYeEk6S0w327y/ue8+oJmGUvXhlkFFq7oT0LmHuAJZ6T9pfXg1Q88wpghfg
 ub+dU/Da9hvdgKw7i9PgSYsLPosm0oA1af+tv/2GoxOxluyVb7HEBoRm0Hdx0PGMHzQ1
 Nr2GKrtuCTyVKeP9A7qOaIUAlqrtY9GLDExYr+8Mu1i0fL3VGDL3PwwKqwuriVdlxEvr
 fJ9XhjGkLdGkX7mcC2Ms/MG3fXzk4tRj688hIXZNKnF+lQa+EjM4H2OpW8WnL1uwmQAa
 y8J+5D9uD5Td9+veuPUL190pRTPV8+QZhrSeHxeRX5f5TWxmStCXpBgtaFWZaPEzYM9r
 Xi/g==
X-Gm-Message-State: AOAM533P53cxpfL0U8Jk8BhgS3FQs0p1HNHfv/EDfVoHwu7wdRzF76eE
 aC6FeL8VZvvPP7qQR15DhS2uQU6pvJRhAN2IaVwf
X-Google-Smtp-Source: ABdhPJy0d5mAszBSKdUnlPdIoCssdjrG2wCJou4+nlBeWGWYDQpU2JyWaAtd8I41GOc2xZGnE1bt43VD0lieGXqSrqo=
X-Received: by 2002:a92:bad9:: with SMTP id t86mr5699761ill.308.1599697899340; 
 Wed, 09 Sep 2020 17:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <c6ac607d2cd253de6a990538edfde7f86066f04f.1599549462.git.haibo.xu@linaro.org>
 <20200908111625.2wzzn7jh5wt4nnmu@kamzik.brq.redhat.com>
 <CAJc+Z1GCmf5fEjifa84O6jmfd6WCih1jT07AXb7vWFC7=sXfrA@mail.gmail.com>
 <20200909093435.txd7bkt6n3z7tm4u@kamzik.brq.redhat.com>
In-Reply-To: <20200909093435.txd7bkt6n3z7tm4u@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Thu, 10 Sep 2020 08:31:27 +0800
Message-ID: <CAJc+Z1Eer6HRN8P_2CnujYjCmUNzmTbXvU6CtH0Mzpr0MywwJA@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] hw/arm/virt: spe: Add SPE fdt binding for virt
 machine
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=haibo.xu@linaro.org; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 at 17:34, Andrew Jones <drjones@redhat.com> wrote:
>
> On Wed, Sep 09, 2020 at 03:51:14PM +0800, Haibo Xu wrote:
> > > > +
> > > > +            if (spe) {
> > > > +                assert(ARM_CPU(cpu)->has_spe == ON_OFF_AUTO_ON);
> > > > +                if (kvm_irqchip_in_kernel()) {
> > > > +                    kvm_arm_spe_set_irq(cpu, PPI(VIRTUAL_SPE_IRQ));
> > > > +                }
> > > > +                kvm_arm_spe_init(cpu);
> > >
> > > A later patch introduces userspace irqchip support. Should we avoid
> > > allowing it until then to avoid breaking bisection?
> > >
> >
> > Yes, it's possible to break the bisection. To avoid it I think we can
> > move the above codes
> > block to a separate patch after adding the userspace irqchip support,
> > Or, just put the userspace
> > irqchip support patch before this patch. What's your opinion?
> >
>
> This patch ca forbid SPE without kernel irqchip. Then the patch that adds
> userspace irqchip support would also remove the restriction.
>
> Thanks,
> drew
>

Good idea! Will fix it in v3.

