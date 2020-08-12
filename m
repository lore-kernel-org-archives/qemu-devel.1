Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C64AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D267620774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRSR+B+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D267620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vvI-0002Hu-3l
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5vtL-0008Kz-Sg; Wed, 12 Aug 2020 14:54:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5vtK-00051B-D8; Wed, 12 Aug 2020 14:54:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id f1so3035593wro.2;
 Wed, 12 Aug 2020 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dxAExs3eG8Wiz2w/0qPoftcsX8vyKKdMXw++FjakOPk=;
 b=LRSR+B+mhYF83SM0LAVcUvQz2AqtGJkMQXFdgAMj/HAIaYdjqeWOZ55esijc3VX1tU
 HI4en9VjscOVmYuqNOtdSJymNWYo8a4nXxJYG0z1EfarQEPr1guW//hvwzu7qqQ1RSb6
 9yuL+C86eVz3HYeqvTSrEfKvGUL2pHq1VaLpiP0qW0RjoflE2sjhAKNlhqpKrvh++5u1
 BSvoM3lwgfFxTcMPRAPsiMfrxyf4w61qekpo5ngA4uN3RrfjZshRlLD8czixRVg4BjSS
 HANeMhodroYBVKaywFWq2NgYOMcaQFBXY9uh8MYgIyUC7atakj0NkorxNeKLD62N/zpF
 btPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dxAExs3eG8Wiz2w/0qPoftcsX8vyKKdMXw++FjakOPk=;
 b=p8fDZAmtfRwC+Wl4DwkVu58AtomFHI9w5BxE2+PweExU73F2TcmHFPXtdRi5tJWSNv
 EgrAWVpJjNDb2uDxknR9sargSQaSpiaWT40AmbVQwc7ip7H55l/e/Bur5mjp87cOLjRy
 FF2HBvJ2ula12lC30x7DrTXs/0DNT7LM9ETtWsE1g0eagLZD1uxhskVDtUiOkMsDEuLy
 yn+XYN5/1up9bkfP6ICdElENsmEa9Arg7zQQfUgN4kUpBXmnIPXjqa2dvqi9Awi8ioNu
 fBQV+eN56elliLNT9Qo/CeFRlhrTnJsjRA/QpEbqGpi993V+87rgeYJ+a+Ft3yDByoSK
 quOQ==
X-Gm-Message-State: AOAM5324PEPAih4HbpAm9G2p/V9CErKOTHq7fEZZF2T62wOdbi7WwLlx
 QWQGdOOG7DSz/ghEpCn2yoVQMEQQ
X-Google-Smtp-Source: ABdhPJwqW89fKcEmbMkdxaAU7wTQyaW+e70J9cViLOKN0lNTbrhFGjjAiypZIWCGHYf5OOgy2bCa4g==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr522709wrn.65.1597258464583;
 Wed, 12 Aug 2020 11:54:24 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j5sm5524243wmb.15.2020.08.12.11.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 11:54:23 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] hw/intc: ibex_plic: Update the pending irqs
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1595655188.git.alistair.francis@wdc.com>
 <0693aa700a4c67c49b3f1c973a82b257fdb7198d.1595655188.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ad0ac0c-8a78-9c49-d48c-b46556cbf0bc@amsat.org>
Date: Wed, 12 Aug 2020 20:54:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0693aa700a4c67c49b3f1c973a82b257fdb7198d.1595655188.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/20 7:34 AM, Alistair Francis wrote:
> After a claim or a priority change we need to update the pending
> interrupts. This is based on the same patch for the SiFive PLIC:
> 55765822804f5a58594e "riscv: plic: Add a couple of mising
> sifive_plic_update calls"
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Cc: Jessica Clarke <jrtc27@jrtc27.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/ibex_plic.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
> index 41079518c6..578edd2ce0 100644
> --- a/hw/intc/ibex_plic.c
> +++ b/hw/intc/ibex_plic.c
> @@ -121,6 +121,9 @@ static uint64_t ibex_plic_read(void *opaque, hwaddr addr,
>          s->pending[pending_num] &= ~(1 << (s->claim % 32));
>  
>          ret = s->claim;
> +
> +        /* Update the interrupt status after the claim */
> +        ibex_plic_update(s);
>      }
>  
>      return ret;
> @@ -140,6 +143,7 @@ static void ibex_plic_write(void *opaque, hwaddr addr,
>      } else if (addr_between(addr, s->priority_base, s->priority_num)) {
>          uint32_t irq = ((addr - s->priority_base) >> 2) + 1;
>          s->priority[irq] = value & 7;
> +        ibex_plic_update(s);
>      } else if (addr_between(addr, s->enable_base, s->enable_num)) {
>          uint32_t enable_reg = (addr - s->enable_base) / 4;
>  
> 


