Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C38BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6A320936
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpmEWgCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6A320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIFIh-0007NF-Jg
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIF2V-0001aU-CO
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:46:48 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIF2P-0007Ev-VA
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:46:47 -0400
Received: by mail-pj1-x1044.google.com with SMTP id jw11so172716pjb.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CgkxfpFluTt5zP00GcUYEwa3CAXm7Xk+FBHChzy0F2A=;
 b=zpmEWgCirF8KjwwQDSKJfwZgkuT2iVXS1NlOvSRVb5Cx9hsFkzLmlLp2iJ0viknk8z
 vL19KqKveWhVkIzu78X5ZuF0Mt0a+oHW8KltVIw8UH0OE3BD+n5rG2n8IfiaSLfWRJiE
 LwvP7fjuTmsyMZcILNY9cfQ57pf/yIMovVtq4k5+7BOIkW0CX+ydSEXlYRB6MZ7PE7Ok
 eDXa+gTqE5yRCUgC1pPoK5u9l4VVO+6D1rqYdz7QMUKMGpZjr4aex5v2q+1ae83LsiNJ
 kV9Md5alKRKPcJXdZI2BXjXEtSGBM5giVGXj0QlYy7gCP9n2nrXjZMs0oj/0Mq67zBAo
 q44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CgkxfpFluTt5zP00GcUYEwa3CAXm7Xk+FBHChzy0F2A=;
 b=HyXxg6rcpJMMUY3CU8uWx35Gwg0HuOq/ZqHQJOLPY6MYsSrWcBxpOBw32u46DMz0sk
 a1ExFBKUTSQ37ot3OV9zIUV7SyESdcrv+qbiJrTBSp+J/u7aTCSbq2ASSIxvygJq1TKq
 PV+/dXQ7utQtEkppKAAr1VTr/GRYo/LfZE7RvHtCRnoL9QwVPVJEfkDpWW9n8PQfEowr
 A0IVtPk/hT+HPgA5gfNJQjc+mEYXhVNEcD4w6hTzBaf05WkuWKcCxDPc4W86LMLVl/If
 868lLTkjyKxS/t9WAVmuabblmaH3zMayASpSDYIm+bQsoyVzD5DSnYy1QbkqghejzbNg
 7LYA==
X-Gm-Message-State: AOAM5311mKxRwKBqE1XVcWH4S5ZkZjdzW85YxlXsNvc0u5uBGkuVfJZk
 OYGQfEbmK+OvJyy4Ep9iyc02OIGvw4Sh5g==
X-Google-Smtp-Source: ABdhPJyll2fcIIC5yI7+NxgqoA40WIZITpzxLKEIM79bPHRfk1jspxv1JfACnk5r/pEfQ2rq1Py4hw==
X-Received: by 2002:a17:902:6bc1:b029:d0:cbe1:e76e with SMTP id
 m1-20020a1709026bc1b02900d0cbe1e76emr20802506plt.21.1600191997994; 
 Tue, 15 Sep 2020 10:46:37 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cf7sm147896pjb.52.2020.09.15.10.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:46:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] qom: Allow objects to be allocated with increased
 alignment
Date: Tue, 15 Sep 2020 10:46:31 -0700
Message-Id: <20200915174635.2333553-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200915174635.2333553-1-richard.henderson@linaro.org>
References: <20200915174635.2333553-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
 include/qom/object.h |  4 ++++
 qom/object.c         | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 056f67ab3b..d52d0781a3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -770,6 +770,9 @@ struct Object
  * @instance_size: The size of the object (derivative of #Object).  If
  *   @instance_size is 0, then the size of the object will be the size of the
  *   parent object.
+ * @instance_align: The required alignment of the object.  If @instance_align
+ *   is 0, then normal malloc alignment is sufficient; if non-zero, then we
+ *   must use qemu_memalign for allocation.
  * @instance_init: This function is called to initialize an object.  The parent
  *   class will have already been initialized so the type is only responsible
  *   for initializing its own members.
@@ -807,6 +810,7 @@ struct TypeInfo
     const char *parent;
 
     size_t instance_size;
+    size_t instance_align;
     void (*instance_init)(Object *obj);
     void (*instance_post_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
diff --git a/qom/object.c b/qom/object.c
index 387efb25eb..2e53cb44a6 100644
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
@@ -691,13 +693,21 @@ static void object_finalize(void *data)
 static Object *object_new_with_type(Type type)
 {
     Object *obj;
+    size_t size, align;
 
     g_assert(type != NULL);
     type_initialize(type);
 
-    obj = g_malloc(type->instance_size);
-    object_initialize_with_type(obj, type->instance_size, type);
-    obj->free = g_free;
+    size = type->instance_size;
+    align = type->instance_align;
+    if (align) {
+        obj = qemu_memalign(align, size);
+    } else {
+        obj = g_malloc(size);
+    }
+
+    object_initialize_with_type(obj, size, type);
+    obj->free = (align ? qemu_vfree : g_free);
 
     return obj;
 }
-- 
2.25.1


