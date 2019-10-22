Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6449CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BC02075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mdkCE2+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BC02075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMtaS-000116-TV
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 08:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMtZX-0000V0-JR
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMtZW-0001da-I6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:47:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMtZW-0001dH-Av
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:47:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id o205so14000689oib.12
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 05:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1OweYMXpkSlcHwkbtejrWkUiib29y0AOj+d1bjILcpo=;
 b=mdkCE2+rejlb6OkJOL64fc7ajE61s+m1Ki9M/WNHbVizLExNifmarOirN80KiF2MgV
 GK+L8cWf8e7I7K3KoH4lPLh2uXuxmT/Xsj3UQiUPgGnwWvXkqrI46eI0XS+k6wPz8f6O
 Rqwr0VcTmV3Jw1GVLUky8P1qAskY/BOHfe7ePzM9kwgNuh0Akx85IiS7cz4bCvOIwvMn
 VxZtsnaSfZFITWX1HxBQtMWk/uttnPv88U/2sBVbelVltrTuFQ0lIE0bxI9SGqgZz00H
 J7SmdPlxp/l+8sx8aZDRfU+562LbU4zAi+8AKHaYYI5xHkVxyudlLPG8vfCai3erUoa/
 mbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1OweYMXpkSlcHwkbtejrWkUiib29y0AOj+d1bjILcpo=;
 b=NRcxNZUB7HV3cO2+gNHyBTGA13DShSX+3fHMgg/UXc3EEs8mM2Z+px5BH6HOrKBPsc
 jWqmhRo8hpCwLwDyJOinOCC9hkJfaTYozRR80o9GVgcwPen1ChdzHLxEFTVMdBit7Qmd
 HgiOp+IUMC6eFqR0h4wBrky7BgbM6z36/z8ME6j1zfQa7w0rikbDd0GQ68gKLWUmB4AW
 XpcXMkFgXMYhkI5kIQ1oPPGDKxW1V+rtyitesZ54tCDpy4cec5ixybKgEiI8Z9ZRK7gc
 k++jilHD+K9fksbhhs04m4/me/1AImLeF7X6t7oTUdt6sDOuT3c0RKvCb/9cs9XPFhDF
 ASmA==
X-Gm-Message-State: APjAAAW6owhEaSXqW6WdE6oZbVewko/SFAJvqtnPlefL+OLaSAeThs9w
 rfZwq8uyPs5B9HoA6QYre1kuXdqO5s6bxTgzjOlWjQ==
X-Google-Smtp-Source: APXvYqyTUjBRJQSQvS2zu+aCJts4DNgy+k5qRDfoqIlG8MwuEVA5OxCTCnGlBP1Q8W+pHNHM90qCj23Ayi49e/CJN5U=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr2849839oic.98.1571748453478; 
 Tue, 22 Oct 2019 05:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191018174431.1784-1-richard.henderson@linaro.org>
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 13:47:22 +0100
Message-ID: <CAFEAcA-MyKoA63UF6DYQ6J-dKihYn9iyG09eFCgWT8j4OqsQnw@mail.gmail.com>
Subject: Re: [PATCH v8 00/22] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 18:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes since v7:
>   * Rebuild hflags for all successful nvic writes (Peter).
>   * Rebuild hflags for Xscale sctlr writes (Peter).
>
> Changes since v6:
>   * Regen hflags in two more places for m-profile (patch 19).
>
> Changes since v5:
>   * Fix the debug assertion ifdef in the final patch.
>   * Add more calls to arm_rebuild_hflags: CPSR and M-profile
>     These become two new patches, 18 & 19.
>   * Update some comments per review. (Alex)
>
> Changes since v4:
>   * Split patch 1 into 15 smaller patches.
>   * Cache the new DEBUG_TARGET_EL field.
>   * Split out m-profile hflags separately from a-profile 32-bit.
>   * Move around non-cached tb flags as well, avoiding repetitive
>     checks for m-profile or other mutually exclusive conditions.
>
>   I haven't officially re-run the performance test quoted in the
>   last patch, but I have eyeballed "perf top", and have dug into
>   the compiled code a bit, which resulted in a few of the new
>   cleanup patches (e.g. cs_base, arm_mmu_idx_el, and
>   arm_cpu_data_is_big_endian).
> ...
>
>
> r~



Applied to target-arm.next, thanks.

-- PMM

