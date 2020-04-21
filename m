Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4161C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650C62076A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZs0lzp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650C62076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrwX-0008Cn-CV
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpe-0005UV-70
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpd-0006XH-Lf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpd-0006PR-2F; Tue, 21 Apr 2020 08:16:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id g12so3417913wmh.3;
 Tue, 21 Apr 2020 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IyJhSv7U0RIReQL21ef7Kz/LxG84zJJ7a7GHPqexH+s=;
 b=jZs0lzp9gafMyzrDRS+QR6YfdUjHvBE1rdQr9wZ3GJhPg89j0TOh1rsoD0gNqaL7FX
 FCnYe10UQ9eR00XB5EE60v9/095OsIAgGS0qHxz/xWz4XLpApUz2q3mXU9qx/DOmag7L
 2D7+5TaWO2cHDCr01e7JiUvmXsklrff79Xs+eLXNnvTh/RYDiTkLYdWNF8uuXuBarlLv
 xco+4+yOicvMugRKdVw5gzMKr4r1/26uZz06+Gjjnld3QfQpIpat9D0wnDaJKV61iz7v
 jcmfGcNv88A4aoL8VR+EnSuT2XoP9LczYiIKzXXOSFoJbpyVHKFQk1r4nKWip0iee0PE
 aSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IyJhSv7U0RIReQL21ef7Kz/LxG84zJJ7a7GHPqexH+s=;
 b=GyBpWz8NnY3rTKsdTxNGA2m+CzjmSYgpLJTydR2X/BygS9yf6HqqWrk3pAJtVgRIct
 S0gDvbWRUu585k3lUmbMXivEv+U6xmtrXCJKvL0P3z48hDVN5PZCpHW/5vX7cO52hPLF
 /IGzbURmGrvoLHqyBqFsm110LAU8gWEeTpOGK1kClNQzKGCaERmCfEGqRTKMETi3BZqx
 bdsxUvH1zcsBN6RJ5SimT/1Stt/jxKPygMdGALDXizPuKdxHX4jX7GlpS/8o8dwWAoYj
 ukSb50DwMvjI6E3eNWJMIh+lBrwcuTgpX5ZFTBchzfv64AInPR+4GP9xKDJYvkAEylPG
 h0Ng==
X-Gm-Message-State: AGi0PuZGe5IoUtY3U56v9xZImPAMaCN9JJeZ794ipdwo2HAuFOAspdL7
 8w7Kbaql9voN2bh4QQUn1CIzHmINcHk=
X-Google-Smtp-Source: APiQypKuHJmvI+idgdP5oH/b2xdw+68Z1GBBAd3j99WQnkfGxW3eAYLspjpnL7eR5trVmygV+e8vNA==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr4515065wmc.142.1587471410144; 
 Tue, 21 Apr 2020 05:16:50 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/17] hw/misc/bcm2835_thermal: Implement the
 'temperature-sensor' interface
Date: Tue, 21 Apr 2020 14:16:20 +0200
Message-Id: <20200421121626.23791-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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

The BCM2835 has a block that reports its temperature.
Let it implement the 'temperature-sensor' interface.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/bcm2835_thermal.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
index 6ee149de20..6b85cf9705 100644
--- a/hw/misc/bcm2835_thermal.c
+++ b/hw/misc/bcm2835_thermal.c
@@ -12,6 +12,7 @@
 #include "hw/misc/bcm2835_thermal.h"
 #include "hw/registerfields.h"
 #include "migration/vmstate.h"
+#include "hw/misc/temp-sensor.h"
 
 REG32(CTL, 0)
 FIELD(CTL, POWER_DOWN, 0, 1)
@@ -32,6 +33,21 @@ FIELD(STAT, INTERRUPT, 11, 1)
 #define THERMAL_OFFSET_C 412
 #define THERMAL_COEFF  (-0.538f)
 
+static void bcm2835_set_temperature(TempSensor *obj, unsigned int sensor_id,
+                                    float temp, Error **errp)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(obj);
+
+    s->temp = temp;
+}
+
+static float bcm2835_get_temperature(TempSensor *obj, unsigned int sensor_id)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(obj);
+
+    return s->temp;
+}
+
 static uint16_t bcm2835_thermal_temp2adc(float64 temp_C)
 {
     return (temp_C - THERMAL_OFFSET_C) / THERMAL_COEFF;
@@ -121,10 +137,14 @@ static const VMStateDescription bcm2835_thermal_vmstate = {
 static void bcm2835_thermal_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    TempSensorClass *tc = TEMPSENSOR_INTERFACE_CLASS(klass);
 
     dc->realize = bcm2835_thermal_realize;
     dc->reset = bcm2835_thermal_reset;
     dc->vmsd = &bcm2835_thermal_vmstate;
+    tc->sensor_count = 1;
+    tc->set_temperature = bcm2835_set_temperature;
+    tc->get_temperature = bcm2835_get_temperature;
 }
 
 static const TypeInfo bcm2835_thermal_info = {
@@ -133,6 +153,10 @@ static const TypeInfo bcm2835_thermal_info = {
     .instance_size = sizeof(Bcm2835ThermalState),
     .instance_init = bcm2835_thermal_init,
     .class_init = bcm2835_thermal_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TEMPSENSOR_INTERFACE },
+        { }
+    },
 };
 
 static void bcm2835_thermal_register_types(void)
-- 
2.21.1


