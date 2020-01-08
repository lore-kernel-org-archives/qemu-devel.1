Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B461CC33CA2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8248D20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/vWRaWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8248D20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAaG-0000Pv-50
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWD-0003ZM-7f
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWB-0004Bi-PP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:56006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWB-0004BE-IH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:32:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id q9so2275380wmj.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lckuBL5tj6x75rcei0OEN2930GIvL6FAWF6DsoXsxj8=;
 b=q/vWRaWoy5Xu+TOb4S3naQrFNno6CyTcPuyJroFhoGNlP4sCq+aUsbpMkhVYBhxV5C
 3MeB0Mo5NQSE31u4e/1v0BWqWv+zQrsMlQ4k1xIQfJXzPsMr1VnYO+XtNXwpl0vlqJGV
 nSfIeS8h6I67eFmCbcGuqIagKiy5V7QMnxQ82XwAnj3MobDJcY1D3nS3h2PS7I5XfIEd
 cyBQ2VKFwTAtupSM8PMgqrBaLvH6+NNucnM2y11MlhjRq5sAlJ4QW9nTIA4wWZVJdUt6
 Kkiu+9j51AkShIyQPFEEeK471Aw29GkBS6kc9W57ggVW8P7pxP1eiE8I70a1sQEMMpzT
 43oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=lckuBL5tj6x75rcei0OEN2930GIvL6FAWF6DsoXsxj8=;
 b=tU2DblKLwQ40mTSBm4hz4xdl/EC7dTJsUUO0UXHJYdN0R3RaB/Ukmf7OYauZUtjEdS
 ROChoCXOfFqbmtJ0APtJab2waugXDO52pTYJS2MmDEkHYWXNJvjd1B6do3RJyAC4oaT4
 MIHUnOrk3rS4RC+Se2KO5znItIQH/dObbQ3EbZN6LJZHTZFEKscriCvITcsMcLBP0BBl
 vLCykke27K1ZMYH8o5yAuY1SLxS6rf30yj9S2RHc1Y3rMFLl/gNNnCfi88iuvdqXjQKr
 Tk3q+e38vcHeueKvfiDlocxECzUBzXyyLwkk3mARO6NM/beMgTbvg6SI1Z2DQIirSquq
 hkPA==
X-Gm-Message-State: APjAAAVEs/qJNHKRlxqgChkQAxvBpolT/M44HA6TOmm+QhOdD4X8tgkU
 hhdKG9Fz+Jn3fpeZfjzoyy9OchD/
X-Google-Smtp-Source: APXvYqzTjd5AUFpeufJysfcXLEVazd2PZ7PBPlYVHN63nIEmP+fTRo5drgDeGL0dsWwy5pEqUmKKvg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr3608816wmi.51.1578486777407;
 Wed, 08 Jan 2020 04:32:57 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.32.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:32:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/38] Misc patches for 2020-01-08
Date: Wed,  8 Jan 2020 13:32:17 +0100
Message-Id: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

The following changes since commit c4d1069c2563f70a5271af6e9e000add64e593be:

  Merge remote-tracking branch 'remotes/elmarco/tags/dbus-vmstate7-pull-request' into staging (2020-01-06 18:22:42 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 083b266f69f36195aef22cb224f86b99ca0d6feb:

  chardev: Use QEMUChrEvent enum in IOEventHandler typedef (2020-01-08 11:15:35 +0100)

----------------------------------------------------------------
* Compat machines fix (Denis)
* Command line parsing fixes (Michal, Peter, Xiaoyao)
* Cooperlake CPU model fixes (Xiaoyao)
* i386 gdb fix (mkdolata)
* IOEventHandler cleanup (Philippe)
* icount fix (Pavel)
* RR support for random number sources (Pavel)
* Kconfig fixes (Philippe)

----------------------------------------------------------------
Denis Plotnikov (1):
      hw: fix using 4.2 compat in 5.0 machine types for i440fx/q35

Michal Privoznik (1):
      x86: Check for machine state object class before typecasting it

Paolo Bonzini (1):
      chardev: use QEMUChrEvent instead of int

Pavel Dovgaluk (2):
      replay: check other timers for icount limit
      replay: record and replay random number sources

Peter Wu (1):
      hw/i386/pc: fix regression in parsing vga cmdline parameter

Philippe Mathieu-Daudé (28):
      hw/i386/x86-iommu: Add missing stubs
      hw/timer/Kconfig: Intel 8254 PIT depends of ISA bus
      hw/usb/redirect: Do not link 'usb-redir' device when USB not enabled
      hw/intc/i8259: Fix Kconfig dependency on ISA bus
      hw/i386/Kconfig: Let the MicroVM machine select the SERIAL_ISA config
      hw/ppc/Kconfig: Restrict the MPC I2C controller to e500-based platforms
      hw/ppc/Kconfig: Let the Sam460ex board use the PowerPC 405 devices
      hw/ppc/Kconfig: Let the Xilinx Virtex5 ML507 use the PPC-440 devices
      hw/ppc/Makefile: Simplify the sPAPR PCI objects rule
      hw/ppc/Kconfig: Only select fw_cfg with machines using OpenBIOS
      hw/ppc/Kconfig: Only select FDT helper for machines using it
      hw/nvram/Kconfig: Add an entry for the NMC93xx EEPROM
      hw/nvram/Kconfig: Restrict CHRP NVRAM to machines using OpenBIOS or SLOF
      hw/rtc/mc146818: Add missing dependency on ISA Bus
      hw/ipmi: Remove unnecessary declarations
      hw/ipmi: Explicit we ignore some QEMUChrEvent in IOEventHandler
      hw/char/terminal3270: Explicit ignored QEMUChrEvent in IOEventHandler
      hw/usb/dev-serial: Explicit we ignore few QEMUChrEvent in IOEventHandler
      hw/usb/redirect: Explicit we ignore few QEMUChrEvent in IOEventHandler
      ccid-card-passthru: Explicit we ignore QEMUChrEvent in IOEventHandler
      vhost-user-crypto: Explicit we ignore some QEMUChrEvent in IOEventHandler
      vhost-user-net: Explicit we ignore few QEMUChrEvent in IOEventHandler
      vhost-user-blk: Explicit we ignore few QEMUChrEvent in IOEventHandler
      virtio-console: Explicit we ignore some QEMUChrEvent in IOEventHandler
      monitor/qmp: Explicit we ignore few QEMUChrEvent in IOEventHandler
      monitor/hmp: Explicit we ignore a QEMUChrEvent in IOEventHandler
      chardev/char: Explicit we ignore some QEMUChrEvent in IOEventHandler
      chardev: Use QEMUChrEvent enum in IOEventHandler typedef

Xiaoyao Li (3):
      accel/kvm: Make "kernel_irqchip" default on
      target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITIES
      target/i386: Add missed features to Cooperlake CPU model

mkdolata@us.ibm.com (1):
      target/i386: Fix handling of k_gs_base register in 32-bit mode in gdbstub

 accel/kvm/kvm-all.c             | 19 ++++++++++-----
 backends/cryptodev-vhost-user.c |  7 +++++-
 chardev/char-mux.c              |  8 +++----
 chardev/char.c                  |  9 ++++++--
 cpus.c                          |  4 ++++
 default-configs/ppc-softmmu.mak |  1 -
 docs/replay.txt                 |  1 +
 gdbstub.c                       |  2 +-
 hw/arm/pxa2xx.c                 |  2 +-
 hw/arm/strongarm.c              |  2 +-
 hw/block/vhost-user-blk.c       |  7 +++++-
 hw/char/cadence_uart.c          |  2 +-
 hw/char/digic-uart.c            |  2 +-
 hw/char/escc.c                  |  2 +-
 hw/char/etraxfs_ser.c           |  2 +-
 hw/char/exynos4210_uart.c       |  2 +-
 hw/char/grlib_apbuart.c         |  2 +-
 hw/char/imx_serial.c            |  2 +-
 hw/char/ipoctal232.c            |  2 +-
 hw/char/lm32_juart.c            |  2 +-
 hw/char/lm32_uart.c             |  2 +-
 hw/char/mcf_uart.c              |  2 +-
 hw/char/milkymist-uart.c        |  2 +-
 hw/char/nrf51_uart.c            |  2 +-
 hw/char/pl011.c                 |  2 +-
 hw/char/serial.c                |  2 +-
 hw/char/sh_serial.c             |  2 +-
 hw/char/terminal3270.c          |  7 +++++-
 hw/char/virtio-console.c        |  7 +++++-
 hw/char/xilinx_uartlite.c       |  2 +-
 hw/i386/Kconfig                 |  2 +-
 hw/i386/pc_piix.c               |  1 -
 hw/i386/pc_q35.c                |  1 -
 hw/i386/x86-iommu-stub.c        |  9 ++++++++
 hw/i386/x86.c                   |  8 +++----
 hw/intc/Kconfig                 |  1 +
 hw/ipmi/ipmi_bmc_extern.c       | 12 ++++++----
 hw/mips/boston.c                |  2 +-
 hw/mips/mips_malta.c            |  2 +-
 hw/net/Kconfig                  |  2 ++
 hw/nvram/Kconfig                |  8 +++++++
 hw/nvram/Makefile.objs          |  4 ++--
 hw/ppc/Kconfig                  | 20 ++++++++++++++++
 hw/ppc/Makefile.objs            |  9 ++++----
 hw/riscv/riscv_htif.c           |  2 +-
 hw/riscv/sifive_uart.c          |  2 +-
 hw/rtc/Kconfig                  |  1 +
 hw/scsi/Kconfig                 |  1 +
 hw/sparc/Kconfig                |  1 +
 hw/sparc64/Kconfig              |  1 +
 hw/timer/Kconfig                |  1 +
 hw/usb/Makefile.objs            |  2 ++
 hw/usb/ccid-card-passthru.c     |  7 +++++-
 hw/usb/dev-serial.c             |  6 ++++-
 hw/usb/redirect.c               |  7 +++++-
 include/chardev/char-fe.h       |  2 +-
 include/chardev/char-mux.h      |  2 +-
 include/chardev/char.h          |  4 ++--
 include/hw/boards.h             |  3 ---
 include/sysemu/replay.h         |  7 ++++++
 monitor/hmp.c                   |  6 ++++-
 monitor/qmp.c                   |  7 +++++-
 net/filter-mirror.c             |  2 +-
 net/vhost-user.c                |  9 ++++++--
 qtest.c                         |  2 +-
 replay/Makefile.objs            |  3 ++-
 replay/replay-internal.h        |  2 ++
 replay/replay-random.c          | 44 +++++++++++++++++++++++++++++++++++
 replay/replay.c                 |  2 +-
 stubs/replay.c                  |  9 ++++++++
 target/i386/cpu.c               | 51 ++++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h               | 13 +++++++----
 target/i386/gdbstub.c           |  4 ++--
 target/i386/kvm.c               |  1 +
 tests/test-char.c               |  6 ++---
 tests/vhost-user-test.c         |  2 +-
 util/guest-random.c             | 13 +++++++++--
 77 files changed, 324 insertions(+), 92 deletions(-)
 create mode 100644 replay/replay-random.c
-- 
1.8.3.1


