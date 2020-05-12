Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B51C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0851C206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KnCLdlcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0851C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVjJ-00054x-7L
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYViB-00046z-NR
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:16:47 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYViA-0002T9-4O
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:16:47 -0400
Received: by mail-oi1-x243.google.com with SMTP id i22so1731186oik.10
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j8clQVz3fsMWPSciXXBVDCSdAONJh6afu24HoRBgs+A=;
 b=KnCLdlcV1sp4CPmQFjCfCNVcLBgNFeDtF/9qvBPVtyhrWK+Tmjusa6KcFmc27N9bRs
 peJpegl04LGTVatDeRhsMPESqBeawPc6iooE3k1GnUdlbsaqtmI9PZXKQTPC2wPvW7Yn
 RF76ZwOs3MUr02sfBgGtiesvIt5AkClycqFm59Zrm7fpxYf+wrsTQ59Zd6x+Snnvu+Ll
 kdZqwPsoMoLlsgVaR82g/MH5OmqBueb1/2g270v5HDoHR6UAIbgU7TT9+KoRLjjoPqAI
 apIfiyu5+G3DsAfZIOMOsAfD/xfazCl/ddIc7JQMjYtS6RQ+e/0Ca/5TgQ+WB4e5oKyK
 CGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j8clQVz3fsMWPSciXXBVDCSdAONJh6afu24HoRBgs+A=;
 b=kgjzY5EB7avd5hr0XzdCxcmrOEhNYCzJnuGeX6nvkVRr6S0CiSzB8rFBj/kd4JE0T1
 rhzSdtuJLZzrkHdlZDfNQ+tWgqeYpL9SvNMvwM35hwhPklOp0KQtBKPLYpwkc3j3+pOk
 0ry1IPKsPfy3vgu+qUmKHqYmLQ+/Ci1ntoIlu2fVvUL+DDtNZCPxRd1REf1M9YAPXEG7
 xSKN8xHvmLr38stU1F93VbTYxHr8HYdFBJ4RQ8ZzEGG5UYp/kgTZ63ar7gUF+KD7pSJK
 6PYYC43me8NN5dBEYVEtXrJ+a9UuWqtYAClVczqnwNKPtpq3f+lLrVIDA0mc4nUQ6sWj
 cyWA==
X-Gm-Message-State: AGi0Pub2YCuv3EoBO4lmlo9XClxUzpOUnmpKttJAuLZDhSBGVK7tlXUQ
 YqxGI1QPVgMzG2rMsPDVOOLoRA53zX007kJ0sCwBtw==
X-Google-Smtp-Source: APiQypLIa3NHAh6PBNNNGVbZI0mlHZv0MK//OofmJ5WSJD3g0MbeGd+fO73/+hgBog0UsICrGy7s817HIE4wqit8HmM=
X-Received: by 2002:a54:400c:: with SMTP id x12mr22670001oie.146.1589293004610; 
 Tue, 12 May 2020 07:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-10-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 15:16:33 +0100
Message-ID: <CAFEAcA9xg=KfsLYKtd9Y0LejfiPyXhfFzLduXTdP993B2fSszQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] target/arm: Create gen_gvec_{cmtst,ushl,sshl}
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a functional interface for the vector expansion.
> This fits better with the existing set of helpers that
> we provide for other operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

