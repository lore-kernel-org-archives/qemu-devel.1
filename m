Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BACC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E37A2089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E37A2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuXE-0004bq-9t
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhuS8-00068c-Im
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhuS7-0007k0-AF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:26:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhuS7-0007ho-1L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:26:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E4842F8BF5;
 Mon,  1 Jul 2019 11:26:29 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D7E866617;
 Mon,  1 Jul 2019 11:26:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 13:26:11 +0200
Message-Id: <20190701112612.14758-4-philmd@redhat.com>
In-Reply-To: <20190701112612.14758-1-philmd@redhat.com>
References: <20190701112612.14758-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 01 Jul 2019 11:26:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 3/4] hw/mips: Express dependencies of the
 Jazz machine with Kconfig
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Jazz use the RC4030 Asic to provide an EISA bus and DMA/IRQ.
The framebuffer display is managed by a G364, the network card is
a Sonic DP83932. A QLogic ESP216 provides a SCSI bus.

None, for the both machine variants (PICA-61 and Magnum 4000),
the DP83932 chipset is soldered on the board, and is MMIO-mapped
(selected via Chip Select). Therefore we have to enforce the
'select' Kconfig rule (we can not use the 'imply' rule helpful
when devices are connected on a bus).

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: Keep CONFIG_JAZZ in default-configs/mips64el-softmmu.mak (Thomas)
v4: explain DP83932 is soldered to justify not using the 'imply' rule
---
 default-configs/mips-softmmu-common.mak |  1 -
 default-configs/mips64-softmmu.mak      |  5 -----
 default-configs/mips64el-softmmu.mak    |  5 -----
 hw/mips/Kconfig                         | 17 +++++++++++++++++
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mi=
ps-softmmu-common.mak
index 63ed293f2e..d545987d42 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -6,7 +6,6 @@ CONFIG_SEMIHOSTING=3Dy
 CONFIG_ISA_BUS=3Dy
 CONFIG_PCI=3Dy
 CONFIG_PCI_DEVICES=3Dy
-CONFIG_ESP=3Dy
 CONFIG_VGA_ISA=3Dy
 CONFIG_VGA_ISA_MM=3Dy
 CONFIG_VGA_CIRRUS=3Dy
diff --git a/default-configs/mips64-softmmu.mak b/default-configs/mips64-=
softmmu.mak
index bad7496672..a169738635 100644
--- a/default-configs/mips64-softmmu.mak
+++ b/default-configs/mips64-softmmu.mak
@@ -1,9 +1,4 @@
 # Default configuration for mips64-softmmu
=20
 include mips-softmmu-common.mak
-CONFIG_RC4030=3Dy
-CONFIG_DP8393X=3Dy
-CONFIG_DS1225Y=3Dy
 CONFIG_JAZZ=3Dy
-CONFIG_G364FB=3Dy
-CONFIG_JAZZ_LED=3Dy
diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
index a67c9517a2..8b0c9b1e15 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -2,15 +2,10 @@
=20
 include mips-softmmu-common.mak
 CONFIG_IDE_VIA=3Dy
-CONFIG_RC4030=3Dy
-CONFIG_DP8393X=3Dy
-CONFIG_DS1225Y=3Dy
 CONFIG_FULONG=3Dy
 CONFIG_ATI_VGA=3Dy
 CONFIG_RTL8139_PCI=3Dy
 CONFIG_JAZZ=3Dy
-CONFIG_G364FB=3Dy
-CONFIG_JAZZ_LED=3Dy
 CONFIG_VT82C686=3Dy
 CONFIG_AHCI=3Dy
 CONFIG_MIPS_BOSTON=3Dy
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 3433e97e1a..ab006477c7 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -12,6 +12,23 @@ config MIPSSIM
=20
 config JAZZ
     bool
+    select ISA_BUS
+    select RC4030
+    select I8259
+    select I8254
+    select I8257
+    select PCSPK
+    select VGA_ISA_MM
+    select G364FB
+    select DP8393X
+    select ESP
+    select FDC
+    select MC146818RTC
+    select PCKBD
+    select SERIAL
+    select PARALLEL
+    select DS1225Y
+    select JAZZ_LED
=20
 config FULONG
     bool
--=20
2.20.1


