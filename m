Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C928C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB3C20717
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB3C20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ1fA-0002fz-3L
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43474)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZ1eI-0001p3-0j
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZ1eG-0000Gw-Tx
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:18:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZ1eG-0000FT-OL
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:18:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so164759wmf.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 16:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m7c/T4XZJbiCJmShp9krjgw/TiJchf5wAljr6fmh1dM=;
 b=hUKU4DywQNdrObtYv7uwE1K8kRa9vGziFDIrffLuSj/R1LCjWRb96ypYj3Ggo5R7P0
 0AibBijsmbHKqllm7P0x3c5TAOz+9MLDhCUznC5cycBSpqCNnjEvqkQaKFaXFDAI04rB
 wDK5AxrMG/jfYnJgMgQ2t1Wc50JTpXNotaEhiwhFFpZGC1qYX6My5lB4eS/c3bVR7s9N
 JMhw+tcBUYg/967UXfqu7lKGyGyB5pFIULVrGCpoXMX+ryOH4U8sePJWgE6p/CZAlw4B
 zxhAz8z4fr19+zsw88S+HiuM4SnAq+lgN4+NILlm/tGrhzFK9hxx9lvwIheiHSdGe0aI
 gFQQ==
X-Gm-Message-State: APjAAAV3xtTB3PFrFclHRS8wVxbyg+oYbkyao6uMLIG8BNbAI2aa5vCz
 5vLqj9MuVQTEKTPSjg+fWwNpOQ==
X-Google-Smtp-Source: APXvYqwtTgAJ51bOg+1PhJ1T9jrlA/CKCnnxCxBiREYEg/Hj3P9VKY+NB4si3zv1VigtouyULcnKJw==
X-Received: by 2002:a1c:2e0a:: with SMTP id u10mr1664555wmu.92.1559863099525; 
 Thu, 06 Jun 2019 16:18:19 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id y9sm2844235wma.1.2019.06.06.16.18.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Jun 2019 16:18:18 -0700 (PDT)
To: Lidong Chen <lidong.chen@oracle.com>, qemu-devel@nongnu.org
References: <cover.1559761541.git.lidong.chen@oracle.com>
 <00742cd052c0b66e8da0b6b684cd460d6a051175.1559761541.git.lidong.chen@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7861c01a-c658-e777-634f-9d299b7abbaa@redhat.com>
Date: Fri, 7 Jun 2019 01:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <00742cd052c0b66e8da0b6b684cd460d6a051175.1559761541.git.lidong.chen@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [Qemu-devel PATCH v2 2/2] util/main-loop: Fix
 incorrect assertion
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, liran.alon@oracle.com,
 liq3ea@gmail.com, armbru@redhat.com, darren.kenny@oracle.com,
 marcandre.lureau@gmail.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/19 9:15 PM, Lidong Chen wrote:
> The check for poll_fds in g_assert() was incorrect. The correct assertion
> should check "n_poll_fds + w->num <= ARRAY_SIZE(poll_fds)" because the
> subsequent for-loop is doing access to poll_fds[n_poll_fds + i] where i
> is in [0, w->num).
> 
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Liam Merwick <liam.merwick@oracle.com>

Ah, so this is not a plain "v2 RESEND" patch of
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00636.html
since you added Peter 'Suggested-by' tag...

> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>

... but then you dropped my 'Reviewed-by'. Assuming this is a typo, and
since there is no logical change in this patch with the previous one,
here it goes again:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.

> ---
>  util/main-loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/main-loop.c b/util/main-loop.c
> index e1e349c..a9f4e8d 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -422,7 +422,7 @@ static int os_host_main_loop_wait(int64_t timeout)
>      g_main_context_prepare(context, &max_priority);
>      n_poll_fds = g_main_context_query(context, max_priority, &poll_timeout,
>                                        poll_fds, ARRAY_SIZE(poll_fds));
> -    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
> +    g_assert(n_poll_fds + w->num <= ARRAY_SIZE(poll_fds));
>  
>      for (i = 0; i < w->num; i++) {
>          poll_fds[n_poll_fds + i].fd = (DWORD_PTR)w->events[i];
> 

