Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F1DC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C5121721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y31+zGqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C5121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNg9-0007rp-0O
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57385)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiMHG-0002pz-KQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiMHE-00045U-LA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:09:10 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiMHB-00041m-7A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:09:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id o101so17640244ota.8
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IjRrVzhAY4PTEFYgOvLWShd7wD4RyDwF84klM+bzNgA=;
 b=Y31+zGqcfWyi7l0tTpSoFrT0txrRuLYTzSSw86m8U3e4o88tBu1arUkD3BXPo/wexC
 3z6AYS0p7VuptI0X8KO2AvfVddygJ9KIEyjBhnd32DYS6qHOhie/2/x5L9Co+4/BbEiY
 udM6r24WSN/NVzT9I0ms4Yo7uEexFoWZnmLpbO++YhMSdbIUAoqdq9Mz8dqxSGZ9A8A9
 kwQOmhHS5RT08o07MYVlcHDoxW1oE+I10YZwm52Mo29s2CyvyehSfIatnSNyJt0ZKDyr
 8k0ZnziqhMlO2LHIiW32FIB23lefq6b5HxQqPExQpIOA+eJQaga5qdH1loJ0em/gwyVQ
 j3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IjRrVzhAY4PTEFYgOvLWShd7wD4RyDwF84klM+bzNgA=;
 b=OMIbhUCvw8qY3wwcF4VUZsbf6kqqWh0I2s2YfKtmLHGF8JYRMjUTNJ0xDVv0/CUuz4
 gIVUwdKfK6RxwSNvhrdhw3gCSFPj0atkcNl6qJSC5S/bEEJjDpK8gfVrp4voVRh1LvvF
 HIpDpB8BzG66c/zWHLwTCzFXrzEorCE4/jD0RK4jDhdLUir450a+FE5lEFKMq6GxJl2v
 bTQb8yytH8RLPFzxO+FAFYByETnJ3eUL142ms1I/YaBocdSTLfPKUVN9LT2r+4An7kC3
 CE3yjMDGdN9jRpUHwodTFXNfp24NCi0/8WILYZWaL6uQ1C4tlAlu0KDN4BycK51dXiiy
 WVxQ==
X-Gm-Message-State: APjAAAUz1drRmqEGHQkrhWiWBN6z6qxiCyZHENi8YDPiUSgVYkX+LFD0
 pl0gtVp5y2KiQ9j46YjF6VSBasctX2gc9mAl/WFF+g==
X-Google-Smtp-Source: APXvYqwG6JVWWhWpDw+J0+KNlgzL6VQyee4XB7opLodP2Frgxt68YrGeiWZVVMhTGX/lUxNmVbQrY3IsauLEhOfJ5VM=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr23515573otj.97.1562087343204; 
 Tue, 02 Jul 2019 10:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190628103957.9504-1-kraxel@redhat.com>
 <CAFEAcA9Dh2EaPkcDmErEdJN+BknuRHvZKe5veOcY_7hMVEXiVQ@mail.gmail.com>
 <CAFEAcA8W6OkDa8cY-YWq7dFeFoZENFiEPNfB3Hy3XQPe6GN2rw@mail.gmail.com>
 <20190702164835.3lnefzrbimltb2h6@sirius.home.kraxel.org>
In-Reply-To: <20190702164835.3lnefzrbimltb2h6@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 18:08:52 +0100
Message-ID: <CAFEAcA9PvQgGVZNg0ziXL3FnqENbfE2U3HkOPyOORmk38y0HNA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 0/6] Vga 20190628 patches
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 17:48, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Jul 02, 2019 at 02:47:12PM +0100, Peter Maydell wrote:
> > On Tue, 2 Jul 2019 at 10:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Hmm, the bitbang-i2c changes in this pull seem to have broken
> > patchew's asan build:
> > https://patchew.org/logs/20190628103957.9504-1-kraxel@redhat.com/testing.asan/?type=message
> >
> > (probably because now we're using and testing the buggy
> > code in a way we weren't before)
>
> Hmm.  Yes, gpio_i2c_init() allocates memory (in inlined
> bitbang_i2c_init).  There is no exit() function so the
> memory is never freed indeed.  On the other hand i2c
> devices are not really hotpluggable, so maybe we only
> need to tag it that way?

The problem is that the qmp 'introspect this device' commands
do an init-(but not realize)-then-delete cycle, which will leak
memory. This isn't a big thing for real-life use (people don't
repeatedly introspect the same device that they can't usefully
use dynamically anyway), but it does get exercised by 'make check',
which is why the sanitizer complains.

I've just sent a patch which tries to fix this by switching
to making it initialize an inlined struct rather than allocating
memory for it.

thanks
-- PMM

