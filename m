Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84462C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 13:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4953B20C56
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 13:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYopsqdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4953B20C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC1J0-0008Vs-Gn
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 09:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kC1IH-0007eX-1U
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 09:53:21 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kC1IF-0003Eu-Lz
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 09:53:20 -0400
Received: by mail-ed1-x541.google.com with SMTP id q4so1593706eds.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6X2MaBJ21+Alc6ewEhKXjcC4MPw0rJP61ITVoGTwtgw=;
 b=NYopsqdApAaWgO6PWSUHCdlZlE+1KKRrbraTStJBPx88LtRij+ppawAONSQXPUjdvt
 dW4uozf2S7AQIeTkiWYlUOl7tPFq7OaBU3L4wi1aWWzbnIbt+qh73qpOrI0PEOsmbEe/
 RsSumMpbz6m5O3bIPt8k/t6bacX2Pzd5CiqSe8dxBC3Svs8Efgp7BCAyIkS8WsSRdwHB
 xnEaM9E7xw7xC0H5+2HzI04X7j74tBikW5lQK3DJm2D3M0zGpfKdozKkyONtZDOTylXn
 w6b1CwlZPoM/szHtYhpNlSBeq1M9fd3G3uudyIJb7M4M5pE8RS10OHLLo+hFoqkU4zw5
 CWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6X2MaBJ21+Alc6ewEhKXjcC4MPw0rJP61ITVoGTwtgw=;
 b=aDSJNk0XT7U1Noy/zc9/5ewy1kxFsGoGcN4WlyYM7XoJL+pDtdxuhSQXVTJ1EPZo5t
 nqvLGWzHcmJnTF0sipWubUB6Am03PqefdKKUaOLJXfHWC5nMYiWQj7E6o3bK+hnWu5KL
 ixnGDl+fMVihwotKDgdMc1WP2qrxJ1scO1o9RL/lm9lRFt88o6hmxx0SmvlByX7X5mvv
 fsY9W8sH6LbcPsrO4q933+cT/PhaxgoUCDc2J+pVKKIfOniifYylweTd204bH2bIM8TJ
 nfEbqkhWGqIXrdbjA59+ttFzJGeM5luU7QfVdCfseF+8m9VtreQRhH8RQY3euGzoe5oa
 c9Gw==
X-Gm-Message-State: AOAM530gLevpurKKetqmVmYp3uIzM4kFmhym07Li4hM+IMTU7jPmXs81
 ih0YNuxUg5RmZ479ZAPsYWufTmwF6YvQcT+7BfqVGw==
X-Google-Smtp-Source: ABdhPJwz+wNke6N9+VK/Xf3dZKWrE8BA/exm+fWWh6IatUFcLmPc5Ru072PQH+YV+wtUSTdsw2wcDuZOLHv0lrM6Hao=
X-Received: by 2002:a50:da44:: with SMTP id a4mr3619638edk.36.1598709198143;
 Sat, 29 Aug 2020 06:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-25-peter.maydell@linaro.org>
 <55675521-a61c-186c-599f-7373e9165184@linaro.org>
 <CAFEAcA87JLog+Ly5wvRi2bOvwDvFVL5mjpnkeB3h+pckbnNMmQ@mail.gmail.com>
 <2007993d-9f64-dca5-5fd9-510c87cd8e86@linaro.org>
In-Reply-To: <2007993d-9f64-dca5-5fd9-510c87cd8e86@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Aug 2020 14:53:07 +0100
Message-ID: <CAFEAcA8cEF4s8E5k=eKs8u3hRqWKDgSwe5yA+c+uVXnCt4ixBg@mail.gmail.com>
Subject: Re: [PATCH v2 24/45] target/arm: Implement fp16 for Neon VRECPE,
 VRSQRTE using gvec
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Aug 2020 at 23:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/28/20 2:40 PM, Peter Maydell wrote:
> > The other approach would be to standardize on "the decodetree pattern
> > always converts the size to the data-type size, regardless of how
> > it's encoded in the insn fields", and then you could check against
> > MO_16 here. Would that be better ?
>
> That might be clearer, yes.  Otherwise it's hard to tell what "size" means
> without looking at the manual for each instance.

Do you mind if I do that as a separate patchset after this one?
I feel that will be easier than trying to weave the change into
this series...

-- PMM

