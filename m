Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66561C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60AF208B8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tacSmC5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60AF208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUecj-00053s-Vi
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUeYm-0003Ix-Ql
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:27:24 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUeYk-00019i-Ho
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:27:24 -0400
Received: by mail-pg1-x541.google.com with SMTP id j7so926145pgk.5
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I092C3thHU0Dt4M3lwY7S4zpzAxG9EpfDsRM7GWUPtM=;
 b=tacSmC5dzXxmyc2g9AgjLn96ku4bSSYh3BMZAm564L3gtSRwQHygtPdZ1Uh6Q+ve0f
 0GjT+IQY02NfIUWiMRbDPoQYGQoAHxYKLuIH+meyyjBk6jlZi/QINmre7P24uh8WIW8I
 xG26uiwqsDGh+Ejnf/TGBPHwIVaEsauHDwWqRhXQs9mczmve9YA5dPkp2/YLB3rYTdQI
 dMsfuOWprYi9SvqutTtDgrWECMDyDJQOzR4/UWYP5HMVRIxr8O0c3AL13qiiwuPhEhY1
 CB2WRS5RMv4Fao7R6Y3KipD3c23lUDcFALM0uJ/MNDcfgIDbHVFFIqyhzKLvFJlSSRmq
 6/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I092C3thHU0Dt4M3lwY7S4zpzAxG9EpfDsRM7GWUPtM=;
 b=KgaoplDkYf9m7qzQm1UnbTCZZ0BDUW6Qb+goETi1TBySs3w4aPQuj0yc3iZkLjnJjR
 WKfQ7HGa7hwx8/LaWkaJ1LqFHgRw1g5TXanX5LiL0K4RLyWhyoa1TMBmchMyNl88Ku7R
 LTN6iYO7gnyKq89yjUKIbmanImvQazmXswaATamITNGHkZI+nzSq9MGFKhTcEcUJ/zMZ
 xTCSyKE1Ge4aKAPuvucaKbxNUrZ1yrqYM14xuJQ/oX/KSd9/vu4tCNC+oQMzlM7GhuZX
 Zc5nSgmJ+TWbiyyoZvAvVhQQJnM/SfyHg//z6a73suko0Gl0Y79ZEhIS1S00Dc2nKA3e
 Fl8w==
X-Gm-Message-State: AOAM532XFZMghec20IPRIf/PM5cRm/tx+FGgSVuw4TJ1p0C23cM/pEvI
 Raldx4lZmC1GCeZ4Ino6q58NtQ==
X-Google-Smtp-Source: ABdhPJww2pIc7IhzFQRTy9oRuTPvS918ESCnkwcnLi0u4wDOaaF3BtwBIUlYy0z3/MZY5AQPRBhU7Q==
X-Received: by 2002:a63:44d:: with SMTP id 74mr208502pge.374.1603150041038;
 Mon, 19 Oct 2020 16:27:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m11sm66219pfa.69.2020.10.19.16.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 16:27:20 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] tcg: add const hints for code pointers
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-6-j@getutm.app>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11912dd5-2740-1d7c-c691-1174fa7ef390@linaro.org>
Date: Mon, 19 Oct 2020 16:27:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019013928.72770-6-j@getutm.app>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "open list:S390 TCG target" <qemu-s390x@nongnu.org>,
 "open list:AArch64 TCG target" <qemu-arm@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Huacai Chen <chenhc@lemote.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/20 6:39 PM, Joelle van Dyne wrote:
> From: osy <osy86@users.noreply.github.com>
> 
> We will introduce mirror mapping for JIT segment with separate RX and RW
> access. Adding 'const' hints will make it easier to identify read-only
> accesses and allow us to easier catch bugs at compile time in the future.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  include/tcg/tcg.h            |  8 ++++----
>  tcg/tcg.c                    |  4 ++--
>  tcg/aarch64/tcg-target.c.inc | 19 +++++++++++--------
>  tcg/arm/tcg-target.c.inc     | 12 +++++++-----
>  tcg/i386/tcg-target.c.inc    | 10 +++++-----
>  tcg/mips/tcg-target.c.inc    | 33 +++++++++++++++++++--------------
>  tcg/ppc/tcg-target.c.inc     | 21 +++++++++++++--------
>  tcg/riscv/tcg-target.c.inc   | 11 ++++++-----
>  tcg/s390/tcg-target.c.inc    |  9 +++++----
>  tcg/sparc/tcg-target.c.inc   | 10 +++++-----
>  tcg/tcg-ldst.c.inc           |  2 +-
>  tcg/tci/tcg-target.c.inc     |  2 +-
>  12 files changed, 79 insertions(+), 62 deletions(-)

tcg/ppc/tcg-target.c.inc:2349:26: error: assignment discards ‘const’ qualifier
from pointer target type [-Werror]
     s->code_gen_epilogue = tb_ret_addr = s->code_ptr;

How many of the targets did you build?


r~

