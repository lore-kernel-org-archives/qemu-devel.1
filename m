Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC96620658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LjEh4UXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC96620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXeE-0001Ht-Rp
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXdK-0000ep-Tz
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:43:30 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXdI-0000Hs-P2
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:43:30 -0400
Received: by mail-ot1-x342.google.com with SMTP id m18so8326092otq.9
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e1iTI/EKHV4E7W5c58FjqltYEmT5rASiRnD4GwRPfhs=;
 b=LjEh4UXJM0XNos49X/r/pe6GxgUDumJdaco9RvC/WZdsgFVCZgNiui6ukF4x7h4ZRC
 rT2xEZUem4ysgqlI4lVs6XjBGUoxNpF0F1LaBhi55cYrbPjUk5o0LYMIzK1MS+ebB+IE
 VJQvIfFYTbmtebrM1zVvfu5ncUw6fjeBC/gTx+QU9pHxF8+2u7CDqaUBbnx7pHiN6Cu8
 t21T6aybM+vgVkUcDrqTCjPgQJIwRjinHmPTmg6DTwguOg+q71rBxGO/bhl6FB++sAWJ
 BofjlQizWfv/VkNzqbcIjJv0QrJ+XZDDRPw5UcP5AadlLxrMioYRAhVVULczxn7bM+Mh
 LYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e1iTI/EKHV4E7W5c58FjqltYEmT5rASiRnD4GwRPfhs=;
 b=Wtn3dtmjzbq+QyZG13CpuelELI1BP1aHVbpSjWXpxAGRQQk+H5/7a5HlB3aaei2R9u
 iFxeAS0KtEBed7YqmrSxPo0kCPJKmyWomads2LlVBKjqETdaGZr9BndqbxEpPyNaL/ci
 l65w1wY1AL45iSNZdLT09phgyKniIjVldg/h1ZoFqZI9l34kf45SwN6PZBMB/QnPlVU6
 CNzALJZ8pGYgdm1p+47/QQ1SLUf5A0afMS+VdLIKnV+3AV4GcSqNtA6Z8jnaSNVGmLuC
 CzctRhIW8yNt/tpRDFcI2zToIKgwQW7z5eED/cGY9ozdCFQFqwuhO/rRf8F/T4whMdcK
 rQCA==
X-Gm-Message-State: AGi0PubQ7NPN5s0YYWWrwsLymRfD2sNlQATlb75DXF7nL5D8mxzXW480
 rHRnhsAQMEtHldzstR57rKjS5kbzzIevL3e+ZdsJ1Q==
X-Google-Smtp-Source: APiQypIZtKYDE5Z8L0dcUk/hyxoP3S+GiWq8rJMAEV4KAeW4uwin5R05hshq2x9a0Kk1ExfTQ5ss+EWe/mlhMTgztA0=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr12871616otc.221.1588585407771; 
 Mon, 04 May 2020 02:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162813.17671-1-richard.henderson@linaro.org>
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 10:43:16 +0100
Message-ID: <CAFEAcA8m33s7e2T0GrZJxb4EyczcEmtW6-tRPoUsiVLO9g8dVw@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] target/arm: sve load/store improvements
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

On Thu, 30 Apr 2020 at 17:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The goal here is to support MTE, but there's some cleanup to do.
>
> Technically, we have sufficient interfaces in cputlb.c now, but it
> requires multiple tlb lookups on different interfaces to do so.
>
> Adding probe_access_flags() allows probing the tlb and getting out
> some of the flags buried in the tlb comparator, such as TLB_MMIO
> and TLB_WATCHPOINT.  In addition, we get no-fault semantics,
> which we don't have via probe_acccess().
>
> Looking forward to MTE, we can examine the Tagged bit on a per-page
> basis and avoid dozens of mte_check calls that must be Unchecked.
> That comes later, in a new version of the MTE patch set, but I do
> add comments for where the checks should be added.
>
> Version 4 addresses some review comments.
> Only 2 patches still unreviewed:
>
> 0004-accel-tcg-Add-probe_access_flags.patch
> 0013-target-arm-Update-contiguous-first-fault-and-no-f.patch

I've reviewed patch 13, but I still don't understand why you've
made the size-related changes in patch 4, so I've continued
our conversation in the thread on the v3 version of that patch.

thanks
-- PMM

