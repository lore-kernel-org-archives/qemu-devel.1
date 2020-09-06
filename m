Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF35BC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 10:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6E920C09
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 10:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvDq276t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6E920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEri8-0002Zi-PD
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 06:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kErhF-000207-J1; Sun, 06 Sep 2020 06:14:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kErhD-0000VE-PB; Sun, 06 Sep 2020 06:14:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id o5so11592840wrn.13;
 Sun, 06 Sep 2020 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vbn0+Q7LLK7QzYKdUg/R1tO/MQuDY7rPs11ACzEAzzI=;
 b=TvDq276tTfUKBvltXAUaiZSNlA2PCAiC10ufGIXIRJN4MvwciazeBLX18v+ckw26s8
 cAavwzIueebv3iVDa2/7GnskLMlrTPXZSZfQ0LqNZyZMEfpwFvueJ8W7xcXCwKHgbBte
 NHuB2qE08Txveh/s3fPMdMPkR+q+8BeBFk+p8cfIPjXd+h6koYJsCAxTxzcmfZbXOqol
 aV4mPqeot8pLRnrbdcBMNCaXAV5qe9/9i6T2Ww66h+6f1FlgP+4ggk5EWID05n4OkInz
 hcs0zBcpeaWsvUj6y801j49vKgq2ulnu/67UAduRrF9XXrxbIK2SRZxAZxB7pmfK0rgm
 MzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vbn0+Q7LLK7QzYKdUg/R1tO/MQuDY7rPs11ACzEAzzI=;
 b=EYUIy4zaP6WGWIXnKw9c5WTjdW+7XfEFdgk97P643A5dJepnB/4XL+nhdMza89S6m8
 3wR6gU8gUk5rC+pYWKKqnwWFp821kzYeEdpxzofshi830Lefh8dW782C/M5r8I1wIqEC
 IEL8DZAIcurTPmu2jznbV/4qrKUxLOlIxbH4VQrcPv5hrEGUTWUEiYiZLKDY8NuTBtOt
 JyDybcg0iiFwj1HOYSWIGR45MAL+kYb4S2Hci+cQiyM/tEBD8BbIZgmY3TP9oQDgrJSx
 rYwlJ+AqLZwdOLrpZqJ/wg7SSa44gd3Twdgu1HVTRbwFh5LmvfnB3plvviDl/6unL5ib
 91Pw==
X-Gm-Message-State: AOAM5338NDFOZLdugdfDlnfQ6ntsuSb93sRS/bDRjeQWzwSyUxIaTEEh
 KRaTfjzqULE5XVsbwDVJ827yJdNPMqE=
X-Google-Smtp-Source: ABdhPJxthR0Pc9eFwoKNkI0qdEttRVddukb+H+ipb91q6m/h8yz1n18cESopH+e/Qod7lxjZMpgRYA==
X-Received: by 2002:a5d:4bcf:: with SMTP id l15mr16088849wrt.384.1599387289625; 
 Sun, 06 Sep 2020 03:14:49 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y1sm21736079wmi.36.2020.09.06.03.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Sep 2020 03:14:48 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] hw: hyperv: vmbus: Fix 32bit compilation
To: Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
References: <20200715084326.678715-1-arilou@gmail.com>
 <20200715084326.678715-3-arilou@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <87028ae2-f31e-a6ee-a4ba-c147837fc52d@amsat.org>
Date: Sun, 6 Sep 2020 12:14:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200715084326.678715-3-arilou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: mail@maciej.szmigiero.name, QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, rvkagan@yandex-team.ru,
 pbonzini@redhat.com, imammedo@redhat.com, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@

Can we add the commit description Richard wrote?

---
Fix 32-bit build error for vmbus:

  hw/hyperv/vmbus.c: In function ‘gpadl_iter_io’:
  hw/hyperv/vmbus.c:383:13: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
  383 |         p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
off_in_page);
      |             ^
  cc1: all warnings being treated as errors

Fixes: 0d71f7082d7 ("vmbus: vmbus implementation")
---

On 7/15/20 10:43 AM, Jon Doron wrote:
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  hw/hyperv/vmbus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index 34392e892a..c28bb4201b 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -383,7 +383,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
>              }
>          }
>  
> -        p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
> +        p = (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
> +                off_in_page);
>          if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
>              memcpy(p, buf, cplen);
>          } else {
> 


