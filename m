Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDE720897
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYRvyv4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDE720897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnxz-00022j-HV
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnwx-0001QC-KN
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:38:27 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:47001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnww-0007xF-01
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:38:27 -0400
Received: by mail-pl1-x644.google.com with SMTP id k13so352074plk.13
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=SwniNxok37/LYegTpNsKUZatfoKXxfsEbk4JpSC6o1M=;
 b=bYRvyv4jMwTzC1k68TOzPDXdwe9ft64TlY6F/5czbnRrCiKeXdTiZoK71IoRnePCwI
 E8VTzblGQv/lvA6CHjtXWTy9P36suxcRqhy/D6eENo+TKNzY3kslMueLzsXVLGJPQZo2
 DrdYXCkIY+4TJFsUFG6XeGqjFXqTIps01L64MqgWu7TPt3U/tn3fi0WI45EUbWryjATS
 1pSWP5CN/Fsh3u3sfJ+LpMBsHrtyEnnFk14+/REpnBTYVKCPnjd4GKa+rZTk9CnoDUX/
 LPz/G6DHoaPRjSnE7IpVYxODwYFkcQC+4evp7/E1ls8G0XGMAoX5+aM0RqmBDuA4OLy0
 rZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SwniNxok37/LYegTpNsKUZatfoKXxfsEbk4JpSC6o1M=;
 b=tidan5dVQYByya5tKKSzQ2mauNXGbmWhNYRgzCTNqsRPh/LOdSmPmhZVjnkYXGXKtf
 uBzJd/2a6ISEiYE0EYecL1efShrbmVk+fhPfLVH8+0y3KO5gWbnur2L9S4Kj36w/7XGz
 fhMJ0O9RNVTioso33knUiwZ2lwVhI24k3heXtc157ss4MslfsMnCfgH29jfGS5gFyUhO
 3UF7cEKd8ZxiihfdWUl1q6ouf/7feONXcrPjuY4HumWAPrQoqBM3k707OlG3YT6TLvfR
 xHNiQfSwtqdgDnLMXlIQ1KLsQscxp62TORPy0/SA85OUQNoZcVPImopRzEz65Q/o1TbZ
 D0Lg==
X-Gm-Message-State: AOAM533UBhVvH2udWGGga/J1RCyzTlczMTGtiTDYDp3NYpEfH5YsAFCI
 Llf5tnYenJbEpwKIiT/0i/EZorlBvoBacQ==
X-Google-Smtp-Source: ABdhPJwZvOtHrKV6iH6YCazJCdUzlRxWmwgn5UgHOLmbD5GqeSzsTzdwkl7ptIuIGKz0g8q8YqWSCA==
X-Received: by 2002:a17:90a:ce:: with SMTP id
 v14mr1081444pjd.123.1598657904447; 
 Fri, 28 Aug 2020 16:38:24 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j4sm540587pgf.8.2020.08.28.16.38.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:38:23 -0700 (PDT)
Subject: Re: [PATCH v2 44/45] target/arm: Implement fp16 for Neon VMUL, VMLA, 
 VMLS
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-45-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1306a667-216c-533c-9107-e42aa9ebfa24@linaro.org>
Date: Fri, 28 Aug 2020 16:38:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-45-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Convert the Neon floating-point VMUL, VMLA and VMLS to use gvec,
> and use this to implement fp16 support.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +    /* a->vm is M:Vm, which encodes both register and index */
> +    idx = extract32(a->vm, a->size + 2, 2);
> +    a->vm = extract32(a->vm, 0, a->size + 2);

I know this is what the current code does, but I tend to think that this is
better done in decode.  E.g.

# SVE floating-point multiply (indexed)
FMUL_zzx        01100100 0.1 .. rm:3 001000 rn:5 rd:5 \
                index=%index3_22_19 esz=1
FMUL_zzx        01100100 101 index:2 rm:3 001000 rn:5 rd:5 \
                esz=2
FMUL_zzx        01100100 111 index:1 rm:4 001000 rn:5 rd:5 \
                esz=3


r~

