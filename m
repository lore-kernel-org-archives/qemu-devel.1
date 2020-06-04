Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B356FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEF7207DA
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C9MAia5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEF7207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjdI-00012b-KV
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaG-00052E-Ob
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:36 -0400
Received: from ozlabs.org ([203.11.71.1]:52741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaF-0000nT-Fo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx6C4mkgz9sTP; Thu,  4 Jun 2020 16:42:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591252947;
 bh=ldWYlnk7sDyLihq8ugblJL+B/6PQKCRla6JRAZXFnAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C9MAia5rXWdS+vQUbrF+cVIvQ5jbCdX0ibXr3lC13Zv0JgOhXRGWM58B4kfnNJLnz
 4WZUm5HPAUU354lIX9+hDTCQvMZ7zIvFzK2H39f5mJMjdOlhuSFF5an24r/2/RDqQe
 lOEc2cDK3zgk1d8grt5ophLFFugTShP76t5Isi0E=
From: David Gibson <david@gibson.dropbear.id.au>
To: rth@twiddle.net, pbonzini@redhat.com, ekabkost@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 3/9] target/i386: sev: Rename QSevGuestInfo
Date: Thu,  4 Jun 2020 16:42:13 +1000
Message-Id: <20200604064219.436242-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604064219.436242-1-david@gibson.dropbear.id.au>
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: brijesh.singh@amd.com, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, dgilbert@redhat.com,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment this is a purely passive object which is just a container for
information used elsewhere, hence the name.  I'm going to change that
though, so as a preliminary rename it to SevGuestState.

That name risks confusion with both SEVState and SevState, but I'll be
working on that in following patches.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


