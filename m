Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 22:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8A6206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 22:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEzcj73n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8A6206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbAab-00089X-TE
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 17:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kbAZk-0007fs-Ot
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 17:51:20 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kbAZj-0003Vl-2g
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 17:51:20 -0500
Received: by mail-pg1-x542.google.com with SMTP id i26so2104707pgl.5
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 14:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sOI8bzzn87v5Pni5KYIalo9rbLAi7Wtn+bY83EtKb/8=;
 b=UEzcj73nTwF8cKJBmbSpivsfLz5lfX4GVwvgT0o3gURJQ8BEOO2lai7IYcm+LKZar3
 bma2YBsMTxHwfUZf044RSTe+o5j9N0Wo4LKMzhWnizKt1NQMsHxTDElo3zHOb5TOTxdV
 kj9g76eRag9Ys3MSFHX0oETDOmCnQbiuoRZ8kgFHSJYJwHYM+Dbk4Xw8LW43M4VP3qxf
 Tqb0rh9Jclig/EL7euibAEDMboanahYdQ8TpaknB6P1Lo8b99+OGj659PRJWBzAx/3sl
 aOu7WVIQmFELkLfQwwo6T3UfYWDYlsG7SpGrgmivwdY3zg4aVI2eNWhslG0LQmZnAXUQ
 DjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sOI8bzzn87v5Pni5KYIalo9rbLAi7Wtn+bY83EtKb/8=;
 b=M7/8OI7m8LwU70BLM4+LGKTmMzlY4mbRpClVSkHY1OkLy0+5fQzmhle+XpkrGGO7Xa
 VzMOT6bkAIyFIH8/QEKf3qVEYDS24/2SXmNOXUjab5bhl9i4mULMC7S/+J3pw0UCSmrW
 jph9eLTLXq6aSdgX5ZfBM0vpIWjk++AtTibQFrCv8+S2bhCir+gzmwI4tqk3DOekvrDb
 LyCsW78SPqEgCnwSTM3OTMiDFdsst6XyqrmNxodDLEB3B+aLIKjfh+aadvSpbK1qta4p
 E8ErzHHmcoRFWwvcgLYp4ZyoI5jrG9sr7fWfeo2tSLNQwlFeT9iPPOJgbOJv2DD6ngqd
 e2sQ==
X-Gm-Message-State: AOAM533OsA1UDfk9Ti5fF+XQ80QyhQSHyfdoxiKZptf6z0o8JSYtsMQ1
 g8SFqObgrD8U8ehnPJzIKFElDqv7bg8c0g==
X-Google-Smtp-Source: ABdhPJyFHBNReXXlwQoHGGOZxFJ0vzqufMupBXzuyX/ECdNpP12yyCvw/ICzG897ItI4L5KjIN1P5Q==
X-Received: by 2002:a17:90a:7303:: with SMTP id
 m3mr1988609pjk.190.1604703076678; 
 Fri, 06 Nov 2020 14:51:16 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id c11sm2677448pgl.20.2020.11.06.14.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 14:51:15 -0800 (PST)
Subject: Re: [PATCH v3 01/41] tcg: Enhance flush_icache_range with separate
 data pointer
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
 <20201106032921.600200-2-richard.henderson@linaro.org>
 <87tuu28bwy.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bfd043eb-cf7d-b5a4-bb26-e8ef07bfb2b5@linaro.org>
Date: Fri, 6 Nov 2020 14:51:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87tuu28bwy.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: j@getutm.app, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 12:31 PM, Alex Bennée wrote:
>> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
>> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>>  {
>> -    __builtin___clear_cache((char *)start, (char *)stop);
>> +    /* TODO: Copy this from gcc to avoid 4 loops instead of 2. */
> 
> Why not do it now?

Do you really want to be including that into a patch that touches all host
backends?  I do it later, in a change by itself.

> I take it i386 is just too primitive to care about flushing things?

Or the reverse.  ;-)


r~

