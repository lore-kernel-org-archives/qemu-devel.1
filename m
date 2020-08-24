Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058BFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF07A2078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhP1ngEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF07A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFdr-0006OL-2v
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFah-0003A4-Q8
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:45:03 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFag-0000A0-5I
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:45:03 -0400
Received: by mail-ej1-x642.google.com with SMTP id d26so2663351ejr.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LSxnoA/X3E+s2dpXMDh0XSU4Wu44JJfCtlMzk4CBmNI=;
 b=FhP1ngEHn/HOqGOcPs3J+DJ3gmPK+t4IHhwNfCQZmKVFYEJN7iYnJ3Cse4FLcrOarP
 mnzzSmFn2mX/KQjrNhL/0bDlBsgn/RWtFCZ2bIV11Q+E8zzQMnuLfnZI4IDlZ7IprLTz
 nU4xEFgmZIsB/4dZ/qkgSpGlmTsGBZfM/N7RbpS8HsaexK6y8QUPQEzDzAgn/jjJj0Od
 68XT527AE25ul9/sFzKj/l8otzFaebNLfGu5DHZkfHK0vIYvY7SGwgn+jSRoWY9bevYa
 CB0M14hDiDBIotOQo7fYMB5lntrnsniU8OY12sauIOuifitpGabBKomoxdDm8U7UpQlc
 EAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LSxnoA/X3E+s2dpXMDh0XSU4Wu44JJfCtlMzk4CBmNI=;
 b=H/wjIw5B/PKpQ+0Ix0mSShnS3sZeP6jxl8cMcO6fBGPr65OqcGXn6GAh6+xr32stUK
 57L+rh+MTiWbJOUVozrxfbjMvTi5Mt7hwxpatm+Tzb8tE7itK4URpM+HYWrt7zkIrR/S
 q6VZZ5tEwUkLXrOahJHIDDlKjn/jjHY3NYfKuFi05nPTx4X9EOFkLPplqqqbacD2qyPe
 tPMTX8+a6CSpOUm5TCti8eCXwFTPwBLxcThoKNmDtBJTYaz1k74cKrH/afH0bwzHpwq3
 gfz3m5sxTaiLdguiS5kDAHNgJxtw1ICOsVqTmD2uuAFirCXlk/XRKaQJcXuhyg8PIQH8
 UM7g==
X-Gm-Message-State: AOAM533fvZUbJJyszyLKOFENO1Y6iazW+YGVIp5SvpfAL3+1iVWxcgiq
 KrdMi+rWj0Mg7gs79khCEX+2SPvxpnXnpR2LdkLFaQ==
X-Google-Smtp-Source: ABdhPJy3EqPWrGLTI97RF/eJAXAYmMlXs4AcW1WJxVAOr76RcwK4zN1J/EPXjKWnF1L7ZlxP6Ks8YNcPlQdgatNblPU=
X-Received: by 2002:a17:906:68da:: with SMTP id
 y26mr6219411ejr.250.1598287500456; 
 Mon, 24 Aug 2020 09:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-8-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 17:44:49 +0100
Message-ID: <CAFEAcA9RppugBZBiKh=FhG=4RwR0qMH6B7gV5sArat+0o_usgA@mail.gmail.com>
Subject: Re: [PATCH 07/20] target/arm: Use tcg_gen_gvec_bitsel for
 trans_SEL_pppp
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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

On Sat, 15 Aug 2020 at 02:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The gvec operation was added after the initial implementation
> of the SEL instruction and was missed in the conversion.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

