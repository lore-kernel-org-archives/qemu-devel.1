Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F780C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B2D2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chidQ7+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B2D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQruK-00047a-P1
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpb-0005OZ-6A
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpa-0006OU-ID
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpa-0006Ha-2K; Tue, 21 Apr 2020 08:16:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id g12so3417706wmh.3;
 Tue, 21 Apr 2020 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qB64pMQz077pdvYBO2lwMlbmaOOXxOAZW+fx+kae1v0=;
 b=chidQ7+4Ch8UfiagLu9jPE6HSdWivmHZ2BE3S7Y5ntFGWwtBcq/3OuGPPEBLP0cj/Q
 U3NDfqwr6qpKZ3P1dAfTYLadrilu3N6h9Avmw5vzHAHLhSCj38sNiFprc9UaXul2WWlv
 i57u2MxpDm5QGIxe1gLknsZeHqqKEnlGVSBQ5or5FBW7Bz0TZh4yFSGV+O6/xI+lDOnT
 LSE8INPlTnH+DMNvGilhIHcooeX6/FHtDjx8Eq+XXY4RdV5xJ9BwA5qKD4Qh2ciR1tsI
 Mj9YBPr4IK82qT9GScFkpNxkO2qTBcny7rYzaySSRkhUzXMPGiJeAFhyOLk1FUCAx0+x
 Qylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qB64pMQz077pdvYBO2lwMlbmaOOXxOAZW+fx+kae1v0=;
 b=hyz2ud4EBsIvxs/72nX2J0ptqvnPvINGGjVwIY9laTq7nxMLMSeJCPdKaeq4Mzry9d
 zIiroeIzhWR8RQqQnGb9AUU+0ZdF/NYaMoSTFEEbYY5wVrkUaNUbqkbbVXKmfYUlphR5
 Of7PnD5w51UQ5weqmwXvI3EAWy85deNUXdd8rIIhU1ly7rvT1o9R0jqfLysdQjV8K5DV
 rKL1ZfzUATI7LX2ZbpPKeM3QMjD1EB4lscEr0ksSPs9vbm726P4nLpsc/aG5DdnZRqPH
 ZMrwobi6Iivs+yU70Y5aZtBtz4qgTN2YFRxTqhlWQtv2FtRMyDJGq19IMNXLdX+69olE
 KJaQ==
X-Gm-Message-State: AGi0PuZqh/qeq/OI7F+BvFZnOsJppi3uAqSYgLsEEzGfiqDOoI3cdPN2
 TZGX6iKBieRui5skWTc74ubHGM2ZJo0=
X-Google-Smtp-Source: APiQypJsuJ1vfx8TLbcBvopG+E0ZH8VhL1BO4VVwV0Wgvrg88IEdNQLrL7WepIexLN2THQDa+fEr/Q==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr4431625wmg.109.1587471406418; 
 Tue, 21 Apr 2020 05:16:46 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 09/17] hw/misc/tmp421: Implement the 'temperature-sensor'
 qdev interface
Date: Tue, 21 Apr 2020 14:16:18 +0200
Message-Id: <20200421121626.23791-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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

The TMP421 is an I2C device with multiple temperature sensors.
Let it implement the 'temperature-sensor' interface.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/tmp421.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 270e7d5510..31bfbecb1d 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
+#include "hw/misc/temp-sensor.h"
 
 /* Manufacturer / Device ID's */
 #define TMP421_MANUFACTURER_ID          0x55
@@ -138,6 +139,21 @@ static void set_temp_mC(TMP421State *s, unsigned int id,
     s->temperature[id] = (int16_t) ((temp * 256 - 128) / 1000) + offset;
 }
 
+static float tmp421_get_temp(TempSensor *obj, unsigned sensor_id)
+{
+    TMP421State *s = TMP421(obj);
+
+    return get_temp_mC(s, sensor_id) / 1000.f;
+}
+
+static void tmp421_set_temp(TempSensor *obj, unsigned sensor_id,
+                            float temp_C, Error **errp)
+{
+    TMP421State *s = TMP421(obj);
+
+    set_temp_mC(s, sensor_id, temp_C * 1000.f, errp);
+}
+
 static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
@@ -380,6 +396,7 @@ static void tmp421_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
     TMP421Class *sc = TMP421_CLASS(klass);
+    TempSensorClass *tc = TEMPSENSOR_INTERFACE_CLASS(klass);
 
     dc->realize = tmp421_realize;
     k->event = tmp421_event;
@@ -387,6 +404,9 @@ static void tmp421_class_init(ObjectClass *klass, void *data)
     k->send = tmp421_tx;
     dc->vmsd = &vmstate_tmp421;
     sc->dev = (DeviceInfo *) data;
+    tc->sensor_count = SENSORS_COUNT;
+    tc->set_temperature = tmp421_set_temp;
+    tc->get_temperature = tmp421_get_temp;
 }
 
 static const TypeInfo tmp421_info = {
@@ -396,6 +416,10 @@ static const TypeInfo tmp421_info = {
     .class_size    = sizeof(TMP421Class),
     .instance_init = tmp421_initfn,
     .abstract      = true,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TEMPSENSOR_INTERFACE },
+        { }
+    },
 };
 
 static void tmp421_register_types(void)
-- 
2.21.1


