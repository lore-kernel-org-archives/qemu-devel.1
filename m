Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA8EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A1620774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3NBd0ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A1620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPPCW-0003MV-SE
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 08:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPPAQ-0002ak-9Z
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 08:00:43 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:44086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPPAN-0002Dy-MM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 08:00:33 -0400
Received: by mail-ed1-x529.google.com with SMTP id b12so8965399edz.11
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hr5vH9UFMjCk6ZkmcMkBXQJN+4WLJlK1jDUuqmOImgo=;
 b=X3NBd0ft2P8p/YweM7SvzVGcfsZZChgSvH4bC+sqCwbr1c6Tqm30+0ZFHhIy4uy9mT
 b3ULnLZyxRSIHSIA31CIaksNEsb9DTntxKFpZDT9x4U8HgtK+Fuw9zrTCaVofGYI29gN
 kj8RbuumBHDb96YfpW63sGsIcHCaAmfiKHhZ/5FpcPaodCHoJgRA/juXl3HEQcSLHd79
 5caDnNo3FovMvzlMmubrn9NQk96F/fBE6H/H+1ikL71watbgD9vyYQEIP9JkZ7ytAB0b
 FKr89DI5N0QmC1Q8XEPtLct+sQCqRAPuAcGOXZahGvu0KHZKhr8wFXRVuauhqXqGOQe6
 uuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hr5vH9UFMjCk6ZkmcMkBXQJN+4WLJlK1jDUuqmOImgo=;
 b=oNQSHNtvVFqFFIl2RGTI9bqKROHBKLXnO4V1MfiUfDSUVzcxA8oCSal0j1BfsV99Sd
 It87tA6fBpqN2UNd+EkVRwtMYbQo8b/zUiKnWeDo0ERVGPzXgYgvi/Gv2faKIG1aTHMv
 BwBXAvmHfT7HoizThLcFNLnPMf05SYbhdqiAyIpgUAl4kQAiqI2NpDtshhwEj6Grh0vm
 LKG7Sq8EZ9dbEToimPoukoIUdtMf2NESv58vT6r1LxQ8VQqG7AnkHvJ43edAECMunzgy
 MSTFCuIM+ZZjVVTTxOSurhmZ6+zQSwtihkj7f2Wdrb1Kk3Q2XVL+0i17UNbnrnLSonoY
 /sjg==
X-Gm-Message-State: AOAM530EEsYQHMw4ZeEfA0W+RMBupBlFrR1Qy4DfuyBH37l45EQBBabw
 TXRZnuvGlIGkBq6XA8AtZtrYgB4boSNZNqm2eAtFYg==
X-Google-Smtp-Source: ABdhPJw6KkpS9t70lUf8Vu5gRqWjNqhzJw1Kkg6+ba8B+Cz6L2XmBiPQn+HjeqjjWQRPB/DFn/CzO9AXV7Hit132+1o=
X-Received: by 2002:aa7:c7d7:: with SMTP id o23mr16503106eds.44.1601899228421; 
 Mon, 05 Oct 2020 05:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201003093851.324923-1-richard.henderson@linaro.org>
In-Reply-To: <20201003093851.324923-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2020 13:00:17 +0100
Message-ID: <CAFEAcA8Pu8PQXyjeKZL__ov6Mr0tugkT9qWeB_t+YcgsPn3pSg@mail.gmail.com>
Subject: Re: [PULL v3 00/11] capstone + disassembler patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Sat, 3 Oct 2020 at 10:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 3 adds the method: to the dependency(), which avoids the
> cmake warning, and also matches the bulk of the other dependency()
> invocations throughout meson.build.
>
> I also added the suggested current_source_dir() out of an abundance
> of caution, even though it works for me either way.
>
>
> r~
>
>
> The following changes since commit dd8c1e808f1ca311e1f50bff218c3ee3198b1f02:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201002' into staging (2020-10-02 14:29:49 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-cap-20201003
>
> for you to fetch changes up to c6d3da962f058bca09b25f99da35436816fb6de8:
>
>   disas/capstone: Add skipdata hook for s390x (2020-10-03 04:25:14 -0500)
>
> ----------------------------------------------------------------
> Update capstone submodule from v3.0.5 to v5 ("next").
> Convert submodule build to meson.
> Enable capstone disassembly for s390x.
> Code cleanups in disas.c
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

