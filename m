Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B106C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D4920718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqdCKRBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D4920718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqCm-00023I-U6
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibqBz-0001OO-1k
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibqBx-0003SN-TS
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:13:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibqBx-0003SF-OK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:13:01 -0500
Received: by mail-ot1-x343.google.com with SMTP id g18so278257otj.13
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q0xCx7uBW7RnFZp2fYdgddjrgqtvR0xZKFC397jatao=;
 b=mqdCKRBL4LeS089VRgIdzhvO8AS712WeVkOisGm/UNkw0z+351UWgrWnRBRQpJAJzX
 dEBkCX8KymTGbb+TT+1FEv4/ZYjZKaAxqDHXG6ZqVi2VQAeXCviBCg1tPN5Fp4svicFZ
 LfHcdvE+DXSjItGRbn/vvGTo509GiToS99vXO8968Y4ygox9yFSFvddJdi1xyuP6bXoh
 GbqiC0RznxtVGgQamy14za6+zyQTpXZn6pqf+/b/LcyE7GQZ6Qfr8K0iJ/HrwbNznH7Z
 jKpOfbSjLMkGZm43cRbdalaSmanxAuUxdPK2DzAsPkEYXWhZ+mlfTUyuRrZKCd2ylXKr
 HsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q0xCx7uBW7RnFZp2fYdgddjrgqtvR0xZKFC397jatao=;
 b=fE03VmnwEgS5dnCC0SsXyFeOEZhQdccjPvxG8zc9mtyhvlzparcrL/6b57yIl8Q3pY
 1USA4J1wl38AGYwCdOfECish6muOZbpO9fFlZou5ECXlbm5ojBoChLkgaHYMf7qt3Guj
 yGbcKgGwi5+NdNlCGTQQcnyHhBrQ0HDBzRx4Lgtz6bN+YFRDwNQPwJhwcgKO4VGrFHlR
 0T2lmcE+48ZSCVfUjWlKqxPhTX0tAuc9NabZxkEnQR5JSC5MU37D7Gc8NiqTKFJDFfPo
 X8SGNXsCf78BndUUHrDk6zHWuvTNuJZHyCjsdYr7fT/Aa/rGX0U29lHkEnqNvgO9dPJ5
 Y/Kg==
X-Gm-Message-State: APjAAAUkjAosnR6tHktQrpcI/VHJa0jJQ+l6R6L8wq8yYGF9AtBVgN82
 NsvdsMUJr8Qbwv9SBCDBmTBUUg4d2WoTDuafW0nmug==
X-Google-Smtp-Source: APXvYqwzU4Bmum6RYOKftwT6nG3fCLyxJDE0kESwp8ZWz2HydjQoRDT0uFGHYsCVI17Zj2vBckX9wy8113DS2wcy2Ao=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr272507otk.91.1575310380586;
 Mon, 02 Dec 2019 10:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20191128054527.25450-1-andrew@aj.id.au>
 <20191128054527.25450-3-andrew@aj.id.au>
In-Reply-To: <20191128054527.25450-3-andrew@aj.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 18:12:49 +0000
Message-ID: <CAFEAcA99yzysf0J=n1yYgtxBmBDvi8-=CrCO6kdymt8Woo9t1Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: Abstract the generic timer frequency
To: Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 at 05:44, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Prepare for SoCs such as the ASPEED AST2600 whose firmware configures
> CNTFRQ to values significantly larger than the static 62.5MHz value
> currently derived from GTIMER_SCALE. As the OS potentially derives its
> timer periods from the CNTFRQ value the lack of support for running
> QEMUTimers at the appropriate rate leads to sticky behaviour in the
> guest.
>
> Substitute the GTIMER_SCALE constant with use of a helper to derive the
> period from gt_cntfrq stored in struct ARMCPU. Initially set gt_cntfrq
> to the frequency associated with GTIMER_SCALE so current behaviour is
> maintained.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

> +static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> +{
> +    /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECOND? */
> +    const unsigned int ns_per_s = 1000 * 1000 * 1000;
> +    return ns_per_s > cpu->gt_cntfrq ? ns_per_s / cpu->gt_cntfrq : 1;
> +}

This function is named gt_cntfrq_period_ns()...

>  static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> +    ARMCPU *cpu = env_archcpu(env);
> +
>      /* Currently we have no support for QEMUTimer in linux-user so we
>       * can't call gt_get_countervalue(env), instead we directly
>       * call the lower level functions.
>       */
> -    return cpu_get_clock() / GTIMER_SCALE;
> +    return cpu_get_clock() / gt_cntfrq_period(cpu);
>  }

...but here we call gt_cntfrq_period(), which doesn't exist,
and indeed at least one of the patchew build systems reported
it as a compile failure.

thanks
-- PMM

