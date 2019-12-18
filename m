Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D54FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4426E21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQtHMx4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4426E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYMe-0000E8-T5
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2z-0006F4-Ts
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2x-0000M4-LT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2w-0000Ks-Oa
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id f129so1610322wmf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=O2k/K3Tg/TtNp6VLEfh3O4q9xXs1rgDoImCIOl/OQ3M=;
 b=GQtHMx4HVC6KY3ksnD5vi92QIUeninhKkamP7hk6g8Ow7mEof4HwdRMwCAIW8QSjYA
 nDCA3Vy/mCR0b+P09apHJT9W5CDZXfkEKFJmT67K3qTuVYjG/ZVpAheYgtHEvQEoj2cC
 QOCqyW1yMMiZUKf42W1H+aWzTLt4BuGEJH6RE1rFyZWTEQICfLMWniIghSFKBpGz2TKy
 OFbrmBSbTed0PO05vReMw4ExPqn+mk3wH75/v4QeFiuY2wPb2SqHJPxpL/QRpdnXo1HO
 Pz6lwcKYMl5cFdWGFNroAMtWsRMDuFXXNgM/KWEht72PVgyYnjXq2uRhuo5qR4Tk/zq+
 Kliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=O2k/K3Tg/TtNp6VLEfh3O4q9xXs1rgDoImCIOl/OQ3M=;
 b=KL5pZljBopznJsJXW+9HLn08jVUSLlo5MFdWYE9Z2kOz2dOg6pj+ElZuAcuIdehSTq
 vFFRKiFk8ASlwf3fivisOTcWFFjl5Z6Bazd7z1sMZXyh5Mk43YMAhnXC7eEKQGubFSV0
 4XUxrzWhaBEF5KXuk+RkfiU/U5voQspeRiXqDCZrQzWQeMet+Xk5LnCHCYb9RXKxK9Gy
 S2XaBpvYjLomSynZdEi0CL0neXxiofBN2rZXD0nbuglPtS2WMm/LI/WfTjAIEMLzfD8d
 J/DWLctWB97h1HI1273sAFmi4afnZLkoc8Kdx8QoV1spBPuZGOtZJXvP5yzmGeMIFa6T
 fK+g==
X-Gm-Message-State: APjAAAVSjvVBA6tUWF84KjqSiy8dHGIUDC1lFwofOXA68sloPVA2Oh6j
 HftBxZtkQZeMVhe3vV++GD5rYziW
X-Google-Smtp-Source: APXvYqzpOx3BS8qljdA/RoYWSMM7/Ek7x94MaexAS0yrGnT1J6UJZ3PFD75e3trpfzrPCS8SVCJa2w==
X-Received: by 2002:a1c:bbc3:: with SMTP id l186mr2865186wmf.101.1576670596528; 
 Wed, 18 Dec 2019 04:03:16 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/87] qom: introduce object_register_sugar_prop
Date: Wed, 18 Dec 2019 13:01:47 +0100
Message-Id: <1576670573-48048-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
index c350eef..b95c161 100644
--- a/vl.c
+++ b/vl.c
@@ -895,13 +895,9 @@ static void configure_rtc(QemuOpts *opts)
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



