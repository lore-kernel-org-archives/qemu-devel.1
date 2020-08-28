Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE40AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FDC2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nt/YzJUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FDC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBlOe-0007Qc-Lj
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 16:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBlO0-00070v-5x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:54:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBlNy-0006Gb-PI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:54:11 -0400
Received: by mail-pf1-x443.google.com with SMTP id x143so1252050pfc.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=hMKTiRWmC8+fF/++QLGQDBcmYsOcbnbUBbMB8OfSekY=;
 b=Nt/YzJUwAPt97nDBk8KUPjg4l7kbUVpJSoFueBvP6amijtFrprzBNcFzlZ9dYAO6Ld
 yQaEOxXZZxpG5ylKMyUnmp0g09GCROAnJufuXVVgjZfbNaxh2gK2zNTB6BycntAeH8/M
 iUKaQsyDUFsUC/8tbiUKAyZZWCOMKIrlLoCfiBOU3gNVKTkUUera48v5tNeoQBkdFmmg
 zVzNGGam2QWSZBYjJkN9ZLe5HyULnZDYtjWW6ykv6O14z3asAfs6dWSZU/JqJ2y5OufM
 F/52ZP8Qx/AS4ThGbhHFsDF8aUYoD6XwVQ14c3dLCHYKZWMTthPLoTyq7KL+d8YjmoFv
 J7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hMKTiRWmC8+fF/++QLGQDBcmYsOcbnbUBbMB8OfSekY=;
 b=gfWt+aVK6EExMLr6blWaCMm0TNZDIFapjBQgKQxjUOO59NFoxJOTAL8pyZ05GaL6a7
 hupHs0uYNhGozcoNuQJ2xcOEvb/nHsE4VkYryJeXGuwZVpnLaDu3gyoj3D1eLdAz6EJ/
 uVpuHCV/Lix16HjhfhpZ3QORX/tqp7g8puSonlfS/gl9V6yi101ch9VSKyWKYOO1bNyY
 oO7HZhx/4zyDaBGqNIvKHa3mF+WPA4/sX9STZgYXW9FV8GvMp94oDyQMLySMPz7w/Xif
 lnXCWtfvgGP2sCveTxvyx4aLZ8XLAx8qk3tTn68KaPRqaVM2cacFI4VrkJdmSXGTnMNi
 wo+A==
X-Gm-Message-State: AOAM533H1IcA54mQBGBn5jvPXaz1evdBGdhpeseG1tcZLroYkoZfXQDm
 PYlW81iFVTmthmDUJYe+4Wr/UMceqeXWiA==
X-Google-Smtp-Source: ABdhPJz7aQVUzwspaq6+4JoYoGYpxhw+hz5PV+nbc1XOaw7MBsgVt2K2vJbSrGlbbHGVlALUUKanlQ==
X-Received: by 2002:a63:511a:: with SMTP id f26mr457275pgb.15.1598648049179;
 Fri, 28 Aug 2020 13:54:09 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y13sm315603pfr.142.2020.08.28.13.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 13:54:08 -0700 (PDT)
Subject: Re: [PATCH v2 30/45] target/arm: Implement fp16 for Neon VMLA, VMLS
 operations
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-31-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b17dd24-b45e-d7e5-9e59-d29aa954898e@linaro.org>
Date: Fri, 28 Aug 2020 13:54:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-31-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
> Convert the Neon floating-point VMLA and VMLS insns over to using a
> gvec helper, and use this to implement the fp16 case.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  6 +++++
>  target/arm/vec_helper.c         | 42 +++++++++++++++++++++++++++++++++
>  target/arm/translate-neon.c.inc | 33 ++------------------------
>  3 files changed, 50 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


