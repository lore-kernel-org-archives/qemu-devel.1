Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051E4C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80581206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3727/cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80581206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3Qr-00043e-I9
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka3Pp-0003RB-0K; Tue, 03 Nov 2020 16:00:29 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka3Pm-0002n3-3n; Tue, 03 Nov 2020 16:00:28 -0500
Received: by mail-wm1-x343.google.com with SMTP id c16so556887wmd.2;
 Tue, 03 Nov 2020 13:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=59mJACjT20bqpMSDRzrAVaY60CDUsZCISW5yfkUXMoE=;
 b=C3727/cAcI9crw5cdUwPBnjoX/23dKXXvPkGMyx/vt1gJ+TnCq2tqnB3qdO/e7xbdR
 kr/zwd5B1Yhog71XUpFE7b0jcNS7aozkunn3vWioRzRdW5Fj4LQyGkSzMMN/r3KKNSDJ
 4DK/j47o4nEPQb2yEZf9g4eTwieBYJcgyIzU8NnAzkp4n8J6xVPrwV32CZjqswL7g7yK
 ktG5osdS+ftku9fXnhv1COM0dr9r8CpgsBqluM4eXBw3Ersl/aCnUlOh6vqHDHicpj+C
 ZrXfl7oA6uEfwRrd4HdvNGtjiynkfZkHIX4V9SwUEHoxV4qBaoKy0vJLBKjaw8HyrGhY
 geOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=59mJACjT20bqpMSDRzrAVaY60CDUsZCISW5yfkUXMoE=;
 b=O9EWg5QcKnvVYsPBOEHzYxtw1YMFQqn8xowIKL+QIElacoip2AjRGbib7duXFMJEKM
 gPZOyTYKhBjBJcOd71IfYjocU0+R+ZNxpdxfW4U8nLqYjuY73FGEJUs/1FBG05jQij6H
 QPWlamC6ztuvaiEWVKLG2ceGjibCpbUSo1lUQ7e7pk2r/eF6fYGZ+WWch1OC0noxb+pv
 geVOMEu0+FV7mpbOPcNWvlOMGrZ2r4uX84VnXY0/GvQscFzAZzCoGeVfjrQfGU/rtHSj
 x3NBZ0+d4qMNJPXVwRYnX9XLVky//cZan89bN66q6sln6L9CCMM1jb8UoNr1Fb4LGY2K
 wBxg==
X-Gm-Message-State: AOAM5333qijnJpXcVHF46oLEA2vQLTn5dDeGwxrm2fzrF0IMFw1mz08+
 o+Ie36zc8N2H9Ze5DIrjcDesOjXDbfA=
X-Google-Smtp-Source: ABdhPJz07fb/InfAP6Z0E28KOss+a7fnhIK6yM26+TUn2+yD2yZWsw+wgg3wa9A8ix43y7aSnH7N0w==
X-Received: by 2002:a1c:e006:: with SMTP id x6mr1048045wmg.107.1604437223192; 
 Tue, 03 Nov 2020 13:00:23 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e2sm28749161wrr.85.2020.11.03.13.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 13:00:21 -0800 (PST)
Subject: Re: [PATCH] hw/arm/nseries: Check return value from
 load_image_targphys()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201103114918.11807-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6eefc3e5-2b95-1f0b-7b02-ef321cbce0f5@amsat.org>
Date: Tue, 3 Nov 2020 22:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103114918.11807-1-peter.maydell@linaro.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 12:49 PM, Peter Maydell wrote:
> The nseries machines have a codepath that allows them to load a
> secondary bootloader.  This code wasn't checking that the
> load_image_targphys() succeeded.  Check the return value and report
> the error to the user.
> 
> While we're in the vicinity, fix the comment style of the
> comment documenting what this image load is doing.
> 
> Fixes: Coverity CID 1192904
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/nseries.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index 76fd7fe9854..d49852c60d7 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -1380,7 +1380,8 @@ static void n8x0_init(MachineState *machine,
>          /* No, wait, better start at the ROM.  */
>          s->mpu->cpu->env.regs[15] = OMAP2_Q2_BASE + 0x400000;
>  
> -        /* This is intended for loading the `secondary.bin' program from
> +        /*
> +         * This is intended for loading the `secondary.bin' program from
>           * Nokia images (the NOLO bootloader).  The entry point seems
>           * to be at OMAP2_Q2_BASE + 0x400000.
>           *
> @@ -1388,9 +1389,15 @@ static void n8x0_init(MachineState *machine,
>           * for them the entry point needs to be set to OMAP2_SRAM_BASE.
>           *
>           * The code above is for loading the `zImage' file from Nokia
> -         * images.  */
> -        load_image_targphys(option_rom[0].name, OMAP2_Q2_BASE + 0x400000,
> -                            machine->ram_size - 0x400000);
> +         * images.
> +         */
> +        if (load_image_targphys(option_rom[0].name,
> +                                OMAP2_Q2_BASE + 0x400000,
> +                                machine->ram_size - 0x400000) < 0) {
> +            error_report("Failed to load secondary bootloader %s",
> +                         option_rom[0].name);
> +            exit(EXIT_FAILURE);
> +        }
>  
>          n800_setup_nolo_tags(nolo_tags);
>          cpu_physical_memory_write(OMAP2_SRAM_BASE, nolo_tags, 0x10000);
> 

What about the other cases?

$ git grep -E ^\\s+load_image_targphys
hw/alpha/dp264.c:163:            load_image_targphys(initrd_filename,
initrd_base,
hw/hppa/machine.c:301:            load_image_targphys(initrd_filename,
initrd_base, initrd_size);
hw/m68k/q800.c:388:            load_image_targphys(initrd_filename,
initrd_base,

Thanks,

Phil.

