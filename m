Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D078BC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B66721743
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpFd8Mc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B66721743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnWP9-0006fG-S2
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 18:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52586)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hnWOx-00064P-QT
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hnWOu-0000z0-45
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:58:25 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hnWOr-0000wb-Ab
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:58:21 -0400
Received: by mail-lj1-x241.google.com with SMTP id m8so21605636lji.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=veuOMbSzp3FlLjheD8D7Ez7jbhuuG22pGFNRviTcBfg=;
 b=DpFd8Mc2mkjb4DgVv/smOmOuKQhkopbTgVa4oA6Z64vLVuQwkBKIJJy0Scny2CtNZA
 Ac1zBtC9tQ15inJK8wXz3opNVQctQ4w2zj+fhl4xoGvey2oJk6AId7ikEOcIJhPniSaG
 9zizNS7cexOj8Cl4ohuzBgX5TG7XsrX/5ZUTj9p+/fjKd0il6bN9/8umaIeFAkUJ79Tx
 Vwge4/9HDrfMtBoWbOw+JSQ6R22SAxNmktmDH4p6trnAYkw8u95k4zkgWaRbOscXVyCv
 GZxM458eif0ImEZmmEchLpIchZChGKPE6JXn5dddPGjBBgAzPMm4IIFDTMF75xJ1iT2I
 oooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=veuOMbSzp3FlLjheD8D7Ez7jbhuuG22pGFNRviTcBfg=;
 b=hYatfKgEpwdW7kEZo9DKw7JoQJfPLfJdufguC+DGcN1BPIXg4Wly/LI8kgyBVEydv+
 ZZXQBS5LO7QkQP1RQ6yOpE+wzLSPo9EDO6eDEk+M4z+/Bl6PJPIZPf1+dpF4mDE7Y2Iu
 klex6CECJZsd8LhPRkf0mUq/1ktEZEujUY2A8pgTn1iLTaO2EyWLUOodFs9Cwl/pJna/
 N/W2so4uErNu/BJ/AEBk2Z7CjdbaXIp9PMHb/7pNCcqhnxLuf4oFUnpwQ0N/EJ8nlnBD
 ETfS2O/AqLITksL/zkl6Vws2XCDcR6d1xdkpoMD3uA2VMCqFzNou4UK9pFW65jzNUtks
 7Ylg==
X-Gm-Message-State: APjAAAVEYYYZNqUiPY0Qu4V4qUR5+SnjfgEZdaHOvMjs99bX3KdGeDUx
 /ScsBqWsJn4n6ZOcPpeG+m/WuUWRSeyHIesfDZA=
X-Google-Smtp-Source: APXvYqwBXnZtsiEtDAF/725DiV5Us+ANm4kgAdS+VypSXzZuoFU2knaJJdbRvxU70oSrXFrIbP8IQpZSHl7lvaUAtxU=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr19197616ljg.119.1563317899025; 
 Tue, 16 Jul 2019 15:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <PSXP216MB0277E6893AD0AE2B4DB95935DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0277E6893AD0AE2B4DB95935DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jul 2019 15:55:01 -0700
Message-ID: <CAKmqyKOu38J9WwFpSra5jf20s+tNcuBnV20UEf6AsJEMFRdntA@mail.gmail.com>
To: Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 0/6] Add the STM32F405 and Netduino Plus
 2 machine
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 9:53 PM Alistair Francis <alistair@alistair23.me> wrote:
>
>
> Now that the Arm-M4 CPU has been added to QEMU we can add the Netduino
> Plus 2 machine. This is very similar to the STM32F205 and Netduino 2 SoC
> and machine.

Ping?

Alistair

>
> v3:
>  - Remove custom reset handler
>  - Add init-entry and init-sp properties
>  - Rebase on master (including Kconfig changes)
> v2:
>  - Reorder patchset
>  - Return the kernel entry point instead of using a pointer
>  - Address Peter's comments
>
>
> Alistair Francis (6):
>   armv7m: Allow entry information to be returned
>   target/arm: Allow setting M mode entry and sp
>   hw/misc: Add the STM32F4xx Sysconfig device
>   hw/misc: Add the STM32F4xx EXTI device
>   hw/arm: Add the STM32F4xx SoC
>   hw/arm: Add the Netduino Plus 2
>
>  MAINTAINERS                        |  14 ++
>  default-configs/arm-softmmu.mak    |   1 +
>  hw/arm/Kconfig                     |  16 ++
>  hw/arm/Makefile.objs               |   2 +
>  hw/arm/armv7m.c                    |   4 +-
>  hw/arm/netduinoplus2.c             |  58 +++++++
>  hw/arm/stm32f405_soc.c             | 301 +++++++++++++++++++++++++++++++++++++
>  hw/misc/Kconfig                    |   6 +
>  hw/misc/Makefile.objs              |   2 +
>  hw/misc/stm32f4xx_exti.c           | 187 +++++++++++++++++++++++
>  hw/misc/stm32f4xx_syscfg.c         | 168 +++++++++++++++++++++
>  hw/misc/trace-events               |  11 ++
>  include/hw/arm/boot.h              |   4 +-
>  include/hw/arm/stm32f405_soc.h     |  73 +++++++++
>  include/hw/misc/stm32f4xx_exti.h   |  60 ++++++++
>  include/hw/misc/stm32f4xx_syscfg.h |  61 ++++++++
>  target/arm/cpu.c                   |  47 ++++++
>  target/arm/cpu.h                   |   3 +
>  18 files changed, 1016 insertions(+), 2 deletions(-)
>  create mode 100644 hw/arm/netduinoplus2.c
>  create mode 100644 hw/arm/stm32f405_soc.c
>  create mode 100644 hw/misc/stm32f4xx_exti.c
>  create mode 100644 hw/misc/stm32f4xx_syscfg.c
>  create mode 100644 include/hw/arm/stm32f405_soc.h
>  create mode 100644 include/hw/misc/stm32f4xx_exti.h
>  create mode 100644 include/hw/misc/stm32f4xx_syscfg.h
>
> --
> 2.11.0
>

