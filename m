Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B708C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6FA206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lf8dQyo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6FA206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvqe-0002us-Pf
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDvpu-0002JI-Nq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:27:58 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDvps-0002C7-Rp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:27:58 -0400
Received: by mail-pg1-x542.google.com with SMTP id 7so3014034pgm.11
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aNKgomjsVStiCcw1WVtj8fziWdefoSubqFjUduvxK68=;
 b=Lf8dQyo9oy5PXxFgs2JxQfWfc7mt/ynF4mppqju/6snVSTtqrAtG9atpPufcz1z8YL
 R63hTtMjD7CVyRk54US7HwA9eZiUVbNYZe23Te6jNCUNXgM8SxzlQ8w9IFeVI+UJ+PXM
 JjNVG0vc6Ok7xt++kFjFe5zOVc7npkeUa0MlvbExXUtMtAdfymSx2SnLE7oPOtr2gbR8
 8+oh+8x3vH4O9nY1UUvmsotAOOD2iMQLuexu2ie5ayCO1hGvALzWqZ7tq0s6wBfK/SLV
 sIGIk3BCIhtY3cV/YfTc7AEO+e4+NH5Y+syProsp5RD10Fh2ztze3Y5r5MgN+hbseNXf
 2JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aNKgomjsVStiCcw1WVtj8fziWdefoSubqFjUduvxK68=;
 b=PAEac3Wd8eMPqf+JcP2qBwH5ZXGDuWC5RJ1dPiME5wFfLu7+KNX5FUEowlLygraqRC
 SI6KEMMlDaZkB3BMvXM0M7PgeOAcyOIBoM+Oz+Fq+gnIYGvcu/HYDDp6HQpbbH4X/jyq
 20jLrNc1nvFwwAynx8QhkrSPmQL1mhTQERN167/CWh2YIC4mjAjCjfUZAT7ThB6jxFWn
 Q7UxjVv/4kjzK0e9WuFZLgDLxXieJUC70Hv7MZ5n0RnhLaTvZteisVFvOgKDhCTkU4DD
 BiqXUWwf16y7N+CdrmCK8BXO4PFFb4njs6ObUvtqA5d9nChoonXye2+73hJPd6eA53R6
 ljUA==
X-Gm-Message-State: AOAM533YT7QKZYhr9365kx2qOQs8qK8EBjecMJ6MBcvU4x4VYKOzwwMq
 6wtfXeJG4NVzr/e5lKoRM1lhjQ==
X-Google-Smtp-Source: ABdhPJz+h2QtWb3JdWo7YLw+CKlR/cJA9/7bhOr65TuwYUxLZ6wqdKgpuiNCaH87MpJVVu2ZIAfCrA==
X-Received: by 2002:a62:f241:: with SMTP id y1mr5357075pfl.206.1599164875069; 
 Thu, 03 Sep 2020 13:27:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id fs24sm3248517pjb.8.2020.09.03.13.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 13:27:54 -0700 (PDT)
Subject: Re: [PATCH v2] linux-user: fix implicit conversion from enumeration
 type error
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200902125752.1033524-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c8ef9a9d-580a-8a72-aed1-b62e92a139fc@linaro.org>
Date: Thu, 3 Sep 2020 13:27:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902125752.1033524-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 5:57 AM, Laurent Vivier wrote:
> MK_ARRAY(type,size) is used to fill the field_types buffer, and if the
> "size" parameter is an enum type, clang [-Werror,-Wenum-conversion] reports
> an error when it is assigned to field_types which is also an enum, argtypes.
> 
> To avoid that, convert "size" to "int" in MK_ARRAY(). "int" is the type
> used for the size evaluation in thunk_type_size().
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

