Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66124C433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C0B207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSr4x+5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C0B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyIaX-0000w2-GC
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyIZv-0000TV-KV
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:30:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:39514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyIZs-0007BF-Ti
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:30:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id b9so1338741plx.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H+N05Q6iH/7kKItLonUDpGJYS7Eiq7WvbdCHpHhINzs=;
 b=JSr4x+5m1U/ypd5X5CUc6NSr1MfYj89Uzf0NXzVpqOjtVEiSPvNpAUHW3NHuY7zE1Q
 d6+gRXti4Rhs4cZIRLZsWIxIZoLMvc8lSWFezZbisJ4IGHn5dRLGEGCPXNu7QK89LQuB
 Bu7K/6rqZz3FLTJ/aMFhBuZt17R+K2U5NwQ/6xt8T2p70FBmmN0NA0DSN4QpklTe+pfF
 1Cs9FSK3tI4NaK6H4WZisZ0MxejwJ32Zdgy8LOqH5kq0AGgATEt+uFuYSZTXy+SKE79B
 n4qUcWyeUX4edsjbYxw2JgD6Th28fypIQ056ojw5jKSoP4sKwyQcuaMUBBQwVJAdufS+
 Vuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H+N05Q6iH/7kKItLonUDpGJYS7Eiq7WvbdCHpHhINzs=;
 b=QZILDMPGOxVHKThnNZ62sggTP+WuVY6HcnzDKE0sZxiQ8rVatV9TTbG4H0+EpucRUt
 hHFQjH44MPi7qfl+6IjXyyqObOG5uzRib+//oUZ7LkyUm0zvryhtUOjknHiappGm4sTT
 4DvNYjHFQhx4No6ZswqVr1dasdsNcERy7LdQd88nYGocEFEsBwbiVeoiB7G7e8St2Xx3
 Hn4L06qFdrDhYsjTDFqALeea3fvGx86+XirQjQsA0NuDY/BWdUd2LG3WIj5Q6MEdXqb9
 eOBJuCAITUS8matObDB+oKLXJ96IubGfthNAV0h+ArnaZr42heGO55NgXcEpH7hIvZaI
 8Ysw==
X-Gm-Message-State: AOAM533X6J9vzea5QX+xObfj8LpgOlopuLaGhsIWJwIZik6vudXxBUr1
 cP4FCl+GKpO5yPxArtEZseKSEg==
X-Google-Smtp-Source: ABdhPJyl35v5cBnVhifA7huu1ZKUDPTw+l5gMyelsaBINkonjrsFJ3yV5vcaiJyRzFAhY5npSAx8hw==
X-Received: by 2002:a17:90b:338d:: with SMTP id
 ke13mr470419pjb.60.1595439047284; 
 Wed, 22 Jul 2020 10:30:47 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 x10sm211365pfp.80.2020.07.22.10.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 10:30:46 -0700 (PDT)
Subject: Re: [RFC v2 15/76] target/riscv: rvv-0.9: add fractional LMUL
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-16-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d0d9b56e-5d8a-83c9-59b0-88b842380487@linaro.org>
Date: Wed, 22 Jul 2020 10:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-16-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
>  FIELD(VTYPE, VLMUL, 0, 2)
>  FIELD(VTYPE, VSEW, 2, 3)
> -FIELD(VTYPE, VEDIV, 5, 2)
> -FIELD(VTYPE, RESERVED, 7, sizeof(target_ulong) * 8 - 9)
> +FIELD(VTYPE, VFLMUL, 5, 1)
> +FIELD(VTYPE, VEDIV, 8, 9)
> +FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
>  FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 1, 1)

The ediv definition is wrong -- should be 8, 2.


> @@ -37,4 +38,10 @@ target_ulong fclass_d(uint64_t frs1);
>  #define SEW32 2
>  #define SEW64 3
>  
> +/* table to convert fractional LMUL value */
> +static const float flmul_table[8] = {
> +    1, 2, 4, 8,      /* LMUL */
> +    -1,              /* reserved */
> +    0.125, 0.25, 0.5 /* fractional LMUL */
> +};
>  #endif

Don't define data in a header file; only declare it.

> @@ -60,6 +60,9 @@ typedef struct DisasContext {
>      /* vector extension */
>      bool vill;
>      uint8_t lmul;
> +    float flmul;
> +    uint8_t eew;
> +    float emul;

Why are you adding floating-point values to DisasContext?

> +static inline float vext_vflmul(uint32_t desc)
> +{
> +    uint32_t lmul = FIELD_EX32(simd_data(desc), VDATA, LMUL);
> +    return flmul_table[lmul];
>  }

And in the helpers?  Are you planning on some sort of path through int -> float
-> int for computation?  That seems questionable.


r~

