Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB9CC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376B220714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0t1iFcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376B220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Xvi-0005zR-CT
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1XtN-0002Ke-U8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1XtM-0006JR-WB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:56:05 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1XtM-0006Ii-MF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:56:04 -0500
Received: by mail-pl1-x644.google.com with SMTP id j7so4435831plt.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 07:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QOk9GEk8P97Nr46FRq3IM9r/5hhIciqeGkunvl9OamQ=;
 b=B0t1iFcSlUp8EdhF5M6r0ToWHz+dvNYm8TjUumCfuMfflP3ueM6Yy0ZeTSNyl4cgKw
 wRsbQ3OR9I3s1gYqr/gDbw0TrM0zblFDD9QZla2am9wUVBmYAINNMrCPXMXrB48jlmiH
 7np3QfYLBJ+fNxJrUPy5N43gvGIsljBAmRTZUQ+t0kwVSfra3KAhGeabxz6w4Kb6S/5W
 SqQBheCDtHMGBGknWX/TGN6zhS1+tOvu8m9s6zgl1/NeCuJkUmdXZw+WX2qFDD0wOQeT
 qZDKfya4DQ7ahMIuZcvk7O7b3BBJiA8SAhKvDf9IsO+DES1+XPDCFWtpFMWjN1QPJ6Hp
 vKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QOk9GEk8P97Nr46FRq3IM9r/5hhIciqeGkunvl9OamQ=;
 b=l3w6kMXvxNgwoj5cduUA0GFR2yDgRcB1RVW/vIoagdBOyBc3e0NmfZ8ky9Gp7rMKmH
 5iVYeeTT/SowfcFq13w8OT2kbHGuvnq4MRoWFUfP0YXl5Fb+PKyfFhAHnfcE2t4J8gbk
 ftTzl3zm5sUdjzLVSD3Axf1BgdYxkLfL9Bf5URZ187O2Ve0zivvAJteC4BcDt9ukMNtG
 KAta9bCiPeyRrPPu/4XwGImGLX6E5svhXYqsgPmJVsVG2MXCkA0d2CNGxoYpp5fA6mGN
 uhAsJgQ47g0SZ4XnFiKBEY7eaNMYurem+I1Qacqma0x8hzj4q50n1SMxOsnV3/OZ9pZr
 Gr0Q==
X-Gm-Message-State: APjAAAU+8QBzCplCZE7CDiWqwfDrVWbv8rSMCHHG5HJg7QFDlnbLOzUr
 hfZ8mY3vWkkjHkG9CWH7aJH83Q==
X-Google-Smtp-Source: APXvYqwVvzaH/BlUTphcFqRVnMy/yK50hn4/J1hbAU7/n5f0+sLnE5oOzDLPRny0YMQ/4DqiMhzwmg==
X-Received: by 2002:a17:902:9a94:: with SMTP id
 w20mr19070104plp.6.1581436563595; 
 Tue, 11 Feb 2020 07:56:03 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e38sm4333195pgm.82.2020.02.11.07.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 07:56:02 -0800 (PST)
Subject: Re: [PATCH v4 2/4] target/riscv: configure and turn on vector
 extension from command line
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-3-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a1182b3-b92a-51b1-1784-4324250fb2dd@linaro.org>
Date: Tue, 11 Feb 2020 07:56:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210081240.11481-3-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 8:12 AM, LIU Zhiwei wrote:
> +            if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
> +                error_setg(errp,
> +                       "Vector extension implementation only supports VLEN "
> +                       "in the range [128, %d]", RV_VLEN_MAX);
> +                return;
> +            }
> +            if (!is_power_of_2(cpu->cfg.elen)) {
> +                error_setg(errp,
> +                       "Vector extension ELEN must be power of 2");
> +                return;
> +            }
> +            if (cpu->cfg.elen > 64) {
> +                error_setg(errp,
> +                       "Vector extension ELEN must <= 64");
> +                return;
> +            }

ELEN should use the same "only supports ELEN in the range" language as VLEN.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

