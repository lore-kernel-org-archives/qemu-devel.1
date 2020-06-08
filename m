Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077922053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTqXqW08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077922053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIsn-0005Xw-A1
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiIiY-0004On-FQ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:25:38 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiIiX-0005bH-Dq
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:25:38 -0400
Received: by mail-oi1-x243.google.com with SMTP id b8so15478683oic.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OXqnU60FQPOgI0RLFW7HJ0PukbUzK9DJjSGRvv8rpAk=;
 b=iTqXqW08NHNkrofnKl0ACT6k41zE9cno0NyBwtNtLCsXWRNe6pPE8SxU3RD7uhGBQH
 fVATDy9O5lyaMIinkRZUn6gsfPdTCm5kVlMzOO7QQjvNnihieieCqhRp8shPgMd0pRIo
 Hn1uDMHpIXfwPncXW+jyeHvsY9O9IJuuiOM94wBrXwnt6BQ63lR6hLOkY27RQp9ezXUV
 SBYKulGf4bPKTTE27qhVfz4XrLLtK895CDClpRKQVe/NZSBqqFoCOCnepAGWn7lBbUMb
 87HYx9LwLK/KlfqoCXXscaImtr4+qzZynmzLLqySvkC487CXrU+f4KGOreKmjr9PpCy6
 V6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OXqnU60FQPOgI0RLFW7HJ0PukbUzK9DJjSGRvv8rpAk=;
 b=BV6uk1tKPJtuiAYL0h5JgIlVZ6nTWF6/FC2Z1dEYgNqDw8aUqY551g6RtfA/KY+5l+
 rsKUNMQSraQZU9Y8Q6GMWaJrl01koB/9ZIlUKlNsuskHeC0d+IxV10/To3HSO0HKMH2w
 TeBltVZd0iUM1d3GMSy6AZySkrZiX14f/g/6puQOxWHWGcn+g+6djxZCv+t/LxhXPNBe
 fCMpNyiOhqCuk7AoUARyj/ZSlSqUMdTpAz3gI6mjzE9jTXyMcMti/BB9ujEuYmVda+Or
 Un68xjZYU7KMUVdxTTUjcbOkA/SY5KQJa5OOfgyhk9cmH79pP4Cb+akAhkmvRLmj5V0U
 Sg4g==
X-Gm-Message-State: AOAM530LRzTbIb+iTou319beeB+0LPM7lO+8by2EM8qMBTjTK558Uz5V
 YQQe5tcMkrry14wi1byVZA+IV8YFiiCZmWsD+liaEQ==
X-Google-Smtp-Source: ABdhPJzPKgqw8c7sf/MNjykDTZK3/l81yG7tWSJ0l6ovuhdv9Mjq+nabFsNwmLMdWQYlDbwgNR47/P1Ih6CUv8Luqq4=
X-Received: by 2002:aca:568c:: with SMTP id k134mr10030718oib.48.1591626335894; 
 Mon, 08 Jun 2020 07:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-10-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-10-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 15:25:25 +0100
Message-ID: <CAFEAcA8qWmMfn765D+fXZGqOoDyb59vaha=wsRjhZPiNG7MVkA@mail.gmail.com>
Subject: Re: [PATCH v2 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 at 12:13, Markus Armbruster <armbru@redhat.com> wrote:
>
> cuda_init() creates a "mos6522-cuda" device, but it's never realized.
> Affects machines mac99 with via=cuda (default) and g3beige.
>
> pmu_init() creates a "mos6522-pmu" device, but it's never realized.
> Affects machine mac99 with via=pmu and via=pmu-adb,
>
> In theory, a device becomes real only on realize.  In practice, the
> transition from unreal to real is a fuzzy one.  The work to make a
> device real can be spread between realize methods (fine),
> instance_init methods (wrong), and board code wiring up the device
> (fine as long as it effectively happens on realize).  Depending on
> what exactly is done where, a device can work even when we neglect
> to realize it.
>
> These onetwo appear to work.  Nevertheless, it's a clear misuse of the
> interface.  Even when it works today (more or less by chance), it can
> break tomorrow.
>
> Fix by realizing them in cuda_realize() and pmu_realize(),
> respectively.
>
> Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/misc/macio/cuda.c | 10 +++++-----
>  hw/misc/macio/pmu.c  | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index e0cc0aac5d..763a785f1a 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -33,6 +33,7 @@
>  #include "hw/misc/macio/cuda.h"
>  #include "qemu/timer.h"
>  #include "sysemu/runstate.h"
> +#include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> @@ -523,15 +524,14 @@ static void cuda_realize(DeviceState *dev, Error **errp)
>  {
>      CUDAState *s = CUDA(dev);
>      SysBusDevice *sbd;
> -    MOS6522State *ms;
> -    DeviceState *d;
>      struct tm tm;
>
> +    object_property_set_bool(OBJECT(&s->mos6522_cuda), true, "realized",
> +                             &error_abort);

Still disagree with barfing on failure when we have a perfectly
good way to return the failure indication.

thanks
-- PMM

