Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4781C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9A520684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B11h9vC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9A520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueUL-0002Ru-Ux
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrb-0005Ik-DI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucra-00042M-6n
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:39 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucra-0003yD-04
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:38 -0500
Received: by mail-wr1-x42c.google.com with SMTP id q6so3120238wro.9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iMY7RCyLDjVvD/6DMcsQnff3G2M3+BaxKEPV2kf0Sdo=;
 b=B11h9vC83d5DX0RkqTTv9sx7Q7jXyKLFhtU7h63Qa0zeZr3NRynrFYzWwVbPs5NSAy
 Ijz/pXUodkRbllvzhuO0EMzH1QdeFe1O6GYhF121iQH3VLUUWb0forb0h7KWPYZ8J4Ij
 6ylvnBlfBadurrb/YX+50E2yMuBWJ4uWSphaw9jgX9rnbB4Jwek7twrF1sHzzwNdvRL+
 ootgy8NOWV3a5TTeMywcj2lgJ9aozjcEJtJSUuxYAb5frdPB3DSJ0U/MXVC42nMQmqDN
 wfID7t34uU9K/mcTXFV5TuoBAvyLcDyXJCMxkiARSt+EfJYI2r76E/n2z18cWgCTWNuT
 fd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iMY7RCyLDjVvD/6DMcsQnff3G2M3+BaxKEPV2kf0Sdo=;
 b=qY4++3jSGYwc9/Sl1PI8OcCCeaxqpOaJQRO+vCgGfZ6k7hJctNGlbvQRe9IpV6gWh+
 OXxcEKiuExQWuWmaPDSXagL+JWKu6YbdcFc7SiNur2hbp8QZMOBYAoxOaGMx5i8HVzXH
 8iqYK1xHoG5k5H6/1MYqP9knbfPQ5Y3P46h9VbDu/Y5aQiz5TKb/gJKafplwcweC8/wd
 GwEu2fH8jxjBtrSRnB/dD45LWrv3TjNRXPTPj8WuUO7P4Hijwm0OoK8yx+z9pHSlCWpG
 ruT4Emv0OCdqMRvq0oWHU8XfcixgSmjE335+dl+ijF0b5xOR92GOpqu9QXtClusslZL9
 9lWQ==
X-Gm-Message-State: APjAAAXhBFEibv1muDeO6cNYqneU9vqmocc1f0OeHMF2rYADGpLnpk6P
 ejSz0B8ri5hKCpjN0ppPTXoiepgi
X-Google-Smtp-Source: APXvYqzO/wfzNBsPUxWqsX52SJ/PORF98s8kBd5OzOY0JXkcvF9O/qESv5FHWKRy5Y7qIOprMaKSqg==
X-Received: by 2002:adf:df03:: with SMTP id y3mr17892903wrl.260.1579787376819; 
 Thu, 23 Jan 2020 05:49:36 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/59] qdev: move helper function to monitor/misc
Date: Thu, 23 Jan 2020 14:48:37 +0100
Message-Id: <1579787342-27146-35-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Move the one-user function to the place it is being used.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200110153039.1379601-5-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c         | 26 --------------------------
 include/hw/qdev-core.h |  2 --
 monitor/misc.c         | 26 ++++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 60aec8b..8708605 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -760,32 +760,6 @@ void qdev_alias_all_properties(DeviceState *target, Object *source)
     } while (class != object_class_by_name(TYPE_DEVICE));
 }
 
-static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
-{
-    GSList **list = opaque;
-    DeviceState *dev = (DeviceState *)object_dynamic_cast(OBJECT(obj),
-                                                          TYPE_DEVICE);
-
-    if (dev == NULL) {
-        return 0;
-    }
-
-    if (dev->realized && object_property_get_bool(obj, "hotpluggable", NULL)) {
-        *list = g_slist_append(*list, dev);
-    }
-
-    return 0;
-}
-
-GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
-{
-    GSList *list = NULL;
-
-    object_child_foreach(peripheral, qdev_add_hotpluggable_device, &list);
-
-    return list;
-}
-
 static bool device_get_realized(Object *obj, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 1518495..6b0e7b2 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -457,8 +457,6 @@ extern bool qdev_hot_removed;
 
 char *qdev_get_dev_path(DeviceState *dev);
 
-GSList *qdev_build_hotpluggable_device_list(Object *peripheral);
-
 void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp);
 
 void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp);
diff --git a/monitor/misc.c b/monitor/misc.c
index de1ca4d..4752150 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1959,6 +1959,32 @@ void object_add_completion(ReadLineState *rs, int nb_args, const char *str)
     g_slist_free(list);
 }
 
+static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+    DeviceState *dev = (DeviceState *)object_dynamic_cast(OBJECT(obj),
+                                                          TYPE_DEVICE);
+
+    if (dev == NULL) {
+        return 0;
+    }
+
+    if (dev->realized && object_property_get_bool(obj, "hotpluggable", NULL)) {
+        *list = g_slist_append(*list, dev);
+    }
+
+    return 0;
+}
+
+static GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
+{
+    GSList *list = NULL;
+
+    object_child_foreach(peripheral, qdev_add_hotpluggable_device, &list);
+
+    return list;
+}
+
 static void peripheral_device_del_completion(ReadLineState *rs,
                                              const char *str, size_t len)
 {
-- 
1.8.3.1



