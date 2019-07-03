Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938FBC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6016C20645
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkcnH20r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6016C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hindY-0002Om-Ls
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47499)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hinK6-0003q4-Kd
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 18:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hinK4-0001n4-MT
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 18:01:54 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hinK3-0001gL-QE
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 18:01:52 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so3955662otq.12
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3J0be21DAQXd0O5N4+4qUpeRAOAtNdGJd9Hd1SsvNoE=;
 b=DkcnH20rnxeHil++e+O0Ik+giSAaXlGWNHWKnLHzpG1Lb33bqNUiwpS4hVdDwDBG72
 b3L2l7M7+9oeLRGwC5/hNu7YvA9rWwwyweYrL2DEbl4YcjHfB0Y30xROzbEhkqGgaToH
 ybeGws+IhsQzY1TMCsJpjixRIQ+WQJ1BWrBeed1xwAsNGfGcZkO8EkBgUEjgnP6nUuhf
 t/cWgCaVEV7c9oWs3Tum+DVJqGefucxe8UzD2pLUXBcMoQycgNte+XO1Y0Q9qz77liQi
 BltomorjsIv7Mb+nhHspBe3zWI6aYxSekIPmIr+eqyHda1Ow9XXcEXyJhQG0MEUJvj/H
 srGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3J0be21DAQXd0O5N4+4qUpeRAOAtNdGJd9Hd1SsvNoE=;
 b=RGHwp0XE8Mwy6VDGY4VIgrYD+4iVDaxqhPL5NMaE2WViO2iZHTwnN0pk+cmr3fPPj5
 jIFrXfdCcdwRHfVtPIukPOgjJdR4Kp55P8zxZx6T+WfjieKhTFCrqKKoZUCROnshcrpZ
 aZCsLNELIAGazlwvBVqnSBoFdrqgO7UER8ZiVF3ys5byn7xMkHIPsHsSELVdqXAxWhBe
 Mt8TsJysHOVLNg45Ftr8BfLKNbte8sk8pwjI6wUCK7HuWA47GJMVLTt6yfbLLj8IDChs
 //qne0I/z0OMKHUlMM01VDY8obzFRX68waFZADh5N1Zop8qo2tmKVkVLEj4Uw4wbbvk2
 DT1Q==
X-Gm-Message-State: APjAAAWU7K0Fv7Ue7ncxh+esnKMfFc8WU1e9uksPrBBfNbx0mepJpU8L
 9jCjqrYkcA33PJbP1nSVmtlK/UANwPaiI7/mpcFK1A==
X-Google-Smtp-Source: APXvYqyQqOqt2eRP9pfY2wfuT1f6Xx2421OlEXKXB686SG5DvKwKyHwCi6b8dDRDk7UOl4CaAkql+fTdcHJV0hLqTvA=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr32189174otn.135.1562191303867; 
 Wed, 03 Jul 2019 15:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
In-Reply-To: <20190701043536.26019-7-jan.bobek@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 23:01:32 +0100
Message-ID: <CAFEAcA9cqbD0HjLmTOzF_fGHGOXeBhnJ0uRoQe2kQqeNYgTdXA@mail.gmail.com>
To: Jan Bobek <jan.bobek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 06/14] x86.risu: add MMX
 instructions
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 05:43, Jan Bobek <jan.bobek@gmail.com> wrote:
>
> Add an x86 configuration file with all MMX instructions.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

> --- /dev/null
> +++ b/x86.risu
> @@ -0,0 +1,96 @@
> +###############################################################################
> +# Copyright (c) 2019 Linaro Limited

I'm guessing from your email address that this copyright line probably
isn't right :-)

thanks
-- PMM

