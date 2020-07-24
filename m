Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F7C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5261B2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQUEtDct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5261B2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxfr-0007GF-Jd
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyxfI-0006mK-Qp
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:23:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyxfH-0000bl-93
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:23:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id a21so6940870otq.8
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JY60+F52pOqNfLuF34BgNU+gRkLt9509QBB3kMGyn6U=;
 b=PQUEtDcteJeHlqxdhRk0Q3cn+qJZyYTfj7XE6QJPCDD9DyM1dhXlaoS2mn4kcxLViT
 35soJRqLu+yJoLzZAdZs2A3qc5q8zaqvZJhih220xrF/x36wzXgfr7DvbgKth1P0s1N1
 itiusyovNUWRsVT7RAmCaG0DlFzpE8PIKY2NQfjtU+t7MY0rYWwlqV1T03oR60PhTvGg
 Q0dVWwYpz4SfhfgjOjfRPAPzkLgAGs+bEGpf99YmrCfXbFNqmlZydkI9NwYzNOwWHA0w
 hqFrG6DEbpsI+FwDkN0thxZpTDUDxZ2saiJblSfgWfZtqsXEJs7CI2oXUUwOfw12L9y+
 ID0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JY60+F52pOqNfLuF34BgNU+gRkLt9509QBB3kMGyn6U=;
 b=GjBj4b4L6j3QRMrMHcZ3XlCuwFZQBphIemf6gzF9Z/37PK6UwffhKkJ2kw3yv8nQle
 oT9Ef02xpE0vkqEP3t4Qvj2w0aJXKIp5XbLP1KRUBX+LCGSxLzjsItFftS8BcH4KDlzd
 TfGLqYYzf46/hJoq+DPiIxrCuR9uJ0LPE/XcRNjjxdTpq/T6LuYvBaRv4lcs5NBY4NjI
 jIIsxImPFf9Ylz7MKrNebp4XzBW487oq1Pu83naMJ5Lo/PVUNSMKwlUFweRj9pEoZdOC
 cC7TWpZ+JLD65hdPggjQx+LswnX29Ba1MiucY3drMAmtL0aBpMU74ItJicmoEA7Ky6vy
 AF9Q==
X-Gm-Message-State: AOAM531Ud7HXfolDGYWlrduk8HFv5jVTkaPM6MKE9EJtSC/jovRacDBY
 1QeU4XYyIEbtv3bspDBGGMI30UN4fxyBzjGf7FLyLT7A
X-Google-Smtp-Source: ABdhPJxonBpM7KanU5mTL1qJvUwwlBBj2qgRk1+vPUsPuYotyeQKVDaNXLwmn3X5HjYy53WavseIjTUszlyhrsvkp3c=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr8984206oto.135.1595596986174; 
 Fri, 24 Jul 2020 06:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200721163528.80080-1-richard.henderson@linaro.org>
In-Reply-To: <20200721163528.80080-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2020 14:22:55 +0100
Message-ID: <CAFEAcA-K6jb9Zxq30iXB=OtcCWBJEZbZAu0iw=ftxewje_g3hw@mail.gmail.com>
Subject: Re: [PATCH for-5.1] target/arm: Always pass cacheattr in
 S1_ptw_translate
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 17:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When we changed the interface of get_phys_addr_lpae to require
> the cacheattr parameter, this spot was missed.  The compiler is
> unable to detect the use of NULL vs the nonnull attribute here.
>
> Fixes: 7e98e21c098
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

