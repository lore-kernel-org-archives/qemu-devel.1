Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187DAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFBA208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRFqz77u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFBA208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgVw-0007iR-5X
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGgUo-0006cS-5d
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:41:34 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGgUm-0002Em-AE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:41:33 -0400
Received: by mail-ej1-x641.google.com with SMTP id i22so13151852eja.5
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4jHheEwjaucM3IHATI9zTt19WJagXpRYPKx7PpeInls=;
 b=cRFqz77u5VLo80CrjaNe+KZZBb98YEE4+kXZ4pvi+r8ObE7Z5WecYfyxmmfJ/tPl49
 6Q3Z06VF3DLda+RIjHQRm9CDxoF+Vk9UG6JLcPc1RfuyoVVtR9wtGzGocL/6DriWSTXJ
 z8MZGmst4wdWJRvWrzERx3EjMo1Q1SKRBKdYmJnd2/pqNNyOzpPSQjtxdO+w+7k/FWGh
 uZzJ8i2butPj/vYK0EKfnJWT0DDx5y3Yw486/7ZBRgSQnVzkPsYdzJaXQi6nia29m2CN
 6wI2oQhODBpDY0AlJCkbbJs2//JFUqUAwd4phAxPJhHU8q+2HX0TgDVNt5fv9d3pzjOA
 Qj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4jHheEwjaucM3IHATI9zTt19WJagXpRYPKx7PpeInls=;
 b=KUhXBSukPCmNI3TwRZldSaJWPiXFeVS49WfJQPDWW2Xtsi7pi6gkBfLWOVxJNbfNHv
 0mOBpYRtToMmlWJBv26O3Wy8mQA4sikUnPY6mkYpKomHST/zK9kxwOZxh3yGUcYcd63X
 U2ha72MdyNMbckW96N6ClyyeatDTuKT3rhgO41CBt6PQvIjELvTrPXVB0ae/hfwqw4Q8
 lyv46OSYIfoxRPn0g3q5TdZuqNCDI1Rx7BPZcNTFUJg1w2vMmKUIfJdMv4+udTag1Cfg
 2dUjoV2aVRymQgI5Tm70UpUhP1amm+XT27PZ+aoU07K/Xby8aV0a1eH7kn/4wkQ4V2Ls
 Cctg==
X-Gm-Message-State: AOAM530fGqZUdI5yfvhyvrwwVM3tLLpCgsmXkbJ8ZvBC2/lYKHq33a4a
 dORqqd1HQAQlj+EfGi1UOVdPj9rqoKfqKTLqhZcqPQ==
X-Google-Smtp-Source: ABdhPJwlSPikWblc45DvQgEQ6yJHvStqHC6iJUu7BTflf/4sa2kdP4bMBDWUUz/xp95zwhvTg8nCLu/yf4BJIxe21wk=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr1530679ejv.56.1599820890698; 
 Fri, 11 Sep 2020 03:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Lzsy=o9yshAAAacuTwcs3Hfr4MfWiX-SiUf5A2Fds3vGOrAQ@mail.gmail.com>
In-Reply-To: <CA+Lzsy=o9yshAAAacuTwcs3Hfr4MfWiX-SiUf5A2Fds3vGOrAQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Sep 2020 11:41:19 +0100
Message-ID: <CAFEAcA9ap=c=1XZ6wpphiE=FYtCU+vdNCX8THW-m-hUp_XyGmg@mail.gmail.com>
Subject: Re: [PATCH 1/1] accel/tcg/user-exec: support computing is_write for
 mips32
To: zou xu <iwatchnima@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 at 02:14, zou xu <iwatchnima@gmail.com> wrote:
>
> From 533ed02427bdaf0265f62fcb4f961854a41b7037 Mon Sep 17 00:00:00 2001
> From: ZouXu <iwatchnima@gmail.com>
> Date: Wed, 9 Sep 2020 21:59:13 +0800
> Subject: [PATCH 1/1] accel/tcg/user-exec: support computing is_write for
>  mips32
>
> Those MIPS32 instructions can cause store operation:
> SB/SH/SW/SD/SWL/SWR/SDL/SDR/CACHE
> SC/SCD/SWC1/SWC2/SDC1/SDC2
> ---
>  accel/tcg/user-exec.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index bb039eb32d..b5ad721aa5 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -708,10 +708,38 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>      siginfo_t *info = pinfo;
>      ucontext_t *uc = puc;
>      greg_t pc = uc->uc_mcontext.pc;
> -    int is_write;
> +    int is_write = 0;
> +
> +    /* Detect store by reading the instruction at the program counter. */
> +    uint32_t insn = *(uint32_t *)pc;
> +    switch(insn>>29) {
> +    case 0x5:
> +        switch((insn>>26) & 0x7) {

Here we mask to get a 3-bit field...

> +        case 0x0: /* SB */
> +        case 0x1: /* SH */
> +        case 0x2: /* SWL */
> +        case 0x3: /* SW */
> +        case 0x4: /* SDL */
> +        case 0x5: /* SDR */
> +        case 0x6: /* SWR */
> +        case 0x7: /* CACHE */
> +            is_write = 1;

...but here all 8 cases are handled identically.
Is there a typo/logic error here, or should this
really just be

    case 0x5:
        /* SB, SH, SWL, SW, SDL, SDR, SWR, CACHE */
        is_write = 1;

?

Is CACHE really a write insn ?

> +        }
> +        break;
> +    case 0x7:
> +        switch((insn>>26) & 0x7) {
> +        case 0x0: /* SC */
> +        case 0x1: /* SWC1 */
> +        case 0x2: /* SWC2 */
> +        case 0x4: /* SCD */
> +        case 0x5: /* SDC1 */
> +        case 0x6: /* SDC2 */
> +        case 0x7: /* SD */
> +            is_write = 1;
> +        }
> +        break;
> +    }

thanks
-- PMM

