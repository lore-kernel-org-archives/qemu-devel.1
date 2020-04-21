Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D2C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231FD2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZHkmtxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231FD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrvn-0006s7-59
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpm-0005hq-F3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpk-0006uN-Qg
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:17:01 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:32897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpj-0006ig-HV; Tue, 21 Apr 2020 08:17:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id v8so2397450wma.0;
 Tue, 21 Apr 2020 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CYtLz8PPZg3PndLlvtgyHck5NW5BLfVBBR1hau+JN5c=;
 b=TZHkmtxxqAXN1pgT9h5BfTyJGo1J9DJ9gFdiRGyS64zCu8FenqR3yCc0/frBfAN/Uq
 I9SODa3i8jveF26QqNDklGK5M8KA0ETnVU+QMXmE3NqZjVVOhgtigcuo5dFkz6lOdXSO
 3C5ehpy4nlJjwDLhW5tzq29XsnhakU54kkmGxLlPfDSf0yDYVvTgAEa0wWQpDX9v1JUp
 hctyrQZgt1gUZnYaOhca7BygS1I4J/cMhSUbqywrd11HjVzDp/ecqiCMwDkYePXMEW6g
 8VZt0LA8OuIa0AtWdUIGh5Myau9HWA4zNNf23oW70cdykAreycg4YGcWVo0HtzMnPSM7
 Pg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CYtLz8PPZg3PndLlvtgyHck5NW5BLfVBBR1hau+JN5c=;
 b=XDj7ZG6lqF/Cl0fqCOGHu1jNwJIUrv0F8Mp0gvtgfasYX4nLhOIG78wdGGXHK/whOB
 IYPn5kWamjiTSRPDFlUlu3ckHC5MShs2Snu9k44pRpdxYHYVANRoFwVIc1lLETeSbSFK
 WebujdahxsBMEuTCHAEUtoaeuCybjwGlVp3V5NbRwf7LJ5TW/XCbBHRT59Gi6IwVXrjh
 k/IiuPEskn5mtbRkDjCnsB2rdbZLkzgVn4Ah7U6URNruzwJHaLwx8UersxxY2JpOWHpG
 a4TywZoviAPJ0E7/4EQKxsrRgUzvCOvB7sXNG2purczcORIPwzfUX74fGLmerveNgd0v
 d9pA==
X-Gm-Message-State: AGi0PuYqyipsRARAmyXvyhPQ/WBoCpwaFQFPkde1h2g6eRubCJZIkv6m
 ZxPbtBvuesA/TZ6ryEIPWBJgND7TwS0=
X-Google-Smtp-Source: APiQypIzhC2Noi2yk8BmmqC+or1z3xXHBvrSGm8/5GIfDfg3z2sJYuOa8clDfbYT8fmdP1lTZUC3HA==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr4385077wml.7.1587471415949;
 Tue, 21 Apr 2020 05:16:55 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 14/17] hw/display/ads7846: Implement the
 'temperature-sensor' qdev interface
Date: Tue, 21 Apr 2020 14:16:23 +0200
Message-Id: <20200421121626.23791-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

The 4-wire ADS7846 Touch Screen Controller is able to report a
pair of temperatures.  Let it implement the 'temperature-sensor'
interface.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/ads7846.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/display/ads7846.c b/hw/display/ads7846.c
index 9228b40b1a..e37e99f5ec 100644
--- a/hw/display/ads7846.c
+++ b/hw/display/ads7846.c
@@ -16,6 +16,7 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "ui/console.h"
+#include "hw/misc/temp-sensor.h"
 
 typedef struct {
     SSISlave ssidev;
@@ -53,6 +54,12 @@ typedef struct {
 #define ADS_Z1POS(x, y)	600
 #define ADS_Z2POS(x, y)	(600 + 6000 / ADS_XPOS(x, y))
 
+/* TI Datasheet SBAS125H "TEMP DIODE VOLTAGE vs TEMPERATURE (2.7V SUPPLY)" */
+#define ADS_TEMP0_OFS_MILLIV    666.f
+#define ADS_TEMP1_OFS_MILLIV    761.f
+#define ADS_TEMP0_COEFF         2.08f
+#define ADS_TEMP1_COEFF         1.60f
+
 static void ads7846_int_update(ADS7846State *s)
 {
     if (s->interrupt)
@@ -157,12 +164,39 @@ static void ads7846_realize(SSISlave *d, Error **errp)
     vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_ads7846, s);
 }
 
+static float ads7846_get_temp(TempSensor *obj, unsigned sensor_id)
+{
+    ADS7846State *s = (ADS7846State *)obj;
+
+    if (sensor_id) {
+        return (ADS_TEMP1_OFS_MILLIV - s->input[7]) / ADS_TEMP1_COEFF;
+    } else {
+        return (ADS_TEMP0_OFS_MILLIV - s->input[0]) / ADS_TEMP0_COEFF;
+    }
+}
+
+static void ads7846_set_temp(TempSensor *obj, unsigned sensor_id,
+                             float temp_C, Error **errp)
+{
+    ADS7846State *s = (ADS7846State *)obj;
+
+    if (sensor_id) {
+        s->input[7] = ADS_TEMP1_OFS_MILLIV - ADS_TEMP1_COEFF * temp_C;
+    } else {
+        s->input[0] = ADS_TEMP0_OFS_MILLIV - ADS_TEMP0_COEFF * temp_C;
+    }
+}
+
 static void ads7846_class_init(ObjectClass *klass, void *data)
 {
     SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    TempSensorClass *tc = TEMPSENSOR_INTERFACE_CLASS(klass);
 
     k->realize = ads7846_realize;
     k->transfer = ads7846_transfer;
+    tc->sensor_count = 2;
+    tc->set_temperature = ads7846_set_temp;
+    tc->get_temperature = ads7846_get_temp;
 }
 
 static const TypeInfo ads7846_info = {
@@ -170,6 +204,10 @@ static const TypeInfo ads7846_info = {
     .parent        = TYPE_SSI_SLAVE,
     .instance_size = sizeof(ADS7846State),
     .class_init    = ads7846_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TEMPSENSOR_INTERFACE },
+        { }
+    },
 };
 
 static void ads7846_register_types(void)
-- 
2.21.1


