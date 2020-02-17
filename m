Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE9BC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285ED20578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3xtpy2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285ED20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52111 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mDO-0006KP-C8
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3mCi-0005Ch-H3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3mCh-0006o1-IN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:37:16 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:38422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3mCh-0006nc-Ch
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:37:15 -0500
Received: by mail-pf1-x431.google.com with SMTP id x185so9425865pfc.5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8ci84h4Xvpwk7pAYfAxAKKlR5HwCF2Jf9E8+nZL5kSg=;
 b=l3xtpy2p2zqRNWFiX4ZzeoR1xKrB5zngE8Q4Z/eylt06ryDKhUaS67OcxhEprqFhxP
 FuDgd3UXdCkZiOjuOJO0ew3+eUSw+20/DH49CVpfrnJlvcfPcbl31r8taVgXGF3jAjDB
 hZoSR/C9swwuv5sevMnBkNgpMejZD+YrPCFRapzZFA16LRKXqFXb6TRJCVGT7HTrkxpn
 /d6DseiKu71VKCvUoE+79zPUoQjTVqyuYlfiCZlPYk7tZOiz/+0xIad9K58W5WMU0wEq
 GMi1zgSTUVq8N5TDYmu89xeNyQrF//xyDiuvD2igKYpU0OMu5/5C8ODgitE7K65PVTNn
 8A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ci84h4Xvpwk7pAYfAxAKKlR5HwCF2Jf9E8+nZL5kSg=;
 b=r1aTBEbBiE3XE9TKXkgVsZSIIk0pWvTH1Mrr4lB6y281rIptj9NIHDvZu5RKElpc0T
 ph3QokXhbLPoapukXNDBq2CnkuZDUsa9KeX+9+Rym5eceFurCL7mrr+x+EbNA0BX+/be
 MvU5KTgjBa8DVqhwLweDkt8fnaoS3Zi3AoxFOCpd/gpVM9whWl6z5Zm+bl+rph+zyHXC
 LU2kTEeC9D7UsVMLCGmuoL1y1gorwJ0EB8VcaYjUaKh9i/YuWAIRNcL8Lx+mqw57WORL
 bSOeZuonddsca+EArmFL2iFnObwgmvM2jUyrZDGURqt+BlpQa+Wz5bmdPN+dtXu+ORe4
 F+pw==
X-Gm-Message-State: APjAAAXSaU6vnTEGRGwwGc03r3zB0SDVjz4cjNemA3sffesYPjkZ94Ff
 4e8JCRShrK+/9YA1E6Ot/iIdlQ==
X-Google-Smtp-Source: APXvYqze/2fGaEODEh3YOkSLCa8QqWfKTjI4xeO9uE8R2O6X7y77T1d6OQvRXMVq3O5ve1lnbkj0VQ==
X-Received: by 2002:a17:90a:7d07:: with SMTP id g7mr713631pjl.17.1581968234122; 
 Mon, 17 Feb 2020 11:37:14 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r3sm1222024pfg.145.2020.02.17.11.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:37:13 -0800 (PST)
Subject: Re: [PATCH v5 64/79] ppc/ppc405_boards: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-65-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4785e2b8-ce6d-b060-c130-918722feea35@linaro.org>
Date: Mon, 17 Feb 2020 11:37:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-65-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> @@ -439,18 +439,16 @@ static void taihu_405ep_init(MachineState *machine)
>          g_free(sz);
>          exit(EXIT_FAILURE);
>      }
> -    memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
> -                                         machine->ram_size);
>  
>      ram_bases[0] = 0;
>      ram_sizes[0] = 0x04000000;
>      memory_region_init_alias(&ram_memories[0], NULL,
> -                             "taihu_405ep.ram-0", ram, ram_bases[0],
> +                             "taihu_405ep.ram-0", machine->ram, ram_bases[0],
>                               ram_sizes[0]);
>      ram_bases[1] = 0x04000000;
>      ram_sizes[1] = 0x04000000;
>      memory_region_init_alias(&ram_memories[1], NULL,
> -                             "taihu_405ep.ram-1", ram, ram_bases[1],
> +                             "taihu_405ep.ram-1", machine->ram, ram_bases[1],
>                               ram_sizes[1]);
>      ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
>                    33333333, &pic, kernel_filename == NULL ? 0 : 1);
> @@ -546,6 +544,7 @@ static void taihu_class_init(ObjectClass *oc, void *data)
>      mc->desc = "taihu";
>      mc->init = taihu_405ep_init;
>      mc->default_ram_size = 0x08000000;
> +    mc->default_ram_id = "ef405ep.ram";

Cut and paste error on the ram name.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

