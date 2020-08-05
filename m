Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D89C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAEB22DA9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRNgneoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAEB22DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3MM2-0001QD-Te
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3MLM-0000tI-09
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:32:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3MLJ-0002aK-6H
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:32:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id a65so24651163otc.8
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wsQxH89XzZQOtnF97UVCoY2SF9sHY7PsuDgF0KNX6xc=;
 b=ZRNgneoKd3dPzxRqHd8Ygn8wZghci/+w9SYcENWHOQ9cX0yyvFBUto9APG/WOuTIn3
 zeUm6kFS6q0kyMUCYTSs3d90GerMzVTKABwmwzFqy0X0WUN5ed5kXfQYZklcMuX8Bx/K
 FBFsjeCJeM9zPRW6AeTA2Ha4a8frTBxIbPgozgbT5eo6xONgwTZ8v0zS/fckomsKbKHr
 2fClisuQok4qbXrGc0HRzjiFfDM8LcsuFiCUULI+0FS6/I+qJuaTf4xoS0RN8vkuBIb8
 tu4fkhjbcuESS1Gyzw1hvD2kF1ayq+JddmuB78ZTtKlfufy0a9A69jcNDCDXd45lxntM
 C3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wsQxH89XzZQOtnF97UVCoY2SF9sHY7PsuDgF0KNX6xc=;
 b=dsgyK6DU5n/FEG/PitfCcXgYShSpLt4UlHUuXkIqiTa0MbuhUksDg2PsKGuGrr31Rw
 Nn1IPAM4Y7mYkCD5pEkDd1IRbCco0MWOJb3Gih8JYR9nkz+VyM8OhCz4h+SBEI32OnjY
 Q0cVsTgYSYB8M9bTVl7V5+WP/+imXyGinL0H8TFRUFHj8DBLA4CAmGFbLAIge7PwS3sG
 4rEpJfvt4RK/00n2rQfU23dFaqYfb6HnaMdHACrROiAp9Yn3HVVD1pC2FzK6tfHJbYv/
 Q+7G1EXWZ0qFesyJB+rW/TIP3HTMrDcvYoLxhvrQOHe2rb/l7NO/hBibSHzKENFBFyjO
 MedQ==
X-Gm-Message-State: AOAM530E7Qa/DFjplfTfvcvZCdsYs8Bdq0X+O8iwDbuAYDfIyM3Kmg/S
 sSz6TkzCKxHg1ony2QuQeXQX+sZ12d4pYnZ7kWMFgA==
X-Google-Smtp-Source: ABdhPJwAimqLyHIOhboafh5FS6nYV8IGNVJc7/1693Ga6h/1GqrJupP+bCBpkU61Npr8mcBD49N/Jwhi8g41y4Bd3Ss=
X-Received: by 2002:a9d:5504:: with SMTP id l4mr3251509oth.221.1596645159741; 
 Wed, 05 Aug 2020 09:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200804193903.31240-1-peter.maydell@linaro.org>
 <e710d6bb-564d-88bb-aa60-894ddc1280c8@linaro.org>
In-Reply-To: <e710d6bb-564d-88bb-aa60-894ddc1280c8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Aug 2020 17:32:28 +0100
Message-ID: <CAFEAcA8bfQucS=0OJRCOvhZdef_d+TUJEyjgYHAx3A7sHMWhSQ@mail.gmail.com>
Subject: Re: [PATCH v2 for-5.1?] target/arm: Fix Rt/Rt2 in ESR_ELx for copro
 traps from AArch32 to 64
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Julien Freche <julien@bedrocksystems.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 16:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/4/20 12:39 PM, Peter Maydell wrote:
> > When a coprocessor instruction in an  AArch32 guest traps to AArch32
> > Hyp mode, the syndrome register (HSR) includes Rt and Rt2 fields
> > which are simply copies of the Rt and Rt2 fields from the trapped
> > instruction.  However, if the instruction is trapped from AArch32 to
> > an AArch64 higher exception level, the Rt and Rt2 fields in the
> > syndrome register (ESR_ELx) must be the AArch64 view of the register.
> > This makes a difference if the AArch32 guest was in a mode other than
> > User or System and it was using r13 or r14, or if it was in FIQ mode
> > and using r8-r14.
> >
> > We don't know at translate time which AArch32 CPU mode we are in, so
> > we leave the values we generate in our prototype syndrome register
> > value at translate time as the raw Rt/Rt2 from the instruction, and
> > instead correct them to the AArch64 view when we find we need to take
> > an exception from AArch32 to AArch64 with one of these syndrome
> > values.
> >
> > Fixes: https://bugs.launchpad.net/qemu/+bug/1879587
> > Reported-by: Julien Freche <julien@bedrocksystems.com>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; applied to master for 5.1.

-- PMM

