Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F9EC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C77720578
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4qqU3wW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C77720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs67B-0001wR-J7
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47774)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs66b-0001PZ-7J
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs66a-0006QC-9W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:54:25 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs66a-0006Pn-34
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:54:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id q20so62528959otl.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D94d0FaMRBU/A12jdNzpAFYDLjU+Bo/jgqqx0M39XkQ=;
 b=d4qqU3wW8Uz5k/FJNUrjLQAUVcvJB6e6iaFR6GE6f8SrlKEsT+udHMxo/f8sUc7zDG
 8ZKNP4JiRAHIBew2PwdX6FTD1iSabVYIPIQHvmeXdB8QVA7YAIUxcDuEIpioh4B0aHOj
 9CX24QPGVFvAqHezC00htuxOyu/PDJ624scw6bTGX0so8xcCw25tI1LJ+6eJrbNYf6Ky
 e06OGIzntEo7N5Rzg8ewa7y5uoOahv36tU9YOe5oDr+QIrKUkqTdOJby46FnAXWw3uhq
 69odoR2p0ft2jLGd1GTcbn09sEVEJWVkriUEuOgRq+HXgNzYF7ty386NfjLQPNL/7rtp
 HOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D94d0FaMRBU/A12jdNzpAFYDLjU+Bo/jgqqx0M39XkQ=;
 b=kqqM5A9q7BM20y0c4afo1cD27Du9NJ3woil3EewVrTNEVTvxcYeImOrFUztyqi7wZ2
 h0sVSx1JeNNBdJIxtgQjhPfc2ct6L/RcRq6Djgs5ayfosbF0UP0dpzqIybrojLQ1NJMl
 6k8WplgdulFUggemQY/KzrqLOa87q+SD7TzPIoUjY6lz3ybQtpvd9gbNihr2f7TcHvKD
 vzHtwJmKiuXUR55HP2CQ088moFyhBsCIVyIjcf+NKjQrMFjZzjZaEsM/HRHp+OegNxRo
 gH0KdLetbbj9SYjfRJNKfYvLE1cOfDCJKIxKBH21js2gt1lNmlFseOmoPHpyPAGAmLVp
 c7Hw==
X-Gm-Message-State: APjAAAVsi9exaj4qXR2KvzL78YP+ejsTkC7Gf9LyMY67KNNJ25u32T46
 +cKftVz2rI4WrcrIhf/5Rlzc8g19yeBuB+8V0NlcSA==
X-Google-Smtp-Source: APXvYqwZFLloC+kkN3VAbttm2CwB9uD1ErF5DbJPb6CJ9n6blephgO1sQ+6nyqHIPcjIGY6fgTLUxUq5v5lzq80QzHs=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr239175otk.221.1564408463061;
 Mon, 29 Jul 2019 06:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-6-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:54:12 +0100
Message-ID: <CAFEAcA_7MCLuBPz-OQRCcdf02S2mqqVT5nmP+i6k7SAcdGkutQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 05/67] target/arm: Use the saved value of
 the insn address
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The address of the current insn is still available in s->base.pc_next,
> and need not be recomputed from s->pc - 4.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

