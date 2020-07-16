Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36E52071B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2WwoYWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36E52071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7nW-0002mg-AS
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 13:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw7mh-0001vB-6o
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:35:03 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw7mf-0003SV-BQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:35:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id g37so4836570otb.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h1XCTv0f7ele07kRG79X+j9UrVzrxwceve41vj9nc6I=;
 b=e2WwoYWRz0xr/f4jpZNVXg+UJgYwQY5oo3I8Ntj0bswElod8sZAF42zZ10ygnLXfO6
 4Ds9X1cmuFb8hlQJpmINlwcPjSzdPtbBrjvtO/i/JuuheJnYU0n5/ySzJNQM4bv2brkI
 /h+VNdP5UlnlR2FSeUVPMWnMsmV/DgLdtM4Fnd5JbwvgQphOnjZ9q2/2Os9wBDQopDNt
 y2w3SSFnVyk1d519FxyukkSKx/XXv3Ae4efQb6w3bxTL0Ud+oblJy7JDcog044VOZ6LJ
 KRQ+pUH5WoZnB8K9/1rX2soGmBzRf9R4Mobn/HIFrdl7bOUGivsAia05XVJ3HLP4yIT6
 V3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h1XCTv0f7ele07kRG79X+j9UrVzrxwceve41vj9nc6I=;
 b=tv1M4gCo7OLdAhEzUPL/6V1F/phNK1BKRlCST51huuwzOLeLMo21sue/+LJ58q5eIH
 lXgzmeAjJlSlt0sVsqmNmOfwEzeOkYOy+8UO6m0Xa1+t6G9QvWW7QeavRhpiC6KaHGwV
 +C9XHm4nZPpTTD75/VyuE6taSRAa+9vQQFwdiX9FhtePeh1HOWHY+UHJ233yOUpVRtqC
 XGGn12FyEkkyx6UUlvVgMTBWgvMyl2pzkp76Mt/W6kCUquiwNczOKRutLIx71xs1PmtY
 IVGtx1L2vj8OyWA953zOy6CY3cUFZGL0qMk7hx5GduNj2Zia/R/U89oeToZldMON2WKh
 /Maw==
X-Gm-Message-State: AOAM532NEd0oMjvRsKjzdx8lHCTDf3GCp6Dr2dNxP8NCuBHsKMKTEO9p
 t1b0N/FYiLPNNh1RmzkJPfuOZZ7EbHvHoNAZnfo9IA==
X-Google-Smtp-Source: ABdhPJxEWKLM6ExUYGqthPY2yRM7TY0ekjYNxLm8308WgeQ+PAhSPIX6uJQpmeB1TLuHPW2H2OnmGNhe1rzSYSxkQA8=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr5446006ota.91.1594920899402; 
 Thu, 16 Jul 2020 10:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-2-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-2-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 18:34:48 +0100
Message-ID: <CAFEAcA-2un0v51XxkMsYdMNJAYXrAKZNXL6QNO8jyLLM7COrEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] hw/pci-host: add pci-intack write method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 13:29, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add pci-intack mmio write method to avoid NULL pointer dereference
> issue.
>
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/pci-host/prep.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> Update v3: Add Reviewed-by: ...
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09395.html
>
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 367e408b91..3c8ff6af03 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/units.h"
> +#include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
> @@ -119,8 +120,15 @@ static uint64_t raven_intack_read(void *opaque, hwaddr addr,
>      return pic_read_irq(isa_pic);
>  }
>
> +static void raven_intack_write(void *opaque, hwaddr addr,
> +                                        uint64_t data, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +}
> +
>  static const MemoryRegionOps raven_intack_ops = {
>      .read = raven_intack_read,
> +    .write = raven_intack_write,
>      .valid = {
>          .max_access_size = 1,
>      },

I suspect this may be a read-only register (and so a guest error
rather than unimp) but I'm not sure I've found the correct
Raven PCI controller datasheet, and if I have then there's a
lot of unimplemented functionality in our model. So UNIMP
is fine. This controller is only used by the ppc '40p' machine.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

