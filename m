Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C018C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF04E2223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gE5GIkdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF04E2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpeS-0005V9-Vq
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUpbd-00045m-Tm
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:15:06 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUpbb-0008Lz-VV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:15:05 -0400
Received: by mail-ej1-x644.google.com with SMTP id lw21so2083128ejb.6
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 04:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UTBTM6kZdyting9dnwCgnfuL7yXsGIQ9CBVlep2Z6Us=;
 b=gE5GIkdqzL6orVBKg3zUhZGYN4flOeAZi2nlpDjgUAuA1IbSyfh6zlm0PjA1TeNtSZ
 Azn8K2vumwvLzf99y8Wmt8jjHNrIon9OzZf6A6nsRgFbMhri459GWF9upZKP0Lo7IC6u
 NEmMozFmr0Aezu0Hwbvqrq2i3C4AmUd9/TalzVx+Ji0eEq4o/ayJbZaXqQv1cASKikna
 zxvaLk8cAKAwpX1kjjgHQ1vyAeiQAFE4vXsgwyTCbMT/ummx6PHWw//TzXOSMvvwxDJd
 NXNDiMp0/oJkZgwT8k222Bbw5o2xRCdUz32I3qJxbnbv2tqIzuOMrbVfxo+Cl16rUWRP
 Mzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UTBTM6kZdyting9dnwCgnfuL7yXsGIQ9CBVlep2Z6Us=;
 b=HxHSg00Qb9SqaxlfjjSiZ6r0DlABYU+iMRcRFO3A645YSJnPpQfLZFNf9XIZLhG90w
 WvtQcOD+sM9AU5o+mVyqmcO38lLDMSUDk5sIJgGkkRnJVMBtkadlfnUCH1dPn76q1GQm
 K/CLeaUi3kNuEi8waXvyzDDc3mNcv7geC5BzYjjpJgUMc91UaRPfBaws+ABuPW5Cy7Xa
 k7cxfE0Gr7ou/DYThoNm1yKgAwyZiAPY9Uw+L51gQSAAIkrDNWNqxyJ6wgRGiIEpff7W
 hoEfJcXyi1uRXX0wzKn2JBQndPbmuIZy97CWanVCxbuzC2DpNa0ODgiYg+3CTyYcORnm
 ym2Q==
X-Gm-Message-State: AOAM532L6OtMDIunD2KU9DuGemgMKuzzzcRHxn8le3DXykJUtjRkSNxJ
 wDrxbL0yh91Wi57lGsZwZstU0Ffmtsf9pOOmI95UFA==
X-Google-Smtp-Source: ABdhPJwNGtqheOecRNSzzNj0gcnZ9M0CyUlaELiqjp2Kjr94XKhwTh6Xug7/DKXgwCzPjR9y+qEkkWKs6b9VvqDULCw=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr2556236ejb.482.1603192502132; 
 Tue, 20 Oct 2020 04:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201019203023.658555-1-ganqixin@huawei.com>
In-Reply-To: <20201019203023.658555-1-ganqixin@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 12:14:51 +0100
Message-ID: <CAFEAcA-NPcXxh7QPtUtY5CornQjb-vTb_kCzRUSwMCZqkVVkBg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Fix line over 80 characters warning
To: Gan Qixin <ganqixin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 at 12:03, Gan Qixin <ganqixin@huawei.com> wrote:
>
> Hi all,
>     I used scripts/checkpatch.pl to find that many files in the hw directory
> contain lines with more than 80 characters. Therefore, I splited some lines to
> fix this warning.

I personally have come round to the idea that we should instead
adjust checkpatch so that it doesn't have a hard 80 character
complaint limit.

Compare the kernel coding style change:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144

whose rationale I agree with. We should *prefer* 80 character
wrapping, but there are some places where an 85-character
line is much more readable and sensible style than inserting
a line break just to please checkpatch.

thanks
-- PMM

