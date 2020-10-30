Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1722C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2398320731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBg1+aqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2398320731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYZOe-00076E-V7
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZN0-0006U2-DH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:43:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZMt-0001BW-Pj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:43:26 -0400
Received: by mail-pg1-x541.google.com with SMTP id o3so5938346pgr.11
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/fASQS/vg4+7sSwz9Ev+iuGWJBOfUnQURoJcpEt3nsQ=;
 b=RBg1+aqoYs8Tq8GgHzgdMfLYExHuxM9EvNnW6hEvVi//iYGge73JFv29MB4OxJC8cc
 +hs9NGnZ5/2ySSJKEGZ8UZNlSOqotqmooLaFUKySgnQvstjzdKXGKgYDxiZt0x5rxWM0
 sw4c94YX9VNYSL0PcW2JjzO3ir92wmszLAwOTX5LLzq8Slt3SctpMwc7qgz+V7Bud++J
 Np561XHluooNXFjlD3QmoemR1q2RtYoVJ9IygLMnhO9lDvZnFwZw7OLGVR9YMcI7HQ3P
 kpNYfG2WgfR+A3MK6CWRYCaXUilsI4oRa0VIUyPiCvjrPMOfRrUGWRDes5E6jSXG9mUL
 RLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/fASQS/vg4+7sSwz9Ev+iuGWJBOfUnQURoJcpEt3nsQ=;
 b=kXYdo5i8BoOSVJ9p5OrIUjR6fYW/eZNPr0GH2AvYgrdw1l5TvVYkjdyJhP8yiNB6rV
 asf+ZzRGw/DxMt9/uFK8zLh6qhtGUch7XXAW2vs3Pqkvncx3Q/35+lMxmEmoazID1j5d
 ec5b5YVuZPLbCmCOOnj9tVAUZ/CsPpm8ibNibTsoJ0hi2vxfoxpCZ4Sg2DaNQEomPp96
 T4gN8d1Q8kK1O/vRQMxV9XyiaItAl2DMO2DuMcGrBCgA9hbLqo4uy3B8x/ATcWGM+SNB
 5Y1BmCBYGmD73cBxjDSqYvpNcm92zfOnKqkermaL2b9eNwjDfiJxAlQh/ZXYm/bkdvQi
 g0Ig==
X-Gm-Message-State: AOAM531hWaSvw6YM0SMa5sRjBO9UhDRZFxapgFUaELcUg0ttenWtOYAC
 lkHIIHPnUvmMkACU+C2hNIKgOw==
X-Google-Smtp-Source: ABdhPJyInc+ULnwdbAzI/w5i+iPjoAPbFvY5/CvBP8kZYT1w+rg59Kvs+2iACap5v3i0t5JO9fmoPQ==
X-Received: by 2002:a17:90a:de5:: with SMTP id
 92mr4366744pjv.179.1604083396168; 
 Fri, 30 Oct 2020 11:43:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z6sm6717683pfj.48.2020.10.30.11.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 11:43:14 -0700 (PDT)
Subject: Re: [PATCH] target/unicore32/translate: Add missing fallthrough
 annotations
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>
References: <20201030093157.11795-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7c109ad0-c1a8-d60a-839a-b70e988f3059@linaro.org>
Date: Fri, 30 Oct 2020 11:43:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030093157.11795-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 2:31 AM, Thomas Huth wrote:
> Looking at the way the code is formatted here (there is an empty
> line after break statements, but none where the break is missing),
> the fallthrough is very likely intended here. So add a fallthrough
> comment to make the it compilable with -Werror=implicit-fallthrough.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/unicore32/translate.c | 2 ++
>  1 file changed, 2 insertions(+)

We don't need to guess based on blank lines.
This matches with the instruction set overview at

https://en.wikipedia.org/wiki/Unicore

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

