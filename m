Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2B3C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF4F2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYCa3vo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF4F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVijv-0000xZ-UF
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 18:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kViiv-0000Q9-Qj; Thu, 22 Oct 2020 18:06:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kViit-00051E-O7; Thu, 22 Oct 2020 18:06:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so5423190wru.12;
 Thu, 22 Oct 2020 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S9oCSIT0bPgiC34+L+hmIouoQfKPSNUNV3gEnPwikTg=;
 b=UYCa3vo3mVxusJ2+lpJ5/54Cujw7jMcFBPJnidMMXEHNJ9NAwK4Asjh/RX3Zumra4s
 /X4kaL76xQInFGFVjkhLptUeLhbxXrT4lCar0KE2rYnS2Mqttn/kenzk4g4scsSzEQVm
 gG7fVNOzhhpA8acTrQbDnVGsdcSXGPTHmIApEpr3WNTBLPjpJWf3r0at6qkErRzXYd85
 FWDHkzRI5xhLCjagGnkMunA38JLuQn19sd3lWjk5FLwZmRZoRQJDRrTD4k/9EvZMm4ED
 vN2owbaxYiDnGt7BJLbicuXph6Fe27w01eLVQGljGtpsPjEYGWzwE7cVjkob7F2qOLxI
 xayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S9oCSIT0bPgiC34+L+hmIouoQfKPSNUNV3gEnPwikTg=;
 b=oNmcVele0aqAZhL8Yw/ZqSvzPe/t5gmNeeZr7jcPaNOQEcevQ0AKGcnRipmN3xVZBf
 t05Z+fvyE3ppdpnEbVp+cqF0YhhfI2eCVF9P8SkgkvHjjmJdyoo344nrTLWu7qMW0/Tl
 tVgev7OKEONP6ZU0XlzoKxMHpJZn74O2C19dDHfhKsAlag+mvlWT+9TEYdHWVZRknSxt
 D0QLzrSTNLHwbfQVxcydERoq7xA4jSV7ChhseUT5EHor2e0T3igU6D08B5K1eSlcDas2
 kWA3DmKS36qpWsfwMqxw79tSUsMTMMx1abqs7CpvcJ4hIPTaxwfstyayJC+NUSm0h/id
 iZRA==
X-Gm-Message-State: AOAM530CLKRz7Ji/yAaPtLgpdHlwCHeLNdp6rfeRBj+twxb3WiYZm8JN
 kNxeQtpSMlb0wvBuMpGAFpk=
X-Google-Smtp-Source: ABdhPJwBPbTVoFKKbAELq3S/0FYvYpzPffvp1aaRZdoSbRgvvnhHEHA/0Xz49tcLt8bTvHXwM8fhGQ==
X-Received: by 2002:adf:ed06:: with SMTP id a6mr4604062wro.375.1603404373824; 
 Thu, 22 Oct 2020 15:06:13 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i14sm5777945wml.24.2020.10.22.15.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 15:06:13 -0700 (PDT)
Subject: Re: [PATCH v3 00/15] raspi: add the bcm2835 cprman clock manager
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
References: <20201010135759.437903-1-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6c1ad96-ce36-e229-2a9d-d71070b82d82@amsat.org>
Date: Fri, 23 Oct 2020 00:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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

Cc'ing Guenter who had a similar patch and might be interested
to test :)

patch 16/15 fixup:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg752113.html

On 10/10/20 3:57 PM, Luc Michel wrote:
> v2 -> v3:
>    - patch 03: moved clock_new definition to hw/core/clock.c [Phil]
>    - patch 03: commit message typo [Clement]
>    - patch 10: clarifications around the CM_CTL/CM_DIBV mux registers.
>                reg_cm replaced with reg_ctl and reg_div. Add some
>                comments for clarity. [Phil]
>    - patch 10: fixed update_mux_from_cm not matching the CM_DIV offset
>                correctly. [Phil]
>    - patch 11: replaced manual bitfield extraction with extract32 [Phil]
>    - patch 11: added a visual representation of CM_DIV for clarity [Phil]
>    - patch 11: added a missing return in clock_mux_update.
> 
> v1 -> v2:
>    - patch 05: Added a comment about MMIO .valid constraints [Phil]
>    - patch 05: Added MMIO .impl [Phil]
>    - patch 05: Moved init_internal_clock to the public clock API, renamed
>      clock_new (new patch 03) [Phil]
>    - patch 11: use muldiv64 for clock mux frequency output computation [Phil]
>    - patch 11: add a check for null divisor (Phil: I dropped your r-b)
>    - Typos, formatting, naming, style [Phil]
> 
> Patches without review: 03, 11, 13
> 
> Hi,
> 
> This series add the BCM2835 CPRMAN clock manager peripheral to the
> Raspberry Pi machine.
> 
> Patches 1-4 are preliminary changes, patches 5-13 are the actual
> implementation.
> 
> The two last patches add a clock input to the PL011 and
> connect it to the CPRMAN.
> 
> This series has been tested with Linux 5.4.61 (the current raspios
> version). It fixes the kernel Oops at boot time due to invalid UART
> clock value, and other warnings/errors here and there because of bad
> clocks or lack of CPRMAN.
> 
> Here is the clock tree as seen by Linux when booted in QEMU:
> (/sys/kernel/debug/clk/clk_summary with some columns removed)
> 
>                          enable  prepare
>     clock                 count    count          rate
> -----------------------------------------------------
>   otg                         0        0     480000000
>   osc                         5        5      19200000
>      gp2                      1        1         32768
>      tsens                    0        0       1920000
>      otp                      0        0       4800000
>      timer                    0        0       1000002
>      pllh                     4        4     864000000
>         pllh_pix_prediv       1        1       3375000
>            pllh_pix           0        0        337500
>         pllh_aux              1        1     216000000
>            vec                0        0     108000000
>         pllh_rcal_prediv      1        1       3375000
>            pllh_rcal          0        0        337500
>      plld                     3        3    2000000024
>         plld_dsi1             0        0       7812501
>         plld_dsi0             0        0       7812501
>         plld_per              3        3     500000006
>            gp1                1        1      25000000
>            uart               1        2      47999625
>         plld_core             2        2     500000006
>            sdram              0        0     166666668
>      pllc                     3        3    2400000000
>         pllc_per              1        1    1200000000
>            emmc               0        0     200000000
>         pllc_core2            0        0       9375000
>         pllc_core1            0        0       9375000
>         pllc_core0            2        2    1200000000
>            vpu                1        1     700000000
>               aux_spi2        0        0     700000000
>               aux_spi1        0        0     700000000
>               aux_uart        0        0     700000000
>               peri_image      0        0     700000000
>      plla                     2        2    2250000000
>         plla_ccp2             0        0       8789063
>         plla_dsi0             0        0       8789063
>         plla_core             1        1     750000000
>            h264               0        0     250000000
>            isp                0        0     250000000
>   dsi1p                       0        0             0
>   dsi0p                       0        0             0
>   dsi1e                       0        0             0
>   dsi0e                       0        0             0
>   cam1                        0        0             0
>   cam0                        0        0             0
>   dpi                         0        0             0
>   tec                         0        0             0
>   smi                         0        0             0
>   slim                        0        0             0
>   gp0                         0        0             0
>   dft                         0        0             0
>   aveo                        0        0             0
>   pcm                         0        0             0
>   pwm                         0        0             0
>   hsm                         0        0             0
> 
> It shows small differences with real hardware due other missing
> peripherals for which the driver turn the clock off (like tsens).
> 
> Luc Michel (15):
>    hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
>    hw/core/clock: trace clock values in Hz instead of ns
>    hw/core/clock: add the clock_new helper function
>    hw/arm/raspi: fix CPRMAN base address
>    hw/arm/raspi: add a skeleton implementation of the CPRMAN
>    hw/misc/bcm2835_cprman: add a PLL skeleton implementation
>    hw/misc/bcm2835_cprman: implement PLLs behaviour
>    hw/misc/bcm2835_cprman: add a PLL channel skeleton implementation
>    hw/misc/bcm2835_cprman: implement PLL channels behaviour
>    hw/misc/bcm2835_cprman: add a clock mux skeleton implementation
>    hw/misc/bcm2835_cprman: implement clock mux behaviour
>    hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
>    hw/misc/bcm2835_cprman: add sane reset values to the registers
>    hw/char/pl011: add a clock input
>    hw/arm/bcm2835_peripherals: connect the UART clock
> 
>   include/hw/arm/bcm2835_peripherals.h       |    5 +-
>   include/hw/arm/raspi_platform.h            |    5 +-
>   include/hw/char/pl011.h                    |    1 +
>   include/hw/clock.h                         |   18 +
>   include/hw/misc/bcm2835_cprman.h           |  210 ++++
>   include/hw/misc/bcm2835_cprman_internals.h | 1019 ++++++++++++++++++++
>   hw/arm/bcm2835_peripherals.c               |   15 +-
>   hw/char/pl011.c                            |   45 +
>   hw/core/clock.c                            |   21 +-
>   hw/misc/bcm2835_cprman.c                   |  808 ++++++++++++++++
>   hw/char/trace-events                       |    1 +
>   hw/core/trace-events                       |    4 +-
>   hw/misc/meson.build                        |    1 +
>   hw/misc/trace-events                       |    5 +
>   14 files changed, 2146 insertions(+), 12 deletions(-)
>   create mode 100644 include/hw/misc/bcm2835_cprman.h
>   create mode 100644 include/hw/misc/bcm2835_cprman_internals.h
>   create mode 100644 hw/misc/bcm2835_cprman.c
> 

