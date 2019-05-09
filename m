Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C64FC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BFB206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BFB206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOft5-0008JR-JQ
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:02:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfrf-0007Ma-Mu
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfre-0005Lg-F6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:01:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOfre-0005Kw-8p
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:01:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so1515900wrr.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qgBIB0/V6l4Z/z7hvFoLu4Xk+3NEiWprenKWM4aXPrw=;
	b=XlYqBwyBJ5u6q5BSgpprKNFp0o0jTgz8zDxhxRgvvONNS2esVdKvXd8q1C8hSSWHLW
	z3MwmPEneTNrLY2gZTo12INpQ5iDR9fnnQ6dzwO51b/pNxvzSTLqYZiNQ6F5P9c1d7X3
	pqs1jAKSUcUthQx5lBOGr4zuIJRA0HfgIkt79NhB11RKuQEOi8qcHMU8XJTndaa4opa7
	vVlxS+zOm6mz3P6gTm6P4D7qTfjgqUxaFeR/5auvpyf8fdXsA6gNTxJWwEd4IzaIZvWg
	XlLrLZJEkBynHwsEX+DwXmbQrm+VMxHxCCXVr3CpQRvOmzLaM+V2qRAt4yC6s3ozUxJM
	HZyQ==
X-Gm-Message-State: APjAAAXS7TwRWdTFpOT6OLt6BT9AWUrFMPoIv+4qVXCeboWjDeTooToq
	TydvrHinWFk/78eN8+QG90AZ3hDk+xU=
X-Google-Smtp-Source: APXvYqwmBh7ndULguF9ccKTodnmZHcj1WssVKD3uXxVkFFFezqsHWYou3gmDixdvmr2Erp+VVM0DKQ==
X-Received: by 2002:a5d:6642:: with SMTP id f2mr2268856wrw.75.1557396080008;
	Thu, 09 May 2019 03:01:20 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	n15sm2337502wru.67.2019.05.09.03.01.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 03:01:19 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190509060246.4031-1-richard.henderson@linaro.org>
	<20190509060246.4031-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e664fd29-8bbc-9197-d503-039bde8aa37b@redhat.com>
Date: Thu, 9 May 2019 12:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509060246.4031-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 11/27] target/mips: Tidy control flow in
 mips_cpu_handle_mmu_fault
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 8:02 AM, Richard Henderson wrote:
> Since the only non-negative TLBRET_* value is TLBRET_MATCH,
> the subsequent test for ret < 0 is useless.  Use early return
> to allow subsequent blocks to be unindented.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/mips/helper.c | 54 ++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index cc7be7703a..86e622efb8 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -915,41 +915,35 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>                       mmu_idx, TARGET_PAGE_SIZE);
> -        ret = 0;
> -    } else if (ret < 0)
> -#endif
> -    {
> -#if !defined(CONFIG_USER_ONLY)
> +        return 0;
> +    }
>  #if !defined(TARGET_MIPS64)
> -        if ((ret == TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
> -            /*
> -             * Memory reads during hardware page table walking are performed
> -             * as if they were kernel-mode load instructions.
> -             */
> -            int mode = (env->hflags & MIPS_HFLAG_KSU);
> -            bool ret_walker;
> -            env->hflags &= ~MIPS_HFLAG_KSU;
> -            ret_walker = page_table_walk_refill(env, address, rw, mmu_idx);
> -            env->hflags |= mode;
> -            if (ret_walker) {
> -                ret = get_physical_address(env, &physical, &prot,
> -                                           address, rw, access_type, mmu_idx);
> -                if (ret == TLBRET_MATCH) {
> -                    tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                            physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> -                            mmu_idx, TARGET_PAGE_SIZE);
> -                    ret = 0;
> -                    return ret;
> -                }
> +    if ((ret == TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
> +        /*
> +         * Memory reads during hardware page table walking are performed
> +         * as if they were kernel-mode load instructions.
> +         */
> +        int mode = (env->hflags & MIPS_HFLAG_KSU);
> +        bool ret_walker;
> +        env->hflags &= ~MIPS_HFLAG_KSU;
> +        ret_walker = page_table_walk_refill(env, address, rw, mmu_idx);
> +        env->hflags |= mode;
> +        if (ret_walker) {
> +            ret = get_physical_address(env, &physical, &prot,
> +                                       address, rw, access_type, mmu_idx);
> +            if (ret == TLBRET_MATCH) {
> +                tlb_set_page(cs, address & TARGET_PAGE_MASK,
> +                             physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> +                             mmu_idx, TARGET_PAGE_SIZE);
> +                return 0;
>              }
>          }
> -#endif
> -#endif
> -        raise_mmu_exception(env, address, rw, ret);
> -        ret = 1;
>      }
> +#endif
> +#endif
>  
> -    return ret;
> +    raise_mmu_exception(env, address, rw, ret);
> +    return 1;
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

