Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F23FC55182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083462076A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQjmJ8en"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083462076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrwZ-0008G6-54
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpc-0005Q8-Et
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpb-0006RH-Jn
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpb-0006Ll-3e; Tue, 21 Apr 2020 08:16:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id t14so16164074wrw.12;
 Tue, 21 Apr 2020 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dxi1KO+TbSTdgnmzvfmca5B9kXzDJPZKOcIl8f3DUQw=;
 b=BQjmJ8enz8lUSt6E5WQY5PUGsO/9S96y4lvBf6t5cXsBreDBc61nc8Zi8ULKzcHQ7s
 74CDd24JP69qrGcAPyYuVIV08ZfY3Z8KGgAiH3U4tOk25BgIQX11kbP6m8OZgU2pxwWW
 JVovd/a/oq2kSgRtT9RqL4BS2E9ar3f05I2aI6HooTIaSmg3TVkp5JaLUCDNf+3Rf7gm
 XT69TSTSyswd9i75aoqawj6WhJF4wQGPvdvt+gXH7nhUeEX/Bl0PSZpOGLs+F1TF7i23
 rKoK3NwT90CNYClLgwXG5ol/mgxhU7E1D0B1ExNBx5U1J864QVVBZeylL7UkeEoMoFbE
 FamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dxi1KO+TbSTdgnmzvfmca5B9kXzDJPZKOcIl8f3DUQw=;
 b=nH/DeazyqcFbTb3WbSdEfQOiNPm5JJsCBviC8BFvExZUjKrlOxmCsaCrMwp5CHXvzY
 67q+JkDUNOwlykF3oldR8lrqJrcwHd6vEOs0ink+YsclrOrviWg/Ho7+J3+PoK2HUc+R
 zqN+UPDWAOL+C+jBrPNcZts28fwesG5Zeuy3qekNqwag14j2B+SGoMWadx5UzIH2DSwT
 Rg1a4/ySkVfNzeI+aabDhgaD+/F2Ulj3duAIBrCwObRNjlTjJuuKFq8/Gckqtz95zSRN
 zZ4sp38LQL+IFQx7qR1Yxn+b8r8BzzKj6J0e2RUAnCK8nrFRdix7BikRiK/m9ycM3Np6
 uiEg==
X-Gm-Message-State: AGi0PubTprjWin7NfsZHPN57eFtvnIUbhrMFnIy6g3GgZAV2/vUd8bza
 mEaBh6DLEhwktwQplKYswKsfIhRV62M=
X-Google-Smtp-Source: APiQypI8eN/kNGtO8H27o8kq3sndlRYJmjoJy9u/vHksOMTcHQhVVH44ZebXFb7/QmfOeZNxPAlcAQ==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr23552791wrn.173.1587471408332; 
 Tue, 21 Apr 2020 05:16:48 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 10/17] hw/misc/bcm2835_thermal: Hold the temperature in
 the device state
Date: Tue, 21 Apr 2020 14:16:19 +0200
Message-Id: <20200421121626.23791-11-f4bug@amsat.org>
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

We are going to modify this variable, move it to the device state.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/bcm2835_thermal.h |  1 +
 hw/misc/bcm2835_thermal.c         | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/hw/misc/bcm2835_thermal.h b/include/hw/misc/bcm2835_thermal.h
index c3651b27ec..df6a7b86c3 100644
--- a/include/hw/misc/bcm2835_thermal.h
+++ b/include/hw/misc/bcm2835_thermal.h
@@ -22,6 +22,7 @@ typedef struct {
     /*< public >*/
     MemoryRegion iomem;
     uint32_t ctl;
+    float64 temp;
 } Bcm2835ThermalState;
 
 #endif
diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
index c6f3b1ad60..6ee149de20 100644
--- a/hw/misc/bcm2835_thermal.c
+++ b/hw/misc/bcm2835_thermal.c
@@ -32,7 +32,7 @@ FIELD(STAT, INTERRUPT, 11, 1)
 #define THERMAL_OFFSET_C 412
 #define THERMAL_COEFF  (-0.538f)
 
-static uint16_t bcm2835_thermal_temp2adc(int temp_C)
+static uint16_t bcm2835_thermal_temp2adc(float64 temp_C)
 {
     return (temp_C - THERMAL_OFFSET_C) / THERMAL_COEFF;
 }
@@ -47,8 +47,7 @@ static uint64_t bcm2835_thermal_read(void *opaque, hwaddr addr, unsigned size)
         val = s->ctl;
         break;
     case A_STAT:
-        /* Temperature is constantly 25°C. */
-        val = FIELD_DP32(bcm2835_thermal_temp2adc(25), STAT, VALID, true);
+        val = FIELD_DP32(bcm2835_thermal_temp2adc(s->temp), STAT, VALID, true);
         break;
     default:
         /* MemoryRegionOps are aligned, so this can not happen. */
@@ -85,6 +84,13 @@ static const MemoryRegionOps bcm2835_thermal_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void bcm2835_thermal_init(Object *obj)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(obj);
+
+    s->temp = 25.0;
+}
+
 static void bcm2835_thermal_reset(DeviceState *dev)
 {
     Bcm2835ThermalState *s = BCM2835_THERMAL(dev);
@@ -103,10 +109,11 @@ static void bcm2835_thermal_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription bcm2835_thermal_vmstate = {
     .name = "bcm2835_thermal",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(ctl, Bcm2835ThermalState),
+        VMSTATE_FLOAT64(temp, Bcm2835ThermalState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -124,6 +131,7 @@ static const TypeInfo bcm2835_thermal_info = {
     .name = TYPE_BCM2835_THERMAL,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Bcm2835ThermalState),
+    .instance_init = bcm2835_thermal_init,
     .class_init = bcm2835_thermal_class_init,
 };
 
-- 
2.21.1


