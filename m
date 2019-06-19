Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A83C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2103E20863
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i1bqNdH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2103E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdOvK-0005Wn-6n
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 20:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOp8-0007iJ-84
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOf2-0003ZE-12
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:41:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOf1-0003VC-DP; Tue, 18 Jun 2019 20:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560904872; x=1592440872;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fBCjfi+R8ucsPxgA/Z2V/xNWXgYi2PD3waNn5eO6axQ=;
 b=i1bqNdH4SZpqHOfxCz5MJvqUQ1lOZVUG/H6Y5KXeTRhaphZgO1HZEDE2
 4peZXB/42pLuBvhLqujgsYehc/UoW1JbURPHMIb4prX6L2KzMT5UStbHA
 5DNSCZ68XkR1KcGp+m74j9sTybkIo6h8GE6dUSf/IWY7yq5eNBmyXvoia
 39cqzRpF2jXBHA9/FVWwFcVXWyNOmLggygfe0krpLQD9RrdCupUq32XlA
 ZDCjh2Q0fykneUwPGvXksUbcJGEQCbbqEklqJ4Rl7zFr/+rwhtXa2wMFA
 O60GRtM0+Z4SrvWwO+htxQhq3FnsjjaT/+mytTQFjPmXuOjWVw87L5NRj g==;
X-IronPort-AV: E=Sophos;i="5.63,390,1557158400"; d="scan'208";a="110901041"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 08:41:07 +0800
IronPort-SDR: 5IqP78ttRklEhgqjx9Blu74Mrpj8DGKPYG62Tn+i75ww2L+WbjBvS6zDiLl8UhfONvNR1mUdbG
 WUISvsfNqOI7770u8WQH8j5QcY87KSzP6+/PWDKr7yVgYUv/m4Fzdds5bpo/46Y+N4MYHvi1fq
 D+8D2vFeZv6Gp9CzCBixeScvWZJfvOzUipXU4jMxBDvglBJYqAzjuNUl7bIZCVGCtgYCyaNxE9
 PS3O+M5RMd0EIbHI0mgwSDW3YNYELPfLiytifammdvBdP1hMdyGipdZjwYZikPRVL3apAm/8UM
 gTuZWGsQg4M5CA+Uj5pSYrMT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 18 Jun 2019 17:40:34 -0700
IronPort-SDR: gEHLQrLMK8LtoJIEw3zLX6lKLe1+uVOiYR4aVlMiEgAHUIToyn8yoeIocpE9t7GX/ZHdAm2n7n
 tRJ3S5tiufT7jIH7hncBaXfTb/bsiMSESuX7CXp89Af4GjlfQI1qJ1miYiQ3aX9esE6d6ggXtM
 wc6inXmxEiTGE+dGQuIubGx+kfuMna/a55ZUWtuT4foYbOWh53mXaR9dD5uoxnALeGNNLlK51T
 DRKSOyS5FLiZjowRi2MLW3rINQXLKVBS5snv8px5sJrqTVVzUuHzMqIFKKnTcn5OjGxB6AqXBz
 Q64=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2019 17:41:05 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 18 Jun 2019 17:38:44 -0700
Message-Id: <cover.1560904640.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [RFC v1 0/5] RISC-V: Add firmware loading support and
 default
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

This is an RFC as it will break ALL current users! See below for details.

This series consolidates the current RISC-V kernel loading
impelementation while also adding support for the -bios option and more
advanced kernel image types.

After consolidating the kernel loading we can extend the boot loader to
support a -bios option. We can also extend the kernel loading options to
support not just ELF files but other standard formats.

Finally we can include the OpenSBI firmware by default for QEMU users.

At the end of this series we are in the good place of no longer
requiring users to build firmware to boot a kernel. Instead users can
just run QEMu with the -kernel option and everything will work. They can
also override the firmware with their own using the -bios option. Using
"-bios none" will result in no firmware being loaded (as it is today).

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Unfortunately this series (patch 5 specifically) results in all current
Linux boots being broken as users are already loading in their own
firmware, which overlaps with the now included default. They will
see this error:

  rom: requested regions overlap (rom phdr #0: ./images/qemuriscv64/fw_jump.elf. free=0x0000000080008090, addr=0x0000000080000000)
  qemu-system-riscv64: rom check and register reset failed

If a current user specieifies "-bios none" their flow will continue
working. A user can instead no longer load their firmware and
use the default or they can load their firmware with the -bios option.

At the moment the best idea I have to not break all users is to only
include the default firmware if the user specifies "-bios opensbi".
That is change the default to not loading the firmware. Then we can work
on updating documentation and maybe in future change the default to
include a firmware and anyone who doesn't want a default firmware can
specify "-bios none".

Any other ideas on how to not break everything?



Alistair Francis (5):
  hw/riscv: Split out the boot functions
  hw/riscv: Add support for loading a firmware
  hw/riscv: Extend the kernel loading support
  roms: Add OpenSBI version 0.3
  hw/riscv: Load OpenSBI as the default firmware

 .gitmodules                         |   3 +
 Makefile                            |   3 +-
 configure                           |   1 +
 hw/riscv/Makefile.objs              |   1 +
 hw/riscv/boot.c                     | 143 ++++++++++++++++++++++++++++
 hw/riscv/sifive_e.c                 |  17 +---
 hw/riscv/sifive_u.c                 |  19 +---
 hw/riscv/spike.c                    |  21 +---
 hw/riscv/virt.c                     |  54 ++---------
 include/hw/riscv/boot.h             |  30 ++++++
 pc-bios/opensbi-riscv32-fw_jump.elf | Bin 0 -> 197988 bytes
 pc-bios/opensbi-riscv64-fw_jump.elf | Bin 0 -> 200192 bytes
 roms/Makefile                       |  17 ++++
 roms/opensbi                        |   1 +
 14 files changed, 216 insertions(+), 94 deletions(-)
 create mode 100644 hw/riscv/boot.c
 create mode 100644 include/hw/riscv/boot.h
 create mode 100644 pc-bios/opensbi-riscv32-fw_jump.elf
 create mode 100644 pc-bios/opensbi-riscv64-fw_jump.elf
 create mode 160000 roms/opensbi

-- 
2.22.0


