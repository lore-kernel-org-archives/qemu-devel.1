Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D942C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0444B207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPN9Ccsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0444B207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluTI-0002sq-9g
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jluS4-0001h5-Uv
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:19:32 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jluS2-0004y0-M9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:19:32 -0400
Received: by mail-ot1-x344.google.com with SMTP id d4so4498270otk.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=719po6yBzvB0Jxp4u8XJmXaxbW6RZMHkp4D2J3C5OrQ=;
 b=DPN9Ccsxk8ixbSgCRjynwjgsqiVhATGw8joqecBLQkskIrhxwQeEjhZr1bAzUMnbN4
 lDIIVmL3aEANnhnTLmyRMZpys62oEHJ/b9QMr2SQsFk93pL9rLHU3qqjveK3h2mWRA58
 VuwMPMBuKCMtQanyWEc7WizxVXlmDktnV9P5LahnybcaeRz7Zfqwww/l9fStGQuEALg2
 uz7mi2Z/7DtwtL28TqtutU38WBbmMc9JzwczPc7US3i6ftxs5TIH5xSVqJt9gMyS0/rT
 1itk1ei59k38illRt522ozScOw/xplH17SgI7xrLXtBGdSxvuqzMXIrELxlACXCHpa5e
 mb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=719po6yBzvB0Jxp4u8XJmXaxbW6RZMHkp4D2J3C5OrQ=;
 b=XVRyDg/VgDS6Pr4NC7cqBLMqKMfG/8xQFZcr5A8meO6lYm1Ueh0Tt40U8ztWpBrm4H
 TEYd1HTxarY+rlYtf7cwK796+cxfHPPpSaf9crCxu3APaMJ1rgnMK+U7eLFtnL5LqwnF
 rnsBVHxTS9Q6ltC0qB2qoNd6EI2tzo0XHHANnMNLxRVH0XoPIodARQ0VMbO47bZz84qj
 uVTFpqmgXP/DI2rhT6j+E5Kmm7f7R37e3rAekZeVPHzfLvyyP1iDx9Juw4pa6GYl4vjL
 V0k61uAi/DwBbBPrXlrNAqwGQp1fxbkxa7w3YxxQt1/qvxtcm5SIzfb090kyJT+Swcgt
 Ql4w==
X-Gm-Message-State: AOAM5313D+UkQLd5qLIRF0Jk5VmRXhD+YWy5T2/MzD0gTBgYA8OGCQ4m
 YspFsjeO31DrjBVNvvt5f0MyFb7qIeN96eg16aXY8A==
X-Google-Smtp-Source: ABdhPJzldg/NXMJPaPL50sLvy/h/8dpgRq0JD/1d6YfxGi8Oz/MkQLRIHXYKaSAGd+lF6WU2sJgOnyRKpz5uraClEak=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr3230862otn.221.1592486367473; 
 Thu, 18 Jun 2020 06:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-12-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 14:19:16 +0100
Message-ID: <CAFEAcA9rJN8uE+D6eOitdsD87Ja764u662Sk3Jb9BE5nRVVMNQ@mail.gmail.com>
Subject: Re: [PATCH v7 11/42] target/arm: Implement the GMI instruction
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v6: Inline the operation.
> ---
>  target/arm/translate-a64.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

