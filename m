Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FC5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3916206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFZ85W0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3916206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTTh-0005Pb-V1
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT99-00086w-RO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT91-00019i-Pt
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oa8JasYJVEKYYlm2jMKtBXTwkbJOCM9mWA3N9ZVAqs=;
 b=XFZ85W0U3A2R37kJSqau6iTbIbtnCAA9YlzuKtyKVFLg0WgP3u7+kfOCV4gSOUowDF11SC
 bAVycRnqdMF+Gb35AiiZtUTjrndNpUKN1y2ia4ChRoCJfyiVDSO4wRy4RePeysaCDNCvQ4
 DiuTDg/XmhdAmZcpDeTJ4Glhr3uqn8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-ahBkQjBcPNSjTb0R9ucxRQ-1; Thu, 11 Jun 2020 15:45:04 -0400
X-MC-Unique: ahBkQjBcPNSjTb0R9ucxRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0433A0C00;
 Thu, 11 Jun 2020 19:45:03 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3322860CC0;
 Thu, 11 Jun 2020 19:45:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 014/115] qom/object: Move Object typedef to 'qemu/typedefs.h'
Date: Thu, 11 Jun 2020 15:43:08 -0400
Message-Id: <20200611194449.31468-15-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We use the Object type all over the place.
Forward declare it in "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200504115656.6045-2-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/block/vhost-user-blk.c | 1 -
 hw/pci-host/pam.c         | 1 -
 hw/scsi/vhost-user-scsi.c | 1 -
 include/hw/display/edid.h | 3 ---
 include/qemu/typedefs.h   | 1 +
 include/qom/object.h      | 2 --
 include/qom/qom-qobject.h | 2 --
 include/sysemu/sysemu.h   | 1 -
 stubs/qmp_memory_device.c | 1 -
 9 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9d8c0b3909..98941019a2 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -20,7 +20,6 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
-#include "qom/object.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost.h"
diff --git a/hw/pci-host/pam.c b/hw/pci-host/pam.c
index 45c4333cd3..a496205783 100644
--- a/hw/pci-host/pam.c
+++ b/hw/pci-host/pam.c
@@ -28,7 +28,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qom/object.h"
 #include "hw/pci-host/pam.h"
 
 void init_pam(DeviceState *dev, MemoryRegion *ram_memory,
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index cbb5d97599..f2e524438a 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qom/object.h"
 #include "hw/fw-path-provider.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index 23371ee82c..5b1de57f24 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -1,9 +1,6 @@
 #ifndef EDID_H
 #define EDID_H
 
-#include "qom/object.h"
-#include "hw/qdev-properties.h"
-
 typedef struct qemu_edid_info {
     const char *vendor; /* http://www.uefi.org/pnp_id_list */
     const char *name;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index ecf3cde26c..de68d51d52 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -76,6 +76,7 @@ typedef struct NetFilterState NetFilterState;
 typedef struct NICInfo NICInfo;
 typedef struct NodeInfo NodeInfo;
 typedef struct NumaNodeMem NumaNodeMem;
+typedef struct Object Object;
 typedef struct ObjectClass ObjectClass;
 typedef struct PCIBridge PCIBridge;
 typedef struct PCIBus PCIBus;
diff --git a/include/qom/object.h b/include/qom/object.h
index fd453dc8d6..c7c97ead60 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -20,8 +20,6 @@
 struct TypeImpl;
 typedef struct TypeImpl *Type;
 
-typedef struct Object Object;
-
 typedef struct TypeInfo TypeInfo;
 
 typedef struct InterfaceClass InterfaceClass;
diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
index 77cd717e3f..82136e6e80 100644
--- a/include/qom/qom-qobject.h
+++ b/include/qom/qom-qobject.h
@@ -13,8 +13,6 @@
 #ifndef QEMU_QOM_QOBJECT_H
 #define QEMU_QOM_QOBJECT_H
 
-#include "qom/object.h"
-
 /*
  * object_property_get_qobject:
  * @obj: the object
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 3efccdba7e..4b6a5c459c 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -5,7 +5,6 @@
 #include "qemu/timer.h"
 #include "qemu/notify.h"
 #include "qemu/uuid.h"
-#include "qom/object.h"
 
 /* vl.c */
 
diff --git a/stubs/qmp_memory_device.c b/stubs/qmp_memory_device.c
index 85ff8f2d7e..e75cac62dc 100644
--- a/stubs/qmp_memory_device.c
+++ b/stubs/qmp_memory_device.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qom/object.h"
 #include "hw/mem/memory-device.h"
 
 MemoryDeviceInfoList *qmp_memory_device_list(void)
-- 
2.26.2



