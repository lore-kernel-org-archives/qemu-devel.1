Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6600AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D78420709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKxRkyAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D78420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZht4-0002cM-9e
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZhps-00078p-9h
 for qemu-devel@nongnu.org; Fri, 15 May 2020 17:25:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZhpq-0007tc-0w
 for qemu-devel@nongnu.org; Fri, 15 May 2020 17:25:39 -0400
Received: by mail-oi1-x243.google.com with SMTP id x7so3537429oic.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dqC1gW7Ev9zXaqHiZqDoUVI45PdxTDsiQZAOzL+z+FY=;
 b=QKxRkyAk6KNc+l73aZhIXWwZhWwhtQVnwfpR88ZOeeYs0izMBAHQ/VPD456Mml3bj5
 4hXm46VNBJiFiJAz1vmxo/LuQnzG5AhEX3Sdp+w9XWk6sH6zOt9UNPvFWlecwqGDXl19
 XycRmeNJhd6wnnN3EJZUD7KbpCHW153vhPzdun+lmLVqh3V3GllvU1fFsKl8hctdlNKV
 xBBCTUEmNKWltf80TRP0uGZ3/rdYbY49Hra4OQ+nlHAvJ8uSiQjdvHRyXe9PR94l6sJV
 4Jgrs6BAe+rtt4PY7cLI0jH2ZqacoCWiMAp0Ptj3N6W5ZZW2PPvCAa4NuOBo3mAmfbK8
 hQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dqC1gW7Ev9zXaqHiZqDoUVI45PdxTDsiQZAOzL+z+FY=;
 b=cjHRvcu3NiXKJ62fNSy8Tof5FTFgwpjXI549O7ZebPPvAz0JzXOQsIqcutQfWkEWhy
 TWK4Y9ckYUlEg2KB3zP3CRjSp4PpbLts8y/BpaBFjmyc+eiAjUFPaCVNk6IiOmf6ZYC0
 Sh3Mfn2DKnLmttfaGH7igfUoNqZJ3pPGR7L2xzP1FTZeFPfnWyhMFQMjZ3sCBx4Jq3gT
 1K3IEtGE6w/n/5dx5dTc8qEQLW9evJr2zeMGN3/oBiWKrXVbqjto/RDQ22bn1z61z7Ln
 dy6fbLqJUBhJMntAEZO9UxZnqpx71telFrqGpGFffzInZExaS/tfaKlHf/cPCC8VeoZ8
 xvyQ==
X-Gm-Message-State: AOAM5336v+UTAL8BdUzskdfQU2rnfrTdgKqD6l41p9olpFWa8YNyEPzo
 yz/kkJi7fjoVYse3FZuXI3L4tp2zHe1iDba+DT/9XA==
X-Google-Smtp-Source: ABdhPJwjmNW5hYgOdntldIsNvi4HFphoUa2AMavLjeB0Fy9AdUS1Jr4w/OL1/Fznx8Z5DzYOCdsnsLsRYa2CfSnbNOw=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr3346053oih.48.1589577934092; 
 Fri, 15 May 2020 14:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200507202429.1643202-1-amanieu@gmail.com>
 <CAFEAcA-n8-pOcwovsS1Z3T4AMa1Nueo2yik9zX5H16QAHeE05A@mail.gmail.com>
 <CA+y5pbSueV8HQKQEZnBS4DvOvMDXUY7HMaODNhY7v-fKkJJPYw@mail.gmail.com>
In-Reply-To: <CA+y5pbSueV8HQKQEZnBS4DvOvMDXUY7HMaODNhY7v-fKkJJPYw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 22:25:22 +0100
Message-ID: <CAFEAcA8etD+V3KrCFwvqfDuZ0x4_cW-RN423WG13iVpJBRvq4g@mail.gmail.com>
Subject: Re: [PATCH] linux-user/arm: Reset CPSR_E when entering a signal
 handler
To: "Amanieu d'Antras" <amanieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 at 21:41, Amanieu d'Antras <amanieu@gmail.com> wrote:
> On Fri, May 15, 2020 at 7:34 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > I was just looking at the signal code's handling of CPSR for a different
> > reason, and I noticed that at the moment we don't allow CPSR.E to be
> > updated from the signal frame when the signal handler returns
> > (because CPSR_USER doesn't contain CPSR_E and that's what we
> > use in restore_sigcontext() to define what bits from the frame we
> > allow updating). Don't you find that when the interrupted code
> > returns from the signal handler that it ends up running with the
> > wrong endianness (ie the endianness the handler used) ?
>
> I actually found this while trying to test the SETEND instruction
> under risu. The signal handler was crashing because it loaded a
> pointer with the wrong endianness, which was pretty obvious. However I
> missed the fact that code was now running with the wrong endianness
> after returning from the signal handler since I had both the master
> and the apprentice running under qemu-arm.
>
> > I'm going to fix this by putting CPSR_E in CPSR_USER, anyway.
>
> You also need to call arm_rebuild_hflags() after modifying CPSR_E
> otherwise the change doesn't take effect.

Hmm. I was expecting cpsr_write() to take care of that if we
updated a cpsr flag that was in the hflags, but it looks like
the rebuild_hflags() is in the HELPER() wrapper but not in
cpsr_write() itself. Richard, does anything go wrong if
cpsr_write() proper does the hflags rebuild ?

thanks
-- PMM

