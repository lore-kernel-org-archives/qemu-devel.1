Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AFEC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB0A206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgwc764+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB0A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtdi-0002Mj-Fg
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFA-000546-BM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF8-0007Ri-RW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:12 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtF8-0007Qh-KD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:10 -0500
Received: by mail-wr1-x42b.google.com with SMTP id t2so8067845wrr.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6TyA/+5V+DxLz28FUTU191tVzWRi5eFH4NrfOHyckas=;
 b=Qgwc764+1pvO3QBnWdhQRDqAatDJr+NOKvVtr7f+pAEA2VGoQl+5GMV/UTF4TEFURm
 ilYlMhxHR5cwgOQUbe6dNvHRL5wnQWw347O9dNWckY2fqtcQso/9L3/NrUc3h98hybV3
 jfMUme+R62jX06H0DDts93NZNrKXpmCmrLVHYxU6NgrvzY+jjyFZncSbuPhXjS8FbF8M
 dijdsXTfNCAWLklNN4LOa9NMCCn0Qp1D+zMvlDyW+KFhfBa19uaooRUet98RXdsHnVe9
 PDFUXFNP2XGzuVaD9K84rTj7lJD9lhUh+mNdoOovr0P9Fv5QrAG5Z796WmShm50uzk0l
 IisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6TyA/+5V+DxLz28FUTU191tVzWRi5eFH4NrfOHyckas=;
 b=saE0XPAgTqeL2GT2tNuIUsVqP0Lr4RrMXez7X22FwO3I4wOvmXZRapLJJjgIX7xcwz
 JK2GT2xcRtzkm0LF6Y8t2mpDGcFMK11cSTK22LpD/s5vsKW97yz7UrYKwyAUE1iZAir9
 NX6cc542JC+4aURLtqj8kKBd6Xx9WFbQFTWwnVvrGasUDHtuKR6vZd0kCFfn3Grffyad
 MU58hhLFHXFwDiedcTdGYIKfBU/QzUYRNh+nwXFxXvtwFlvnIASQ641t8nNjbE2TYuwt
 Mg85KnxBJA4ou84Nhxn2z8Rkt3BZCSHIjGcRZDn2edV7kkDjlJ2EWY4jOchVJ+vc3EWe
 C5Xg==
X-Gm-Message-State: APjAAAUHQ8nbc5u/ZQyyUziah6zLhiMx3h9wkVMMhlT82ZJQtPRPemc4
 cHIqm/Ar9QBNQzLmvHLbTejc8SW1
X-Google-Smtp-Source: APXvYqw8fyg9kA686vubJlX5DtvYN6AD/yEOisaHCiBOAkQTaHsFN8qbbkKc2P90wJJJGpCIlZQxiw==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr31528076wrt.381.1576513749432; 
 Mon, 16 Dec 2019 08:29:09 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/62] qom: add object_new_with_class
Date: Mon, 16 Dec 2019 17:28:06 +0100
Message-Id: <1576513726-53700-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

Similar to CPU and machine classes, "-accel" class names are mangled,
so we have to first get a class via accel_find and then instantiate it.
Provide a new function to instantiate a class without going through
object_class_get_name, and use it for CPUs and machines already.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c             |  4 +---
 include/qom/object.h      | 12 ++++++++++++
 qom/object.c              |  5 +++++
 target/i386/cpu.c         |  8 ++++----
 target/s390x/cpu_models.c |  4 ++--
 vl.c                      |  3 +--
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 60c3827..dd38a46 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -48,9 +48,7 @@ AccelClass *accel_find(const char *opt_name)
 
 int accel_init_machine(AccelClass *acc, MachineState *ms)
 {
-    ObjectClass *oc = OBJECT_CLASS(acc);
-    const char *cname = object_class_get_name(oc);
-    AccelState *accel = ACCEL(object_new(cname));
+    AccelState *accel = ACCEL(object_new_with_class(OBJECT_CLASS(acc)));
     int ret;
     ms->accelerator = accel;
     *(acc->allowed) = true;
diff --git a/include/qom/object.h b/include/qom/object.h
index 230b18f..f9ad692 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -593,6 +593,18 @@ struct InterfaceClass
                                              __FILE__, __LINE__, __func__))
 
 /**
+ * object_new_with_class:
+ * @klass: The class to instantiate.
+ *
+ * This function will initialize a new object using heap allocated memory.
+ * The returned object has a reference count of 1, and will be freed when
+ * the last reference is dropped.
+ *
+ * Returns: The newly allocated and instantiated object.
+ */
+Object *object_new_with_class(ObjectClass *klass);
+
+/**
  * object_new:
  * @typename: The name of the type of the object to instantiate.
  *
diff --git a/qom/object.c b/qom/object.c
index bfb4413..bc444d3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -658,6 +658,11 @@ static Object *object_new_with_type(Type type)
     return obj;
 }
 
+Object *object_new_with_class(ObjectClass *klass)
+{
+    return object_new_with_type(klass->type);
+}
+
 Object *object_new(const char *typename)
 {
     TypeImpl *ti = type_get_by_name(typename);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69f518a..a044078 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4640,7 +4640,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
         return;
     }
 
-    xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
+    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
 
     x86_cpu_expand_features(xc, &err);
     if (err) {
@@ -4711,7 +4711,7 @@ static GSList *get_sorted_cpu_model_list(void)
 
 static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
 {
-    Object *obj = object_new(object_class_get_name(OBJECT_CLASS(xc)));
+    Object *obj = object_new_with_class(OBJECT_CLASS(xc));
     char *r = object_property_get_str(obj, "model-id", &error_abort);
     object_unref(obj);
     return r;
@@ -5092,7 +5092,7 @@ static X86CPU *x86_cpu_from_model(const char *model, QDict *props, Error **errp)
         goto out;
     }
 
-    xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
+    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
     if (props) {
         object_apply_props(OBJECT(xc), props, &err);
         if (err) {
@@ -5936,7 +5936,7 @@ static void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
     APICCommonState *apic;
     ObjectClass *apic_class = OBJECT_CLASS(apic_get_class());
 
-    cpu->apic_state = DEVICE(object_new(object_class_get_name(apic_class)));
+    cpu->apic_state = DEVICE(object_new_with_class(apic_class));
 
     object_property_add_child(OBJECT(cpu), "lapic",
                               OBJECT(cpu->apic_state), &error_abort);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7e92fb2..72cf48b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -440,7 +440,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     if (cpu_list_data->model) {
         Object *obj;
         S390CPU *sc;
-        obj = object_new(object_class_get_name(klass));
+        obj = object_new_with_class(klass);
         sc = S390_CPU(obj);
         if (sc->model) {
             info->has_unavailable_features = true;
@@ -501,7 +501,7 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
         error_setg(errp, "The CPU definition '%s' requires KVM", info->name);
         return;
     }
-    obj = object_new(object_class_get_name(oc));
+    obj = object_new_with_class(oc);
     cpu = S390_CPU(obj);
 
     if (!cpu->model) {
diff --git a/vl.c b/vl.c
index be3f51c..dab6001 100644
--- a/vl.c
+++ b/vl.c
@@ -3966,8 +3966,7 @@ int main(int argc, char **argv, char **envp)
                       cleanup_add_fd, NULL, &error_fatal);
 #endif
 
-    current_machine = MACHINE(object_new(object_class_get_name(
-                          OBJECT_CLASS(machine_class))));
+    current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
     if (machine_help_func(qemu_get_machine_opts(), current_machine)) {
         exit(0);
     }
-- 
1.8.3.1



