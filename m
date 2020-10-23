Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852F4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553A120797
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM+3CK3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553A120797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVoCv-0006ky-2F
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 23:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1kVoAW-0005lX-K3; Thu, 22 Oct 2020 23:55:08 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1kVoAU-0003F4-5x; Thu, 22 Oct 2020 23:55:08 -0400
Received: by mail-oi1-x241.google.com with SMTP id f8so424562oij.10;
 Thu, 22 Oct 2020 20:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=do4MYaznpO15ElDgEE06pFh4NznvHCCm+/CB4DM3A9o=;
 b=rM+3CK3wdZ1c5Uu5Wqe7nOrL8amXYI5Cb9Exs1iuvvG0gBOt0mbRjAqU7gyNqgw6K/
 DyWLmWCCvvrdopjGgJMhtWAIjKRyjHc1YGY/EF9Xbx+6V37u3L2FXMrBzvLX0wBww7ZJ
 62FUFTVpvrw7DN0pE6FnUYjy8rR6tTLCMik7Cc//RaSJNJ1hv1rfojZ4O2uky3iv08x4
 UOgJ0Y/yQzXqFj1vp5xhHcWy9wQBA8wau7XxGskNYh06BMbEsEOBZ0etIZdX0J+5J3yt
 oYHCoe7xQr7VNax9p524daZzH5+LIEUU8Ptc36jinLGUG6EoG5DbKUsx3irTS965smnF
 kLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=do4MYaznpO15ElDgEE06pFh4NznvHCCm+/CB4DM3A9o=;
 b=H14cvETCkK+5Lud4HX0C4hOJUD0SLpLKv9PV+EhECoXUAxnwej/IfG+2VSdCg3c6OZ
 PdB09UiLNNMByK59C8qSIakWJtt5jN0jLHe3eaJgqjm65uNSx5rOfdOsDJ28w2HjDPBR
 HpylIN20zV5pk4iWKSAV8tj3PgrOM5cC6o+SmwoG/27qTZsE+eqZWoQ6aW2Eh2fTGnTd
 dDd3aIvETifIT5zXBhf177TtL/RkK2u5LEEEhunJVVIzyRy+k0v86Jzjl6ScxVZNewPh
 FnIYAVh01WruonPtKNCc3yanYybuDkl0Uo5nEGbXEccPCThyisntjAcT2zKqT7s6ZzCb
 n+Fg==
X-Gm-Message-State: AOAM532L/4td2Vn85ETEmtpvkd0wXLbT9guabe4r/dWHA911SY9uTkvQ
 kzPl7XC8kcLKsjlbodaIU2Q=
X-Google-Smtp-Source: ABdhPJw6RY28N73Gdb5MPJccIuhffNrs7dd+UMZ+ZtMEnrBIsCVvryuOlhswKm7TpCMrVsl1XW1jPg==
X-Received: by 2002:aca:ed90:: with SMTP id l138mr280233oih.178.1603425304681; 
 Thu, 22 Oct 2020 20:55:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 l3sm116841oib.10.2020.10.22.20.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 20:55:03 -0700 (PDT)
Subject: Re: [PATCH v3 00/15] raspi: add the bcm2835 cprman clock manager
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201010135759.437903-1-luc@lmichel.fr>
 <f6c1ad96-ce36-e229-2a9d-d71070b82d82@amsat.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <9a858d15-5335-9036-058c-d752c2689219@roeck-us.net>
Date: Thu, 22 Oct 2020 20:55:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f6c1ad96-ce36-e229-2a9d-d71070b82d82@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=groeck7@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 3:06 PM, Philippe Mathieu-Daudé wrote:
> Cc'ing Guenter who had a similar patch and might be interested
> to test :)
> 
I applied the series on top of qemu mainline and ran all my test with it
(raspi2 with qemu-system-arm as well as qemu-system-aarch64, and raspi3
in both big endian and little endian mode with qemu-system-aarch64.
All tests passed without error or kernel warning.

For the series:

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> patch 16/15 fixup:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg752113.html
> 
> On 10/10/20 3:57 PM, Luc Michel wrote:
>> v2 -> v3:
>>    - patch 03: moved clock_new definition to hw/core/clock.c [Phil]
>>    - patch 03: commit message typo [Clement]
>>    - patch 10: clarifications around the CM_CTL/CM_DIBV mux registers.
>>                reg_cm replaced with reg_ctl and reg_div. Add some
>>                comments for clarity. [Phil]
>>    - patch 10: fixed update_mux_from_cm not matching the CM_DIV offset
>>                correctly. [Phil]
>>    - patch 11: replaced manual bitfield extraction with extract32 [Phil]
>>    - patch 11: added a visual representation of CM_DIV for clarity [Phil]
>>    - patch 11: added a missing return in clock_mux_update.
>>
>> v1 -> v2:
>>    - patch 05: Added a comment about MMIO .valid constraints [Phil]
>>    - patch 05: Added MMIO .impl [Phil]
>>    - patch 05: Moved init_internal_clock to the public clock API, renamed
>>      clock_new (new patch 03) [Phil]
>>    - patch 11: use muldiv64 for clock mux frequency output computation [Phil]
>>    - patch 11: add a check for null divisor (Phil: I dropped your r-b)
>>    - Typos, formatting, naming, style [Phil]
>>
>> Patches without review: 03, 11, 13
>>
>> Hi,
>>
>> This series add the BCM2835 CPRMAN clock manager peripheral to the
>> Raspberry Pi machine.
>>
>> Patches 1-4 are preliminary changes, patches 5-13 are the actual
>> implementation.
>>
>> The two last patches add a clock input to the PL011 and
>> connect it to the CPRMAN.
>>
>> This series has been tested with Linux 5.4.61 (the current raspios
>> version). It fixes the kernel Oops at boot time due to invalid UART
>> clock value, and other warnings/errors here and there because of bad
>> clocks or lack of CPRMAN.
>>
>> Here is the clock tree as seen by Linux when booted in QEMU:
>> (/sys/kernel/debug/clk/clk_summary with some columns removed)
>>
>>                          enable  prepare
>>     clock                 count    count          rate
>> -----------------------------------------------------
>>   otg                         0        0     480000000
>>   osc                         5        5      19200000
>>      gp2                      1        1         32768
>>      tsens                    0        0       1920000
>>      otp                      0        0       4800000
>>      timer                    0        0       1000002
>>      pllh                     4        4     864000000
>>         pllh_pix_prediv       1        1       3375000
>>            pllh_pix           0        0        337500
>>         pllh_aux              1        1     216000000
>>            vec                0        0     108000000
>>         pllh_rcal_prediv      1        1       3375000
>>            pllh_rcal          0        0        337500
>>      plld                     3        3    2000000024
>>         plld_dsi1             0        0       7812501
>>         plld_dsi0             0        0       7812501
>>         plld_per              3        3     500000006
>>            gp1                1        1      25000000
>>            uart               1        2      47999625
>>         plld_core             2        2     500000006
>>            sdram              0        0     166666668
>>      pllc                     3        3    2400000000
>>         pllc_per              1        1    1200000000
>>            emmc               0        0     200000000
>>         pllc_core2            0        0       9375000
>>         pllc_core1            0        0       9375000
>>         pllc_core0            2        2    1200000000
>>            vpu                1        1     700000000
>>               aux_spi2        0        0     700000000
>>               aux_spi1        0        0     700000000
>>               aux_uart        0        0     700000000
>>               peri_image      0        0     700000000
>>      plla                     2        2    2250000000
>>         plla_ccp2             0        0       8789063
>>         plla_dsi0             0        0       8789063
>>         plla_core             1        1     750000000
>>            h264               0        0     250000000
>>            isp                0        0     250000000
>>   dsi1p                       0        0             0
>>   dsi0p                       0        0             0
>>   dsi1e                       0        0             0
>>   dsi0e                       0        0             0
>>   cam1                        0        0             0
>>   cam0                        0        0             0
>>   dpi                         0        0             0
>>   tec                         0        0             0
>>   smi                         0        0             0
>>   slim                        0        0             0
>>   gp0                         0        0             0
>>   dft                         0        0             0
>>   aveo                        0        0             0
>>   pcm                         0        0             0
>>   pwm                         0        0             0
>>   hsm                         0        0             0
>>
>> It shows small differences with real hardware due other missing
>> peripherals for which the driver turn the clock off (like tsens).
>>
>> Luc Michel (15):
>>    hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
>>    hw/core/clock: trace clock values in Hz instead of ns
>>    hw/core/clock: add the clock_new helper function
>>    hw/arm/raspi: fix CPRMAN base address
>>    hw/arm/raspi: add a skeleton implementation of the CPRMAN
>>    hw/misc/bcm2835_cprman: add a PLL skeleton implementation
>>    hw/misc/bcm2835_cprman: implement PLLs behaviour
>>    hw/misc/bcm2835_cprman: add a PLL channel skeleton implementation
>>    hw/misc/bcm2835_cprman: implement PLL channels behaviour
>>    hw/misc/bcm2835_cprman: add a clock mux skeleton implementation
>>    hw/misc/bcm2835_cprman: implement clock mux behaviour
>>    hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
>>    hw/misc/bcm2835_cprman: add sane reset values to the registers
>>    hw/char/pl011: add a clock input
>>    hw/arm/bcm2835_peripherals: connect the UART clock
>>
>>   include/hw/arm/bcm2835_peripherals.h       |    5 +-
>>   include/hw/arm/raspi_platform.h            |    5 +-
>>   include/hw/char/pl011.h                    |    1 +
>>   include/hw/clock.h                         |   18 +
>>   include/hw/misc/bcm2835_cprman.h           |  210 ++++
>>   include/hw/misc/bcm2835_cprman_internals.h | 1019 ++++++++++++++++++++
>>   hw/arm/bcm2835_peripherals.c               |   15 +-
>>   hw/char/pl011.c                            |   45 +
>>   hw/core/clock.c                            |   21 +-
>>   hw/misc/bcm2835_cprman.c                   |  808 ++++++++++++++++
>>   hw/char/trace-events                       |    1 +
>>   hw/core/trace-events                       |    4 +-
>>   hw/misc/meson.build                        |    1 +
>>   hw/misc/trace-events                       |    5 +
>>   14 files changed, 2146 insertions(+), 12 deletions(-)
>>   create mode 100644 include/hw/misc/bcm2835_cprman.h
>>   create mode 100644 include/hw/misc/bcm2835_cprman_internals.h
>>   create mode 100644 hw/misc/bcm2835_cprman.c
>>


