Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD6C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E9E222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNR91pvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E9E222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZTk-0003Yb-0C
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDZ7Q-0001H9-Vo
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDZ7P-0004ng-GP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:08:00 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDZ7P-0004n4-A4
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:07:59 -0400
Received: by mail-pl1-x644.google.com with SMTP id s17so36853plp.6
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zKpl9jWF7yohhRW+KbqxUCibNvl2Z53+iZCD5XEizI4=;
 b=uNR91pvRCwcuiYNvBUqwh1PcxVPhBjuOKSe810lMdYb2XbCeTmwkyx/p+ZjPCtt1aC
 6Mq1TsQg5lh8Gua+uzY0KxJDwmhDpMMryajQjbGzqtCDthpWZ5XP/EpKJD3ZaojeS2iF
 uyDvbVcX16t+F2mloHDGFxkojM54XYObUJoZJLbWRtEUDagkbDTNrlTbtlV3ZTwe93cY
 f9DXoyJC+/QeT2SG5v7CTSi9iT2wMm6vCzYLjHb9jO97C8AEHfo435/dT8cdu/RaL7WH
 pPVEUB1VSLSYuvHITmhEGrfSbA6dxOR3LZ6VlBXd620gSt8WnZvn3w4TMZWHzqIei8YH
 43Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zKpl9jWF7yohhRW+KbqxUCibNvl2Z53+iZCD5XEizI4=;
 b=iV/rOts02kRrAXyBqTFja6O3aXsHNoBW5lrReH8yYwRE6+5MtWyJ2aiBTSIw/ZyfqC
 eCTYf3AeFrXEf5iwxTld3fh8/omg7KUod290EsOec8Z5BfM8AdBtzK49xEBWNqPuM/My
 NqhlLIW0MB5RvjKy24JYsZQdAiZoCDuRa8i5TteD1ewD7CeLqNK2yyfM1L9FuAApvYBL
 mKbtmDLXperyFv4KyT0sN8C5Q9VSYs+t2zMChhfJcsFgznoRYpy1bFKBDbqGNuthe0J0
 RXxJv84LIXuulqfyF7vpiaYcpiBfVO/LvYqkSVj1cUTFzeNTgybId3wWftRvVMixzaGT
 HNvQ==
X-Gm-Message-State: APjAAAXJKuGwBzuA6EtMWUph8c46yYpgNevOtHkscv4NljnEr13oOBGU
 /N8rCZr1Mr8/fNTrdJzp0N1DpA==
X-Google-Smtp-Source: APXvYqyEk2ODKjE97AqcrtWyw1yTImZvr7bM880/6S5IYEVIGFe0vAtOutG4wNaG89eGEDmwOTqVbg==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr109642plm.31.1569524878184; 
 Thu, 26 Sep 2019 12:07:58 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id e10sm34997pfh.77.2019.09.26.12.07.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Sep 2019 12:07:56 -0700 (PDT)
Subject: Re: [PATCH v4 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190924113105.19076-1-drjones@redhat.com>
 <20190924113105.19076-5-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2beb840f-99cf-d928-0926-c284933c78d9@linaro.org>
Date: Thu, 26 Sep 2019 12:07:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924113105.19076-5-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 4:31 AM, Andrew Jones wrote:
> +static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
> +{
> +    uint32_t start_vq = (start_len & 0xf) + 1;
> +
> +    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
> +}
> +
>  /*
>   * Given that SVE is enabled, return the vector length for EL.
>   */
> @@ -5360,13 +5367,13 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
>      uint32_t zcr_len = cpu->sve_max_vq - 1;
>  
>      if (el <= 1) {
> -        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
> +        zcr_len = sve_zcr_get_valid_len(cpu, env->vfp.zcr_el[1]);
>      }
>      if (el <= 2 && arm_feature(env, ARM_FEATURE_EL2)) {
> -        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
> +        zcr_len = sve_zcr_get_valid_len(cpu, env->vfp.zcr_el[2]);
>      }
>      if (arm_feature(env, ARM_FEATURE_EL3)) {
> -        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
> +        zcr_len = sve_zcr_get_valid_len(cpu, env->vfp.zcr_el[3]);

This has lost the MIN relation between these 3 registers.
One possible solution is to keep these 3 if statements as-is,
but make one call

    zcr_len = arm_cpu_vq_map_next_smaller(cpu, zcr_len);

at the end.

> +#if __SIZEOF_LONG__ == 8
> +#define BIT(n) (1UL << (n))
> +#else
> +#define BIT(n) (1ULL << (n))
> +#endif

There's no reason not to always use 1ULL is there?


r~

