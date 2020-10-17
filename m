Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E491C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277DF206CB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd/xoURO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277DF206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTilP-0007tm-5W
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTikI-0006uC-FK; Sat, 17 Oct 2020 05:43:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTikH-0000Oe-4K; Sat, 17 Oct 2020 05:43:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id e2so7851737wme.1;
 Sat, 17 Oct 2020 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SqS3l8ZAwT2yGPN/KrV3XVq9nvmP8nzBd7Ul/IOgGfQ=;
 b=Qd/xoUROyj0MXBhTSddIT56BbDYO1rXzl3CjR0IreVrLppCCr2rq7t/eTqDXqEyXTM
 1YxCm6nGgjXamYTJKqUs+HQ/ywscE4Cmx2bjQUg7jyi53H+sa3yUPd/mq6FaO9p0sQ6e
 3H47l60zWelAnW9wucoEF5ssKpS5DWC5uKpGXNo5thC9rhEIldZS/SBDtcGsXIX4cLxM
 we15Kj0LstCsRxuezknV4afg4pJ4RKoM+Whfl/GSM20L5SpHbLHfqdTonMn+8C4H3yrQ
 sIEMsMW3eGl15jApZEFVdaBaAVDMG25y5Ez4GMAddpcl4/Kerf09LBeVGBUwVwZjB1af
 vCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SqS3l8ZAwT2yGPN/KrV3XVq9nvmP8nzBd7Ul/IOgGfQ=;
 b=q0pYY6ywnJAjUwAOpKXPnObZ68bTsDTzdAQdGLzuKBzUCTpeNcFcqgeK0XxfRPUl+0
 L/J85cd/sAqt+jLOgyid8kJ11mbOrrn3R5vGmUSWFtpdhGEN2IVh8uLPmFfMqa6vC8vi
 ahzbOaZUkxxXKzGEhYd27eP0yHMFmXWi8w0ebiW7NhxCITk6btJKblksUdolaAR9ehFZ
 yn7NSAJjJtFyFP5YpNSWCnLn40HdZfV5JeYQHUZ4smf0dhNWhyf4AeMMKFzTyrojI5gU
 6970nLC/NvY1uWuNwVYX2GaE1p2GuOi0ISP/jcecn4HDT5G2vh51cy/0M7f0gz/YZ5fO
 t4Bg==
X-Gm-Message-State: AOAM531JdkR4vSz0sMk3Xd5Ykrv8FMDpxhweSg1hO/RoGtBLML5Bn1BU
 lfuSu28MSLEUup20gt+DdIw=
X-Google-Smtp-Source: ABdhPJx5RQE3BwFeOKStSN9LcU27r5DmdC3WijTwlJHOT6JFPFEbF3LWRP1xOPObuSHFqIvosqCpnA==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr8047882wmj.102.1602927802117; 
 Sat, 17 Oct 2020 02:43:22 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id a3sm8090295wrh.94.2020.10.17.02.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:43:21 -0700 (PDT)
Subject: Re: [PATCH 3/5] sun4u: use qdev properties instead of legacy
 m48t59_init() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, hpoussin@reactos.org, qemu-ppc@nongnu.org,
 atar4qemu@gmail.com, david@gibson.dropbear.id.au
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ac152afa-131b-2452-d4dd-012d0a7dbafb@amsat.org>
Date: Sat, 17 Oct 2020 11:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016182739.22875-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:27 PM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/sparc64/sun4u.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index ad5ca2472a..05e659c8a4 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -671,10 +671,13 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>       pci_ide_create_devs(pci_dev);
>   
>       /* Map NVRAM into I/O (ebus) space */
> -    nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
> -    s = SYS_BUS_DEVICE(nvram);
> +    dev = qdev_new("sysbus-m48t59");
> +    qdev_prop_set_int32(dev, "base-year", 1968);
> +    s = SYS_BUS_DEVICE(dev);
> +    sysbus_realize_and_unref(s, &error_fatal);
>       memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
>                                   sysbus_mmio_get_region(s, 0));
> +    nvram = NVRAM(dev);
>    
>       initrd_size = 0;
>       initrd_addr = 0;
> 

