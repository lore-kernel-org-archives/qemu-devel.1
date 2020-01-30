Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E336EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99AF206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lq/Wwa8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99AF206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCci-0003vq-TK
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTz-0005fi-Ip
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTw-0002zq-9m
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:55 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTw-0002zD-2Y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:52 -0500
Received: by mail-wr1-x42c.google.com with SMTP id a6so4728157wrx.12
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lt09TXjdWWSldnue6vzLMA5nWkuFv0K0sVt7j6VTK2g=;
 b=lq/Wwa8PQTiGlBWdKJ86IcAHXKH2UI3ET0KyypKmT3iExA5FE58a5apPTvbp7s3kF/
 bZXvBKpKdx7saumGBtmOwLWOgqaWvUi6WUCTdAvpw9BC0Bd6cJ7u0WrNbNCIaAYS8fZl
 Xnt5QmWIB+cEYC2PjfqTUt+2i4rPE2y0zwUhEl9P2SAbpHNZgml+gQ3ooikoBUDP5iiB
 gqBqWvFBz4SRZp1wfcNWLw8lK5OcuTWgUUzZLBUzMkh+6bCRcCHo9A4IcXjOv/UgirII
 V08qhhhRaLg+d9D1ZcdU7SV0qrB771JYRUqHlJyQ58A7t753SMkBSFyxhGCfVqivGNvo
 sZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lt09TXjdWWSldnue6vzLMA5nWkuFv0K0sVt7j6VTK2g=;
 b=P19j5cXqm7S+O24sVVm1RgtXnj29N96pu5IrcD6wDC0u7k2aIfiBCyIqKWHFCdxN94
 1GDa6bTKEGx+/+cR6HYylc6lOI393Keqad5dwcYQk/OYshUCfAF82pJ9FNklRk0ZC7BN
 Zl81y2PWblDxts8qtn0aWHpmACE3YTA4yi/KRYVLlcc5zYJWFtP6JVJAxtGq7G7O2myD
 jTXt3CEy1JJeGxju4mMJ2OSQtWd8ekHPOLkpNSpPbnIevMOJBimjGrJiyZsr8+xtZJ5q
 iStqM3NxiJaT6ur1xDJ6FQzLGo2fCAYjoS/3AqNaTuluXggNnYE4mA0OveeF35Z3e4ev
 w6yQ==
X-Gm-Message-State: APjAAAV/9gNVGOBj3a9f9O567VhB0inYriZv2Dg9+bbXsZxDGlRSwlZh
 dKFAkdwWmtbyqG2hxgLcB12H7GHa0Dlmfg==
X-Google-Smtp-Source: APXvYqwg5kbXwMR0uDG009TUkg3urwxTOX11ezOG7/OitzP4dMVUmdi3I1ydwwBTjekTZ7b2t6PiOQ==
X-Received: by 2002:a05:6000:1201:: with SMTP id
 e1mr511292wrx.386.1580400950665; 
 Thu, 30 Jan 2020 08:15:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/26] hw/core/resettable: add support for changing parent
Date: Thu, 30 Jan 2020 16:15:20 +0000
Message-Id: <20200130161533.8180-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

From: Damien Hedde <damien.hedde@greensocs.com>

Add a function resettable_change_parent() to do the required
plumbing when changing the parent a of Resettable object.

We need to make sure that the reset state of the object remains
coherent with the reset state of the new parent.

We make the 2 following hypothesis:
+ when an object is put in a parent under reset, the object goes in
reset.
+ when an object is removed from a parent under reset, the object
leaves reset.

The added function avoids any glitch if both old and new parent are
already in reset.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200123132823.1117486-6-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/resettable.h | 16 +++++++++++
 hw/core/resettable.c    | 62 +++++++++++++++++++++++++++++++++++++++--
 hw/core/trace-events    |  1 +
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index c0b9fc6ad62..96073354fd6 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -194,6 +194,22 @@ void resettable_release_reset(Object *obj, ResetType type);
  */
 bool resettable_is_in_reset(Object *obj);
 
+/**
+ * resettable_change_parent:
+ * Indicate that the parent of Ressettable @obj is changing from @oldp to @newp.
+ * All 3 objects must implement resettable interface. @oldp or @newp may be
+ * NULL.
+ *
+ * This function will adapt the reset state of @obj so that it is coherent
+ * with the reset state of @newp. It may trigger @resettable_assert_reset()
+ * or @resettable_release_reset(). It will do such things only if the reset
+ * state of @newp and @oldp are different.
+ *
+ * When using this function during reset, it must only be called during
+ * a hold phase method. Calling this during enter or exit phase is an error.
+ */
+void resettable_change_parent(Object *obj, Object *newp, Object *oldp);
+
 /**
  * resettable_class_set_parent_phases:
  *
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index 91332084870..6e0b0f492f1 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -28,12 +28,16 @@ static void resettable_phase_exit(Object *obj, void *opaque, ResetType type);
  * enter_phase_in_progress:
  * True if we are currently in reset enter phase.
  *
- * Note: This flag is only used to guarantee (using asserts) that the reset
- * API is used correctly. We can use a global variable because we rely on the
+ * exit_phase_in_progress:
+ * count the number of exit phase we are in.
+ *
+ * Note: These flags are only used to guarantee (using asserts) that the reset
+ * API is used correctly. We can use global variables because we rely on the
  * iothread mutex to ensure only one reset operation is in a progress at a
  * given time.
  */
 static bool enter_phase_in_progress;
+static unsigned exit_phase_in_progress;
 
 void resettable_reset(Object *obj, ResetType type)
 {
@@ -65,7 +69,9 @@ void resettable_release_reset(Object *obj, ResetType type)
     trace_resettable_reset_release_begin(obj, type);
     assert(!enter_phase_in_progress);
 
+    exit_phase_in_progress += 1;
     resettable_phase_exit(obj, NULL, type);
+    exit_phase_in_progress -= 1;
 
     trace_resettable_reset_release_end(obj);
 }
@@ -206,6 +212,58 @@ static void resettable_phase_exit(Object *obj, void *opaque, ResetType type)
     trace_resettable_phase_exit_end(obj, obj_typename, s->count);
 }
 
+/*
+ * resettable_get_count:
+ * Get the count of the Resettable object @obj. Return 0 if @obj is NULL.
+ */
+static unsigned resettable_get_count(Object *obj)
+{
+    if (obj) {
+        ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+        return rc->get_state(obj)->count;
+    }
+    return 0;
+}
+
+void resettable_change_parent(Object *obj, Object *newp, Object *oldp)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+    ResettableState *s = rc->get_state(obj);
+    unsigned newp_count = resettable_get_count(newp);
+    unsigned oldp_count = resettable_get_count(oldp);
+
+    /*
+     * Ensure we do not change parent when in enter or exit phase.
+     * During these phases, the reset subtree being updated is partly in reset
+     * and partly not in reset (it depends on the actual position in
+     * resettable_child_foreach()s). We are not able to tell in which part is a
+     * leaving or arriving device. Thus we cannot set the reset count of the
+     * moving device to the proper value.
+     */
+    assert(!enter_phase_in_progress && !exit_phase_in_progress);
+    trace_resettable_change_parent(obj, oldp, oldp_count, newp, newp_count);
+
+    /*
+     * At most one of the two 'for' loops will be executed below
+     * in order to cope with the difference between the two counts.
+     */
+    /* if newp is more reset than oldp */
+    for (unsigned i = oldp_count; i < newp_count; i++) {
+        resettable_assert_reset(obj, RESET_TYPE_COLD);
+    }
+    /*
+     * if obj is leaving a bus under reset, we need to ensure
+     * hold phase is not pending.
+     */
+    if (oldp_count && s->hold_phase_pending) {
+        resettable_phase_hold(obj, NULL, RESET_TYPE_COLD);
+    }
+    /* if oldp is more reset than newp */
+    for (unsigned i = newp_count; i < oldp_count; i++) {
+        resettable_release_reset(obj, RESET_TYPE_COLD);
+    }
+}
+
 void resettable_class_set_parent_phases(ResettableClass *rc,
                                         ResettableEnterPhase enter,
                                         ResettableHoldPhase hold,
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 77d61cb66e6..aecd8e160eb 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -16,6 +16,7 @@ resettable_reset_assert_begin(void *obj, int cold) "obj=%p cold=%d"
 resettable_reset_assert_end(void *obj) "obj=%p"
 resettable_reset_release_begin(void *obj, int cold) "obj=%p cold=%d"
 resettable_reset_release_end(void *obj) "obj=%p"
+resettable_change_parent(void *obj, void *o, unsigned oc, void *n, unsigned nc) "obj=%p from=%p(%d) to=%p(%d)"
 resettable_phase_enter_begin(void *obj, const char *objtype, unsigned count, int type) "obj=%p(%s) count=%d type=%d"
 resettable_phase_enter_exec(void *obj, const char *objtype, int type, int has_method) "obj=%p(%s) type=%d method=%d"
 resettable_phase_enter_end(void *obj, const char *objtype, unsigned count) "obj=%p(%s) count=%d"
-- 
2.20.1


