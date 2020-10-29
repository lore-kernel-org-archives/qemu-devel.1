Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704DAC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73036214DB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhIJSfHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73036214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY1xj-00065O-Rm
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 03:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kY1vV-0005CQ-MK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:00:49 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kY1vT-0000e7-PO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:00:49 -0400
Received: by mail-ej1-x644.google.com with SMTP id bn26so2349819ejb.6
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dg173+sGEfswzF9gfy416c9DJVSimwiYSD7RCaosqeg=;
 b=rhIJSfHCe8amTDmomZpahTWtkmtExmYnE5Jw5xzF2eCwgs9a6nEdPOGZb3rESyb38c
 yc3apyhkcEL96zZgEQnXtbbYUt2awIceUDLQlzXUSL+Zc8P34FwXmEyunhaNbGz2xP+B
 PtihxErLRQ7HF4oyMMS9asVe+OmFoMBMefszaoEFzHsZRPNbJzvaoAYvzlUoiUbvbDQT
 7uSWigo3X3dJhQJhrx74LlVc6b/XwRIPmnSBRLhqaE4Im05id8tEBXmQYgxPIjmr/boh
 lAk/inUVcfIxs2UvQWHd9sqOAuv+3unVXKZ2o1xi/hJPHomOqOjp9W4/B3K6k9WbBokq
 4FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dg173+sGEfswzF9gfy416c9DJVSimwiYSD7RCaosqeg=;
 b=O5qFMCi7UK3zoB+A83EHHV8HAMPC+0YopcMXYLPiIzFFpNPxmSbmQ8AOzyzjJRtJ6s
 yOjjVFXUb+cNvqj6tvBehZLWebS0sZJzIfT4mLWibBrUtF5rqidgFOX9kjGqSUPf0BrN
 VkkGy7LAy2p7OtwDfBJ9SZ6TSC8K7mVKXnB/ArREgRIXvEwa+WAxuwwkrqv1XRfF6ow6
 jUQpkGDltVsadujRwOiBnJMTpTgaH+t4HqpYasdpqNfte3VmaoWkdiVhRlBg8+aNWn3e
 J+ucHCW2R0jhOyTUCEV+uCTsLlPTm09aysLZtPTm93nakpb5pJyy7tXWE9z+PzG50u6h
 WLgw==
X-Gm-Message-State: AOAM5335TZU2HO3W2JRF1xxNyVYHc+gS81XXeS1naGaJtLmCqeceLa2W
 nmKv/LxcyGZ8quSodfJTC/E=
X-Google-Smtp-Source: ABdhPJzyhsuNPxEVpjqJQquUcGJ4babs4ops5v8QnrZO5XKyB1nJnToDcS8zGyyb2UgIrSUFudE9QQ==
X-Received: by 2002:a17:906:a296:: with SMTP id
 i22mr518991ejz.288.1603954845596; 
 Thu, 29 Oct 2020 00:00:45 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e5sm926507ejb.26.2020.10.29.00.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 00:00:44 -0700 (PDT)
Subject: Re: [PATCH] Add int128_or to include/qemu/int128.h
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1603919949-17498-1-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <642eee82-160d-bcaa-3fb5-1808d7b3c7a9@amsat.org>
Date: Thu, 29 Oct 2020 08:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1603919949-17498-1-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.921,
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 10:19 PM, Taylor Simpson wrote:
> Discovered the need when working on Hexagon target
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg733818.html
> Useful as a standalone patch

Following the QEMU commits style:

"qemu/int128: Add int128_or()"

Add the int128_or() implementation.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  include/qemu/int128.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/qemu/int128.h b/include/qemu/int128.h
> index 76ea405..52fc238 100644
> --- a/include/qemu/int128.h
> +++ b/include/qemu/int128.h
> @@ -58,6 +58,11 @@ static inline Int128 int128_and(Int128 a, Int128 b)
>      return a & b;
>  }
>  
> +static inline Int128 int128_or(Int128 a, Int128 b)
> +{
> +    return a | b;
> +}
> +
>  static inline Int128 int128_rshift(Int128 a, int n)
>  {
>      return a >> n;
> @@ -208,6 +213,11 @@ static inline Int128 int128_and(Int128 a, Int128 b)
>      return (Int128) { a.lo & b.lo, a.hi & b.hi };
>  }
>  
> +static inline Int128 int128_or(Int128 a, Int128 b)
> +{
> +    return (Int128) { a.lo | b.lo, a.hi | b.hi };
> +}
> +
>  static inline Int128 int128_rshift(Int128 a, int n)
>  {
>      int64_t h;
> 


