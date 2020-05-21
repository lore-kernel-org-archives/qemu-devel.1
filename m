Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D460A20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYlFcPyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D460A20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbsNk-0003uz-VV
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 17:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbsN2-0003KH-Ti
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:04:52 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:35414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbsN1-0004Sa-Rd
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:04:52 -0400
Received: by mail-ot1-x32d.google.com with SMTP id 69so6665810otv.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7hifb8PmkKRhDKxepruN3fw5LA2aolqacfPAZ9386uQ=;
 b=AYlFcPyqj95apJ+QetnwczbReuhj0lm5vuYhOlAcMerd1VNiHYOr7bVlb+WPFgsvmz
 foDgXQN/sSGLpeZpakpDWGGaQXsqRGkdjmbRgX0XutPnLlmxx86pLJO4r82cqsGXzWTs
 xdFKckSbjAvufDGv27IN5X8YKcMiN04m26YGPq9wugYe6otqz2kgaR0t1daleapgvRXU
 5bpshJr9TVpIpr+vU3Ni/3T09sHslLCHg0q2BUyIfZ70XYRqQk5a6kCJ13hvZlw/l4Ib
 Nr6p9qguqauIvXu8hIeukaFjlzf0G3oVqBOict4nuNpIE3hhwodXI1tBfjIBkY3wOCUq
 RQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7hifb8PmkKRhDKxepruN3fw5LA2aolqacfPAZ9386uQ=;
 b=sB6LfCkZg5F1oX67V415mOMfSGMVXMVrVvC1n+LDENGQiICxZU0dL/P4M758e+NTWn
 MZbyXMgHW9vV1styQoNZn4DtJFbk2eRUPmtuFwIEXEpIHg8j6o219XVCcsVouOjqTdjK
 XHso+zBgKreJTBMYK2BYwUZZSK4AqBpc59WCclcQwwZhflRmo48nykOqMV2+UqdZmkmY
 1KdPX/QcK1yMvQawvGFYek2uGajzV/AhrRygm8ugr2hbt2L2RhaNoGuQ+2ORn2T7MRy3
 vHeRcT4wBUXcr2Vkz1HXJxIKqAfxsPWD6yiFMqW/IF7NfObY1FbHOqHFqD9avYCdnxFs
 pdaA==
X-Gm-Message-State: AOAM530lZqntwhG9dQTSRwpAqFcs5wYkANT/G684MGwR9c7SZjd/MqbD
 ffrb5XmiMNNmo4Cpy6HVOXkRsh3lwp46WHOZtZ9k4w==
X-Google-Smtp-Source: ABdhPJz1iBMRqTbjiGqUmjIatvIGqyqBmImqeFfxp9ukDpS+Utm4O1vt5RivU457WcveAbZ9JRhTQkF5nf4iQ8W6qj0=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr8461972otb.91.1590095089817; 
 Thu, 21 May 2020 14:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200517162135.110364-1-linux@roeck-us.net>
 <20200517162135.110364-3-linux@roeck-us.net>
In-Reply-To: <20200517162135.110364-3-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 22:04:38 +0100
Message-ID: <CAFEAcA8DfoR3EUHn2J4D8BNR9Ms27R-uR7q7BnXuwOFFbGgZdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] hw/watchdog: Implement full i.MX watchdog support
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32d.google.com
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 17 May 2020 at 17:21, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Implement full support for the watchdog in i.MX systems.
> Pretimeout support is optional because the watchdog hardware
> on i.MX31 does not support pretimeouts.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

> +static Property imx2_wdt_properties[] = {
> +    DEFINE_PROP_BOOL("pretimeout-support", IMX2WdtState, pretimeout_support,
> +                     false),
> +};

This Property array is missing the DEFINE_PROP_END_OF_LIST()
terminator entry, which makes QEMU crash on startup on
various host architectures but not x86-64, presumably by
random luck meaning there's some zeros after it there.

I'm going to fix up the version of this commit in my tree.

thanks
-- PMM

