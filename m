Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D81C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F8220760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWWololK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F8220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP8V-0006Xl-EW
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxS-0005OK-7A
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:38 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxQ-0005jD-A0
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:37 -0400
Received: by mail-wr1-x434.google.com with SMTP id z2so11163586wrp.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BV5GFtOw7R1H4BotV7qt+eZkjeU8tiG6fWsBH/nC4NE=;
 b=EWWololKHeGgEes6IpwthhB0QUqEi+VEEERDOqW5NuniZEoVamTavcURzRXwo/8C8q
 wntmtgEkXZ/vwY42fEluTzXY06+/4tq/3G3adc/ouZPqtnNF4fpiLEqQAY3ehmBhOcK8
 /qSHjhyVy2vSt+kxR9h1/Wh7vL8TFNRaHpGC0e7diU2L1D9MN1P66V6uNC1SbBqkkfcg
 OGHlJXDibCgpMhpnjM5hG2Bdm6S7cnXniz0t/GjukEjnc/0MT/hMVlxp/vFw25cHCNIQ
 hwNG3ZEj/6dTL7b/AJJ+9WPrBY6MK9JgtE+ysNY5t/WpfPjT4B/qD5nBHAppns+UF6Db
 BjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BV5GFtOw7R1H4BotV7qt+eZkjeU8tiG6fWsBH/nC4NE=;
 b=ZQSyP7aPWVsdjGo0xpjKlKc+mEw2wssfDZU2yR94ULi68DP0B8CtVwJ0Hvaw4/QXGU
 3bh9cW+LV9DED3Xz1llOUf4jZR1hpTtWaamL4y9tqutdlB+llB7XTtXWa9oGxS2al3rk
 uterkInQZYi9jEFK1Ois9qrALbOEMAJHMV/pN7JwjPBOgHF9kLoGlub5oEkRiVe3PVqv
 VNnFJla3+BOnnYj3rlTuW9jQfdUP78El3pxvlc+PnpyIYa+aCdvyLWrIAWHExfwty1Np
 WEabxSrnTtIZFlxvhJ7+7ZA/i3lYqjYM4AHHEoFsI9gAO165g6HoxZy23REbwghrx1Lx
 zFmg==
X-Gm-Message-State: AOAM531JGo1FYAmHcbvJKTukSvvp1KLhidyv86GR84TMQAZUWLyJvt1K
 BWvOO/rSNbaYBVJ+GYqkbuoyTX0/RJRRZA==
X-Google-Smtp-Source: ABdhPJzNa43uaFN8QDTMUqDzBR5/6l7uoRUyr4Tmtk/SE5yr8Q+mTULs/VYZSYgV4jBCeCHTxsHgzA==
X-Received: by 2002:adf:8444:: with SMTP id 62mr35981389wrf.278.1593795274578; 
 Fri, 03 Jul 2020 09:54:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/34] ssi: Add ssi_realize_and_unref()
Date: Fri,  3 Jul 2020 17:53:55 +0100
Message-Id: <20200703165405.17672-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an ssi_realize_and_unref(), for the benefit of callers
who want to be able to create an SSI device, set QOM properties
on it, and then do the realize-and-unref afterwards.

The API works on the same principle as the recently added
qdev_realize_and_undef(), sysbus_realize_and_undef(), etc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-9-peter.maydell@linaro.org
---
 include/hw/ssi/ssi.h | 26 ++++++++++++++++++++++++++
 hw/ssi/ssi.c         |  7 ++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 93f2b8b0beb..4be5325e654 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -79,6 +79,32 @@ extern const VMStateDescription vmstate_ssi_slave;
 }
 
 DeviceState *ssi_create_slave(SSIBus *bus, const char *name);
+/**
+ * ssi_realize_and_unref: realize and unref an SSI slave device
+ * @dev: SSI slave device to realize
+ * @bus: SSI bus to put it on
+ * @errp: error pointer
+ *
+ * Call 'realize' on @dev, put it on the specified @bus, and drop the
+ * reference to it. Errors are reported via @errp and by returning
+ * false.
+ *
+ * This function is useful if you have created @dev via qdev_new()
+ * (which takes a reference to the device it returns to you), so that
+ * you can set properties on it before realizing it. If you don't need
+ * to set properties then ssi_create_slave() is probably better (as it
+ * does the create, init and realize in one step).
+ *
+ * If you are embedding the SSI slave into another QOM device and
+ * initialized it via some variant on object_initialize_child() then
+ * do not use this function, because that family of functions arrange
+ * for the only reference to the child device to be held by the parent
+ * via the child<> property, and so the reference-count-drop done here
+ * would be incorrect.  (Instead you would want ssi_realize(), which
+ * doesn't currently exist but would be trivial to create if we had
+ * any code that wanted it.)
+ */
+bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp);
 
 /* Master interface.  */
 SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 67b48c31cd6..a35d7ebb266 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -90,11 +90,16 @@ static const TypeInfo ssi_slave_info = {
     .abstract = true,
 };
 
+bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp)
+{
+    return qdev_realize_and_unref(dev, &bus->parent_obj, errp);
+}
+
 DeviceState *ssi_create_slave(SSIBus *bus, const char *name)
 {
     DeviceState *dev = qdev_new(name);
 
-    qdev_realize_and_unref(dev, &bus->parent_obj, &error_fatal);
+    ssi_realize_and_unref(dev, bus, &error_fatal);
     return dev;
 }
 
-- 
2.20.1


