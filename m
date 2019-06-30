Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773CEC5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 10:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465E5204FD
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 10:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dp7n7Gl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465E5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhWzQ-00038z-Iz
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 06:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hhWxN-0001Sh-6b
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hhWxL-0004CX-FR
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:21:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
 id 1hhWxL-0004B3-7H
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:21:11 -0400
Received: by mail-pf1-x443.google.com with SMTP id q10so5112706pff.9
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=2UYQ3yYYDlDIP0MsyiA7Zdsuo4ukrQD2ytHAxPp6tug=;
 b=Dp7n7Gl1mhsB89QHdQW1gMl+Mgw0Zk+x1v9rjtqU38XFdKVZNxuJpDrEitJOmWbq4M
 pIYtKAKwy5/NTB2dRxLlrD2rpDyii3sgehaU6ZASBkeKuMPnpeXcxODbxZ9vdvC5FvkX
 +S0R/8uLWe3hxKPAM/eYC8/c0x/MUUgZCAp4UkBNgUNo+xJd9GPqLZy/u4UqUE3X73YA
 yWnQ52rUkHF8LLkdhd+Z+lqHsSb8LnPJinVzm4baiEyrXOe48y3qu1CWBQPUhy8Fc9F2
 d0lIDMvv9avMzUP44jiXKqGlpcxsDT40sGGN5HYCt9+2cYuTCxloXBBRGn2yNkA67mRV
 +flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2UYQ3yYYDlDIP0MsyiA7Zdsuo4ukrQD2ytHAxPp6tug=;
 b=Ba9Q6zlROgRzP0GlN9amsxkI/SO/ueuU1HJkqJ6hT2hlwLNGJVTgnzHSqe/UMdJg4m
 DlOan/W/iHJeCmCjdYEcriqCyssc+rt1XQ0Nb2ruynQN3fdQud9EYHGe+bD/XBFSWz9p
 DogBpy02+Dx4LURwdbdye1Ya5AcK5z0NgyF8Cy9nvGaQfD8eMIG6O+5Usa6nczePiAdm
 KwlutPO/uDQSx2Qo1TRjG8qFvbEytO2iA8GW8DSfszyg3xE79epfmZ1tbfrLB0mHNQ6o
 IPfn+30XyMqQocYf9ik2M8oU2G7LYZzx6VKC45GkUUYz8a/X8nLlBaWm2glaf8O74iHz
 Mi9Q==
X-Gm-Message-State: APjAAAUU8t8fFSn6eR0+PHOMsD+XLZKhsiswpQaJ5myn/sBmyyGTY1PK
 t0uEb8RistS3TH+6cS4a70mt+A==
X-Google-Smtp-Source: APXvYqzOpKDzkqgVa7clFEvEXlJvmJPI+lCcaTJurPsgmXwIvKqNf4MgJg6gL41Tz3Yh9ypt0zov/w==
X-Received: by 2002:a65:5a44:: with SMTP id z4mr5183482pgs.41.1561890068923;
 Sun, 30 Jun 2019 03:21:08 -0700 (PDT)
Received: from localhost.localdomain ([114.246.94.159])
 by smtp.gmail.com with ESMTPSA id m100sm8714549pje.12.2019.06.30.03.21.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 30 Jun 2019 03:21:08 -0700 (PDT)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 30 Jun 2019 18:20:32 +0800
Message-Id: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v9 0/2] Add Arm SBSA Reference Machine
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
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, radoslaw.biernacki@linaro.org,
 leif.lindholm@linaro.org, ard.biesheuvel@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the Aarch64, there is one machine 'virt', it is primarily meant to
run on KVM and execute virtualization workloads, but we need an
environment as faithful as possible to physical hardware,  to support
firmware and OS development for pysical Aarch64 machines.

This machine comes with:
 - Re-designed memory map.
 - CPU cortex-a57.
 - EL2 and EL3 enabled.
 - GIC version 3.
 - System bus AHCI controller.
 - System bus XHCI controller.
 - CDROM and hard disc on AHCI bus.
 - E1000E ethernet card on PCIE bus.
 - VGA display adaptor on PCIE bus.
 - Only minimal device tree nodes.
And without:
 - virtio deivces.
 - fw_cfg device.
 - ACPI tables.

Arm Trusted Firmware and UEFI porting to this are done accordingly, and
it should supply ACPI tables to load OS, the minimal device tree nodes
supplied from this platform are only to pass the dynamic info reflecting
command line input to firmware, not for loading OS.

v9 changes:
 - only a few lines update to refine the patch format, while the final
   sbsa-ref.c is kept same with v8

v8 changes:
 - rebase to latest QEMU tree
 - use new way of creating flash as in 'virt' machine
 - other minor typos and comments update

v7 changes:
 - edit memory map for PCIE slightly
 - add another secure UART which can be used for RAS and MM from EL0.

v6 changes:
 - rebased to the latest QEMU tree
 - rechecked all the header files included
 - added the newly introduced system bus EHCI controller
 - removed the machine_done callback due to commit 5614ca80
 - updated block comments styles according to checkpatch.pl
 - use Kconfig to add new file
 - use private SBSA* types defination instead of VIRT* in virt.h
   since nobody else using them so they are in the .c file instead
   of a new .h file

v5 changes:
 - removed more lines derived from virt.c
 - designed a new memory map
 - splitted former one patch into two for easier review
 - cancled previous EHCI and new HXCI coming later separately

V4 changes:
 - rebased to v3.0.0
 - removed timer, uart, rtc, *hci device tree nodes
   (others were removerd in v3)
 - other minore codes clean up, mainly unsed header files, comments etc.

V3 changes:
 - rename the platform 'sbsa-ref'
 - move all the codes to a separate file sbsa-ref.c
 - remove paravirtualized fw_cfg device
 - do not supply ACPI tables, since firmware will do it
 - supply only necessary DT nodes
 - and other minor code clean up

Hongbo Zhang (2):
  hw/arm: Add arm SBSA reference machine, skeleton part
  hw/arm: Add arm SBSA reference machine, devices part

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Kconfig                  |  16 +
 hw/arm/Makefile.objs            |   1 +
 hw/arm/sbsa-ref.c               | 806 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 824 insertions(+)
 create mode 100644 hw/arm/sbsa-ref.c

-- 
2.7.4


