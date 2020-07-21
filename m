Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEF2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F99206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT8G6Brg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F99206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxwB4-0006uF-P7
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 13:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxwAK-0006GO-MK; Tue, 21 Jul 2020 13:34:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxwAI-0008NW-Gz; Tue, 21 Jul 2020 13:34:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id q15so3630887wmj.2;
 Tue, 21 Jul 2020 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QVq+i3UG96JuGFAhhqsCmWBy6uZORelPSH3xeO/Fkfg=;
 b=fT8G6BrgLjANg9TYc1JZtY5kYpFLCTsb72vE1anxJ3wiAW43niBkf5ffApsGsjjnTc
 ybs9IuN5dO8hz0xmO0f0rjtTwrc52J4/3cc7056sg2evHguYMVbeTa8ghTbWG/B9UXXN
 yPjQhQgPuRTQLp0NT6Uc0p/JjZ1n+iNb6zUld0mhbNHjtneCbGDkOQLStFmWre6soHNk
 Bbb3VkG8RE9YiIvR9uZVq4Bn1rKy/AqZEicicvRleJsdqOe2rZPf6AcDzl23GDLZDO01
 h/O/PQnmW52qNbqpSe44htLaLzyuYG5PXQ6vDaoR5Cgy8mAva8pTV9k9RowMP8ndIgpQ
 maig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QVq+i3UG96JuGFAhhqsCmWBy6uZORelPSH3xeO/Fkfg=;
 b=N+U0Q4TiE+KosoSEH4Zw0G/7+ybDzvZOHCYARaO+8usutiI8aE3nX4bRRJ3tq/4B//
 AKDnT2UnjEpfwI79yj/eOskK7/fm6qI3JQHbvXPTCBD1aob+9bRf9hLBQnekxu8hioLM
 59xsmZUTC07Kmp/La4BCc/p7hCPP0U3OE54RURE9CHMDb6E8hbMXs5VJKUPXGkkmPTu8
 fcQwTd6OEqworCZ/FMUMUHHw6T4KcPFBZkW1qmebyP4WoYaW961WSYGZvvNrk1dGX4YI
 MCZPlaJHAy9mZ0xy3MyAszVDyyOqICKJrjrgafX16nJCHrNV5rxmuCx1z8VlgWvfZ0nh
 yATw==
X-Gm-Message-State: AOAM532a+owtecrD1X+h3Nbaj4EXnh9dVtTXz6m6XfPQ6QTE0iDYAeGj
 pWgCFjFcSQlRjcDBDYWh+9I=
X-Google-Smtp-Source: ABdhPJwxkMsOSQ7+aqhVBFU+sOGzclTDup8C41sxCl0S6wg9AjA350BJJ76azp1XBu0y+WDt+eIFAQ==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr5325788wmb.185.1595352892134; 
 Tue, 21 Jul 2020 10:34:52 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f197sm4474662wme.33.2020.07.21.10.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 10:34:51 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] hw/ide/ahci: Do not dma_memory_unmap(NULL)
To: qemu-devel@nongnu.org
References: <20200718072854.7001-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a922c0ea-b836-8578-5772-f2d1736892b9@amsat.org>
Date: Tue, 21 Jul 2020 19:34:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200718072854.7001-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/20 9:28 AM, Philippe Mathieu-Daudé wrote:
> libFuzzer triggered the following assertion:
> 
>   cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
>     -nographic -monitor none -serial none -qtest stdio
>   outl 0xcf8 0x8000fa24
>   outl 0xcfc 0xe1068000
>   outl 0xcf8 0x8000fa04
>   outw 0xcfc 0x7
>   outl 0xcf8 0x8000fb20
>   write 0xe1068304 0x1 0x21
>   write 0xe1068318 0x1 0x21
>   write 0xe1068384 0x1 0x21
>   write 0xe1068398 0x2 0x21
>   EOF
>   qemu-system-i386: exec.c:3621: address_space_unmap: Assertion `mr != NULL' failed.
>   Aborted (core dumped)
> 
> This is because we don't check the return value from dma_memory_map()
> which can return NULL, then we call dma_memory_unmap(NULL) which is
> illegal. Fix by only unmap if the value is not NULL (and the size is
> not the expected one).

Maybe worth mentioning it was hidden before but got revealed by commit
77f55eac6c ("exec: set map length to zero when returning NULL").

Cc'ing commit 77f55eac6c's reviewers.

> Cc: qemu-stable@nongnu.org
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: f6ad2e32f8 ("ahci: add ahci emulation")
> BugLink: https://bugs.launchpad.net/qemu/+bug/1884693
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ide/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 009120f88b..4f596cb9ce 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -250,7 +250,7 @@ static void map_page(AddressSpace *as, uint8_t **ptr, uint64_t addr,
>      }
>  
>      *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
> -    if (len < wanted) {
> +    if (len < wanted && *ptr) {
>          dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
>          *ptr = NULL;
>      }
> 

