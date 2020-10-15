Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC2BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84CE21D41
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M95eddoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84CE21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5Pd-0002ok-Kw
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT5EH-0001UW-Bf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:31:50 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:46150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT5ED-0007Nl-2p
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:31:43 -0400
Received: by mail-ed1-x544.google.com with SMTP id 33so3470776edq.13
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=bBuKOmZ+1wb0rXNSIrM3zJXE++U/4YyR49GY80nl+44=;
 b=M95eddoZJGH3LfLQ0bMzwIbjJ1Unudg9PVhR71I4PQPTy+E2K0/4ujW5CTV+pLVX9n
 tNaSanX8zjEmq5tcXMMty7CDEIShhU4cqIge4ZCHTDHAfgHiWc8rYP8T2xbgO1oxa+gQ
 1igIuPbf+nVc4TyCgbzHRMpTfrLa1XXpgdIwZpgeFGhOUGshPWl9pFg20tJV5F64TScu
 kDhCm4TsQspyAp9bxnCdc5l3+9F9hf/B7cg1O4HirS0K5oR1FOeQ7UZPlaZFUeTQOwN/
 eKG3Uy8JaKjmdF8a2LkuJmzwrfs/j7SSJA6GqEcze+llrINhLcDsUwF0ummkQgVoSGlD
 ZYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=bBuKOmZ+1wb0rXNSIrM3zJXE++U/4YyR49GY80nl+44=;
 b=Mp386rEWf0K8V7URqwBFOFWc3+t7U4bbw0msvAEL9eNP69GGuX/KImIJ4fMFyK1n15
 YQyd410G6UB/5Wx4I3sAcnGt+UeIGxxaUScrQLp5vWWusAZZFsIE4UjagosX5mhiZ0GO
 hrrHerypD+3flKb/wBzhxzF7UKaslJl4MjEYr8GLqahTziZVvzJn+QztTTKIwFT9uCUp
 YQLKGXTMEnrC55Mi+DMMnwbmwJfxaAG6DPXsU4hqykqLLMaV5spEwEJm9qATxyTBB1H1
 kiEoGwxbP9Pt70MzCDkM7SrHvhmjrY8AsADjXhsVcjrvlmmCTFmWseEYDX5OWhpQMzjT
 mB4A==
X-Gm-Message-State: AOAM533QhfFq0skfaQQoZL9HwWm552SWX8BMyUkVj7Igmxo0QIilJUen
 t3TxeL1KYPvUAQiY1dZTPxNriaftL/6MIMDazu5J7UWiFeYRrlve
X-Google-Smtp-Source: ABdhPJwtwpufI9Zlr3xVaSsiUZmuiFIrGp27yPgejDE8V222zC6EZrOAjwf9NJGgPS/sTaFMCJ9jY+yv8nM3a9Kpyds=
X-Received: by 2002:aa7:d79a:: with SMTP id s26mr4851319edq.251.1602775896953; 
 Thu, 15 Oct 2020 08:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201015151829.14656-1-peter.maydell@linaro.org>
 <20201015151829.14656-3-peter.maydell@linaro.org>
In-Reply-To: <20201015151829.14656-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2020 16:31:25 +0100
Message-ID: <CAFEAcA-4qq=kknVKck_tGdFaj6F8QP9MCOiqvydLcs4F+tmffA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/timer/armv7m_systick: Rewrite to use ptimers
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 16:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The armv7m systick timer is a 24-bit decrementing, wrap-on-zero,
> clear-on-write counter. Our current implementation has various
> bugs and dubious workarounds in it (for instance see
> https://bugs.launchpad.net/qemu/+bug/1872237).

...and 10 minutes after sending this I realized I'd forgotten
to finish removing the no-longer-needed state struct fields.
This should be squashed in:

diff --git a/include/hw/timer/armv7m_systick.h
b/include/hw/timer/armv7m_systick.h
index 84496faaf96..d57e299fd89 100644
--- a/include/hw/timer/armv7m_systick.h
+++ b/include/hw/timer/armv7m_systick.h
@@ -26,8 +26,6 @@ struct SysTickState {
     /*< public >*/

     uint32_t control;
-    uint32_t reload;
-    int64_t tick;
     ptimer_state *ptimer;
     MemoryRegion iomem;
     qemu_irq irq;
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index 2f192011eb0..5ac3a8a7e81 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -219,7 +219,6 @@ static const VMStateDescription vmstate_systick = {
     .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(control, SysTickState),
-        VMSTATE_INT64(tick, SysTickState),
         VMSTATE_PTIMER(ptimer, SysTickState),
         VMSTATE_END_OF_LIST()
     }

thanks
-- PMM

