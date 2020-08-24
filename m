Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B887AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843122078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/kjwxoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843122078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAETM-0003Qp-Qv
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAESa-0002lD-3i
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:32:36 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAESY-00054a-F0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:32:35 -0400
Received: by mail-ed1-x542.google.com with SMTP id w2so8438868edv.7
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MxMiHyr7H6SdchgEQYZfGNqGqlgDsoQMY45ryw1TG2c=;
 b=E/kjwxoYFMzWwU/7Mwoqk1GsTii2QvNy8Xh2eEmjfJDEErrbhKMSkyZdNe2MnhquAq
 2GdZR3accmYQTSiyJpRgpSkM+9wCe7FG/j66UWXk5xHXEuFR5Cs0n233PkAry0UMkHGj
 V8A6fYnkCcxzs0VNbu37AdKVMRq7hTlh33dtMt1qtx0j/mZKQOqHcyZyiLVC7mBnXnbo
 xDBY0qQH5BHOtzW06+lc82ljuWgC9Q+uFeBAiLj9otm9rbWLCkHFcvePBE+hTDh4U6hU
 a2sDEaaujb1n35v/sx+ucbZMNrhOeBhpQkxqgLW5EYBSPeitGIq+ki/+jao63nOuOMNX
 K3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MxMiHyr7H6SdchgEQYZfGNqGqlgDsoQMY45ryw1TG2c=;
 b=JW+eAHBHCTJXs+uWptL1yarwSFQis9DUvj2kTCUJuWxr8YqUKDm/F06Oi4Np78+RN+
 /xEPIGhjhuElpZ0mbr6KXh05NeV35pTjGbR4JtiHD6BJRv52C7AJ45MXTyExvUyZGPNy
 nUget9oh8koQmreJUOPP2eUpesZY8+KsSmh9obUiNos1yBUDtKZ1VK64P3QnBvfb+fUh
 T9X/sMVWvb9mKtNurflxYeUeQzxWrLM1L6A/W/e2M7isgONxJub/6STvofL9Az1VJsY8
 DHJ6uwnamvGAK9JtgEON2zhzJP8RypZ2G7YGmqXgIVaV7+Go5M1wTjBX6km9JRV1lYuY
 O0Vg==
X-Gm-Message-State: AOAM531Rn7Ixeo3AxYR62sMlJ4vIzOFTH5mYH3wMIKsGsFwW1gEb5dLk
 IJ20TjBzOiXnbZo6wTx9mQPNVey24WijO/CDAY3uCg==
X-Google-Smtp-Source: ABdhPJwuC0PRUfMWyM05YhkLBZr2qNSXQJcpmVtolVu1MDoraD9Rxevip7AtXbKqxWeqpfXA8JhUDrG22DWcQSWwWj0=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr6098219edy.52.1598283152923;
 Mon, 24 Aug 2020 08:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200813200816.3037186-1-richard.henderson@linaro.org>
In-Reply-To: <20200813200816.3037186-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 16:32:21 +0100
Message-ID: <CAFEAcA-8Q_qm2PppzzC4ScraPSwdSvg3fKutAhBT6-89DfRpaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/arm: Fix syndrome for MTE tag check fail
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: andreyknvl <andreyknvl@google.com>, vincenzo.frascino@arm.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 at 21:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Supercedes: <20200812171946.2044791-1-richard.henderson@linaro.org>
>
> We missed filling in the WnR bit for the syndrome reported
> into ESR_ELx for the Tag Check Fail Data Abort.
>
>


Applied to target-arm.next, thanks.

-- PMM

