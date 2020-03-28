Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D60C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE5E206CC
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pghbGcmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE5E206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI2Hj-0003xC-8v
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 23:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jI2H4-0003F6-8O
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jI2H3-000604-47
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:36:42 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jI2H2-0005zR-UU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:36:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id b9so4227060pls.12
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uKI2J2kmXTKnljWu7KUTcOr+8EW8JlgRdnzNGpaw77E=;
 b=pghbGcmKrTJW16FKo5OlUOElj4OjjPCAHZvfrSGNlfVg7p07H7MQxN5IK2xgM6E0oP
 JceOX1zAOJjRFIOKzfaczjgBJfERdjq42EJPJJQBfNeKHA74WWK+562ZN2PU0q4yxROE
 +Lz+zPLkRlJesqJOyiQOOpeXRqHv24zq6IMU3DlQGNy9Ab0U27wFDxDZa5rAn9N/wxGP
 Fd8sV2zP/HaioItsmOgBZ59/2uPq9oNYaYsToUiDkk8z5dSP6+YKteKPjfAPv82U6Gc1
 HSV3PEG+f1YI1gehLaEqUXN83/mFGMvDKu6CJaEdL3XEAzNIe0MHLw8hvyOnKkDE2ELP
 xD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uKI2J2kmXTKnljWu7KUTcOr+8EW8JlgRdnzNGpaw77E=;
 b=bQN7Hcs7/qDe4lDAWGiRqx+9sTi4MQrf2neB7+6ly+fee5GKvaH5Z0xHqBhMIq/Ijj
 3FgYVF5VE+yPMxtW0Ia6QBxpvt1ub851d+EivODgdzY8s8Tr+OTOlVDVlemioTZ0GDcJ
 nAG0b3o1y7IuZAphkQGPqURwNHyvjp2g211DjSacUuMu2XJm/mUzXH86rvvkOxxFcL3D
 LWociQSe+3RaQGuydB+stwd7ktJDfkSOt6nbVIp0BDoPMVuhIAOE6vA0TjpcQy+N3u4/
 f0Zj/ysnLHwfYazLUBPAMWRFvzdOd6hSTU5SiibTT71ezg9RYN4XNJAmIJy0fmVKWfOw
 4D1A==
X-Gm-Message-State: ANhLgQ1HYbIVYJrHCA+4YOsshD72/0RBMpIDzW1Tu5D7qxsQrAwHKM6X
 EmQRm3G9936Qb7T+kdlvf8k5Zw==
X-Google-Smtp-Source: ADFU+vvKyUF24NKwtUCJb0e/3yn3Ei3h9C7Axudc8EL5MneM3UHJWKV9fqyxp+m7M7LclT+nRTN0+A==
X-Received: by 2002:a17:90a:cb0e:: with SMTP id
 z14mr2750126pjt.156.1585366599600; 
 Fri, 27 Mar 2020 20:36:39 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id b198sm2768647pga.71.2020.03.27.20.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 20:36:38 -0700 (PDT)
Subject: Re: [PATCH v6 55/61] target/riscv: integer extract instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-56-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07501722-9afa-0a47-bba5-434631335372@linaro.org>
Date: Fri, 27 Mar 2020 20:36:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-56-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> +/* Integer Extract Instruction */
> +static void extract_element(TCGv dest, TCGv_ptr base,
> +                            int ofs, int sew)
> +{
> +    switch (sew) {
> +    case MO_8:
> +        tcg_gen_ld8u_tl(dest, base, ofs);
> +        break;
> +    case MO_16:
> +        tcg_gen_ld16u_tl(dest, base, ofs);
> +        break;
> +    default:
> +        tcg_gen_ld32u_tl(dest, base, ofs);
> +        break;
> +#if TARGET_LONG_BITS == 64
> +    case MO_64:
> +        tcg_gen_ld_i64(dest, base, ofs);
> +        break;
> +#endif
> +    }
> +}

I just remembered that this doesn't handle HOST_WORDS_BIGENDIAN properly -- the
MO_64 case for TARGET_LONG_BITS == 32.

Because we computed the offset for MO_64, not MO_32, we need

    case MO_64:
        if (TARGET_LONG_BITS == 64) {
            tcg_gen_ld_i64(dest, base, ofs);
            break;
        }
#ifdef HOST_WORDS_BIGENDIAN
        ofs += 4;
#endif
        /* fall through */
    case MO_32:
        tcg_gen_ld32u_tl(dest, base, ofs);
        break;
    default:
        g_assert_not_reached();


r~

