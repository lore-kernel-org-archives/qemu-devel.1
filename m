Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A322C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CCE217D8
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsT3VuV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CCE217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP4YB-0008GQ-Bw
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 09:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP4XW-0007X6-6l
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP4XU-0006sG-PQ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:26:45 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP4XU-0006rk-KB
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:26:44 -0400
Received: by mail-oi1-x243.google.com with SMTP id j16so16533826oih.10
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uFVmbDLrbvji1ltWxqDESnl+8YxWAHHZJL+vVC3Bh8A=;
 b=DsT3VuV61KgYhaZsitF77PoUPQhJMXIGtTMm4vRsLqu0MTqhtw0HGK/vrVdksNjlCV
 14Fd5XuPEcXWueaYIwFLr9LzWMdE0LQrYTG//5AbhmvLplyGfp1YuTBuH5gT6pxx8y8P
 o3gfMVh99V+Hr8T2TvGnRJYCSQdXNHBXggoXxcxAhfALUhcY868at54ngO2XEbrNokeI
 uB63oBqj4O/BLKAQ5tCqfs6JxG85W9HRDGcq4lLUVHJizyikVqIFdB+OamUFxeJIVetQ
 Zfb3XOEMgAIG7eAiALPLcpCBqIpahFxl+SyohS2X6YtYQDczXWSHcCyEClmX5IQXDcG1
 5L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uFVmbDLrbvji1ltWxqDESnl+8YxWAHHZJL+vVC3Bh8A=;
 b=BCkMYjz6+axFIaTGETsGgNVAnxBFBg0Q2RUZX1e70Zf8JJSN0CZe0mR3KsDUFStAxO
 OqpY3LF9V4EDEUlsbrdKdguRJGcuU3Mo8pQAVeCXEMeb5WWCk1ZZTQ/8z6blBuVP8k/o
 hPqpCOoGDggstJBLICukuF3ULqZwDP/BJ7Xgb8R6a9xluM+Y6wVBFDcOYRWOwGnkVAUB
 jIS3SdJQ/L/TQl8liVxDcXaZVdRoVhiMuQPKQpmIIGRpaqikvs2T98V/KpPBdwJeT4KB
 AuBVpK7dant2X0urGsjq8bkLUolthk5/N6iubdx/+gdKhx5dfid0Q1mHuXL/MRbjvfL3
 PmDA==
X-Gm-Message-State: AGi0PuZNkoB7WmBbp+se15eR1/c2jyRB9TU0wIS2ZAnDw3Z2t3GXYj4C
 vyTBYQS7pw5wyY2/EZD6/0E4iX8Oe3Yo0DY0CXZ6Bg==
X-Google-Smtp-Source: APiQypItnxGEmio7CESklPyhQ96hslCP15+GdE6Z8uKykgie8yeLDjkBZ0EqLbQ+xYU+KUhK6OzCAIEPKE08M1tdAhs=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr2714437oia.146.1587043603300; 
 Thu, 16 Apr 2020 06:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-9-richard.henderson@linaro.org>
In-Reply-To: <20200311064420.30606-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 14:26:32 +0100
Message-ID: <CAFEAcA-v9O6+iZu9_grS6iW=QhmJeLGVfnJ8BOe59KzaPMczzg@mail.gmail.com>
Subject: Re: [PATCH 08/16] target/arm: Use SVEContLdSt in sve_ld1_r
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

On Wed, 11 Mar 2020 at 06:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> First use of the new helper functions, so we can remove the
> unused markup.  No longer need a scratch for user-only, as
> we completely probe the page set before reading; system mode
> still requires a scratch for MMIO.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +    /* The entire operation is in RAM, on valid pages. */
> +
> +    memset(vd, 0, reg_max);
> +    mem_off = info.mem_off_first[0];
> +    reg_off = info.reg_off_first[0];
> +    reg_last = info.reg_off_last[0];
> +    host = info.page[0].host;
> +
> +    while (reg_off <= reg_last) {
> +        uint64_t pg = vg[reg_off >> 6];
> +        do {
> +            if ((pg >> (reg_off & 63)) & 1) {
> +                host_fn(vd, reg_off, host + mem_off);
> +            }
> +            reg_off += 1 << esz;
> +            mem_off += 1 << msz;
> +        } while (reg_off <= reg_last && (reg_off & 63));
> +    }
> +
> +    /*
> +     * Use the slow path to manage the cross-page misalignment.
> +     * But we know this is RAM and cannot trap.
> +     */
> +    mem_off = info.mem_off_split;
> +    if (unlikely(mem_off >= 0)) {
> +        tlb_fn(env, vd, info.reg_off_split, addr + mem_off, retaddr);
> +    }
> +
> +    mem_off = info.mem_off_first[1];
> +    if (unlikely(mem_off >= 0)) {
> +        reg_off = info.reg_off_first[1];
> +        reg_last = info.reg_off_last[1];
> +        host = info.page[1].host;
> +
> +        do {
> +            uint64_t pg = vg[reg_off >> 6];
> +            do {
> +                if ((pg >> (reg_off & 63)) & 1) {
> +                    host_fn(vd, reg_off, host + mem_off);
> +                }
> +                reg_off += 1 << esz;
> +                mem_off += 1 << msz;
> +            } while (reg_off & 63);
> +        } while (reg_off <= reg_last);

Does this loop for the second page need to be phrased
differently than the loop for the first page was? I was
expecting the two chunks of code to be identical, and they
almost are, but not quite...

Either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

