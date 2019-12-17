Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14D9C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E03F206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1FWdXjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E03F206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihH7u-0002MX-Ep
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihH6H-0000zY-Mk
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihH6E-000717-9Z
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:57:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihH6D-0006v1-CA
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:57:33 -0500
Received: by mail-wr1-x433.google.com with SMTP id d16so12314823wre.10
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 09:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=nKZchHpd70vIlJbL+VC1V92+mHhvR2A0AqZFydfzy38=;
 b=Z1FWdXjcUKpSV/XCRoLKMKPVlO6XqNVvo9TlYCsLamuPuPwkOYjUu/Eu16XuFzJUSL
 tNBObqIKw05qwTwu+RnsJz0S9jwgEd4648BIH0IgaDsNy3Vhg/Bvjq2iIErHrw+v9ZvR
 klAg6QGRApNWnw1ErvIGwUn6t+yQMJEXzL+UJpA0mRGhEJVEG5utW8a3jJeDuXkmflCq
 kCYTsVSCaD9bUFprQu2a6GM/Q49THZD0QVMP8dSIkMaRuNJhyytRxgdnOCA8k+MCEymM
 fLete6O26OdtRsBr57x5egsjy9MDv/k2EIR84G237ayqtE3Z7V//2zoS9DoI6TM9/P/D
 0TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=nKZchHpd70vIlJbL+VC1V92+mHhvR2A0AqZFydfzy38=;
 b=iQq/wSYzOOKVMUZH7rZSqEkryDr3Q9PsdABYQAEKZ8m35Bz4Hcvf/alhyg3sdATQYz
 MK9tJQ6f3LaEHJzejkxNyjz339IYfQ8+oxBZtfD0fQuiqMKgtLpDfUvRTPn/INg5+lzK
 h9pcYSwdHtlyESLnpBSXyGT15gFCPvFBs+TsxH+hxst09KJxA2CF4fGCK7DuKh4SWTIS
 mX6yh22mOMkOMvJhFQlPkQ7gK85mOhhF5cw9BglzwMvHXebUq1heo391INFMHvAaN3oB
 T9abAOnKmSdn7PU9KVOaOzkpGThvayA7rw0ohX9ANggkaVZ5siGIDHL0U5r2/y1IwSGR
 cU0g==
X-Gm-Message-State: APjAAAWntdglyabUQb8grqA/oaoz1emWYfnKyHV5Rd1oBzvVAXyNL5v6
 ntTyHy9qCAz4p+0CzS5llk8/6EKF
X-Google-Smtp-Source: APXvYqwlMICYUqCzvmfKQlOMF//GWH4SCu1sGuxxuiQDznmse13inBZ8/jJ+POzsimA9YFbOC6vwoQ==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr41021616wrv.9.1576605449982; 
 Tue, 17 Dec 2019 09:57:29 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q8sm3649573wmq.3.2019.12.17.09.57.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 09:57:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/62] qom: introduce object_register_sugar_prop
Date: Tue, 17 Dec 2019 18:57:25 +0100
Message-Id: <1576605445-28158-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
References: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

Similar to the existing "-rtc driftfix" option, we will convert some
legacy "-machine" command line options to global properties on accelerators.
Because accelerators are not devices, we cannot use qdev_prop_register_global.
Instead, provide a slot in the generic object_compat_props arrays for
command line syntactic sugar.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h |  1 +
 qom/object.c         | 23 +++++++++++++++++++++--
 vl.c                 | 10 +++-------
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 128d00c..230b18f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -679,6 +679,7 @@ void object_apply_global_props(Object *obj, const GPtrArray *props,
                                Error **errp);
 void object_set_machine_compat_props(GPtrArray *compat_props);
 void object_set_accelerator_compat_props(GPtrArray *compat_props);
+void object_register_sugar_prop(const char *driver, const char *prop, const char *value);
 void object_apply_compat_props(Object *obj);
 
 /**
diff --git a/qom/object.c b/qom/object.c
index d51b57f..e7b72f7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -414,10 +414,29 @@ void object_apply_global_props(Object *obj, const GPtrArray *props, Error **errp
  * Global property defaults
  * Slot 0: accelerator's global property defaults
  * Slot 1: machine's global property defaults
+ * Slot 2: global properties from legacy command line option
  * Each is a GPtrArray of of GlobalProperty.
  * Applied in order, later entries override earlier ones.
  */
-static GPtrArray *object_compat_props[2];
+static GPtrArray *object_compat_props[3];
+
+/*
+ * Retrieve @GPtrArray for global property defined with options
+ * other than "-global".  These are generally used for syntactic
+ * sugar and legacy command line options.
+ */
+void object_register_sugar_prop(const char *driver, const char *prop, const char *value)
+{
+    GlobalProperty *g;
+    if (!object_compat_props[2]) {
+        object_compat_props[2] = g_ptr_array_new();
+    }
+    g = g_new0(GlobalProperty, 1);
+    g->driver = g_strdup(driver);
+    g->property = g_strdup(prop);
+    g->value = g_strdup(value);
+    g_ptr_array_add(object_compat_props[2], g);
+}
 
 /*
  * Set machine's global property defaults to @compat_props.
@@ -445,7 +464,7 @@ void object_apply_compat_props(Object *obj)
 
     for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
         object_apply_global_props(obj, object_compat_props[i],
-                                  &error_abort);
+                                  i == 2 ? &error_fatal : &error_abort);
     }
 }
 
diff --git a/vl.c b/vl.c
index 46e4ec3..be3f51c 100644
--- a/vl.c
+++ b/vl.c
@@ -897,13 +897,9 @@ static void configure_rtc(QemuOpts *opts)
     value = qemu_opt_get(opts, "driftfix");
     if (value) {
         if (!strcmp(value, "slew")) {
-            static GlobalProperty slew_lost_ticks = {
-                .driver   = "mc146818rtc",
-                .property = "lost_tick_policy",
-                .value    = "slew",
-            };
-
-            qdev_prop_register_global(&slew_lost_ticks);
+            object_register_sugar_prop("mc146818rtc",
+                                       "lost_tick_policy",
+                                       "slew");
         } else if (!strcmp(value, "none")) {
             /* discard is default */
         } else {
-- 
1.8.3.1

