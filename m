Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1868C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C046020732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYQjnSNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C046020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sXB-0003cU-1G
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6sUM-00087D-5X
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6sUK-0003H0-PY
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:56:17 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6sUK-0003DE-4g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:56:16 -0500
Received: by mail-ot1-x342.google.com with SMTP id i6so2249044otr.7
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vSlyjrHn0wwwoUfIb0R4V+IQfkjjgd/zT/gBOmtqyZs=;
 b=ZYQjnSNvIOVLqQ+QFNpbE7OoQHbXusuMyKEPbAKfX3Imv7Szuj6MWa/oO3MeGPbOK4
 ICtSx8BUcZr5yjQiMEOfPUWX4dWrApXG8LoXVvRo/BdzH55z+hbjmGsecAQH45DGwQMA
 AkMpQz9JNhzz+PIjHOzkqWAE9NnaUKzlSFb0CGBvDx5L9J2qkJRfClyJPtiJ2kkYE8cF
 Z1xMvgTwZnP7eVhNa2xs1iTv4r/UjOVmrbF8H3BYJxMOonhNXeUq3h1sreNOj1Iemufh
 VF41ACB1uMfDQmLsDY1ZmXVB7YH4O840VH8AKVZdXtwk7L5cIXoHHTwfBisCeq4voRh7
 /y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vSlyjrHn0wwwoUfIb0R4V+IQfkjjgd/zT/gBOmtqyZs=;
 b=FRy5A1qxVQf4rrsvazVFwk9orWUKAHPPRY3kHlwNoFb7gqOHrF73W9LL//u5op88tE
 05tURi0VX5Q1zfCa94xiSZYNWYX7ypyZIrRxTTs+WgEEmmqcTgg8H0L5pVwW8CQ9wV3z
 iTEzp02SI9cs3DdFXejSdAj2umYwgCyyGv7q4xZhG2njcv8/CdZIhyIlDaDxfxLSArTQ
 5TLH8paudD7JY+c+TH0+htFEAzrBoz5wzaqOlIRF9rBiyxzzNXe3Pkg/xICnplMVKwjQ
 /uy7SrdvNLRT953h1B3apDQxh+/FQkSSWPYfn9aGT13lmNRmNT72PvX1jgxwsmZaHJUS
 5obg==
X-Gm-Message-State: APjAAAXsQeG+WKPv09lgNLLyf5RFMH1/YGKHTeW3RsDIZaIfFHRSom+L
 eQa3EF2GCxceE+mBcjRlUiYf5/B8jCPjGbrzyQ6Fuw==
X-Google-Smtp-Source: APXvYqzkYL1xNGz+onXMSfdplyTEWAbGn0qvLNhGjpts5dlgi3sAPyf1Xj3L01ek7Y4ktzU+7yFU4DNZ5K14rVybl3c=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr1974454otq.97.1582707375051; 
 Wed, 26 Feb 2020 00:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20200225182435.1131-1-peter.maydell@linaro.org>
 <20200226085209.ni7oph6odt24warq@kamzik.brq.redhat.com>
In-Reply-To: <20200226085209.ni7oph6odt24warq@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Feb 2020 08:56:03 +0000
Message-ID: <CAFEAcA-Bhuy+2dU3joZoip5=tOkiTSoC+LzdNzyd+urUnoRNXw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gic_kvm: Don't assume kernel can provide a
 GICv2
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 08:52, Andrew Jones <drjones@redhat.com> wrote:
> Although, many QEMU command line users still won't know what to do
> without an explicit "Try -machine gic-version=host" hint, so that
> might be nice to add too.

In the GIC code we don't know if the machine even has a
gic-version property, so we're not in the right place to try to
produce that message.

thanks
-- PMM

