Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B48C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0AF2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIRRSpL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0AF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOy4-0005LJ-HT
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOwO-0003eS-MB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:17:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOwM-0004Hk-Qd
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:17:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id m2so4714727otr.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eeyo+75/orNQ0G3OkE5kjiaL52lZnCICMfyIyvlFIG4=;
 b=aIRRSpL8aUZrAgTM3F1X0naVQo0wvs0OY5kkSQqY8eCeUpIjWCt8ljdcjnew5Ighun
 H/MzjQ36IuTrX+subP8KvYg8jOvHp3lGK8xja+SukxEO0/7b7XMG2ktiIizAo0ZMnT9D
 vvgU052NDaEhkmGJOKEwpn8/0V49h/yujtlgO8GrTb+ycgNQJ1i+0szb2MGlLA5YkBMz
 4S5n30cojlHv+N4rzhbmYT8q1XtgqWIbOODMVsXkbj/bvnxwIqunlVMRe+NWe5DydC/g
 JpylBAs7FCtxI2m1uVMfeNYUC5+Map0M5DkIZl8/ltF0bADtFbAUPoSjUJ4nKLxRb6GF
 yfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eeyo+75/orNQ0G3OkE5kjiaL52lZnCICMfyIyvlFIG4=;
 b=dWKKNS0u49vs7LEMUsKpeF1PFixXG50IAhpLqb+G7fbLPnwwc3di6l+8Wf8Thl4SUa
 qs+6TY24ViQiZ6/E3dFoYz42Ga+Br8GQUiE29Tn543DejgKgS1Sjde2ixrt/dqdS3ndH
 Fe0w5qQjrC4ddsAD3j7WvqEjQqfVJPSkLvwJeGiAk+HGdwJdou+B56HS9nHEwqbRj8wi
 lxeZbq43jvMS2F/fVAV4gHZNRb4HDxh1dsUQFYyiPiOCycepM8z9szTZSsQBWRSSbnrb
 jfJhqoKL0pLpXPfEll9mD7cShl1ZU8CUhBXF1cmrBJ87Mzv6BqKAu5bgRdeW1Qsgma4O
 OUiA==
X-Gm-Message-State: AOAM533ru39Z1gTHXxhVuDPqVVz/S2GVzX1NddfJ46QjyXu5oYO/C4Z/
 b+sif6c/mjUJcUhNPqz1tHgCXXtBTXy45YoIKPm+FQ==
X-Google-Smtp-Source: ABdhPJzuP3Wc5rI4xShbbWUxY+g2C8YHZR+wICLgfXjX+DmkF13U0s3D4329Lr7tZAVJ1lRp1GTugr+NaBzofUKaz4o=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr12256452oth.135.1593080224641; 
 Thu, 25 Jun 2020 03:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-11-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 11:16:53 +0100
Message-ID: <CAFEAcA_LnXtSTxeJzHq_y_CL88buiu2RZ8N7S9pcAarYsbqdGg@mail.gmail.com>
Subject: Re: [PATCH v8 10/45] target/arm: Revise decoding for disas_add_sub_imm
To: Richard Henderson <richard.henderson@linaro.org>
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

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The current Arm ARM has adjusted the official decode of
> "Add/subtract (immediate)" so that the shift field is only bit 22,
> and bit 23 is part of the op1 field of the parent category
> "Data processing - immediate".
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

