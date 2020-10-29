Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707BCC55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16B020782
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8KpX5ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16B020782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYE4I-0008Ox-Ls
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYE2w-0007st-Mf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:57:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:38145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYE2u-00081l-UX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:57:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id 10so3261664pfp.5
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5myeMAAO/CLup76oLM4fXqmFmmYTBbqa9pCtXsZS/8Q=;
 b=O8KpX5ardn2gFj9Suo39nPPiXooo1eXU4QaitB6iG3qWHyCYeo2dMtKmvXqC0ynnfL
 qulwn+Hcn7uciyZfzrXGp25A0zg/U60jY/uRXEzx16bXM5C19WVQecBopUBvgy5IHIpW
 BS/CWTgL9e9YUcFPaIVVAad4tQq8nS3WO8USd+lPQAVLaLsBmsk4hyjuzFft6cNmI7aI
 Ut4sHyJ7IVc40hvlU/JT4nDvAymX572lKKY23hVLBxNT7Kve4FvRaRpBNHV/wJzMUXSy
 2S5t9x4RYZE/XHqf9nwCTq1TLiSvkcOl5tWj4j5apnGDnwM0o8ceE4pvO+4SLP/kNoJp
 U9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5myeMAAO/CLup76oLM4fXqmFmmYTBbqa9pCtXsZS/8Q=;
 b=BbfzRMrB5y2xnwxMn6ANHF1hsjoPG+ojV1xLYl3EvTAMhSa9SyHEtVqgyu/FYXupiO
 7agRKsADIIEvC4x1JyGzBoEfE7JgiYVUEGZZpTPUoKoxEjFdh4f5RksR2rPaxoE5OEUh
 BXgJB7hg3uBpXBItSybz3WAmebxppUAQMONrGevs+AhBROAayBXy0nqUoxSweo5+Hcdq
 WyqGfKdpZpQeWGy0rqDpT///i82yK8CAHlctzcJzd6WwUU+ZPgDKOpiMaQoqtb+KDfVl
 XNPXvchtN8Hf0FWgvIjGyznWF1Y1C2g7hqkUHyf6F5O0y7UbLzo4dsofEtVDQ8Q7UMrJ
 fA5w==
X-Gm-Message-State: AOAM530Sgkh1yvQ1rymy03kmZG2iePvokB+i+odGHlhE1HzmYsPT6OSR
 yVJek5Q/YwpXHC3a5G6DtQyNlg==
X-Google-Smtp-Source: ABdhPJynK38yFXuJZ3Gj499afJw5hVaJtBtZ0GDbbWEgvTwIB//bFIAi7WM6bQVCUG9i9PyqgJRcLQ==
X-Received: by 2002:a63:143:: with SMTP id 64mr5548591pgb.335.1604001434593;
 Thu, 29 Oct 2020 12:57:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x123sm3801225pfb.212.2020.10.29.12.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 12:57:13 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] hw/rx/rx-gdbsim: Fix memory leak
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201028192219.833329-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf44f3b3-c604-0b02-f37a-271f238956fa@linaro.org>
Date: Thu, 29 Oct 2020 12:57:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028192219.833329-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.261,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 12:22 PM, Philippe Mathieu-Daudé wrote:
> +            g_autofree void *dtb;
>  
>              dtb = load_device_tree(dtb_filename, &dtb_size);

With g_autofree, we must initialize the variable on declaration.  Often this is
with NULL, but in this case, just merge these two lines.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

