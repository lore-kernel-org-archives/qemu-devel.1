Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ADBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 21:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8575A2067B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 21:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNsfPM0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8575A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgx40-00057R-Qc
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 17:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgx36-0004X9-Uj
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 17:05:16 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgx34-00061O-Nf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 17:05:16 -0400
Received: by mail-pf1-x441.google.com with SMTP id x22so3840730pfn.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ALZSyeo39NbS9OLB322BCxqDYf5DPRpt4qvdmM0EEqw=;
 b=eNsfPM0ojKk3ID2Xfld3Vu9RFCiL9CPwu8HSU744sFXyuXYw4xx8tAa8IT7MygAMbX
 Ip7YXQmroicxSyNee/jHj/dc2Q4Ia8+yPm6AgROAsmWWxduTP47lxqTSaFYNLfQgMD+6
 BqMHwj8Zc67Y0pzKkOEp/u/bScwjgga+3Hkf0dRilWXkoJyeUngnSioKldiypy5Ei/aW
 U2VPA2qQuN2I9iNKp78srmp7BejwoxVXMvtOCgNWssyz7oGgDGfr7Y3vuKvOjugMckGY
 LNHl9n2H52PjWwV+TvR64ZzVN2TAOf/bSbohjHaS91cD2Ai15ZHk7E4K9dL3LMrAJ2QV
 Zx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ALZSyeo39NbS9OLB322BCxqDYf5DPRpt4qvdmM0EEqw=;
 b=h59ZnSDT9Ct5YxfrmlU2Z4XA8eoRPaWRqj9t3W2uqoszrIibJT8TNI1SED8a74JuEy
 s7egsYo2We996SENkqPmnENEII6CCHdvMd6VGuak+ANkt793VbHYwyXmWeznZLpyz/Zb
 7W/YAkMqLHZmz+2DV3z/uY5C/6IZ7LZptSNAHvKz7l2pLEOoToQRN9LVGOyWie0p7SQ9
 KwF0kPfWWRmGSUgYzHH0qgnaAr2pxIJ5dFRwpDoFZF7A1EScxDMuK987RJ07bmP+iZVP
 ty+iShEkJuS3RQFFUfwhe5cJU9Z/ZaPgg3lKODdgQR6zfXktThDnyhPupQ9XTnep23Ay
 10tg==
X-Gm-Message-State: AOAM53228Jhev1ECaGAc8NXopm0ijdfPjdMu0GFhVyMXY4u5CXSfCcYj
 dLA1OO+QDCNXVT00Vwlxak3+cw==
X-Google-Smtp-Source: ABdhPJyyVeEtKoXWsNi4Z7PauE4xhGzXkdbHyMRIl/GNK7/I4aE5obhrzAmvHaX+azXUUQSVMtSwxA==
X-Received: by 2002:a63:4a1d:: with SMTP id x29mr6096226pga.53.1591304710519; 
 Thu, 04 Jun 2020 14:05:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id c1sm2566546pfo.197.2020.06.04.14.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 14:05:09 -0700 (PDT)
Subject: Re: [PATCH v8 56/62] target/riscv: integer extract instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-57-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a75eef93-7ca3-2704-42a0-2449dfd1e2d8@linaro.org>
Date: Thu, 4 Jun 2020 14:05:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521094413.10425-57-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, alistair.francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 2:44 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/insn32.decode              |   1 +
>  target/riscv/insn_trans/trans_rvv.inc.c | 116 ++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


