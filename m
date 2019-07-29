Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9CBC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA6A206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvDxtZNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA6A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6u0-0005S7-0g
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34422)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6ss-0004Er-DX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6sq-0001d6-0f
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:44:17 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs6sp-0001cD-Ry
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:44:15 -0400
Received: by mail-ot1-x341.google.com with SMTP id r21so56756089otq.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mTou6HtwuM+AgGnMhdLUP2Fz/qAdbFfW2Ju6OqoHdhU=;
 b=CvDxtZNp1yV6suWBasV+vzxVXRJT2rRRzasN0HS3MzCPrXmpPe3K1qDZSQPPosDk62
 tz8SG20Y8niZkHiyKDyIseHr8WuC8XL4PmbVcPU/8rpxkowkzjHVzF1+P1X1nUf+IkDf
 ErxAiv1yQewUbFlKdwS0YheigzNzgHCHNEBJOPyfM3zhqrr75V69tN8Y9Lhp1v30j9Fw
 OdtfJ1ruEB5rmyG+aicFGAaqkpkQypUaf3CdbvoO5sktwQ91OnQbbt5augyOGraRhfS+
 W2uMGayD3Linb1kDYq+66fPTF4vOQXdzx63mz17ETTgfCsug09wvHu0G1kMNB9kbkBSw
 zonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mTou6HtwuM+AgGnMhdLUP2Fz/qAdbFfW2Ju6OqoHdhU=;
 b=BJehSNmt5MdA7yzRrLc9T4bdLh7CQH++27RxHe1IAbHE47qOAnXhud6eGCLUaOzmO4
 atwL3GMPLFcZpaShQgd2Ze5eD9Tad1Q3u3JKPxT6oaBzJx3Aho3AH4+rTfBfCkuzBWT/
 OA0jfaigsm4WRrpEvKaX0M8ZkDd8mAJS7avXOu0dpCH+/9mU8WO8MxDVtE6PqVAYBCWt
 JZ6mrPIbc7I4bfMs/kOrBloz2KBSirAhf9mqoDoaT+Kze45kxtcc7G0zC3OJxYEql1yf
 UbV5u5LDUzSQvfD7cZhVKaJ0Qdu863HVWnCJIz0mN3uaXHfbHnTIDRWv73CfcIytxDUz
 /4Xg==
X-Gm-Message-State: APjAAAXSBehTwQfTAgO7G40NM0viu0fa/1/J+FNTLkxhB2auRbBYLUIf
 E59NlfF9QzhkHYhg3s47jMk4B4USQWWJAsYa34XeiQ==
X-Google-Smtp-Source: APXvYqx2wZR85wknbtBk+Oz/cFruIITlRPztJwbZy7sDx7j2RQfD5cJH19rhs5XqkhRYAvtBolWH96EQuwzc2sYRlzs=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr27123423otr.232.1564411454250; 
 Mon, 29 Jul 2019 07:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-13-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 15:44:03 +0100
Message-ID: <CAFEAcA_F5PrZPJ6ocxCvPQZ8zMgWZyjXsgtDfftheXL2=WqBpw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 12/67] target/arm: Introduce gen_illegal_op
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Unify the code sequence for generating an illegal opcode exception.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c |  3 +--
>  target/arm/translate.c         | 21 +++++++++++----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(This feels like it should go earlier in the patchset, before the
introduction of the decode skeletons ?)

thanks
-- PMM

