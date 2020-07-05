Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7578AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFFF2068F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHa8D6B9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFFF2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js8AY-0001cC-Ir
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 13:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js89l-00012O-L0
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 13:10:21 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js89i-00072s-Qb
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 13:10:21 -0400
Received: by mail-ot1-x344.google.com with SMTP id g37so6284184otb.9
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ZQRbT758TX2gxOlkJidQdi2GmVVmVYR4ms97Buz708=;
 b=cHa8D6B9W/dAZ1YoX4vO0Kw5a4hl9+Lnm5gBG7egJDeOp1gq666D7Byz4fgjIdHv/e
 nJHuJY7gKle0I+cSq3oBAymVvSQrXdUrwsmNCfrJ4jaUcbzrEWV2sXJsQzyKOtvs2/Ok
 02wqs9r4B+86yIgHfdz775BCi8QP0049oGcfQyPzY/U1d8vFFCygiiQxYpXOMT6bk3eA
 34absVQNOJaUkhTZGoKlKVo86zx5mzxxab3ObmIuh9AGrzR6E6toHfFpibdBLuYQEFKr
 uQzW1Ex7y+LR0IHALbBC3P0lGzd2Od+X7f5mH0v+oO6t5dDAmVRfka91gWYiSjA1AD3g
 v4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ZQRbT758TX2gxOlkJidQdi2GmVVmVYR4ms97Buz708=;
 b=MdlxlTChFU1H88XxYnd4W+u6WYFW1Pjv/J+COpYfu18llOc5mhctJk5jZwWyQO35Ph
 Pu0Mp99fgXShWPotO2zjCP11EXgerssJYIqpPdHtlKsuVvZlsH+bmssWp9ff0+Tiyxsc
 2uiD8piCVW1l4GPBoOkQaZ2hY16i2LBhX6laGT+RIwFSTUKHWDaPDp/F/q0vdWZyf6gB
 maqjGXF/RQnj0lus7jIKur0rM4tH48J/QA85Eju7mJ8lCsjx3XZhmyDE4kpMiJByeZ8G
 Nf18RhfBtqeiW9611F3PhBEtBb3gDMUAGfbIazFIHRHVyo1JbCszt6Br8W2MfZnbKNu7
 QqIg==
X-Gm-Message-State: AOAM5305BVTW/ijNuYQ1td1S2ht48a4d2iz+oFUIqYxNqkHL5HUyb4j/
 l8N9Yw1S375vSFLJv2byHCTnpPBhDVtD93xuIDikvQ==
X-Google-Smtp-Source: ABdhPJzrJODtJsCWs6wfu+Re0oghWaghNIS+jPK4C5pft8NSsjBesGkl020U2jaHFmy0gKEPLQiv2TBqoHEtFXJbSSU=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr30932395oto.135.1593969017498; 
 Sun, 05 Jul 2020 10:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
In-Reply-To: <20200629160535.3910-3-wentong.wu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 Jul 2020 18:10:06 +0100
Message-ID: <CAFEAcA-1eFyMNkqg-c3dTZv7HjVRUPbwcbZht5HV1mwgzrMcBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
To: Wentong Wu <wentong.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Marek Vasut <marex@denx.de>,
 Chris Wulff <crwulff@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 09:17, Wentong Wu <wentong.wu@intel.com> wrote:
>
> wrctl instruction on nios2 target will cause checking cpu
> interrupt but tcg_handle_interrupt() will call cpu_abort()
> if the CPU gets an interrupt while it's not in 'can do IO'
> state, so add gen_io_start around wrctl instruction. Also
> at the same time, end the onging TB with DISAS_UPDATE.
>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> ---
>  target/nios2/translate.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> index 83c10eb2..51347ada 100644
> --- a/target/nios2/translate.c
> +++ b/target/nios2/translate.c
> @@ -32,6 +32,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/translator.h"
>  #include "qemu/qemu-print.h"
> +#include "exec/gen-icount.h"
>
>  /* is_jmp field values */
>  #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
> @@ -518,7 +519,11 @@ static void wrctl(DisasContext *dc, uint32_t code, uint32_t flags)
>      /* If interrupts were enabled using WRCTL, trigger them. */
>  #if !defined(CONFIG_USER_ONLY)
>      if ((instr.imm5 + CR_BASE) == CR_STATUS) {
> +        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
> +            gen_io_start();
> +        }
>          gen_helper_check_interrupts(dc->cpu_env);
> +        dc->is_jmp = DISAS_UPDATE;
>      }
>  #endif
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

though as Richard notes ideally the interrupt handling code here should
be rewritten because the check_interrupts helper is a very weird way
to implement things.

thanks
-- PMM

