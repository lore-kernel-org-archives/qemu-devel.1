Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62611C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D04C20866
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="TAr3q2ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D04C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNp0-0006eU-At
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKNjv-0004s6-3G; Mon, 21 Sep 2020 11:28:27 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKNjt-00050t-CQ; Mon, 21 Sep 2020 11:28:26 -0400
Received: from [172.17.10.14] (unknown [172.17.10.14])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 8D1DD21CC5;
 Mon, 21 Sep 2020 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1600702102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSQvclVDcXZ1wD+4XXss/Y5cF5u1BIBLD/qPA1mnwzA=;
 b=TAr3q2ihTe2Bu/aSZGO/hQDwPpE3aipRoPlU6JGM9ni3lYuL+4wB2gTTGkPT7eAll/n/Al
 5YXAOwXoR79pFcgcBTAFqkeTQwHqOgWvpbHxuewTo6lo1esgH9SKM40KUzpgfkidB6+QzB
 1PDNqgV70RxEGdtmRArF/DhcJUQXHzM=
Subject: Re: [PATCH 2/3] hw/arm/bcm2835: Add more unimplemented peripherals
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200921034729.432931-1-f4bug@amsat.org>
 <20200921034729.432931-3-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <472f3b7a-d633-9f1f-bb47-cc28b39d9628@greensocs.com>
Date: Mon, 21 Sep 2020 17:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921034729.432931-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 11:27:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 5:47 AM, Philippe Mathieu-Daudé wrote:
> The bcm2835-v3d is used since Linux 4.7, see commit
> 49ac67e0c39c ("ARM: bcm2835: Add VC4 to the device tree"),
> and the bcm2835-txp since Linux 4.19, see commit
> b7dd29b401f5 ("ARM: dts: bcm283x: Add Transposer block").
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   include/hw/arm/bcm2835_peripherals.h | 2 ++
>   hw/arm/bcm2835_peripherals.c         | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
> index b4d3ae121ac..ccd9eb11102 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -47,6 +47,7 @@ struct BCM2835PeripheralState {
>   
>       BCM2835SystemTimerState systmr;
>       BCM2835MphiState mphi;
> +    UnimplementedDeviceState txp;
>       UnimplementedDeviceState armtmr;
>       UnimplementedDeviceState cprman;
>       UnimplementedDeviceState a2w;
> @@ -68,6 +69,7 @@ struct BCM2835PeripheralState {
>       UnimplementedDeviceState otp;
>       UnimplementedDeviceState dbus;
>       UnimplementedDeviceState ave0;
> +    UnimplementedDeviceState v3d;
>       UnimplementedDeviceState bscsl;
>       UnimplementedDeviceState smi;
>       DWC2State dwc2;
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index a9d7f53f6e9..15c5c72e465 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -343,6 +343,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>           qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
>                                  INTERRUPT_USB));
>   
> +    create_unimp(s, &s->txp, "bcm2835-txp", TXP_OFFSET, 0x1000);
>       create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
>       create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
>       create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
> @@ -356,6 +357,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>       create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
>       create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
>       create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
> +    create_unimp(s, &s->v3d, "bcm2835-v3d", V3D_OFFSET, 0x1000);
>       create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
>   }
>   
> 

