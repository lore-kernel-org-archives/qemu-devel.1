Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7886CC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4387C22296
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q4Ds4wOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4387C22296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQ8L-0006fT-KJ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvQ7Z-0005gJ-Ts
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvQ7Y-0007O3-V6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:53:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvQ7Y-0007Lt-Pa
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:53:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id j11so7337032otp.10
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TFJ8+QiEz3CZrxJGNn8ZjRZU6uLheuguQ13sLuKkqUI=;
 b=q4Ds4wOFOD3Hm9eA0LlREjKzGx9FN+lf9rj7gGOInDJ9476/wJsCxiOgof+mw3XepD
 ETr/w8ZzIpy3Ha3aa5Ip/Sw01+I6pQCqKR9qCX/ujC5bGYG2IFDRGVXgNATrYRO4zRKQ
 okJ1mJmgyKTUnLfNUFHfHlY92VIRQc61VOwU/8e1dyBrxf6AswbHKIw74i0LIt4CVP6b
 6ROLUHuDU2CtflPtUKB4dOBaekXoTzzyEfaQZ4ir66Lr2U5iXPqSQsNYim4VPmKhv9Es
 75ZWD3EjS3wTmA7lJ+Y96IVv5XsbbMD66ziw2BPm6eyOxr1MtfglbKadzbLDeJkFya98
 AE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TFJ8+QiEz3CZrxJGNn8ZjRZU6uLheuguQ13sLuKkqUI=;
 b=ZQ/LhsokdGb4xeB9+irvksb5C47wxW3iSi15RPLDFTAsrJgnU3y50yRhBzAgBVUji1
 WIBPKwrVulNVXSqDxjtlq+aw2camn9z7Lm2z3Lm8I8Mf8Cf6fkaWT1NIPDUK90aHP9mf
 YCEzGn12mUlCFl+Kq3j6IkD9aHBuWZqFN4/NljTN/SbBs01q8Agj2T2u9kgE5OFgo/6f
 ZEbg0q6Rss6Qe4FB0cnH55p7kP2NEWQ93x9DUpy/NIQbRyIWRDOm3rUAUhB6LPyVRcPn
 zVdCWBTSI7ZJWZjLpdmCJ1HBRhkUNV4fvloowPrYlCqd6f/mD01evejZPQmn7aTu9+9+
 4i+g==
X-Gm-Message-State: APjAAAXQQFJHqx1YrrBYXvrJftkTn4tyH/h5CXe9ce+iYZ2BWzsufv/D
 9MTPUpdXdf3xJYADKq4DLHgeu2SnHO60tUfF3/MlUw==
X-Google-Smtp-Source: APXvYqyG0QSGcDX1WgBUfS8I2yD4EhwUFpgCmCAMEV5CVZBKi0RrjWQUyOMbu3lh0vJhwHrTAIqoRALCX19PhuyBsjU=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr751481oie.48.1565200387864;
 Wed, 07 Aug 2019 10:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190807045335.1361-1-richard.henderson@linaro.org>
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 18:52:57 +0100
Message-ID: <CAFEAcA-s3DZcW=L0X=Snxj7PwyLQerhQwrYiKj=icJwkHp6pqw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 00/11] target/arm: decodetree prep patches
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug 2019 at 05:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are split out of my decodetree conversion of the
> aarch32 general instructions.  With one exception, these
> are all related to cleaning up how we refer to "PC".
>
>
> r~
>
>
> Richard Henderson (11):
>   target/arm: Pass in pc to thumb_insn_is_16bit
>   target/arm: Introduce pc_curr
>   target/arm: Introduce read_pc
>   target/arm: Introduce add_reg_for_lit
>   target/arm: Remove redundant s->pc & ~1
>   target/arm: Replace s->pc with s->base.pc_next
>   target/arm: Replace offset with pc in gen_exception_insn
>   target/arm: Replace offset with pc in gen_exception_internal_insn
>   target/arm: Remove offset argument to gen_exception_bkpt_insn
>   target/arm: Use unallocated_encoding for aarch32
>   target/arm: Remove helper_double_saturate

Whole series
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I have one query on 3/11 but the change itself is clearly
correct so it's just a question of if we need to tweak the
commit message. Once we've figured that out I'll apply the
series to target-arm.next.

thanks
-- PMM

