Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BDEC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA582076B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvMWhnmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA582076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs0J-0005qh-Pr
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpo-0005l8-AY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpm-0006x3-JA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:17:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpl-0006pL-3X; Tue, 21 Apr 2020 08:17:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id u127so3433073wmg.1;
 Tue, 21 Apr 2020 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zOrL0Bw2XAb9sksyQa2AaC8LCpCTMRMx/mgWehci6Rg=;
 b=qvMWhnmPkerQAXKEyBEg3wcrkLbAxN5Gm+OCD5CFWHErRv5J9TMYMyH0RmeO0r8U7G
 QQ8sOnefZQZ8ENHxkwTwCUSfd6YrQKTVrkfHJJMAvXt1t6nQOR2yvb/0LyK/ksTcXEVx
 /RaDHNvEtxeL+LmcSafDOOpZtUFNXIajcwCypfZX14Zb7Q5VTHEVRKs0M4ZMrfMok+SE
 tzMszs5Gkhxk1NvP8UFrLye5G66xtiLuGbuhE3YPTOwT8zKHJLi21G2ZrvpW/t1MJ3dA
 8b08MhvOzdXEQiN/U6hPfw0TMwQycQXQkb08FnTTb1UI49p96Psxh0KhNxmul7iU/OTn
 mQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zOrL0Bw2XAb9sksyQa2AaC8LCpCTMRMx/mgWehci6Rg=;
 b=aFy2zNVAGdBdG0azm2ssoXUgy2T1fhfPQ5aCOSMfgf9JPqAO6BAhBqM3wQ0JVonTMo
 V01zI6HSQUuX5G6ZJmhN0FrpGLPbWGbEF1X0ctiu1FKrVsndEKwXo6Vxw+XoqUzmJpMa
 OKdU6iBbQ9pTYfAFuE3EV3k1YR8/HkKiFH7HA61R5HFGuzKia1e6C4TimYfYhISx9Abj
 UVqoDhChFUIpmxjkIJ3ln1DCFETVoFKWIWAihV14ZOK/beboXIDfmxOa9WnFxBbY1oZY
 GRoRL3r/XYNeqIrKuC3sa4UFgBbyiFTG3DnOnPErFFWbsZVuuZwIp3etD89kCpBRSWwj
 5eGw==
X-Gm-Message-State: AGi0PuZs5l+RZE6CI/EBex6YCG3a9FoHXGJZuWzL6MC8Ws9Cv64kEQIz
 8/b8CIRbq3tPEohJw5/fCAZZaT0fVIk=
X-Google-Smtp-Source: APiQypIYPDgFFpBFbwESXHwQ6Kj5g/rORzJTF60JCbZ+SPujuhkgh5XcYcVJIhSZF/Fa54CYeUTeKQ==
X-Received: by 2002:a1c:3986:: with SMTP id g128mr4586515wma.8.1587471417858; 
 Tue, 21 Apr 2020 05:16:57 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 15/17] hw/ide/qdev: Implement the 'temperature-sensor'
 qdev interface
Date: Tue, 21 Apr 2020 14:16:24 +0200
Message-Id: <20200421121626.23791-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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

IDE drives exposing a SMART interface report the air flow
temperature. Let them implement the 'temperature-sensor'
interface.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/qdev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index c22afdb8ee..144d6ab533 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 #include "qapi/visitor.h"
+#include "hw/misc/temp-sensor.h"
 
 /* --------------------------------- */
 
@@ -270,6 +271,12 @@ static void ide_dev_instance_init(Object *obj)
     object_property_set_int(obj, -1, "bootindex", NULL);
 }
 
+static float ide_hd_get_temp(TempSensor *obj, unsigned sensor_id)
+{
+    /* See airflow-temperature-celsius in smart_attributes[] */
+    return 100.f - 0x45;
+}
+
 static void ide_hd_realize(IDEDevice *dev, Error **errp)
 {
     ide_dev_initfn(dev, IDE_HD, errp);
@@ -315,11 +322,14 @@ static void ide_hd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
+    TempSensorClass *tc = TEMPSENSOR_INTERFACE_CLASS(klass);
 
     k->realize  = ide_hd_realize;
     dc->fw_name = "drive";
     dc->desc    = "virtual IDE disk";
     device_class_set_props(dc, ide_hd_properties);
+    tc->sensor_count = 1;
+    tc->get_temperature = ide_hd_get_temp;
 }
 
 static const TypeInfo ide_hd_info = {
@@ -327,6 +337,10 @@ static const TypeInfo ide_hd_info = {
     .parent        = TYPE_IDE_DEVICE,
     .instance_size = sizeof(IDEDrive),
     .class_init    = ide_hd_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TEMPSENSOR_INTERFACE },
+        { }
+    },
 };
 
 static Property ide_cd_properties[] = {
-- 
2.21.1


