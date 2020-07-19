Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD4C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 09:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95D42073A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 09:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIpUOrrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95D42073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx5db-0001R5-5p
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 05:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jx5d3-00011x-K6
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 05:29:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jx5d2-0005LC-1A
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 05:29:05 -0400
Received: by mail-oi1-x244.google.com with SMTP id t198so11933096oie.7
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2020 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P8dl9Qcsxx9hAVdAaDwUDcSMvPUPhkrjeNUIMbut4Es=;
 b=NIpUOrrNbxLXP8qqq2nnyyfzf5ewz7eH2/89o8juj102ccBV/hn2qO1wQeS8PWcimT
 WUfq21XR4rGjTmoQBpl/NOHorbKYH3iVGe10DJIxeUxNDRQzh3fWH/PafpYkwuynqhWb
 UR3QPmcZ6X36gckPscq9yIjTRULEX5fAzPwCaOuw1qLUr9fdiZ/e0yn5ltkRyJobpQDX
 +ENyUDRkEsySEVMfmbsoLnT+W67fnL8X13jFfOuYpHztXHvdYMc+ljwiSTmFHG/PHotp
 Tber2YKhYnTj+xL3d42KNIy7RF8fxqQlmE7gecNExnWGF9kESFjtPRa3Dfbi2NQLd2sH
 Chnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P8dl9Qcsxx9hAVdAaDwUDcSMvPUPhkrjeNUIMbut4Es=;
 b=hgyh+CrYKRKnZ9sepXM36naqXkRIG3xQMnnm8hGd50eOVdgZxWmTx0OS/oo8z1k1X/
 herahMUXd12B7wbzow+IHDSJuIhWo4LTEe/RImdmkwuKL3uBzhGyK1/koOU+HQE+oZ8o
 5sFm0RIdXXlpGFIpb1gToqR0Pl0OPYAV5nPAPFxQFABB2qlT7IUQb8PHpcGXjkb3CF39
 aAbM4pcrZEQy1o6FRELvQdl/arap6u7mNkKh832VjAOfXKvzL3xgveRUEbikYVo8QLkd
 /qMMrk0LLmWuzhYmAmVKXpjn/8V9VTQdcIV8hZKLhLDrpvoYagvg44i5rgvnsWLjDRLr
 Qq5w==
X-Gm-Message-State: AOAM532GHYEDeFm75+TWdUffRyFp9eFF/U1WfCm3VnWXox1tbVuB1t1y
 48gs38gwYBj77jBTnfzwAvKnHmQ/CEk2+jEsHg3cFg==
X-Google-Smtp-Source: ABdhPJyWQYQXLfhfmR3D9jC2Ramj3Je0//XezTf2j/sByHwRILn5sQTEGo8/Y/YUW091RzEHTxDq+8kdpZrPrL2MSWM=
X-Received: by 2002:aca:2819:: with SMTP id 25mr12881608oix.48.1595150942679; 
 Sun, 19 Jul 2020 02:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200717164803.GJ29192@minyard.net>
In-Reply-To: <20200717164803.GJ29192@minyard.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Jul 2020 10:28:51 +0100
Message-ID: <CAFEAcA_Qt-sK4EOevzJG9DeOHveEda4+E+_k=fd3SAXLs1aCig@mail.gmail.com>
Subject: Re: [GIT PULL] IPMI updates
To: Corey Minyard <minyard@acm.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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

On Fri, 17 Jul 2020 at 17:48, Corey Minyard <minyard@acm.org> wrote:
>
> The following changes since commit 95d1fbabae0cd44156ac4b96d512d143ca7dfd5e:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200716-pull-request' into staging (2020-07-16 18:50:51 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cminyard/qemu.git tags/for-qemu-ipmi-5
>
> for you to fetch changes up to e3f7320caa1cc08a9b752e555b79abd6218c7c7a:
>
>   ipmi: add SET_SENSOR_READING command (2020-07-17 11:39:46 -0500)
>
> ----------------------------------------------------------------
> Man page update and new set sensor command
>
> Some minor man page updates for fairly obvious things.
>
> The set sensor command addition has been in the Power group's tree for a
> long time and I have neglected to submit it.
>
> -corey


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

