Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C10AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA2B208D5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWLr9tET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA2B208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jllou-0004CK-6W
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlloF-0003fr-Ky
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:05:51 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlloD-0007d5-Vz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:05:51 -0400
Received: by mail-pl1-x641.google.com with SMTP id y18so1891594plr.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HaZkqTflqaHG2kuLncCEt0A6vuNetouWADqfgCeHnw4=;
 b=gWLr9tETcaIWEx2v+3DfxIYp3dKz+yVW5H/hLkjSpWA1lT2gWsjXHWpqzIi9MUbYtW
 BV8pgbNCEvNYIQVPXD6IERT3myMxEx0cngrIGU3AtEBUaUrEuUEvtTjD0aE6pn0yoiWE
 WpGI1TM/iatFeASyiFRh5tGd9f/ZLDaC5Q7uRkTQSkwBGuCgfq5JgTP2+VlOkKAZIU3r
 9W6YVqfJOIrJ7FD9bx7ibvDXpp6w4M3yy08dwd7ndnvrJKDMAz8BPTUHm2tdlCl2bTeh
 GKkU9sgKZkTjaB57q2w0fUYNe6NVj9QYYSYe8z/FhcjzS6bb48onpsqos1AXltwuxlS6
 YGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HaZkqTflqaHG2kuLncCEt0A6vuNetouWADqfgCeHnw4=;
 b=UyAsD9jZZvh4kLL6X7fEKJPRRDLV8yDX7I3/vgzPAvc/LJoI3gMyspm3Tq8c4B0P1r
 Qb0qWJhhKW41QCuFc6bXjCA9ZEhGQwPfQeceK1JVJA531OyhIg08EoqqzSU6Mlb0RKyj
 rqQkjvmWN7Ed/tJRaSSlD8pNYp1KvFFNjm1uMHDA3QvO9XbOLQZqpoC0bLNNiq9QBO/F
 N0dAhBbM6sYETKGQDlUiAyL9UoKUu7+EiAEaV694EkDxtG/8xQ/sIsh8QhyWHD/j1FbX
 pRfsOqwHIH54BIFiZ93+eHI825eDvr4QVF/AN1ngi6n87oZofOIrJSTYU/UIhqg9hQXf
 8xQQ==
X-Gm-Message-State: AOAM533cGV2YeLrabtJDfjdTU3HYaSn+ZdIRZ2DvsZNrBUOGR21JkjWv
 L1wKCA4NbNAxgFCmEWSLd6k6VA==
X-Google-Smtp-Source: ABdhPJz3Seif6V4+sdqtKwZtCBw50bmRa/UtRfvp5oHxxUOXaZd9cofCzzOKM9nUArNjx9DlCRiyPw==
X-Received: by 2002:a17:902:a60d:: with SMTP id
 u13mr2177730plq.46.1592453148251; 
 Wed, 17 Jun 2020 21:05:48 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n19sm165562pgb.0.2020.06.17.21.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 21:05:47 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Implement SVE2 fp multiply-add long
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200504171240.11220-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <76ea3eb3-4139-0268-9e5d-ccd4ee6deb1d@linaro.org>
Date: Wed, 17 Jun 2020 21:05:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200504171240.11220-1-steplong@quicinc.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 10:12 AM, Stephen Long wrote:
> +void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
> +                               void *status, uint32_t desc)
> +{
> +    intptr_t i, opr_sz = simd_oprsz(desc);
> +    intptr_t sel1 = simd_data(desc) * sizeof(float16);
> +    for (i = 0; i < opr_sz; i += sizeof(float32)) {
> +        float16 nn_16 = *(float16 *)(vn + H1_2(i + sel1));
> +        float16 mm_16 = *(float16 *)(vm + H1_2(i + sel1));
> +
> +        float32 nn = float16_to_float32(nn_16, true, status);
> +        float32 mm = float16_to_float32(mm_16, true, status);
> +        float32 aa = *(float32 *)(va + H1_4(i));
> +        *(float32 *)(vd + H1_4(i)) = float32_muladd(nn, mm, aa, 0, status);
> +    }
> +}

This isn't quite right.  The float16 to float32 conversion cannot raise any
exceptions -- this is an exact operation.

We already have an implementation of this function in vec_helper.c --
float16_to_float32_by_bits, used by the AdvSIMD version of this same operation.

I've rearranged the helpers to match AdvSIMD, and queued the patch.


r~

