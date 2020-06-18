Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4393CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8C82075E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3QlcluY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8C82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxVS-0002GC-A7
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxUl-0001dE-MD
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:34:31 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:43129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxUj-0002tR-8b
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:34:31 -0400
Received: by mail-oo1-xc44.google.com with SMTP id i4so1297971ooj.10
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ogH/hvJ4K6TDa3sOy+CkgXcU7PCbCLfZUwjFwrQp3aw=;
 b=q3QlcluYwYzCBZ8iLJuaa7EkhUbOXvF1Zxsu9sBg6MdLfSYcxhMKn7QewfQh5N303i
 L+0uPo/ordiI6U62X/NZJiclZP42XCI1sezsrXh/1PvbDhLoxj1Kh9ra8gWw4i+mtLMj
 fc3m750SJk7d8CDaGgitIudi7X2T5wV+6GrVLXa+U6V2j1f9guWcSHHGQL2Ubpo/ZNKu
 7eX+sMABGUT49M5Q4Uwn9npbl5lOmkzUuJUt5TxNq6d0onu+vZjXHeRqHwWcA/NIWTbA
 hU3/4SJ1565o3/lw/rfxWnahJdyKzP/PhBDXgYP3/4rBMXlXJ8nkDnHtv7Fz9IEe5dL7
 L/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ogH/hvJ4K6TDa3sOy+CkgXcU7PCbCLfZUwjFwrQp3aw=;
 b=UsLD6GbWLO++EYfLZ7UP1eYyrjrJER5qEBfX5n3sr+fVpm2cj/V9YSr6U2DeLqVIYW
 HIjkse+Ma/4FExtaPeXG58QctgVXdy00i08vvsuf4741PVqDWAIzCkZpipmetIoGDGPV
 Nc1yjHhmlVhMsqKVphnltTBBp9SpmO8deAY3yE4YFUGDzANze4BNDiS9cx4SjzBI7acD
 Bkel25bSYlf8LQWfPF3tWYSEwAOfS/mgpGLVqx54P1klVqU/wz00j7p+2p35FUOvkZO6
 E++bacBY2TDtuWIHbg4swLU/sCJAMvnX0lNRK1WvhHbK6nFIrrT7ZfgEJ9C/kchtIxus
 ZW1g==
X-Gm-Message-State: AOAM5311dc2laU3yL+dglvdBrhhV2C1S20Zc1HUwA60qmatvHn4oYe9D
 vEw7q3WFT2z+44YtNLNefx2Hgq/QL0/YmIcdnqAImA==
X-Google-Smtp-Source: ABdhPJzTfzXxL11J3Afe2JaG73l1MgxbAk5rl09RfVQ7QZcxqnLz0/qssBcuygfDICMUloqgVEm8PSPsKS9HTj3JDdE=
X-Received: by 2002:a4a:a20b:: with SMTP id m11mr4869907ool.20.1592498067866; 
 Thu, 18 Jun 2020 09:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-24-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 17:34:16 +0100
Message-ID: <CAFEAcA8xYTkxY__pT_yG=6VL4Ku7=nqc5okML9OD3B1XxL_VFA@mail.gmail.com>
Subject: Re: [PATCH v7 23/42] target/arm: Add gen_mte_check1
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Replace existing uses of check_data_tbi in translate-a64.c that
> perform a single logical memory access.  Leave the helper blank
> for now to reduce the patch size.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index c4f86c69ba..9f8ae99cc0 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -204,20 +204,20 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
>  }
>
>  /*
> - * Return a "clean" address for ADDR according to TBID.
> - * This is always a fresh temporary, as we need to be able to
> - * increment this independently of a dirty write-back address.
> + * Handle MTE and/or TBI.
> + *
> + * For TBI, ideally, we would do nothing.  Proper behaviour on fault is
> + * for the tag to be present in the FAR_ELx register.  But for user-only
> + * mode, we do not have a TLB with which to implement this, so we must
> + * remote the top byte now.

"remove".

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

