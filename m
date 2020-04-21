Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC91C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D362064C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giN1sWjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D362064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrqe-0006kh-PM
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpM-0004um-M1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpK-00060R-VK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpK-0005uh-J9; Tue, 21 Apr 2020 08:16:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id f13so16186135wrm.13;
 Tue, 21 Apr 2020 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AJMOOz4bJ3+OgFhuoPiLJoOi2hKQD09s1vZajzHfQC8=;
 b=giN1sWjor02EMrv2H9rfe7w9wa98wrXgTTv80o7asNr554AiJSZRMu0vUMM6Envwwo
 yPwPNgZqesaJAJFTx0TkyvLJE/GCowes3Ylz5MPxvuTt5/jmjdMoJ0cvgb5Nj26FrZRj
 omRkiGlVsnbs/LLNorsvFJuF1L3jlqz/2my5RfIu1O49FydcMdhI+ULU26vCur9wsy0i
 xcQA3fHSgcby9rbXRyufWsZq8uDPLNHCTrR+64nTDqSbcT3FcstB4RxMZdwYxFM5LzLD
 mExK5NENeHWjTiyggyqfJ6iHyfYY1XUwltRC5aBY2s/KUKBcIq1zAjjdCvY80S0LS54r
 skvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AJMOOz4bJ3+OgFhuoPiLJoOi2hKQD09s1vZajzHfQC8=;
 b=kOqv0Oqqgm4rfR4okjkzdKfAxDsZOXC9Oqd47w9tt1wPpSBQBhvhfrOo2WoBAi4kO1
 3PEsKxCVlSEpG9Hh7eD12XYBARD+9RtyT+BPqRA8oV6/AA5Y/MgmpaGyzzYSKqlESFDW
 /OMlQYcyqp2WVgs3sXpC8SFS5VEP7G4zrnKkInDOyZ5MiDoZC+Z/k+VNtMIrOvml7cZ3
 9fU0mFFX9QBw+/baJxgpgawEKN//sRUHu3fUtWLJtfKg2gYT/9KOYP7f+3bC1aqMz/Td
 YMzmL8BTHheifGNg5HEtjcK4SuauBG2g9FVH5LD3IHP9GfYQPur8ZLNuoWjLBNOjfaYv
 CADA==
X-Gm-Message-State: AGi0Pubj9EFt3txuXIfHX/digCb9SQ6oijmZKGSkMCWNWdwcY6qDvGB2
 k0xrTh0ydP4iBSsVEroHfRlL98py+tw=
X-Google-Smtp-Source: APiQypIKn7o5GdcqxEx2zReJwzXACEhuJIE+ufUILwU9CmNAtdoLnhHSTojkPIKI8CZ2qIcvn2KlvQ==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr23451072wrq.316.1587471390955; 
 Tue, 21 Apr 2020 05:16:30 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 01/17] hw/misc: Introduce the temperature sensor interface
Date: Tue, 21 Apr 2020 14:16:10 +0200
Message-Id: <20200421121626.23791-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce an interface to set and get temperature from devices.

A device can have multiple temperature sensors.
Each sensor might have a custom name.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/temp-sensor.h | 69 +++++++++++++++++++++++++++++++++++
 hw/misc/temp-sensor.c         | 25 +++++++++++++
 MAINTAINERS                   |  6 +++
 hw/misc/Makefile.objs         |  1 +
 4 files changed, 101 insertions(+)
 create mode 100644 include/hw/misc/temp-sensor.h
 create mode 100644 hw/misc/temp-sensor.c

diff --git a/include/hw/misc/temp-sensor.h b/include/hw/misc/temp-sensor.h
new file mode 100644
index 0000000000..3067b1dd2e
--- /dev/null
+++ b/include/hw/misc/temp-sensor.h
@@ -0,0 +1,69 @@
+/*
+ * Generic interface for temperature sensors
+ *
+ * Copyright (c) 2020 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MISC_TEMP_SENSOR_H
+#define HW_MISC_TEMP_SENSOR_H
+
+#include "qom/object.h"
+
+#define TYPE_TEMPSENSOR_INTERFACE "temp-sensor-interface"
+#define TEMPSENSOR_INTERFACE(obj) \
+    INTERFACE_CHECK(TempSensor, (obj), TYPE_TEMPSENSOR_INTERFACE)
+#define TEMPSENSOR_INTERFACE_CLASS(class) \
+    OBJECT_CLASS_CHECK(TempSensorClass, (class), TYPE_TEMPSENSOR_INTERFACE)
+#define TEMPSENSOR_INTERFACE_GET_CLASS(class) \
+    OBJECT_GET_CLASS(TempSensorClass, (class), TYPE_TEMPSENSOR_INTERFACE)
+
+typedef struct TempSensor TempSensor;
+
+typedef struct TempSensorClass {
+    /* <private> */
+    InterfaceClass parent;
+    /* <public> */
+
+    /** Number of temperature sensors */
+    size_t sensor_count;
+
+    /**
+     * get_name:
+     * @obj: opaque pointer to Object
+     * @sensor_id: sensor index
+     *
+     * Returns: name of a temperature sensor.
+     */
+    const char *(*get_name)(TempSensor *obj, unsigned sensor_id);
+
+    /**
+     * set_temperature:
+     * @obj: opaque pointer to Object
+     * @sensor_id: sensor index
+     * @temp_C: sensor temperature, in degree Celsius
+     * @errp: pointer to a NULL-initialized error object
+     *
+     * Set a sensor temperature.
+     *
+     * If an error occurs @errp will contain the details
+     * (likely temperature out of range).
+     */
+    void (*set_temperature)(TempSensor *obj,
+                            unsigned sensor_id, float temp_C, Error **errp);
+
+    /**
+     * get_temperature:
+     * @obj: opaque pointer to Object
+     * @sensor_id: sensor index
+     *
+     * Get a sensor temperature.
+     *
+     * Returns: sensor temperature in °C.
+     */
+    float (*get_temperature)(TempSensor *obj, unsigned sensor_id);
+} TempSensorClass;
+
+#endif /* HW_MISC_TEMP_SENSOR_H */
diff --git a/hw/misc/temp-sensor.c b/hw/misc/temp-sensor.c
new file mode 100644
index 0000000000..b7c1eb2d87
--- /dev/null
+++ b/hw/misc/temp-sensor.c
@@ -0,0 +1,25 @@
+/*
+ * Generic interface for temperature sensors
+ *
+ * Copyright (c) 2020 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/temp-sensor.h"
+
+static TypeInfo tempsensor_interface_type_info = {
+    .name = TYPE_TEMPSENSOR_INTERFACE,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(TempSensorClass),
+};
+
+static void tempsensor_register_types(void)
+{
+    type_register_static(&tempsensor_interface_type_info);
+}
+
+type_init(tempsensor_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2b..5559110c56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1575,6 +1575,12 @@ F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
 F: tests/qtest/sd*
 
+Temperature Sensors
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Odd Fixes
+F: hw/misc/temp-sensor.c
+F: include/hw/misc/temp-sensor.h
+
 USB
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 68aae2eabb..4f90efb06d 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -90,3 +90,4 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 obj-$(CONFIG_MAC_VIA) += mac_via.o
 
 common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
+common-obj-y += temp-sensor.o
-- 
2.21.1


