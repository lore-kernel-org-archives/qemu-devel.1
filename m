Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F60FC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 22:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D2C2073B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 22:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8w2r6h0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D2C2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji3cf-00056G-La
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 18:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ji3bQ-0004DM-BX
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 18:17:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ji3bP-0007pe-4V
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 18:17:16 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so13522956wmh.4
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dhAoQWd9q7mQwrIw9bX6sg077JGQFpVoRyJHO4h4AA0=;
 b=h8w2r6h0StQfeJVpLsunKBh5GbLO4MVAHyMMKMnODkg94/LOytnG6x0mrTBLuftG6B
 0u/Kq9C7uT11U+H2RsOo3/TH70kxjlhUbF6lHM75HMPY+v4LupUBgEhTUITvXvWnxKnB
 iPI281k/DSl6L3T6tC5t8j/KVbeDMUIcSkxN60S1qLPLXoSm/+rib1oIck8b+yO8O4xr
 ymBj/2tITgfG4tITNEvfcr1byOTZY0z9x0lcLZmsi1u6Ta4vpZPC0Q4ez6TzJPDxcCD6
 Z+INuXuPKaSssyuXAfybrRRLkmX6OTGDdV2FLudEJpzuKXu384CwbmZqcdSzqEiwkBJ8
 tpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dhAoQWd9q7mQwrIw9bX6sg077JGQFpVoRyJHO4h4AA0=;
 b=R28NN5JZYPSosLox8lrmmSOEAam+iS2UcwXihOIqAvZ+QiEVDmaAY8EuFy2+rdydEX
 MpIVu2dsdHSVwjKiyEkezITZClk7oBL8ynccNfi3BGYHfXWtJXC9ay4/YRFtwFIxRt07
 szZoRRY+6ACPEvJBUWRJGA2/82m+TQdDO0ZP//fxra9vRG+Ar1RkIVLWCc3P9T4S4sg7
 3Jralbp9bE7yj35y98s3xA5k29I+C22e2Fr6lNmUGmo6xcG4ewxVVQwcyUmdLcQ6qhod
 v6OcClEn93vMAcUH+B98GddxF+xKa2BlbED3HY0pK/Guu37Kv0WYN+X0/jujjgftQJMb
 B8XQ==
X-Gm-Message-State: AOAM5320AJj4JBsh1OTCdiU5D0zvTdwCz2TOflTFdv9dETcZ7ZEOJ1Cz
 QgAyeKWSGB/Lbee29NNBOkQ=
X-Google-Smtp-Source: ABdhPJxJPg5ZhN6LbooNRHCaU3H1QfpjiDGWik9KwVIgjk0LaCILouR2ifRKeMZBhglLlaBFFNp9uQ==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr13092739wml.173.1591568233123; 
 Sun, 07 Jun 2020 15:17:13 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j4sm21384717wma.7.2020.06.07.15.17.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2020 15:17:12 -0700 (PDT)
Subject: Re: [PATCH] net: tulip: Set PCI revision to match dec21143
To: Marek Vasut <marek.vasut@gmail.com>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
References: <20200418002552.343480-1-marek.vasut+renesas@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <203b5328-b473-119c-4122-8f775f390ad0@amsat.org>
Date: Mon, 8 Jun 2020 00:17:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200418002552.343480-1-marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sven, could you review thiw one-line patch?

On 4/18/20 2:25 AM, Marek Vasut wrote:
> The tulip driver claims to emulate dec21143 and it does not emulate dec21142.
> The dec21142 and dec21143 can be discerned by the PCI revision register,
> where dec21142 reports value < 0x20 and dec21143 value >= 0x20. E.g. the
> U-Boot 'tulip' driver also only supports dec21143 and verifies that the
> PCI revision ID is >= 0x20, otherwise refuses to operate such a card.
> 
> This patch sets the PCI revision ID to 0x20 to match the dec21143 and
> thus also permits e.g. U-Boot to work with the tulip emulation.
> 
> Fixes: 34ea023d4b95 ("net: add tulip (dec21143) driver")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> Cc: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/net/tulip.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index 1295f51d07..ffb6c2479a 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -962,6 +962,8 @@ static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
>  
>      pci_conf = s->dev.config;
>      pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
> +    /* Anything with revision < 0x20 is DC21142, anything >= 0x20 is DC21143 */
> +    pci_conf[PCI_REVISION_ID] = 0x20;
>  
>      s->eeprom = eeprom93xx_new(&pci_dev->qdev, 64);
>      tulip_fill_eeprom(s);
> 


