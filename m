Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B672EC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EDC20738
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrAEDLWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EDC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kILeq-0002so-GS
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 20:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILax-0006HD-UQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:47 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILau-0001Vd-LQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:47 -0400
Received: by mail-pf1-x444.google.com with SMTP id z18so413214pfg.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 17:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+jDBZOfLiTrHQFNxHg77u5bGYtXjoCt88pLLuScea1s=;
 b=mrAEDLWaG0r6y4SrB4wKFW0RpKtBFvptgTnZrV0obPYX1D8UPQRcAHZlThDotJQL+v
 EPvaUkAX8MXvkmhcFUWiRkbTKgrm64Pyp0wMRe+EXytC4o+2fvpzhFpNRaUFIKfPrGQE
 7Scz5okPjMt94y2zl/Ar3MUlrDVHLkmEoXzcwlVcDPO7HtUS6EqhVHu+5jK3QD7VvpQR
 546j6RabTgu6ZbuErwgyFnSLqCNP1e0Cak22uZgcrNJel3tVv8AdJx3TxyjgP08FvEh+
 v1H4vr4T02c4uKSlKBqSMCnHd5nuJMXg+mZCKpvP8PcMptP7c1NGASw0TtkJ/XKW/tB2
 2R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+jDBZOfLiTrHQFNxHg77u5bGYtXjoCt88pLLuScea1s=;
 b=CMg+e5s7kC5Mpxq1cbpG6nLFdQKBsBoxbkqfBme4/m/Zt2obu8JiXcVLipX6B9WcVN
 Zl2GO5gU/IqgLEWly17uaKa9p1G+mZ+JsMltky3SxHahh1vBU7/b/Z6NoqBIGas8Lwly
 NxDaRcx6k4NHHksTl9eXvsFTGfB3rS5f8kML9HvbhSM1AA3QN+ros7OBDP+n1Vew7aCq
 nfuky+PQzjXNuIFC9+9+e/WGtHVuz+KN4xM6FqNU13cSUcu0x1LFCKz+vsAuGM+Vmv1e
 1lVICeEsXnHeWhDvtosTnpx3zoIUm4o2zr0kpVB9X7DHfB8YgZoLWu5EPtd3tc5m6UUB
 xs0g==
X-Gm-Message-State: AOAM530anw78D81Fw3rDBAzQCbO5q2/hqGmf391Gvl7HnDNPlQ14NFuD
 hUGBdFls+QdcdWH+5YHJ6PiVHi9pkFCEfA==
X-Google-Smtp-Source: ABdhPJwBKhgsIWz+hInQGSaNJP6ku4tXxczmI2H3qaPlpHhMk2WYbEtGPZ6VCpw9S28/s4tSTxi67Q==
X-Received: by 2002:a63:c9:: with SMTP id 192mr16920983pga.37.1600217202984;
 Tue, 15 Sep 2020 17:46:42 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id kf10sm611723pjb.2.2020.09.15.17.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 17:46:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] qom: Allow objects to be allocated with increased
 alignment
Date: Tue, 15 Sep 2020 17:46:34 -0700
Message-Id: <20200916004638.2444147-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916004638.2444147-1-richard.henderson@linaro.org>
References: <20200916004638.2444147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It turns out that some hosts have a default malloc alignment less
than that required for vectors.

We assume that, with compiler annotation on CPUArchState, that we
can properly align the vector portion of the guest state.  Fix the
alignment of the allocation by using qemu_memalloc when required.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h |  5 +++++
 qom/object.c         | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 056f67ab3b..5709c36859 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -691,6 +691,7 @@ struct Object
         .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
         .name = TYPE_##MODULE_OBJ_NAME, \
         .instance_size = sizeof(ModuleObjName), \
+        .instance_align = __alignof__(ModuleObjName), \
         .instance_init = module_obj_name##_init, \
         .instance_finalize = module_obj_name##_finalize, \
         .class_size = sizeof(ModuleObjName##Class), \
@@ -770,6 +771,9 @@ struct Object
  * @instance_size: The size of the object (derivative of #Object).  If
  *   @instance_size is 0, then the size of the object will be the size of the
  *   parent object.
+ * @instance_align: The required alignment of the object.  If @instance_align
+ *   is 0, then normal malloc alignment is sufficient; if non-zero, then we
+ *   must use qemu_memalign for allocation.
  * @instance_init: This function is called to initialize an object.  The parent
  *   class will have already been initialized so the type is only responsible
  *   for initializing its own members.
@@ -807,6 +811,7 @@ struct TypeInfo
     const char *parent;
 
     size_t instance_size;
+    size_t instance_align;
     void (*instance_init)(Object *obj);
     void (*instance_post_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
diff --git a/qom/object.c b/qom/object.c
index 387efb25eb..fcc15f6d88 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -50,6 +50,7 @@ struct TypeImpl
     size_t class_size;
 
     size_t instance_size;
+    size_t instance_align;
 
     void (*class_init)(ObjectClass *klass, void *data);
     void (*class_base_init)(ObjectClass *klass, void *data);
@@ -114,6 +115,7 @@ static TypeImpl *type_new(const TypeInfo *info)
 
     ti->class_size = info->class_size;
     ti->instance_size = info->instance_size;
+    ti->instance_align = info->instance_align;
 
     ti->class_init = info->class_init;
     ti->class_base_init = info->class_base_init;
@@ -688,16 +690,44 @@ static void object_finalize(void *data)
     }
 }
 
+/* Find the minimum alignment guaranteed by the system malloc. */
+#if __STDC_VERSION__ >= 201112L
+typddef max_align_t qemu_max_align_t;
+#else
+typedef union {
+    long l;
+    void *p;
+    double d;
+    long double ld;
+} qemu_max_align_t;
+#endif
+
 static Object *object_new_with_type(Type type)
 {
     Object *obj;
+    size_t size, align;
+    void (*obj_free)(void *);
 
     g_assert(type != NULL);
     type_initialize(type);
 
-    obj = g_malloc(type->instance_size);
-    object_initialize_with_type(obj, type->instance_size, type);
-    obj->free = g_free;
+    size = type->instance_size;
+    align = type->instance_align;
+
+    /*
+     * Do not use qemu_memalign unless required.  Depending on the
+     * implementation, extra alignment implies extra overhead.
+     */
+    if (likely(align <= __alignof__(qemu_max_align_t))) {
+        obj = g_malloc(size);
+        obj_free = g_free;
+    } else {
+        obj = qemu_memalign(align, size);
+        obj_free = qemu_vfree;
+    }
+
+    object_initialize_with_type(obj, size, type);
+    obj->free = obj_free;
 
     return obj;
 }
-- 
2.25.1


