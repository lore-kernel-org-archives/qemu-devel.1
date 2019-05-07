Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90139C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FB420989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FB420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvPu-0005YT-Jc
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:25:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKO-0000gT-76
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKN-0008B4-0U
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:19:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hNvKK-000881-8d; Tue, 07 May 2019 04:19:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C2A983F3C;
	Tue,  7 May 2019 08:19:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB21F171F1;
	Tue,  7 May 2019 08:19:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C3765A1EA; Tue,  7 May 2019 10:19:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:19:46 +0200
Message-Id: <20190507081946.19264-9-kraxel@redhat.com>
In-Reply-To: <20190507081946.19264-1-kraxel@redhat.com>
References: <20190507081946.19264-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 07 May 2019 08:19:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 8/8] i2c-ddc: move it to hw/display
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Move it together with the other EDID code.  hw/i2c should only
include the core and the adapters, not the slaves.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20190325155923.30987-1-pbonzini@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/{i2c =3D> display}/i2c-ddc.h | 0
 include/hw/display/xlnx_dp.h          | 2 +-
 hw/{i2c =3D> display}/i2c-ddc.c         | 2 +-
 hw/display/sii9022.c                  | 2 +-
 hw/display/sm501.c                    | 2 +-
 hw/display/Kconfig                    | 5 +++++
 hw/display/Makefile.objs              | 1 +
 hw/i2c/Kconfig                        | 5 -----
 hw/i2c/Makefile.objs                  | 1 -
 9 files changed, 10 insertions(+), 10 deletions(-)
 rename include/hw/{i2c =3D> display}/i2c-ddc.h (100%)
 rename hw/{i2c =3D> display}/i2c-ddc.c (99%)

diff --git a/include/hw/i2c/i2c-ddc.h b/include/hw/display/i2c-ddc.h
similarity index 100%
rename from include/hw/i2c/i2c-ddc.h
rename to include/hw/display/i2c-ddc.h
diff --git a/include/hw/display/xlnx_dp.h b/include/hw/display/xlnx_dp.h
index 26b759cd448d..45a805033a53 100644
--- a/include/hw/display/xlnx_dp.h
+++ b/include/hw/display/xlnx_dp.h
@@ -27,7 +27,7 @@
 #include "hw/misc/auxbus.h"
 #include "hw/i2c/i2c.h"
 #include "hw/display/dpcd.h"
-#include "hw/i2c/i2c-ddc.h"
+#include "hw/display/i2c-ddc.h"
 #include "qemu/fifo8.h"
 #include "qemu/units.h"
 #include "hw/dma/xlnx_dpdma.h"
diff --git a/hw/i2c/i2c-ddc.c b/hw/display/i2c-ddc.c
similarity index 99%
rename from hw/i2c/i2c-ddc.c
rename to hw/display/i2c-ddc.c
index 7aa872777145..9fe5403a923e 100644
--- a/hw/i2c/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -20,7 +20,7 @@
 #include "qemu-common.h"
 #include "qemu/log.h"
 #include "hw/i2c/i2c.h"
-#include "hw/i2c/i2c-ddc.h"
+#include "hw/display/i2c-ddc.h"
=20
 #ifndef DEBUG_I2CDDC
 #define DEBUG_I2CDDC 0
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index 9994385c35a2..9c36e4c17ec9 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/i2c/i2c.h"
-#include "hw/i2c/i2c-ddc.h"
+#include "hw/display/i2c-ddc.h"
 #include "trace.h"
=20
 #define SII9022_SYS_CTRL_DATA 0x1a
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 2122291308f0..1e2709b2d002 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -35,7 +35,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
-#include "hw/i2c/i2c-ddc.h"
+#include "hw/display/i2c-ddc.h"
 #include "qemu/range.h"
 #include "ui/pixel_ops.h"
 #include "qemu/bswap.h"
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 72be57a40311..c236cd2d0a7c 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -1,3 +1,8 @@
+config DDC
+    bool
+    depends on I2C
+    select EDID
+
 config EDID
     bool
=20
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index dbd453ab1b01..650031f72536 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -1,3 +1,4 @@
+common-obj-$(CONFIG_DDC) +=3D i2c-ddc.o
 common-obj-$(CONFIG_EDID) +=3D edid-generate.o edid-region.o
=20
 common-obj-$(CONFIG_FW_CFG_DMA) +=3D ramfb.o
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 820b24de5b27..78a2008e3ad5 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -5,11 +5,6 @@ config SMBUS_EEPROM
     bool
     depends on I2C
=20
-config DDC
-    bool
-    depends on I2C
-    select EDID
-
 config VERSATILE_I2C
     bool
     select I2C
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 5f76b6a9909a..d7073a401f1c 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,6 +1,5 @@
 common-obj-$(CONFIG_I2C) +=3D core.o smbus_slave.o smbus_master.o
 common-obj-$(CONFIG_SMBUS_EEPROM) +=3D smbus_eeprom.o
-common-obj-$(CONFIG_DDC) +=3D i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) +=3D versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86_ICH) +=3D smbus_ich9.o
 common-obj-$(CONFIG_ACPI_SMBUS) +=3D pm_smbus.o
--=20
2.18.1


