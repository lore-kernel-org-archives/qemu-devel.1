Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E35CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866992166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866992166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdBz-0006lL-KB
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNbfD-0005gy-AP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNbfC-00026F-3V
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNbfB-00025t-RS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:52:22 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 003CD757CC
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:52:21 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a6so9914231wru.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fuxAS+48ViB93xjNQvGzMHTfKn8EG+Eo7PCeAaPkh2k=;
 b=bftaM6FanIy4sM/658riyuuTydYnuCITur0xen5hBzrOoaQN9FfrAPQUFPO+ArAhfs
 HheV495lW6EYdrJkKYnOQJCw4IdJXBYbt6jLoI4lmNY/TmwmiesSGc9HNPBJCUIF886Y
 tOFc3UBsyA2PZu0ZX+FMueRtde658Uhf3mcxDNMrX4LXu01744H0rlA0C4hp5JPkSWTH
 EbS8YeqRNlQpNDtrT67zQFYSLW4YQyUnlt+Gtt9/fEhBKvtjcLzjQBJwTqNlSqFw5V2+
 2gG/Sc5ayqiEMtgAKBdLXJFLJUK7QUoX6RnEQ3O+pcoOhyJjwWVAGN3iVl5rI9BfLvkp
 vXDw==
X-Gm-Message-State: APjAAAVv+k1N9NLWx7hauyxskXvJxIpcGXxFYsvMggLDmwF9Ppf/yea0
 6JP2P0bSXEhAiaqQym2xVLMq/sQaJZ8RbLH07QBSPXMJ4gd5qHf/LZFBsF/MW4zihE707yuXC7H
 2Er001WVWl+UnktQ=
X-Received: by 2002:adf:a50b:: with SMTP id i11mr3693889wrb.308.1571917939548; 
 Thu, 24 Oct 2019 04:52:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxe8IbD6pLdEAxv/denSqwOFwN7ZPOgx7SQ4Rbv3m+lLKmx7QLGY6px/RKyCcoIl6BJ7vw2vA==
X-Received: by 2002:adf:a50b:: with SMTP id i11mr3693875wrb.308.1571917939359; 
 Thu, 24 Oct 2019 04:52:19 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p15sm24499171wrs.94.2019.10.24.04.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 04:52:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55b477b7-877e-954f-2175-ed36fa787600@redhat.com>
Date: Thu, 24 Oct 2019 13:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023154505.30521-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 5:44 PM, Richard Henderson wrote:
> From: Wei Yang <richardw.yang@linux.intel.com>
> 
> Use ROUND_UP() to define, which is a little bit easy to read.
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

^ one is enough ;)

> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Message-Id: <20191013021145.16011-2-richardw.yang@linux.intel.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index ad9ab85eb3..255bb186ac 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -220,7 +220,7 @@ extern int target_page_bits;
>   
>   #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
>   #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
> -#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
> +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
>   
>   /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
>    * when intptr_t is 32-bit and we are aligning a long long.
> @@ -228,9 +228,8 @@ extern int target_page_bits;
>   extern uintptr_t qemu_host_page_size;
>   extern intptr_t qemu_host_page_mask;
>   
> -#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size - 1) & qemu_host_page_mask)
> -#define REAL_HOST_PAGE_ALIGN(addr) (((addr) + qemu_real_host_page_size - 1) & \
> -                                    qemu_real_host_page_mask)
> +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
> +#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size)
>   
>   /* same as PROT_xxx */
>   #define PAGE_READ      0x0001
> 

