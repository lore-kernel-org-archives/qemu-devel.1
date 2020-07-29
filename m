Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B910C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082AF207F5
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAiPi74f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082AF207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0pri-0001Iz-B9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0pqw-0000sO-8e
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:26:54 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0pqu-0004JR-El
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:26:53 -0400
Received: by mail-pj1-x1041.google.com with SMTP id c6so2185732pje.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=am6nnQbLfL/llaSst+wCAdzlD0lYQ3PtpBlX5HMohsg=;
 b=SAiPi74f9Y5LjEXSHBkXYAfmSwtbjfN/IFyHpsq/bWJnOk0HMZEs0EhgToNTsJTNZz
 KGsPBzobkk+3Vc4AEGKHhJ6sbIktQIwpupQ0Ot/MDgbuBA28yVmtnYxZJeH61vqlLkYJ
 4RGSFbpSnHshNRVTSHVaAhXhw9VNw7/SSW3Q4JvynuyN+hpJw6QzN8w9lnde8pMF6aIh
 SXUQ7GUsYcxJpBdTGGW7Vljc3c8e4xhCN3MZX9Km089z9tl50FJO62Wql5ge8rMB72Gk
 PyFqFETSrj0bbJ+plwdeSwvGFFlzNCsY6WSge1D/CpacvFXtP3OEbUM3jebriHNbNNKA
 Fzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=am6nnQbLfL/llaSst+wCAdzlD0lYQ3PtpBlX5HMohsg=;
 b=RAOj/+he95aApW7ROF1WuBvIIxziXorLTRbm9WQc025gcEjYSFvBVWBbXzfbVeOOLL
 ICdDfOeF0LQWYEbub1HKO7esqp243C2adWcVm5fTgKuMI+yoIClX7li87YNRqHj9rNEj
 Ga5ivo+A//mEbbhqzhGe+hSTMM/LlFwTiEsePhgWq1L5ZsHFgcnM6+cThmmr5gg1oHjC
 znOMIRkmJ+98QYUOlLXhjJo/k4WRWBeQpe+7YtdDZ1ULOp9+Wz+RBNXtQg4mJrAwaN34
 Jm+xOPjdliCR3JEYjfu0FdQSAHO3lZbeZ1kUFcxyimirLKGtnxv/gkdfEHq7fLJBqELQ
 I0MQ==
X-Gm-Message-State: AOAM5309ZYZdal26icFLGvMbTZgUMr6riTCH1o/jgJ8kAqnHfSkuuKDE
 dJSnvPA4XeWS2LMVql3jpKBTUA==
X-Google-Smtp-Source: ABdhPJx7zCt5Iz2KruipSR5y4TrB/fP88Qj0YsJwAK0wleCNefcwUPcwd440NMxSZg5noPq40rQ0LQ==
X-Received: by 2002:a17:90b:3750:: with SMTP id
 ne16mr10713741pjb.6.1596043610724; 
 Wed, 29 Jul 2020 10:26:50 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w17sm3017398pge.10.2020.07.29.10.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 10:26:50 -0700 (PDT)
Subject: Re: [PATCH 4/4] hw/display/artist.c: fix out of bounds check
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200727214608.32710-1-deller@gmx.de>
 <20200727214608.32710-5-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <767c4e05-6018-7f99-4401-cbc1480c3d28@linaro.org>
Date: Wed, 29 Jul 2020 10:26:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727214608.32710-5-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 2:46 PM, Helge Deller wrote:
> -        for (i = 0; i < pix_count; i++) {
> +        for (i = 0; i < pix_count && offset + i < buf->size; i++) {
>              artist_rop8(s, p + offset + pix_count - 1 - i,
>                          (data & 1) ? (s->plane_mask >> 24) : 0);
>              data >>= 1;

This doesn't look right.

You're writing to "offset + pix_count - 1 - i" and yet you're checking bounds
vs "offset + i".

This could be fixed by computing the complete offset into a local variable and
then have an inner if to avoid the write, as you do for the second loop.

But it would be better to precompute the correct loop bounds.


r~


> @@ -398,7 +390,9 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>          for (i = 3; i >= 0; i--) {
>              if (!(s->image_bitmap_op & 0x20000000) ||
>                  s->vram_bitmask & (1 << (28 + i))) {
> -                artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
> +                if (offset + 3 - i < buf->size) {
> +                    artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
> +                }
>              }
>          }
>          memory_region_set_dirty(&buf->mr, offset, 3);
> @@ -420,7 +414,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>              break;
>          }
> 
> -        for (i = 0; i < pix_count; i++) {
> +        for (i = 0; i < pix_count && offset + i < buf->size; i++) {
>              mask = 1 << (pix_count - 1 - i);
> 
>              if (!(s->image_bitmap_op & 0x20000000) ||

