Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABE1C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D5C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RzpXfb3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D5C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54986 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXHk-0004WV-VM
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEI-0002Hh-09
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEF-0008QS-RG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:14:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37621)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEE-0008Lr-FK; Mon, 24 Jun 2019 18:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561414463; x=1592950463;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vFjcLec50OQuUsuPDDaBnnbYmF2vqv0MpG2bzJSALMA=;
 b=RzpXfb3OFVURAk6uBysET5ef18FQNIFsWRqXhLXEAHwcznM1VujNOV9b
 dmeX8RMlHZI5Pqyx9gOL0Aa4lmZoV+gYBRc9TtI7L5Km+9O41u5GlWDhz
 tLzjfOF/Cs5xD2GRoSJiZxfoK9Si7ZcAXf9MgRAktf6RJXCqMU+15tTyJ
 fXYIr310Pz1btOx/7leYR9Cp9LEg9KyKyUtvfJbvrV4EEdeDbnlKVABe7
 9gkNeRK8NON7Kee86ZEDCvMM70PCreTy15cBn34x4QHRpmyRULRtB2LJ+
 EmQnYCb6p+PhgRpUQL2GLaYFmm7yUCA8fGrqQ4OXoIG0QpBVees6zU1SC w==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="116308871"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 06:14:16 +0800
IronPort-SDR: 7UCnQYgkU+kI6P5akPS71SU+SBxb8FDkRcgF9TWfLR/UK2oUqBxCJs+0P/S1hdO/qwWdo65BTk
 4h+v0dgf9teNpRGkefLCVb9k9PMD1JSG/eTZWkpv+nyclatdOHajFvfEUHnSlxRsJYdWJf0KNN
 rrHIAF7O8egKKOCBatvG/iBD7glZPaRxp8Cpkzt+/WLvfL+5QM07zr5coUw3w/W3nhgVOG6NFJ
 hItN3oDy2luLn150h4dR2WUXvvnBBUHEytcx1TA7RGA1ULNqikaUMI09iNcQKImzXC4X4xoki2
 KkkxAzYKC8A/MOyv12CNsmfS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 24 Jun 2019 15:13:26 -0700
IronPort-SDR: 00vV7sOI3fj1sZ1pfUyuw44Aqv7RWGq0VepCC2UMEd9gJ7oljTyU1zAn+Oa8nzdWCKC5OwT61M
 R9gqVNwvTL/cQmAZpQai7Y4CYK262sCDbHrcqIg207dv/Jhxzvs8qC6NL2ox5PltZrp34kUV+G
 plSafPfkzm/P0Z7fCz7YHFacHf6FMWuLx6DLxVjmGVbHzd4oPyXmAC3kIEezZpSuhVuASMbpSb
 3EE/yGY52KvR4ZckgFory9P9FYIwyAdBcYgshUxMK6hdyZr0jNNYmA+/59AAFHijecOXf3HhbS
 cN4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Jun 2019 15:14:15 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 24 Jun 2019 15:11:46 -0700
Message-Id: <cover.1561414240.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 0/5] RISC-V: Add firmware loading support
 and default
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series consolidates the current RISC-V kernel loading
impelementation while also adding support for the -bios option and more
advanced kernel image types.

After consolidating the kernel loading we can extend the boot loader to
support a -bios option. We can also extend the kernel loading options to
support not just ELF files but other standard formats.

Finally we can include the OpenSBI firmware for QEMU users.

To avoid breakages we have not changed the default behaviour of QEMU.
The plan is to change the default though, which is why an entry to the
qemu-deprecated.texi file has been added as well as a new warning.

After this series QEMU 4.1 has three options:
 1. ``-bios none`` - This is the current default behavior if no -bios option
      is included. QEMU will not automatically load any firmware. It is up
      to the user to load all the images they need.
 2. ``-bios default`` - In a future QEMU release this will become the default
      behaviour if no -bios option is specified. This option will load the
      default OpenSBI firmware automatically. The firmware is included with
      the QEMU release and no user interaction is required. All a user needs
      to do is specify the kernel they want to boot with the -kernel option
 3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.

All users should transition to using a -bios option. We can start
updating all documentation after the release of 4.1.

At the end of this series and the transition period we are in the good
place of no longer requiring users to build firmware to boot a kernel.
Instead users can just run QEMU with the -kernel option and everything
will work. They can also override the firmware with their own using
the -bios option. Using "-bios none" will result in no firmware being
loaded (as it is today).


Alistair Francis (5):
  hw/riscv: Split out the boot functions
  hw/riscv: Add support for loading a firmware
  hw/riscv: Extend the kernel loading support
  roms: Add OpenSBI version 0.3
  hw/riscv: Load OpenSBI as the default firmware

 .gitmodules                                  |   3 +
 Makefile                                     |   5 +-
 hw/riscv/Makefile.objs                       |   1 +
 hw/riscv/boot.c                              | 154 +++++++++++++++++++
 hw/riscv/sifive_e.c                          |  17 +-
 hw/riscv/sifive_u.c                          |  22 +--
 hw/riscv/spike.c                             |  21 +--
 hw/riscv/virt.c                              |  60 ++------
 include/hw/riscv/boot.h                      |  32 ++++
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 28848 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 28904 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 28904 bytes
 qemu-deprecated.texi                         |  20 +++
 roms/Makefile                                |  48 ++++--
 roms/opensbi                                 |   1 +
 15 files changed, 278 insertions(+), 106 deletions(-)
 create mode 100644 hw/riscv/boot.c
 create mode 100644 include/hw/riscv/boot.h
 create mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
 create mode 160000 roms/opensbi

-- 
2.22.0


