Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709E5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 22:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83C72087D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 22:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2UUCoO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83C72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFlpX-0001LN-OU
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 18:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFlYC-0005K2-BV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:53:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFlY9-0001Jh-FO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599601992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STycltGk/N79qHEc2F8EjCKOe0jyH7lhTX7lgq0Xm6w=;
 b=e2UUCoO1f6yB+JhIfgur+n+Zry9O5rdsUP+zC7bkCWwemdz1+3vV1OJQ+WVzjC1sDDKduL
 viDHtnCBg/cmR5d+QK3D/xg4r87+H2ibEi+J4060Hjx3E/d1sppUg0kMPjSpv3c7idz2hZ
 sSUrlRrooVLKXWhYnjhgFIvMM/AXREo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-ldEEpkwXNFq8IkuyINeNFg-1; Tue, 08 Sep 2020 17:53:08 -0400
X-MC-Unique: ldEEpkwXNFq8IkuyINeNFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F341091062;
 Tue,  8 Sep 2020 21:53:07 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FB435D9E8;
 Tue,  8 Sep 2020 21:53:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/34] vmgenid: Rename VMGENID_DEVICE to TYPE_VMGENID
Date: Tue,  8 Sep 2020 17:52:24 -0400
Message-Id: <20200908215239.3519638-20-ehabkost@redhat.com>
In-Reply-To: <20200908215239.3519638-1-ehabkost@redhat.com>
References: <20200908215239.3519638-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200902224311.1321159-11-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/acpi/vmgenid.h | 6 +++---
 hw/acpi/vmgenid.c         | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index 86cd1da605..aff574df5f 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -6,7 +6,7 @@
 #include "qemu/uuid.h"
 #include "qom/object.h"
 
-#define VMGENID_DEVICE           "vmgenid"
+#define TYPE_VMGENID           "vmgenid"
 #define VMGENID_GUID             "guid"
 #define VMGENID_GUID_FW_CFG_FILE      "etc/vmgenid_guid"
 #define VMGENID_ADDR_FW_CFG_FILE      "etc/vmgenid_addr"
@@ -18,7 +18,7 @@
 
 typedef struct VmGenIdState VmGenIdState;
 DECLARE_INSTANCE_CHECKER(VmGenIdState, VMGENID,
-                         VMGENID_DEVICE)
+                         TYPE_VMGENID)
 
 struct VmGenIdState {
     DeviceClass parent_obj;
@@ -29,7 +29,7 @@ struct VmGenIdState {
 /* returns NULL unless there is exactly one device */
 static inline Object *find_vmgenid_dev(void)
 {
-    return object_resolve_path_type("", VMGENID_DEVICE, NULL);
+    return object_resolve_path_type("", TYPE_VMGENID, NULL);
 }
 
 void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 2df7623d74..53db6af75d 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -198,7 +198,7 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
 
     if (!bios_linker_loader_can_write_pointer()) {
         error_setg(errp, "%s requires DMA write support in fw_cfg, "
-                   "which this machine type does not provide", VMGENID_DEVICE);
+                   "which this machine type does not provide", TYPE_VMGENID);
         return;
     }
 
@@ -206,7 +206,7 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
      * device. Check if there are several.
      */
     if (!find_vmgenid_dev()) {
-        error_setg(errp, "at most one %s device is permitted", VMGENID_DEVICE);
+        error_setg(errp, "at most one %s device is permitted", TYPE_VMGENID);
         return;
     }
 
@@ -232,7 +232,7 @@ static void vmgenid_device_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo vmgenid_device_info = {
-    .name          = VMGENID_DEVICE,
+    .name          = TYPE_VMGENID,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(VmGenIdState),
     .class_init    = vmgenid_device_class_init,
-- 
2.26.2


