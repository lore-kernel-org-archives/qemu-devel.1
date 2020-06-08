Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104EEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83652072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRI7+d27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83652072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiISP-0004ii-3J
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiIRR-0003nA-5e; Mon, 08 Jun 2020 10:07:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiIRQ-0002u3-5c; Mon, 08 Jun 2020 10:07:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id x13so17562064wrv.4;
 Mon, 08 Jun 2020 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GCmApNcE+Ba4QIb93ioIhEnP3YbWIgaEGAE/nYpU68c=;
 b=YRI7+d27g7ydrZH/TmFfOtnvSknCr8gS+z+xPUJNkYPnu5Qw2x8czPROeV2KGiiMMx
 MozYOmpB70LG8RUkoEhiBgmGVx5QJDkGQp/61cxnzTR7iDgs8n0y3AwEb/epqIXedVqs
 6OTkf+aANbMjAS+N/mBuP/d1k7gQmAMcslfbKLlVbmpS3Cbddt+6RdIGC5PNdGweePYN
 DZ7knJJll9iKEhduLk+9Qz6ZN6G5UU8se3F0JYzFN8m2hHEG0cJaQUvOvHUVJraOlEA8
 vWXEqO49EQM30IuSX3HnfPZQiGseI0ustN7hiQ5Qg71iX3P3ISOa5N0nlZi0wBR0mYew
 q0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GCmApNcE+Ba4QIb93ioIhEnP3YbWIgaEGAE/nYpU68c=;
 b=Ky4k+IiYVJpOo4kRUXbO+66Xm1XhteWt2eDozpLmE3F1SeDn9lNQk6Jdcg1RTdiDdl
 37tyds6zq9AX3usnulX4MQQc+yPWuTj1LS5LvrfTmmGpyT80mmsHY8ObeNwDsYPbZpLQ
 qJQZxai1045Xl+VD5ux/8JGhyRjD/dShDUlqD5VSYGpVkiczflSV6JhL5qoKzzvyq63x
 2G4+Z95/ct+AH93ljoPIEA6h+RpXRCY80BG3UK2KkcDWUa8x4r/YSW9hAtidtEimHw0B
 CpFZb/e3RVyHkYHhhLDnPezVB2MOUmvFOEtSemDI7hgQAV+8ia8qVtnN06hvJ6dKZxYk
 hgsA==
X-Gm-Message-State: AOAM531BuwzYBCPJPj1DbuesLv87nRVnyTOlz542aaeoC2EHKKVRk/ZE
 Z1C5EfrWi8js0M1naA0mLX4=
X-Google-Smtp-Source: ABdhPJy+Msxy5V5EfRsJxWMGYQRpdpSg4oLwrBMzZ00LwDWxIgDZjZVh8syKbuadW4z7p2azMHA2Iw==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr25191705wru.296.1591625274296; 
 Mon, 08 Jun 2020 07:07:54 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s72sm22485782wme.35.2020.06.08.07.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 07:07:53 -0700 (PDT)
Subject: Re: [PATCH v2 18/24] display/sm501 display/ati: Fix to realize
 "i2c-ddc"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-19-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <78cb2378-4877-183b-2d62-0984eee746f2@amsat.org>
Date: Mon, 8 Jun 2020 16:07:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528110444.20456-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Magnus Damm <magnus.damm@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:04 PM, Markus Armbruster wrote:
> sm501_init() and ati_vga_realize() create an "i2c-ddc" device, but
> neglect to realize it.  Affects machines sam460ex, shix, r2d, and
> fulong2e.
> 
> In theory, a device becomes real only on realize.  In practice, the
> transition from unreal to real is a fuzzy one.  The work to make a
> device real can be spread between realize methods (fine),
> instance_init methods (wrong), and board code wiring up the device
> (fine as long as it effectively happens on realize).  Depending on
> what exactly is done where, a device can work even when we neglect
> to realize it.
> 
> This one appears to work.  Nevertheless, it's a clear misuse of the
> interface.  Even when it works today (more or less by chance), it can
> break tomorrow.
> 
> Fix by realizing it right away.  Visible in "info qom-tree"; here's
> the change for sam460ex:
> 
>      /machine (sam460ex-machine)
>        [...]
>        /unattached (container)
>          [...]
>     -    /device[14] (sii3112)
>     +    /device[14] (i2c-ddc)
>     +    /device[15] (sii3112)
>          [rest of device[*] renumbered...]
> 
> Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
> Fixes: c82c7336de58876862e6b4dccbda29e9240fd388
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-ppc@nongnu.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/ati.c   | 2 ++
>  hw/display/sm501.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 065f197678..5c71e5f295 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -929,6 +929,8 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>      bitbang_i2c_init(&s->bbi2c, i2cbus);
>      I2CSlave *i2cddc = I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC));
>      i2c_set_slave_address(i2cddc, 0x50);
> +    object_property_set_bool(OBJECT(i2cddc), true, "realized",
> +                             &error_abort);
>  
>      /* mmio register space */
>      memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index acc692531a..fbedc56715 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1816,6 +1816,8 @@ static void sm501_init(SM501State *s, DeviceState *dev,
>      /* ddc */
>      I2CDDCState *ddc = I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC));
>      i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
> +    object_property_set_bool(OBJECT(ddc), true, "realized",
> +                             &error_abort);
>  
>      /* mmio */
>      memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_SIZE);
> 

