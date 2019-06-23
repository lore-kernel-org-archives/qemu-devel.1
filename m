Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D11C43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 02:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17A020673
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 02:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdbHGCRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17A020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hesTo-0000xh-QX
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 22:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hesSo-0000EU-EO
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 22:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hesSn-00032G-CK
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 22:42:42 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
 id 1hesSn-0002yN-5H
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 22:42:41 -0400
Received: by mail-pg1-x541.google.com with SMTP id v9so5198835pgr.13
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2019 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=d/UIhArRzZQ/AiYxCwVh0WjkOQYp1EoyTFMKzL/gCPw=;
 b=tdbHGCRPIBoslKmdoU01I/Wwo/ZtvJKSsAmKGtNlfSsBWWP3MXqEm3GXA3gGNsGQn/
 IfhHKTdtcXEGFkOe1qWgJ7OblGbK5oVqz1iLb1cyq5ZBDgJzls7ekQgNNRb2P0dz/Eip
 G3uV9pvj05ThW2aoINEFrxmCRbjWDt+M1v1k0j4FgYxd6DhK+BKgjeHF3DLU3dmzKWNq
 Gvd5nj3yLH6m/QC0+gvP1rJnMml4OJdyW6WmbhEvf5FkJ5cezwZuhAk4vbzOTCA4RE1H
 1ajmlBabO09CMFgyNsZ+efrxB1EdzxR/NV6Q753c3Zy+fBEYzt3iuVpcXFHgoMTomntJ
 nR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=d/UIhArRzZQ/AiYxCwVh0WjkOQYp1EoyTFMKzL/gCPw=;
 b=Xg1fVO5/5GEVVMz4pz1XVt0B9hIoFEs1VcTlmUae5I1pVIcnYwOmHojy09jLfd46Bj
 P1AIfDlLNN0uoXAntbXjM/pcQs8VD5V/5G8gHE2k7d7BVEiiWRdOWmmx0YMmNFb0iVJi
 UWO7KjHqW7QxdbdOGhPkKa47DxhlO3+y4UXVKvbCCki/beXbKEpjY5xuGlv0iQ+KZyG3
 JIQQRxx704v2tVx8CFKXEF9GaEAa779ImN96vfmmU2q3ZvoKH4yfONO7OECcWf8Q5uoG
 5QsYz6YMyAr1InO85QkRWIsvmvrDb0wtsNcBI53fsZbw8NP7H0asQaskE19OEBBptpwy
 svSg==
X-Gm-Message-State: APjAAAU5nisRm6KgGR3F6AUQXhC8aeTu9Ah2qTxZVQcELn6Cc9SlQo9v
 sjqQmrKV0GExcACm2z+O5myjig==
X-Google-Smtp-Source: APXvYqxXC6c0jCjmH2WZUb5Zs3A+j2vrRTNC0O4IJZ5lKF9bMqUHJaFYoqGtlDyARJmVIblzy0LUsw==
X-Received: by 2002:a17:90a:de02:: with SMTP id
 m2mr16236861pjv.18.1561257758821; 
 Sat, 22 Jun 2019 19:42:38 -0700 (PDT)
Received: from localhost.localdomain ([222.131.159.173])
 by smtp.gmail.com with ESMTPSA id o13sm7007146pje.28.2019.06.22.19.42.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 22 Jun 2019 19:42:38 -0700 (PDT)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 23 Jun 2019 10:40:53 +0800
Message-Id: <1561257655-25907-1-git-send-email-hongbo.zhang@linaro.org>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v8 0/2] Add Arm SBSA Reference Machine
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
 hw/arm/Kconfig                  |  14 +
 hw/arm/Makefile.objs            |   1 +
 hw/arm/sbsa-ref.c               | 806 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 822 insertions(+)
 create mode 100644 hw/arm/sbsa-ref.c

-- 
2.7.4


