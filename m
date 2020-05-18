Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1DCC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18DC20826
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDl5CqI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18DC20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai6I-0005V1-2y
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai4Y-0002Vu-JS
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:52:58 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai4X-0008Ki-Hf
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:52:58 -0400
Received: by mail-oi1-x241.google.com with SMTP id r25so9386869oij.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FHGbHiL/9TfNFj+9b0fADCs3SxAbpuuNL8CUpJ60wfU=;
 b=bDl5CqI9EcwhUJaxu7JmbLxpagXx1iHBupca1k3cytZZwCpeFYap4cYw7A+zZTBV7N
 4Dk8h2LGznFT/mqiB+lzX9BcglkEu8vaMNG41gRzXutKzn1uLRs4DB2riD3bvakPH5Cu
 ZcLVpT1NI4xzjl3VLhtMzN7hIa77BvMANVUldngToUaEtsjTjtCFW/1RLqqg2YuJVzCh
 q6C/iRKF5L5roylXHAVQEjA4ITRFYqbfHOnexewmmV4Fgp0o/J5MU7Y06Tq4Q5A+8DMS
 lE+h0w8+8Q5pDH5BLl1Y+iA4KwwzksN+DLFkIOo/8Kk9Z7t2y7QR9+8zPMrUSLeUpMbv
 wfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FHGbHiL/9TfNFj+9b0fADCs3SxAbpuuNL8CUpJ60wfU=;
 b=CjyBxVx2bvNDB9NEEW1J2ruOFVMA+zUXu85dvO1GhxowNvgGgrh793buZCg5gOXcbS
 uSXbcI1aCgHuf2Rw3N/8XdSLcpgqQDIAU+xpNsBdUy9wLrIBKq19t4dVhUWE12FxGDOt
 aKhOR8yB1g7u2muv+fTCuUVX7sUdOSXqPnJx8b8Hd82pq3F9fFn23f5qVoh6rI4dBaEy
 CyrwxYAQXoZxxJ/UzNbtQzwId2GYqDAcdmHI7/aawbAR4IMucZWU8pKr5tEOMMxrDTuL
 xibpyr7XDOR/xltU/qHd2vEi539haNUzYbUZE5vWaArpOcIINi3ArjeNU8/c3fxMvfXf
 +lUA==
X-Gm-Message-State: AOAM531SD/PhNvBU9u3Kic9qdhVO33wMqWX04y3LvqR3fsiaLIXXAWxb
 FW5gUlYVbpGeN/wDMgc4qiW78n72123rAp4vV1Uvyg==
X-Google-Smtp-Source: ABdhPJxhOz8rCZLmPd0MvTLPtLXenUXjWakPb0QTRAdAj8K5yYhl2pGBK2K2pi/PXlo9O5d03O5ZEyTykd/meJ6NUiw=
X-Received: by 2002:a54:400c:: with SMTP id x12mr20306oie.146.1589817176244;
 Mon, 18 May 2020 08:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200513180953.20376-1-richard.henderson@linaro.org>
 <20200513180953.20376-4-richard.henderson@linaro.org>
In-Reply-To: <20200513180953.20376-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 16:52:45 +0100
Message-ID: <CAFEAcA-PL7zxXYkD_KXyBzOFrCVnFKxkubAHec_xCdVgDeje_g@mail.gmail.com>
Subject: Re: [RISU 3/9] Hoist trace file opening
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

On Wed, 13 May 2020 at 19:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  risu.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/risu.c b/risu.c
> index 059348f..1c66885 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -363,6 +363,21 @@ int main(int argc, char **argv)
>          }
>      }
>
> +    if (trace) {
> +        if (strcmp(trace_fn, "-") == 0) {
> +            comm_fd = ismaster ? STDOUT_FILENO : STDIN_FILENO;
> +        } else {
> +            if (ismaster) {
> +                comm_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
> +            } else {
> +                comm_fd = open(trace_fn, O_RDONLY);
> +            }
> +#ifdef HAVE_ZLIB
> +            gz_trace_file = gzdopen(comm_fd, ismaster ? "wb9" : "rb");
> +#endif
> +        }
> +    }

Looking at later patches in the series I see the rationale.
We should really be error-checking the opens here, but that's
a preexisting bug.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

