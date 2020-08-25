Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D501C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132DD20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mi5K61nx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132DD20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZOw-0008Fu-95
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZOP-0007mp-TC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:53:41 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZOO-0008Nv-6K
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:53:41 -0400
Received: by mail-ej1-x644.google.com with SMTP id md23so15898786ejb.6
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uf5wVI3JN5dBidbqdF3BhzF6kS7akN21evOjUr2c42k=;
 b=Mi5K61nxz8aE+JHrxfxzICx6epWn6tS71GJSsPa/GqLujvBmm5XwXn+MgYXw2F9NvQ
 DQwbzr8NfEZLe2iUtbJTWuuAtOfccNojNAy8l+4CvN01LkoWBhQgWxfxb6hRiAaZFujd
 nBM7NDw9SqJ12j33kUvINA3olm30xl55gvLbdsB4aVt/UTgoMFU9pSY3Q6mwVVSOClUZ
 DuBGblhMvAzDAy7BjBMlKXYcWHCE+g/dfIs8D1JQhKXPv3m3/3I3/arzGcEJp7BFLni4
 BqV73pT34ooQopDbIbAw71zn7rs7V1+yrc/TEEyjhFeZT4RkM5TJ9GNxwD0srRvGzOvP
 8ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uf5wVI3JN5dBidbqdF3BhzF6kS7akN21evOjUr2c42k=;
 b=GTHISsnfqjh+d9dujEhOU2mIwqqIy+QmQptdWIV2agh11f2pMEsB7/QuacFarolFd7
 ZwIW+Tm1836OX9s0MDAKioUBLMMYCclOTARGLKQQsqL1ya+KoaxGHy0CM2tE8pMcMsFz
 EPwNykSoactqiIzasH1zHQFBCQX6R7afplSmaIrHaKXbR/dsX7B88k6OdZSaJXt6quK1
 GPRPvOf8VISK/xRj1NbJW+xCN2EcRiqSveqZj+IRLexAv4Nj+01ndHRzbm8SCCvLA4I9
 w+4Jffh/PdkQ7HZh3vK2FgJpD1DKSTq7DKjGB7vLxxeTL+e3ATXE619iQj9lB082I3ma
 QOGA==
X-Gm-Message-State: AOAM530fd1GwKZ6bIyo4+/NLa/6oHf35JKPoXBE1u//681dAnpoPkQ7U
 kA14W7cFiBZn+hW3xa5Yj7Qh8QMmH6XbWtofOqxFWNNEYg01uw==
X-Google-Smtp-Source: ABdhPJzbq2214QvbqWCsK6oc9336j3hT0X32mGx7A7xgPSXP3dDDGw8KKuhllHzl4jMUa3xPmNDc4ZrTDW9VMrsFjIw=
X-Received: by 2002:a17:906:59b:: with SMTP id
 27mr11283968ejn.56.1598363618295; 
 Tue, 25 Aug 2020 06:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-18-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 14:53:26 +0100
Message-ID: <CAFEAcA9m6ZHDzAmk3vdg2hEsA2SPNuigURh416eJUbyPq1PgCg@mail.gmail.com>
Subject: Re: [PATCH 17/20] target/arm: Fix sve_punpk_p vs odd vector lengths
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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

On Sat, 15 Aug 2020 at 02:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Wrote too much with punpk1 with vl % 512 != 0.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index b8651ae173..c983cd4356 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2104,11 +2104,11 @@ void HELPER(sve_punpk_p)(void *vd, void *vn, uint32_t pred_desc)
>              high = oprsz >> 1;
>          }
>
> -        if ((high & 3) == 0) {
> +        if ((oprsz & 7) == 0) {
>              uint32_t *n = vn;
>              high >>= 2;
>
> -            for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
> +            for (i = 0; i < oprsz / 8; i++) {
>                  uint64_t nn = n[H4(high + i)];
>                  d[i] = expand_bits(nn, 0);
>              }
> --
> 2.25.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

