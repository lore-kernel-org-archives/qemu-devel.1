Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F068C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF055206DC
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onKjrx8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF055206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHobM-0003tj-0e
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHoa9-0003Ni-Kz
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:31:45 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHoa8-000182-0x
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:31:45 -0400
Received: by mail-ej1-x643.google.com with SMTP id j11so13404ejk.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J7X73hukbS/oronnoq/x6xfCgvSbC/nu1mAuH1pfZZg=;
 b=onKjrx8e4m8urnBvKrsvUpkH4ZdYRvWETWpQtYfG9SBA4M807KJpWp28Z4t5zXqI/4
 3NgQHsFObsT+CRRH8+UaiJGdrJg1umYjD8o74M8mWtp7GxI9p+JrmPuUH+BY/ax19YNs
 2sgnLrAjD8/xr8o+zQ+0uDAcjLhOmsodYNO9l2x4Gt9kMgnihF1XOAws76PVjOJRVN8i
 ORuqg2VOS+qa+gfWlykihLgbRpAYZrjbX7nWqySP1CgW0spVr1bP+ZSlMEfH+0Qz+qDP
 HLSsNfRBHsBaCyPAL2Kffo42Phac1WXPs+LoH0wR0rg6lam0OOYz21vk7GunEGQqIqWo
 EB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J7X73hukbS/oronnoq/x6xfCgvSbC/nu1mAuH1pfZZg=;
 b=aqneRqdfzxxLYe8clz7DLqx1MP4EAK9nWYHvZP6Ru9TipDeZR9qcqTLY0vbgKb6N/H
 BOFSkfjQ+CFlcvNX4wJcHU5bWJMHDQeF+MeE+zuwVaeFfn6w7tDXGFlMm0xpU9giBjZT
 t0eya7N0vKMdlUQnFHV/BvMTXnaFg4a1KGyTLVGSmyHRIouyQEz2QNBJHAt/kY2KywbL
 TzfwCvnveXB5Xe41vkF9UdAF1ZP8vQm20vUFuCEqERzMua+BaXRx39XqIlB82/2SX0ix
 j1mzUICcLgRp64875V5PvE4aF6YXYqQMvYzKebuUgEMbNnqsSQoxKvHNc8r5ph5Ov0kL
 SViw==
X-Gm-Message-State: AOAM533F6QsWItqNMUq8W7jF7LMidp4001DFK/h8e1tlLQpuWeTsd1eG
 Au72PLtTRT5VwNtVM8nygh4LlTpcm76D8Gw5s6lH2w==
X-Google-Smtp-Source: ABdhPJwB+2WZKYbcZTVWcUtkFm0nhEe4Hga39La4FzC4riM1egMXd3qj1vKL7w3Qc01YxoJgFhh82cwFRChEOoBrcvs=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr14047379ejb.382.1600090302413; 
 Mon, 14 Sep 2020 06:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
 <20200914000153.1725632-2-richard.henderson@linaro.org>
In-Reply-To: <20200914000153.1725632-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 14:31:31 +0100
Message-ID: <CAFEAcA9tEPx+CxHMk7p0n+Wt94J0G-daeknc=G6RDuGxbYtbgQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] capstone: Convert Makefile bits to meson bits
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 01:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There are better ways to do this, e.g. meson cmake subproject,
> but that requires cmake 3.7 and some of our CI environments
> only provide cmake 3.5.
>
> Nor can we add a meson.build file to capstone/, because the git
> submodule would then always report "untracked files".  Fixing that
> would require creating our own branch on the qemu git mirror, at
> which point we could just as easily create a native meson subproject.
>
> In leiu, build the library via the main meson.build.

"in lieu" (or you could just say "instead" :-))

thanks
-- PMM

