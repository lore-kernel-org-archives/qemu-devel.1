Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE77C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC13120578
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2NjUxeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC13120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFeU-0007TN-72
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFdJ-0006AF-Ma
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:47:45 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFdI-0000fS-7v
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:47:45 -0400
Received: by mail-ed1-x541.google.com with SMTP id l63so5632239edl.9
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UrEu2309xWRZ6m60JKiwr/6CMxca/bepa4oix3KKf10=;
 b=M2NjUxeJfkuaYdjJ8ur22eV6gnhurul8gUNrfGgBGCrg/HzY1u/be0UZiDDrnH9b3S
 MiIRFjwY+xiuJbstdtqCbuZjE4Lk0y24nLaPb+e6/GasWoDNvfNlnCHd67+7CE3nmsBR
 Uvx6bnxYE69po7HGkMKbNmnTZbooOGhYxJihvyDOXEJXO5ATv4j9Kd82cI1OZyMr5RnE
 yjtVS6ovsUnUKpNBuvk71UCGeIEyPGxvmY614c2CVcYWqSQxyOUnnqQDxK09coMIRofb
 juBCm/th27sclg2q/+ezMvTCBKOQQm5oouXtBZtIhoysW4bun+a+5qYqaxFeIZPpPkzU
 teeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UrEu2309xWRZ6m60JKiwr/6CMxca/bepa4oix3KKf10=;
 b=eS/bwYsSEhstyTAToZ3FQWNW8/SGJGRvueOUDUAm00q90F+NdOhxROM4yS+4QDiIsn
 NZk65g32j2COTYxaJCw+tsW3vnbWfpgH28DD2Ip0+5D0pwgJshcr8ZEZ8SfULHr7WXhf
 kHU/wXW3/kS9aXVlLo+/lTB8jN0rTaXzqzvbTGu5jCrsfhLfOFCDQ2kn3xjSJ3u78nwN
 AC5W0sw+Bgv+LgNqhfZd6scLKQp1ysOSrUftPwOGTvrrmPAPSIAWj5nnrszdWyNklN7n
 EH1Pkt2yuZuEU5GIsAhPvshIv8a8MQnRQjPc+DmeBRDp4ILScIEb6zI+QMIJq3lLrOhe
 TQRg==
X-Gm-Message-State: AOAM53062ZW0g1KFz7qngLOIOIyKWjcW/16ClBlC/FCvlMZFFXW++pcx
 c+XgC8dsy2lACekuY7OACgW1p19vSIP6pDPEQXUs1w==
X-Google-Smtp-Source: ABdhPJzbCDoV2wNsQktMO9+f1j6Dv8Ue5w4oBz9UvquA67yQOYXn92pB1VGaZyvhx2jDzXPGUyEE9EuGRzd9o89g8kk=
X-Received: by 2002:aa7:de0e:: with SMTP id h14mr6075268edv.146.1598287662719; 
 Mon, 24 Aug 2020 09:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-13-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 17:47:31 +0100
Message-ID: <CAFEAcA-6u5WdPJFBu7+MGt2FMF8C-nkBMjuU6ct4HMNdMbsRBw@mail.gmail.com>
Subject: Re: [PATCH 12/20] target/arm: Split out gen_gvec_ool_zz
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Aug 2020 at 02:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

