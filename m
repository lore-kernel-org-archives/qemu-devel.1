Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D168C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D966D20829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npK8ma15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D966D20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Eoh-0005BD-6e
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 16:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Eo6-0004e6-FL
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:05:38 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:36694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Eo4-0000tw-PE
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:05:38 -0400
Received: by mail-pj1-x1030.google.com with SMTP id ha11so5572809pjb.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eykv5iZmiJgPYAteXK2dH9jalFi92HfAfSldGsFPEMA=;
 b=npK8ma15rXK9SFO1EgDUkIQZIqEx3GmCXGaK7wmGVIWxE7JNloGQPp9NGwH6AjoVam
 wT1heuMDhjgxdOYHwmb9NM4RTHH0nqifu8DeyBEOWfc2tTY9dLV+opilK1dTUJwTiPq9
 gaC9eE6Aay8v+r7AmG7JZ6K4lUZR+sTbS9/K0FNC3/IRN7/9UDkBVfnjFw3n4TOTJfE2
 J6jub7UhMsN5P1FZrfCAoYSgyfO7B93HWYoAOMrWa1LqZ81yRLc8bfTO+Y0wMAoq8TRp
 a/A4gIOtt0aFgL2oBhg8owUeeK9+c19q+W4cfzoVPrIPWPNT2QeJD4UQoTBcSBjXZAVZ
 Z5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eykv5iZmiJgPYAteXK2dH9jalFi92HfAfSldGsFPEMA=;
 b=ugNG9Y1di/T5CVvvQC/N05lmT+AsPTFLdvSnNiIFHja/qQEw9kvE7hm5O3DilYOrTp
 AekVRc0gMiXKMwnOLMpMKbBHbsi6gyNr/1J9RqQ2Vh0Z1RVo3BlQbWc1aSv5koAXvrPX
 a2CFYoIGP6rfLayMjsmRS/8x4uGRraX1mJco77Y5NjJFcyvwuvapLx+vHS9Dra16+E+U
 Gr8XS3SfttacixBfGKHZHceuoUhCDc4P6RtyZ3sUopVUgCL6ZJcMpfC36Ry6k22ihz3J
 eYeo1US8BeDkf59qFh3Yt/WmqMl7Dmz41ayaznE7Gs+dTFqhEdzE2bgGTgD8OsdJjK5m
 Hvhg==
X-Gm-Message-State: AOAM532ZmbJaSEkqEnugBYTjKckKkXSqOyXZvB/HL0m/dShSk4ia0dLO
 4jZzhREC9TF/ePWl/N2fHUj9Kg==
X-Google-Smtp-Source: ABdhPJynFOBIxWhgKwOmhUQdW/plUEF9Md/wgFzx01VZ4bvJOjoRaXHyXYFDnS/kKrnSRbGw+dURTQ==
X-Received: by 2002:a17:902:44c:: with SMTP id 70mr687841ple.293.1596139535543; 
 Thu, 30 Jul 2020 13:05:35 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w9sm6525729pja.39.2020.07.30.13.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 13:05:34 -0700 (PDT)
Subject: Re: [RFC v2 40/76] target/riscv: rvv-0.9: floating-point move
 instruction
From: Richard Henderson <richard.henderson@linaro.org>
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-41-frank.chang@sifive.com>
 <45dc44af-55d4-5254-4476-75b35e249d2c@linaro.org>
Message-ID: <ba4576c6-112d-f36a-aa6c-df8cb4886998@linaro.org>
Date: Thu, 30 Jul 2020 13:05:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <45dc44af-55d4-5254-4476-75b35e249d2c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/30/20 12:57 PM, Richard Henderson wrote:
> On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
>> +                (s->sew < MO_32)) {
>> +                /* SEW < FLEN */
>> +                TCGv_i64 t1 = tcg_temp_new_i64();
>> +                TCGv_i32 sew = tcg_const_i32(1 << (s->sew + 3));
>> +                gen_helper_narrower_nanbox_fpr(t1, cpu_fpr[a->rs1],
>> +                                               sew, cpu_env);
> 
> Also, while there is currently one function, gen_nanbox_s, you'll want to add
> gen_nanbox_h to match.

Oops, I forgot which way your helper worked.
The correct function is gen_check_nanbox_s.


r~

