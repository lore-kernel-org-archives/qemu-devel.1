Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D167C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270042075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jok5xB+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270042075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyur-0003xm-B7
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuytx-0003JC-KK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuytw-0002YW-8p
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:21:33 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:42580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuytw-0002XG-2J
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:21:32 -0500
Received: by mail-ot1-x32f.google.com with SMTP id 66so1546868otd.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6vBwWJFt2KEYe/qCie/QQtar5VEO+Y5mvenX+hAAxiE=;
 b=Jok5xB+hXHyS7+7mfzu/N9N6fmfIuk6aHEBUqofIZMzvspLKDiMGK2lqKK5A4mbDFS
 coiY+fZHEXIiFnKEISIBjWS2prlkb8Z4vIpqfRaworI9MFqbKD0zX0/hD0kahAtQ0LXl
 l+SvmIQBAA4Jdxq7g114OFD8l+E5ZdbJZOdvmRYV5lkcrVQLKZyuVtVaCXVumqA7o6YF
 XJIrZJFivwl6dA2F3Pg50AHmAxAbl6PcKvwTraVvpQb0tPockJUntt94K4EDlR0xIu4u
 ZTrmI5BcNPonJM6gKTQbA2ihnBQH6p/3juoiNBYiBlumcHpFMHyf//ONEJ1FjZ1LV6ox
 c5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6vBwWJFt2KEYe/qCie/QQtar5VEO+Y5mvenX+hAAxiE=;
 b=Vvt/8RDTO5/KJSmp9x8kPhGWPJG8nJ0LTc51EA08EIWpq8dtdYbpy7V9wCKTqrUzDB
 NsVRNYD9AIOCOwldSuFZ8AwPQe+BPUiLs5QV3vD8U9xi+N8NMv4tqG9bg57mCAuS4i6J
 VmrlxSLevZZCv0QAGFOihZElgs+csWoQwPGbJIHRXhsRMdApLWXiu/f0h+biAih/hQTW
 vWmIpXPbf3IpE5o79eRHxXdHQq1dHsVKDnE60N3Ab+iJpPEyz+BxEJf8RZv48dxUjPAX
 RsJdavcoz+PIINsqxx6ynAHYaG04qAoMd0IcuwXZTPD7WDI9ye5GsM5NZSpbeAe6Dwgr
 bOiA==
X-Gm-Message-State: APjAAAW9BCxYl9tVfKc4stQAk5wEo3JPHTbPTwe6/wKeAbIPPMZpi/Jl
 HjWa0Cw/WU+Hd2z20vBSCRSiYRPlUyvE523f2dH39Q==
X-Google-Smtp-Source: APXvYqyKN6fiDCGKWUwQsP/0yrQ4sW2C790k//4HZyo+F5oajTK9rWRzd9PVg02beAmlrKmzWWwaKkjXjN1wrIwl+Cc=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr2493859otq.97.1579872090706; 
 Fri, 24 Jan 2020 05:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
 <20190108224600.23125-13-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-13-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 13:21:19 +0000
Message-ID: <CAFEAcA-6KiNwN_5xNgZQcJEHou5uO7KrMUgNyXf3ae6=DO7scA@mail.gmail.com>
Subject: Re: [PULL 12/29] target/ppc: move FP and VMX registers into aligned
 vsr register array
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Jan 2019 at 22:46, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
> The VSX register array is a block of 64 128-bit registers where the first 32
> registers consist of the existing 64-bit FP registers extended to 128-bit
> using new VSR registers, and the last 32 registers are the VMX 128-bit
> registers as show below:
>
>             64-bit               64-bit
>     +--------------------+--------------------+
>     |        FP0         |                    |  VSR0
>     +--------------------+--------------------+
>     |        FP1         |                    |  VSR1
>     +--------------------+--------------------+
>     |        ...         |        ...         |  ...
>     +--------------------+--------------------+
>     |        FP30        |                    |  VSR30
>     +--------------------+--------------------+
>     |        FP31        |                    |  VSR31
>     +--------------------+--------------------+
>     |                  VMX0                   |  VSR32
>     +-----------------------------------------+
>     |                  VMX1                   |  VSR33
>     +-----------------------------------------+
>     |                  ...                    |  ...
>     +-----------------------------------------+
>     |                  VMX30                  |  VSR62
>     +-----------------------------------------+
>     |                  VMX31                  |  VSR63
>     +-----------------------------------------+
>
> In order to allow for future conversion of VSX instructions to use TCG vector
> operations, recreate the same layout using an aligned version of the existing
> vsr register array.
>
> Since the old fpr and avr register arrays are removed, the existing callers
> must also be updated to use the correct offset in the vsr register array. This
> also includes switching the relevant VMState fields over to using subarrays
> to make sure that migration is preserved.



> @@ -281,15 +281,17 @@ static void save_user_regs(CPUPPCState *env, struct target_mcontext *frame)
>      /* Save VSX second halves */
>      if (env->insns_flags2 & PPC2_VSX) {
>          uint64_t *vsregs = (uint64_t *)&frame->mc_vregs.altivec[34];

This line didn't change in this patch, but the code change seems
to have prompted Coverity to warn (CID 1396862):

 illegal_address: &frame->mc_vregs.altivec[34] evaluates to an address that is
 at byte offset 544 of an array of 528 bytes.

> @@ -393,16 +395,18 @@ static void restore_user_regs(CPUPPCState *env,
>      /* Restore VSX second halves */
>      if (env->insns_flags2 & PPC2_VSX) {
>          uint64_t *vsregs = (uint64_t *)&frame->mc_vregs.altivec[34];

...and then CID 1396863 is the same issue for this line.


Is this legit, or a false-positive ?

thanks
-- PMM

