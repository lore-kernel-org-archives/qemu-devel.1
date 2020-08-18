Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0289AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06FA206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpCm3KD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06FA206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83Ya-0006gT-Sc
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k82l0-0006h6-Ng; Tue, 18 Aug 2020 10:38:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k82ky-0002z5-V1; Tue, 18 Aug 2020 10:38:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id k8so17248198wma.2;
 Tue, 18 Aug 2020 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G/uCLWaQ9/GC6p92u4AC2/fMAZX9rQveSBzhpBtS05w=;
 b=VpCm3KD8qjtSjgc0szFsLzm2liuitP2rGzNRyHCDmQMvvBjHOq98rif2bpQI377kRt
 6WxnFngKIFULlLXjkr05raic3JBRI2RXFI/J5C/jAWLmNu38aQEb5dLczfAmTOFqmt9s
 d1DNRgGgyaeROUhoN8/CXSzUoGAqhxijh/1nKa+NzjB3hiUr5D63JG8JM7WfyalZIYbF
 AmhaByNf6BiznD99ISkxmexhCBumANSsCsucJJyHqJHDr2H93kv0G+LdNKON2Bp4cO9s
 nDcMqqsNFbeVgfxsCGON09bXnSlQ/KF0aa0cTH+dkABNr4epW2sABCg8fHg0qTjbS2Yn
 eMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=G/uCLWaQ9/GC6p92u4AC2/fMAZX9rQveSBzhpBtS05w=;
 b=Wi0g54HVMhNVoD/7vvNmpv1cHJX3usJ+ZqDf2lU/iRfT8O880F1jXIGWH7B6AodjAd
 taekXWMZF7QcptXsTDHeTxcZ971GSlP/FlmBz4UiWYwA9b8Xj33AyKR4b/7JUWQbLqVm
 n2X6V5OXba4chgvpIMCUzkv5uWphYRZKNqfYCDPKXHLS35WU8tMGE0J9cqwKP75Z6kjY
 1zWqRygcBJTmNk4CTat6TsqNWqrR3xaSBjMeYM/oz1RJykGcQiWC6kUsgnAebFRHirrT
 L/KoqqP4/lRJbj374jU091UoYetYRW/WkE5AvCR6fyhxiAMsYm+2b0ybCWkjijZIXLq+
 Ut2w==
X-Gm-Message-State: AOAM531adJnnCk//5Y6xAp2CnjW+E9T2G5lAe7ajBAtnx+kEXdCXn+/q
 abXhuwUaiXZmLJbHnb/oRq6A4Ioc8RA=
X-Google-Smtp-Source: ABdhPJxBdZMHsQ13wn4Jn4/vvkn9clMjwCUoscXSZQhed/ngWCJJ1shX8Y4YY5mUcoNpkpBa6BsNOA==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr250551wma.62.1597761509689;
 Tue, 18 Aug 2020 07:38:29 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z8sm139177wmf.42.2020.08.18.07.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 07:38:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/core/qdev: Make qdev_pass_gpios() arguments
 self-describing
Date: Tue, 18 Aug 2020 16:38:24 +0200
Message-Id: <20200818143825.691110-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818143825.691110-1-f4bug@amsat.org>
References: <20200818143825.691110-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the direction qdev_pass_gpios() pass the GPIOs more obvious
by renaming its arguments as 'from_dev' and 'to_container'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h | 10 +++++-----
 hw/core/qdev.c         | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index ea3f73a282d..c72d4db2d26 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -643,8 +643,8 @@ static inline void qdev_init_gpio_in_named(DeviceState *dev,
 
 /**
  * qdev_pass_gpios: create GPIO lines on container which pass through to device
- * @dev: Device which has GPIO lines
- * @container: Container device which needs to expose them
+ * @from_dev: Device which has GPIO lines
+ * @to_container: Container device which needs to expose them
  * @name: Name of GPIO array to pass through (NULL for the anonymous GPIO array)
  *
  * In QEMU, complicated devices like SoCs are often modelled with a
@@ -653,14 +653,14 @@ static inline void qdev_init_gpio_in_named(DeviceState *dev,
  * to create GPIO arrays on itself which simply pass through to a GPIO
  * array of one of its internal devices.
  *
- * If @dev has both input and output GPIOs named @name then both will
+ * If @from_dev has both input and output GPIOs named @name then both will
  * be passed through. It is not possible to pass a subset of the array
  * with this function.
  *
- * To users of the container device, the GPIO array created on @container
+ * To users of the container device, the GPIO array created on @to_container
  * behaves exactly like any other.
  */
-void qdev_pass_gpios(DeviceState *dev, DeviceState *container,
+void qdev_pass_gpios(DeviceState *from_dev, DeviceState *to_container,
                      const char *name);
 
 BusState *qdev_get_parent_bus(DeviceState *dev);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 96772a15bd5..79cbd990114 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -576,30 +576,30 @@ void qdev_connect_gpio_out(DeviceState * dev, int n, qemu_irq pin)
     qdev_connect_gpio_out_named(dev, NULL, n, pin);
 }
 
-void qdev_pass_gpios(DeviceState *dev, DeviceState *container,
+void qdev_pass_gpios(DeviceState *from_dev, DeviceState *to_container,
                      const char *name)
 {
     int i;
-    NamedGPIOList *ngl = qdev_get_named_gpio_list(dev, name);
+    NamedGPIOList *ngl = qdev_get_named_gpio_list(from_dev, name);
 
     for (i = 0; i < ngl->num_in; i++) {
         const char *nm = ngl->name ? ngl->name : "unnamed-gpio-in";
         char *propname = g_strdup_printf("%s[%d]", nm, i);
 
-        object_property_add_alias(OBJECT(container), propname,
-                                  OBJECT(dev), propname);
+        object_property_add_alias(OBJECT(to_container), propname,
+                                  OBJECT(from_dev), propname);
         g_free(propname);
     }
     for (i = 0; i < ngl->num_out; i++) {
         const char *nm = ngl->name ? ngl->name : "unnamed-gpio-out";
         char *propname = g_strdup_printf("%s[%d]", nm, i);
 
-        object_property_add_alias(OBJECT(container), propname,
-                                  OBJECT(dev), propname);
+        object_property_add_alias(OBJECT(to_container), propname,
+                                  OBJECT(from_dev), propname);
         g_free(propname);
     }
     QLIST_REMOVE(ngl, node);
-    QLIST_INSERT_HEAD(&container->gpios, ngl, node);
+    QLIST_INSERT_HEAD(&to_container->gpios, ngl, node);
 }
 
 BusState *qdev_get_child_bus(DeviceState *dev, const char *name)
-- 
2.26.2


