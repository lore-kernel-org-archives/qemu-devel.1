Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBEAC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D166024672
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJ8VZtkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D166024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4pj4-0004rJ-1H
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pi8-0003yt-HH
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pi7-0000ao-Md
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:34:04 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4pi7-0000ae-IT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:34:03 -0500
Received: by mail-ot1-x342.google.com with SMTP id z9so4438282oth.5
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VbXKch9vGVWuUHcLou/qd2nd4WkIuVKQM0DmZMYmaOM=;
 b=GJ8VZtkQJyAOoU+7mA4BVE5BpwnCYMntzJpM3EWWWoio603Wux/3b0gaCpXhOQDfGr
 TAE4Ke6QP4tn0p5UOzrSzhty820HwtpadzU2Lz5jtaKBcdMLrXYwuPBXT5wF7gS3FgNK
 H7Nigz2ugvPbSBAFCnXUCQWWwCN7ydaF/id1ZwHUA4BrHpwPdEPTtQICuEN8o2o9Q7oF
 tgYmJ4H0iSE1b2jPVDtv4DD6UCx/JKX51xi8g7WqR7QIPOBqAskgVQXQTPfz3eGXHuRd
 rc3304SdkD7qVqEiE8D4tBFfA3LSZMZ6Q0IaeyEfO7RG16kUfD0Hiq/iCLcsSpAfyzoJ
 EaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VbXKch9vGVWuUHcLou/qd2nd4WkIuVKQM0DmZMYmaOM=;
 b=rhYu6B14rh0ND8pl0eYd4H5uru7KmVPLdiMh6YZdfHBxXOButu2GT8wU+ftcAuPQgY
 lnNUI6VjmBtOV7VEu+e3pBUZFPFkc309jxlq9dsz4/oaYLlqgoXxw1Qggrvly48GOVmS
 M5JVwosZAIIg8DwjwoZ5rC3G2Y/6beUSL7+LYy9sYh1FNgJP6FLnNB9aAM8YijL5FN2p
 VkKp9fCDd6BWUui0+dsjrRpnp0BXbl9IWXD+WuVwBbC4ycZuNR40EWM1uHEkgscvN2ZV
 1mtiWyB0kZ1E32rKLOdvJnu+0u/d4G4m6LZK8IhyXopNoVo7PM1ZyxgPH+XsKfXzVuZW
 Dvcg==
X-Gm-Message-State: APjAAAVPH3rv00EVNcX9vookZmUI0AZjGTpEwCL0Qu7AjB5Isg4JSNqr
 Qtz4QBfDt1Nh+9vVnLmJtRGRQj+LKEfetDAPqbaG1Q==
X-Google-Smtp-Source: APXvYqzouQqCcOmswyLsPu6X3Nly5JcAQJjQJmhNRexCtyOsijzf8b+pJA7OI5Wjs5CSS0Wq0fGtMEWTf4hGTnVMVko=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr24785473ota.232.1582220042795; 
 Thu, 20 Feb 2020 09:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-17-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 17:33:51 +0000
Message-ID: <CAFEAcA-n3sk_kTVsOrxxLcf-OqDdKt=-2QYu7mUgwC6krnQF5A@mail.gmail.com>
Subject: Re: [PATCH 16/19] target/arm: Remove ARM_FEATURE_VFP*
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Fri, 14 Feb 2020 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We have converted all tests against these features
> to ISAR tests.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

