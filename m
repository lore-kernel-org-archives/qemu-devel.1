Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556BEC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E0B20665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXViolUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E0B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPL94-0000Tf-MZ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 03:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPL7P-0007cE-V1
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:41:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPL7O-00020W-IR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:41:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id s12so8318514wrw.11
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QmOMXvN20E2xyh3hB+ZoZRxy9gYL31DpHJcUjF8twpE=;
 b=vXViolUHIonDu7+bhzPGSexryUCg9LlSeelO98eGXwfvreoKk7J9RjXGj2yR5p8Zje
 O6YI2xriGLgVfIJ/7g1Rrj7Ks0jc9o0XgiDJ2b911C9pZVEins4SXtK57d5ooAjiYtMe
 wMxTNd+pyaOYm4hFu5eayygqXuXUggIgRynXG7GhcGLBMZ1iulM5z2DdUAJ0NvGzq8eC
 R7D5XiAZ4EZV35sOjh9Y+Is5TYhKu5tEDzHukpsdPeaEChwwTQkHfX3gY4JAL79QK5VQ
 e/3h1JFPFCKnQHvjI4BvcS1dPlYyVex/UNYHaddohR9BUKxl92V+rUfky8nbBULCX/aw
 tqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QmOMXvN20E2xyh3hB+ZoZRxy9gYL31DpHJcUjF8twpE=;
 b=MvMCK8unBGClrAE51wn8/Pry2fPzfDjdMau11flwOikQJQEZJ8ky9uDgsTKgLh8J9N
 Lj/P+2Tx2yYdHP/rZsfcrYVc6n2fDROSEqI2CGqJga7wOSD+1sD4WbfFeyIqm9tDSP1W
 Lmp5tWtaXxE99xNZT34xDdbQ7FC6EDlUtL5Se35QQOyY5NoZgEw+/3oR7ILZcIHtiQTv
 JBiUN4NSGziHrcXUhzBQiaCjWsjxcQE7Xyftk4eKHm7sm7NCRVU5airoZl/BpVVXOWqg
 7IUKbO2dk8oKBmx4y9QpoNTzHHaOH2XeisXfZe8zFBrH8jTHJktrHk3qEfYRh8F3HdBH
 X+4Q==
X-Gm-Message-State: AOAM5321SZAHN5UptE09jvbkWaahb8X4jtNDidCOOL0Hn0DcpOfp/0Xg
 pX7wYhH5D24NXG6/aMwjrh4=
X-Google-Smtp-Source: ABdhPJyz33SRt3U7ITaokhI9gVdoysivdU+HouXza/djFWDIzbZvp8wkUfFuTWbjlGpnA1P1lw2kCA==
X-Received: by 2002:adf:9043:: with SMTP id h61mr16568948wrh.237.1601883668927; 
 Mon, 05 Oct 2020 00:41:08 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h3sm12974080wrq.0.2020.10.05.00.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 00:41:08 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/mips: Code simplifications
To: qemu-devel@nongnu.org
References: <20200927163943.614604-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <79e51e24-c17e-ccca-73e4-4dd59a9443f1@amsat.org>
Date: Mon, 5 Oct 2020 09:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200927163943.614604-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 9/27/20 6:39 PM, Philippe Mathieu-Daudé wrote:
> Doing housekeeping on old branches older than 1 year.
> Some patches are still valuable, so post them.
> 
> These patches should not introduce logical change,
> they simply rewrite old style code using more recent
> API/macros.
> 
> Philippe Mathieu-Daudé (2):
>   hw/mips: Simplify loading 64-bit ELF kernels
>   hw/mips: Simplify code using ROUND_UP(INITRD_PAGE_SIZE)
> 
>  include/hw/mips/mips.h | 4 +++-
>  hw/mips/fuloong2e.c    | 3 +--
>  hw/mips/malta.c        | 6 +++---
>  hw/mips/mipssim.c      | 9 ++-------
>  hw/mips/r4k.c          | 9 ++-------
>  5 files changed, 11 insertions(+), 20 deletions(-)
> 

