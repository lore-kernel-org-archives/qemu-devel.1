Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE64C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62187221EB
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjeqHHuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62187221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDFtg-0004GP-IN
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 19:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDFt4-0003pl-Ne
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDFt3-0007Xc-S6
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:08:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDFt3-0007Rb-KV
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:08:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id 2so7520821pfg.12
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 16:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1TkZPilsn+jl35ez8OZ36Wsu6xin6wdaz7FWIvDFTkk=;
 b=EjeqHHuGfA0yP3aCZfux1h6+CNyFRz62tNQGtqXox33Ddr9b52kdiRcjog6VZHfEAf
 cJZV7gdrNKWlcL18yl36nI83CRJpS7iSzJPrPHfsqnRPejo8d4GYA2/47mCpvXPe/JGm
 FO4njLl88rnqK8QWIrgyW1fTGwZzS7MVGQyL3kN63OQwfUiEkuy9tijmzFVJM8lk/e2I
 lLu0S3qfsIMFHMsBrWMamC6je3Mv8sjKIm6nqq0rcDMWrzuu/RgoJbC74DGQ+8131ss1
 ZH9PRNyWuomEdOL5sNeesQ86lzxOKwWNWKv1RlozAMxQEqVgmqDtiOGl2fxAyWnhyg66
 bISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1TkZPilsn+jl35ez8OZ36Wsu6xin6wdaz7FWIvDFTkk=;
 b=ToxX+2NDWmb8+AYUeolhYuOQb2V0KyOvOuudxhwBjKe/GfIkhpjULhhTiSR/rMa0jt
 GAKRoAdPg2cN+eJD6sJzMdyhx5bqByZrni0o6UtA7AzQ6OQ0b2OpO/Mo2x6CDiFdOIEa
 4dV7bq1s+MzoJjcdaMR7OleBEfYy1ACybVAIeAkMjGPkI9PyM5Z6GLNZBfT+2V53Aaom
 0/CyzDp0gubvRhdsNlvfnY+C8OK7dY64phOUWDhfV8kLOmx+eTGigANSeLM9Fn8TgOLt
 alDnBRb5O7gGMA+QPUc6CqUabkC/EHk9JtpUy6YBxhzaCzlr6jSqUfuaXlf6EWu8ai86
 6LXA==
X-Gm-Message-State: ANhLgQ0/jf7k/Y8c+YqlDuksb7geW6/j7gBVO1ew5H7rb2GInGepm4P0
 ljl2/1Q7oc64buWuDBcZKSFOHg==
X-Google-Smtp-Source: ADFU+vvsbLfjYsNc4D0coPuDu08yxb71hpvxnpY1aDG7PCeXxe1Y5qiZLRFVufZpu7XTB+0cmou2pw==
X-Received: by 2002:a63:2542:: with SMTP id l63mr19671502pgl.312.1584227288404; 
 Sat, 14 Mar 2020 16:08:08 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d7sm355063pfr.17.2020.03.14.16.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 16:08:07 -0700 (PDT)
Subject: Re: [PATCH v5 43/60] target/riscv: narrowing floating-point/integer
 type-convert instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-44-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a1d4b32c-47db-b399-4c14-05d9269bc3d3@linaro.org>
Date: Sat, 14 Mar 2020 16:08:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-44-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +static uint32_t vfncvtffv32(uint64_t a, float_status *s)
> +{
> +    return float64_to_float32(a, s);
> +}
> +RVVCALL(OPFVV1, vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
> +RVVCALL(OPFVV1, vfncvt_f_f_v_w, NOP_UU_W, H4, H8, vfncvtffv32)
> +GEN_VEXT_V_ENV(vfncvt_f_f_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4, clearl)

Same question as for float32_to_float64.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

