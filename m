Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC22C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04504222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEmLid5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04504222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtxq-0000vd-QO
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnh-0005q7-VC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtng-0006L2-Jp
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:17 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtng-0006Kn-Dd
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:16 -0500
Received: by mail-wm1-x342.google.com with SMTP id b17so2280425wmj.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WlKrofDa4j3N22AYaGt218mSvCaVNbM8UKHCQuejvbk=;
 b=oEmLid5CyqiWpYA7YnLFodz5JRkBBt6E2FSEOuJlUIwaQYzuyPjU9cTsfNoSLn1EJn
 A30ii760z3VHk3SfbQB28jR0uwdAbRitOboycqF7qrsc3V2djwwuld3dI52wREzCQH/1
 V6/YYEew5D28Q2+F7/ySFOp6Pk9S25d2050mhtexfxiJ+tktIXRF2s2TWi+D9INjRqvi
 OWK5n3fMqb8w+oUneo4w1QQA9tt7hTeHXHsvxisO/lVb7iohNy55F4dBSm8GFBITmAEr
 qCtHGOQwVouzEvdG0B5wPlrvFlgZmFULHRIN77Uo5F7X8RqGRFFOu/jtsZd2G2UWkYLq
 zl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=WlKrofDa4j3N22AYaGt218mSvCaVNbM8UKHCQuejvbk=;
 b=HwrfNtAMyXUlKR0hk8BvvGiMhLLZJk+zS5SYeUY3XesBY5dZRUvKnhVdgZku8u+gfI
 BLf+TUyuUK9LrFUbYE8RMCQl2W1kmH5LGy4k99SEPlPBcgHIvzuqrW4gvLisa84KW3lc
 co3heNB38v96OaeZp+4/0/pv/o4h0zoJeaGusyF2zFhlpVX8fZu6D4ByW5upyrwT49q8
 lMYQ4VGjcR6KsFGuHC3drb0ImgqCHuCNU8MNmZ1Z3uhDJw2Y1lOS6WKut2a9Hg20mdbP
 fq/nfAWdjaCLKyVf0Nj5CbSLQd+DPgfn1tUtU0RsMwbZ3dIMZnjZ/pYyn43rcvqxFloP
 WIYQ==
X-Gm-Message-State: APjAAAUnel/7itPhBqli/fiZYwgPyLFTlplV71DyN9hJJaEVCS4qtENr
 UEt8dPxC6mRzMMN6wNCeog3iVrtO
X-Google-Smtp-Source: APXvYqzrqEoZm9SIpdGzJInDCEHXo5WV9uklireTeOJNgI+dKw3xVZ3G/ENSYKMbjiMNUU+eXibRCw==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr2874305wmf.173.1573655955073; 
 Wed, 13 Nov 2019 06:39:15 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/16] qom: add object_new_with_class
Date: Wed, 13 Nov 2019 15:38:58 +0100
Message-Id: <1573655945-14912-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to CPU and machine classes, "-accel" class names are mangled,
so we have to first get a class via accel_find and then instantiate it.
Provide a new function to instantiate a class without going through
object_class_get_name, and use it for CPUs and machines already.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h      | 12 ++++++++++++
 qom/object.c              |  5 +++++
 target/i386/cpu.c         |  8 ++++----
 target/s390x/cpu_models.c |  4 ++--
 vl.c                      |  3 +--
 5 files changed, 24 insertions(+), 8 deletions(-)

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
index c7825dd..ee7708e 100644
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
index a624163..4742a0e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3881,7 +3881,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
         return;
     }
 
-    xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
+    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
 
     x86_cpu_expand_features(xc, &err);
     if (err) {
@@ -3952,7 +3952,7 @@ static GSList *get_sorted_cpu_model_list(void)
 
 static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
 {
-    Object *obj = object_new(object_class_get_name(OBJECT_CLASS(xc)));
+    Object *obj = object_new_with_class(OBJECT_CLASS(xc));
     char *r = object_property_get_str(obj, "model-id", &error_abort);
     object_unref(obj);
     return r;
@@ -4333,7 +4333,7 @@ static X86CPU *x86_cpu_from_model(const char *model, QDict *props, Error **errp)
         goto out;
     }
 
-    xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
+    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
     if (props) {
         object_apply_props(OBJECT(xc), props, &err);
         if (err) {
@@ -5177,7 +5177,7 @@ static void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
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
index cb993dd..6e406d4 100644
--- a/vl.c
+++ b/vl.c
@@ -3988,8 +3988,7 @@ int main(int argc, char **argv, char **envp)
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



