Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CBFC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 23:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2D521707
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 23:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYThPspj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2D521707
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV1HU-0004mm-VS
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 19:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kV1Ew-0003hj-Df
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 19:40:26 -0400
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42]:45990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kV1Et-0003xv-DM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 19:40:26 -0400
Received: by mail-vk1-xa42.google.com with SMTP id m3so60923vki.12
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 16:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ny4GZITxBl1x7gXJeqDFvluB75Neh/+3KKa1M6hbhzs=;
 b=GYThPspjV41J7fmrlcpFxnMAFOH3rbatOr8xIITZGrggDRi3rwLU9d/mtm1DNhSvZ7
 rT1p89FE7e87Bv9fuUZsJE9PZyvBopVOQvkhy9QdeRoN6xhMPt4pmeuqWr5flWw/lNI8
 iW8U0bJWtJmPZKCfTXEvJ9R3lav3XrU7ikgxxk4t9qKtiAT7PBjsZy9rL+DksO1o/+AS
 inR9KAfoMXl4vODivKJTvXz0RFskJ1bdCmqJ93QRVKMXhXfXT4dwDosRZG0oF/cHNIXX
 bpvmx7RxFewgqXI5br8OUosUF8Nzk/Do87TtFu2+CiVc3kIhPnVxhVhws+OrGg+6t535
 RhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ny4GZITxBl1x7gXJeqDFvluB75Neh/+3KKa1M6hbhzs=;
 b=YmgvazYP3fDtEe5bU3LowX8dMpmpNocg32hN9I9tWGDh0CzS3bp56A8H9Ss7JI/7ZH
 IS13ufZYbMBZfYnQHU8cGnx3N90dxF7QdkcxkZXPOAtt40x64Sohcbe1Dl3vTZzDgyzK
 3QE0TNKmFpY1opdDcA1aJLf3ZOBjxHgKJkADzBW5UWm3aoTIsWXKdK7O48BR1yi2GtVb
 jrwm9pJHpbXQnw948eCBl2X5db3kXtCT1jvbu0C0oe13AS11qg+ulFLnr7VNWQbFd/+3
 RsSOrF1ZJl90gM2HXyf/rmNErEVL1STChYo49Yzp9pCJgqANH/lVIg1jBPkNBhu0qkr4
 v30w==
X-Gm-Message-State: AOAM530p+wsykbVtEQgA2EKDOQSSTa6HE95NPLsM7p0V2OF8Ij2gcnHR
 WIBXIsgkUm1cChpMZylywF+kX3RHRdVtmCCjH6/6rw==
X-Google-Smtp-Source: ABdhPJwEgaGjYneAncTWKOmZ0QVLCZMfs60SwUJj2STn7ZWCcHVGewRDlGL0KVAMt7XYEYt9Vn0ICykskYJImBXoIJs=
X-Received: by 2002:a1f:25d0:: with SMTP id l199mr296976vkl.18.1603237220705; 
 Tue, 20 Oct 2020 16:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201008232154.94221-1-hskinnemoen@google.com>
 <20201008232154.94221-5-hskinnemoen@google.com>
 <CAFEAcA_-sWHjQ4ct66h=9ZMRqwnuFT+LWPFYLHGuuur2-+C9yg@mail.gmail.com>
In-Reply-To: <CAFEAcA_-sWHjQ4ct66h=9ZMRqwnuFT+LWPFYLHGuuur2-+C9yg@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 20 Oct 2020 16:40:09 -0700
Message-ID: <CAFQmdRbTxH_NPnnekFC_6uw1KLkf5uNvwL32hezTTo129Xs=RA@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/misc: Add npcm7xx random number generator
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 CS20 KFTing <kfting@nuvoton.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a42;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 6:02 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 9 Oct 2020 at 00:22, Havard Skinnemoen <hskinnemoen@google.com> wrote:
> >
> > The RNG module returns a byte of randomness when the Data Valid bit is
> > set.
> >
> > This implementation ignores the prescaler setting, and loads a new value
> > into RNGD every time RNGCS is read while the RNG is enabled and random
> > data is available.
> >
> > A qtest featuring some simple randomness tests is included.
> >
> > Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>
>
> > +static const VMStateDescription vmstate_npcm7xx_rng = {
> > +    .name = "npcm7xx-rng",
> > +    .version_id = 0,
> > +    .minimum_version_id = 0,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_UINT8(rngcs, NPCM7xxRNGState),
> > +        VMSTATE_UINT8(rngd, NPCM7xxRNGState),
> > +        VMSTATE_UINT8(rngmode, NPCM7xxRNGState),
> > +    },
>
> This is missing the VMSTATE_END_OF_LIST() terminator.
>
> > +};
> > +
>
> > --- /dev/null
> > +++ b/tests/qtest/npcm7xx_rng-test.c
> > @@ -0,0 +1,278 @@
> > +/*
> > + * QTest testcase for the Nuvoton NPCM7xx Random Number Generator
> > + *
> > + * Copyright 2020 Google LLC
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the
> > + * Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> > + * for more details.
> > + */
> > +
> > +#include <math.h>
> > +
> > +#include "qemu/osdep.h"
>
> osdep.h must always be the first #include line, before anything
> else, including system includes.
>
> > + * Verifies that the first data byte collected after enabling the RNG satisfies
> > + * a monobit test.
>
> Some of this "is this really a random number" testing seems a bit
> overkill given that the RNG device is just plumbing through the
> qemu_guest_getrandom() result, but since you've written the code
> we may as well keep it :-)

You may be right, though there were a couple of reasons why I added it.

One is that rngd was complaining about /dev/hwrng failing randomness
tests, so I wanted to make sure my device wasn't doing anything to
ruin the randomness. In the end, it turned out to be a kernel bug:
https://lkml.org/lkml/2020/9/23/1021

Another reason is that the value from qemu_guest_getrandom() isn't
consumed directly when reading the data register; it's latched when
reading the status register and returned on the next read from the
data register. So it's possible to imagine a bug causing the same
value to be returned over and over, which should cause the randomness
test to fail.

> If you fix the #include order and the missing terminator then

Will do, thanks!

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM

