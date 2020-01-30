Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8302C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66458206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCzMdviA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66458206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCcw-00049X-Jk
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTx-0005f4-I9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTu-0002yA-Io
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:53 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTu-0002xM-8P
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:50 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so4778638wrt.6
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cIeIrOBKlg+8QECQUwGsPP7Ki4UR570zZAiToVtjuT4=;
 b=OCzMdviAq0pcn+cnHKMiBDm2TiFUCB3dXbRbcPJrs8aCOdzsohIl6fHpM3az6eUbRI
 VG4itRFwRpKuQNrMQp3fTkihGnGGZKgbcDf1+CaVuVl5Rra3p64iS5tY+OAo2e+SPvRf
 vaph8yDuG03ZwqFcwUEPQtsyW3aulIZEeoBz7qf1cyQ8CDgn1M8at4qnzyrhAcGH+Sm1
 y1tblyWJsjao0vIT1jrwcRltcOTUa6/lHNwLMssXXVnYuNYbDJqaWAOEY6ii+cFlzxMX
 OS73/9gPUdUegRaWQaVYTwddzvkp77VltMH4CeN3tCM/ourNwqpCOZ4opeNK4vgpHzw/
 qyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cIeIrOBKlg+8QECQUwGsPP7Ki4UR570zZAiToVtjuT4=;
 b=tsmlyBGsLJRt3oEBfU6DcGXRp+TOnvdGKj53lKKneuHnWq6C/8MLbTkZgPoZwW+uDm
 vWO43Zuyt4yLbPychkCCpCRB6sXO/WAWIS7qxQFaPYiHz1XE2W+uolTr3TekQFp5MJ+S
 58CuARYaCqbftc9JPQQBN6qIUZUkXOvXdZaX1JyxotuyetQwk7SJSnMZ4DcpvbBeubFN
 rvxgfiMo4YRQ7DAe//Xd2ZKuNymAR4lisE+yKQ9xU5qwNtQ8pVWOcPXtQTE0U9KGKt+2
 JEp5YNUn1c2WyTKEXHZIn9T+6J/Vjmx8BWADSlE77dBJw51IYtQ+HGACAAScs71FykTg
 u71Q==
X-Gm-Message-State: APjAAAUa/USQ76/OGks3TghHJyswSuoVDtC5+erx8dnCR0ZMheVv2aEb
 P5Vx1vKf3Q0IZVE7oKEUVmpmO8SKAJfbpQ==
X-Google-Smtp-Source: APXvYqzN2tdr5ComBozXVAb58EOExQO/sGTjhHmLu+4V5aajojnjazcre8LoHXWEUfIVGWwmt83Weg==
X-Received: by 2002:adf:f484:: with SMTP id l4mr6758506wro.207.1580400948325; 
 Thu, 30 Jan 2020 08:15:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/26] hw/core: create Resettable QOM interface
Date: Thu, 30 Jan 2020 16:15:18 +0000
Message-Id: <20200130161533.8180-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

This commit defines an interface allowing multi-phase reset. This aims
to solve a problem of the actual single-phase reset (built in
DeviceClass and BusClass): reset behavior is dependent on the order
in which reset handlers are called. In particular doing external
side-effect (like setting an qemu_irq) is problematic because receiving
object may not be reset yet.

The Resettable interface divides the reset in 3 well defined phases.
To reset an object tree, all 1st phases are executed then all 2nd then
all 3rd. See the comments in include/hw/resettable.h for a more complete
description. The interface defines 3 phases to let the future
possibility of holding an object into reset for some time.

The qdev/qbus reset in DeviceClass and BusClass will be modified in
following commits to use this interface. A mechanism is provided
to allow executing a transitional reset handler in place of the 2nd
phase which is executed in children-then-parent order inside a tree.
This will allow to transition devices and buses smoothly while
keeping the exact current qdev/qbus reset behavior for now.

Documentation will be added in a following commit.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200123132823.1117486-4-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/Makefile.objs   |   1 +
 include/hw/resettable.h | 211 +++++++++++++++++++++++++++++++++++
 hw/core/resettable.c    | 238 ++++++++++++++++++++++++++++++++++++++++
 hw/core/trace-events    |  17 +++
 4 files changed, 467 insertions(+)
 create mode 100644 include/hw/resettable.h
 create mode 100644 hw/core/resettable.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a522b7297d3..9e41ec9a15d 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -2,6 +2,7 @@
 common-obj-y += qdev.o qdev-properties.o
 common-obj-y += bus.o
 common-obj-y += cpu.o
+common-obj-y += resettable.o
 common-obj-y += hotplug.o
 common-obj-y += vmstate-if.o
 # irq.o needed for qdev GPIO handling:
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
new file mode 100644
index 00000000000..c0b9fc6ad62
--- /dev/null
+++ b/include/hw/resettable.h
@@ -0,0 +1,211 @@
+/*
+ * Resettable interface header.
+ *
+ * Copyright (c) 2019 GreenSocs SAS
+ *
+ * Authors:
+ *   Damien Hedde
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_RESETTABLE_H
+#define HW_RESETTABLE_H
+
+#include "qom/object.h"
+
+#define TYPE_RESETTABLE_INTERFACE "resettable"
+
+#define RESETTABLE_CLASS(class) \
+    OBJECT_CLASS_CHECK(ResettableClass, (class), TYPE_RESETTABLE_INTERFACE)
+
+#define RESETTABLE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(ResettableClass, (obj), TYPE_RESETTABLE_INTERFACE)
+
+typedef struct ResettableState ResettableState;
+
+/**
+ * ResetType:
+ * Types of reset.
+ *
+ * + Cold: reset resulting from a power cycle of the object.
+ *
+ * TODO: Support has to be added to handle more types. In particular,
+ * ResettableState structure needs to be expanded.
+ */
+typedef enum ResetType {
+    RESET_TYPE_COLD,
+} ResetType;
+
+/*
+ * ResettableClass:
+ * Interface for resettable objects.
+ *
+ * See docs/devel/reset.rst for more detailed information about how QEMU models
+ * reset. This whole API must only be used when holding the iothread mutex.
+ *
+ * All objects which can be reset must implement this interface;
+ * it is usually provided by a base class such as DeviceClass or BusClass.
+ * Every Resettable object must maintain some state tracking the
+ * progress of a reset operation by providing a ResettableState structure.
+ * The functions defined in this module take care of updating the
+ * state of the reset.
+ * The base class implementation of the interface provides this
+ * state and implements the associated method: get_state.
+ *
+ * Concrete object implementations (typically specific devices
+ * such as a UART model) should provide the functions
+ * for the phases.enter, phases.hold and phases.exit methods, which
+ * they can set in their class init function, either directly or
+ * by calling resettable_class_set_parent_phases().
+ * The phase methods are guaranteed to only only ever be called once
+ * for any reset event, in the order 'enter', 'hold', 'exit'.
+ * An object will always move quickly from 'enter' to 'hold'
+ * but might remain in 'hold' for an arbitrary period of time
+ * before eventually reset is deasserted and the 'exit' phase is called.
+ * Object implementations should be prepared for functions handling
+ * inbound connections from other devices (such as qemu_irq handler
+ * functions) to be called at any point during reset after their
+ * 'enter' method has been called.
+ *
+ * Users of a resettable object should not call these methods
+ * directly, but instead use the function resettable_reset().
+ *
+ * @phases.enter: This phase is called when the object enters reset. It
+ * should reset local state of the object, but it must not do anything that
+ * has a side-effect on other objects, such as raising or lowering a qemu_irq
+ * line or reading or writing guest memory. It takes the reset's type as
+ * argument.
+ *
+ * @phases.hold: This phase is called for entry into reset, once every object
+ * in the system which is being reset has had its @phases.enter method called.
+ * At this point devices can do actions that affect other objects.
+ *
+ * @phases.exit: This phase is called when the object leaves the reset state.
+ * Actions affecting other objects are permitted.
+ *
+ * @get_state: Mandatory method which must return a pointer to a
+ * ResettableState.
+ *
+ * @get_transitional_function: transitional method to handle Resettable objects
+ * not yet fully moved to this interface. It will be removed as soon as it is
+ * not needed anymore. This method is optional and may return a pointer to a
+ * function to be used instead of the phases. If the method exists and returns
+ * a non-NULL function pointer then that function is executed as a replacement
+ * of the 'hold' phase method taking the object as argument. The two other phase
+ * methods are not executed.
+ *
+ * @child_foreach: Executes a given callback on every Resettable child. Child
+ * in this context means a child in the qbus tree, so the children of a qbus
+ * are the devices on it, and the children of a device are all the buses it
+ * owns. This is not the same as the QOM object hierarchy. The function takes
+ * additional opaque and ResetType arguments which must be passed unmodified to
+ * the callback.
+ */
+typedef void (*ResettableEnterPhase)(Object *obj, ResetType type);
+typedef void (*ResettableHoldPhase)(Object *obj);
+typedef void (*ResettableExitPhase)(Object *obj);
+typedef ResettableState * (*ResettableGetState)(Object *obj);
+typedef void (*ResettableTrFunction)(Object *obj);
+typedef ResettableTrFunction (*ResettableGetTrFunction)(Object *obj);
+typedef void (*ResettableChildCallback)(Object *, void *opaque,
+                                        ResetType type);
+typedef void (*ResettableChildForeach)(Object *obj,
+                                       ResettableChildCallback cb,
+                                       void *opaque, ResetType type);
+typedef struct ResettablePhases {
+    ResettableEnterPhase enter;
+    ResettableHoldPhase hold;
+    ResettableExitPhase exit;
+} ResettablePhases;
+typedef struct ResettableClass {
+    InterfaceClass parent_class;
+
+    /* Phase methods */
+    ResettablePhases phases;
+
+    /* State access method */
+    ResettableGetState get_state;
+
+    /* Transitional method for legacy reset compatibility */
+    ResettableGetTrFunction get_transitional_function;
+
+    /* Hierarchy handling method */
+    ResettableChildForeach child_foreach;
+} ResettableClass;
+
+/**
+ * ResettableState:
+ * Structure holding reset related state. The fields should not be accessed
+ * directly; the definition is here to allow further inclusion into other
+ * objects.
+ *
+ * @count: Number of reset level the object is into. It is incremented when
+ * the reset operation starts and decremented when it finishes.
+ * @hold_phase_pending: flag which indicates that we need to invoke the 'hold'
+ * phase handler for this object.
+ * @exit_phase_in_progress: true if we are currently in the exit phase
+ */
+struct ResettableState {
+    unsigned count;
+    bool hold_phase_pending;
+    bool exit_phase_in_progress;
+};
+
+/**
+ * resettable_reset:
+ * Trigger a reset on an object @obj of type @type. @obj must implement
+ * Resettable interface.
+ *
+ * Calling this function is equivalent to calling @resettable_assert_reset()
+ * then @resettable_release_reset().
+ */
+void resettable_reset(Object *obj, ResetType type);
+
+/**
+ * resettable_assert_reset:
+ * Put an object @obj into reset. @obj must implement Resettable interface.
+ *
+ * @resettable_release_reset() must eventually be called after this call.
+ * There must be one call to @resettable_release_reset() per call of
+ * @resettable_assert_reset(), with the same type argument.
+ *
+ * NOTE: Until support for migration is added, the @resettable_release_reset()
+ * must not be delayed. It must occur just after @resettable_assert_reset() so
+ * that migration cannot be triggered in between. Prefer using
+ * @resettable_reset() for now.
+ */
+void resettable_assert_reset(Object *obj, ResetType type);
+
+/**
+ * resettable_release_reset:
+ * Release the object @obj from reset. @obj must implement Resettable interface.
+ *
+ * See @resettable_assert_reset() description for details.
+ */
+void resettable_release_reset(Object *obj, ResetType type);
+
+/**
+ * resettable_is_in_reset:
+ * Return true if @obj is under reset.
+ *
+ * @obj must implement Resettable interface.
+ */
+bool resettable_is_in_reset(Object *obj);
+
+/**
+ * resettable_class_set_parent_phases:
+ *
+ * Save @rc current reset phases into @parent_phases and override @rc phases
+ * by the given new methods (@enter, @hold and @exit).
+ * Each phase is overridden only if the new one is not NULL allowing to
+ * override a subset of phases.
+ */
+void resettable_class_set_parent_phases(ResettableClass *rc,
+                                        ResettableEnterPhase enter,
+                                        ResettableHoldPhase hold,
+                                        ResettableExitPhase exit,
+                                        ResettablePhases *parent_phases);
+
+#endif
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
new file mode 100644
index 00000000000..91332084870
--- /dev/null
+++ b/hw/core/resettable.c
@@ -0,0 +1,238 @@
+/*
+ * Resettable interface.
+ *
+ * Copyright (c) 2019 GreenSocs SAS
+ *
+ * Authors:
+ *   Damien Hedde
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "hw/resettable.h"
+#include "trace.h"
+
+/**
+ * resettable_phase_enter/hold/exit:
+ * Function executing a phase recursively in a resettable object and its
+ * children.
+ */
+static void resettable_phase_enter(Object *obj, void *opaque, ResetType type);
+static void resettable_phase_hold(Object *obj, void *opaque, ResetType type);
+static void resettable_phase_exit(Object *obj, void *opaque, ResetType type);
+
+/**
+ * enter_phase_in_progress:
+ * True if we are currently in reset enter phase.
+ *
+ * Note: This flag is only used to guarantee (using asserts) that the reset
+ * API is used correctly. We can use a global variable because we rely on the
+ * iothread mutex to ensure only one reset operation is in a progress at a
+ * given time.
+ */
+static bool enter_phase_in_progress;
+
+void resettable_reset(Object *obj, ResetType type)
+{
+    trace_resettable_reset(obj, type);
+    resettable_assert_reset(obj, type);
+    resettable_release_reset(obj, type);
+}
+
+void resettable_assert_reset(Object *obj, ResetType type)
+{
+    /* TODO: change this assert when adding support for other reset types */
+    assert(type == RESET_TYPE_COLD);
+    trace_resettable_reset_assert_begin(obj, type);
+    assert(!enter_phase_in_progress);
+
+    enter_phase_in_progress = true;
+    resettable_phase_enter(obj, NULL, type);
+    enter_phase_in_progress = false;
+
+    resettable_phase_hold(obj, NULL, type);
+
+    trace_resettable_reset_assert_end(obj);
+}
+
+void resettable_release_reset(Object *obj, ResetType type)
+{
+    /* TODO: change this assert when adding support for other reset types */
+    assert(type == RESET_TYPE_COLD);
+    trace_resettable_reset_release_begin(obj, type);
+    assert(!enter_phase_in_progress);
+
+    resettable_phase_exit(obj, NULL, type);
+
+    trace_resettable_reset_release_end(obj);
+}
+
+bool resettable_is_in_reset(Object *obj)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+    ResettableState *s = rc->get_state(obj);
+
+    return s->count > 0;
+}
+
+/**
+ * resettable_child_foreach:
+ * helper to avoid checking the existence of the method.
+ */
+static void resettable_child_foreach(ResettableClass *rc, Object *obj,
+                                     ResettableChildCallback cb,
+                                     void *opaque, ResetType type)
+{
+    if (rc->child_foreach) {
+        rc->child_foreach(obj, cb, opaque, type);
+    }
+}
+
+/**
+ * resettable_get_tr_func:
+ * helper to fetch transitional reset callback if any.
+ */
+static ResettableTrFunction resettable_get_tr_func(ResettableClass *rc,
+                                                   Object *obj)
+{
+    ResettableTrFunction tr_func = NULL;
+    if (rc->get_transitional_function) {
+        tr_func = rc->get_transitional_function(obj);
+    }
+    return tr_func;
+}
+
+static void resettable_phase_enter(Object *obj, void *opaque, ResetType type)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+    ResettableState *s = rc->get_state(obj);
+    const char *obj_typename = object_get_typename(obj);
+    bool action_needed = false;
+
+    /* exit phase has to finish properly before entering back in reset */
+    assert(!s->exit_phase_in_progress);
+
+    trace_resettable_phase_enter_begin(obj, obj_typename, s->count, type);
+
+    /* Only take action if we really enter reset for the 1st time. */
+    /*
+     * TODO: if adding more ResetType support, some additional checks
+     * are probably needed here.
+     */
+    if (s->count++ == 0) {
+        action_needed = true;
+    }
+    /*
+     * We limit the count to an arbitrary "big" value. The value is big
+     * enough not to be triggered normally.
+     * The assert will stop an infinite loop if there is a cycle in the
+     * reset tree. The loop goes through resettable_foreach_child below
+     * which at some point will call us again.
+     */
+    assert(s->count <= 50);
+
+    /*
+     * handle the children even if action_needed is at false so that
+     * child counts are incremented too
+     */
+    resettable_child_foreach(rc, obj, resettable_phase_enter, NULL, type);
+
+    /* execute enter phase for the object if needed */
+    if (action_needed) {
+        trace_resettable_phase_enter_exec(obj, obj_typename, type,
+                                          !!rc->phases.enter);
+        if (rc->phases.enter && !resettable_get_tr_func(rc, obj)) {
+            rc->phases.enter(obj, type);
+        }
+        s->hold_phase_pending = true;
+    }
+    trace_resettable_phase_enter_end(obj, obj_typename, s->count);
+}
+
+static void resettable_phase_hold(Object *obj, void *opaque, ResetType type)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+    ResettableState *s = rc->get_state(obj);
+    const char *obj_typename = object_get_typename(obj);
+
+    /* exit phase has to finish properly before entering back in reset */
+    assert(!s->exit_phase_in_progress);
+
+    trace_resettable_phase_hold_begin(obj, obj_typename, s->count, type);
+
+    /* handle children first */
+    resettable_child_foreach(rc, obj, resettable_phase_hold, NULL, type);
+
+    /* exec hold phase */
+    if (s->hold_phase_pending) {
+        s->hold_phase_pending = false;
+        ResettableTrFunction tr_func = resettable_get_tr_func(rc, obj);
+        trace_resettable_phase_hold_exec(obj, obj_typename, !!rc->phases.hold);
+        if (tr_func) {
+            trace_resettable_transitional_function(obj, obj_typename);
+            tr_func(obj);
+        } else if (rc->phases.hold) {
+            rc->phases.hold(obj);
+        }
+    }
+    trace_resettable_phase_hold_end(obj, obj_typename, s->count);
+}
+
+static void resettable_phase_exit(Object *obj, void *opaque, ResetType type)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+    ResettableState *s = rc->get_state(obj);
+    const char *obj_typename = object_get_typename(obj);
+
+    assert(!s->exit_phase_in_progress);
+    trace_resettable_phase_exit_begin(obj, obj_typename, s->count, type);
+
+    /* exit_phase_in_progress ensures this phase is 'atomic' */
+    s->exit_phase_in_progress = true;
+    resettable_child_foreach(rc, obj, resettable_phase_exit, NULL, type);
+
+    assert(s->count > 0);
+    if (s->count == 1) {
+        trace_resettable_phase_exit_exec(obj, obj_typename, !!rc->phases.exit);
+        if (rc->phases.exit && !resettable_get_tr_func(rc, obj)) {
+            rc->phases.exit(obj);
+        }
+        s->count = 0;
+    }
+    s->exit_phase_in_progress = false;
+    trace_resettable_phase_exit_end(obj, obj_typename, s->count);
+}
+
+void resettable_class_set_parent_phases(ResettableClass *rc,
+                                        ResettableEnterPhase enter,
+                                        ResettableHoldPhase hold,
+                                        ResettableExitPhase exit,
+                                        ResettablePhases *parent_phases)
+{
+    *parent_phases = rc->phases;
+    if (enter) {
+        rc->phases.enter = enter;
+    }
+    if (hold) {
+        rc->phases.hold = hold;
+    }
+    if (exit) {
+        rc->phases.exit = exit;
+    }
+}
+
+static const TypeInfo resettable_interface_info = {
+    .name       = TYPE_RESETTABLE_INTERFACE,
+    .parent     = TYPE_INTERFACE,
+    .class_size = sizeof(ResettableClass),
+};
+
+static void reset_register_types(void)
+{
+    type_register_static(&resettable_interface_info);
+}
+
+type_init(reset_register_types)
diff --git a/hw/core/trace-events b/hw/core/trace-events
index a375aa88a48..77d61cb66e6 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -9,3 +9,20 @@ qbus_reset(void *obj, const char *objtype) "obj=%p(%s)"
 qbus_reset_all(void *obj, const char *objtype) "obj=%p(%s)"
 qbus_reset_tree(void *obj, const char *objtype) "obj=%p(%s)"
 qdev_update_parent_bus(void *obj, const char *objtype, void *oldp, const char *oldptype, void *newp, const char *newptype) "obj=%p(%s) old_parent=%p(%s) new_parent=%p(%s)"
+
+# resettable.c
+resettable_reset(void *obj, int cold) "obj=%p cold=%d"
+resettable_reset_assert_begin(void *obj, int cold) "obj=%p cold=%d"
+resettable_reset_assert_end(void *obj) "obj=%p"
+resettable_reset_release_begin(void *obj, int cold) "obj=%p cold=%d"
+resettable_reset_release_end(void *obj) "obj=%p"
+resettable_phase_enter_begin(void *obj, const char *objtype, unsigned count, int type) "obj=%p(%s) count=%d type=%d"
+resettable_phase_enter_exec(void *obj, const char *objtype, int type, int has_method) "obj=%p(%s) type=%d method=%d"
+resettable_phase_enter_end(void *obj, const char *objtype, unsigned count) "obj=%p(%s) count=%d"
+resettable_phase_hold_begin(void *obj, const char *objtype, unsigned count, int type) "obj=%p(%s) count=%d type=%d"
+resettable_phase_hold_exec(void *obj, const char *objtype, int has_method) "obj=%p(%s) method=%d"
+resettable_phase_hold_end(void *obj, const char *objtype, unsigned count) "obj=%p(%s) count=%d"
+resettable_phase_exit_begin(void *obj, const char *objtype, unsigned count, int type) "obj=%p(%s) count=%d type=%d"
+resettable_phase_exit_exec(void *obj, const char *objtype, int has_method) "obj=%p(%s) method=%d"
+resettable_phase_exit_end(void *obj, const char *objtype, unsigned count) "obj=%p(%s) count=%d"
+resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
-- 
2.20.1


