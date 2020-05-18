Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C48C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435E820758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+tqQ6KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435E820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai7l-0000YK-E4
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai6Y-0006mJ-8s
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:55:02 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:45683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai6X-0000JW-HJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:55:01 -0400
Received: by mail-ot1-x330.google.com with SMTP id c3so8420130otr.12
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GIfdXjuGxeXNsNWvoe+0kSXaOm4lf/M9/AGS3/3uPRo=;
 b=D+tqQ6KZrvLcLzaM7gSuicvui4Dev3TrdT9cO+Bz40lTXCQYcnY2rV7Fk4scAoTeph
 qqaEyiJAuZrug0cyVq5II8hR5W6FB30qvqCg/JI7fMxGvsONUnrAL/eBpC5QBYrzHeFB
 mMZZT1qbiN2TciojaZgxmriSXFiOpC13coxPfZweHoEueHXxlP0ThmGsYwA12mqhQK7u
 W4pbZwqIMpKs45OOzCYyZvVimtlC9SG45l1JpDoppz8v6LnYT0Ow/kXANZ67EkqvzoVF
 1XHlau5NRQNwQotC5i8STgWjei5KRl4pMtPaPN0rvCCT1jZxjRrPCV3Bje4nogpOqanv
 JdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GIfdXjuGxeXNsNWvoe+0kSXaOm4lf/M9/AGS3/3uPRo=;
 b=qyR9Hc4VoGyk2OsPmYawChQ3/oqqV7hvXyAxk/dQ5iyCCPV5X7quGdpi0AVNS6pJ+B
 HllRZ54JVCcoVhWl70nZiMN143SoMT9E11CXB0sKpwBEUCEiUhairTkaC8YBXKH3DLOI
 adFwNHZFOl0D17DqvjHs0VupQLpSSU13LBBFYnqfgvb22yLNGvz+2XnCbkhAX2QTyFdt
 OtKXLGvoul6fL/w9R9i17aEUHrjYPb8XTgUzrnI7EgsyfVbWz5JO3Oa5gc7PZJPjh0Ya
 ow8KUjbzeandwb0AgucJl45fmfwB0OZ4N6leRXwV0D3z1zM0Ncohn6z5+7JSzvDZO8f4
 Y8KA==
X-Gm-Message-State: AOAM5314mWBgaSHOxVf9RA0eMnwGEOt0F0OZZJa+bwg2lBd3XXr//Ah9
 Giw2+kmOQuuGmBuYqI9YJxWV0L2iB7iffA00nOU43g==
X-Google-Smtp-Source: ABdhPJwKMeRfr3qLRWvBGPqbNcvU8e0nSsgQMjYYJHnHamM5j+QIE89x37a6YrtBdVNaUw+pKxb2T4qWVbOgOBDBJSc=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr10956914otb.91.1589817300413; 
 Mon, 18 May 2020 08:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200513180953.20376-1-richard.henderson@linaro.org>
 <20200513180953.20376-6-richard.henderson@linaro.org>
In-Reply-To: <20200513180953.20376-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 16:54:49 +0100
Message-ID: <CAFEAcA-pKnqGywy4UACdA0eJfNqiWOahka3C1hwP2JmndJrOfw@mail.gmail.com>
Subject: Re: [RISU 5/9] Use EXIT_FAILURE, EXIT_SUCCESS
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 at 19:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Some of the time we exit via the return value from main.
> This can make it easier to tell what it is we're returning.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I don't really see the benefit personally, but
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

