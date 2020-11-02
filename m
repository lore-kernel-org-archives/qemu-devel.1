Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32FFC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D30B2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLjZZc66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D30B2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWh3-0003Uq-4J
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZWUN-0002gq-Ln
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:50:59 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:39035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZWUL-0007OK-1B
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:50:59 -0500
Received: by mail-ed1-x532.google.com with SMTP id e18so2545128edy.6
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 01:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QP3mO4N0e2zy5Xe68Nrspvl6MDsRH3Wb8REYuar2i7c=;
 b=yLjZZc66UST0vC9FV1d/x44LtC1CjemfSDSwBhvVLyqmzNV+6lDYzUxkVKnaujtPV0
 O1LBreo4zXOHaqLmfLOkjAl1+ZgY1ayTRIljfHHe+SpjBC4TFwzmKzwSEWqN/r6ybl0D
 Lq86cJwe18b+ZABpVaqAQw4aE1P4heVFnOzy3hke+yKnHxoOxGsjh3tkQ08Ep079s/wn
 dU99f8VrDFoIqqpuO8ZSQIeDlenuwRUP+UZyLF5M7DDFFhXIth4PHen9M+OVC+gwu4TZ
 dZjPi76EaSX0OzO6GqyskzenV9LBug0s4CM0gW9oyX4KvurSPGkQuWGAkJ8hMrMCgaWd
 SyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QP3mO4N0e2zy5Xe68Nrspvl6MDsRH3Wb8REYuar2i7c=;
 b=qdju0mR3ETtsczB7BNA9gGwBQ0JtUsH1N7V4FOcDkmF43v+kuidYLmlNrKMPhQyWDA
 rBhQk0WbMJmF2bxJSnc1Dvdr6zd4SCS4REE1UxygS2tpAQk6HIdH+KR8HT7nFYbLVeJ0
 I6koflhvwz6K2q+rnoRStYphXLWSYCe9mrRfQdYk7iBGVmuATOEXCdbg5qGU5SaY3AxH
 JDJVWnhAk9R8nyTOV9aBAUPfqfCCSfrIVwdWQujF8jhbkv5bgcTIFdlJFReS5tDV/2DY
 cSkq5t/CcBqtvf0kTZ+iKuTpIXGXP/35Mpj8DPXTJpG3TJVE60UKabprqrEP7dp9Ssak
 p43w==
X-Gm-Message-State: AOAM530ShHViwWHRbQUJ4CZc0mUoBMV23Iwmn0Cl2xO9ykXAF0Ffyhpr
 Y52DYFK0L5yOC5oaL0RIkM+HtUD/VFIOMy/81fwZ5A==
X-Google-Smtp-Source: ABdhPJzS4SrpdU3lyJOuW4fF7NAcJ35tbraXqHEEDAxXFvvXhu4hQpkL7oQ4MD3oq1Zx/Dh0BkNBDAlP+mhy74GdqWY=
X-Received: by 2002:a05:6402:4c6:: with SMTP id
 n6mr16033878edw.204.1604310655376; 
 Mon, 02 Nov 2020 01:50:55 -0800 (PST)
MIME-Version: 1.0
References: <5F9D449A.900@huawei.com>
 <CAFEAcA9w_JZ5m2Cj9Cuc4GMka8vp-AabtmqNLwe0q7ObN7QKyA@mail.gmail.com>
 <5F9F953A.4060603@huawei.com>
In-Reply-To: <5F9F953A.4060603@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 09:50:43 +0000
Message-ID: <CAFEAcA9JN00jcP0ss2wjm7QkR3OFZAksVLuTYNv_tjSG8v2esA@mail.gmail.com>
Subject: Re: [PATCH] util: Remove redundant checks in the openpty()
To: AlexChen <alex.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 05:12, AlexChen <alex.chen@huawei.com> wrote:
> Thanks for your review, I will add this description to my commit message in my patch V2.
> In addition, since the amaster and the aslave are not allow to be NULL,
> do we need to check that the amaster and the aslave are NULL in the beginning of the openpty()?

No, we can just assume it. Our coding style doesn't
mandate that level of defensive-coding against caller
errors.

thanks
-- PMM

