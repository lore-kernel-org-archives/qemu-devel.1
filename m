Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A446EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 18:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0927322261
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 18:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaLBKtEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0927322261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUDWX-0000lY-Bm
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 14:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUDVT-0000JR-Fg
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 14:34:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUDVR-00050N-Ra
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 14:34:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id q5so10517202wmq.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o/SmfThFbczct97xncIMCeFPxg9KWeQJlgi2YMprATA=;
 b=SaLBKtEXVE6hqzzoeD9ZU1MrzHSxFzp6bou74y5uSQVwAJotcxUIZ/VfE7o0SpfgXx
 5DKZ3j+zzC9Ic/ldg+Is+q58xqkH9hBSwrOVq3ICxeBAnzrJRPKBOjy4vnbdpjz5VJUT
 dqn8kjhJ05fXicZ1mFhB9QH7Iv70dxYHm80mSshWz5n6xUZdUMkaeifR++Yt5b7CoGj1
 G8rpq165vk6FNfKasuPoMhuo/rdJLRzkAbFTwoXvvvUoStHbjekRw+ANAgpmbK2mvuhU
 zqGyyFucGuVPCcpAFrV9s59Cm/p7D2zyaCcvFVzrWDBQlq0pzMZqSI5Zj7Z1GfL0HaDU
 fN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o/SmfThFbczct97xncIMCeFPxg9KWeQJlgi2YMprATA=;
 b=Qre5GstmsP4/wjNUCgcrb/NBOEjFFb7D9ZkmiEGIihrMqiMC4jeCjMCHvEdgN8I22V
 KOG75bTUSPuHnxDOnio54R0URRpFlLRwV9AJN1RlPkt4O/UlbNZLtqm93FH1xRBi5kZu
 22YKffrZY8NZTQdJx9wlpITPcUpZQSVoesIvtRUoxawmaI+nSHsB2HtyhYCQQ5pZyBwF
 jEFzwN1lyRhIzKAMXQnuUIKCF7i7atF7Qj2XXHwMYulzhaaBTPCS5Tw4eb9l9THq+vbZ
 5C6L50VX8nKdgGCY2rbo2vhct5tcB19yhygybVMz3XPCPvqqf3nLnv65vGpOkkqmXhLP
 SFnA==
X-Gm-Message-State: AOAM531E4Y1vfGiTSDw+NK6oupVSCVmPUokXORdqUGAfVRUzaj7TL+Zc
 4Zc7fzRSpD+z4JK0UCwFsEk=
X-Google-Smtp-Source: ABdhPJzSot15Pthh2vMAOjYG1u9A0fCWM5fOuZnknlIQdQMVY3DbyEdURRJwh83e9c1O6FEAQnus5g==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr3676842wmh.143.1603046048094; 
 Sun, 18 Oct 2020 11:34:08 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id u2sm15043095wre.7.2020.10.18.11.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 11:34:07 -0700 (PDT)
Subject: Re: [PATCH v3] util/oslib-win32: Use _aligned_malloc for
 qemu_try_memalign
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201018164836.1149452-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a80c300f-1a78-e3d1-bc28-2380fd4c7c8e@amsat.org>
Date: Sun, 18 Oct 2020 20:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201018164836.1149452-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/20 6:48 PM, Richard Henderson wrote:
> We do not need or want to be allocating page sized quanta.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Include <malloc.h>; use g_assert not assert.
> ---
>   util/oslib-win32.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index e99debfb8d..29dd05d59d 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -39,6 +39,7 @@
>   #include "trace.h"
>   #include "qemu/sockets.h"
>   #include "qemu/cutils.h"
> +#include <malloc.h>
>   
>   /* this must come after including "trace.h" */
>   #include <shlobj.h>
> @@ -56,10 +57,8 @@ void *qemu_try_memalign(size_t alignment, size_t size)
>   {
>       void *ptr;
>   
> -    if (!size) {
> -        abort();
> -    }
> -    ptr = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
> +    g_assert(size != 0);

"The alignment value, which must be an integer power of 2.",
so maybe:

        g_assert(size != 0 && is_power_of_2(alignment));

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    ptr = _aligned_malloc(alignment, size);
>       trace_qemu_memalign(alignment, size, ptr);
>       return ptr;
>   }
> @@ -93,9 +92,7 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
>   void qemu_vfree(void *ptr)
>   {
>       trace_qemu_vfree(ptr);
> -    if (ptr) {
> -        VirtualFree(ptr, 0, MEM_RELEASE);
> -    }
> +    _aligned_free(ptr);
>   }
>   
>   void qemu_anon_ram_free(void *ptr, size_t size)
> 


