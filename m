Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E75C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6FF2073B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c86P5FTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6FF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfwn-0003Cy-Jx
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfwD-0002kB-Dg
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:41:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfwB-0001Pn-Qb
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:41:33 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so9812070wmj.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ebcUtTn4PehBcB6V0CciawNM0piRDMerv10NHneDLqQ=;
 b=c86P5FTO1hvOS1dD/jTLdIUk+ja4xWazemazG9IdMhNntpCZzDOxaeKP6GJSUN5Tbw
 8OUqkNWTnvfnhGgnNxbWjkr4j/AYd80KgFu8Zo9cW9FugARnQPE15aYPZJxLiUln82oQ
 YztbME1FKXuryGvwA90gWD5uh9lOrGugAZq2o9h9BFk/LEtQZJS3Z0s4mW2wBbF68/0m
 ZlwAnXr429PWn453lXLUbptmrK2T4HI6VrKi21u/Aerr900wABOcgmYeMJMkUAVJ/lKN
 nHt2BygAJ77LnC1ShZu1OmalqiVllofDfwwBm6l7KHUPUmKNTFn2UaA5D/my6PqDpG8p
 P0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ebcUtTn4PehBcB6V0CciawNM0piRDMerv10NHneDLqQ=;
 b=DgwqyNMzuJv1OtUlXSBYteSerPZzKKL77d2WrHU0nGqVgPOTlGO6pZ8LJuE8JfMOXk
 xPc/PB/GMmoKJ3cn9OvKnQBdb3xbQRF+x8mQ71Z0unmjLkxp2PIvDRaX9mQy0IgxXMjV
 sp4H3ZZZdrDaXq2bNBD9s+hpGHkF6m3YTKBgE5Vly5xKrGslCuDLF3d1frGf+8x1i077
 G6nO/qVYoNs5vVA+DEPAN1xJVmj1xT6+JLIINalbQ6GsAqWlKG/zDsJQLUB0ELlYvYLs
 As9/fffKtFJSgQJMHR9CNesVo85Q7SAVuldJc8ewmeLgbuOHVwOgWzk17zlTCYgJ4qB9
 RWTQ==
X-Gm-Message-State: AOAM530nwHMH2GpnB/IQwFwahsKmn6LZx1frxct+go4yIr+9B5K8YZ+U
 IgIsyV+4NsoBT7CyzkTI5k38a/gTFr0=
X-Google-Smtp-Source: ABdhPJwPK2I7AJpcnbrqo0ndIBkC56GB7BX0MUjXxPWuA676g/kH61qFywZD+iVV+kM+o/Yv44xqHQ==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr13402149wme.179.1599342090355; 
 Sat, 05 Sep 2020 14:41:30 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id c6sm19148621wrr.15.2020.09.05.14.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 14:41:29 -0700 (PDT)
Subject: Re: [PATCH v3 16/19] target/microblaze: Move mmu parameters to
 MicroBlazeCPUConfig
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
 <20200904190842.2282109-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8d8453ae-0020-ab47-ffa5-feb56afb6143@amsat.org>
Date: Sat, 5 Sep 2020 23:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904190842.2282109-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
> The final 4 fields in MicroBlazeMMU are configuration constants.
> Move them into MicroBlazeCPUConfig where they belong.
> 
> Remove the leading "c_" from the member names, as that presumably
> implied "config", and that should not be explicit in the location.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/cpu.h    |  5 +++++
>  target/microblaze/mmu.h    |  7 +------
>  target/microblaze/cpu.c    |  9 +++++----
>  target/microblaze/helper.c |  4 ++--
>  target/microblaze/mmu.c    | 30 +++++++++++++++++-------------
>  5 files changed, 30 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

