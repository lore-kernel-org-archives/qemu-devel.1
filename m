Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E37AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8AF20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYorpeGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8AF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Fhr-0001kl-7G
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 17:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Fh7-0001FN-Lu
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:02:29 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:35941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Fh5-0000YR-4E
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:02:29 -0400
Received: by mail-pj1-x102a.google.com with SMTP id ha11so5702776pjb.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 14:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5Ycd4hMHAF13+V2uRqeO1a9ARPRIJzDKulk0mG2Bz9I=;
 b=WYorpeGvBYz0DJ5vrR425i9gV3kamma1ds5E63bDoXXctUdtEGiqD247mAzvF3rqB3
 Uid5SppJU0aLSjmhb/F9P1pluv+7vJXmlSTXIUNnU0oHTLrOcpO/BDBKVZMqMjJqSF+9
 37eVh4pcvUTQEQco5AsntgcNSjGXW6DyODp7PnVrQv980WdDTMmaaL4HS8wN8UhNKE8m
 Fil3WHjmtaUpSmkxlT29EU064rWX7H5bg2G/u6xWgALBZBQdY+Oi1fW2R3eOmPtiCA/0
 SkYUAxN+SbNnjyLlUUy1cAekTuV64OkrnvflJIQY3xcHkWQfRVrefFfvhAMzsXD+Gwf/
 4bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Ycd4hMHAF13+V2uRqeO1a9ARPRIJzDKulk0mG2Bz9I=;
 b=pu2y21lWcogHPZvijhvmQ4WNLeD25utRm4hgKQe5SgJnZ0Gr18jlWFFzEWWGVgRHCZ
 FN0Rvfgbg5A2cUuaHUfyGLt2RE8dP24eXF6fdifJDHzsBql3z6ppOx+Ay8qxD6yn1VNy
 fxaXVhr+hmBK6+TGOyThyRsbjR0drJuzj5zxVVdpHGB6j5b8jKA+bqARgIab47wr74jK
 ZkgGxCFATowsh9Gb5wN4YkIlXjp5KaJEOtRL75cnyos/cKJQHUbnSF96pd0Vw4/aX53J
 99RqjcqwhSqgMEQ3VUjM0CJoY3j50Fw+XugKD3wloj7qM0nuWR6Yedf7BGsM41QTWq+y
 RVCg==
X-Gm-Message-State: AOAM530PqV3Bans41pInI0HkoKTIyLWVbepyfqhAs49M6TAUQycgpq5L
 uqxSccG2te+2Lb+ZoAu9DJYEeg==
X-Google-Smtp-Source: ABdhPJz7/+JKc3TB2Q/qQb1CXQhleEooIXgWa7udF82Kp4OvUFA5qgGNW3HOjVhbL1G1TaqZY/Pg/w==
X-Received: by 2002:a17:90a:8d0b:: with SMTP id
 c11mr970853pjo.196.1596142945352; 
 Thu, 30 Jul 2020 14:02:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s68sm6584196pfb.103.2020.07.30.14.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 14:02:24 -0700 (PDT)
Subject: Re: [RFC v2 47/76] target/riscv: rvv-0.9: narrowing integer right
 shift instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-48-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <556f1864-b96e-8137-a423-b25aa9a6fa02@linaro.org>
Date: Thu, 30 Jul 2020 14:02:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-48-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/helper.h                   | 24 ++++++++++----------
>  target/riscv/insn32.decode              | 12 +++++-----
>  target/riscv/insn_trans/trans_rvv.inc.c | 30 ++++++++++++-------------
>  target/riscv/vector_helper.c            | 24 ++++++++++----------
>  4 files changed, 45 insertions(+), 45 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

