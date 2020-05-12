Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50734C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF0D206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuTW6FUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF0D206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVkj-0007AE-Bk
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVjZ-0005mN-MZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:18:13 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVjY-0002yF-RT
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:18:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id a68so2095821otb.10
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uIO8tRfE4zB4VikXgUxYGBnO/90Xv49ZAf/QsuPrmqs=;
 b=FuTW6FUgXwN4HC+IwLEHD7PPGa5W4CLH5j3JUWlwr4cIfOvOdbovh43WSxmonN7FCm
 FapZ9Hbb3onr+bSkilXum0OZcFL5MiWdzhyK6AoGO05HXprOVgG1qc2LkHnwDEMRSzmo
 HUBo8yzO6lHfhI/jZ6zmGx2PSDwPVLqfYPEfMyxjTVNuSi5Nacqv9tQAX+GjneDVMQH6
 bC6hG6hPtIhx1itVhewk9BjWY8FkuWB+OdQy2I1Fii6gRE2AVyopfSkG5TvSH8JkOwmM
 5ZezFfQr5227i9ieVryQWGxWRYKL4zbrQThq+AvF/7YM9543bgbmZTBmCIotIaim42JR
 rkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uIO8tRfE4zB4VikXgUxYGBnO/90Xv49ZAf/QsuPrmqs=;
 b=HIcwPuE1YA6HyA14nRdlfIedztb2N98m7XsvDHb1Ikk5UThiJDkE4Yj4S+tou7aYp2
 G8gAvIb0ULnScit1vHyn/DxYF+csWuak/2vIKK2/hA2hNhlPEt+DFQG4FhrbIbSWcrNP
 AHfVG+LOpNAyg1Hjucez21VZHsyhts7QQk8bl6WjwIsNARqau/8fmvENnZc8gH7fLN7q
 16r4EM4UDIToJsjeM/jXEpD8al31LlcYxv6PxRlLlhJ6Sa0OQ0ilq4eY4REMt2VGYks9
 bTazk+xH+bMcxqPHZJLpB3npy6VH8eTUpU4IleGPQGEIK+b+LZdQ/LXoailZao/5yBDd
 aSVQ==
X-Gm-Message-State: AGi0PuaMgBtxojW1AR5+vRt6Z9AcI0XEs5A5J2QUJ5vvClkXxhPv3umT
 79QxVMmE5kYmBhpxwEEX4KI0yiE/p1FYPnH/FxFEBQ==
X-Google-Smtp-Source: APiQypJT8Ug58JbyDI3kwDOej/kvMkITDgsuhnL7xZ+aJKoCzwMUVDR41PQaOmguFf35FeCbp6TssM6t3sdKYl8+y5Y=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr16020715otc.221.1589293091518; 
 Tue, 12 May 2020 07:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-11-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 15:18:00 +0100
Message-ID: <CAFEAcA-tKUG_poHdkgnsQBGcknNoJTOB4+Er785EW8vKi_q=kw@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] target/arm: Create gen_gvec_{uqadd, sqadd, uqsub,
 sqsub}
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a functional interface for the vector expansion.
> This fits better with the existing set of helpers that
> we provide for other operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

