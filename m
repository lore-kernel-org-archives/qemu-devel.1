Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EAC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D57218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUQW3PTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D57218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNqu-0003C0-QH
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXMuR-0006N5-Vr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:13:00 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXMuN-0001jR-SH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:12:58 -0400
Received: by mail-ed1-x541.google.com with SMTP id v19so981416edx.9
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZjHkoAu2GQuZRbdEyCVjIbSkW16Ixy/i8fRdvBrKSKg=;
 b=tUQW3PTZ1LsZuYvAoM1NwNuu36jMBOwT0XCkxMU6KhhbCK6hpfRoZ3dQ/U9qh+BnNo
 AJERZi+MJY0LAfOZw7TS8CZ9xs69u1yHczPVx2UbjhOAehjakAh7nJcCv5tqPlNjocgM
 mSK6IZZiSCij8fei7YJIcQepKHQ5eFa166/TeA2bQJtXFhhsvk6FuBmZAHURMSFNCL5I
 9M1ABo5kLR9OpxYOziq8SHsiF532vj4xbkdKu+spPPPFulpMkxNtbHoFeyBupJr6NC+N
 FDzHrPAcWWYomhaH87m0g6AtgEN4krM/JE6GFaHKMMHCZbCr4x3FTVuKkv6nyILI3/Ix
 gKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZjHkoAu2GQuZRbdEyCVjIbSkW16Ixy/i8fRdvBrKSKg=;
 b=lhs80jwqd9+OW5K3PovdItrERl3OIblmDS0J5eRN4LoRyAXVnrrKPPyGzwOh+7Q2rY
 Qatco3j8Wj6HunokOJlYe/aP50QiC95DlOduDNrKIM06QGjMguEmCuTzApN4+pkavQ37
 YSurkkd3cUJSyYj30mZesvG7uuGB9UTvgIPF2AKwsSO8/IktrDg3ATYPP8p+/WEkG51k
 e0wDgEcOmSysnCVm6bhkoYhpCNRXQrn4A/p0+NxUxVBAvSDRS6uyjb5oLiqQlZ8e0ju2
 ZsRHtWWV6M4MKyWL/JvhNUJcLyejgkG7sQMzT8gVsHSzXxK+6htEBusvQq9P3diRNMsp
 372w==
X-Gm-Message-State: AOAM5336kKSrrKmFGNrMtI+o7ZPsmj3tbg+KUAeCljvRoM6ArXr21XQR
 95/jK/Czpsgj0GQoPR3CmheBVjj0mIt0p2i9X6XwfA==
X-Google-Smtp-Source: ABdhPJxEB5CXDULy3Mticm0FOSkwq9pCkR4NDl2Xm5M6riTK2nxbkpeyzr9txOwjGrpNVG5Boj5c7YG6PW+Rsnhr6jM=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr1703863edf.52.1603797173945; 
 Tue, 27 Oct 2020 04:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201027015927.29495-1-shashi.mallela@linaro.org>
In-Reply-To: <20201027015927.29495-1-shashi.mallela@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 11:12:42 +0000
Message-ID: <CAFEAcA9KQwGrS-9J2M41=KCzJm618vFH4cnjRT+H5AwREMxcsA@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Add watchdog support for SbsaQemu
To: Shashi Mallela <shashi.mallela@linaro.org>
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
Cc: Leif Lindholm <leif@nuviainc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 01:59, Shashi Mallela <shashi.mallela@linaro.org> wrote:
>
> This patch series adds watchdog timer support for SbsaQemu platform.
>
> The watchdog timer has been implemented first based on the generic
> watchdog timer specifications from ARM SBSA v6.0 and then used
> in the SbsaQemu reference platform
>
> Changes in v8:
> - cleared irq also along with ws0 clear on each explicit refresh
> - addressed additional review comments
>
> Shashi Mallela (2):
>   hw/watchdog: Implement SBSA watchdog device
>   hw/arm/sbsa-ref: add SBSA watchdog device

Applied to target-arm.next. Thanks for the respins and for
working through our code review process.

-- PMM

