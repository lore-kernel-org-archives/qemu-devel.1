Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA08C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CCB206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7XG9Eui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CCB206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV0Fs-0005od-Cv
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 16:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iV0E7-00051u-VY
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iV0E5-0000xV-SQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:30:59 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:38643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iV0E3-0000ug-SQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:30:57 -0500
Received: by mail-oi1-x234.google.com with SMTP id a14so3233256oid.5
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 13:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lrDyOei8USiE9vbmz3ztTpn5Ak87M4FF0I6TF+2m+VE=;
 b=R7XG9EuiAzad2/wTwgp28A5XC5X1t0xeTEPEwDFjKAlnu72HcBtDrR6Wrd74haZj9N
 TH8kg53a9AbSzypjYmwWHy2qKJqgtCXRurDY5b6JRg0YW24e7sqOAWV2zrIOW7zp6AaS
 /9XLg7saxVleWe8OkSsShirrv3168a6MK36KJA6RP4Vp5WdyQLOPYU1tsxiyXUh2tGa3
 0UZRGYAyajQtD11+cJsBR1zzoaAy0+QNnmaksDDjczxaC2UDewxvNsKRzxcg66Kd+Fns
 WcMKUVz9N+rfM1lflAYO0P/hNJmey0F44jFQvI7Ctds2JU73BzMxedI2qqUhS6urT8E9
 I+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lrDyOei8USiE9vbmz3ztTpn5Ak87M4FF0I6TF+2m+VE=;
 b=LubwCbBhL/mMPhXTKBhsVA+/HZZrGKicEtAVeYjR9H1SyLo/OOWT7oACSdH4P0mP/F
 63WBeqv94dsA8iODZTaAk9uz4rak6/CKvBBQ6G/S7AfbdHtuZmpW/hBuAb1yQl7qeFNT
 IfZ4GLAQg3XdsmcYrIxbNqYViFlyMYUrPAKGMGJ0+lV2efcx9ZDb/qSBKLC0yebXW8kq
 A+px7E+O2oMGJViMi10N62qY1u6aHw7RSnvMlW5xB2s0CpwPcSGy8XegT5M0G40cW2xg
 U1Wuw4sOEBAk8GMG+hsd7ZT3dhJFh9tNVcyTqotfYbV7K4qP0B6nCXhQV/+Uh550bH/I
 GOaA==
X-Gm-Message-State: APjAAAX/r8oaf6LZxgrJsZrsZh1KcCwIOXbhPLPV8CW/GzJ5zasWTz6O
 INjCLs0yzyibIQnjKxFm9NH8qP6RKepqYy1tMd4PDQ==
X-Google-Smtp-Source: APXvYqyudXboIiQ2e2m0CtZoGk2JBnubQ/kUq1hN3kfsYVSNbMkbLGM3xNngfz0EdTK2Nl5SYJQk8ep9oGM2zah/nhs=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr624128oij.163.1573680652658; 
 Wed, 13 Nov 2019 13:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20191101085140.5205-1-peter.maydell@linaro.org>
 <20191101085140.5205-5-peter.maydell@linaro.org>
 <CAFEAcA-xYWLzsfDAWWmEk4DhXcO5zqKVZMrRp9=4t9MBAasaMA@mail.gmail.com>
 <ac0c7520-2f6b-fb49-c725-37b46272c835@linaro.org>
In-Reply-To: <ac0c7520-2f6b-fb49-c725-37b46272c835@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Nov 2019 21:30:41 +0000
Message-ID: <CAFEAcA9KwEzNoyugPNjqBmOb-F7EWWJ=0kf6ysD3mDk_R9v=DA@mail.gmail.com>
Subject: Re: [PULL 04/11] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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

On Wed, 13 Nov 2019 at 20:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/12/19 11:23 AM, Peter Maydell wrote:
> >> +static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
> >> +{
> >> +    uint32_t start_vq = (start_len & 0xf) + 1;
> >> +
> >> +    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
> >
> > "Subtract operation overflows on operands
> > arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"
> >
> > Certainly it looks as if arm_cpu_vq_map_next_smaller() can
> > return 0, and claiming the valid length to be UINT_MAX
> > seems a bit odd in that case.
>
> The lsb is always set in the map, the minimum number we send to next_smaller is
> 2 -> so the minimum number returned from next_smaller is 1.
>
> We should never return UINT_MAX.
>
> >     return bitnum == vq - 1 ? 0 : bitnum + 1;
>
> But yes, this computation doesn't seem right.
>
> The beginning assert should probably be (vq >= 2 ...)
> and here we should assert bitnum != vq - 1.

Coverity may also be looking at the case where
TARGET_AARCH64 is not defined. The fallback definition
of arm_cpu_vq_map_next_smaller() for that situation
always returns 0.

thanks
-- PMM

