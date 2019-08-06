Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6743EC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB502173B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB502173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv1D3-0000nw-9d
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 11:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51011)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hv1Ap-0004C4-Ea
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hv1An-0004kz-VJ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:14:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hv1An-0004kT-N2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D42030605F1
 for <qemu-devel@nongnu.org>; Tue,  6 Aug 2019 15:14:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-251.ams2.redhat.com
 [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98C076013A;
 Tue,  6 Aug 2019 15:14:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 713D51136422; Tue,  6 Aug 2019 17:14:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 17:14:16 +0200
Message-Id: <20190806151435.10740-11-armbru@redhat.com>
In-Reply-To: <20190806151435.10740-1-armbru@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 06 Aug 2019 15:14:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/29] ide: Include hw/ide/internal a bit
 less outside hw/ide/
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
Cc: John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to hw/ide/internal's file comment, only files in hw/ide/ are
supposed to include it.  Drag reality slightly closer to supposition.

Three includes outside hw/ide remain: hw/arm/sbsa-ref.c,
include/hw/ide/pci.h, and include/hw/misc/macio/macio.h.  Turns out
board code needs ide-internal.h to wire up IDE stuff.  More cleanup is
needed.  Left for another day.

Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/allwinner-a10.c         | 1 +
 hw/arm/cubieboard.c            | 1 +
 hw/arm/xlnx-zynqmp.c           | 1 +
 hw/ide/ahci_internal.h         | 1 +
 hw/ppc/mac.h                   | 1 -
 include/hw/arm/allwinner-a10.h | 1 -
 include/hw/arm/xlnx-zynqmp.h   | 1 -
 include/hw/misc/mos6522.h      | 1 -
 8 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 35e906ca54..3b0d3eccdd 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -16,6 +16,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "cpu.h"
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index f7c8a5985a..38e0ca0f53 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -16,6 +16,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index a60830d37a..0f587e63d3 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -24,6 +24,7 @@
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sysemu.h"
 #include "kvm_arm.h"
=20
 #define GIC_NUM_SPI_INTR 160
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 95ecddcd3c..73424516da 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -25,6 +25,7 @@
 #define HW_IDE_AHCI_INTERNAL_H
=20
 #include "hw/ide/ahci.h"
+#include "hw/ide/internal.h"
 #include "hw/sysbus.h"
=20
 #define AHCI_MEM_BAR_SIZE         0x1000
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index a741300ac9..6af87d1fa0 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -30,7 +30,6 @@
 #include "exec/memory.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
-#include "hw/ide/internal.h"
 #include "hw/input/adb.h"
 #include "hw/misc/mos6522.h"
 #include "hw/pci/pci_host.h"
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a1=
0.h
index 7182ce5c4b..101b72a71d 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -7,7 +7,6 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/net/allwinner_emac.h"
-#include "hw/ide/pci.h"
 #include "hw/ide/ahci.h"
=20
 #include "sysemu/sysemu.h"
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 6cb65e7537..d7483c3b42 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -22,7 +22,6 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/char/cadence_uart.h"
-#include "hw/ide/pci.h"
 #include "hw/ide/ahci.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/xilinx_spips.h"
diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index 03d9f0c059..493c907537 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -29,7 +29,6 @@
=20
 #include "exec/memory.h"
 #include "hw/sysbus.h"
-#include "hw/ide/internal.h"
 #include "hw/input/adb.h"
=20
 /* Bits in ACR */
--=20
2.21.0


