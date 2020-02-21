Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46877C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1094B2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8izINCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1094B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5As7-0003L5-90
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5Ao8-0005Tp-RT
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5Ao6-0004vi-N1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:05:40 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5Ao5-0004u1-P5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:05:37 -0500
Received: by mail-ot1-x341.google.com with SMTP id z9so2442248oth.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jHOz3oRYoHoICxYqN8teLISw72GYtDQHZyWca6MZPAU=;
 b=d8izINCaEqvsnGo4CKyTQG9PUZsXL69n27qR+kjvWylgUQcL96aw1cHsbPWRxGo0dp
 1EefS9EBspaW1Dr9MDW+plDemcyFX32Z+Mf7tAbLrBIfvtxYni6Fokb2dYfooqX4HyCT
 HCw5kvr3OSUBlQ8q1L8cYaygXGh84y1e0bNePJaNoxW6IFb8NBNnxFHpeK/tV1Y8x7mX
 GsMOUwKWnAS05w32/bv2QOwh30Wi1DlUt/+p1DJA9aJmlC9bPbplpP2fUFkVxP4ySt1J
 CSdCZvyjQjnlYNqdZTXj9/2RGV482tmyc3Ikil7KEWd/IIqyCc00AyjxqVgqxXUGEg9H
 H2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jHOz3oRYoHoICxYqN8teLISw72GYtDQHZyWca6MZPAU=;
 b=CTfkwd+hQ+bwmPvL+I5ZmkVglbod+OlTmXQcj2HTySos1lRbPH2+0yui6an74pkFJQ
 LwzV5LewLF+MeTuBWIiDq5iWDRjHvl4trfp4T3YD4sYwlaXwoWPzBGvDdjrNGbSG0Gaa
 ihHwoLFS7O93CS7q8TAzXtw7rIgNheBl763nvRliqRtl1/r5BW6SkRfLEIkPpz3HjQG5
 bv0FtPGjhaLrpZ/XMw49DybTK+hKq6Rry+w/a65Wg2iJq3EZuwpswcFHwrqK7mPh4brA
 KPXQda68PX6pGZQ0cZmDhyO8QwD32j5mAf56vMhfZxKdbXfhs0WbmMFGpOVxuU4G5M6R
 6nHg==
X-Gm-Message-State: APjAAAXaqMS8hj+aqitfdzGWqVAbWUpl2HQbaM2FbHgdaasW9pa0Y1cH
 J5QFWCTZEfzBIlOPZp9fVhK+g6t0zckrkqAnT6y1SUq/
X-Google-Smtp-Source: APXvYqzDo3ZtrGIcaXcRd6Kye5s5xvIoUJ4G7onk3E6Ma9uZZP1KqgJipygeNhs/Pc7p2wCiY/VEWEpgQPbSNTrGOz0=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr29037718otd.91.1582301136874; 
 Fri, 21 Feb 2020 08:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-11-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 16:05:25 +0000
Message-ID: <CAFEAcA9w0_VAu5BzSd8P4dDKedWKUVqb2t=HSJaiFNAwOrX-Bg@mail.gmail.com>
Subject: Re: [PATCH 10/19] target/arm: Add missing checks for fpsp_v2
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Fri, 14 Feb 2020 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We will eventually remove the early ARM_FEATURE_VFP test,
> so add a proper test for each trans_* that does not already
> have another ISA test.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

