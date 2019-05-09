Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B49DC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2E5208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2E5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOfdV-0007Iy-My
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:46:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfcU-00065H-IF
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfcT-0004Fs-OP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:45:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOfcT-0004FY-It
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:45:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id b203so2391592wmb.4
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 02:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wQ1H6O0Mwu8s2Fe+arsqfjpj7l1as2Lh8PXqKO9Hm10=;
	b=pMZwrT7aq6QsQ1UKQum9nFimcoOpCbGsdaFOjqTRU+jK8a8KSSH6YvM98D5UgVKH8T
	0TOAINBeKPmX7VDhyK1DPxg/9RG142POHGiVZ9TnIzy+4FQwu2kq0SFHNZbb2bUm8+yK
	OgT7Thp1TzxLXC4kqrcrPA9JzGxePhqauWeL/XHVK0EHMmckh686C/Xx61eew/1HKo4C
	gkqAeor9tEJMRoX1JWA0xtYRI7uBOfDQxJrwvXNSN/3D3h/lJIkhrtlRIuKXZOYyemiU
	Tw3LOC8Bt8n3/n+onxa4OtozcRHZv711bfjQwnv6BwncwSTO16fWsY/s8Hj87jxLexy7
	dpvw==
X-Gm-Message-State: APjAAAVTShYeub7mcU0MrJr7f4ii0eaKdijVvYGToodwho+XwazDnYnK
	jazjj1Aoxuc42vnK55stARL14Sr+mS4=
X-Google-Smtp-Source: APXvYqxeO0De6cWpD1MunBAC62SNVkvEtFPb3dKHONTe9C9PRYr5dcB1H3W/Y665dnW7a2zQLv+yTQ==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203mr1474692wme.27.1557395140364; 
	Thu, 09 May 2019 02:45:40 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id 20sm1441441wmk.46.2019.05.09.02.45.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 02:45:39 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190509060246.4031-1-richard.henderson@linaro.org>
	<20190509060246.4031-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7af0bb82-0a4f-ff1e-7554-b9d140dfdc9d@redhat.com>
Date: Thu, 9 May 2019 11:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509060246.4031-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 10/27] target/mips: Pass a valid error
 to raise_mmu_exception for user-only
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
> At present we give ret = 0, or TLBRET_MATCH.  This gets matched
> by the default case, which falls through to TLBRET_BADADDR.
> However, it makes more sense to use a proper value.  All of the
> tlb-related exceptions are handled identically in cpu_loop.c,
> so TLBRET_BADADDR is as good as any other.  Retain it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/mips/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index c44cdca3b5..cc7be7703a 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -884,7 +884,7 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>      int prot;
>      int access_type;
>  #endif
> -    int ret = 0;
> +    int ret = TLBRET_BADADDR;
>  
>  #if 0
>      log_cpu_state(cs, 0);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

