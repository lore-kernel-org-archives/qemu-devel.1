Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61176C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B882082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmTW6cUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B882082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCZz-0006sn-30
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU5-0005jO-Qe
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU3-00035r-Mn
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:01 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCU3-00034c-FV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:59 -0500
Received: by mail-wr1-x432.google.com with SMTP id z7so4713408wrl.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YmJRQbKvPa3ku6efec1x7l3XUepaPhrTD7WZsHIwnAk=;
 b=YmTW6cUl5v5XbZWLCbj6Scy4AtJOxmyNBO9M3yc3mj8LWoY+jgVls/MDSzrgfb4DsI
 lfmhXVmoW5jX6urOQ5KEbtYd/GO/2/cAWQncDlOVUZdQUTNCC20QZc7Hkc3+oERnxglX
 nkzsAcMAcMaA6RCYr5zE4Kona7ThUvkDOHK76Ed+OVKjlUYl5R91FXDrXBM2SEJ3hW1n
 ELzpa1S7SKZJq8IKKfW/5LP5kPYTZCITh1U5Gx+zJuJ8VBNwQLrCWbJcMCbMrpxyyP5u
 5iA+scBTB1HHV3ynxOrRI8kAgYhHJhX8HYO3NiKJPLzIF1D9b7CGOat/4oLt1BZQEm3K
 OEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YmJRQbKvPa3ku6efec1x7l3XUepaPhrTD7WZsHIwnAk=;
 b=Fr7PUFmuKIsIK15527RChIn2u2uxqkF8nQap8gu68K/VTCjKWgk2jjJ1HIwyl7KQLG
 c7b1nl6AKgDCWhGU4RbqYZ1Y19S1rCGPrwlm9QZyK/tjjA8iKFWUhoz1v9qyzhDzFwtj
 gJV67aYHwpUrxn4ZXa5Z9i4t7vwykLIWUPoxAnohslnab9NV3CjtPH29hXmeMVSjCw99
 3uHEimy+PzdQ4JIZruhWrRzq2M0q9rszmJNI1gU/TOI+LCQjpcLaUfBm4hYW2BMGYQ58
 rptk0477qWs9z2MHobbiMh1JI7HQy3DpgJGYoCWxow+7tufv80AD8hYIPnHNlcuHOlO/
 RhRQ==
X-Gm-Message-State: APjAAAXBqbq7nYOjTW397ZysRslZ7IFiuDa0jnGowhxu0ERDYQoBcbKo
 JBV23Iygh4DJ0wgxI43ZV3OjPcPZBcMvFA==
X-Google-Smtp-Source: APXvYqxPsHZcJ6QXC8YuVngrtxLUXYkKnzXSYyqnPIH8O7xPh0IbLcgAQJtUf8unjilaiFOPI/WB2A==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr6354724wru.411.1580400957461; 
 Thu, 30 Jan 2020 08:15:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/26] docs/devel/reset.rst: add doc about Resettable interface
Date: Thu, 30 Jan 2020 16:15:24 +0000
Message-Id: <20200130161533.8180-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200123132823.1117486-10-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/index.rst |   1 +
 docs/devel/reset.rst | 289 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 290 insertions(+)
 create mode 100644 docs/devel/reset.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index ac862152dcb..4dc2ca8d715 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -24,3 +24,4 @@ Contents:
    tcg
    tcg-plugins
    bitops
+   reset
diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
new file mode 100644
index 00000000000..abea1102dc4
--- /dev/null
+++ b/docs/devel/reset.rst
@@ -0,0 +1,289 @@
+
+=======================================
+Reset in QEMU: the Resettable interface
+=======================================
+
+The reset of qemu objects is handled using the resettable interface declared
+in ``include/hw/resettable.h``.
+
+This interface allows objects to be grouped (on a tree basis); so that the
+whole group can be reset consistently. Each individual member object does not
+have to care about others; in particular, problems of order (which object is
+reset first) are addressed.
+
+As of now DeviceClass and BusClass implement this interface.
+
+
+Triggering reset
+----------------
+
+This section documents the APIs which "users" of a resettable object should use
+to control it. All resettable control functions must be called while holding
+the iothread lock.
+
+You can apply a reset to an object using ``resettable_assert_reset()``. You need
+to call ``resettable_release_reset()`` to release the object from reset. To
+instantly reset an object, without keeping it in reset state, just call
+``resettable_reset()``. These functions take two parameters: a pointer to the
+object to reset and a reset type.
+
+Several types of reset will be supported. For now only cold reset is defined;
+others may be added later. The Resettable interface handles reset types with an
+enum:
+
+``RESET_TYPE_COLD``
+  Cold reset is supported by every resettable object. In QEMU, it means we reset
+  to the initial state corresponding to the start of QEMU; this might differ
+  from what is a real hardware cold reset. It differs from other resets (like
+  warm or bus resets) which may keep certain parts untouched.
+
+Calling ``resettable_reset()`` is equivalent to calling
+``resettable_assert_reset()`` then ``resettable_release_reset()``. It is
+possible to interleave multiple calls to these three functions. There may
+be several reset sources/controllers of a given object. The interface handles
+everything and the different reset controllers do not need to know anything
+about each others. The object will leave reset state only when each other
+controllers end their reset operation. This point is handled internally by
+maintaining a count of in-progress resets; it is crucial to call
+``resettable_release_reset()`` one time and only one time per
+``resettable_assert_reset()`` call.
+
+For now migration of a device or bus in reset is not supported. Care must be
+taken not to delay ``resettable_release_reset()`` after its
+``resettable_assert_reset()`` counterpart.
+
+Note that, since resettable is an interface, the API takes a simple Object as
+parameter. Still, it is a programming error to call a resettable function on a
+non-resettable object and it will trigger a run time assert error. Since most
+calls to resettable interface are done through base class functions, such an
+error is not likely to happen.
+
+For Devices and Buses, the following helper functions exist:
+
+- ``device_cold_reset()``
+- ``bus_cold_reset()``
+
+These are simple wrappers around resettable_reset() function; they only cast the
+Device or Bus into an Object and pass the cold reset type. When possible
+prefer to use these functions instead of ``resettable_reset()``.
+
+Device and bus functions co-exist because there can be semantic differences
+between resetting a bus and resetting the controller bridge which owns it.
+For example, consider a SCSI controller. Resetting the controller puts all
+its registers back to what reset state was as well as reset everything on the
+SCSI bus, whereas resetting just the SCSI bus only resets everything that's on
+it but not the controller.
+
+
+Multi-phase mechanism
+---------------------
+
+This section documents the internals of the resettable interface.
+
+The resettable interface uses a multi-phase system to relieve objects and
+machines from reset ordering problems. To address this, the reset operation
+of an object is split into three well defined phases.
+
+When resetting several objects (for example the whole machine at simulation
+startup), all first phases of all objects are executed, then all second phases
+and then all third phases.
+
+The three phases are:
+
+1. The **enter** phase is executed when the object enters reset. It resets only
+   local state of the object; it must not do anything that has a side-effect
+   on other objects, such as raising or lowering a qemu_irq line or reading or
+   writing guest memory.
+
+2. The **hold** phase is executed for entry into reset, once every object in the
+   group which is being reset has had its *enter* phase executed. At this point
+   devices can do actions that affect other objects.
+
+3. The **exit** phase is executed when the object leaves the reset state.
+   Actions affecting other objects are permitted.
+
+As said in previous section, the interface maintains a count of reset. This
+count is used to ensure phases are executed only when required. *enter* and
+*hold* phases are executed only when asserting reset for the first time
+(if an object is already in reset state when calling
+``resettable_assert_reset()`` or ``resettable_reset()``, they are not
+executed).
+The *exit* phase is executed only when the last reset operation ends. Therefore
+the object does not need to care how many of reset controllers it has and how
+many of them have started a reset.
+
+
+Handling reset in a resettable object
+-------------------------------------
+
+This section documents the APIs that an implementation of a resettable object
+must provide and what functions it has access to. It is intended for people
+who want to implement or convert a class which has the resettable interface;
+for example when specializing an existing device or bus.
+
+Methods to implement
+....................
+
+Three methods should be defined or left empty. Each method corresponds to a
+phase of the reset; they are name ``phases.enter()``, ``phases.hold()`` and
+``phases.exit()``. They all take the object as parameter. The *enter* method
+also take the reset type as second parameter.
+
+When extending an existing class, these methods may need to be extended too.
+The ``resettable_class_set_parent_phases()`` class function may be used to
+backup parent class methods.
+
+Here follows an example to implement reset for a Device which sets an IO while
+in reset.
+
+::
+
+    static void mydev_reset_enter(Object *obj, ResetType type)
+    {
+        MyDevClass *myclass = MYDEV_GET_CLASS(obj);
+        MyDevState *mydev = MYDEV(obj);
+        /* call parent class enter phase */
+        if (myclass->parent_phases.enter) {
+            myclass->parent_phases.enter(obj, type);
+        }
+        /* initialize local state only */
+        mydev->var = 0;
+    }
+
+    static void mydev_reset_hold(Object *obj)
+    {
+        MyDevClass *myclass = MYDEV_GET_CLASS(obj);
+        MyDevState *mydev = MYDEV(obj);
+        /* call parent class hold phase */
+        if (myclass->parent_phases.hold) {
+            myclass->parent_phases.hold(obj);
+        }
+        /* set an IO */
+        qemu_set_irq(mydev->irq, 1);
+    }
+
+    static void mydev_reset_exit(Object *obj)
+    {
+        MyDevClass *myclass = MYDEV_GET_CLASS(obj);
+        MyDevState *mydev = MYDEV(obj);
+        /* call parent class exit phase */
+        if (myclass->parent_phases.exit) {
+            myclass->parent_phases.exit(obj);
+        }
+        /* clear an IO */
+        qemu_set_irq(mydev->irq, 0);
+    }
+
+    typedef struct MyDevClass {
+        MyParentClass parent_class;
+        /* to store eventual parent reset methods */
+        ResettablePhases parent_phases;
+    } MyDevClass;
+
+    static void mydev_class_init(ObjectClass *class, void *data)
+    {
+        MyDevClass *myclass = MYDEV_CLASS(class);
+        ResettableClass *rc = RESETTABLE_CLASS(class);
+        resettable_class_set_parent_reset_phases(rc,
+                                                 mydev_reset_enter,
+                                                 mydev_reset_hold,
+                                                 mydev_reset_exit,
+                                                 &myclass->parent_phases);
+    }
+
+In the above example, we override all three phases. It is possible to override
+only some of them by passing NULL instead of a function pointer to
+``resettable_class_set_parent_reset_phases()``. For example, the following will
+only override the *enter* phase and leave *hold* and *exit* untouched::
+
+    resettable_class_set_parent_reset_phases(rc, mydev_reset_enter,
+                                             NULL, NULL,
+                                             &myclass->parent_phases);
+
+This is equivalent to providing a trivial implementation of the hold and exit
+phases which does nothing but call the parent class's implementation of the
+phase.
+
+Polling the reset state
+.......................
+
+Resettable interface provides the ``resettable_is_in_reset()`` function.
+This function returns true if the object parameter is currently under reset.
+
+An object is under reset from the beginning of the *init* phase to the end of
+the *exit* phase. During all three phases, the function will return that the
+object is in reset.
+
+This function may be used if the object behavior has to be adapted
+while in reset state. For example if a device has an irq input,
+it will probably need to ignore it while in reset; then it can for
+example check the reset state at the beginning of the irq callback.
+
+Note that until migration of the reset state is supported, an object
+should not be left in reset. So apart from being currently executing
+one of the reset phases, the only cases when this function will return
+true is if an external interaction (like changing an io) is made during
+*hold* or *exit* phase of another object in the same reset group.
+
+Helpers ``device_is_in_reset()`` and ``bus_is_in_reset()`` are also provided
+for devices and buses and should be preferred.
+
+
+Base class handling of reset
+----------------------------
+
+This section documents parts of the reset mechanism that you only need to know
+about if you are extending it to work with a new base class other than
+DeviceClass or BusClass, or maintaining the existing code in those classes. Most
+people can ignore it.
+
+Methods to implement
+....................
+
+There are two other methods that need to exist in a class implementing the
+interface: ``get_state()`` and ``child_foreach()``.
+
+``get_state()`` is simple. *resettable* is an interface and, as a consequence,
+does not have any class state structure. But in order to factorize the code, we
+need one. This method must return a pointer to ``ResettableState`` structure.
+The structure must be allocated by the base class; preferably it should be
+located inside the object instance structure.
+
+``child_foreach()`` is more complex. It should execute the given callback on
+every reset child of the given resettable object. All children must be
+resettable too. Additional parameters (a reset type and an opaque pointer) must
+be passed to the callback too.
+
+In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located
+``DeviceState`` and ``BusState`` structure. ``child_foreach()`` is implemented
+to follow the bus hierarchy; for a bus, it calls the function on every child
+device; for a device, it calls the function on every bus child. When we reset
+the main system bus, we reset the whole machine bus tree.
+
+Changing a resettable parent
+............................
+
+One thing which should be taken care of by the base class is handling reset
+hierarchy changes.
+
+The reset hierarchy is supposed to be static and built during machine creation.
+But there are actually some exceptions. To cope with this, the resettable API
+provides ``resettable_change_parent()``. This function allows to set, update or
+remove the parent of a resettable object after machine creation is done. As
+parameters, it takes the object being moved, the old parent if any and the new
+parent if any.
+
+This function can be used at any time when not in a reset operation. During
+a reset operation it must be used only in *hold* phase. Using it in *enter* or
+*exit* phase is an error.
+Also it should not be used during machine creation, although it is harmless to
+do so: the function is a no-op as long as old and new parent are NULL or not
+in reset.
+
+There is currently 2 cases where this function is used:
+
+1. *device hotplug*; it means a new device is introduced on a live bus.
+
+2. *hot bus change*; it means an existing live device is added, moved or
+   removed in the bus hierarchy. At the moment, it occurs only in the raspi
+   machines for changing the sdbus used by sd card.
-- 
2.20.1


