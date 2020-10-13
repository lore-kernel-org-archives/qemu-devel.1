Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F78AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D176620BED
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HL4CNVkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D176620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSQZg-0004Gi-NP
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSQZ5-0003kS-4p
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:06:31 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSQZ3-0005LC-Cu
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:06:30 -0400
Received: by mail-pj1-x1041.google.com with SMTP id h4so45364pjk.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=tFP9/oVxNxD5L14FkZIvJ7f+2CkBXItmIACKqHNyNWg=;
 b=HL4CNVkhB0SywKAJa4egrbGm0lPJMAJ1hXM2gF7ltcHuCcNgCvbSa8RvJJEAWS20UJ
 ItpWlqccdQFtwW59nIwHkTcyf5JEb9wP/QrSiOJ7q+AqGl+vlmTXaic6ClE3ZH9tmOL1
 eDRpH/2w2pX1xNCLuBmwbGeONqSS6Xmd5YOTZ++WrVKyF+i+XZwHJZTAc3yX0EQPfIbF
 xbAxTFir3AKRnFbsqIvi/YahTjLSMAdokimU+496FX8yVocJyByKVnkXIyQUJ84JHSnS
 p26G7ywLQpWS5S5owHNFa2LGqzT4nGuj/E/PazDhFeb2tgWdz8/4+3S5wm7h4btMykGm
 meeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tFP9/oVxNxD5L14FkZIvJ7f+2CkBXItmIACKqHNyNWg=;
 b=irvJizcrf8gMcQ7Q7JITT6nziLHjCoqA/+EKddUE6cF4vRYsMzw5jWrt+WUjlrH5AV
 1x+ElaikFl9RBYCRnl4nY2CpG1HiVNCL7CQTwy9u0VwKWM98o5Q5l29AaMP7IHq1yl7W
 m9SwnZeTzv5nCS8v5gANmdLm5UEpRt01q/I8R/1P8NapYi0drBDxnzP75+vjpXRRa+NQ
 oHPOZdd1+JvbZSDVC2pugKPCzGoze+GYbzdP6PJkVEiRErvUS1SYMzMD0alJ1mqzagQk
 uksX7nKMKQXyizuVBFhPgfmTVRRfIjFtzaPIBIPoZC5lg/NmhRtsPQFVc9NyKexaK6NS
 JN8g==
X-Gm-Message-State: AOAM5306a7pybRMsmhq+GBKEhEenjR9OTBZqgYgOYXbvlhdegaheb+k6
 NAi3BMeibWWli8p8Dn+c+LbWJCk8H/2x+g==
X-Google-Smtp-Source: ABdhPJwH4rzSmUvLL5ok3LTUsW+pLdc6njyXO+k8UyIBPx+a6GgR72uPFtF87Lusl5fSIPAoMQ2Zpg==
X-Received: by 2002:a17:90a:dc07:: with SMTP id i7mr25101pjv.111.1602619587570; 
 Tue, 13 Oct 2020 13:06:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z20sm515191pfn.39.2020.10.13.13.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 13:06:26 -0700 (PDT)
Subject: Re: [PATCH 09/10] target/arm: Implement FPSCR.LTPSIZE for M-profile
 LOB extension
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dbba485a-b69e-9138-5db4-d146ceec3c3a@linaro.org>
Date: Tue, 13 Oct 2020 13:06:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012153746.9996-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 8:37 AM, Peter Maydell wrote:
> @@ -198,8 +200,14 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>          /*
>           * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
>           * and also for the trapped-exception-handling bits IxE.
> +         * From v8.1M with the low-overhead-loop extension bits
> +         * [18:16] are used for LTPSIZE and (since we don't implement
> +         * MVE) always read as 4 and ignore writes.
>           */
>          val &= 0xf7c0009f;
> +        if (cpu_isar_feature(aa32_lob, cpu)) {
> +            val |= 4 << 16;
> +        }
>      }
>  
>      vfp_set_fpscr_to_host(env, val);
> @@ -212,9 +220,18 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>       * (which are stored in fp_status), and the other RES0 bits
>       * in between, then we clear all of the low 16 bits.
>       */
> -    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
> -    env->vfp.vec_len = (val >> 16) & 7;
> -    env->vfp.vec_stride = (val >> 20) & 3;
> +    if (cpu_isar_feature(aa32_lob, cpu)) {
> +        /*
> +         * M-profile low-overhead-loop extension: [18:16] are LTPSIZE
> +         * and we keep them in vfp.xregs[].
> +         */
> +        env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7cf0000;
> +    } else {
> +        /* Those bits might be the old-style short vector length/stride */
> +        env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
> +        env->vfp.vec_len = (val >> 16) & 7;
> +        env->vfp.vec_stride = (val >> 20) & 3;
> +    }

I think these two sets of masking are confusing.
Perhaps usefully rearranged as

    if (!fp16) {
        val &= ~fz16;
    }
    vfp_set_fpscr_to_host(env, val);

    if (!m-profile) {
        vec_len = extract32(val, 16, 3);
        vec_stride = extract32(val, 20, 2);
    }
    val &= 0xf7c80000;
    if (lob) {
        val |= 4 << 16;
    }
    fpscr = val;

Which then obviates the next patch.


r~

