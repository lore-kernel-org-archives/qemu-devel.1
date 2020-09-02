Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F86FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF4620767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yiz6l8o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF4620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbrp-0000WJ-W6
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVn-00065T-Th
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVl-0000Hd-PA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8Pk5jOk8CB1YWjYJvidnNSb3NDcbzxHzKV0QpjlF2A=;
 b=Yiz6l8o7z4iE7Ma8+O5wDDWJUA/1g2yjEZPpq5g4BPqEosB0VWymF97/bak9AyfVCp4yWL
 7m86H32BGQx7X6IKEIYUtkcw60hJr1GgNiTS40+bEOPas21KwACXg/xkzfj6potOTNZtCK
 2e9NlK5hFwKM2VKwq7DEs2+FlLMdTkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-yA__gHZPPmm4v4RazN5LUg-1; Wed, 02 Sep 2020 18:45:47 -0400
X-MC-Unique: yA__gHZPPmm4v4RazN5LUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B3858064BF
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:45:46 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 574BF7EEA7;
 Wed,  2 Sep 2020 22:45:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 61/63] tests: Rename TYPE_DUMMY to TYPE_DUMMY_OBJECT
Date: Wed,  2 Sep 2020 18:43:09 -0400
Message-Id: <20200902224311.1321159-62-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:06
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 tests/check-qom-proplist.c | 30 +++++++++++++++---------------
 tests/test-io-task.c       | 14 +++++++-------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 1571606c1c..b4b31c57d3 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -28,13 +28,13 @@
 #include "qom/object_interfaces.h"
 
 
-#define TYPE_DUMMY "qemu-dummy"
+#define TYPE_DUMMY_OBJECT "qemu-dummy"
 
 typedef struct DummyObject DummyObject;
 typedef struct DummyObjectClass DummyObjectClass;
 
 DECLARE_INSTANCE_CHECKER(DummyObject, DUMMY_OBJECT,
-                         TYPE_DUMMY)
+                         TYPE_DUMMY_OBJECT)
 
 typedef enum DummyAnimal DummyAnimal;
 
@@ -153,7 +153,7 @@ static void dummy_finalize(Object *obj)
 
 
 static const TypeInfo dummy_info = {
-    .name          = TYPE_DUMMY,
+    .name          = TYPE_DUMMY_OBJECT,
     .parent        = TYPE_OBJECT,
     .instance_size = sizeof(DummyObject),
     .instance_init = dummy_init,
@@ -337,7 +337,7 @@ static void test_dummy_createv(void)
     Error *err = NULL;
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
-        object_new_with_props(TYPE_DUMMY,
+        object_new_with_props(TYPE_DUMMY_OBJECT,
                               parent,
                               "dummy0",
                               &err,
@@ -366,7 +366,7 @@ static Object *new_helper(Error **errp,
     Object *obj;
 
     va_start(vargs, parent);
-    obj = object_new_with_propv(TYPE_DUMMY,
+    obj = object_new_with_propv(TYPE_DUMMY_OBJECT,
                                 parent,
                                 "dummy0",
                                 errp,
@@ -403,7 +403,7 @@ static void test_dummy_createcmdl(void)
     QemuOpts *opts;
     DummyObject *dobj;
     Error *err = NULL;
-    const char *params = TYPE_DUMMY \
+    const char *params = TYPE_DUMMY_OBJECT \
                          ",id=dev0," \
                          "bv=yes,sv=Hiss hiss hiss,av=platypus";
 
@@ -443,7 +443,7 @@ static void test_dummy_badenum(void)
     Error *err = NULL;
     Object *parent = object_get_objects_root();
     Object *dobj =
-        object_new_with_props(TYPE_DUMMY,
+        object_new_with_props(TYPE_DUMMY_OBJECT,
                               parent,
                               "dummy0",
                               &err,
@@ -470,7 +470,7 @@ static void test_dummy_getenum(void)
     int val;
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
-        object_new_with_props(TYPE_DUMMY,
+        object_new_with_props(TYPE_DUMMY_OBJECT,
                          parent,
                          "dummy0",
                          &err,
@@ -533,7 +533,7 @@ static void test_dummy_iterator(void)
         "bv"};                  /* instance property */
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
-        object_new_with_props(TYPE_DUMMY,
+        object_new_with_props(TYPE_DUMMY_OBJECT,
                               parent,
                               "dummy0",
                               &error_abort,
@@ -552,7 +552,7 @@ static void test_dummy_class_iterator(void)
 {
     const char *expected[] = { "type", "av", "sv" };
     ObjectPropertyIterator iter;
-    ObjectClass *klass = object_class_by_name(TYPE_DUMMY);
+    ObjectClass *klass = object_class_by_name(TYPE_DUMMY_OBJECT);
 
     object_class_property_iter_init(&iter, klass);
     test_dummy_prop_iterator(&iter, expected, ARRAY_SIZE(expected));
@@ -575,9 +575,9 @@ static void test_qom_partial_path(void)
 {
     Object *root  = object_get_objects_root();
     Object *cont1 = container_get(root, "/cont1");
-    Object *obj1  = object_new(TYPE_DUMMY);
-    Object *obj2a = object_new(TYPE_DUMMY);
-    Object *obj2b = object_new(TYPE_DUMMY);
+    Object *obj1  = object_new(TYPE_DUMMY_OBJECT);
+    Object *obj2a = object_new(TYPE_DUMMY_OBJECT);
+    Object *obj2b = object_new(TYPE_DUMMY_OBJECT);
     bool ambiguous;
 
     /* Objects created:
@@ -594,9 +594,9 @@ static void test_qom_partial_path(void)
     object_unref(obj2b);
 
     ambiguous = false;
-    g_assert(!object_resolve_path_type("", TYPE_DUMMY, &ambiguous));
+    g_assert(!object_resolve_path_type("", TYPE_DUMMY_OBJECT, &ambiguous));
     g_assert(ambiguous);
-    g_assert(!object_resolve_path_type("", TYPE_DUMMY, NULL));
+    g_assert(!object_resolve_path_type("", TYPE_DUMMY_OBJECT, NULL));
 
     ambiguous = false;
     g_assert(!object_resolve_path("obj2", &ambiguous));
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index 85e7a98da5..74b60f951a 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 
-#define TYPE_DUMMY "qemu:dummy"
+#define TYPE_DUMMY_OBJECT "qemu:dummy"
 
 typedef struct DummyObject DummyObject;
 typedef struct DummyObjectClass DummyObjectClass;
@@ -40,7 +40,7 @@ struct DummyObjectClass {
 
 static const TypeInfo dummy_info = {
     .parent = TYPE_OBJECT,
-    .name = TYPE_DUMMY,
+    .name = TYPE_DUMMY_OBJECT,
     .instance_size = sizeof(DummyObject),
     .class_size = sizeof(DummyObjectClass),
 };
@@ -65,7 +65,7 @@ static void task_callback(QIOTask *task,
 static void test_task_complete(void)
 {
     QIOTask *task;
-    Object *obj = object_new(TYPE_DUMMY);
+    Object *obj = object_new(TYPE_DUMMY_OBJECT);
     Object *src;
     struct TestTaskData data = { NULL, NULL, false };
 
@@ -95,7 +95,7 @@ static void task_data_free(gpointer opaque)
 static void test_task_data_free(void)
 {
     QIOTask *task;
-    Object *obj = object_new(TYPE_DUMMY);
+    Object *obj = object_new(TYPE_DUMMY_OBJECT);
     struct TestTaskData data = { NULL, NULL, false };
 
     task = qio_task_new(obj, task_callback, &data, task_data_free);
@@ -113,7 +113,7 @@ static void test_task_data_free(void)
 static void test_task_failure(void)
 {
     QIOTask *task;
-    Object *obj = object_new(TYPE_DUMMY);
+    Object *obj = object_new(TYPE_DUMMY_OBJECT);
     struct TestTaskData data = { NULL, NULL, false };
     Error *err = NULL;
 
@@ -174,7 +174,7 @@ static void test_task_thread_callback(QIOTask *task,
 static void test_task_thread_complete(void)
 {
     QIOTask *task;
-    Object *obj = object_new(TYPE_DUMMY);
+    Object *obj = object_new(TYPE_DUMMY_OBJECT);
     struct TestThreadWorkerData data = { 0 };
     GThread *self;
 
@@ -215,7 +215,7 @@ static void test_task_thread_complete(void)
 static void test_task_thread_failure(void)
 {
     QIOTask *task;
-    Object *obj = object_new(TYPE_DUMMY);
+    Object *obj = object_new(TYPE_DUMMY_OBJECT);
     struct TestThreadWorkerData data = { 0 };
     GThread *self;
 
-- 
2.26.2


