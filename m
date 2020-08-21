Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF21C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB7A20656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hI7Z8EwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB7A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99sQ-0003fc-Ep
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k99q8-0000TW-0l
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:24:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:36422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k99q6-0005wA-5j
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:24:27 -0400
Received: by mail-ed1-x52a.google.com with SMTP id ba10so1934812edb.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1pM4T06mhdKnPhaCodqlTQE1VNvZNPn0zn/kvK/OWHw=;
 b=hI7Z8EwJY3XqhGeFbcKuJh/nm2itwth8p0C3Nuh2HPiMqazMNl43pfJR8jS1ybrRPZ
 j3G4x97DvPuRHRSI+abKui8OKHaOYIFybF3SW3aBXABPUSMB3Pogh8fVN9lZ7x4acO5/
 X/w3Wm9P4GnVOkuBFPCWB816iAbUHXDIyGVovLRAMqUUmJW5dRhOpTVXWEkoGs11JvoO
 p2vV9d0UCKIfvDZUs8EXv4e2i4pNIgIqUDdIVsxsnsfbS6mm0V5BjI3XI89gMV/kNAD7
 WUE9FxB8Qcrq+4Ios0uOy860uoWEKVjLfjdFfYYdL7Gcpml5p9N/Z/cP083sTGgxudLx
 KCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1pM4T06mhdKnPhaCodqlTQE1VNvZNPn0zn/kvK/OWHw=;
 b=cIQ5Ikud0mfi76ZYhUBq9cAAMUhcvkQjCn10y+9oL0e5ngfC0VIN1clfQNPgXIlBF1
 6PK97tOd8DRK7926ygj4fgC1hrw1p1jYLVN1fv2oxgpM3Fsj3aPnw7hq7aGjH3fK4253
 zjBxli9kF0nG0wa2m5WQS8MVqXPpW/Czp4LSEWGXS/sq9vGlLqgt8zSkCG34jwkHOmjY
 UR9kZ3Gw/RTnBHFNe6vCRuHZnVHlAphmgtT4Z2jilxPVw+n9/47hzM1/VAmuvjS8+HbJ
 H/TNYiLYiACfXAhJ4MeVmCudP5pug8PfCOF5d2HfN4w/4IwW+tWmgsqoHDWapWdyO/SI
 h0Sw==
X-Gm-Message-State: AOAM5319s9MbZ/xKmgx070YZNmY4KHfhO1CAsCqqaornZG84tZscL0ES
 P5L6mOOWBWZDQmBKCoui+EQUBaXgNWH0YjDnS6+5O+PwSN3IMw==
X-Google-Smtp-Source: ABdhPJzlTrgerWY1kjPPFnQNJlmqkM/mfSeU4mNl+lnKXmWK9VHdvFFTGXW9wJufZe79Vr/r6R3htija/jZKThfUtIE=
X-Received: by 2002:aa7:ca0c:: with SMTP id y12mr3442451eds.251.1598027063977; 
 Fri, 21 Aug 2020 09:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200812232439.20153-1-jcmvbkbc@gmail.com>
In-Reply-To: <20200812232439.20153-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 17:24:12 +0100
Message-ID: <CAFEAcA_CMuZbJqEi8sv3f1tJomkSB-3kpA48T0AZL8U2WhbpUw@mail.gmail.com>
Subject: Re: [PULL 00/24] target/xtensa updates for 5.2
To: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 at 00:24, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following batch of updates for target/xtensa.
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20200812-xtensa
>
> for you to fetch changes up to f64fa1494d5f92d4e4f0cc6a0ef3c7e3cc12763d:
>
>   target/xtensa: import DSP3400 core (2020-08-12 15:56:51 -0700)
>
> ----------------------------------------------------------------
> target/xtensa updates for 5.2:
>
> - add NMI support;
> - add DFPU option implementation;
> - update FPU tests to support both FPU2000 and DFPU;
> - add example cores with FPU2000 and DFPU.

Hi; this conflicts with the meson buildsystem merge, I'm
afraid -- can you rebase and resend, please?

thanks
-- PMM

