Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F122C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634F822281
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuMLccjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634F822281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWU3z-0004nu-4Y
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 20:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWU2U-0003jZ-VE; Sat, 24 Oct 2020 20:37:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWU2T-0004HV-6l; Sat, 24 Oct 2020 20:37:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id n6so7922349wrm.13;
 Sat, 24 Oct 2020 17:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZabuqZGwm1fVDKwuFzSLyxhNSX/2duX+YmYK6sFRHYM=;
 b=XuMLccjPkNU9QFTeE75BMcT1nN0hN/dzxD9AigWFXAR2kdQdNtYJZdxuwJDR/mxzCo
 8wd/0beJUAnzqscNUrbzmNQyVj2Ue/bhLTM5CBnjZPUv46kOiHbYHbKtvFB++v3bhtId
 AuQkYTmIWbFyWu8FKlzFUCcNdWTVX6/ZDl+12vW7ar0AaWPOSPQjSU/QEyeEufkw0ZS9
 Cg2nl3jJkc4n/BWycHj+6Yy/V+CFyySWVHToB2g6SuEgc9XMmZQ5tFLr2v6oAN18yoy5
 0w7EKJaccaTYkNNkSxfvH7YpDN3L9bBWx8E9vWOOECl9UEDZktfwX3J78tneg+zJwC1n
 JyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZabuqZGwm1fVDKwuFzSLyxhNSX/2duX+YmYK6sFRHYM=;
 b=rntsCeWecjWe5xZS5iOTFcM3WJFrHFkRp1v4CLKnbC97EN3i9CYx7mI8DYsAbcKTcW
 6Bjm2vlhi3JHCxW3VhHMfdfW7VxmQ0X+Jx+Xlzsq6HAbqmjDo4k0GDBgXjlyxx7DvhlK
 4k5rI1JFumBXvP9+3wmbrFQXAuuzPiHKJ/wGCmrdSz8uEfZDPSOH/O/VW0TNYcX1Neah
 UabSoDCZHrcuMnM5uefin14RHw8HQQQpE+/4BAAmYYvoJIRGIMVgTZvxhfN6AaxRxbM4
 Jm1/AP5lSewcxv+5T+JI0RnaSqMKMT/26wqkRdp0NN/SAjFmW/PNjsEzpndRZ2fP0W86
 d9RA==
X-Gm-Message-State: AOAM530rFJ/izH9q/qsGXBUfcMdH2vRFcUEvlsa2DjCdIoZ3zDsa1e/O
 /bkezBrbtGZR4ISw0p3MWfOqfniYlY4=
X-Google-Smtp-Source: ABdhPJxw+iEKq1PKP7Jcq10Ad++GznCNZCSAjHgRAAyXZI0TS54zyAAEvFUrUpkhm+aoqzX78y3QHw==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr9681254wro.328.1603586254953; 
 Sat, 24 Oct 2020 17:37:34 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 3sm12907060wmd.19.2020.10.24.17.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 17:37:34 -0700 (PDT)
Subject: Re: [PATCH V2 09/14] sh4/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20201009064449.2336-1-zhaolichang@huawei.com>
 <20201009064449.2336-10-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8f8483cf-ed90-2ecc-d986-e0d31e928ad6@amsat.org>
Date: Sun, 25 Oct 2020 02:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009064449.2336-10-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Cc: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 8:44 AM, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/sh4.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> Reviewed-by: Philippe Mathieu-Daude<f4bug@amsat.org>
> ---
>   target/sh4/cpu.h       | 2 +-
>   target/sh4/op_helper.c | 2 +-
>   target/sh4/translate.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Thanks, applied to renesas-next.

