Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42355C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9292080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1lPrmy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9292080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxSC-0000JN-BM
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxQh-0006FZ-1a
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:30:19 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxQe-0002AT-FU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:30:18 -0400
Received: by mail-ot1-x342.google.com with SMTP id e5so4991886ote.11
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qd8diK4G6IguGXmqangBheq2zhTVbXCdk9eDcRP7wZY=;
 b=d1lPrmy1RUThdZO4jQUnA+r9syx2gtRV2acBIDswrkzVhtpOoGqS6Xq71SWcUMMmdq
 arOaiGqSn7pN+nnhxrqCufzY4ZJouXv2mNsNkNoOqJZHL/UBdfluvRwaLNe7DBb7p8I4
 ocrZFnl+2R9bCBeCKiwU3kfWtiAhqxXa9aRQEse7xpQ+P6O3EmZAB5No8Y8JqSAfWdDK
 05FnMJDHds64driWc5/6U803KzoWN9CRpbkWVXC8w2MKjmNxhS7ViRXlXzMeIv7cB/Kw
 5+8GwROK8C4MKz1qXfFPv93ZV1zV/VHrcO4j1XGkcEtkCINPfaARA3LdVWS5M4MZNGQZ
 +aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qd8diK4G6IguGXmqangBheq2zhTVbXCdk9eDcRP7wZY=;
 b=qG7DbepN44k31TsitXC1c26NNTK3kp6gCBViUElf8XHa2IXvm8YBpFzv8xwW16NPDd
 IOUcH8NkjMZO9L1m4ZGgJD1V8R8arHHe+67CDF9lCPEvJ3nZnjppAODTKTJmLQFSfIpP
 WhCFJaKGsSUZ3Ee/oR05RuvruCTF6WW5sgaopcM3iAEQJi9kXOqud5kKo6FPkOO+qlHa
 KTmFSLZh/QpoRBxormkR/8pN68dRk+qXYJZaBB7YVYEq4A3vkaNf9tTwXjNdjGI+Hq2w
 Xka1JAdvPX/VUnUO59G91ymHgz7sTsSfpBsWFnsX2K6WljjTcR1rANJhHDKeate9qGrL
 tIhQ==
X-Gm-Message-State: AOAM531AEoWs+kfQ3PnaBkW3w5iNHbg80teV766v8XhMXlJhJxh0wxg8
 k6RimOKsLkCDGf+OQNIcE6JODeUTeCo2DNlOn6IVp25Zy24=
X-Google-Smtp-Source: ABdhPJxH7qsIpEMYwryTUYcHVJKWuB8Q7l0p0nrbRVQbZI5abS1rsi3aZSi7hKG64U0cz4FsPWxF1SX+CDtZVxXfd2E=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr4204046oto.91.1592497815358; 
 Thu, 18 Jun 2020 09:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-23-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 17:30:04 +0100
Message-ID: <CAFEAcA8MJW00H=NmAs8AXLWJ-e28c+GVYjNpwigLBeL5JiULVw@mail.gmail.com>
Subject: Re: [PATCH v7 22/42] target/arm: Move regime_tcr to internals.h
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
> We will shortly need this in mte_helper.c as well.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 9 +++++++++
>  target/arm/helper.c    | 9 ---------
>  2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

