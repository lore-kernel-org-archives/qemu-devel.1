Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CCCC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C41A20735
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKDZqnAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C41A20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXnyW-0005av-OA
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 11:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsp-0006Bp-5P
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnso-0000yr-H1
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id g13so7719580wrb.8
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nhtj1jAF4qT4dfDuiPhnBSJih8Wb/3HVDfEqyCaACoc=;
 b=LKDZqnAw1B5EhxraXCFJv0s3xYPDrGFHCFwuF8LWC3zSrviQFQvc+S3mm4S+WdZjsa
 0U2+UTywrOLHA0dSEAHQvdwilMrUYFVhk/j5/nobwNv6hI2SK6UQ75Op0ktX8B7pWIlM
 ZSznCdty6cNdSDBIfyPT+VhcF5PM0s6PAnTFUKuY+l310xVQjWJqWEy2X6++8P+oAB0r
 o1jXQ1BqKrPGy3+y4XkH0yNTin1Az9s0uI1x3AwLm++pKe7OiK1A/UA9veUmlkWFu3Wu
 Z9NkSR4TwiE3lde/V2ZHfkfEqtroM7q7trCqpMfBKVCAqx61S/b/Xt8yKHBLoBCgndc0
 IX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Nhtj1jAF4qT4dfDuiPhnBSJih8Wb/3HVDfEqyCaACoc=;
 b=rM+c1eG8E21jFhxCm28YZ8HEx0Nyz18KbZj9PJE4urx7yunMUusAfFIiw3L1uFoJE4
 GN28h9hOyUbo21DPtyYx3Yiv1bUHL27ENYMJo4sBlNb4+SExxYydPNWJk5UaMsnCCuM3
 KRlyYu80sBfgvpR4CfTGVLBVi0lHtZrcb2V8pZ+sTo0BlOYikKDlsb9sQ7Kt/sSEh4r+
 8ZZcsTnUPKQyk4sbGQkv4HB9gQvoTel6sHZBxpImHi2LnE2xr0NMi23c/L4viomyizOh
 yiSMT+r8uSneHJoBKQhrHfZ6isJe5yZC+zdL2mJGwl0sG4qmLj4kKhuHlvYZbbY8X5c8
 XNgA==
X-Gm-Message-State: AGi0PuaO5095NNpOcU6PC+GhIVSS+Gq/Qr1NErTqaREzfcDW5WMaqXSd
 CC2PmVzuF1LaUET/1+BOUhYxf9hDWLw=
X-Google-Smtp-Source: APiQypK6xaZiFtQl72J2Rnx7ZWzfryDLEgDNcykWQDkjbHyeP9WanegBpZPqasopUlGsMEERBL6QTQ==
X-Received: by 2002:adf:9447:: with SMTP id 65mr13973249wrq.331.1589124529112; 
 Sun, 10 May 2020 08:28:49 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a67sm24186702wmc.30.2020.05.10.08.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 08:28:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hw/misc/empty_slot: Convert 'size' field as qdev property
Date: Sun, 10 May 2020 17:28:36 +0200
Message-Id: <20200510152840.13558-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510152840.13558-1-f4bug@amsat.org>
References: <20200510152840.13558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/empty_slot.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 5ab426e965..0df086fe98 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/empty_slot.h"
 
 //#define DEBUG_EMPTY_SLOT
@@ -57,17 +58,13 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
     if (slot_size > 0) {
         /* Only empty slots larger than 0 byte need handling. */
         DeviceState *dev;
-        SysBusDevice *s;
-        EmptySlot *e;
 
         dev = qdev_create(NULL, TYPE_EMPTY_SLOT);
-        s = SYS_BUS_DEVICE(dev);
-        e = EMPTY_SLOT(dev);
-        e->size = slot_size;
 
+        qdev_prop_set_uint64(dev, "size", slot_size);
         qdev_init_nofail(dev);
 
-        sysbus_mmio_map_overlap(s, 0, addr, -10000);
+        sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, addr, -10000);
     }
 }
 
@@ -80,11 +77,17 @@ static void empty_slot_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
+static Property empty_slot_properties[] = {
+    DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void empty_slot_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = empty_slot_realize;
+    device_class_set_props(dc, empty_slot_properties);
 }
 
 static const TypeInfo empty_slot_info = {
-- 
2.21.3


