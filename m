Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFFCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5353022475
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iArXDO2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5353022475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrJK-0001Yj-8f
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUrHw-0000ji-PM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:02:52 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUrHu-0005Ua-Ov
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:02:52 -0400
Received: by mail-ej1-x644.google.com with SMTP id lw21so2574868ejb.6
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Jq0oDuHlogkDwR14cDHXBYFn1FeOR0Ae9C6KBlV4Nc=;
 b=iArXDO2nRL7+TgwIiL88Zi3E1cSSA5zwe7rGV7aek9p3c2G6/LgVseLNpp0/mCpfJ1
 0mixtS418XOiLWJKvWnVVJnHQ1k80TgTEcuI/RcHnsk147bZqFa81GyElO5J+H9j1XvT
 8BKJUS7oI+w7mBYbAA5L6ZD6PilkVo10CtzJfH3TekgtC/+RtUU2LdQjseY0p3bZLk+Z
 URCIaB6yg0CiEJ+c4aJkZGxSz9pGULqIQcuG10FHSOl6T45KD6PfMlU1u/ayk4TgL6Uh
 Xt3YKm0DhMaSTTDIdyMUFwUJK+ahcKrsIv9uHLbBc4ADn+iSuwDhPh3S7wKO7HzOsKjy
 4hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Jq0oDuHlogkDwR14cDHXBYFn1FeOR0Ae9C6KBlV4Nc=;
 b=rWztVa9F31FBW2bAS13ujWHX+hgAbOn+0KY1NncMMkcoWH7I5V43ZzeHrewY9atqjk
 4lfoZxh43IG72/4xr9vUZqFf20LGGJfBPFjGM3U/F2kM6i3WblkTGcX7kZCy+4L52fZB
 BRTbGRQ5cqJlJX8SeEfVW9RVERnZHgNj9NBQ4pM9Zp1aZkvHEkdANEAowIgCcQivDm45
 q/aOE25NMxLjePCBpSgOF+sDhMNAc+xTmajrAt4up8P9G41sJHNQVzFvuIjC3I7VJ2sL
 SNgDwezO1JNO568Xs1hZ6u7pRVC5rOttJMPwe3fxfCUVXR7U9YLdqsylQJ7DvAU+IdIl
 7Tdw==
X-Gm-Message-State: AOAM531XNbWsq7GTaMz6JVvcwrNn+z2/O86SWdAwuwjxYr7OiyN1S4mS
 uN7FK5pDS0GclJrKNsVicK65pYUzj+D9pxW0863XMA==
X-Google-Smtp-Source: ABdhPJyfxdnbVR+sVWysdH7M6dwqXVp51KIEl5J3BJXwx5ExdUnH0ZDxtW7cXMQ5Zl6o9+L4ixX/1+3ITUwCIyBC2nM=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr3093047ejb.4.1603198967531; 
 Tue, 20 Oct 2020 06:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201008232154.94221-1-hskinnemoen@google.com>
 <20201008232154.94221-5-hskinnemoen@google.com>
In-Reply-To: <20201008232154.94221-5-hskinnemoen@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 14:02:36 +0100
Message-ID: <CAFEAcA_-sWHjQ4ct66h=9ZMRqwnuFT+LWPFYLHGuuur2-+C9yg@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/misc: Add npcm7xx random number generator
To: Havard Skinnemoen <hskinnemoen@google.com>
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 00:22, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> The RNG module returns a byte of randomness when the Data Valid bit is
> set.
>
> This implementation ignores the prescaler setting, and loads a new value
> into RNGD every time RNGCS is read while the RNG is enabled and random
> data is available.
>
> A qtest featuring some simple randomness tests is included.
>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>


> +static const VMStateDescription vmstate_npcm7xx_rng = {
> +    .name = "npcm7xx-rng",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(rngcs, NPCM7xxRNGState),
> +        VMSTATE_UINT8(rngd, NPCM7xxRNGState),
> +        VMSTATE_UINT8(rngmode, NPCM7xxRNGState),
> +    },

This is missing the VMSTATE_END_OF_LIST() terminator.

> +};
> +

> --- /dev/null
> +++ b/tests/qtest/npcm7xx_rng-test.c
> @@ -0,0 +1,278 @@
> +/*
> + * QTest testcase for the Nuvoton NPCM7xx Random Number Generator
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include <math.h>
> +
> +#include "qemu/osdep.h"

osdep.h must always be the first #include line, before anything
else, including system includes.

> + * Verifies that the first data byte collected after enabling the RNG satisfies
> + * a monobit test.

Some of this "is this really a random number" testing seems a bit
overkill given that the RNG device is just plumbing through the
qemu_guest_getrandom() result, but since you've written the code
we may as well keep it :-)

If you fix the #include order and the missing terminator then

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

