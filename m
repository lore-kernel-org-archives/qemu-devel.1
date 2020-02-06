Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D484C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EAF2082E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhzqRfTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EAF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVpz-0002Eg-Jv
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo2-00007e-1d
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo0-0001bk-IL
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:09 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo0-0001UD-Bh; Wed, 05 Feb 2020 20:18:08 -0500
Received: by mail-wm1-x342.google.com with SMTP id t23so4501839wmi.1;
 Wed, 05 Feb 2020 17:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Tq5S/N+0JOq8c9dlCr3FKmOhtjiwItYwYRBLhuDC7A=;
 b=dhzqRfTTMKnc/slCd2A5GK/4tWWJj3ctlKsJLVN+0ksxF6qMVXbwGLTPou3wGKErLP
 0R1toyGDwFopCyVih6C5Y+KJr0/24mqduJWEOqqPmvWMNurr7G+XeXTxQW+MH4CO23oQ
 HPpsWwRVORk9uunFCovL/5go9YJisIK31kvnlZqEbKBLw7Pz92ctBK47BotgvcneWK/w
 VEOCvNnbCsXXiBYerqCGbmg+pZPQnY5IJq+gwvnbVRNY3pZnRKiWuavLPW70iBqtCqO9
 RrPomb7igtIOlVZUl05R1ELXTPCH7bkqc2pim0lgrC636FyouTaYUOwRb16ocCOzVSsY
 cXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+Tq5S/N+0JOq8c9dlCr3FKmOhtjiwItYwYRBLhuDC7A=;
 b=VtChgoYJWXo44YWyLaDTYVN9oPcxo1J/APRcN7Y6NX5UX4ksiIn1n6n+LfeK5UAwwv
 1dZ5eJoYpchM1oKya8CqXX6fnN8s6roc/I6XCiCBu/epSyCNXIhOrbEdyUrJDT5UhLtL
 13+WLgonsu8kTb1Fvi3wzgCmI6C/l2GS/DYagJj6LT72o7XiKemV6XEyqOAbOK5e4pYk
 ADxjJP+eFDfNEiFGcN9+DmaDjLzvMQ2ZrMTuPWpVBkjdK7tBhD2Yxmi6xUfuhXWtbhDJ
 FZLVYOpSs41kSd4x6GhgNy6+2KGgpapAMPLQpueTbfCjsTCfSx3/6RPJmSTm48brQCyf
 vpAA==
X-Gm-Message-State: APjAAAW9OSH70OYZJyR3rXEqApG4sBAQEW+D21UC/I3eLbBwAB2kja83
 LrZSwCXEvRzp+pTMM3aNYb9I5Dlf
X-Google-Smtp-Source: APXvYqyW6tUwif5U2Bb1Vtbf9o2ziHlZ1h35j8VG4lrisNawe8vnGtNkZ0xGBY4J8fYmYUoZD4Ds9g==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr662146wmi.152.1580951882851; 
 Wed, 05 Feb 2020 17:18:02 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/30] hw/arm/raspi: Use BCM2708 machine type with pre
 Device Tree kernels
Date: Thu,  6 Feb 2020 02:17:27 +0100
Message-Id: <20200206011756.2413-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stephen Warren <swarren@nvidia.com>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Chan <michael.chan@broadcom.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Kshitij Soni <kshitij.soni@broadcom.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When booting without device tree, the Linux kernels uses the $R1
register to determine the machine type. The list of values is
registered at [1].

There are two entries for the Raspberry Pi:

- https://www.arm.linux.org.uk/developer/machines/list.php?mid=3138
  name: MACH_TYPE_BCM2708
  value: 0xc42 (3138)
  status: Active, not mainlined
  date: 15 Oct 2010

- https://www.arm.linux.org.uk/developer/machines/list.php?mid=4828
  name: MACH_TYPE_BCM2835
  value: 4828
  status: Active, mainlined
  date: 6 Dec 2013

QEMU always used the non-mainlined type MACH_TYPE_BCM2708.
The value 0xc43 is registered to 'MX51_GGC' (processor i.MX51), and
0xc44 to 'Western Digital Sharespace NAS' (processor Marvell 88F5182).

The Raspberry Pi foundation bootloader only sets the BCM2708 machine
type, see [2] or [3]:

 133 9:
 134     mov r0, #0
 135     ldr r1, =3138       @ BCM2708 machine id
 136     ldr r2, atags       @ ATAGS
 137     bx  r4

U-Boot only uses MACH_TYPE_BCM2708 (see [4]):

 25 /*
 26  * 2835 is a SKU in a series for which the 2708 is the first or primary SoC,
 27  * so 2708 has historically been used rather than a dedicated 2835 ID.
 28  *
 29  * We don't define a machine type for bcm2709/bcm2836 since the RPi Foundation
 30  * chose to use someone else's previously registered machine ID (3139, MX51_GGC)
 31  * rather than obtaining a valid ID:-/
 32  *
 33  * For the bcm2837, hopefully a machine type is not needed, since everything
 34  * is DT.
 35  */

While the definition MACH_BCM2709 with value 0xc43 was introduced in
a commit described "Add 2709 platform for Raspberry Pi 2" out of the
mainline Linux kernel, it does not seem used, and the platform is
introduced with Device Tree support anyway (see [5] and [6]).

Remove the unused values (0xc43 introduced in commit 1df7d1f9303aef
"raspi: add raspberry pi 2 machine" and 0xc44 in commit bade58166f4
"raspi: Raspberry Pi 3 support"), keeping only MACH_TYPE_BCM2708.

[1] https://www.arm.linux.org.uk/developer/machines/
[2] https://github.com/raspberrypi/tools/blob/920c7ed2e/armstubs/armstub7.S#L135
[3] https://github.com/raspberrypi/tools/blob/49719d554/armstubs/armstub7.S#L64
[4] https://gitlab.denx.de/u-boot/u-boot/blob/v2015.04/include/configs/rpi-common.h#L18
[5] https://github.com/raspberrypi/linux/commit/d9fac63adac#diff-6722037d79570df5b392a49e0e006573R526
[6] http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-February/001268.html

Cc: Zoltán Baldaszti <bztemail@gmail.com>
Cc: Pekka Enberg <penberg@iki.fi>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Kshitij Soni <kshitij.soni@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3996f6c63a..ef76a27f33 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -29,8 +29,7 @@
 #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default */
 #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
 
-/* Table of Linux board IDs for different Pi versions */
-static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43, [3] = 0xc44};
+#define MACH_TYPE_BCM2708   3138 /* Linux board IDs */
 
 typedef struct RasPiState {
     BCM283XState soc;
@@ -116,7 +115,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     static struct arm_boot_info binfo;
     int r;
 
-    binfo.board_id = raspi_boardid[version];
+    binfo.board_id = MACH_TYPE_BCM2708;
     binfo.ram_size = ram_size;
     binfo.nb_cpus = machine->smp.cpus;
 
-- 
2.21.1


