Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00929C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0B7206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMvrIc+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0B7206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtS3-0004zt-T5
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF9-00051x-39
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF7-0007QQ-Tn
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:10 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtF7-0007P2-My
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:09 -0500
Received: by mail-wr1-x433.google.com with SMTP id d16so8036079wre.10
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=2Jpvl6A6XndxsapCWSE4YM+0B7PHr4ZqWFQfh1tgXgQ=;
 b=hMvrIc+0hz8mVr4QHU8g/SqwDmg0ziUUwgvNqmamNbUkF7Yq5qa91BBJJw88xe+cgr
 W5D5LPCqVK9UXSD8JPMm+lqPGY2kXi2JO8MeKIO8zl/7oQviF7UDmIH/1HKjxgk5rPMK
 MU8Mg7hjannvjRkJmM4Prbm+rShfyIpT54E7uV9p6so6bf/YcBYgdzKMkhL5SAZhL+e8
 d2C4ZtMB2d2DHsD9ko6CU01xB9b5+dEsex1vcZ9KZku1LkOgU+h5lfJOTAmdXKBB3LM0
 BMIuLsQFRWO1sDFyWIB5CbKjqql9qPH5gSzpJmxMAvXSd+/ta9PnoHHYkHomtlrsQ7ms
 ZAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=2Jpvl6A6XndxsapCWSE4YM+0B7PHr4ZqWFQfh1tgXgQ=;
 b=eu+FV5sN5rQim3w6BkmxZnafxEKHyv/1MdeBRZsyN7ZK1R6fm25rnu339jYVdJ8ygy
 e7lJEfKPIVlXnecnMx1OXt86ITYo8UGoZH7Qeu2ps+FXttpxZt+RqmbA078I8eonn2KI
 ekPR5ykk3fNj2/MGgi5oyex0Yd+ZR0qIcmwoJorzOmoW/3aRcc30g6cejXaRD52rF7Mo
 he1Gt0J0sv+LtYVxQTfijNBEIqa5lnRQeGVKxIc/38KMcSI/xnL7MDPNl9iB/tsVAa0P
 Nv+Bo8Xb1kXGrssGgZK4iYb/7MJVvRK6vIXab2Q3unZ4W3bznwFEFI7hsch/ltfOABXn
 KBIQ==
X-Gm-Message-State: APjAAAUZICsgupHwkAhQf6jwtWzvBxZnzvCDHmsnWOnImalcYkK3/beC
 VhupZxtrePTGt62LuGq9BK+6l9zE
X-Google-Smtp-Source: APXvYqzPp3WMsbru66CDyEB+NgGYinW8kf6kNmhZ0Cwlt6dMPNDK/X2X+MaVIdCZVxFheATZNWoLfA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr31430013wro.334.1576513748462; 
 Mon, 16 Dec 2019 08:29:08 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/62] qom: introduce object_register_sugar_prop
Date: Mon, 16 Dec 2019 17:28:05 +0100
Message-Id: <1576513726-53700-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
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
index d51b57f..bfb4413 100644
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
+    g = g_new(GlobalProperty, 1);
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



