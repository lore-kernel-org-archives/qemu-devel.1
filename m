Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811AEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4232071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DukH141D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4232071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWum-0004Cm-DR
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAWtA-0001s3-T8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:13:16 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAWt7-0004PX-I7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:13:16 -0400
Received: by mail-ej1-x643.google.com with SMTP id j25so6829315ejk.9
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hPeirD7CG2hWwwzdTUsWUhhx96NbCo1/axS51u2z0Rg=;
 b=DukH141DrudC9i6sgZyPlcQXnbcEmqBu8NenJmLIL9zRkvDfIzn9jiiCG1AT/KGeWD
 q5yp6uSzMarT01uBBi1hgtU9oWxxPiGgJ1mxMo9DPgrKNaLoFkLbuhV4CpOmfxfdDYYz
 MOJ2jAM3HLDADsaUElLDXbC5sLet8kNLFr4BNg8YBAKRSVKMns/CMu1te3KWeH4YiXog
 dHBrjzshP0K7MOV/okZEKAT7mtu484x17vSvJYeHkYkC9wJh84nxOp/2S6UQ+DSRqqAY
 80J2ep365b2ZWW5OiQkrFaG3qejImNZtqiNubvdG+bPfvAbLb6nN5XI5AfP//3710XoS
 Q9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hPeirD7CG2hWwwzdTUsWUhhx96NbCo1/axS51u2z0Rg=;
 b=rxVtHwmb1riLpRcRAHZ4pfB5ZCsdEznWrVKT24HfwfSARhXEW5SzxO+3DRXM9K1MXb
 5OzzPndkxV1eF9mhWJXkExkNMpX4/zDzlt6lxANGMFYNP4gqY/4fnpuv54lePRggJQhb
 O1lV+BVJ6FLPAbchKB0YbN24LZe2oeoHcC1xv9VrH6IkFpRikjRcqGaQYrFLCERJSVQ+
 LM2Vl6KVqs3hVy2TUUxApD38C1YpyHRmAWoGwAwzwVRMZxhbKz8iDuLluYV2FBdjgi80
 FPfkifqf4IqxMB7i9Dyxu6OU/C4tTtacIdgMnaUFlQODkW99zkVJd41lLxCNl9HTn4pp
 1INw==
X-Gm-Message-State: AOAM532ccDmr2jWZgnt9B+8O/xWZ4DcT49Tx06PH1lpQYh+9wDbho6yY
 6fFhtfSOGWfi8Np2AHf5kr3BvT16fQJT0BM1snAnGQ==
X-Google-Smtp-Source: ABdhPJztoJOeAVXtekysYtTrmu6Chw1gRTtdeb9fjPkYpBBPSfkwZKvDHWUmC4LSo1LclSvWmT72uptLSQ0Ai+J+1pU=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr9579769ejb.382.1598353991986; 
 Tue, 25 Aug 2020 04:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-7-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 12:13:00 +0100
Message-ID: <CAFEAcA8quF43=Xehm4FRSNJRKCxb2rDzniZtwoxFf1fc-gHmDQ@mail.gmail.com>
Subject: Re: [PATCH 06/20] target/arm: Clean up 4-operand predicate expansion
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
> Move the check for !S into do_pppp_flags, which allows to merge in
> do_vecop4_p.  Split out gen_gvec_fn_ppp without sve_access_check,
> to mirror gen_gvec_fn_zzz.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 111 ++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 68 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

