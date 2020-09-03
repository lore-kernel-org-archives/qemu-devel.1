Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7145FC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290E0206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TulSmbWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290E0206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsUo-0005Hk-Av
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsTU-0003gr-Cp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:52:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsTS-00065R-FK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:52:36 -0400
Received: by mail-pf1-x444.google.com with SMTP id u128so2790120pfb.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YGaZi7VgeTfvUZOm436eKpOQgjUIU1eNsEdcRl6xGS8=;
 b=TulSmbWFDr66EjIkaxFhZYSDpHGtziPSDsbkbYfz0+1Qt7qdZXrtq1cqecB/hid4oN
 bsdof4I52wTl1ZgGk3sVo3iGL7G6m5VJysD0fMYBB5e/CTjr2cKvHFZC4x+LhPVYEtfo
 g9qegheaRfIPYr1VSnViXJwxRIGHOLqMRGb/PRuD260V6zZ4Yahr00JxNNskOfGbBzbH
 GunekvMQ3zjUkD7hf6BEPTmnk4oYHfPtElVuXsA6Id86YvhZAyHzWcwwhaOwM3RssXcb
 xYi7vskqFWZgjkZyIXRyS2/rXw4FcEzzqoL7Z0ecfkgA//YIbiMImd0GSXzK9t05Fyfx
 JXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YGaZi7VgeTfvUZOm436eKpOQgjUIU1eNsEdcRl6xGS8=;
 b=ZEzTRCv5LAXrvtcSLyghyKWu5d5wTruy8daAUMY8r9s2eVpxwz5x/oGmpn2sXZ0Tsz
 8jBqTy/anhIxZaAMEdG0tuPBPH7EMCbsMyemAssyOZSc4EOEqwwffq6UxfEoSmMDvYil
 SEtxMe2EXeQgi6YebTIDrXfZo/d9kmFCc8oxLTf7ZoGi2xxKnfBwU6NR5KLHSqHgrzAv
 bz2M5doQe/7R/ZPeIDhHd9ubfxPGr0z5K8P5PkeXwvvCAHsDbVkgSH00Wa5EF8GQSAeg
 +ssHu/VtQKaSEJlD29Jo48l9rXq1NXMRMbIJQweUc9vA8WILFqTSVFWGIqrhnl4+FU54
 uYxA==
X-Gm-Message-State: AOAM532j7iO09Da+EyaVx/FW60al876Ff7WKrcyG1g24Mga2lWpVhWKW
 k53/yJn0n4awXZCZK7auLVMDTA==
X-Google-Smtp-Source: ABdhPJwAh+iLU2CQS3CeEy3rY8XBQWg1kddH1qN5hYASOnc30LuoqfKM9Z0a9x4IMKPzGn8LjXkfUg==
X-Received: by 2002:a63:110c:: with SMTP id g12mr3543941pgl.91.1599151953049; 
 Thu, 03 Sep 2020 09:52:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k5sm3097600pjq.5.2020.09.03.09.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:52:32 -0700 (PDT)
Subject: Re: [PATCH v6 4/8] util: refactor qemu_open_old to split off variadic
 args handling
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903152210.1917355-1-berrange@redhat.com>
 <20200903152210.1917355-5-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0fd4036b-d3c3-5bac-4ae4-64ce598880c5@linaro.org>
Date: Thu, 3 Sep 2020 09:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903152210.1917355-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 8:22 AM, Daniel P. Berrangé wrote:
> This simple refactoring prepares for future patches. The variadic args
> handling is split from the main bulk of the open logic.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/osdep.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


