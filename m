Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70779C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 20:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A00320720
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 20:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If2hmNbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A00320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyihi-0007Uy-FQ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 15:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iyigw-0006yb-5C
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 15:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iyigv-0002Fi-7H
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 15:51:34 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:41771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iyigs-0001wG-Us; Mon, 03 Feb 2020 15:51:31 -0500
Received: by mail-qv1-xf42.google.com with SMTP id s7so7500745qvn.8;
 Mon, 03 Feb 2020 12:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fgOz3cXcpU3JCTQclBWX5iX+7k+RaGgpydNnyDbxK54=;
 b=If2hmNbgsJTQotCcKIrSfyY/d/GtzDE6j5jJgOHFrnHUBdgKR7AzX08ThGFlCkd2ww
 SC4vp61WS08DfT0lwYGFlCnLiGO7rsw85SxSpjYzXsqIiwF3pxGQ0QrtkSiermky2LSi
 FAgCHFCvBY44xQdAxcv2lwoSlaxdXUEWKYGjWA0/AEYEcUB+h2XqXodEdlA5uay3JfeD
 njUQXXhwWAcqq7dGMJ16vLSKWVz3wSpgbW4lyl8KosutaH/tsgk8FDOywjVLJcfuRV6y
 ZBje2ARHMG3LQ/m0FNyt39JXe/eMeySaDZQ0aFKDhO3a/Gvw9UGMRJ/TV3AMqP43XwSp
 JfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fgOz3cXcpU3JCTQclBWX5iX+7k+RaGgpydNnyDbxK54=;
 b=JaKg3ywPkFSg1KvHw5sG433nLBXFw98vNUeni9/a4i3/atWsLCVEfEE21O/bZJpwiV
 0RBEzVBuZug+inHYSqTcWhUHHx9OM0oXhI/4dijZp8bxvLtOfpSszBxqBFxgu2UA+P+Y
 IgTNuDAbQ1ToEZg0EHGO1TgLmA/MbOfjESKFbv9aa6VDrFSzxHraWY1yM4wQu4LqEL1y
 eXNOsD7j/h7AoJrft9hGmB/8Z7e7Ic28chJ6RdmrXRiFV8QPQ5zR7TqKR85gB2lMMUcD
 avTIm3v1N193yrpw/NDXFEFhtB60QHl/mMPHbuSPf3QJPReqkfjn2Wf18HJAWDWg3DQw
 kEAg==
X-Gm-Message-State: APjAAAWemK6TMYLaaivcOLIHqZnYWk1fAodIDQrWLB2hcz00FV4lGAfH
 ETe85uAzDvaHtxyy5Hg8SZYyVPWS
X-Google-Smtp-Source: APXvYqw3+364DwQ1MUBu2NFmfO5lzBUlTuXFT/QRAn1sJt3JO/v2qeX+dDzSFK3qOGxoOMc86pzY3Q==
X-Received: by 2002:a0c:ea92:: with SMTP id d18mr24574059qvp.201.1580763089968; 
 Mon, 03 Feb 2020 12:51:29 -0800 (PST)
Received: from ?IPv6:2804:431:c7c7:c177:887c:ce1b:6a44:15ec?
 ([2804:431:c7c7:c177:887c:ce1b:6a44:15ec])
 by smtp.gmail.com with ESMTPSA id e13sm10584606qtq.26.2020.02.03.12.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 12:51:29 -0800 (PST)
Subject: Re: [PATCH qemu] spapr/rtas: Print message from "ibm,os-term"
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20200203032044.118585-1-aik@ozlabs.ru>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e3e2311c-8a34-d395-9ae0-c104d3a224a0@gmail.com>
Date: Mon, 3 Feb 2020 17:51:26 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203032044.118585-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/3/20 12:20 AM, Alexey Kardashevskiy wrote:
> The "ibm,os-term" RTAS call has a single parameter which is a pointer to
> a message from the guest kernel about the termination cause; this prints
> it.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   hw/ppc/spapr_rtas.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>


> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 883fe28465e6..656fdd221665 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -345,6 +345,13 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
>                               target_ulong args,
>                               uint32_t nret, target_ulong rets)
>   {
> +    target_ulong msgaddr = rtas_ld(args, 0);
> +    char msg[512];
> +
> +    cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
> +    msg[sizeof(msg) - 1] = 0;
> +
> +    error_report("OS terminated: %s", msg);
>       qemu_system_guest_panicked(NULL);
>   
>       rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> 

