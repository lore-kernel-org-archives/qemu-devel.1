Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B2C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A128D2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yegvtL4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A128D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnNr-0004Bq-Qu
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBnNE-0003jo-DK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:01:32 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:38214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBnNC-0003u3-2i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:01:32 -0400
Received: by mail-ej1-x643.google.com with SMTP id oz20so1190091ejb.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=18ZTh4+r1SVO3ESDY9qvWYIJqPS0l5BlA8U6rusTVm4=;
 b=yegvtL4yQBqHrPJAbGPauCXUkyZsRNKU2CsdV/d+I2tDQRNZ1xeJHQtlRTBrQaFoYj
 aq3N7v+AIzAu0WKMzVNKR9JGo6UTdRwilOFEuloIuuvr754qYkdEQYCeUwCnbUPnZerH
 yLJ1jXLgq/PSpU3ZZJXKUbJvmg0b4j4u+BLdfOgWPg/eLUgVyLPsrlCOjp+B9dVhok1y
 I1GGcMVCA8rsuJWHJ7Uuca2PPVpPyW1aqDdhFuxQ/u90iuxCeDyxQd2qdja5tqxUknaf
 XijHgvXr3WjesaYvD/5CYNGeklSwljO4nYQwpjIytw8+qpQ6+EFozzgoThGPZ+CTs+tV
 3pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=18ZTh4+r1SVO3ESDY9qvWYIJqPS0l5BlA8U6rusTVm4=;
 b=r/TgkTXWGWuHWYE/Xz7zSKrnGotyplgcG1uerySIGjyDfFksU0RkpEJ5Zhgqe6fx6T
 YD+yJO/idjvjBz0qiDyFEZayS/MGe/LaZJGgKzLppm+EbMS4XCA7CeegQ/P72w4j1GX/
 HpfDxVaxHoj0LVg5urlu2pJQv6oUBhnPPhEOVPpbLvSi/D4aQTOASFjfCgOLL49ALO31
 Zp0Vc/zUzdTtRVubrQaYP20vVQPCmUPXrxti9fLNYA9bPTxyOH/5V18oB3JG4LDn/StO
 6DKge+1hYtQCBwdbig/OYwYNbn4FEs3lwoNoIyRHU9k2EPDa7ZTQUBUnx+wfGpDNft08
 1EsA==
X-Gm-Message-State: AOAM531xQ9D/a7bNyQidntdCgnxDAyfCEudlkdLwzlQgYZVOCqzXUs6/
 FFwjGQ55zHSrSJdmrz/PVMlQbDqGGFDBEXvt+MOe1g==
X-Google-Smtp-Source: ABdhPJyElnULyNkgtsZR/3oeVaQiWpd9+6iLm03a48pacfzNqYzVRvWh+/jbnGdFwKaHXY0R79fd3rKGs8fbveOGItI=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr1121727ejn.56.1598655687900; 
 Fri, 28 Aug 2020 16:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-17-richard.henderson@linaro.org>
 <CAFEAcA8s==-CGT88P97xFaxcNkOf6WdNYi-3HSwjWRBXh+KQxw@mail.gmail.com>
 <b3f1beff-c524-a4a7-1202-e9b317ac263b@linaro.org>
In-Reply-To: <b3f1beff-c524-a4a7-1202-e9b317ac263b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Aug 2020 00:01:16 +0100
Message-ID: <CAFEAcA9J-9OC04r8WD5KYwCXrrF4=7WFyt588vzELcsPz4eT_A@mail.gmail.com>
Subject: Re: [PATCH 16/20] target/arm: Fix sve_zip_p vs odd vector lengths
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Aug 2020 at 20:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/25/20 6:49 AM, Peter Maydell wrote:
> > Why is it OK to only check vd==vn etc rather than checking for
> > overlap the way the old code did ? The commit message doesn't
> > mention this.
>
> We only ever pass pred_full_reg_offset, so there will only ever be exact
> overlap.  I can either split this out as a separate change or simply add it to
> the patch description.

Whichever you prefer, I guess.

thanks
-- PMM

