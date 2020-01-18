Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A94FC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C4121739
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmAq0C4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C4121739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istfF-0005ex-9z
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1istaA-0008RA-DA
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ista7-0001Ol-TX
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:16:30 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ista7-0001NF-Jv; Sat, 18 Jan 2020 14:16:27 -0500
Received: by mail-wm1-x342.google.com with SMTP id d73so10552527wmd.1;
 Sat, 18 Jan 2020 11:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=293nwiyuaOamswqMc0EVTlOq8q0MzXCBPubm+nvXYDI=;
 b=QmAq0C4PRgdnUb7wZfnqw6Spi6JmLykluvhuT7NtN9az4KFrxCpoHwgQ40tLOEa6yx
 7VoVE9Gq6fJ09G1fRViBEqifvV/aabz+dOWJnPzP8IHTJoa79UGSaMGvQPtLBInuNgNZ
 nLBB2YHNeT93sRMu6/ORpIevi9dsXc90e2D3S8PYT1eqm/4ZfkgCwOJZjwys5CrWDIiE
 kRawG93I0AWtYFLH3QE0TEl/Huaowv1DDvZ2WJxoRji/z9TewgPnwEy6ydRoeG5u7l/6
 WfzfDpYEq3WVoU+oTAEorG8hMb+DbclFxTwIcfNlsMZ1kcQx9e+PLF7cY+c3PX4k3rhF
 lsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=293nwiyuaOamswqMc0EVTlOq8q0MzXCBPubm+nvXYDI=;
 b=enjTScK3/xbgxsUzoemhvncQyUbubWyQlAKS8+303l95saHOLRiKjxTI6xdt39W3e0
 madYnT8344Cmz+XiHq5FCteVJ+84baWz+5w75QHpgI2JrvsvqMcE9n9Z0g1rd4dEJwFo
 Lc8vY3/LGbEU6G1zNr8kR2WytRExo5fxHpFEwKcwRo3tmsIDzaRgY1CHsZI/XkghfqbY
 aaFG4jnPLln3cpuoR6I5Ar6sZ0gvEiwxSs7fWmJ8EriXB+CAPmCUp6kD4RVlefKsNrMV
 6xShDGvNoQ/5xR2OQbl5WUsBL7eR+XMeLFOFqc1jd4Zwru4gCymsN/d/JNjcC1D2UkUn
 YCmA==
X-Gm-Message-State: APjAAAWypa1Y2uSF8g/O4juZtitVrHZ/AGabUjiFanrO1CPyYBEMqpTv
 wcD7mlZHmn7z12xbo7Q487GEm/vZ
X-Google-Smtp-Source: APXvYqwJW4dWmYd3pwy5SUXrSS/4WS63NkWDB63fBwf4YX+K/2QLbRtKKwft3wGdNyiKTS6zSY0MHg==
X-Received: by 2002:a05:600c:210e:: with SMTP id
 u14mr10650326wml.28.1579374985597; 
 Sat, 18 Jan 2020 11:16:25 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z11sm41339690wrt.82.2020.01.18.11.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 11:16:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 0/4] tests/boot_linux_console: Test booting NetBSD via U-Boot
 on OrangePi PC
Date: Sat, 18 Jan 2020 20:16:19 +0100
Message-Id: <20200118191623.32549-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series add a test on the OrangePi PC for:
- SD Card booting
- U-boot & UART
- NetBSD 9

I simply followed Niek description in docs/orangepi.rst:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg669347.html

The sdcard image is big, but the test runs very quick (1min),
even on Travis CI: https://travis-ci.org/philmd/qemu/jobs/638823612#L3778

(11/48) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9:  PASS (65.17 s)

  $ TMPDIR=/tmp AVOCADO_ALLOW_LARGE_STORAGE=yes avocado --show=app,console run -t machine:orangepi-pc tests/acceptance/boot_linux_console.py
  JOB ID     : 4e11f0d22d121fd766ab5f0956ec464cf9fce64b
  JOB LOG    : /home/phil/avocado/job-results/job-2020-01-18T19.14-4e11f0d/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9:
  console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
  console: DRAM: 1024 MiB
  console: Failed to set core voltage! Can't set CPU frequency
  console: Trying to boot from MMC1
  console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner Technology
  console: CPU:   Allwinner H3 (SUN8I 0000)
  console: Model: Xunlong Orange Pi Plus / Plus 2
  console: DRAM:  1 GiB
  console: MMC:   Device 'mmc@1c11000': seq 1 is in use by 'mmc@1c10000'
  console: mmc@1c0f000: 0, mmc@1c10000: 2, mmc@1c11000: 1
  console: Loading Environment from FAT... Warning: HDMI PHY init timeout!
  console: Warning: HDMI PHY init timeout!
  console: In:    serial
  console: Out:   serial
  console: Err:   serial
  console: Net:   phy interface7
  console: Could not get PHY for ethernet@1c30000: addr 0
  console: No ethernet found.
  console: starting USB...
  console: Bus usb@1c1b000: USB EHCI 1.00
  console: Bus usb@1c1d000: USB EHCI 1.00
  console: scanning bus usb@1c1b000 for devices... 1 USB Device(s) found
  console: scanning bus usb@1c1d000 for devices... 1 USB Device(s) found
  console: scanning usb for storage devices... 0 Storage Device(s) found
  console: Hit any key to stop autoboot:  0
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: =>
  console: => setenv bootargs root=ld0a
  console: => setenv kernel netbsd-GENERIC.ub
  console: => setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb
  console: => setenv bootcmd 'fatload mmc 0:1 ${kernel_addr_r} ${kernel}; fatload mmc 0:1 ${fdt_addr_r} ${fdtfile}; fdt addr ${fdt_addr_r}; bootm ${kernel_addr_r} - ${fdt_addr_r}'
  console: => boot
  console: 8850008 bytes read in 2583 ms (3.3 MiB/s)
  console: 28162 bytes read in 34 ms (808.6 KiB/s)
  console: ## Booting kernel from Legacy Image at 42000000 ...
  console: Image Name:   NetBSD/earmv7hf 9.0_RC1
  console: Image Type:   ARM Linux Kernel Image (no loading done) (uncompressed)
  console: Data Size:    8849944 Bytes = 8.4 MiB
  console: Load Address: 00000000
  console: Entry Point:  00000000
  console: Verifying Checksum ... OK
  console: ## Flattened Device Tree blob at 43000000
  console: Booting using the fdt blob at 0x43000000
  console: XIP Kernel Image (no loading done)
  console: Loading Device Tree to 49ff6000, end 49fffe01 ... OK
  console: Starting kernel ...
  console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
  console: [   1.0000000] [ Kernel symbol table missing! ]
  console: [   1.0000000] Copyright (c) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
  console: [   1.0000000]     2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017,
  console: [   1.0000000]     2018, 2019 The NetBSD Foundation, Inc.  All rights reserved.
  console: [   1.0000000] Copyright (c) 1982, 1986, 1989, 1991, 1993
  console: [   1.0000000]     The Regents of the University of California.  All rights reserved.
  console: [   1.0000000] NetBSD 9.0_RC1 (GENERIC) #0: Wed Nov 27 16:14:52 UTC 2019
  console: [   1.0000000]         mkrepro@mkrepro.NetBSD.org:/usr/src/sys/arch/evbarm/compile/GENERIC
  console: [   1.0000000] total memory = 1024 MB
  console: [   1.0000000] avail memory = 1003 MB
  console: [   1.0000000] armfdt0 (root)
  console: [   1.0000000] simplebus0 at armfdt0: Xunlong Orange Pi PC
  console: [   1.0000000] simplebus1 at simplebus0
  console: [   1.0000000] simplebus2 at simplebus0
  console: [   1.0000000] cpus0 at simplebus0
  console: [   1.0000000] simplebus3 at simplebus0
  console: [   1.0000000] cpu0 at cpus0: Cortex-A7 r0p5 (Cortex V7A core)
  console: [   1.0000000] cpu0: DC enabled IC enabled WB enabled LABT branch prediction enabled
  console: [   1.0000000] cpu0: 32KB/64B 2-way L1 VIPT Instruction cache
  console: [   1.0000000] cpu0: 32KB/64B 2-way write-back-locking-C L1 PIPT Data cache
  console: [   1.0000000] cpu0: 2304KB/64B 16-way write-through L2 PIPT Unified cache
  console: [   1.0000000] vfp0 at cpu0: NEON MPE (VFP 3.0+), rounding, NaN propagation, denormals
  console: [   1.0000000] cpufreqdt0 at cpu0
  console: [   1.0000000] cpu1 at cpus0
  console: [   1.0000000] cpufreqdt1 at cpu1
  console: [   1.0000000] cpu2 at cpus0
  console: [   1.0000000] cpufreqdt2 at cpu2
  console: [   1.0000000] cpu3 at cpus0
  console: [   1.0000000] cpufreqdt3 at cpu3
  console: [   1.0000000] gic0 at simplebus1: GIC
  console: [   1.0000000] armgic0 at gic0: Generic Interrupt Controller, 160 sources (160 valid)
  console: [   1.0000000] armgic0: 256 Priorities, 128 SPIs, 16 PPIs, 16 SGIs
  console: [   1.0000000] fclock0 at simplebus2: 24000000 Hz fixed clock (osc24M)
  console: [   1.0000000] fclock1 at simplebus2: 32768 Hz fixed clock (ext_osc32k)
  console: [   1.0000000] gtmr0 at simplebus0: Generic Timer
  console: [   1.0000000] gtmr0: interrupting on GIC irq 27
  console: [   1.0000000] armgtmr0 at gtmr0: Generic Timer (24000 kHz, virtual)
  console: [   1.0000060] sun8ih3ccu0 at simplebus1: H3 CCU
  console: [   1.0000060] sun8ih3rccu0 at simplebus1: H3 PRCM CCU
  console: [   1.0000060] sunxigpio0 at simplebus1: PIO
  console: [   1.0000060] gpio0 at sunxigpio0: 94 pins
  console: [   1.0000060] sunxigpio0: interrupting on GIC irq 43
  console: [   1.0000060] sunxigpio1 at simplebus1: PIO
  console: [   1.0000060] gpio1 at sunxigpio1: 12 pins
  console: [   1.0000060] sunxigpio1: interrupting on GIC irq 77
  console: [   1.0000060] sunxisramc0 at simplebus1: SRAM Controller
  console: [   1.0000060] sun6idma0 at simplebus1: DMA controller (12 channels)
  console: [   1.0000060] sun6idma0: interrupting on GIC irq 82
  console: [   1.0000060] connector0 at simplebus0: HDMI connector
  console: [   1.0000060] com0 at simplebus1: ns16550a, working fifo
  console: [   1.0000060] com0: console
  console: [   1.0000060] com0: interrupting on GIC irq 32
  console: [   1.0000060] fregulator0 at simplebus0: vcc3v3
  console: [   1.0000060] fregulator1 at simplebus0: usb0-vbus
  console: [   1.0000060] fregulator2 at simplebus0: vcc3v0
  console: [   1.0000060] fregulator3 at simplebus0: vcc5v0
  console: [   1.0000060] sunxiusbphy0 at simplebus1: USB PHY
  console: [   1.0000060] /soc/clock@1000000 at simplebus1 not configured
  console: [   1.0000060] /soc/mixer@1100000 at simplebus1 not configured
  console: [   1.0000060] /soc/lcd-controller@1c0c000 at simplebus1 not configured
  console: [   1.0000060] /soc/hdmi@1ee0000 at simplebus1 not configured
  console: [   1.0000060] sunxirtc0 at simplebus1: RTC
  console: [   1.0000060] emac0 at simplebus1: EMAC
  console: [   1.0000060] emac0: Ethernet address 52:54:00:12:34:56
  console: [   1.0000060] emac0: interrupting on GIC irq 114
  console: [   1.0000060] ukphy0 at emac0 phy 1: OUI 0x0088a0, model 0x0000, rev. 0
  console: [   1.0000060] ukphy0: 10baseT, 10baseT-FDX, 100baseTX, 100baseTX-FDX, 100baseT4, auto
  console: [   1.0000060] h3codec0 at simplebus1: H3 Audio Codec (analog part)
  console: [   1.0000060] /soc/hdmi-phy@1ef0000 at simplebus1 not configured
  console: [   1.0000060] /opp_table0 at simplebus0 not configured
  console: [   1.0000060] sunxitwi0 at simplebus1: Marvell TWSI controller
  console: [   1.0000060] sunxitwi0: interrupting on GIC irq 76
  console: [   1.0000060] iic0 at sunxitwi0: I2C bus
  console: [   1.0000060] sy8106a0 at iic0 addr 0x65: Silergy SY8106A regulator
  console: [   1.0000060] /display-engine at simplebus0 not configured
  console: [   1.0000060] sunximmc0 at simplebus1: SD/MMC controller
  console: [   1.0000060] sunximmc0: interrupting on GIC irq 92
  console: [   1.0000060] motg0 at simplebus1: 'otg' mode not supported
  console: [   1.0000060] ehci0 at simplebus1: EHCI
  console: [   1.0000060] ehci0: interrupting on GIC irq 104
  console: ehci0: ohci or uhci probably not configured
  console: [   1.0000060] usb0 at ehci0: USB revision 2.0
  console: [   1.0000060] ohci0 at simplebus1: OHCI
  console: [   1.0000060] ohci0: interrupting on GIC irq 105
  console: [   1.0000060] ohci0: OHCI version 1.0
  console: [   1.0000060] usb1 at ohci0: USB revision 1.0
  console: [   1.0000060] ehci1 at simplebus1: EHCI
  console: [   1.0000060] ehci1: interrupting on GIC irq 106
  console: ehci1: ohci or uhci probably not configured
  console: [   1.0000060] usb2 at ehci1: USB revision 2.0
  console: [   1.0000060] ohci1 at simplebus1: OHCI
  console: [   1.0000060] ohci1: interrupting on GIC irq 107
  console: [   1.0000060] ohci1: OHCI version 1.0
  -console: [   1.0000060] usb3 at ohci1: USB revision 1.0
  console: [   1.0000060] ehci2 at simplebus1: EHCI
  console: [   1.0000060] ehci2: interrupting on GIC irq 108
  console: ehci2: ohci or uhci probably not configured
  console: [   1.0000060] usb4 at ehci2: USB revision 2.0
  console: [   1.0000060] ohci2 at simplebus1: OHCI
  console: [   1.0000060] ohci2: interrupting on GIC irq 109
  console: [   1.0000060] ohci2: OHCI version 1.0
  console: [   1.0000060] usb5 at ohci2: USB revision 1.0
  console: [   1.0000060] ehci3 at simplebus1: EHCI
  console: [   1.0000060] ehci3: interrupting on GIC irq 110
  console: ehci3: ohci or uhci probably not configured
  console: [   1.0000060] usb6 at ehci3: USB revision 2.0
  console: [   1.0000060] ohci3 at simplebus1: OHCI
  console: [   1.0000060] ohci3: interrupting on GIC irq 111
  console: [   1.0000060] ohci3: OHCI version 1.0
  console: [   1.0000060] usb7 at ohci3: USB revision 1.0
  console: [   1.0000060] sunxiwdt0 at simplebus1: Watchdog
  console: [   1.0000060] sunxiwdt0: default watchdog period is 16 seconds
  console: [   1.0000060] sunxicodec0 at simplebus1: H3 Audio Codec
  console: [   1.0000060] audio0 at sunxicodec0: playback, capture, full duplex, independent
  console: [   1.0000060] audio0: slinear_le:16 2ch 48000Hz, blk 40ms for playback
  console: [   1.0000060] audio0: slinear_le:16 2ch 48000Hz, blk 40ms for recording
  console: [   1.0000060] spkr0 at audio0: PC Speaker (synthesized)
  console: [   1.0000060] wsbell at spkr0 not configured
  console: [   1.0000060] /soc/ir@1f02000 at simplebus1 not configured
  console: [   1.0000060] /soc/gpu@1c40000 at simplebus1 not configured
  console: [   1.0000060] psci0 at simplebus0: PSCI 0.1
  console: [   1.0000060] gpioleds0 at simplebus0: orangepi:green:pwr orangepi:red:status
  console: [   1.0000060] gpiokeys0 at simplebus0: sw4
  console: [   1.0000060] sunxitimer0 at simplebus1: Timer
  console: [   1.0000060] /soc/video-codec@1c0e000 at simplebus1 not configured
  console: [   1.0000060] cpu3: Cortex-A7 r0p5 (Cortex V7A core)
  console: [   1.0000060] cpu3: DC enabled IC enabled WB enabled LABT branch prediction enabled
  console: [   1.0000060] cpu3: 32KB/64B 2-way L1 VIPT Instruction cache
  console: [   1.0000060] cpu3: 32KB/64B 2-way write-back-locking-C L1 PIPT Data cache
  console: [   1.0160154] cpu3: 2304KB/64B 16-way write-through L2 PIPT Unified cache
  console: [   1.0234452] vfp3 at cpu3: NEON MPE (VFP 3.0+), rounding, NaN propagation, denormals
  console: [   1.0291986] cpu1: Cortex-A7 r0p5 (Cortex V7A core)
  console: [   1.0291986] cpu1: DC enabled IC enabled WB enabled LABT branch prediction enabled
  console: [   1.0291986] cpu1: 32KB/64B 2-way L1 VIPT Instruction cache
  console: [   1.0394135] cpu1: 32KB/64B 2-way write-back-locking-C L1 PIPT Data cache
  console: [   1.0394135] cpu1: 2304KB/64B 16-way write-through L2 PIPT Unified cache
  console: [   1.0394135] vfp1 at cpu1: NEON MPE (VFP 3.0+), rounding, NaN propagation, denormals
  console: [   1.0493315] cpu2: Cortex-A7 r0p5 (Cortex V7A core)
  console: [   1.0634020] cpu2: DC enabled IC enabled WB enabled LABT branch prediction enabled
  console: [   1.0694913] cpu2: 32KB/64B 2-way L1 VIPT Instruction cache
  console: [   1.0694913] cpu2: 32KB/64B 2-way write-back-locking-C L1 PIPT Data cache
  console: [   1.0806243] cpu2: 2304KB/64B 16-way write-through L2 PIPT Unified cache
  console: [   1.0896281] vfp2 at cpu2: NEON MPE (VFP 3.0+), rounding, NaN propagation, denormals
  console: [   1.6053940] sdmmc0 at sunximmc0
  console: [   1.9566931] uhub0 at usb0: NetBSD (0000) EHCI root hub (0000), class 9/0, rev 2.00/1.00, addr 1
  console: [   2.0663940] uhub1 at usb2: NetBSD (0000) EHCI root hub (0000), class 9/0, rev 2.00/1.00, addr 1
  console: [   2.1170633] uhub2 at usb1: NetBSD (0000) OHCI root hub (0000), class 9/0, rev 1.00/1.00, addr 1
  console: [   2.2277627] uhub3 at usb4: NetBSD (0000) EHCI root hub (0000), class 9/0, rev 2.00/1.00, addr 1
  console: [   2.2800297] uhub4 at usb3: NetBSD (0000) OHCI root hub (0000), class 9/0, rev 1.00/1.00, addr 1
  console: [   2.3289886] uhub5 at usb6: NetBSD (0000) EHCI root hub (0000), class 9/0, rev 2.00/1.00, addr 1
  console: [   2.4083724] uhub6 at usb7: NetBSD (0000) OHCI root hub (0000), class 9/0, rev 1.00/1.00, addr 1
  console: [   2.4895047] uhub7 at usb5: NetBSD (0000) OHCI root hub (0000), class 9/0, rev 1.00/1.00, addr 1
  console: [   2.8171937] sdmmc0: SD card status: 4-bit, C0
  console: [   2.8234040] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
  console: [   2.8743967] ld0: 1290 MB, 655 cyl, 64 head, 63 sec, 512 bytes/sect x 2642944 sectors
  console: [   3.1588850] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
  console: [   4.9942260] WARNING: 4 errors while detecting hardware; check system log.
  console: [   5.0142912] boot device: ld0
  console: [   5.0551260] root on ld0a dumps on ld0b
  console: [   5.2175484] root file system type: ffs
  console: [   5.2858559] kern.module.path=/stand/evbarm/9.0/modules
  console: Tue Jan 18 18:15:15 UTC 2050
  console: Starting root file system check:
  PASS (35.96 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 36.09 s

Based-on: <20200108200020.4745-1-nieklinnenbank@gmail.com>
"Add Allwinner H3 SoC and Orange Pi PC Machine" v3
https://www.mail-archive.com/qemu-devel@nongnu.org/msg669328.html

Philippe Mathieu-Daudé (4):
  Acceptance tests: Extract _console_interaction()
  Acceptance tests: Add interrupt_interactive_console_until_pattern()
  tests/boot_linux_console: Test booting NetBSD via U-Boot on OrangePi
    PC
  .travis.yml: Allow untrusted code and large files

 .travis.yml                               |  2 +
 tests/acceptance/avocado_qemu/__init__.py | 59 ++++++++++++++++-----
 tests/acceptance/boot_linux_console.py    | 63 +++++++++++++++++++++++
 3 files changed, 110 insertions(+), 14 deletions(-)

-- 
2.21.1


