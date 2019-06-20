Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB39C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B567A206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B567A206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvfk-0005yo-KK
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55253)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hdvYZ-00089o-LX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hdvT5-0000BF-IO
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:43:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:12612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hduqT-0008R8-Lg
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:03:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E933C746392;
 Thu, 20 Jun 2019 13:02:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5E7907461AE; Thu, 20 Jun 2019 13:02:49 +0200 (CEST)
Message-Id: <5d1fe4db846ab9be4b77ddb0d43cc74cd200a003.1561028123.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1561028123.git.balaton@eik.bme.hu>
References: <cover.1561028123.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 20 Jun 2019 12:55:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: [Qemu-devel] [PATCH v5 1/2] i2c: Move bitbang_i2c.h to
 include/hw/i2c/
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
Cc: Corey Minyard <cminyard@mvista.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bitbang i2c implementation is also useful for other device models
such as DDC in display controllers. Move the header to include/hw/i2c/
to allow it to be used from other device models and adjust users of
this include. This also reverts commit 2b4c1125ac which is no longer
needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/i2c/bitbang_i2c.c                 | 2 +-
 hw/i2c/ppc4xx_i2c.c                  | 1 -
 hw/i2c/versatile_i2c.c               | 2 +-
 {hw =3D> include/hw}/i2c/bitbang_i2c.h | 2 ++
 include/hw/i2c/i2c.h                 | 2 --
 include/hw/i2c/ppc4xx_i2c.h          | 2 +-
 6 files changed, 5 insertions(+), 6 deletions(-)
 rename {hw =3D> include/hw}/i2c/bitbang_i2c.h (80%)

diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 5dfc72d9d7..3cb0509b02 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -12,7 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "bitbang_i2c.h"
+#include "hw/i2c/bitbang_i2c.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
=20
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index d606d3dbeb..5fb4f86c38 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -30,7 +30,6 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i2c/ppc4xx_i2c.h"
-#include "bitbang_i2c.h"
=20
 #define PPC4xx_I2C_MEM_SIZE 18
=20
diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
index e07be9890c..24b6e36b6d 100644
--- a/hw/i2c/versatile_i2c.c
+++ b/hw/i2c/versatile_i2c.c
@@ -23,7 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "bitbang_i2c.h"
+#include "hw/i2c/bitbang_i2c.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/i2c/bitbang_i2c.h b/include/hw/i2c/bitbang_i2c.h
similarity index 80%
rename from hw/i2c/bitbang_i2c.h
rename to include/hw/i2c/bitbang_i2c.h
index 9443021710..3a7126d5de 100644
--- a/hw/i2c/bitbang_i2c.h
+++ b/include/hw/i2c/bitbang_i2c.h
@@ -3,6 +3,8 @@
=20
 #include "hw/i2c/i2c.h"
=20
+typedef struct bitbang_i2c_interface bitbang_i2c_interface;
+
 #define BITBANG_I2C_SDA 0
 #define BITBANG_I2C_SCL 1
=20
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 8e236f7bb4..75c5bd638b 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -81,8 +81,6 @@ uint8_t i2c_recv(I2CBus *bus);
=20
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r);
=20
-typedef struct bitbang_i2c_interface bitbang_i2c_interface;
-
 /* lm832x.c */
 void lm832x_key_event(DeviceState *dev, int key, int state);
=20
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index aa2a2bf9de..8437bf070b 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -28,7 +28,7 @@
 #define PPC4XX_I2C_H
=20
 #include "hw/sysbus.h"
-#include "hw/i2c/i2c.h"
+#include "hw/i2c/bitbang_i2c.h"
=20
 #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
 #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_=
I2C)
--=20
2.13.7


