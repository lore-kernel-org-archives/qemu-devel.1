Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45298C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006D9206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e//evoK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006D9206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwXJ-0005Aj-2U
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEj-00018w-31
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45335
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEb-0006bz-JH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599166407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3sKMxahOjYTwSinktMwxAbRSsAgIiqhInGAWsm1MF0=;
 b=e//evoK0ry8RImKlquUNZwz6AkRL0MqJr76mNg1ViT7JUj3xjR5JEIDBoHx0KQKj6OelS4
 FnpofOM3A26PPq4Zt99fjD5YpWVkalazA3CjJ6QvJR3CiOTorOKKX28schjJYPunTFkNoS
 GRAATgw5Wye16NW5g0cbPFPBJQNOd0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-Hj42jdj_OaSM61UhGHXF2g-1; Thu, 03 Sep 2020 16:53:15 -0400
X-MC-Unique: Hj42jdj_OaSM61UhGHXF2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB35A18BA282;
 Thu,  3 Sep 2020 20:53:14 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6AD81190;
 Thu,  3 Sep 2020 20:53:14 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/27] ap-device: Rename AP_DEVICE_TYPE to TYPE_AP_DEVICE
Date: Thu,  3 Sep 2020 16:52:35 -0400
Message-Id: <20200903205247.1667472-16-ehabkost@redhat.com>
In-Reply-To: <20200903205247.1667472-1-ehabkost@redhat.com>
References: <20200903205247.1667472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200902224311.1321159-6-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/s390x/ap-device.h | 4 ++--
 hw/s390x/ap-device.c         | 2 +-
 hw/vfio/ap.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
index fb250a20f3..e502745de5 100644
--- a/include/hw/s390x/ap-device.h
+++ b/include/hw/s390x/ap-device.h
@@ -14,7 +14,7 @@
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
-#define AP_DEVICE_TYPE       "ap-device"
+#define TYPE_AP_DEVICE       "ap-device"
 
 struct APDevice {
     DeviceState parent_obj;
@@ -22,6 +22,6 @@ struct APDevice {
 typedef struct APDevice APDevice;
 
 DECLARE_INSTANCE_CHECKER(APDevice, AP_DEVICE,
-                         AP_DEVICE_TYPE)
+                         TYPE_AP_DEVICE)
 
 #endif /* HW_S390X_AP_DEVICE_H */
diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
index fc0b41e937..237d1f19c5 100644
--- a/hw/s390x/ap-device.c
+++ b/hw/s390x/ap-device.c
@@ -21,7 +21,7 @@ static void ap_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ap_device_info = {
-    .name = AP_DEVICE_TYPE,
+    .name = TYPE_AP_DEVICE,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(APDevice),
     .class_size = sizeof(DeviceClass),
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index f399ec0a31..68ed059b39 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -177,7 +177,7 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo vfio_ap_info = {
     .name = VFIO_AP_DEVICE_TYPE,
-    .parent = AP_DEVICE_TYPE,
+    .parent = TYPE_AP_DEVICE,
     .instance_size = sizeof(VFIOAPDevice),
     .class_init = vfio_ap_class_init,
 };
-- 
2.26.2


