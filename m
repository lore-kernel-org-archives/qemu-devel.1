Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B1BC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A3A20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1/f3Sl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A3A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aJ4-0008PI-0F
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aHn-0007Sm-7e
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aHm-00068M-44
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:29:27 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1aHl-00065Q-St
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:29:26 -0500
Received: by mail-pf1-x443.google.com with SMTP id 4so5886970pfz.9
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9IQX76N1HVS8RO6biOhu769HLbabl1tu8cVc/rmMs1c=;
 b=c1/f3Sl8IyBvlBnrrWcrKtWuUbOsdK21+s7X7vze6mydlmhO8cCplVFedWP3+TU+O7
 r4WLf4hSJTxt7z4Yvnd9Ps+Ka0FpNCbpDqXGiaYTIgAhruardKB3Y3jo61qY8pjrhegG
 y/jJYoyhULoys/FMsW274ljtnrI4q9mAwl1FOiQi/jm4g0/xjqdwhHMtFYHYoOBOMIJZ
 Q+ohPE4uviLlyT89pObwfwihPU05/AgZFsrrRAAo3ZwplgtxSm845GgaAe2rGhyYZLtL
 XsKa32wmXSfp62ph9zVovrDWxHTQ1VkUp/hGgtbXSa6QPZCzK+e8N1Hi7trgWSIR4rkf
 nepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9IQX76N1HVS8RO6biOhu769HLbabl1tu8cVc/rmMs1c=;
 b=mfFn93EUfShBE0dAXo9hkdU8Ve7TS8GjZnFqnl30wjZnxSao+lWtVf6Uwjw2FjX03U
 V8EKfTgD/kJtjvSKylnqf+sxxrVUGELhh59QVUzb1JVWbc77S6MJz9rkRV6RTeL1cuoW
 y1j2hGio/08n0E4RM9cUeomcRCz55AVg1/v7X3cntkH5OAUhmfsKWGjqY3L5B2ZOf1QL
 thGuuE5lvydj4o1ZTnDHWP3oFUrPIkqzJh/N/0RIYrd+xkuhogfu2l92WACKQKshHAmD
 1WvRDGwzCPRaVM3DvDtgYMfKrKaRm9q0hOIFwbDzQeYMkniyubX4r7Gh3F8XqCevqIrH
 E9nA==
X-Gm-Message-State: APjAAAWAERq7QOoWN01y/IYli4dO13Rgy8h1beFcL/aEW5si4L2OWp+T
 /mGAoa8bysdMVpyZcF7TfsFTCQ==
X-Google-Smtp-Source: APXvYqx5ZgS39wdTKIUz25kzKF+3sks0s84NIVWJrLx6f0mi8udz8LoXKfQQCfi6ZIOKEVAR5dJLYQ==
X-Received: by 2002:a62:547:: with SMTP id 68mr4427817pff.217.1581445764876;
 Tue, 11 Feb 2020 10:29:24 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 gx2sm4041591pjb.18.2020.02.11.10.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:29:24 -0800 (PST)
Subject: Re: [PATCH 03/13] target/arm: Define and use any_predinv isar_feature
 test
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1354828b-4941-0025-4675-c4105b4f3df0@linaro.org>
Date: Tue, 11 Feb 2020 10:29:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 9:37 AM, Peter Maydell wrote:
> Instead of open-coding "ARM_FEATURE_AARCH64 ? aa64_predinv: aa32_predinv",
> define and use an any_predinv isar_feature test function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 5 +++++
>  target/arm/helper.c | 9 +--------
>  2 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


