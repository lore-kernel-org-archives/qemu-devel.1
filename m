Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B6C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73601222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qL6RK7KB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73601222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irr3o-0001wv-Ie
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irr32-0000ZQ-RL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irr2z-0006nC-MZ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:21:59 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:50818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irr2z-0006mD-GB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:21:57 -0500
Received: by mail-pj1-x1041.google.com with SMTP id r67so561536pjb.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 14:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5AERv8nsR5Ukb39KPVGYVp9RsFSYNeIq1f64nvTPkCA=;
 b=qL6RK7KB59o4BfL6HrXgUdKpvIPbQ7NsNDtvXWUXUXNQTGqtWinYYv5P+oTviJKnyZ
 pSuJdVZftsydTn3wdGH+tAkIjbIc2VCFptWYRFW5zdZ6M6MBXlTi5mbCzAPUc52U1vBZ
 Xrm6MEys4UtIC/en0VRLMvHF1ATA421U7YsvNVPDyDn+OwxkZ/+di4RJccwcStyeBCDv
 1QFxW188jOqrW0aOHFnwmzO0JT6ao8Yw1TAuiMuUPtdz6t0WMaVQy7BDKg2nFNGubwhK
 4b1nDsOzVQfzl5sN55FthTgY2rxyOpYazsL46UNGbD+5xkZlD6B3RmsOitA/C3TYE9AW
 /A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5AERv8nsR5Ukb39KPVGYVp9RsFSYNeIq1f64nvTPkCA=;
 b=SXDO8/feiQy2y+hhMWlhTXM0uYz5zLggn6VCakbcYUcwuFWF1AOvJEwA7i7Sljrs4i
 TbSZy7jj4SkEl0+5BVgjGaxnI+V8SATSlHFVsGpS1lBpr4NCoi7wm+F/sMwEuRwAJHY3
 3WoiNGbh27sE5fCABwnxV0nsc3es5Cl5fxAdrk3u7nNInWNEmcBhQEdFsjfexrmibUkG
 3F2xngt5VfOKlPfdqFJtuzLThom67CliJAd4WKmIS+2ZnLReApPR5UnrRdL/MqPtP3Qh
 ErvM8VPLHTQuUKp5mSMbmonpb+JB3AIP3Alf85Ywz7zDcA5OYnYAvR3qqbklqRnlwPCW
 vB6A==
X-Gm-Message-State: APjAAAXVA9PpqA5rqZ3/2AX6tXbFFNP6pFVIFcc6yW7oYNp0xuswKmuD
 puc7943QcdmCbfDtuakn1V36Ig==
X-Google-Smtp-Source: APXvYqyb5hNQ0T4Hv11MmQm43ZKjeINB1oj4QLJU4g3/S5XUQai/1kchkrdhnOUT1b13y0QKMY9G1w==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id
 z15mr2654832pjt.131.1579126915831; 
 Wed, 15 Jan 2020 14:21:55 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id 11sm23467531pfz.25.2020.01.15.14.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 14:21:54 -0800 (PST)
Subject: Re: [PATCH v5 09/22] target/arm: prepare for multiple dynamic XMLs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c6987f3-0c6d-22d4-af11-773741f6613a@linaro.org>
Date: Wed, 15 Jan 2020 12:21:50 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:09 AM, Alex Bennée wrote:
> We will want to generate similar dynamic XML for gdbstub support of
> SVE registers (the upstream doesn't use XML). To that end lightly
> rename a few things to make the distinction.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.h     | 20 +++++++++++++-------
>  target/arm/gdbstub.c | 30 +++++++++++++++---------------
>  target/arm/helper.c  |  4 ++--
>  3 files changed, 30 insertions(+), 24 deletions(-)

It seems to me, that if vg were present in the xml, and honored by gdb, that
the xml for the rest of the registers *could* describe the maximum register
width as opposed to the current register width.  At which point this wouldn't
need to be dynamic at all -- merely have a comment next to ARM_MAX_VQ that
changes must be reflected in the gdb xml file too.  Which I expect to never happen.

But again, this is how gdb works today, so
Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

