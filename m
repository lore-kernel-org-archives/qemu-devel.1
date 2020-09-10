Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE39C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FA12078B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSH6yXhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FA12078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGsE-0005pG-0x
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGGrf-0005EU-GW; Thu, 10 Sep 2020 03:19:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGGrd-0003mB-Vx; Thu, 10 Sep 2020 03:19:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so5495874wrt.3;
 Thu, 10 Sep 2020 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hl9W75JxTDTtLskPt/stSZrsAY40mzT8RpIuh3gAYM8=;
 b=OSH6yXhXOXySEYMz2e8nQsA5/aRUfCHxQiiph3jMk0dLG3cBHNWwuXkbc2SMICOY5H
 xwZ5ZqzKdslIWvJdQ1bzCUdDoPaLyzAlssbhQuieXXWJS14ES22kB8bGI9pLuOh5297p
 kQHHGK2y5LeEQt/wWPachckm679SRbDogtMYdle5OcLxm3QMDxH6rSM0vPLQWUgCyZWJ
 Eii3G+yKHTx/e6ncrGrp58tIXSPnof7u+uoDm7sSxfzpqLq1uwXJsHh960XpzP83E/ph
 DQF+cH3v0bh1s5dW0Byo2UEEJ1/TfSj2u9D9Hl9rLGejgK9xmD3tRK/tSBUGnqIOs0Q7
 wBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hl9W75JxTDTtLskPt/stSZrsAY40mzT8RpIuh3gAYM8=;
 b=NUacJEI9J19CdNo765xOqwT96ajth9QEug4rQOZH4ypO+4fMyzaQJ1bEwJ7uN2Cz+0
 9pXKifXfwfsGWyxmlhQgA60za07kMlJ1+NZNpmb/tpVnZSBfwYet8gCiuhPOh4iq66/+
 NQ71/klqvymTU/c8ncpXYRifzvBlw2m5wkxJkNuEdvrggPU3DtRjodwHwv5ndMryiwei
 YlaCx5O5Rrt/YQXmhXlqpiIi4dt76c9gKNrWgjdIUk08ZG9iXX5Xmu2JQpysVOEHKWXi
 rDrbj5OeVeA9SoEI7TCrGMl/u9twpptocfXhRm87H13V5VF9L37m2fLPzJgRU6pEIqSr
 RE7Q==
X-Gm-Message-State: AOAM530IjvQfaGwA4RfHn63HPq0dOFdcyMrmja02qQ1Sp8a5b8hrsGOV
 LL2jSC1KW/RDnw7cUpBLe5U=
X-Google-Smtp-Source: ABdhPJynJYAqahOqlW1M4HQNVi+fz3NMVKJEMUiGHQWQNGUjdl2cRgamc++QK7Gt7ANdpt3ZGXfbpA==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr8273326wrm.0.1599722363887;
 Thu, 10 Sep 2020 00:19:23 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k22sm7729642wrd.29.2020.09.10.00.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 00:19:23 -0700 (PDT)
Subject: Re: [PATCH 0/4] hw/sd/sdhci: Strengthen multiple DMA transfers
To: qemu-devel@nongnu.org
References: <20200903172806.489710-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f3c4c8e8-83f6-bd56-36fa-41ba5e2f2eba@amsat.org>
Date: Thu, 10 Sep 2020 09:19:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903172806.489710-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 Ruhr-University <bugs-syssec@rub.de>, Prasad J Pandit <pjp@fedoraproject.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 7:28 PM, Philippe Mathieu-Daudé wrote:
> Still trying to fix the bugs reported by Aleksander...
> 
> - Do not send 0 block count
> - Reduce DMA to MMIO re-entrancy by yielding when pending IRQ
> 
> Based-on: <20200901140411.112150-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (4):
>   hw/sd/sdhci: Stop multiple transfers when block count is cleared
>   hw/sd/sdhci: Resume pending DMA transfers on MMIO accesses
>   hw/sd/sdhci: Let sdhci_update_irq() return if IRQ was delivered
>   hw/sd/sdhci: Yield if interrupt delivered during multiple transfer
> 
>  hw/sd/sdhci.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 

ping for review?

