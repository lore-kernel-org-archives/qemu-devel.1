Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC92C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE02A22B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGKqMuhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE02A22B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVNv-0007Ng-8E
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLN-0002Mf-R9
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLL-0007Il-QC
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 22so22179954wmg.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hv/hRwDof3drBWJIx+Z5EldftQ4h6Grha3K0MkRlGTk=;
 b=AGKqMuhw3m4d33q0mUK6W2+UJSssuf59IF9pKdyRQM53j5AFtUNFitVrLz1m54h9th
 pjTiqml6mJWKvFkGLfj0ReJcLiPhR38NJ56AVkNOQzMpheB0iQR6zHuvvD5lYjfu5U8u
 k7UytPz0CDTsXEsvdcZnkaa5VnIZa719RsUwuh6aRRJZWKMZhwQah9jiftvpqE+xGOSK
 FAqU33mwXEHXgKjX40hWtKuC0ZqIFM/Y/JGBkcrNSKagBhSO9zOPHUDzKWwrtqh5QPUF
 ZMOdtfbQsXPAVJjDxToKwNqq7WhN8rNHGcVkDJAbGFmKvLRTrY7H6MwCHEra19s9bFDG
 7dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hv/hRwDof3drBWJIx+Z5EldftQ4h6Grha3K0MkRlGTk=;
 b=d5viOS07EBMdn3PlRJsGlATD6S4mS4LpxRvWbeWKeDKYh9d5GyuUkR6PaNiM4WW4CI
 9wo//Ef4d5ftxRr2MIm+/tmMNPEzKmcX8hX0O/2rxHB0JvRzHuqDM6qBP6kp/Zi7dJgc
 uLrSPlfBFwLt8G0QzmD0lChpQIliMvHKYzPvpmzAp5M83A0hQsLqqo2jIOJI6lki5PNs
 7K9I/MsBkiK6FMTCr4X0Bcz1kY9suCdzNU0Zc2ND99V0Ax4/HCkkYL9EFsqWYM/8mYta
 Zn0/qxSS9giE8UoKaEohh5j1yMbfJJAfP3N7MSFStGsYtmhtnCuabZwDfo4Y8Dj4p+xQ
 v0Jw==
X-Gm-Message-State: AOAM532aB8Q3SSp2+pqFzhIED0XHVC6RGGHK0LHrjeJyDJ30DDFKX+Js
 vSGKlm0yq2xA4BxTQoHd6wvPNTl8GiBNRA==
X-Google-Smtp-Source: ABdhPJyKPFLjYztcEuk3wCsrdcxbP15F40aeOwOh81wAPXZWc1VXGoLXFklbsoyMaAf2baPJ5bLefg==
X-Received: by 2002:a1c:d8:: with SMTP id 207mr20722005wma.81.1595249789868;
 Mon, 20 Jul 2020 05:56:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] qdev: Move doc comments from qdev.c to qdev-core.h
Date: Mon, 20 Jul 2020 13:56:14 +0100
Message-Id: <20200720125621.13460-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The doc-comments which document the qdev API are split between the
header file and the C source files, because as a project we haven't
been consistent about where we put them.

Move all the doc-comments in qdev.c to the header files, so that
users of the APIs don't have to look at the implementation files for
this information.

In the process, unify them into our doc-comment format and expand on
them in some cases to clarify expected use cases.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200711142425.16283-2-peter.maydell@linaro.org
---
 include/hw/qdev-core.h       | 57 ++++++++++++++++++++++++++++++++++++
 include/hw/qdev-properties.h | 13 ++++++++
 hw/core/qdev.c               | 33 ---------------------
 3 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fe78073c708..2d441d1fb2e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -320,9 +320,66 @@ compat_props_add(GPtrArray *arr,
 
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
+/**
+ * qdev_new: Create a device on the heap
+ * @name: device type to create (we assert() that this type exists)
+ *
+ * This only allocates the memory and initializes the device state
+ * structure, ready for the caller to set properties if they wish.
+ * The device still needs to be realized.
+ * The returned object has a reference count of 1.
+ */
 DeviceState *qdev_new(const char *name);
+/**
+ * qdev_try_new: Try to create a device on the heap
+ * @name: device type to create
+ *
+ * This is like qdev_new(), except it returns %NULL when type @name
+ * does not exist, rather than asserting.
+ */
 DeviceState *qdev_try_new(const char *name);
+/**
+ * qdev_realize: Realize @dev.
+ * @dev: device to realize
+ * @bus: bus to plug it into (may be NULL)
+ * @errp: pointer to error object
+ *
+ * "Realize" the device, i.e. perform the second phase of device
+ * initialization.
+ * @dev must not be plugged into a bus already.
+ * If @bus, plug @dev into @bus.  This takes a reference to @dev.
+ * If @dev has no QOM parent, make one up, taking another reference.
+ * On success, return true.
+ * On failure, store an error through @errp and return false.
+ *
+ * If you created @dev using qdev_new(), you probably want to use
+ * qdev_realize_and_unref() instead.
+ */
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
+/**
+ * qdev_realize_and_unref: Realize @dev and drop a reference
+ * @dev: device to realize
+ * @bus: bus to plug it into (may be NULL)
+ * @errp: pointer to error object
+ *
+ * Realize @dev and drop a reference.
+ * This is like qdev_realize(), except the caller must hold a
+ * (private) reference, which is dropped on return regardless of
+ * success or failure.  Intended use::
+ *
+ *     dev = qdev_new();
+ *     [...]
+ *     qdev_realize_and_unref(dev, bus, errp);
+ *
+ * Now @dev can go away without further ado.
+ *
+ * If you are embedding the device into some other QOM device and
+ * initialized it via some variant on object_initialize_child() then
+ * do not use this function, because that family of functions arrange
+ * for the only reference to the child device to be held by the parent
+ * via the child<> property, and so the reference-count-drop done here
+ * would be incorrect. For that use case you want qdev_realize().
+ */
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
 void qdev_unrealize(DeviceState *dev);
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 587e5b7d317..8f3a98cba69 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -282,6 +282,19 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
  */
 void qdev_property_add_static(DeviceState *dev, Property *prop);
 
+/**
+ * qdev_alias_all_properties: Create aliases on source for all target properties
+ * @target: Device which has properties to be aliased
+ * @source: Object to add alias properties to
+ *
+ * Add alias properties to the @source object for all qdev properties on
+ * the @target DeviceState.
+ *
+ * This is useful when @target is an internal implementation object
+ * owned by @source, and you want to expose all the properties of that
+ * implementation object as properties on the @source object so that users
+ * of @source can set them.
+ */
 void qdev_alias_all_properties(DeviceState *target, Object *source);
 
 /**
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 01796823b41..96772a15bd5 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -128,13 +128,6 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
     }
 }
 
-/*
- * Create a device on the heap.
- * A type @name must exist.
- * This only initializes the device state structure and allows
- * properties to be set.  The device still needs to be realized.  See
- * qdev-core.h.
- */
 DeviceState *qdev_new(const char *name)
 {
     if (!object_class_by_name(name)) {
@@ -143,11 +136,6 @@ DeviceState *qdev_new(const char *name)
     return DEVICE(object_new(name));
 }
 
-/*
- * Try to create a device on the heap.
- * This is like qdev_new(), except it returns %NULL when type @name
- * does not exist.
- */
 DeviceState *qdev_try_new(const char *name)
 {
     if (!module_object_class_by_name(name)) {
@@ -378,14 +366,6 @@ void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
     qdev_unrealize(dev);
 }
 
-/*
- * Realize @dev.
- * @dev must not be plugged into a bus.
- * If @bus, plug @dev into @bus.  This takes a reference to @dev.
- * If @dev has no QOM parent, make one up, taking another reference.
- * On success, return true.
- * On failure, store an error through @errp and return false.
- */
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 {
     assert(!dev->realized && !dev->parent_bus);
@@ -399,16 +379,6 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
     return object_property_set_bool(OBJECT(dev), "realized", true, errp);
 }
 
-/*
- * Realize @dev and drop a reference.
- * This is like qdev_realize(), except the caller must hold a
- * (private) reference, which is dropped on return regardless of
- * success or failure.  Intended use:
- *     dev = qdev_new();
- *     [...]
- *     qdev_realize_and_unref(dev, bus, errp);
- * Now @dev can go away without further ado.
- */
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
 {
     bool ret;
@@ -814,9 +784,6 @@ static void qdev_class_add_property(DeviceClass *klass, Property *prop)
                                           prop->info->description);
 }
 
-/* @qdev_alias_all_properties - Add alias properties to the source object for
- * all qdev properties on the target DeviceState.
- */
 void qdev_alias_all_properties(DeviceState *target, Object *source)
 {
     ObjectClass *class;
-- 
2.20.1


