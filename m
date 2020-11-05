Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED060C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5E820715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcgRlF5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5E820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kah0w-00062E-9s
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kagzr-0004yc-8O
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:16:19 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kagzn-0004R3-SQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:16:18 -0500
Received: by mail-ed1-x541.google.com with SMTP id q3so1650507edr.12
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 07:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OLZ4e5HyXQunKoIuzJrv+QJGcGZe+iyKNDjNT81WyA8=;
 b=tcgRlF5OQnn06val58vb22g0L5QswlhFU/QaNyd1f1ro5CbRknh7ozkBEdsonIBIyI
 5M8QTtmF93bCKACsE60SFz0/KVYZKC5yL97Ts/mpMtA/rv+QIEPNxLX0TtkTgZ6RcSAJ
 kCwcle7ZDllDY0BDkgogUVPxYOfkLJ/pJgANsSnPvBL+xxH7aLIeNu7Oui/as+6RpGQW
 k3qCGfvxK2jlU+z8jlq16DBk7hSpF+LhSG1byTzhLqev1lLlIGK33rZLXbP6bhEfmcLZ
 TcSGx/JhLmso2b3QIHMs+Sg+EZ4H2IDvU+xIvxyzQd/YwKO1o2F5PqwMw4xghYpX/+37
 KcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OLZ4e5HyXQunKoIuzJrv+QJGcGZe+iyKNDjNT81WyA8=;
 b=Dd3RciQV4o41rKy/mlo0iTXhO2ZRVVh60mkjZ7gnKKL3aSSq1r0xKHkmDAyUq+M6RR
 LOcqWug1shHdUA0yjOgRGDT/KTnhajAgjLB1WS5L/K/+DtZGRUpB6bX87+b7sPywwdkO
 qWRgIrkRs6Cugjb37nbqlV04uk7/sNZDQv9DIzRl1bvad/fTACu4gnttZYxGFYWyu47q
 /iGcL05CB1IiB6V8KPdW74RVQPWT9W0FCqVmRJk9oJ2FOrx11NfuDtLZotUBvHKa2FED
 K4Q4MKC2vfzInvcABTW52ERrYNe+DJj2YpwJu0wy9G2RYrygaK65CtIny8uV0NdyxzEW
 sMYA==
X-Gm-Message-State: AOAM533FdtxdV30NcAlpRHkg+YFM0ol/lB9ee5c+GB7DnMyEInr41N2w
 owScNkNh34bZF+GZVPPqVSkbk6eHQbFtbfj1ejo4eA==
X-Google-Smtp-Source: ABdhPJy5w5zsFOi5j3xB0p0Z9qZ6YMx3mcOSTt9hnWWBKMG+J+TxtEXQTSx+Ap77GjYNi2ndzjThxiu6DjAz2XmWsSc=
X-Received: by 2002:a05:6402:4c6:: with SMTP id
 n6mr3139316edw.204.1604589374133; 
 Thu, 05 Nov 2020 07:16:14 -0800 (PST)
MIME-Version: 1.0
References: <bf2b4da4-385d-a0f7-7915-4f31fa797898@gmail.com>
In-Reply-To: <bf2b4da4-385d-a0f7-7915-4f31fa797898@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2020 15:16:02 +0000
Message-ID: <CAFEAcA94OTo=FT6yWVod6SYNEzowQ9ee8kKcih=q1T7TTrYBBw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Correct definition of stack_t
To: LemonBoy <thatlemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Nov 2020 at 14:55, LemonBoy <thatlemon@gmail.com> wrote:
>
> From 914c30863b45d6fcd3e2fc83929bcac546be1555 Mon Sep 17 00:00:00 2001
> From: LemonBoy <thatlemon@gmail.com>
> Date: Thu, 5 Nov 2020 15:48:24 +0100
> Subject: [PATCH] linux-user: Correct definition of stack_t
>
> Some platforms used the wrong definition of stack_t where the flags and
> size fields were swapped or where the flags field had type ulong instead
> of int.

Coincidentally, I just noticed this yesterday (am in the middle of
trying to debug why qemu-sparc64 crashes trying to start bash...)

> Due to the presence of padding space in the structure and the prevalence
> of little-endian machines this problem went unnoticed for a long time.
>
> The type definitions have been cross-checked with the ones defined in
> the Linux kernel v5.9, plus some older versions for a few architecture
> that have been removed and Xilinx's kernel fork for NiosII [1].
>
> The microblaze header and the bsd-user ones remain unchanged as I don't
> know if they are wrong or not.

As far as I can tell, Microblaze doesn't define its own stack_t,
so it must be using the asm-generic one,  so I think it also needs
changing.

> [1] https://github.com/Xilinx/linux-xlnx/blob/master/arch/nios2/include/uapi/asm/signal.h

> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>

Other than also changing microblaze,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

