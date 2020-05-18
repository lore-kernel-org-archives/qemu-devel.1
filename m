Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7345BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4376A20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bv1vXJdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4376A20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai4b-00026M-Gf
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai3H-0000G6-Pl
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:51:39 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:45592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai3G-00083K-Rs
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:51:39 -0400
Received: by mail-oi1-x22c.google.com with SMTP id d191so9347000oib.12
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rFiT5qpbkBwYZEMvTVrbKS1J+r1bqQ31KEqLyDIl3lo=;
 b=bv1vXJdjN4DTrDcjie2LK8JraphtqTpsN9y1bPxwd8Silunzpm/gEXGgfYxVegX+JZ
 fnsJsjiZ8XYeu9Xr9e7LWeH2+QMHnabkB3sRg6kYslKOWjG5SumC1A/LibIgsae21HbM
 8hFcEFu8SWFtpPxgKWXIZOfdYVqo8lAe40StCnxv3VgFy7nJsH4dGZqv2sFY8s5YVLdd
 t9DOW5MNEcxYPTgDrNWNiqWcctZxDNwF2fWfbqRChapkishCVWTCq/xdObn6RhVVZm9I
 MSUM20xZNzifz0f2tGrdsvkSS3svSd9ppOZ+xnVt9myx2CyW9ixdn+/VQtr91HGFzZWo
 UMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rFiT5qpbkBwYZEMvTVrbKS1J+r1bqQ31KEqLyDIl3lo=;
 b=LL4MgDep2YTxImLu8W7Zf3gzIEtLS9VbZivrxT/ot7teGQRa+CD/4stkQ38PdH8GHB
 Q2i9HdJy+YuCmcbfBEh5t1id34JM+0v/ZXQ65PNObWsfro7+5t16zVRXMf8PfMhER5lN
 YwA+Qgkt2sYW7LYqAWJ6QJd+SQGmfU7hctDiFhFGqeUTiW7YGZ5xbCX7Yf695+qmCAWQ
 d6N0UOYidhwW4Qq61nG6VWggnXZ+dJ3xjkeXFpllxD+Q63GO7zRYCZtR0+XllqAhlHv0
 9427nwMMJpBUVF9zolW+AQpOm27h3L8PdSMyZjmPcgSJgTnRVKXg8LRrgF+bzCgZI/xD
 /1xg==
X-Gm-Message-State: AOAM530Tffgnb15MEKwb0c1XNO9Qpu8XeMCfPtFx/5QilhfH+MIOQEGi
 v/mGzSiQLRbwet9GpZo52dEMhIBIKG8o70MOY1a3lA==
X-Google-Smtp-Source: ABdhPJzxyaqhc6pzfyNmH/g1SDCLcyNRkIgQSyGiZdO7hvF3uaMuPR9EHwM8HIuLllQ3IFW6HgMEfdAf+0cWB/uhwl4=
X-Received: by 2002:aca:895:: with SMTP id 143mr11333060oii.163.1589817097700; 
 Mon, 18 May 2020 08:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200513180953.20376-1-richard.henderson@linaro.org>
 <20200513180953.20376-2-richard.henderson@linaro.org>
In-Reply-To: <20200513180953.20376-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 16:51:26 +0100
Message-ID: <CAFEAcA_sT3-CkMh1rVpz4EdXzgoBBmime8JQtOOMQt1heUkz4A@mail.gmail.com>
Subject: Re: [RISU 1/9] Use bool for tracing variables
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22c.google.com
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
>  risu.h    | 3 ++-
>  reginfo.c | 2 +-
>  risu.c    | 8 ++++----
>  3 files changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

