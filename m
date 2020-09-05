Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3BFC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE39D2073B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1A7HR0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE39D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfxb-0004I2-4G
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfx1-0003lF-Mr
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:42:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfx0-0001XU-7L
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:42:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id m6so10882941wrn.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sYrL9yO7gV87qUMsgaLyavewF2w86opY4D7SYA8kSkU=;
 b=K1A7HR0+n/QSMn6nMjTbDnSk2fXsyMyqEEUWB0IX7LIRMg9vtOItv+ec4+VD4Alu8x
 +8UHDuWVBct6JRRuGmeG5CMpIdXL+V1/zYMKLgT3XAcdx/Qi+QH0KEZGcBkBY/RWOhQj
 NlNbLRW38xiDpTfUZabkXUKSeJt413gRwBBmIRL5+gREM4KJqPLYWtQRqB+E7WAegzMN
 NQ1TsCEHC2oXOLuKChwmlIUWBSyDmvut95SLu+Aq+5JgNaR+ZwIcRzGlbdWcgApHazqo
 /Fc4aKT+wKTXLAD7OWRAJowvalUaD9mZRoTB+0PcLbGFx7TRJ+okwRr51Fe/HKQB2VrA
 R3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sYrL9yO7gV87qUMsgaLyavewF2w86opY4D7SYA8kSkU=;
 b=itPt2972VrW4m7XRfPT2toP1phBzY1nbAuDBPyYbeqRM9lkXoJZ7fSmQrpKEsj/jyD
 EU4S0DTHQU6ERosRwpOxzTt4TCEMIb3jc0a2DIxRBObB/H+WlC7w6Ae3TxPC3mMwhfOA
 aAxVLv2sKCfcrxfIoHeTSHi93aNWHQhoMS+w6uUFe7DN5n5az4vpLPu3MXAXZ40iGzTQ
 GP9NegkWXGRCV4oG0+S7bo10lLUbeEogCTl/7XC+SAKrrpP/XRG+PJNr0INxVWNZcd1t
 42OZp6pFcDwHTpK+uR4xXW9DieVOGeGIgcv8ky5oxTYAzzKjjnkh/HBMsJk01sgY1eLW
 6sBQ==
X-Gm-Message-State: AOAM532cdUO0UMYeaQlEktYi+IxsVfo7WwJDzVsRzH1ODYO98R0tZZV9
 8t9NGSTNPoObXRUUBJITNy0=
X-Google-Smtp-Source: ABdhPJzyRwJ+svB5iFcgQZGvNbuVlWlZdpx1LHHH5mOHxoCsbNr/79hpSLo3h8rdrOPQMvHJDhpEeg==
X-Received: by 2002:a05:6000:1184:: with SMTP id
 g4mr13748598wrx.20.1599342140725; 
 Sat, 05 Sep 2020 14:42:20 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t1sm17563671wmi.16.2020.09.05.14.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 14:42:20 -0700 (PDT)
Subject: Re: [PATCH v3 18/19] target/microblaze: Put MicroBlazeCPUConfig into
 DisasContext
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
 <20200904190842.2282109-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bfaa38f2-6f6e-387a-b27b-e32a7cb5a8fe@amsat.org>
Date: Sat, 5 Sep 2020 23:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904190842.2282109-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.107,
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 9:08 PM, Richard Henderson wrote:
> The bulk of the translator should not have access to the
> complete cpu state, to avoid the temptation to examine bits
> that are in run time, but not translation time context.
> 
> We do need access to the constant cpu configuration, and
> that is sufficient, so put that into DisasContext.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/translate.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

