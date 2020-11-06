Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87DBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138AE20719
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpFXKo9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138AE20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb2e9-0000Q7-12
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb2bT-0007bV-5e; Fri, 06 Nov 2020 09:20:35 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb2bR-00020s-GO; Fri, 06 Nov 2020 09:20:34 -0500
Received: by mail-wm1-x343.google.com with SMTP id h2so1589551wmm.0;
 Fri, 06 Nov 2020 06:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bO4JwNgzfLfxGdMgIq4N8FPUJUUU1BWyvxBJwMRwNOU=;
 b=FpFXKo9hd2kma/8h8Oy/1fKAf7+cCLBcx2puq+XF8OMejXgN0WyHVnOFhEM2vtK1T8
 FmHh8zDnNVmXvGrD3gbQ5Uq+ITl+1b9pdgb6Qf4qWcrvTnoKWE/fncJrW8baHB1wN/uM
 lziu4ZkeZE4johUMHC3WQaFpiYEMhWd+g9trLj8FokSAkeK9Ep/ODXRU7wZuaQT48xTO
 krKvtFF4UIuFRxbdZEF8LJIHu96c2zbbiv4DXuru3oy8mogFku+BcZp8Xwqxw/zb4qq9
 4KLH+1qrtBaVf54EFzIv0DFSQR4bqMBYNofimWyr7q6GSaI+JTnX/XfQQsTQed7T7BMg
 3Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bO4JwNgzfLfxGdMgIq4N8FPUJUUU1BWyvxBJwMRwNOU=;
 b=C26lbIQZEwYituyV1URkzRkCcYJP+4fBR7X9XJtc6qwBrKR6YKO97tEqL6Fu0DqNfi
 mu9DLCc+x37spm/WtDQhA497/F8b0ijQeF3Lmr/hXx4lc2nA/Bxtl/AnXtRH4a+XSDYA
 nt7q7wVUF1I4U0wD0UdkkmvjTABI5RM2O2MaptJf1AQVrpPUuVg0gjDhfTYZAEgYm6JH
 xsIcNecWsUpVFLr5x3Ydy/bxp3DiVaTGfNOvMqekLDzCNEw4G68lRQtGQfE+qgpDs588
 Q1UWzCBYrJwvGvwX4F5w3beBys2pAvAN7XSswjMq4vu0HVaATOJ0CjIAdqw37+xdxpPU
 2MKg==
X-Gm-Message-State: AOAM533VDjTPmx2ZVr9M3lH+KG+rIQc0EQfnTmFGjKG/ytxUsH9m4DA/
 0cJYxEceCGsCGoJgujCyKMI=
X-Google-Smtp-Source: ABdhPJy8GG5nj6kuSbHXapX7cA3uavUfmQx34quK9o+rN7jE8j0lBi7RcY0RwIICrCsTv2jzXGV2NQ==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr2724913wmh.41.1604672431031; 
 Fri, 06 Nov 2020 06:20:31 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d3sm2557753wrg.16.2020.11.06.06.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 06:20:30 -0800 (PST)
Subject: Re: [PATCH v1 1/1] hw/intc/ibex_plic: Clear the claim register when
 read
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <68d4575deef2559b7a747f3bda193fcf43af4558.1604629928.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1ef9a373-9c67-d12f-014a-9a88520b9635@amsat.org>
Date: Fri, 6 Nov 2020 15:20:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <68d4575deef2559b7a747f3bda193fcf43af4558.1604629928.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 3:32 AM, Alistair Francis wrote:
> After claiming the interrupt by reading the claim register we want to
> clear the register to make sure the interrupt doesn't appear at the next
> read.
> 
> This matches the documentation for the claim register as it clears the
> pending bit (which we already do): https://docs.opentitan.org/hw/ip/rv_plic/doc/index.html

"When an interrupt is claimed by a target the relevant bit of IP is
cleared." Correct.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> This also matches the current hardware.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/intc/ibex_plic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
> index f49fa67c91..235e6b88ff 100644
> --- a/hw/intc/ibex_plic.c
> +++ b/hw/intc/ibex_plic.c
> @@ -139,6 +139,9 @@ static uint64_t ibex_plic_read(void *opaque, hwaddr addr,
>          /* Return the current claimed interrupt */
>          ret = s->claim;
>  
> +        /* Clear the claimed interrupt */
> +        s->claim = 0x00000000;
> +
>          /* Update the interrupt status after the claim */
>          ibex_plic_update(s);
>      }
> 


