Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B04C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8738321D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wtv8ZrF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8738321D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUt8T-0008P4-Eg
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUt6m-0007et-6R
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:59:28 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUt6k-0004ZZ-CQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:59:27 -0400
Received: by mail-ej1-x643.google.com with SMTP id qp15so3212043ejb.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7bkquVpcEoY4NqgXc3bLKM+R+Z+x8Z9TEoN7lITSYec=;
 b=Wtv8ZrF2lwHUaqWYCidG6l9VKHHZXbuD6WHEtoXMw2gbonZbvEgCpl3nkBrEfm3dPp
 IW61Y0BIZyOruefASV2QiKnc5ULC3HcnF8UOKQSNyTi+jS/mJyR6a9J8Z5uQtYcfkKvD
 v2EIBI5QQJin5CuYIQCywQopnE5ayB0g9CrhmeBsCxlnWIuHW0dBQzaLqWakRCCCmUja
 NNZ5SHICQaV1QpqWFGuDSg5I2EKKs715aBVUVt0YbMyko9lzU6kC1T5Tg/A7kMi+/8uL
 BUrHB/aGbjvu1iP0Cgs+pyOKyCvroyi1Xezo3s8PKHI0V6WqxEMFwqHNTI0DZGiKPjhS
 ulcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7bkquVpcEoY4NqgXc3bLKM+R+Z+x8Z9TEoN7lITSYec=;
 b=Y6v4zHQ44rXQlogIabvC9WactdZnOCai+Z/xVK68AaUfNXKi8GS9CwMQKo8wZV7SI3
 sORPuI2mp5oHuy2MkER+IZ5+8nP9WTfoog0zwPYRTNd9GSLqlABW+ts968YaBVROeLGP
 TfFgzPf4dv7hI7d/rkAoZs1hHnYdV29+tLXJVxfD3/rGvg3jBc8OTA4OmPzis3PWMZ2w
 /ufMy0CgP2K4SSmEIhuPQ3nitaFHmMlNSRvn6OTaJUqRHb/Ws9LR29GdSCLEu3LCAqqC
 BgUmpNRiDEf02O+KOBDago+ZOWrYrlaxxZ2la/UO2MvKdN2kjaU83nsbt76QJVTwgvhF
 MfDw==
X-Gm-Message-State: AOAM532bUJsnm1AMuOm50msr5KZBfb3EvHmWL0kZRgJt5cjpaUw2/f+O
 p9y0tbk+4M5fAwDgro/I9fPYSrFK4cr+3W6RaD8FRg==
X-Google-Smtp-Source: ABdhPJwiIWP4ZgP7rw2DvquwHSxNsrNS//2UKedOwf510yYoamEB8jw+BsyXTF7pZvQflUu6FcOQ7tXdpSCDmDX+XLo=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr3537819ejb.482.1603205964676; 
 Tue, 20 Oct 2020 07:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201016184207.786698-1-richard.henderson@linaro.org>
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 15:59:13 +0100
Message-ID: <CAFEAcA9PAz0_r0HGqgcmXmFnB_of6f2X_QA4M=yV5WmoonFYbQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/12] linux-user: User support for AArch64 BTI
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Oct 2020 at 19:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The kernel abi for this was merged in v5.8, just as the qemu 5.1
> merge window was closing, so this slipped to the next dev cycle.
>
> Changes from v10:
>   * Include Phil's plug of interp_name memory leak.
>   * Convert error reporting to Error api.
>   * Mirror the kernel's code structure for parsing notes
>     (though Error means that it's not exactly the same).
>   * Split aarch64 stuff from basic note parsing patch.
>
> Changes from v9:
>   * Split what is now patch 7 into 3 more (pmm).
>   * All prerequisites are now upstream.
>



Applied to target-arm.next, thanks.

-- PMM

