Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95868C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662E920769
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwrHYwhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662E920769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYOos-00077k-Hz
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 02:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYOnW-0003rm-S0; Tue, 12 May 2020 02:53:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYOnW-0003un-5R; Tue, 12 May 2020 02:53:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id z72so12353685wmc.2;
 Mon, 11 May 2020 23:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VzLlK543jZw8z23/LK+Fd553H/vt953iqs0D1un348Y=;
 b=AwrHYwhsig95de9WPn6ozC3d0JJ4ANpXuSjQhfelXUTB5PkeNDk9VvCofamoZ+yfCP
 jaHrt+3+7Kscr8GmX7kEvf8a7PjiMLq1qedtuMuk9ANMzqvGDxxcyXBe66Tvdx9xCZMy
 LNx6QDKv2XCzG+8hlYLxwgewCvfFcKC8v+Y4e0BwQbk+XNsyfL+S/+rK2+id088RL6uB
 7xJbh4wM/5XOfKJ9ML+R+sUBhnM8qIu2IIS8ic9m50r5p+FVSDIk7W+SSC1rbsAnM+Oy
 wl3RJJBEk4c/pJLzYpWGpizn0DbuWSB1f3hFD3P7Hmbxp7kxotR15auLiIYuSIZAxfvS
 sxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VzLlK543jZw8z23/LK+Fd553H/vt953iqs0D1un348Y=;
 b=i/flagBw400f8fPiklWBIyySstijYJp9hVcF3pOlAx9J12tsvS/5OVaHctNn7Yp3b2
 9PYajXlpE8TEHGUqXEa45b/B5MK4q/6P9w3SK78X3Y7b8KPwRSAwSO6gXzjUCIU3Wm1W
 HhdpfMtxNm6KVfmi0Zq7JrLctOcs4kqcb2OSZ4bDzHHO1WigJ6ajMhqAkgcDB3qHlOB4
 78XdARsrmjDKZ0NDq7R7wAimwPuhCSiiD05RjztIC46+5BZWEG5vwa6UJcLN2R3nTP0s
 t0YiyYA684juiQa9+NhWcFqlS5aBVGEZxG4OZW8zDAUYaEfrAneP/9icpM0Jk1vLckHd
 tkFA==
X-Gm-Message-State: AGi0PuaxSIV7lZU51ZfZTJZrqv81dQnCJulF4MOFskyus7FE/1hJf/Ct
 xfyrRTYJtleSHwHtYN5FbATnXfiVTy0=
X-Google-Smtp-Source: APiQypLfQkPM6xa7U7i9+X3247iDd+8JlEu8z5zteSbQ8JVg5PrIuMGW3wTcv0vvELs41ZajEMpbkw==
X-Received: by 2002:a05:600c:22d6:: with SMTP id
 22mr35421747wmg.121.1589266428178; 
 Mon, 11 May 2020 23:53:48 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h11sm879104wrt.18.2020.05.11.23.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 23:53:47 -0700 (PDT)
Subject: Re: [PATCH] hw/ide/ahci: Log lost IRQs
To: qemu-devel@nongnu.org
References: <20200504094858.5975-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4bec74b-8236-266b-8d49-51fd10798dbc@amsat.org>
Date: Tue, 12 May 2020 08:53:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504094858.5975-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 5/4/20 11:48 AM, Philippe Mathieu-Daudé wrote:
> One might find interesting to look at AHCI IRQs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/ide/ahci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 13d91e109a..fc82cbd5f1 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1509,6 +1509,7 @@ static void ahci_cmd_done(IDEDMA *dma)
>   
>   static void ahci_irq_set(void *opaque, int n, int level)
>   {
> +    qemu_log_mask(LOG_UNIMP, "ahci: IRQ#%d level:%d\n", n, level);
>   }
>   
>   static const IDEDMAOps ahci_dma_ops = {
> 

