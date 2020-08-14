Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D65C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E83020771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNRRIfaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E83020771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e2H-0006DJ-Ln
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e17-000519-Sv
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:01:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e16-0003lv-64
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:01:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id f12so9066202wru.13
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Zls6EdTy6Z2QsaIfy2W7iRMrRgmvLmgC4RKZKLFouxo=;
 b=hNRRIfaXjUZ/5mDt/bzZ7aOqesWGWkM9y9QaG1RBo8Tx7Vw5L4iG11XvhErb9PA/iN
 2+r0/H0eqcoQ1XuB8NjN3tPHjmGcuHdO+Wr9RNFN3KuSLM8PdERghOQjvXFIgAEdAihd
 Nj/Ap2azNeTtg7aBTNTg1aVncyvy+rVvB8lCnUT89+ZHZXQ8H1p6R+D5XmUhfmfcNca5
 aj24/Iyid7mgIp+KE7k809+6+d0D3dcXXcl5C1SQWlgBItDSaXl72znZIcbOQZYy9doH
 7l1eLimA3JT8hfhPCaRoWuYBj9qTfa2D/fpYfua66Qz2wLJczVqCDrkSpGP9CcFukUpW
 C/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zls6EdTy6Z2QsaIfy2W7iRMrRgmvLmgC4RKZKLFouxo=;
 b=A+mbAUIoiy0hPEJv2HhWEM6xUOwySDfRBeJSIGcDd8E4B2TQuUnRnPceVjAaSKeMTG
 3KBIwTMwEdaw9vYsNukxRQLfojBz5UZ7qKg3xkLrsFFjUmGDvxmIXYWY1hUyvC17LrV2
 KRXPKvgbm5jg6Aci6VKUQxG95eQa4ivsW8CVTQ508Hw6B6/KicRIxu72mIalqqOINVFP
 rkQMrqIOFpdC+kpMUk2OMnw+oyGm9gFdX8fvw8aJon+phI+XrkKaBkCrxk2ERMgPNht+
 6uxaJwDC+jVyWp3XN0yi+CgsC2QWIxcXXxqLCSoKae+LBC0Upv3tQi5Iv1yvAu74LXn4
 fccQ==
X-Gm-Message-State: AOAM533ZC68uJlO5AJvKKqyfo7SU5fb7ZvJCda/buJqjDYVEEIvfi1l5
 HA57m5C0e8IY7763N1kmWws=
X-Google-Smtp-Source: ABdhPJzXoiDlIn9KWeg0+3bHYN6vfqNuMmfpqOGRfgX/ejCbv25XwzAwjR3v6K1ZyXZL9AYaSG7nqw==
X-Received: by 2002:adf:97d3:: with SMTP id t19mr3547603wrb.138.1597428082909; 
 Fri, 14 Aug 2020 11:01:22 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h6sm16911761wrv.40.2020.08.14.11.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:01:22 -0700 (PDT)
Subject: Re: [PATCH 15/41] tulip: Move TulipState typedef to header
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-16-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9892cdec-f4df-b512-dab9-4aedc9c79698@amsat.org>
Date: Fri, 14 Aug 2020 20:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-16-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 12:25 AM, Eduardo Habkost wrote:
> Move typedef closer to the type check macros, to make it easier
> to convert the code to OBJECT_DEFINE_TYPE() in the future.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/tulip.h | 1 +
>  hw/net/tulip.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/tulip.h b/hw/net/tulip.h
> index 5271aad8d5..c3fcd4d4e1 100644
> --- a/hw/net/tulip.h
> +++ b/hw/net/tulip.h
> @@ -5,6 +5,7 @@
>  #include "net/net.h"
>  
>  #define TYPE_TULIP "tulip"
> +typedef struct TULIPState TULIPState;
>  #define TULIP(obj) OBJECT_CHECK(TULIPState, (obj), TYPE_TULIP)
>  
>  #define CSR(_x) ((_x) << 3)
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index 4487fd61cf..ca69f7ea5e 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -18,7 +18,7 @@
>  #include "trace.h"
>  #include "net/eth.h"
>  
> -typedef struct TULIPState {
> +struct TULIPState {
>      PCIDevice dev;
>      MemoryRegion io;
>      MemoryRegion memory;
> @@ -44,7 +44,7 @@ typedef struct TULIPState {
>  
>      uint32_t rx_status;
>      uint8_t filter[16][6];
> -} TULIPState;
> +};
>  
>  static const VMStateDescription vmstate_pci_tulip = {
>      .name = "tulip",
> 


