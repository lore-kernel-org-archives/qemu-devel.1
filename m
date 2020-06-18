Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B474BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79101207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SB02cViE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79101207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlvSD-0007C3-PK
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 10:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlvRZ-0006H2-Oc
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:23:05 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlvRW-0000dJ-Ij
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:23:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id c194so5228206oig.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dzD/G7YSLnlaz8NnpJuTit854jCAV3rFj8vlhaOab8U=;
 b=SB02cViEqD1r6FNbbk9rqaKmTlq4/YbB/WziUK9lyKMMr4mUB4fNZCtqZ0uatC/39U
 SnUgAkyGswi1tpE9z/+6sXp9hBshIekUJEujv8gQ8APK8vxm76K+jFsIs7mZVI73OHwx
 DQNrpAKG1anSWJlVihrssPuqwuCte5tFXLzUlRrOziat9gIoSPI9F9QtVdD0zitF0IdX
 0azqNQbJ6viI79iQ+NxA0Hu8n/cpmPNEVFhs35gFcxCS43ePfzORrNOzAVSk0I0A+hTs
 VUZ1xd0eFS6J6r/ezYbIfs2wDHoUp/BEk3oauHyiC7DUZZ0sxS70XRbozUW5uA7pKm0f
 Hk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dzD/G7YSLnlaz8NnpJuTit854jCAV3rFj8vlhaOab8U=;
 b=SmgG0OaRifrN7sj+Gd7hGa3+BC9Tly+cksL7kbAkYdQhssABqhvOE8wUdEVTgEXVpl
 7PxxacBMO2pwxPNuW8ddbxTDYMVtj4KmlDosAOkoGO5eiLpQxE7gIfc2usjC9YwTB3y3
 CluisYou+Bjn5NDF6KYJpFNfAQFPWIHr8j6eUDEpZ1SJYpPR7WANxWnZ3ozoTyVwTeL9
 YQxO07mabriFjiscnI9Mm3VWY9XxVvpa0DlOlqfURcsMj6vfm9sDrehXrljH0k2/UYi9
 +bbEHgGGTXYAwqIQ4+PB76Skj3yVjiYmC9fL1hSxqjRPxDAoazXUREU0V3r82jcyOJQu
 I5Wg==
X-Gm-Message-State: AOAM532YcclkvSvP6sO7uBnYQ4AgH8GEbAtNo1Yp/lBeTALMSNH8k9be
 KNFuaDsQT1eSj+uTgE8zAgg6PCFPOYhMdDKriQqHYQ==
X-Google-Smtp-Source: ABdhPJxz/fy6gSaxXjB+q7+cWfgx1k0ZOfxuOa+Evu207w55Tlwvu9CI4oVTT8Yggv22EsF/TIcSPlP/dHw4VidcWJk=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2988875oib.146.1592490181289; 
 Thu, 18 Jun 2020 07:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-19-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 15:22:50 +0100
Message-ID: <CAFEAcA-uXUYpwPxxkJhG2w7aqw4xJAnCUXnMsaeGtjzTg3n+Tw@mail.gmail.com>
Subject: Re: [PATCH v7 18/42] target/arm: Simplify DC_ZVA
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
> Now that we know that the operation is on a single page,
> we need not loop over pages while probing.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c | 94 +++++++++++------------------------------
>  1 file changed, 25 insertions(+), 69 deletions(-)
>
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index bc0649a44a..60a04dc880 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -1119,85 +1119,41 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
>       * (which matches the usual QEMU behaviour of not implementing either
>       * alignment faults or any memory attribute handling).
>       */
> +    int blocklen = 4 << env_archcpu(env)->dcz_blocksize;
> +    uint64_t vaddr = vaddr_in & -blocklen;

This seems unnecessarily confusing compared to keeping the old
> -    uint64_t vaddr = vaddr_in & ~(blocklen - 1);

I generally find mixing of arithmetic negation with bitwise ops
hard to read because I have to remember what the binary operation
that is 2s-complement-negation actually is.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

