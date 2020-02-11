Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06691C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29A02086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W40WW+bM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29A02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aUg-0003a6-1v
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1aTZ-0002fs-IC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1aTY-0003Be-GL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:41:37 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1aTY-0003AT-BU
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:41:36 -0500
Received: by mail-ot1-x342.google.com with SMTP id p8so11120040oth.10
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yCMU31N7IVyNHuyuF78ZH1xKkUksoiKLmXOgmlPKvs0=;
 b=W40WW+bMBrtNlJjX1eUlCLTMWJXM6DPhaXWqyO1RTw7uaLCjFHi7Fi/F3jgFVg7zMa
 36vd08FJp+moWmUtbjDD/KLfEcIIPX3vWHadbL63XqD7Zt9QWauOw23FhZ3HNyEG9krI
 e+i97HEaBOO5FJBP5WwRwfmmkdutFfMwKFDwvtGDOgY17iYRD6ZSo1eTI4k5JEeDGIbf
 g+6X6fzv/Lk35zxXKi7gin6erEywGbYoOta/NlrHlhInlknJOP0YTqVw6Hmy6C9oVK+g
 FTu5Kv5HPpXYYNVTLiZVGyVs4S/7TmX/ZX3cBfALZ3VO2Rx2FBA20U35xoBo5/5idAw5
 tpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yCMU31N7IVyNHuyuF78ZH1xKkUksoiKLmXOgmlPKvs0=;
 b=KQjzkB5XV1vMAD4PTIQirCfD9A0oOpWK7SK/S/CRDgp1LCluMjO4l8H7CUD+oAidmr
 O19yrFOw7AMYC6CU5oHPslY1X5IASXPYpw/cJYquJGebFDNH3gRZEySBEAAduN3i7WZw
 2pMYxmSmFK7VLyxHXrZEH1P/hQsAx5b6oB2lC6GEKIkY1Go1aWWF1dX8+U0/BR+OSR9L
 xyZejbn1+x1ZAC+89vpLhT/GIuJMJEqWVuHOmFHZYvtTOKVeFKWL12cQoc7gzn0s4hDx
 MQjFxltXCokXwXdQb2CHKh8HhDOSLJ+1h28mLOdp8JwqIeHBAjsSkM674nSq5ELhNbqa
 0Ydw==
X-Gm-Message-State: APjAAAV6/Hl09RPGq87tNRGGMTFXhuX9EhvLKu5s0lrbfxBL/2l7TER1
 R7X2CZOWmLQJX0UT41rK4ThCTgWHJPDzb7ewSH7v3A==
X-Google-Smtp-Source: APXvYqxEouJ3ioesHW/UG0zXWv75+xWFyFkgw/htSlLMvQA+L0Qpz+qsO+eWdLIixj45txPRaIc20AOsYuZYo2HkqwY=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr5896144otq.97.1581446495590; 
 Tue, 11 Feb 2020 10:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20200208125816.14954-1-richard.henderson@linaro.org>
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 18:41:24 +0000
Message-ID: <CAFEAcA-zRRSUia6Ls1WGJw5_QLsgkz1KqJnJBESsNv-AbS633w@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] target/arm: Implement PAN, ATS1E1, UAO
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Sat, 8 Feb 2020 at 12:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: https://git.linaro.org/people/peter.maydell/qemu-arm.git/log/?h=target-arm.next
>
> Version 4 incorporates the feedback on v3.  In particular:
>   * Split out CPSR_J masking to its own patch.
>   * Merge trivial braces formatting fixes into patch 5.
>   * Drop "Tidy msr_mask" patch, leaving CPSR_USER handling alone.
>   * Fixes for EL3 in "Set PAN bit as required on exception entry".
>
> Patches without review:
>
>   0005-target-arm-Split-out-aarch32_cpsr_valid_mask.patch
>   0006-target-arm-Mask-CPSR_J-when-Jazelle-is-not-enable.patch
>   0009-target-arm-Remove-CPSR_RESERVED.patch
>   0014-target-arm-Set-PAN-bit-as-required-on-exception-e.patch



Applied to target-arm.next, thanks.

-- PMM

