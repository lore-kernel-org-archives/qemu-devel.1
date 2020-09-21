Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC3C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD5E2223E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGjW3HUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD5E2223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOxj-0001rK-87
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKOsp-0006jg-JE; Mon, 21 Sep 2020 12:41:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKOso-00016q-3v; Mon, 21 Sep 2020 12:41:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id b79so151786wmb.4;
 Mon, 21 Sep 2020 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wDioXb+16Whup7NzJ5JhW0Ott17OnjjbAB2KPYJ3T1c=;
 b=YGjW3HUlAWJ//UmYyoQqE2a/FeOtwakKhP61TwILe87iVZ5jnjMF2G3kYnlCG3xdRn
 iTzH8DDAyVCC9GuR9DF/EvmqnQnZkEs26luuleJjgise/bYv+XN+qAqJxRk+9jWYtGMf
 3OYIpDWr0TCxNI+na7HnO4HBHcoW/1VdzznRHFu/64R4IAoBoN7k4EHElxagEue15TOj
 q+CCNZJat5yMjgQ0nM+5rUbQZ2qDZ1AWdbqDczKU45XdCubpEG7Hi0zAIUWC2/Z4q0GX
 K67NAm/JHo3sZrVOZX05LeNtbpMe1sKjzNT8FEboawuFGp3SKyIUy4dWny7vqTMwTxeu
 3lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wDioXb+16Whup7NzJ5JhW0Ott17OnjjbAB2KPYJ3T1c=;
 b=PPquJZhOhcfBumZXMlYokmhkjtWAl3qiqM7OzAVvXQiyRnTENVfbnej9KfV9+mDDep
 PexfwrFlP7fB0XXTqqQ4/WrVpwlJepl/+J0BwCEzvjEUJL7i6yKJXIn16CrHahzBe5+C
 je8pqT6mB0b9hi7eL66fVMHTUYlB1CXeqP73C688KEe2IGoTZB35/qjUmol6qBpYwr9q
 c1MXfmrORHW/X06yPHWaA7Ld3Vk9RXXlK66AjDfI/ru3eTlyTPC9N38bS3ubCQNtUoaz
 lyGIiewsWyDMyU1PdcnndFWTpwDE/8Owfg0YZBsdagWDktlDhO8KaDVCqlbFQrcpPemy
 Hy5g==
X-Gm-Message-State: AOAM53362Ht1G/alC1XgBl/ddK37QBDU+OBziGWrMNUDm5/TIWmm7m8H
 D1hicMVJ8aic/LT/xBFa728=
X-Google-Smtp-Source: ABdhPJzUK9LGS6Dcp0A2PGn8TLpud78KDqmDWP+iVh8EPdclcUtxuNZcUuDHZRq1f0aS5mCh5y94Xg==
X-Received: by 2002:a1c:bdd4:: with SMTP id n203mr217531wmf.119.1600706496535; 
 Mon, 21 Sep 2020 09:41:36 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 10sm175572wmi.37.2020.09.21.09.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 09:41:35 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] hw/arm/raspi: Use RaspiProcessorId to set the
 firmware load address
To: qemu-devel@nongnu.org
References: <20200921075628.466506-1-f4bug@amsat.org>
 <20200921075628.466506-8-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0e2b3fcc-7015-1c7f-906d-a0baa0ff4415@amsat.org>
Date: Mon, 21 Sep 2020 18:41:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921075628.466506-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 9:56 AM, Philippe Mathieu-Daudé wrote:
> The firmware load address depends of the SoC ("processor id") used,
> not of the version of the board.
> 

I forgot:
Suggested-by: Luc Michel <luc.michel@greensocs.com>

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 0d8e5a34c78..ae98a2fbfca 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -238,7 +238,8 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
>       * the normal Linux boot process
>       */
>      if (machine->firmware) {
> -        hwaddr firmware_addr = version == 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
> +        hwaddr firmware_addr = processor_id <= PROCESSOR_ID_BCM2836
> +                             ? FIRMWARE_ADDR_2 : FIRMWARE_ADDR_3;
>          /* load the firmware image (typically kernel.img) */
>          r = load_image_targphys(machine->firmware, firmware_addr,
>                                  ram_size - firmware_addr);
> 

