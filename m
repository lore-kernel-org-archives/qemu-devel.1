Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F46FC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C408020663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmWGR9ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C408020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3qe-0001bL-R7
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3pI-00087l-Sl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3pI-0000G4-1n
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:29:36 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT3pH-0000Fj-EN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:29:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id 72so26114158otu.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x/Qkb5v8cgo/2weOxnCaHAa33gDIqaZKELUecVpEeW4=;
 b=zmWGR9otVYO8bNW4gkkqvQfY0ROgPSxNEZlW81eVE0BdApUQwuuJNBslLQZnbw9YS5
 KGIis4k6AYOrPIzp7ZyTahAqebP5bQsiX5irqN2bFdWs6uNJaobT7a5A7GZdxMXvk6a4
 MsjwUkbPbhwWSfiZ2smwuNIrivQUu2C9KZ9MFNd8R5awvC2g6L0trjgelFsOz77CHdpB
 50Kltk2xr3e15MaHSdBa5RJ8H8407C6dTd0hqXrLgC09/J42DH6KOrQlbc8S5yplrdEQ
 fYnmIW4DkHxWtgMaUctsknZLd4tVCa4sO+1q5ZXd0PybDwx2bZd6iZ957UJr8+lNlYrt
 OgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x/Qkb5v8cgo/2weOxnCaHAa33gDIqaZKELUecVpEeW4=;
 b=NMv26qQPuC26zJ7dLmddgVKEVQXSmOfAER6sKH5OSZ8RqENfJYh8OSDmbkKUQ0FiCP
 aIVfl91Ppf1WUuq9buAzvjHwnize5p5ASV4lD7imbw+xvbIGVCXpQSo+933MtyT/P5+a
 6WWQs0Nx7W6C03/F+6FtR1KsI6UGNubBVuq5mbtQK9pq/vIbhNr9HDF5uq3catd4w4zg
 ApxxT1RA+6M/3iWmcmwOwdskYWOwvfmlDGCQHxvcnB0v9S4Nk/VX8YH6PaG38tRQUeZR
 vX/umtvxrzPqYZJrZnuxZZrRNoR+aNz4TUNlyF0Yn52Apaqmu1kXbab2CXac2DLpE9A+
 Z5ZA==
X-Gm-Message-State: AGi0PuZ2XXwqqBKrCs1I9Gsg9vOC+rSsIPzh2QXI6FUOrxVxS5fUeGjD
 J6DnEXtMQwqYr3K+XiO9TjFqCgizfT7ajJFWQiY0mQ==
X-Google-Smtp-Source: APiQypIr4K/LVQ0aIax8phw+q9AV/VKcPGIm9u58QPsv/Vaq+9Aj/g44lguull2qoZeJW1d+tCVV7qv/fO5JiQrpQMc=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr18695784otb.135.1587994173979; 
 Mon, 27 Apr 2020 06:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200330210400.11724-1-peter.maydell@linaro.org>
In-Reply-To: <20200330210400.11724-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 14:29:22 +0100
Message-ID: <CAFEAcA-B2t_Wyt=QJC6R19MotBifrciaf3BmV=P6uWhSoi1=pg@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm: Implement ARMv8.2-TTS2UXN
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for code review, since 5.0 is nearly out the door...

thanks
-- PMM

On Mon, 30 Mar 2020 at 22:04, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This is obviously not 5.0 material, but I figured it would be better
> to push it out for review now rather than hang on to it and forget...
>
> TTS2UXN is an ARMv8.2 extension which changes the 'XN' field in stage
> 2 translation table descriptors from just bit [54] to bits [54:53],
> allowing stage 2 to control execution permissions separately for EL0
> and EL1.
>
> For QEMU this had the potential to be awkward, because it means that
> the stage 2 translation now depends on whether it's being used
> for an EL0 or an EL1 stage 1 access (the address doesn't change
> but the access permissions do). Fortunately, although we allocated
> a QEMU TLB/MMU index for Stage 2, we never actually look anything
> up in the TLB. So patch 1 turns ARMMMUIdx_Stage2 into a 'NOTLB'
> index (ie one without a QEMU TLB), thus avoiding the complication
> of splitting it into separate Stage2-for-EL0 and Stage2-for-EL1
> indexes. Once we've done that the actual implementation is pretty
> trivial -- we just need to plumb an extra 's1_is_el0' argument
> into get_phys_addr_lpae(), and then use it to decide what to do.
>
> Peter Maydell (4):
>   target/arm: Don't use a TLB for ARMMMUIdx_Stage2
>   target/arm: Use enum constant in get_phys_addr_lpae() call
>   target/arm: Add new 's1_is_el0' argument to get_phys_addr_lpae()
>   target/arm: Implement ARMv8.2-TTS2UXN
>
>  target/arm/cpu-param.h |   2 +-
>  target/arm/cpu.h       |  36 ++++++--
>  target/arm/cpu.c       |   1 +
>  target/arm/cpu64.c     |   2 +
>  target/arm/helper.c    | 183 ++++++++++++++++-------------------------
>  5 files changed, 107 insertions(+), 117 deletions(-)

