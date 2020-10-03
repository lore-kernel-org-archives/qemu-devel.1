Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC315C41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709B720691
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZOUMSCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709B720691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlFK-0006NY-K1
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOlBM-0001f9-IT
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:18:52 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:45261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOlBJ-0000PH-Sg
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:18:52 -0400
Received: by mail-oo1-xc43.google.com with SMTP id h8so1172860ooc.12
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JiOaHmztZx69QdBOi89znhr2Y++Js4D7pdtyKCX51lw=;
 b=HZOUMSCY0A0SkgJCmIuglJlEP4EsiXf/i6tftEoc4QWlEyMk5d5E+Jw8cKuBTEmm0v
 gK7YpRoiAaYEpiPX5afCDuzJgFiOsV0y3+y7c5RHGBU1OfGq6lRjC5Gj+18RMjoyGjzL
 LqZPCHko2ZbGepqjcejiDIvmgPNQhfyanqyod4ZwmcQWbw6fDLpNF6upukiPHqmbVH4H
 FTH1UAilgzPNsHeoVwLtUYtIWwyb16sAw94k2r8yUwUERcgQ3B47MxdHm+UIMMK+HEl2
 pScSK7Co0iBtg4RpQcF0mbvUE7iXG1ldeZyYLgadMNjNdW4lkqDcCoUgY5/XTw6sg4e4
 IVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JiOaHmztZx69QdBOi89znhr2Y++Js4D7pdtyKCX51lw=;
 b=YCOzj049c218FIVzXb9rxINs6+aIWlAsmG4h2ezdXP2xeu2o4uJN8Oy9qnIO7f20Dj
 JKn0+HL0696cAVtMkbfnHXgHZXMpKavNF08OloEXSupQN51kEiXWxudRRkJPJ51lTBGe
 Q+PCsCWZMVpUSdg+Ex+tfcuayYlU4Qm/hrJbjbGFc6F0K6KqG90lrOeMph7V18/jds44
 Hu1CWG2C2ti8HvU0PMTfM4Wb3WQc+sj6snn4ufv9IUSfXxos0v/vkXS3ktEG4CvgCYQi
 XN036VWvc6e7zhHF/dsn6pRGVYxIqc26M8iLy+1oLMHKm4VkeO8hQhtpeCl37P0liOs3
 gfrw==
X-Gm-Message-State: AOAM531RTSUoO92t4fM/KOnFLZHcBBKNTEq/mNNEHYPp5iXqVjM1WsuW
 CO0FDIOlkzaaVE6ScfoYH3Pu1A==
X-Google-Smtp-Source: ABdhPJzI9mEYDI+sEG7syQjdCaNEPV+7VfbKLc92cs7UcKd97MZPTlWkSUVy80EztZZrDJaKkOEi6A==
X-Received: by 2002:a05:6820:384:: with SMTP id
 r4mr6265392ooj.62.1601745528622; 
 Sat, 03 Oct 2020 10:18:48 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id a82sm112533oii.44.2020.10.03.10.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 10:18:47 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] hw/arm/bcm2835_peripherals: Correctly wire the
 SYS_timer IRQs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201002164216.1741110-1-f4bug@amsat.org>
 <20201002164216.1741110-5-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a762827-4d82-63c2-c3f6-3ac9475fb408@linaro.org>
Date: Sat, 3 Oct 2020 12:18:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002164216.1741110-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.252,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 11:42 AM, Philippe Mathieu-Daudé wrote:
> The SYS_timer is not directly wired to the ARM core, but to the
> SoC (peripheral) interrupt controller.
> 
> Fixes: 0e5bbd74064 ("hw/arm/bcm2835_peripherals: Use the SYS_timer")
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/bcm2835_peripherals.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

