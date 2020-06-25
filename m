Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0D4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EEE20702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sgToXK+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EEE20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRfV-00023S-AH
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRYA-00081p-Ui
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:04:19 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRY2-00060x-26
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:04:18 -0400
Received: by mail-oi1-x243.google.com with SMTP id a21so4854899oic.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=569093/Kxu0KVnbPnEOnweQ5Th0thrkKMk/C2CHOZm4=;
 b=sgToXK+kwz56sR/hmepJwigKArcua0HblXUVGssmGjIrapMgzUaZfL54UmiwN5xceF
 KmJTDj9TsSrU9thk7rfyNTLXeivz14LEKLk3XrYTVQIxPw5djyHxLWEShosN1LX5ykuz
 UC5EaAN8cEv6NOSuMgqLARziHw3WtksxWRsEaXMbOdvaLPQKDYRM7OWtzyFYoenxYigm
 G5Fj1ZLKia1ZZn6+HZnU5K+yp2QSaj3+koo19EAu13fKT7ex8aIDA313tQfh/AnjmM0j
 H1p0eVGgdGAYZ1FlLI1tdest6Ryw2yqNBCzuQOM+B51P9GoAnCq0dcx/tolm8os6ujqx
 zXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=569093/Kxu0KVnbPnEOnweQ5Th0thrkKMk/C2CHOZm4=;
 b=BZdE8VnnP0UpbUcslBTHgmrlOusUlU+Tlmr+7fW1qM4naJiMHV4JG/4FfgINJlWFW0
 mYW7ZYbyAbJ4379eNsZ2sY2u/gIE6IynrNbtw8T0gmWOs6gEWnLnCC0LMkKWdy5KWPgf
 x9JpLyJWpbq5m8tOj38ZoZeD0LSlMsNQAHuuv8ZBhtCHAoO9TKVwO9KVc7pA/NDvGWWG
 CPn7wPy6Z8Tt0kl38c04PcfhTVXoON3h6b3d0CI/SPUvDe4si9Wi1Oa7EMI/zLtz2+ru
 Tz9QRmCjg9hyxPLfeDwe71Qiv5k2DV7SLojawT6NGWBv+j2jFb974TTAtXCfBjDkojTH
 25Zw==
X-Gm-Message-State: AOAM532j/SmmAKh4Ynispip2R4PQ/WtcAqF0RNH0nVACCwWP17ebtEKs
 6JDKMUaQS2+bY5+Af8Ku+2GC/u0OAbHrGRWV3V8I/A==
X-Google-Smtp-Source: ABdhPJxNRqFO8vt3eXkRXftzD6nxCQDK8OOaLgGXyr8XzhrBIWn9ukj+elDs5gdfC/Nu8JBseRcC68WLPvSa8SF2ahU=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2048029oia.163.1593090247077; 
 Thu, 25 Jun 2020 06:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-45-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 14:03:56 +0100
Message-ID: <CAFEAcA_svDHEDP5g3aaEL6_b-8hy0AB8oRBWj=y6G1K_r6E9nQ@mail.gmail.com>
Subject: Re: [PATCH v8 44/45] target/arm: Add allocation tag storage for
 system mode
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Look up the physical address for the given virtual address,
> convert that to a tag physical address, and finally return
> the host address that backs it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/mte_helper.c | 126 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>

> +    /* If not normal memory, there is no tag storage: access unchecked. */
> +    if (unlikely(flags & TLB_MMIO)) {

Comment says we're checking a memory attribute, but the code
is checking for TLB_MMIO, which isn't the same thing.

thanks
-- PMM

