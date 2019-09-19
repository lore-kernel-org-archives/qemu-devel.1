Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93590C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC9F21D71
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQsS66C6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC9F21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4oU-00057z-CG
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iB4ai-00078f-TB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iB4ae-0001Fe-1M
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:07:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iB4ad-0001BZ-PI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:07:51 -0400
Received: by mail-pl1-x643.google.com with SMTP id q15so2217436pll.11
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zn109NspYuddncozafqxVjUrrzvHkyw69jS7Iiefkx8=;
 b=UQsS66C6C9IjyVpY7ax8CgvPkPxh+9rJ/eDfBi3NJeyYkDZKVl3B6ibLfCH8W/Uaop
 BVrgOSjQtwUUUEj2VSwBHjHtQN4n6zt1aM7tPmI0lmHJOiUVPj3RLtnEFqvarerJ9/FH
 RSTj/A6keeEsXa5TjmG9VrUbMEpm7NO9ugpR01i8PSNog0hC8VEdDWoTGpcmCRBFqu/R
 AhrQVNqii2W9bZwLKXOXX6dVr01/xIjxEmIKJS5Y8V1ak9MuNz0ik+RVnzuI48Y/XY+W
 D/tyt3u6HGNEolXz921Sm55PlPVWtqreCt6tw2wX2NJq/Fggzk7WTgCgvETFkGDuVpEL
 GsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zn109NspYuddncozafqxVjUrrzvHkyw69jS7Iiefkx8=;
 b=Zb8/gGCZ+woEACuPdVJuaHEEPjmxbTpXrZitFFuWC+ezL3w2B0RTMM4Mqif0ZKR5Q3
 ZeZIl8s+qsqmw7epEHiaIGWyoDWuqvNws0j4iVbsBnRK+CT/Jypao39H28B2eWBfHwUu
 bbrIaa39/MVbJ4SqeLoe40MVMECp/zlR0p0sVFwxn+vJX3kfaUPEGW6WCwihY0ZMLwmP
 Hf3ihJGVBVJGiCW1qbK4fdz2Y6aXkzwkkt54NJb8pr3jYBXdQIc6IHUS+LuOfcBGaAD1
 qM2aq4z7B5vnLAJikVTiA1L7m+qywvbRBLvC5iO5hZ/9EE88OlBiYGiFr4MjhlumKs0x
 IFGg==
X-Gm-Message-State: APjAAAWwcovkL6A2vQnAhYiAC75z6NtFkeTWBkDbUbgqmYTBGT41bBml
 XTKmMFVvCPR8qvzkIxyS+JTkVQ==
X-Google-Smtp-Source: APXvYqwf1+KlV06d6P5/M8Cjx6hnXKuha3OOA6KfrNJC2lfXgemwubSmZrStYOtTs7k6f1Vu/wSjQw==
X-Received: by 2002:a17:902:8b83:: with SMTP id
 ay3mr12592214plb.32.1568930870441; 
 Thu, 19 Sep 2019 15:07:50 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x10sm2815pfr.44.2019.09.19.15.07.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Sep 2019 15:07:49 -0700 (PDT)
Subject: Re: [PATCH v2 09/16] tests/tcg: add float_madds test to multiarch
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190919171015.12681-1-alex.bennee@linaro.org>
 <20190919171015.12681-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fe7844c1-d34d-0f6c-627d-b3ddf1334dae@linaro.org>
Date: Thu, 19 Sep 2019 15:07:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919171015.12681-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 10:10 AM, Alex Bennée wrote:
> This is a generic floating point multiply and accumulate test for
> single precision floating point values. I've split of the common float
> functions into a helper library so additional tests can use the same
> common code.
> 
> As I don't have references for all architectures I've allowed some
> flexibility for tests to pass without reference files. They can be
> added as we get collect them.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - allow tests to add addition patterns to the list
>   - conditional diff-out
>   - use __builtin_fmaf instead of forcing optimisation
>   - use hex floating point definitions and output
> v3
>   - remove add_const stuff, make explicit tests explicit
>   - various style clean-ups
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

