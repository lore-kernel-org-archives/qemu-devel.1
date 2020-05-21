Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA95C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9932320826
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4Eqelj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9932320826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbp22-0001ym-Pw
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jboXu-00013Y-Qa
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:59:50 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jboXt-00016Y-CB
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:59:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id f18so6016652otq.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oHKmpJirg4EZoTKDF575j+PCYShCNB8Xm+6VogrN6FA=;
 b=G4Eqelj72FTUuEXOQDgLe1SoQH1v4Ua5qW0EWqZ8ULWhG3c+WQbKYZo9vWNniboF/O
 PHf/AznmoUJk2dltC+/ThYvTKdN2s2KCMvOvdvm3IynzPiHWaVvdnJtDJbrA/sP8meYV
 7PLQ/AASuNRXviX1CLYakMauQGlHAdJQAI2kaOg71DTLeCS/I4hKPh12cLXEeaQPe9pD
 xImacx9JfiSZnZKMOtKD7tKRSohBwXDwW7s6WH6YQD7xOCPgEI6pzF8bb66tfI+KA137
 GCNO56iA69u6+YbumNJaMTh+ea3UKgUzg6d7RQg2915hK+Np+xka8RjaCv83PubIlRRk
 wvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oHKmpJirg4EZoTKDF575j+PCYShCNB8Xm+6VogrN6FA=;
 b=YgJxBJJWJV123hqA6teRfkufM3u+W2HTshguBIe4+t7FpeoBD6uJb7ttKVXINbgowg
 onH7PuB79h1DEi3J3kNarfpE5pb4+QRWUS1O6304+/MLTlawOwkdyS2sqChH8kFuiytX
 EW8pLP6VKLfQfZNn+k07Dr0ug15/uqzNlqOFwJo/kjm97NN0vqvZW6Jp2tyNPJrf0fsh
 /1Zh3/1THLY1n1GpPEKgGzUrmFBk2RSLWuu3tG2MX5wqLyVxpX+GZfgFR3HGRzei75Zk
 SzezugF9swvtsjkYjJo9+/865OE6v9i4pJjySOz9dwpf6lsYB9yh92GEDIevXMAgkHsn
 VTiQ==
X-Gm-Message-State: AOAM530BhP9lxkfvRyN/EdsFzKHvFS9Z1tPrUcF4up2SRN5LN+11mjsc
 n0xjMi03/3AGU+8cMNh8Hcct3DvcA1D2MhbdNXsNsw==
X-Google-Smtp-Source: ABdhPJwEhkexMKUINid9wuLNtB6fVpHfueW3m2e3kqUAv6oOy3z/6jMS/ZrHCXEdUezJ/NTgU5B3vAJW9sHvCYVF9mc=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr8016316otr.135.1590080387984; 
 Thu, 21 May 2020 09:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200519084904.1069-1-geert+renesas@glider.be>
In-Reply-To: <20200519084904.1069-1-geert+renesas@glider.be>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 17:59:37 +0100
Message-ID: <CAFEAcA9-wQ72_M+ZY+EbEgw1L9LVchBgpLivexFXVZ3HuCtcZg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Fix PL061 node name and properties
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 at 09:49, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Make the created node comply with the PL061 Device Tree bindings:
>   - Use generic node name "gpio" instead of "pl061",
>   - Add missing "#interrupt-cells" and "interrupt-controller"
>     properties.

Where have these properties come from? They must be optional,
because in the version of the binding documentation from Linux
5.0 they're not described:
https://elixir.bootlin.com/linux/v5.0/source/Documentation/devicetree/bindings/gpio/pl061-gpio.txt

They seem to have magically appeared in kernel commit
910f38bed9439e765f7e, which purports to only be a change
of format from plain text to yaml but has added some
extra properties and claimed them to be mandatory.

Since the devicetree spec says that the interrupt-controller
property "defines a node as an interrupt controller node"
and a GPIO chip isn't an interrupt controller, this seems
like some kind of error in the dtb binding. Maybe I'm
missing something...

What actually goes wrong if QEMU doesn't specify these
properties?

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7dc96abf72cf2b9a..99593d7bce4d85cb 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -818,13 +818,15 @@ static void create_gpio(const VirtMachineState *vms)
>                                       qdev_get_gpio_in(vms->gic, irq));
>
>      uint32_t phandle = qemu_fdt_alloc_phandle(vms->fdt);
> -    nodename = g_strdup_printf("/pl061@%" PRIx64, base);
> +    nodename = g_strdup_printf("/gpio@%" PRIx64, base);

Does the devicetree binding really mandate what the node name is?
I thought that finding the right device was doe via the
'compatible' string and the nodename could be whatever the
device tree creator wanted.

thanks
-- PMM

