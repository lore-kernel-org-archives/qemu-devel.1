Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3844AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F4F20702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/CSKS13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F4F20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRhR-0004sg-9m
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRaU-0003Fa-DR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:06:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRaS-0006oc-EV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:06:42 -0400
Received: by mail-ot1-x342.google.com with SMTP id 72so5168187otc.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/W2L9pXJYclFws7rjK9bXIcS7kFKPWtf3pvQGjGXRUs=;
 b=Z/CSKS13BtbykJvBL5i89Cv/AJ3jphQiw8jYZUJoFNOlzrPb9vvzBf7ukVXn1MmIcH
 8EKr1YRLDfC53s4JD6J5D6+cRZt3aMR6ZvMms8VPRaqgTGz+xDskHmeUhbh1xe4pW4c5
 tXVwteJ8fthmE5p4vd1FFC+Yq4ijiQgcAkPd5W0OL/n8P/ECphOiZl4wL4N9YCl8rI0D
 jZfTGIo7Vb1nF3ThmhP1ujVte39+yjdcbCgxUPPMxu/YPLkASzVYXccGkLNsDHarQWLr
 QuAFm6H8G2fCoW1rJZQD2sNduXBaT6OERjrMSsQeeQoZ7qH8EeTXVY97m7cWOjLDSj7b
 ZrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/W2L9pXJYclFws7rjK9bXIcS7kFKPWtf3pvQGjGXRUs=;
 b=RnEucW/oeHTWZayETfDrXTiGTUH8U0Ex2ik+k7mK5lA0uJPyFO1kWDlHrSb1B2vHw6
 KNRKiAYvRNah0YxDTA5QwQnQPyO86M3pOZ47toVJkmQY+5nGtNix8E06AQmkA93GSZfI
 Uvq901bu3cJtgBr4WPzmxT2GgB+qw2jj/irfPMDAzhmzLIswqLTupWN6BxaAlgb174XT
 QixroQ0r6x8v8LhB+QFaETVtXZD48mbuCvfThB2zHa9wA0ynRTEh04eghnLD+uXLt9U/
 RhVNBIUXeGiVo06NBCwUzurhdTHMT2QR4ysj94pvu4VEh6D7ymAl8revRIBTle6ACl1l
 1b1g==
X-Gm-Message-State: AOAM530eygEb3mIwAo/peLDSPaaRQ757SJJgYbHWOv20nLctmha6L7CH
 pkJ7KDEJdxsh6DglcXcIkRHtyv0lgbN0Qepzvk3lxg==
X-Google-Smtp-Source: ABdhPJwFaug5lzuRB7YZH5U9fHfPEcTPXByyy5hvbuduCcygbie9F29zglwcLMinUsGsNiK8HhTXLbFiP8AK5ajTFRE=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr25424166otn.221.1593090398997; 
 Thu, 25 Jun 2020 06:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-46-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 14:06:28 +0100
Message-ID: <CAFEAcA9CZUH302_yy=HSX7J3XD=Voj1JvhC-AhL-+o4aDHCkgw@mail.gmail.com>
Subject: Re: [PATCH v8 45/45] target/arm: Enable MTE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We now implement all of the components of MTE, without actually
> supporting any tagged memory.  All MTE instructions will work,
> trivially, so we can enable support.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v6: Delay user-only cpu reset bits to the user-only patch set.
> ---
>  target/arm/cpu64.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 778cecc2e6..45b0ca7188 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -654,6 +654,7 @@ static void aarch64_max_initfn(Object *obj)
>
>          t = cpu->isar.id_aa64pfr1;
>          t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
> +        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
>          cpu->isar.id_aa64pfr1 = t;

Worth a brief comment
   /* Will be downgraded to 1 if board provides no tag memory */

?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

