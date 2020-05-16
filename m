Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C43AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DA4206F4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZMoIkit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DA4206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZpSg-0005mS-A6
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 01:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpS8-0005Ka-FI
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:33:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpS7-0001E9-Pv
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:33:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so5830726wru.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 22:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HTC7hhLrEQbCyOPWsHaRNGQ8RWxwq2pqGyb3TllKs6o=;
 b=iZMoIkitbFev3G8fGrZhOqzr9buD3RqGlaYBeW4VcBNGM1S7bPyDYwuqSkW1TYlX9x
 qgSTnx0lteuBoFT/EXPzvuYhDre4naj0KY4T65rvnDPB+QGOMYF10wEnLfopsW0FYTIY
 CIvXXCzOFejcBK81AQSStFIfVkkAaJnXijSFc3NoZfHIWE6mQeXZapJ0/wiqV/cNxLHE
 0MnM5SbNngikgN78Mh1j1YXN2u/ZF3D5ehymWWg0cDhYz8Ufjymyvpr7McgJ58MRfjFX
 JC22Qz7YKJAqd4AzxLZWlvY1vTjokxN2Q5OD/FdlzcS1uhUmZRg+X40+R2opKooshOgU
 A+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HTC7hhLrEQbCyOPWsHaRNGQ8RWxwq2pqGyb3TllKs6o=;
 b=rQ5dNFBOUMV22ad6pXSR4llaiDmw3GnK6kWCvWTXjM4NUrQkpSxNKqHZ+tPIhrTz0M
 Ob0vyhzUL3qlz1bLkHwtmJTi8QtsUTLvWRFe7ncFLkeH1Hh3stTH2pFQ/h5sNziyHzM7
 l1hfRsJa1O9gGTiPzDgaVya3HkZ2ndZHpoKOWm0bzDXeD+u2dV01i5sVTGYU+O0mW0Hk
 5XMSv7JhpEYbt0yAzGmbrluN6Ti+HnOiys/GLTt8+WCZABuReYa8GKji0Xjjnzj+5t6t
 /wBB71gY3olpYEjFjdPH4scvdw2C/yXvz3CAR5sZvsRTqxml4j06GFj164USzTBSbND5
 MMJw==
X-Gm-Message-State: AOAM530de7RCvKjvpuWAZeG7bKRj0GwvT5rQuofxkvVyC4qb+Dwx4KNg
 2/Q+ZMS20AW/Vwp7mVc1u4w=
X-Google-Smtp-Source: ABdhPJzttCMvjf8xH51ChYOaGBX976kOv4EOmmNiMI7E6eZKkM8W7vtLvaLJa6fzcTnKdtly5HWlcg==
X-Received: by 2002:adf:f487:: with SMTP id l7mr7535643wro.381.1589607218474; 
 Fri, 15 May 2020 22:33:38 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g135sm6209671wme.22.2020.05.15.22.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 22:33:37 -0700 (PDT)
Subject: Re: [PATCH 10/10] softfloat: Return bool from all classification
 predicates
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fb1a9db3-80d9-4107-cc32-ada838923c6f@amsat.org>
Date: Sat, 16 May 2020 07:33:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200515190153.6017-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 9:01 PM, Richard Henderson wrote:
> This includes *_is_any_nan, *_is_neg, *_is_inf, etc.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h        | 66 +++++++++++++++++-----------------
>   fpu/softfloat-specialize.inc.c | 16 ++++-----
>   2 files changed, 41 insertions(+), 41 deletions(-)
[...]

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

