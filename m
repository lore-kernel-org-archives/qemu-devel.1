Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6D2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189F220768
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awyORTc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189F220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTIJ-0004yH-Ch
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTHV-0004Kq-68
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:55:13 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTHT-0005K1-F7
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:55:12 -0400
Received: by mail-ot1-x341.google.com with SMTP id d4so5525850otk.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=egOabnArhNxaatNsxWYSo38vue+qriICqGnIknScYLM=;
 b=awyORTc2yKwX1g3nHiuqDZU/0RIN5i8JycyrnVa9DKlOoa7QHBEYcW0HHlDD/u2dLd
 1afUIl5yXS/N/iWIS/h8XV44jZtekts+qH0ky16FwPIcCttn/rAWT6hG0dhisPRr7/J7
 Onxfliff4bZEAX2KJFxG0zq54QZQpXJxf5xEJ0iECpBUJS9fq0S6pUMJBhjFViSqDkK0
 ffr6cPNzeM3jvUt82nFkSdtHwHS5lsnvLnl2mMuB8eL/egK4i5NOTEEq8AprkEnUhEGd
 AHsijaNxm2rls+iB+oL0LniK5FvVuLhhO2EcrXsU87aWy0PL53mH/j7HL3DD82I5Ux9D
 eJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=egOabnArhNxaatNsxWYSo38vue+qriICqGnIknScYLM=;
 b=FKh55yCLq6w2IknQJPrCRvpMCnBMyAWNJIqWZgoA2QVOg/vPIgDChHWAp2EVpkMbfV
 2JPfiNhpuU4mYfzfTtYhxL0BwiB2dGG9wwk3BN9YKNeqeC1xSFHBIIR72MwTP0XwbwPN
 MFbZduaMoA2hUYyYd0cVCd/mowouqcL9yxQdAr1EVkqm39fvu33DezSR6Au2HZvLRUyx
 12mKEdqszIV6XuSxnD8rnfYbJY1b12cmijaGldrCQW8YxPgNx8eFOALu+fPeywJ79zLe
 riWgnzH07pm6dBrPMq/euuZuel5A0jQyrSWLm/mYhAi1uwWU0iOGozUsGsnkLoDJbi77
 tPPA==
X-Gm-Message-State: AOAM5319wXVqaQr4lSBLhQE0FrwieCX85Ay4Mn1Ep6D2Nw3rrLC853TO
 ndmnyXteHOc0+Df3m9c7nvwXzwS4+H2A4494Szo2yA==
X-Google-Smtp-Source: ABdhPJxxqBGvscH6YwCCi8zLWcSSAcEzpyQwe3PjiuMAv0zElpTtopl8S1d1OyzY6wJkaiyM9Hkn8RHb2hTxxxMQ284=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr25872905otn.221.1593096909988; 
 Thu, 25 Jun 2020 07:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-3-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-3-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 15:54:59 +0100
Message-ID: <CAFEAcA_AkshYzrqZ1O008UuTMj-q7Zd9he99ouqSTVk6tbWD7w@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/9] hw/arm/smmu-common: Add IOTLB helpers
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 zhangfei.gao@foxmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 at 17:15, Eric Auger <eric.auger@redhat.com> wrote:
>
> Add two helpers to lookup for a given IOTLB entry and
> an one. We also more the tracing there.

Missing word between "an" and "one" ? Is "more" a typo
for "move" ?

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

