Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E43C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84462073A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9cmf/Ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84462073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBkac-0004ki-09
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 16:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBkZw-0004D1-Aj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:02:28 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBkZu-0000bc-Qe
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:02:28 -0400
Received: by mail-pg1-x544.google.com with SMTP id v15so941926pgh.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=hdsj7nza4NpVYYIqGQbcT5f4oV+qZDYCHoJXY4Ym8r4=;
 b=B9cmf/VeSKMxqoHooDSP053erCqHmKTDSP/9veM7nQkYzN0LUeJGnacn4AfUjRIAdv
 gPQJ/fLXmHPkx5dmQC5n2DAHAQsIaAEB5tQ6gXKhPiyyi7XBcfDoglx41nThYWeNs43s
 StbSJTBFhRJlIDjJNcB4heQ4TtYQDcH6goxuIcvmGJIbE+YDMeFHfdbns0oX9hIci89S
 QfVm4/1RmF9UlopiXD2C9zEeDs4PHU/dQV611u4WlElHFHdP7pWGTgaWfUFjAHhtbWPj
 HSfGoWfe2ySR+IBvlJJxY3swOVlC7S4LGSnWfkXft5fGeUI5LBjIuXlLdEEHhZ+ePY6p
 x7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hdsj7nza4NpVYYIqGQbcT5f4oV+qZDYCHoJXY4Ym8r4=;
 b=EgrlgddNCOFFvnt53Hs6diKThVMN1eEtblqLpTDlm+aWduvm1TUVv18/ISzFXqFjXf
 cEVsZiXiGmOwZPC8gDAXialh4FfgAokiV4iPwU5uU54pWBmJJDUEwQ0qwHBv5a4WPB2s
 tTbebFhzqOq72rgjJl5RSCGPTQebxNwoafvSJzbl+jJ7NBJOd0A4YR5Cc8oUDH732IHa
 h718OVZ210dGllE40skNrgmyV0NJWVhMKC3LXSE4uDZh0q/j1BIVVYgqtg9W5XeKUwqx
 ui9GG/HHbj1zKKF0pMUeX97N7v79eMsIh+n5F32gaqS2wv+vX55gm3HXSuHHlURlEZNq
 zrwA==
X-Gm-Message-State: AOAM5307fDT1n6GavAx12pqQ81jA8Ye9uyOckCpvvOdhe6LAuerPi2OR
 yyZ8mAowJGQSSXapslZ8RnfqD1RL5JDR/g==
X-Google-Smtp-Source: ABdhPJzXrnipD5iw23Uuh7SpYRJSwa62yCXtYBOQKOUrOzKkFmezAvag5gxNkqqI293hJLNTzPY4qg==
X-Received: by 2002:a65:6a55:: with SMTP id o21mr358813pgu.64.1598644945082;
 Fri, 28 Aug 2020 13:02:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t63sm288755pgt.50.2020.08.28.13.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 13:02:24 -0700 (PDT)
Subject: Re: [PATCH v2 22/45] fpu: Add float16 comparison functions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-23-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <21836c8f-93ba-2bbc-d658-a595ace87b3e@linaro.org>
Date: Fri, 28 Aug 2020 13:02:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Add comparison functions for float16 to match the existing float32
> and float64 ones:
> 
>  float16_eq()
>  float16_le()
>  float16_lt()
>  float16_unordered()
>  float16_eq_quiet()
>  float16_le_quiet()
>  float16_lt_quiet()
>  float16_unordered_quiet()
> 
> These are all just convenience wrappers around float16_compare() and
> float16_compare_quiet().  We will want these for AArch23 fp16
> support.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I already have this queued on my softfloat-next branch.

https://github.com/rth7680/qemu/commit/dd205025a048ef6f53ff51eb86ddc58e7a82a771

I plan on issuing a pull request for it soon.


r~

