Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7DAC5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8C520656
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8C520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgoNy-0000VA-ON
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hgoJ1-0002ln-59
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hgoIv-0006Gn-Ps
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:40:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hgoIg-00060k-Vv; Fri, 28 Jun 2019 06:40:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63702308FED5;
 Fri, 28 Jun 2019 10:40:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com
 [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 026051001DC3;
 Fri, 28 Jun 2019 10:39:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F348E17472; Fri, 28 Jun 2019 12:39:57 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 12:39:52 +0200
Message-Id: <20190628103957.9504-2-kraxel@redhat.com>
In-Reply-To: <20190628103957.9504-1-kraxel@redhat.com>
References: <20190628103957.9504-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 28 Jun 2019 10:40:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/6] i2c: Move bitbang_i2c.h to include/hw/i2c/
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

The bitbang i2c implementation is also useful for other device models
such as DDC in display controllers. Move the header to include/hw/i2c/
to allow it to be used from other device models and adjust users of
this include. This also reverts commit 2b4c1125ac which is no longer
needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-id: 5d1fe4db846ab9be4b77ddb0d43cc74cd200a003.1561028123.git.balat=
on@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 {hw =3D> include/hw}/i2c/bitbang_i2c.h | 2 ++
 include/hw/i2c/i2c.h                 | 2 --
 include/hw/i2c/ppc4xx_i2c.h          | 2 +-
 hw/i2c/bitbang_i2c.c                 | 2 +-
 hw/i2c/ppc4xx_i2c.c                  | 1 -
 hw/i2c/versatile_i2c.c               | 2 +-
 6 files changed, 5 insertions(+), 6 deletions(-)
 rename {hw =3D> include/hw}/i2c/bitbang_i2c.h (80%)

diff --git a/hw/i2c/bitbang_i2c.h b/include/hw/i2c/bitbang_i2c.h
similarity index 80%
rename from hw/i2c/bitbang_i2c.h
rename to include/hw/i2c/bitbang_i2c.h
index 9443021710d7..3a7126d5dee8 100644
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
index 8e236f7bb428..75c5bd638bb9 100644
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
index aa2a2bf9dec2..8437bf070b8b 100644
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
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 5dfc72d9d7b7..3cb0509b0200 100644
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
index d606d3dbeb81..5fb4f86c38f1 100644
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
index e07be9890c8a..24b6e36b6d52 100644
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
--=20
2.18.1


