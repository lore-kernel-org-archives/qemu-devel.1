Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0081DC433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49D620663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWGmNan+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49D620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv41Q-0004aR-0Y
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv40c-0003WD-UZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:21:02 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv40a-0006R9-Ae
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:21:02 -0400
Received: by mail-pg1-x543.google.com with SMTP id m22so6448657pgv.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Kgo4BLot8UMYU8cwfO6GPhprIl7fX/sQxBzvNfxI/7M=;
 b=lWGmNan+bkn4C2074Riu4TfGrxBwnHKG3aKTO97dQkHlppwKX0EqjHWm4dXgxdONTG
 y/UMF8gvC9wtR++j4UuPWg9/5AnmsTdZnLi6VHXDpoC3OdaFBm/YUx6WmDFyDhNSNhWn
 ZOkO9ZHAK1U6QG1/FcfOfYJhbLW1Ffb5NZy2PvOfu0imL4oMtT3bMk8v5kiXME2KMN9U
 vd6NuyGUXF7+fh0lriaL9FNZyhQHEPYpmgVh1rZGp0PTi6eINMB1biH0CO7IJKuPTqDa
 rRDKPDmxXulAUIxDtv61TUdjmlTTj0OODasHqNl0ylnLpUoKpkVktD7giASERVpJNWEX
 8CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kgo4BLot8UMYU8cwfO6GPhprIl7fX/sQxBzvNfxI/7M=;
 b=g/VEp01hldvjzfhW+Ij3M1PLyGI6fEBcIalUBh4lcZ+oMWGKJPb3Q0/XglAfWM8Fzc
 QKM+3WnU6aFBFii3f1czXSsFVXEl3PUQ+BbifhHtJcGCqmOjl9icidIRGY7rRGLQrlCN
 F6NYssmEZU7LRX0g7GuU28ahYR2MuVqDzlCLWZ9+UjTvHT4B5QRnHaGzv0asUvgNmhA/
 /IKdqhMW/ml5WqveEsTy9FLJ09OeslsTN2fPLObE2eh7wa4oZendBOJc6Cir+87weMZS
 ynat+f5P80bpy92Bte8vxyC0V02tjW7dz25R8QI8UxrI/2EGAknhas+LXPqt9hznVDxz
 L7JA==
X-Gm-Message-State: AOAM530CuGJvst3ZjrSlzus0J2I4Hjzwn1pgO2A0j+Z2iS6QOlMEP3wG
 wssfVaTpHhApA3IZ372RKoloBA==
X-Google-Smtp-Source: ABdhPJwj3pP9QOD7cprY+mQi04JWa+BO+wMVRGOyuh0fZPuVzD8+2Zxj9hORHMCk5YVwZNznhChD3g==
X-Received: by 2002:a63:9d45:: with SMTP id i66mr550705pgd.25.1594668058728;
 Mon, 13 Jul 2020 12:20:58 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k26sm14092145pgt.90.2020.07.13.12.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:20:57 -0700 (PDT)
Subject: Re: [RFC PATCH 3/8] fpu/softfloat: add FloatFmt for bfloat16
From: Richard Henderson <richard.henderson@linaro.org>
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-4-zhiwei_liu@c-sky.com>
 <c8fa12f7-6200-4eea-b965-c5e4b2915800@linaro.org>
Message-ID: <6d79072c-ee36-1030-2c11-e2a272bb1b9d@linaro.org>
Date: Mon, 13 Jul 2020 12:20:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c8fa12f7-6200-4eea-b965-c5e4b2915800@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: wenmeng_zhang@c-sky.com, alex.bennee@linaro.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 12:18 PM, Richard Henderson wrote:
> On 7/12/20 4:45 PM, LIU Zhiwei wrote:
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>  fpu/softfloat.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Actually, it occurs to me that clang probably warns for unused variable.  This
will need merging with a patch that uses it.


r~

