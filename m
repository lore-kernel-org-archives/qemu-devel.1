Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FCEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6B02073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qy007EeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6B02073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPH9-000100-Lh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsPGb-0000W1-D9
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:26:33 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsPGZ-0000MQ-Hn
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:26:32 -0400
Received: by mail-io1-xd44.google.com with SMTP id q8so38905952iow.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=626m2y7v45xA66SSQKynyXH6OAAoP3SjQ+sZ16r1KOw=;
 b=Qy007EeT+pldu9Aas2FlxIL0c4vUXWX0hiw7/icHFBl3fVKh/ApnSueAAy+d2mvcQK
 JV7b1iqV3zRINMNbuwlubpk0z9yfBr8T8P/0+mkbKaULnap/Jqsl3ZF7RLZFtC9AnGIw
 kI3Sa8RjpZBeBGOr1/qOQ1CZJ55rx+01OY4BUPzlAWirdyOHEDtPe6PiUmCdQxRRCuwO
 ycCxWfoDKR+wNDVkgtWK2DdINgA2yxAXSmOc+w7bWSdy8NlqsN5Cryzwq2sYRUYtGw0Z
 g+nczpMJpjDBNW/7L6UJZwu6+XdBIT7DfPwrVTWicgU0xX3+2Wgzdek120D+Ftkuzkx8
 VD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=626m2y7v45xA66SSQKynyXH6OAAoP3SjQ+sZ16r1KOw=;
 b=n/NLUmKBQgPhKjE0tZZmW9xEY89D1sG0OfAE5yt07oPdgNjhUl+/VFRxODKJ9UZ3Fr
 7/gd+t+ygeUnrS8aVpf4MxaT/zmyY1MxZITl1vQT/MJxh8JinuqJ1oMY2fBLFJG4Admj
 cmgox5mRlxv6Ia26OTaKFVN6zcY1X5h5DGkXERuWE5lkhOvr4GWodtWNwAyuvImiGDCp
 KlmK7knZJcS4SYFKqX54Sk07iMvcxrHVIBJkd6b1Pjy7e8lfq3vIzvgV3xymKjLxi5QN
 1fkJJTQsogCIJClEX7X6C4NOTRCbGOpF/6DZqNCO/uW4YEshowTUMCcYaqGjGrNy74/K
 L6LA==
X-Gm-Message-State: AOAM532LMPYbpuCQ1/umfyB4I/YIK10IIzu7RQ8C6tpun21eB9jsL86X
 4Bd/yL8TYylHM5MjLly58XFIvPAPbsaWs64M4tBmYQ==
X-Google-Smtp-Source: ABdhPJxCvkuRV6KcuKbfxBTcTvkb+8dzznwpRPQe8tp+qL5hw5lmkEkWUqjZtbPiB2m/cM7OMkl9HlzPRgowZv/0+ZI=
X-Received: by 2002:a6b:9042:: with SMTP id s63mr25467264iod.195.1594034790342; 
 Mon, 06 Jul 2020 04:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200520172800.8499-1-richard.henderson@linaro.org>
 <20200520172800.8499-5-richard.henderson@linaro.org>
In-Reply-To: <20200520172800.8499-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2020 12:26:19 +0100
Message-ID: <CAFEAcA-fqaXRd7-hD0Wh2c+SLshg_7eN-YJp+vyORBLmE_wKLQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] linux-user: Parse NT_GNU_PROPERTY_TYPE_0 notes
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=peter.maydell@linaro.org; helo=mail-io1-xd44.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 at 18:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For aarch64, this includes the GNU_PROPERTY_AARCH64_FEATURE_1_BTI bit,
> which indicates that the image should be mapped with guarded pages.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v9: Only map the startup executable with BTI; anything else must be
>     handled by the interpreter.
> ---
>  linux-user/qemu.h    |   4 ++
>  linux-user/elfload.c | 143 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 112 insertions(+), 35 deletions(-)

Hi; this patch has some changes which seem to be just code motion
(moving the PT_INTERP handling higher up in the function), some
changes which are coding style fixes (braces), some which are
no-behaviour-change changes (using eppnt->foo instead of phdr[i].foo)
and also the actual BTI related functional change. Could you
split them out, please? I think it would make this easier to review.

thanks
-- PMM

