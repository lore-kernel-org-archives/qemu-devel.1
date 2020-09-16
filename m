Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183AEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E4C22272
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5HuvOQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E4C22272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZan-0006Wg-Ut
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIZaE-00065Q-P5
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:42:58 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIZaD-00010X-2m
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:42:58 -0400
Received: by mail-pj1-x1041.google.com with SMTP id u3so1737267pjr.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wpClSBYX9DEPCawVcQoDG67bQ67JcwxeNZjgWicbUkQ=;
 b=u5HuvOQPQilYlyD/7lQRo7qwOlBDeFgWfx9Y3h8kTDDlM5TBBMJjkdcnD2QAF1Xw/u
 G3CHfVEriEOhbLlRNwQgHmYFgnPROeI8PwoQycE/WxsZ3jXEid817E5r9FDh2N5K67hv
 mSYWjMKNSaBbOyfzIhpyjx/WQ5jSgCnvNoYcIto15CKn51+9I0ofiC+736vw8sI9JeNG
 I9GFD5yDQcfVgK1Tg+BPap87ZNOcrnrgnu44HrQ/XUt/RHXZ/OwoIyWema8L1B/trS1C
 sOOiqAcRzi4LH68eOd9vchjxyJgYTfRsKEr8QmqqgykG+nUlhOvmc1OjWGwwrApLoAA/
 /Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wpClSBYX9DEPCawVcQoDG67bQ67JcwxeNZjgWicbUkQ=;
 b=R7vyXmxdeLgdwp7pjHaSAiQKuHqlP0OULdo5FogzNP6FA2tyZO+z+VGes5icAf5CoI
 o/I85VgeQMbGFq70OtHnYqOJTQZXFSuRx1qf66+Wpzfp7I/J7lYGU/sENwwftaNaB+vc
 jkYGr41/e5fR+mCkNFDCY0fotOQJDgEnNI7wHOv8jCrlhIzi9bCUScuPtJj3jcPfyiyG
 +ktBdpCb92w/hMq4O4J2TUiMSR14DQMyxqqdIFXmq02FJO+PE806kFDT2w3uyVO45GCo
 8Xbs527+rl5m/FjrpY98XJTFGMlxlNkOF0ovDv3bxmhzWvXMifun/Jsinush/w0ErvfY
 ilkQ==
X-Gm-Message-State: AOAM5312EN7rwGt16Lg7xmxKgiwVEi+c+IQdJH/+LR7L5O9pgaD3O3zG
 du7+J/6haE303niRvSb3KPmplg==
X-Google-Smtp-Source: ABdhPJyr8ZmiNNvLTh/50BWQ3syjmXB30xMHMJry0kW+ljACn8aK6LssOh4UCOuIptGF5yQ1NHKhjQ==
X-Received: by 2002:a17:90a:cb93:: with SMTP id
 a19mr2433250pju.207.1600270975447; 
 Wed, 16 Sep 2020 08:42:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y13sm14883696pgs.53.2020.09.16.08.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 08:42:54 -0700 (PDT)
Subject: Re: [PATCH] configure: do not limit Hypervisor.framework test to
 Darwin
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200916081131.21775-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f91e623d-3d87-f8e7-28a5-2a0c860146a2@linaro.org>
Date: Wed, 16 Sep 2020 08:42:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916081131.21775-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.062,
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
Cc: Christophe de Dinechin <dinechin@redhat.com>, r.bolshakov@yadro.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 1:11 AM, Paolo Bonzini wrote:
> Because the target/i386/hvf/meson.build rule culls hvf support
> on non-Darwin systems, a --enable-hvf build is succeeding.
> To fix this, just try the compilation test every time someone
> passes --enable-hvf.
> 
> Reported-by: Christophe de Dinechin <dinechin@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


