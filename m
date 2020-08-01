Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C68C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 17:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5BA2065E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 17:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbofvIn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5BA2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1vXb-0004Ik-Qm
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 13:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1vWy-0003rz-KT
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 13:42:48 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:46779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1vWw-0002jj-Gf
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 13:42:48 -0400
Received: by mail-oi1-x235.google.com with SMTP id v13so13036460oiv.13
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2020 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GasALLkohh0lMpJ9xQQRvpzwGd+AFVicvQuHpaRnV8k=;
 b=FbofvIn7pwvxuWy7V7vtIKtLrQW4Bwbh42iAkUiSee/cRjh7j+n0uEjti2YNm0SUUO
 ZvtKNW+u1X6T4lZ3+ZX9WJz7Hl37K9hyWgHHG+DfO0TIa8C7fauoTyq6SvjuIdu93vUU
 1KlsRZjao/78VjwG7OIaMGK20qYkT/fGTST6TNv3XklXCL/JBxFjqV9mlnq9u3D87Cnu
 jDI0e4osa6CQF7x2r4dgPgXNRDuoPjWk26TLVUWYo0GjcO9B6yzgRZAsNJ1Mgj3YgHsj
 wJCbjDKStqIANeUO0gpdNB+cIP5Us/n3vwu3xyTs9RGDboMqZ/bF3x4oIrYMBvvUEYuZ
 IxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GasALLkohh0lMpJ9xQQRvpzwGd+AFVicvQuHpaRnV8k=;
 b=M4pWsK1Jf1hMiPRlUzWc9hDdBFztMvPxhOepG8bEibUgln8g6Zf3teD76Fr3ryCE0g
 9pn1Gf5k3YUzYqUkBGfnTB64FLVe5OaS8maTdeiH42o/Pka0GdRCIV6ufcPeW8xWySqs
 J0+JUZNB9IegdfBICFoJLNztoUxAtUOnUTHnPdAFiEePUFl2sTejJX0srZm+jUkvRkYq
 hWC9zhKK9Sfn8rVrSbcpdCJgUZlgbkqhe3EfWZUsWUstVV29h0Wer7w/78hywi49KTVC
 dYAM3agP3BO3XjbLa+VX9SvhNtvRe0qghe7qO5zOPqObStZCD7RzfXxKhhwVRVMh7EEJ
 SftA==
X-Gm-Message-State: AOAM531hax/l0nsbeEWLKV9T+aCZKbGVPpgyPujORvHps33oK7Aot4rL
 zKrrQx/H9aNO5mpT6mPYh3v0RaXyqIpQ6v97aXqgpw==
X-Google-Smtp-Source: ABdhPJxIFdmaNxB4KOEbI0C5nNH9jgC/86xIWAjBvCjX7/xmEZzMl3/Acx42HeUVoAfH3plYVcK4MlvLXamzsYWT65w=
X-Received: by 2002:aca:48d8:: with SMTP id v207mr6833629oia.48.1596303764988; 
 Sat, 01 Aug 2020 10:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200609162504.780080-1-richard.henderson@linaro.org>
In-Reply-To: <20200609162504.780080-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Aug 2020 18:42:34 +0100
Message-ID: <CAFEAcA_nOx=HNat6mQpt-LGBJzLUgphMSeWChGGVN0kwprXQmw@mail.gmail.com>
Subject: Re: [PULL 0/9] decodetree: Add non-overlapping groups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x235.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jun 2020 at 17:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
> ----------------------------------------------------------------
> Add non-overlapping groups
>
> ----------------------------------------------------------------
> Richard Henderson (9):
>       decodetree: Tidy error_with_file
>       decodetree: Rename MultiPattern to IncMultiPattern
>       decodetree: Split out MultiPattern from IncMultiPattern
>       decodetree: Allow group covering the entire insn space
>       decodetree: Move semantic propagation into classes
>       decodetree: Implement non-overlapping groups
>       tests/decode: Test non-overlapping groups
>       decodetree: Drop check for less than 2 patterns in a group
>       target/arm: Use a non-overlapping group for misc control
>
>  target/arm/t32.decode                        |   4 +-
>  tests/decode/err_pattern_group_nest1.decode  |  11 +-
>  tests/decode/err_pattern_group_nest2.decode  |   6 +
>  tests/decode/err_pattern_group_nest3.decode  |  14 +
>  tests/decode/succ_pattern_group_nest2.decode |  13 +
>  tests/decode/succ_pattern_group_nest3.decode |  11 +
>  tests/decode/succ_pattern_group_nest4.decode |  13 +
>  scripts/decodetree.py                        | 513 +++++++++++++++------------

Hi, Richard. I've just noticed that when we added non-overlapping
group support to decodetree we forgot to update docs/devel/decodetree.rst,
which still thinks the only kind of group is the overlapping kind.
Any chance of a patch to update the docs?

thanks
-- PMM

