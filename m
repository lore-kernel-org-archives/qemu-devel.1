Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC660C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286DD25242
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRoYMJZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286DD25242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMmn-0001F1-1i
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSMlV-0008Ec-UH
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:03:06 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSMlT-0007WA-FL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:03:05 -0400
Received: by mail-pl1-x641.google.com with SMTP id h2so41759pll.11
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=i+RmpWYdLT9YXqB40aa5IblU2V7Jd0t07I3+IEu06Uo=;
 b=JRoYMJZ9KPmzR/xMzZy0DqCjX6jv5ggJAODpMeOgNobJUsWbfdH/HNzcyQ+xPlWyGW
 oaEdrnCW9W/Y8rvzzoEuyvhhyqdnWPUbVKHOcdgoDTaumO4Spsc7EqLxqpsrfTNyZCap
 ME+hKj86UQB6/Cw9crRnplS+O7QsWjGUFZn4Amd6hEuztcCJbq7+sKuporx8h4x4q9LO
 cS5DiGeTP2sqQ5pNbNEIvYHlSUMJGnr5QaZsHWT9yVRSa1UX/3ZfXPvCuSgav/DsRRgH
 ZTRTb5uXlIAKUykygBtuMHzAhK7CO38ApOwEeqFe4oMN4aMkfEzqLoYWp7Zs8nH+4Q8M
 58WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i+RmpWYdLT9YXqB40aa5IblU2V7Jd0t07I3+IEu06Uo=;
 b=FmYFg8SBgVW0MmO3HMsahQ1kGDFhTj75aH5AOFbFraW5o8ZJ8XBP1N9ei27mswk61C
 rBZLfX8eMD5qwuHlJsXjwsI9QObp6j1jhzgTZ48INlbL0U34WuWDo54kw/6XUuxSH+yc
 QKDDHt6MMWS+NqeIQnhM41xABQfT+fOR0fpH8S1wnGecM3x+LgU7gFXrHQW5P1hy2Brk
 6ie1gfYKnQ59ZUqkgz5LVC94Ttz5732EeGNxr7++nOE20Np7cMbmWrrM52J2zI1i4q45
 cp3x7ICKpVbEPtLbC5eXyCdR5hyau+doRbeanImEU9rZ6cTeNw9tS+ULZV7nlB0GDGRQ
 +UAA==
X-Gm-Message-State: AOAM5318eIhmOWpdqsQK09AzfLw4qZw/z+dB6HDNmIDNV//0itB2/S6p
 d2Zns6Q1I5uYZugE4lS1LQCD0VRIXc31thTv
X-Google-Smtp-Source: ABdhPJxJhrKyxwSfNbkkuMXy41LJYHSWuPlNM+CN++9yjqGZ7BMtiHyY/G7L53mPz+x8oXUmqe7GTQ==
X-Received: by 2002:a17:90a:db49:: with SMTP id
 u9mr398137pjx.119.1602604980788; 
 Tue, 13 Oct 2020 09:03:00 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f21sm44164pfk.169.2020.10.13.09.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 09:02:59 -0700 (PDT)
Subject: Re: [PATCH 01/10] decodetree: Fix codegen for non-overlapping group
 inside overlapping group
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <084c4adc-9c9b-a0db-61ed-6d714e337d28@linaro.org>
Date: Tue, 13 Oct 2020 09:02:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012153746.9996-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 8:37 AM, Peter Maydell wrote:
> Generate a "break" instead, so that decode flow behaves
> as required for this nested group case.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/decodetree.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

