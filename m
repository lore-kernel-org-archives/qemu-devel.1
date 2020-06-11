Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FABC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD25E20720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Copq0zFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD25E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUPX-0003JH-Uk
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAS-0001zY-9f
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28089
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAO-0001Qc-Tu
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rH/ZRONMPh9IjqYbOFigbB9B9pKvj83UfzobVXF1za8=;
 b=Copq0zFuR+nDNvjuMKHMEHaq5JwcAZYPKipR4KsVBFlNrz+boRsiXrogKEvdja01Tj5aG5
 +rotoUjTzcJPSKz/kXTiPLKhn6atI6Ta4RVNkQhpNRNUPg5mNpa+yIX88B96bZ6Md8KnYC
 0Ev3sFaeidukB99xbCQLsprWVkN9bng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-svuejcEfP52MH-OHaU3Phg-1; Thu, 11 Jun 2020 15:47:10 -0400
X-MC-Unique: svuejcEfP52MH-OHaU3Phg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 039B79116F;
 Thu, 11 Jun 2020 19:47:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56EFA60CC0;
 Thu, 11 Jun 2020 19:47:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 102/115] target/i386: sev: Rename QSevGuestInfo
Date: Thu, 11 Jun 2020 15:44:36 -0400
Message-Id: <20200611194449.31468-103-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Gibson <david@gibson.dropbear.id.au>

At the moment this is a purely passive object which is just a container for
information used elsewhere, hence the name.  I'm going to change that
though, so as a preliminary rename it to SevGuestState.

That name risks confusion with both SEVState and SevState, but I'll be
working on that in following patches.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200604064219.436242-4-david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 87 ++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 53def5f41a..b6ed719fb5 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -29,22 +29,23 @@
 #include "trace.h"
 #include "migration/blocker.h"
 
-#define TYPE_QSEV_GUEST_INFO "sev-guest"
-#define QSEV_GUEST_INFO(obj)                  \
-    OBJECT_CHECK(QSevGuestInfo, (obj), TYPE_QSEV_GUEST_INFO)
+#define TYPE_SEV_GUEST "sev-guest"
+#define SEV_GUEST(obj)                                          \
+    OBJECT_CHECK(SevGuestState, (obj), TYPE_SEV_GUEST)
 
-typedef struct QSevGuestInfo QSevGuestInfo;
+typedef struct SevGuestState SevGuestState;
 
 /**
- * QSevGuestInfo:
+ * SevGuestState:
  *
- * The QSevGuestInfo object is used for creating a SEV guest.
+ * The SevGuestState object is used for creating and managing a SEV
+ * guest.
  *
  * # $QEMU \
  *         -object sev-guest,id=sev0 \
  *         -machine ...,memory-encryption=sev0
  */
-struct QSevGuestInfo {
+struct SevGuestState {
     Object parent_obj;
 
     char *sev_device;
@@ -57,7 +58,7 @@ struct QSevGuestInfo {
 };
 
 struct SEVState {
-    QSevGuestInfo *sev_info;
+    SevGuestState *sev_info;
     uint8_t api_major;
     uint8_t api_minor;
     uint8_t build_id;
@@ -235,82 +236,82 @@ static struct RAMBlockNotifier sev_ram_notifier = {
 };
 
 static void
-qsev_guest_finalize(Object *obj)
+sev_guest_finalize(Object *obj)
 {
 }
 
 static char *
-qsev_guest_get_session_file(Object *obj, Error **errp)
+sev_guest_get_session_file(Object *obj, Error **errp)
 {
-    QSevGuestInfo *s = QSEV_GUEST_INFO(obj);
+    SevGuestState *s = SEV_GUEST(obj);
 
     return s->session_file ? g_strdup(s->session_file) : NULL;
 }
 
 static void
-qsev_guest_set_session_file(Object *obj, const char *value, Error **errp)
+sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
 {
-    QSevGuestInfo *s = QSEV_GUEST_INFO(obj);
+    SevGuestState *s = SEV_GUEST(obj);
 
     s->session_file = g_strdup(value);
 }
 
 static char *
-qsev_guest_get_dh_cert_file(Object *obj, Error **errp)
+sev_guest_get_dh_cert_file(Object *obj, Error **errp)
 {
-    QSevGuestInfo *s = QSEV_GUEST_INFO(obj);
+    SevGuestState *s = SEV_GUEST(obj);
 
     return g_strdup(s->dh_cert_file);
 }
 
 static void
-qsev_guest_set_dh_cert_file(Object *obj, const char *value, Error **errp)
+sev_guest_set_dh_cert_file(Object *obj, const char *value, Error **errp)
 {
-    QSevGuestInfo *s = QSEV_GUEST_INFO(obj);
+    SevGuestState *s = SEV_GUEST(obj);
 
     s->dh_cert_file = g_strdup(value);
 }
 
 static char *
-qsev_guest_get_sev_device(Object *obj, Error **errp)
+sev_guest_get_sev_device(Object *obj, Error **errp)
 {
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+    SevGuestState *sev = SEV_GUEST(obj);
 
     return g_strdup(sev->sev_device);
 }
 
 static void
-qsev_guest_set_sev_device(Object *obj, const char *value, Error **errp)
+sev_guest_set_sev_device(Object *obj, const char *value, Error **errp)
 {
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+    SevGuestState *sev = SEV_GUEST(obj);
 
     sev->sev_device = g_strdup(value);
 }
 
 static void
-qsev_guest_class_init(ObjectClass *oc, void *data)
+sev_guest_class_init(ObjectClass *oc, void *data)
 {
     object_class_property_add_str(oc, "sev-device",
-                                  qsev_guest_get_sev_device,
-                                  qsev_guest_set_sev_device);
+                                  sev_guest_get_sev_device,
+                                  sev_guest_set_sev_device);
     object_class_property_set_description(oc, "sev-device",
             "SEV device to use");
     object_class_property_add_str(oc, "dh-cert-file",
-                                  qsev_guest_get_dh_cert_file,
-                                  qsev_guest_set_dh_cert_file);
+                                  sev_guest_get_dh_cert_file,
+                                  sev_guest_set_dh_cert_file);
     object_class_property_set_description(oc, "dh-cert-file",
             "guest owners DH certificate (encoded with base64)");
     object_class_property_add_str(oc, "session-file",
-                                  qsev_guest_get_session_file,
-                                  qsev_guest_set_session_file);
+                                  sev_guest_get_session_file,
+                                  sev_guest_set_session_file);
     object_class_property_set_description(oc, "session-file",
             "guest owners session parameters (encoded with base64)");
 }
 
 static void
-qsev_guest_init(Object *obj)
+sev_guest_instance_init(Object *obj)
 {
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+    SevGuestState *sev = SEV_GUEST(obj);
 
     sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
     sev->policy = DEFAULT_GUEST_POLICY;
@@ -326,32 +327,32 @@ qsev_guest_init(Object *obj)
 }
 
 /* sev guest info */
-static const TypeInfo qsev_guest_info = {
+static const TypeInfo sev_guest_info = {
     .parent = TYPE_OBJECT,
-    .name = TYPE_QSEV_GUEST_INFO,
-    .instance_size = sizeof(QSevGuestInfo),
-    .instance_finalize = qsev_guest_finalize,
-    .class_init = qsev_guest_class_init,
-    .instance_init = qsev_guest_init,
+    .name = TYPE_SEV_GUEST,
+    .instance_size = sizeof(SevGuestState),
+    .instance_finalize = sev_guest_finalize,
+    .class_init = sev_guest_class_init,
+    .instance_init = sev_guest_instance_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
 };
 
-static QSevGuestInfo *
+static SevGuestState *
 lookup_sev_guest_info(const char *id)
 {
     Object *obj;
-    QSevGuestInfo *info;
+    SevGuestState *info;
 
     obj = object_resolve_path_component(object_get_objects_root(), id);
     if (!obj) {
         return NULL;
     }
 
-    info = (QSevGuestInfo *)
-            object_dynamic_cast(obj, TYPE_QSEV_GUEST_INFO);
+    info = (SevGuestState *)
+            object_dynamic_cast(obj, TYPE_SEV_GUEST);
     if (!info) {
         return NULL;
     }
@@ -510,7 +511,7 @@ sev_launch_start(SEVState *s)
     gsize sz;
     int ret = 1;
     int fw_error, rc;
-    QSevGuestInfo *sev = s->sev_info;
+    SevGuestState *sev = s->sev_info;
     struct kvm_sev_launch_start *start;
     guchar *session = NULL, *dh_cert = NULL;
 
@@ -696,7 +697,7 @@ sev_guest_init(const char *id)
     s->sev_info = lookup_sev_guest_info(id);
     if (!s->sev_info) {
         error_report("%s: '%s' is not a valid '%s' object",
-                     __func__, id, TYPE_QSEV_GUEST_INFO);
+                     __func__, id, TYPE_SEV_GUEST);
         goto err;
     }
 
@@ -786,7 +787,7 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
 static void
 sev_register_types(void)
 {
-    type_register_static(&qsev_guest_info);
+    type_register_static(&sev_guest_info);
 }
 
 type_init(sev_register_types);
-- 
2.26.2



