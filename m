Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EABC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04136214F1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8VhfoUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04136214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGBy-00020a-5J
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1O-0003ea-Ug
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1J-0006c3-8h
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DdZBB4EDlaaZxGBRJRdKw7c/rep5ZMVUi4EkmGtpg8=;
 b=Q8VhfoUxyOpxC9Qv4utlhIfbnCcwd4gWzghAE/aOdAenqant5Ff78Bzmh/oEJIvY8OM7P+
 vbDwD9aWDs/hyIzqwitA8QQ6l4ZiSsncR0n1/ZLt6nXQk5x0Mh0xWyfFteU0XIJcuLqe2Z
 dKnSs4oYGWFUR3cTpANU2FUhnGIviZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-dNdBBI3pM_Ooqh_Z0FKdKA-1; Thu, 29 Oct 2020 18:03:41 -0400
X-MC-Unique: dNdBBI3pM_Ooqh_Z0FKdKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A25118BA280
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:03:40 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40E2B60C17;
 Thu, 29 Oct 2020 22:03:40 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/36] qdev: Rename qdev_propinfo_* to object_propinfo_*
Date: Thu, 29 Oct 2020 18:02:34 -0400
Message-Id: <20201029220246.472693-25-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions will be moved to be part of QOM, so rename them.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-prop-internal.h     | 28 +++++++++----------
 hw/core/qdev-properties-system.c | 48 ++++++++++++++++----------------
 hw/core/qdev-properties.c        | 48 ++++++++++++++++----------------
 3 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index c8006a21c7..41ec9e8942 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -8,22 +8,22 @@
 #ifndef HW_CORE_QDEV_PROP_INTERNAL_H
 #define HW_CORE_QDEV_PROP_INTERNAL_H
 
-void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp);
-void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp);
+void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp);
+void object_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp);
 
-void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
-                                          const Property *prop);
-void qdev_propinfo_set_default_value_int(ObjectProperty *op,
-                                         const Property *prop);
-void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
-                                          const Property *prop);
+void object_propinfo_set_default_value_enum(ObjectProperty *op,
+                                            const Property *prop);
+void object_propinfo_set_default_value_int(ObjectProperty *op,
+                                           const Property *prop);
+void object_propinfo_set_default_value_uint(ObjectProperty *op,
+                                            const Property *prop);
 
-void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
-                             void *opaque, Error **errp);
-void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp);
+void object_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp);
+void object_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp);
 
 /**
  * object_property_add_static: Add a static property to an object instance
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 60a45f5620..d9355053d2 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -535,9 +535,9 @@ QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) != sizeof(int));
 const PropertyInfo qdev_prop_losttickpolicy = {
     .name  = "LostTickPolicy",
     .enum_table  = &LostTickPolicy_lookup,
-    .get   = qdev_propinfo_get_enum,
-    .set   = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .get   = object_propinfo_get_enum,
+    .set   = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
 
 /* --- blocksize --- */
@@ -566,9 +566,9 @@ const PropertyInfo qdev_prop_blocksize = {
     .name  = "size",
     .description = "A power of two between " MIN_BLOCK_SIZE_STR
                    " and " MAX_BLOCK_SIZE_STR,
-    .get   = qdev_propinfo_get_size32,
+    .get   = object_propinfo_get_size32,
     .set   = set_blocksize,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
+    .set_default_value = object_propinfo_set_default_value_uint,
 };
 
 /* --- Block device error handling policy --- */
@@ -580,9 +580,9 @@ const PropertyInfo qdev_prop_blockdev_on_error = {
     .description = "Error handling policy, "
                    "report/ignore/enospc/stop/auto",
     .enum_table = &BlockdevOnError_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .get = object_propinfo_get_enum,
+    .set = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
 
 /* --- BIOS CHS translation */
@@ -594,9 +594,9 @@ const PropertyInfo qdev_prop_bios_chs_trans = {
     .description = "Logical CHS translation algorithm, "
                    "auto/none/lba/large/rechs",
     .enum_table = &BiosAtaTranslation_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .get = object_propinfo_get_enum,
+    .set = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
 
 /* --- FDC default drive types */
@@ -606,9 +606,9 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
     .description = "FDC drive type, "
                    "144/288/120/none/auto",
     .enum_table = &FloppyDriveType_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .get = object_propinfo_get_enum,
+    .set = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
 
 /* --- MultiFDCompression --- */
@@ -618,9 +618,9 @@ const PropertyInfo qdev_prop_multifd_compression = {
     .description = "multifd_compression values, "
                    "none/zlib/zstd",
     .enum_table = &MultiFDCompression_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .get = object_propinfo_get_enum,
+    .set = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
 
 /* --- Reserved Region --- */
@@ -764,9 +764,9 @@ const PropertyInfo qdev_prop_pci_devfn = {
     .name  = "int32",
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
-    .get   = qdev_propinfo_get_int32,
+    .get   = object_propinfo_get_int32,
     .set   = set_pci_devfn,
-    .set_default_value = qdev_propinfo_set_default_value_int,
+    .set_default_value = object_propinfo_set_default_value_int,
 };
 
 /* --- pci host address --- */
@@ -879,9 +879,9 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
     .name = "OffAutoPCIBAR",
     .description = "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
     .enum_table = &OffAutoPCIBAR_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .get = object_propinfo_get_enum,
+    .set = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
 
 /* --- PCIELinkSpeed 2_5/5/8/16 -- */
@@ -951,7 +951,7 @@ const PropertyInfo qdev_prop_pcie_link_speed = {
     .enum_table = &PCIELinkSpeed_lookup,
     .get = get_prop_pcielinkspeed,
     .set = set_prop_pcielinkspeed,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
 
 /* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
@@ -1039,5 +1039,5 @@ const PropertyInfo qdev_prop_pcie_link_width = {
     .enum_table = &PCIELinkWidth_lookup,
     .get = get_prop_pcielinkwidth,
     .set = set_prop_pcielinkwidth,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5189626c09..e4aba2b237 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -93,7 +93,7 @@ static ObjectPropertyAccessor *static_prop_setter(const PropertyInfo *info)
     return info->set ? static_prop_set : NULL;
 }
 
-void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
+void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     Property *prop = opaque;
@@ -102,7 +102,7 @@ void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
 
-void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
+void object_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     Property *prop = opaque;
@@ -111,7 +111,7 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
 
-void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
+void object_propinfo_set_default_value_enum(ObjectProperty *op,
                                           const Property *prop)
 {
     object_property_set_default_str(op,
@@ -120,9 +120,9 @@ void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
 
 const PropertyInfo qdev_prop_enum = {
     .name  = "enum",
-    .get   = qdev_propinfo_get_enum,
-    .set   = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .get   = object_propinfo_get_enum,
+    .set   = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
 
 /* Bit */
@@ -275,13 +275,13 @@ static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_uint8(v, name, ptr, errp);
 }
 
-void qdev_propinfo_set_default_value_int(ObjectProperty *op,
+void object_propinfo_set_default_value_int(ObjectProperty *op,
                                          const Property *prop)
 {
     object_property_set_default_int(op, prop->defval.i);
 }
 
-void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
+void object_propinfo_set_default_value_uint(ObjectProperty *op,
                                           const Property *prop)
 {
     object_property_set_default_uint(op, prop->defval.u);
@@ -291,7 +291,7 @@ const PropertyInfo qdev_prop_uint8 = {
     .name  = "uint8",
     .get   = get_uint8,
     .set   = set_uint8,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
+    .set_default_value = object_propinfo_set_default_value_uint,
 };
 
 /* --- 16bit integer --- */
@@ -318,7 +318,7 @@ const PropertyInfo qdev_prop_uint16 = {
     .name  = "uint16",
     .get   = get_uint16,
     .set   = set_uint16,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
+    .set_default_value = object_propinfo_set_default_value_uint,
 };
 
 /* --- 32bit integer --- */
@@ -341,7 +341,7 @@ static void set_uint32(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, ptr, errp);
 }
 
-void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
+void object_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     Property *prop = opaque;
@@ -363,14 +363,14 @@ const PropertyInfo qdev_prop_uint32 = {
     .name  = "uint32",
     .get   = get_uint32,
     .set   = set_uint32,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
+    .set_default_value = object_propinfo_set_default_value_uint,
 };
 
 const PropertyInfo qdev_prop_int32 = {
     .name  = "int32",
-    .get   = qdev_propinfo_get_int32,
+    .get   = object_propinfo_get_int32,
     .set   = set_int32,
-    .set_default_value = qdev_propinfo_set_default_value_int,
+    .set_default_value = object_propinfo_set_default_value_int,
 };
 
 /* --- 64bit integer --- */
@@ -415,14 +415,14 @@ const PropertyInfo qdev_prop_uint64 = {
     .name  = "uint64",
     .get   = get_uint64,
     .set   = set_uint64,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
+    .set_default_value = object_propinfo_set_default_value_uint,
 };
 
 const PropertyInfo qdev_prop_int64 = {
     .name  = "int64",
     .get   = get_int64,
     .set   = set_int64,
-    .set_default_value = qdev_propinfo_set_default_value_int,
+    .set_default_value = object_propinfo_set_default_value_int,
 };
 
 /* --- string --- */
@@ -474,14 +474,14 @@ const PropertyInfo qdev_prop_on_off_auto = {
     .name = "OnOffAuto",
     .description = "on/off/auto",
     .enum_table = &OnOffAuto_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .get = object_propinfo_get_enum,
+    .set = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
 };
 
 /* --- 32bit unsigned int 'size' type --- */
 
-void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
+void object_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
     Property *prop = opaque;
@@ -515,9 +515,9 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_size32 = {
     .name  = "size",
-    .get = qdev_propinfo_get_size32,
+    .get = object_propinfo_get_size32,
     .set = set_size32,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
+    .set_default_value = object_propinfo_set_default_value_uint,
 };
 
 /* --- UUID --- */
@@ -686,7 +686,7 @@ const PropertyInfo qdev_prop_arraylen = {
     .name = "uint32",
     .get = get_uint32,
     .set = set_prop_arraylen,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
+    .set_default_value = object_propinfo_set_default_value_uint,
 };
 
 /* --- public helpers --- */
@@ -885,7 +885,7 @@ const PropertyInfo qdev_prop_size = {
     .name  = "size",
     .get = get_size,
     .set = set_size,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
+    .set_default_value = object_propinfo_set_default_value_uint,
 };
 
 /* --- object link property --- */
-- 
2.28.0


