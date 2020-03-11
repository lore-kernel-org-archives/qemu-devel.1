Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672C7C2BAEE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FA820751
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWw3j3qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FA820751
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC9i6-00059l-DB
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC9gx-0003cE-BK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC9gv-0004bR-Qw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:19:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jC9gv-0004Zw-Ks; Wed, 11 Mar 2020 18:19:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id h83so472315wmf.3;
 Wed, 11 Mar 2020 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c35f1rDGvPHKyuTytbQ2vfYuWvGKvBDCH4Yc9uo6TqE=;
 b=jWw3j3qR6NPt2lDt3erDSAYq3SHkuwwvnIg1klXMmahMO+rqUKe8Y/Ty5GhloKMxKD
 m3RWfzMGfiKT2faCirMSdtlFwWAw5UOVVcWJ+67GLMhy7oI33u+PWAY90UGR1IIThksN
 i6MbzzidxrLC/c04nHB57jK4XjJKqt7K0Gi0z3AjPn4K5Ts3i84rXkRiyKoKTFVoapZa
 pXcCDOvmw0Z8vM4yx418rPpb/5YjJL+bsq6xmSrnhhJ9VyICoSnSWdFA748URF9ne5lH
 vTyEc/aNbdnFm6lG92y9TY1SXEPbR2Z61zS/b6P9lUwb/GonFI5hlJj6ZlA67gcGALLQ
 SXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c35f1rDGvPHKyuTytbQ2vfYuWvGKvBDCH4Yc9uo6TqE=;
 b=AsEF+tuTacycN6PkQaTL0h7fDvTpAlOa69hZjLu+Mksv8EVHLHyeOm4zPVIrRCF3kt
 2oJbwuMBVybmHctDwQP2ZtotuKs6BYf9Hzl4seMC2bCM2RW7rh+kCgZhumDm9YF0mxHd
 JPGeF1t/tt4OyJ6C+ifuE8dKzdvaNAoI6kCkJJxwZgopt4rFmXpSfe8c4rRN5lKYUNJ2
 Lbt3+9lvIMHXs5Q6eY3ygp78STz7kZBBplB4FKiR42AwezPgbgVd/FbGVbIWSlmOeDBc
 txuWOeVPOexRUc9JX2UhlGkY8EFd/Ejuzc0Tz+mj5M2/kZhfZbLTbX809jqwYtu3phkp
 2Clg==
X-Gm-Message-State: ANhLgQ0h4Q59FHh9ho4oGlzOjVOWeszhCj81JXXyNB4WkLwFexV7yFNe
 mpfg1hd3VYYU2xHgTvglg4a0E8vU
X-Google-Smtp-Source: ADFU+vt7cXndHJxG7snUWiWC3JPyTuihEFjsZc8RKIG2yohbPG6dB2piWK5zNL3pvH+GHvBU31lUow==
X-Received: by 2002:a7b:cd13:: with SMTP id f19mr911286wmj.10.1583965143858;
 Wed, 11 Mar 2020 15:19:03 -0700 (PDT)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id q7sm19346796wrd.54.2020.03.11.15.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 15:19:03 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/18] Add Allwinner H3 SoC and Orange Pi PC Machine
Date: Wed, 11 Mar 2020 23:18:36 +0100
Message-Id: <20200311221854.30370-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear QEMU developers,

Hereby I would like to contribute the following set of patches to QEMU
which add support for the Allwinner H3 System on Chip and the
Orange Pi PC machine. The following features and devices are supported:

 * SMP (Quad Core Cortex A7)
 * Generic Interrupt Controller configuration
 * SRAM mappings
 * SDRAM controller
 * Real Time Clock
 * Timer device (re-used from Allwinner A10)
 * UART
 * SD/MMC storage controller
 * EMAC ethernet
 * USB 2.0 interfaces
 * Clock Control Unit
 * System Control module
 * Security Identifier device

Functionality related to graphical output such as HDMI, GPU,
Display Engine and audio are not included. Recently released
mainline Linux kernels (4.19 up to latest master), mainline U-Boot
and NetBSD 9.0 are known to work.

For full details on how to use the Orange Pi PC machine, see the file
docs/system/orangepi.rst which is included as a patch in this series.

The contents of this patch series is available on Github at:

  https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v8

The followings are currently known issues in this series:

  - RTC date & time is not persistent
  - boot0 custom Allwinner bootloader not yet working
  - Watchdog not yet implemented, affects U-Boot 'reset' and shutdown/reboot
     -> This is part of the existing A10 timer that needs to be generalized first

Looking forward to your review comments. I will do my best
to update the patches where needed.

===== CHANGELOG =====
v8:
 * hw/arm/allwinner-h3.c: use g_autofree for buffer variable in BootROM setup function
 * hw/arm/orangepi.c: use warn_report to give warning to user when overriding SID without H3 SoC prefix

v7: https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg02864.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v7

v6: https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00046.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v6

v5: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04525.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v5

v4: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg03960.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v4

v3: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg01534.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v3

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03265.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v2

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00320.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v1

With kind regards,

Niek Linnenbank

Niek Linnenbank (13):
  hw/arm: add Allwinner H3 System-on-Chip
  hw/arm: add Xunlong Orange Pi PC machine
  hw/arm/allwinner-h3: add Clock Control Unit
  hw/arm/allwinner-h3: add USB host controller
  hw/arm/allwinner-h3: add System Control module
  hw/arm/allwinner: add CPU Configuration module
  hw/arm/allwinner: add Security Identifier device
  hw/arm/allwinner: add SD/MMC host controller
  hw/arm/allwinner-h3: add EMAC ethernet device
  hw/arm/allwinner-h3: add Boot ROM support
  hw/arm/allwinner-h3: add SDRAM controller device
  hw/arm/allwinner: add RTC device support
  docs: add Orange Pi PC document

Philippe Mathieu-Daudé (5):
  tests/boot_linux_console: Add a quick test for the OrangePi PC board
  tests/boot_linux_console: Add initrd test for the Orange Pi PC board
  tests/boot_linux_console: Add a SD card test for the OrangePi PC board
  tests/boot_linux_console: Add a SLOW test booting Ubuntu on OrangePi
    PC
  tests/boot_linux_console: Test booting NetBSD via U-Boot on OrangePi
    PC

 docs/system/orangepi.rst               | 253 +++++++
 docs/system/target-arm.rst             |   2 +
 default-configs/arm-softmmu.mak        |   1 +
 hw/usb/hcd-ehci.h                      |   1 +
 include/hw/arm/allwinner-a10.h         |   4 +
 include/hw/arm/allwinner-h3.h          | 161 +++++
 include/hw/misc/allwinner-cpucfg.h     |  52 ++
 include/hw/misc/allwinner-h3-ccu.h     |  66 ++
 include/hw/misc/allwinner-h3-dramc.h   | 106 +++
 include/hw/misc/allwinner-h3-sysctrl.h |  67 ++
 include/hw/misc/allwinner-sid.h        |  60 ++
 include/hw/net/allwinner-sun8i-emac.h  |  99 +++
 include/hw/rtc/allwinner-rtc.h         | 134 ++++
 include/hw/sd/allwinner-sdhost.h       | 135 ++++
 hw/arm/allwinner-a10.c                 |  19 +
 hw/arm/allwinner-h3.c                  | 465 +++++++++++++
 hw/arm/cubieboard.c                    |  15 +
 hw/arm/orangepi.c                      | 130 ++++
 hw/misc/allwinner-cpucfg.c             | 282 ++++++++
 hw/misc/allwinner-h3-ccu.c             | 242 +++++++
 hw/misc/allwinner-h3-dramc.c           | 358 ++++++++++
 hw/misc/allwinner-h3-sysctrl.c         | 140 ++++
 hw/misc/allwinner-sid.c                | 168 +++++
 hw/net/allwinner-sun8i-emac.c          | 871 +++++++++++++++++++++++++
 hw/rtc/allwinner-rtc.c                 | 411 ++++++++++++
 hw/sd/allwinner-sdhost.c               | 854 ++++++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c               |  17 +
 MAINTAINERS                            |   9 +
 hw/arm/Kconfig                         |  12 +
 hw/arm/Makefile.objs                   |   1 +
 hw/misc/Makefile.objs                  |   5 +
 hw/misc/trace-events                   |  19 +
 hw/net/Kconfig                         |   3 +
 hw/net/Makefile.objs                   |   1 +
 hw/net/trace-events                    |  10 +
 hw/rtc/Makefile.objs                   |   1 +
 hw/rtc/trace-events                    |   4 +
 hw/sd/Makefile.objs                    |   1 +
 hw/sd/trace-events                     |   7 +
 tests/acceptance/boot_linux_console.py | 230 +++++++
 40 files changed, 5416 insertions(+)
 create mode 100644 docs/system/orangepi.rst
 create mode 100644 include/hw/arm/allwinner-h3.h
 create mode 100644 include/hw/misc/allwinner-cpucfg.h
 create mode 100644 include/hw/misc/allwinner-h3-ccu.h
 create mode 100644 include/hw/misc/allwinner-h3-dramc.h
 create mode 100644 include/hw/misc/allwinner-h3-sysctrl.h
 create mode 100644 include/hw/misc/allwinner-sid.h
 create mode 100644 include/hw/net/allwinner-sun8i-emac.h
 create mode 100644 include/hw/rtc/allwinner-rtc.h
 create mode 100644 include/hw/sd/allwinner-sdhost.h
 create mode 100644 hw/arm/allwinner-h3.c
 create mode 100644 hw/arm/orangepi.c
 create mode 100644 hw/misc/allwinner-cpucfg.c
 create mode 100644 hw/misc/allwinner-h3-ccu.c
 create mode 100644 hw/misc/allwinner-h3-dramc.c
 create mode 100644 hw/misc/allwinner-h3-sysctrl.c
 create mode 100644 hw/misc/allwinner-sid.c
 create mode 100644 hw/net/allwinner-sun8i-emac.c
 create mode 100644 hw/rtc/allwinner-rtc.c
 create mode 100644 hw/sd/allwinner-sdhost.c

-- 
2.17.1

