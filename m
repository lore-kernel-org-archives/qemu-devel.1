Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2934C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F45D207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHKPQiS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F45D207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16G1-0000d8-W0
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k16FQ-0000D9-RC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:57:16 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:44276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k16FP-00013U-7q
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:57:16 -0400
Received: by mail-oo1-xc43.google.com with SMTP id o36so5129653ooi.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XiW7Lo9DkCCefHgEFlgnoyq2Lzb1Rk5l4tqufRQYrns=;
 b=fHKPQiS8nirGs8ZQtZt2iu0LDtJ2fyvn+8Sdl/ZMqVDCHCkEqsbzGzuhgUVEazNEJF
 acTd43DamqJpj1OnurzlzkCqYRetYwmmgaYCRA5OJ6yPzZ0pffWFGhbUlb4yQW4qkJi/
 sDTuwborCJKTmepNBe1VfdEAn6PuBeap2W742R/apb0PiCZUfFpgWHwdmRk4DobczTvd
 dM/bz8nD3FelF4STvJBi/u/IZeDTwe+ueIk0vi/X7QfM89G6+6w2Pf3b8dcrHL8Bb/pc
 JrgRCN7WrcukkwOY2kOrMHfuy39DLhQV1BCOSFNdBzNwhCJIk7W53xSfgRPGt4d0s9SZ
 11Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XiW7Lo9DkCCefHgEFlgnoyq2Lzb1Rk5l4tqufRQYrns=;
 b=YdQAolN79xG+xV9sBaaS9t3S+dnlE0zdMgoqoy8BFE6NSIVH50edPH0JOepx5+oR2f
 8K3GRPbCr61Tx4yz/BevEsmkJMNk4m2qB3HzpMETtpfBExa6LK9kEZySSoa5IHjTwYu/
 czToegaJxoMOwZ5EMlgls4gN1n7J1iOP4ADuqT8DVTkj9TMcWKWLlLwMGv5iOSBJOdD6
 ikPtNL7PYLUORq6nYcUVIOtdYOlMhZtbZQptyVphneLdE7NkPKvvtywWezRIDK7DeACe
 5qKaswOItwes9CiZWs5fOK8fHNRfmVRW2oy2xb5m3hmTep8sSHviZ8v+bVzDszBlvvTb
 8v0w==
X-Gm-Message-State: AOAM532AxX5g0V48w0lY/dosXKoJoN4bTBNZYPS5+L8+Cvy1NZTVxTgj
 YPdUWX5pSXdo8G/xlPt5KAx9vlPrbufEMKjbFKur/Q==
X-Google-Smtp-Source: ABdhPJze92xci3GAzYi871hgg4NEHu4Wj7Ueop6GrSZKjHL5gnNH38VmgFeGDHERXTXWjwN9HPXe+U3C5giqnKMlrTw=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr1909327ool.69.1596106633815;
 Thu, 30 Jul 2020 03:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200728195706.11087-1-richard.henderson@linaro.org>
In-Reply-To: <20200728195706.11087-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 11:57:02 +0100
Message-ID: <CAFEAcA-XSjJxspYw9ESeh0CUW-OJvJnyMbo4m6LJQ9wuhoAhpQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix AddPAC error indication
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Derrick McKee <derrick.mckee@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 20:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The definition of top_bit used in this function is one higher
> than that used in the Arm ARM psuedo-code, which put the error
> indication at top_bit - 1 at the wrong place, which meant that
> it wasn't visible to Auth.
>
> Fixing the definition of top_bit requires more changes, because
> its most common use is for the count of bits in top_bit:bot_bit,
> which would then need to be computed as top_bit - bot_bit + 1.
>
> For now, prefer the minimal fix to the error indication alone.
>
> Fixes: 63ff0ca94cb
> Reported-by: Derrick McKee <derrick.mckee@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This seems like it might confuse us in future so I've added
a comment inside the if():

        /*
         * Note that our top_bit is one greater than the pseudocode's
         * version, hence "- 2" here.
         */

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

and added to target-arm.next.

thanks
-- PMM

