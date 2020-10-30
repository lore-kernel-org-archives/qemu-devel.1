Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1D0C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FDE2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToEUVQ5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FDE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYZZm-000298-Sd
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZZ9-0001P0-LZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:55:59 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZZ7-0002lq-Nx
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:55:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id z24so5999710pgk.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n5WsTISRTCQIvpp4LSM8XKauaw2iY7A6sH8JLSVOCgw=;
 b=ToEUVQ5dxeYZwp1pDiybfaLNVLavjPASlBeyqe6e+sGnlaQ75Bb6878y9qZ2WWpgRK
 DZHG+VnG6dM22ocxm6TBMcJks4U0oRcvbfiH8Xze4xCHjBdqLNGiX5WAXAnkN1xnppnX
 geUfmMg+bmmYWycAdPV2IVLkEYThCmb7WHTCVP/r9BEVzNaIiNGUN5Y+5+f6rRQdmx2c
 MWPR2FW9ZT/tmgNhvhVyzaQvYn+zvKP3J6ph82pIJsIBKwVf6hGXzGKsxC4UtjSZq9Rw
 Xr+VZF8S8fqE2+gFPW3bwXiws1OOH6gHmaT9P05mD9UspnZX53VaVgLs8hagQQPM2pPa
 whKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n5WsTISRTCQIvpp4LSM8XKauaw2iY7A6sH8JLSVOCgw=;
 b=hb+9VHRLIaGbjG9gJV1PNKHCQsLNqUKYJIJ4MzLWIRhPdaO22oYQdcSfazo5HRw9WO
 pNbKRKuEWjrGHLkGIIq0sMMoOW6z61uz87K6PHaVyihWNdq5xyPv/RM5j3vo5S1FJ7D5
 I9Hwq5biTLC2kU2RkcGdY8N7YXf90Exnkiug8Z1w/snFjVKuMm+qgYlE40U9zN3tJZfj
 Lpk9Ns7Qd/lc1681tX2xJXBFJbXD6EbAVW1Y4mlJ1JzcrL6N6AVrwMA3GZtRubqdsmJV
 mpetJYCbE9B91LomvHkbyTGhfXQmhIxH/xLhQVnkv0OThA8KixE53QwIyChXwoTbYNuK
 kGag==
X-Gm-Message-State: AOAM532i772RtxvoNoDjycr40YaCrVNzPJMZCZpMPPqy1cOjZmF61Tix
 LATdXJjbQS3fcPL/K7Y/+CujTIeuMQ6KOw==
X-Google-Smtp-Source: ABdhPJyhZ+AklIskFvMNhQOcWiI+GfiHB52q1QmBOMNI0cpJpXlKPWXk7UQKc0XcxGnQhOjNemDWPA==
X-Received: by 2002:a63:140b:: with SMTP id u11mr1852956pgl.248.1604084156108; 
 Fri, 30 Oct 2020 11:55:56 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t10sm4244148pjr.37.2020.10.30.11.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 11:55:54 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/boot: fix SVE for EL3 direct kernel boot
To: remi@remlab.net, qemu-arm@nongnu.org
References: <20201030151541.11976-1-remi@remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e6066544-a259-9739-3acd-2d9abc2d7455@linaro.org>
Date: Fri, 30 Oct 2020 11:55:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030151541.11976-1-remi@remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 8:15 AM, remi@remlab.net wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> When booting a CPU with EL3 using the -kernel flag, set up CPTR_EL3 so
> that SVE will not trap to EL3.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  hw/arm/boot.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

