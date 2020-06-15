Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6007620739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urf/oB7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6007620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuRJ-00061v-H3
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkuQi-0005Ty-EH
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:06:00 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:44079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkuQg-00014t-SF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:06:00 -0400
Received: by mail-oo1-xc44.google.com with SMTP id e8so3581669ooi.11
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZAdswY5amJWhmX3F06zGanzSHKfw/TKNeBtcyCLxD1E=;
 b=urf/oB7fdLbwEphFndqtgnPZmxj4DkMdKuZMOzEGNpSWC/jy/+Hlp5Q/WXzQaN84Vw
 fOn7jPN+Iym4tL0y/pAcFrgn7irOOf2vRdKqIQhz/gPyFS4K9m5UTggqHT317p+u4Qzh
 tyu/HA5XG5uar/yEUKPm22V18As7BMiGFw885vsg+OOi/lNtVzlESmV0VufCibLQpCA5
 iaC1a5xg/KMaagzLD0N0uRklgsuqosvcxW/S99fZF5bXjmcILTWnmWvz1oxh2aT15KCx
 iO6ShPN97T4AIoxP0pScbe/pHqrrheeSmvoRcxU+Ihet8iUq0k6xUI851BBKdnNBP2OY
 cUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZAdswY5amJWhmX3F06zGanzSHKfw/TKNeBtcyCLxD1E=;
 b=cS6jwQhA5F55C6N8Td04ERTUB2MTnIVsNCUCpShR/VNjmIzPHa34R+qY4oO256tHA5
 b7L7JMWlH+s1CPUsc4BqVqlXKWVxs6rVElcbfZqNuvEzikioP9Z7GD3iY3n0MGLYOGSG
 C016Hqid6wyYRWiYLANpKpW6pzimT5J7UIQE//UcktRRhiAKV6aEFOQhfipt3tc72edn
 8nkXFOcw2Va5Tbu+hfxKI80ALW9J9A/tznk0m5IAKMGmk52JakxH7kfQ/1oSSG7NFmCb
 TXiNne02pFFLpymFylzEcT4u/f3zjcoY8ECK7q1uLvGtCg7btA1xe9g4fFkFR/DFWbp0
 EUCQ==
X-Gm-Message-State: AOAM533vX2FnQScjkUYevWj9TqgBNieEEPWHj1/nXaHczHhUbNh3+n2i
 LCjuiBQ5Gql6jhduO0ermD0IyzfOsB8RRSywN4H7og==
X-Google-Smtp-Source: ABdhPJxnresFssK/GQ94zsxaMyZR/UWBtmzAps05iao8afGypdsCFwGFVIWCl3EA9ETgzjqvLf1XDqJji8m+aSAeAt8=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr22302181ooi.85.1592247957594; 
 Mon, 15 Jun 2020 12:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqyzW=ah4Q=OCE9KP6DYpiQN18oQpVWjqFCvzQfH3MvQFA@mail.gmail.com>
In-Reply-To: <CA+XhMqyzW=ah4Q=OCE9KP6DYpiQN18oQpVWjqFCvzQfH3MvQFA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 20:05:46 +0100
Message-ID: <CAFEAcA_e_0rFWGU2VtN3270sUhssHwe0eEgqb-U2Qq-HQKGLWA@mail.gmail.com>
Subject: Re: [PATCH v3] util/oslib-posix: : qemu_init_exec_dir implementation
 for Mac
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 at 18:06, David CARLIER <devnexen@gmail.com> wrote:
>
> From dfa1e900dd950f4d3fca17fbf5d3dfb5725c83fa Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Tue, 26 May 2020 21:35:27 +0100
> Subject: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for Mac
>
> Using dyld API to get the full path of the current process.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>

> +#elif defined(__APPLE__)
> +    {
> +        uint32_t len = (uint32_t)sizeof(buf);

Why do we need the cast?

> +        if (_NSGetExecutablePath(buf, &len) == 0) {
> +            buf[len - 1] = 0;
> +            p = buf;
> +        }
> +    }

What does this return if you start QEMU with a relative
path (eg "./qemu-system-x86_64") ?  The documentation
suggests that you need to call realpath() to resolve that kind
of relative path.

Did you try the test I suggested with checking that this
actually does return something different from argv[0] ?

thanks
-- PMM

