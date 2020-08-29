Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2E9C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B334720707
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZd2Aa9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B334720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC39c-0004ld-UD
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC395-0004IT-2k
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:51:59 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:37816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC392-0001JT-1f
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:51:58 -0400
Received: by mail-pg1-x52f.google.com with SMTP id 5so1922811pgl.4
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EfTB96CZG/YyqZ04HiL+zf3EWviG8+PcrFr9rhhJ3+g=;
 b=tZd2Aa9OanyF+tZ9bS/QStgBlqyqD7oQzzunqJ9Dzdm76Siy3/lwEzv+jt9EmlrWoF
 ZDWJuup0KOPMVL4lQnNdUA5yihR+0EhhV9vwqV/f8yf/Sym4L4n0mVv7rQH9AJeqCR9e
 XXxHi25BB4/nkhwagThV1Ct6hRO+sfRkK4ZYKRKe/0qloqkwYe9xx/IPYhKMbYqOkqKf
 fAKkkDHWbd2n8aPuBNSGgvzR3YGlGIaxlVcfQNBpGgqqRvdi7gLJF+86K/VMYAej6Hvv
 ASUldnkyqbiq8sv6+XOzBJUhqvz5A26/mx6512+BIr2B0LSLDoj96K+LAMsmldUQTJMZ
 TGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EfTB96CZG/YyqZ04HiL+zf3EWviG8+PcrFr9rhhJ3+g=;
 b=eMmczH4pE56vmHxSXUOA5Dns15XQnGKN5vNrFg8A9fkuFf8hn3MLayqEfKaScvpH7b
 zZjonHf+ehAoC/G2NnisLTCW+Lxl3ix7C0Vrfuak4ZEWoYpIscN2StwDfuSKXRKcbVoI
 TVy3Th3zCsM+5UVrT4+6alpUZbFGww8+ZFfe2DNb1uII5DdnCM6laZpriPj9P+CGEgqH
 yZm2BJUTjd2M5RDNi30pcvyS79K7fQSvoosy9QO5iy6KqrgMtcSp6lPOHJmo4zBXf81P
 0l2vv5v4TYsDFl1KcQK7I675X4Zjj4DeGvPdCifI8XQD7EkVJjkhOSBoKhP4WJ9tcgYo
 ZBIQ==
X-Gm-Message-State: AOAM532RlYfROQX4hcCdNEwYnORMcR9SAtELsMz9cokw/oyamaeea1HG
 03v2OqViXbWVLxXyiu1B3B/dPA==
X-Google-Smtp-Source: ABdhPJystVzGPe7UkTyMpuKtIbs/ab4tJRg+Iq070fBBIA6TZd9kAjV6cmt1O0KeqtVglQPX9f2j+Q==
X-Received: by 2002:a63:5d4a:: with SMTP id o10mr2683171pgm.200.1598716314537; 
 Sat, 29 Aug 2020 08:51:54 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a1sm3166319pfd.65.2020.08.29.08.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:51:53 -0700 (PDT)
Subject: Re: [RFC v4 12/70] target/riscv: rvv-1.0: add fractional LMUL
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-13-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f4cffc7-86dc-92c9-ff61-c3ae1144ecc5@linaro.org>
Date: Sat, 29 Aug 2020 08:51:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-13-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:48 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Introduce the concepts of fractional LMUL for RVV 1.0.
> In RVV 1.0, LMUL bits are contiguous in vtype register.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu.h           | 15 ++++++++-------
>  target/riscv/translate.c     | 16 ++++++++++++++--
>  target/riscv/vector_helper.c | 16 ++++++++++++++--
>  3 files changed, 36 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


