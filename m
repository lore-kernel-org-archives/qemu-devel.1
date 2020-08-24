Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C087C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6383720738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNGgwyV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6383720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFZ3-0008VK-Kx
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFXx-0006ek-Pq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:42:13 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:35240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFXw-0008FJ-2A
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:42:13 -0400
Received: by mail-ej1-x643.google.com with SMTP id a26so12785951ejc.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CuUm7isieOZfHAqCalr91xnNOzIVrugF4U2oxXejZxw=;
 b=SNGgwyV2T8wjGPYER1knm40cKSlTR3wrsIKlLedhDav8nQF3GlkS2MqPB+ElMzjUFN
 WsdTy3j8Mski/Vzckr4YzTw/0oagOVJ4kO/k1ffqPh2eV3rO7/QmETfxIGXEuDjsSpEs
 /y6oKinvYY5ELEX8C8dlx2zkknB9qVH1XiF30JowKSlq5SXLrXn2YIiCC5U5Iy2/moYk
 KGefvKkVtU8te5BnXxOn1TOCjbKT+M7aAUkOCuXiiEyD5Sqw7sOSnNAw7IWz4sR2rfd6
 PsS6E0E6S+Sgir5kVtHa0Bm/XcKx37nqLbQ4UiAZNKwR3Y/Ja9x96vHNCCcilWgDuZzk
 VlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CuUm7isieOZfHAqCalr91xnNOzIVrugF4U2oxXejZxw=;
 b=uCATFVHQpCw5Dxiqobf6EBBYVlnkSNOp4DTvLmSGdmMoG7SUvHwqycBlvP98lCD9LX
 H658dV/iAA3yMq85LGjSoWORH6O0O7Tty8tfE8tVfIJmOQgROlyAIrWd2rfeU7JsUxec
 r8VAAhE3TfSkaMT0u/y4SYUTzcArF5DA9oknK7J4wuItQ2tkx+BjChqY3xZbRD611qoq
 2jE7cgpFVc1/EZ9DuHVqgZHjBh0YKXUjAp+SWQI3AlqbijuphL1460/TfH3GfK4ERpt8
 nmAypZhaPCW/VYn8hCiQJLtxdfL5mrUk7CXJVYI38Dmv1eXsqQnoa3jyKtZVcMDUTWYo
 0QKA==
X-Gm-Message-State: AOAM531LE0Z9FsPW6kHPsHq22Q/mcfAq63abcJJhiki1vT86Cn9lM2dm
 U7kpbN908QbQai2HjVoOu3hHzJj8OgBdd7ShWJL+gQ==
X-Google-Smtp-Source: ABdhPJzBbXIF7ArYmMxD2oDL2s9lvsxpx3ollfTdND0BUyCgP3zPdDotyc8EYM1LceKHMyBhRUhnfabtw23zPVj2hzg=
X-Received: by 2002:a17:906:68da:: with SMTP id
 y26mr6208265ejr.250.1598287330890; 
 Mon, 24 Aug 2020 09:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-6-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 17:41:59 +0100
Message-ID: <CAFEAcA-JLpz_gL6w58TfOsTfYnWRcpDuOxm5yk1GLKkPUQ3CDw@mail.gmail.com>
Subject: Re: [PATCH 05/20] target/arm: Merge do_vector2_p into do_mov_p
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Aug 2020 at 02:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is the only user of the function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

