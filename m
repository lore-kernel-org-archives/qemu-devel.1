Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6AFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69832206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogoLW/Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69832206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtE5L-00073D-O4
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtE4P-0006D4-2b
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:41:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtE4N-0006ve-Jo
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:41:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id o8so4121023wmh.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D70MS2cEBt7j6BZIppVceongrX4lu56v/SDFfQYlWIo=;
 b=ogoLW/DdyMEEWczI2Y61/KRmP0MkjUxHE79D0fNPbt2z7GTVWgk2Tw4NvSN2xiVZ1w
 Bjni6o61cNseYxRwmKkzAa/Kf8Ta1Ss25Gub3IOH9OPWp1uswrUmWt1gyqiMVglGzzK+
 yFDiYrf16ODLLd8k5sFQo07OqfCIpAbn4rRCN1N4cZh9zTVCCdPKfafVjCU2RaN4qqfL
 DAQArlFFLgDyq1XTpyNkRp/qWTJsQID2LGxIMotZ9p2LMs1IzdBdChTngxe+USRztjex
 X/GcW2CZtDq2a7qvtUe8012hQRuPHLXrLr6qEE77zGyebZpqaVh4abX0rrU8W2GKI6fr
 zjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D70MS2cEBt7j6BZIppVceongrX4lu56v/SDFfQYlWIo=;
 b=Dec3ig//zg9329ICtB5aIz5TajqCGn9HHm3XFKr4jg/B1V0M2dDTXGRiZwXJUXHPYw
 +PsDw/DGoxZ7RnJ+v6LlYPtJjXIO6UFr2JxWY9he3JFG8XpY4Rkl4uKyWa6KpFtuEB5A
 xZrCCijB5LecmP6bIUm/Ag4Lv3Pi4to29Uoa4kE+b3Bafmbo/lhCAwjigAcADcFOdDSW
 Qy+KH30e5itFwXlgWcNHxqDXTwFYlrZFaF0mTYwfk3xOik3JAGIDbDdXQkHARMpyeZ9a
 ED5QXwiAfVRbUQ8B23H7oYy6s2PFXZf2FpxsK7K5L1njYrvVOsAv5pVJM91Nh+7G+/tj
 pB7w==
X-Gm-Message-State: AOAM530QNNBcHLJv9hP7ZhAXTA1S3JgK1r/DhG/wqo1YdcSshMgpTXsO
 z5SHNToTfdDhRsvlEM162mU=
X-Google-Smtp-Source: ABdhPJygoJ8rVgJuMR7Wk1uQGDXfNpESSkIi/4aMnQVaN5YX9uz8Ph/AjG9jvxCo5+V5JIvRchCEAg==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr10840362wmb.165.1594230077805; 
 Wed, 08 Jul 2020 10:41:17 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm735303wmd.20.2020.07.08.10.41.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 10:41:17 -0700 (PDT)
Subject: Re: [PATCH 01/21] softfloat: make NO_SIGNALING_NANS runtime property
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-2-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe6c7da0-28fc-a8e1-b332-3e44ac75d045@amsat.org>
Date: Wed, 8 Jul 2020 19:41:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200706234737.32378-2-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 1:47 AM, Max Filippov wrote:
> target/xtensa, the only user of NO_SIGNALING_NANS macro has FPU
> implementations with and without the corresponding property. With
> NO_SIGNALING_NANS being a macro they cannot be a part of the same QEMU
> executable.
> Replace macro with new property in float_status to allow cores with
> different FPU implementations coexist.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Alex Bennée" <alex.bennee@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  fpu/softfloat-specialize.inc.c  | 228 ++++++++++++++++----------------
>  include/fpu/softfloat-helpers.h |   5 +
>  include/fpu/softfloat-types.h   |   1 +
>  3 files changed, 117 insertions(+), 117 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

