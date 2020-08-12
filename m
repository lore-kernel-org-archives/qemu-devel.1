Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC7BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB4F20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQoQ/7eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB4F20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vyr-0001Db-8V
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5vrs-00053g-J0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:52:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:32842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5vrq-0004sM-VA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:52:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id f18so4811974wmc.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+j57N7wW8k9OKW6WuInii83mHFV71fKKjmTxB19zR5c=;
 b=hQoQ/7ebXypQFKqCKX/5hdZbBvScq+ghH95DFIy0FkLQVUayTGaMxCHJfBg9TSBh+t
 F7HNNjbDSKGx5c+qpqv4nr7GxTdZfvU9+P/YTEQwhEC/ZRhY0ldaiZJeUwPc1c7R8PSW
 0iizUxwsYQLMLXdPfyDBFa1kmz+8Ktmz/TyinBO/8N5mKm4KKvPJ9gD+1xkddUyi5zGv
 i7VfMdvXaRo3aa+k9BP4d4k1WIuolCDsLzyAtKefKKeVia9BO0DAOMd8VOpKyULvV7Pw
 cBOaudDFsePP/w8vYATX4mnSrgvAb9aTISMwSdiOfVANOgxQ4x9XrsbtXtvmj6FpmPJ2
 kXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+j57N7wW8k9OKW6WuInii83mHFV71fKKjmTxB19zR5c=;
 b=DWU3fJfSaMmtODrHVCSbfFR8AOTKH4Nwi9TeGjTIGrpw+EAZ7a+thU3SgAcWDYi7eS
 WqO9fMwl1KonuY8K5pgO+2kfPWZcEXOpd7uOaVMqiYr3ejwIMrxNyCTU3mWzNvS9t49G
 0Ndujp3i29tFL7qrXm5Mo5vhOwdgmhgbLRruqyq5URCMp3swZ4yQaN9TmCWddHVqmmJB
 97mKfoGtLqaYb4EfxYB14muk611ErSjVMhrBKBzn9yhCLPHMxkAGWXQHxU6yv/gRNK0d
 zgn8xtpVFPUg1WowltywA40b+/H5jXaIuLTkZ2oTlPEFitTaXSSM5cUNcpbJIGIfwzR8
 WBTA==
X-Gm-Message-State: AOAM533fU95VrMG6joXVGLL6FiGIKR5RtjwUC3z0b2Z2coIii0zfMwKz
 RGYd4JcGLcJvNWpnxPe6GCv/3PX6
X-Google-Smtp-Source: ABdhPJzJnnCqsG1WgttFxNsTPvLsI2CGt6IcjhHDx9/aM7b/5KYBp71kuJXp/pSobCdBynynEE9fMw==
X-Received: by 2002:a05:600c:21c2:: with SMTP id
 x2mr992194wmj.142.1597258371946; 
 Wed, 12 Aug 2020 11:52:51 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id q19sm5366154wrf.48.2020.08.12.11.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 11:52:51 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 3/3] hw/misc/unimp: Display the offset with width
 of the region size
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200807143705.30066-1-f4bug@amsat.org>
 <20200807143705.30066-4-f4bug@amsat.org>
 <d95b2acb-c8e8-91cc-40fd-ed7f4890e4ab@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <38099b57-fa44-a0b1-8b44-24bc8a8a5ccd@amsat.org>
Date: Wed, 12 Aug 2020 20:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d95b2acb-c8e8-91cc-40fd-ed7f4890e4ab@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 7:34 PM, Richard Henderson wrote:
> On 8/7/20 7:37 AM, Philippe Mathieu-Daudé wrote:
>> +    s->offset_fmt_width = ROUND_UP(64 - clz64(s->size - 1), 4) >> 2;
> 
> Better with DIV_ROUND_UP, I think.  Otherwise,

Thanks for the tip! (and for reviewing the other series) :)

> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 

