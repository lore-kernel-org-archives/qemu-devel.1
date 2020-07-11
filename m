Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD84C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B59020720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2bK1g4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B59020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juGRb-0001v7-8e
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 10:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGQd-0000eN-W2
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:24:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGQb-0003vA-Qh
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:24:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id j4so8676440wrp.10
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3fMfM+fr5YwoM4os1V4YvxA21wN2iqGk4DZcdab13Os=;
 b=o2bK1g4gqqRMqXLuFtN2nOzlZ7I3OBv34x8HtwV5K0Yw+gMHxn/Q2ubdFUXM5B6icI
 iuY2NqEokaSK/PhqrrHxR6+8s4bAYdP+xsn9F0r0beFObaa5M6yK8FhpVIj+oWK28Ti3
 TwFC8TWDVn4nlxHo9KjsZCyPNs5zaa7duTAAld0jOJdLCk4DKuRqJkoW76wwwI+qckYX
 e2F6cBDxozo277XtYoOgyo+HN4uFId68/vry+hKpA/TMTo1tVdto1LjWUOiiwj2FCPCY
 AD4SZ8MJx3lrdZlpxXipmKuP9rATGxKAMyx/B7Par+40IwysB0jvkxPx82xa43S6HF9z
 YXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3fMfM+fr5YwoM4os1V4YvxA21wN2iqGk4DZcdab13Os=;
 b=mgfA/9hEyPmXDRntXktB+RdfNiwhf0dCnWmAkMrbkXZ79uj7t8wc+7fp+7YsryI5bI
 vXP75KvvoWR1Guhd2OtJ5cLanE4O9dXTi29dSpNSpPyQAgOxXuXkGi9NRkL6GE38mw1b
 lfTT+lmMUFD0NWXEuEUUpT7UR4PVWxMUQlUgsGq/xZO7RIf37+cgKbqrGXJc7IUnz1el
 rjZcu50rMnnGhoz3a/hGIFtm/amGXGDcs6TNI+h0QG6bbV9gg5cGC2QbLK7Nih3E/HjW
 CxYnEiwztf+PkA/u+sapeD2VWDhEFuEwGIRGotWOWV5Z0+Jn3Kg85Tqau2cZiXiBIqCh
 wWXA==
X-Gm-Message-State: AOAM532VkwjEzEZFRCLjekwe9rCeMcPo2zB5/VomecKPJRXWrQKiz0Qr
 haHNpeqWW24LhO56tUmr5R1LMXaLZPCi3g==
X-Google-Smtp-Source: ABdhPJziEprODdKFDtueHRYRufTA8l6gHdwG/6Cj3E0232brL9Cj2/kEj6yx+snK/zeJoqeAy9H26Q==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr79966763wrn.157.1594477471691; 
 Sat, 11 Jul 2020 07:24:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u10sm13448525wml.29.2020.07.11.07.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 07:24:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 3/3] qdev: Document GPIO related functions
Date: Sat, 11 Jul 2020 15:24:25 +0100
Message-Id: <20200711142425.16283-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711142425.16283-1-peter.maydell@linaro.org>
References: <20200711142425.16283-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add documentation comments for the various qdev functions
related to creating and connecting GPIO lines.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-core.h | 191 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 189 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 1d2bf5f37da..ea3f73a282d 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -424,13 +424,132 @@ void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
 void qdev_machine_creation_done(void);
 bool qdev_machine_modified(void);
 
+/**
+ * qdev_get_gpio_in: Get one of a device's anonymous input GPIO lines
+ * @dev: Device whose GPIO we want
+ * @n: Number of the anonymous GPIO line (which must be in range)
+ *
+ * Returns the qemu_irq corresponding to an anonymous input GPIO line
+ * (which the device has set up with qdev_init_gpio_in()). The index
+ * @n of the GPIO line must be valid (i.e. be at least 0 and less than
+ * the total number of anonymous input GPIOs the device has); this
+ * function will assert() if passed an invalid index.
+ *
+ * This function is intended to be used by board code or SoC "container"
+ * device models to wire up the GPIO lines; usually the return value
+ * will be passed to qdev_connect_gpio_out() or a similar function to
+ * connect another device's output GPIO line to this input.
+ *
+ * For named input GPIO lines, use qdev_get_gpio_in_named().
+ */
 qemu_irq qdev_get_gpio_in(DeviceState *dev, int n);
+/**
+ * qdev_get_gpio_in_named: Get one of a device's named input GPIO lines
+ * @dev: Device whose GPIO we want
+ * @name: Name of the input GPIO array
+ * @n: Number of the GPIO line in that array (which must be in range)
+ *
+ * Returns the qemu_irq corresponding to a named input GPIO line
+ * (which the device has set up with qdev_init_gpio_in_named()).
+ * The @name string must correspond to an input GPIO array which exists on
+ * the device, and the index @n of the GPIO line must be valid (i.e.
+ * be at least 0 and less than the total number of input GPIOs in that
+ * array); this function will assert() if passed an invalid name or index.
+ *
+ * For anonymous input GPIO lines, use qdev_get_gpio_in().
+ */
 qemu_irq qdev_get_gpio_in_named(DeviceState *dev, const char *name, int n);
 
+/**
+ * qdev_connect_gpio_out: Connect one of a device's anonymous output GPIO lines
+ * @dev: Device whose GPIO to connect
+ * @n: Number of the anonymous output GPIO line (which must be in range)
+ * @pin: qemu_irq to connect the output line to
+ *
+ * This function connects an anonymous output GPIO line on a device
+ * up to an arbitrary qemu_irq, so that when the device asserts that
+ * output GPIO line, the qemu_irq's callback is invoked.
+ * The index @n of the GPIO line must be valid (i.e. be at least 0 and
+ * less than the total number of anonymous output GPIOs the device has
+ * created with qdev_init_gpio_out()); otherwise this function will assert().
+ *
+ * Outbound GPIO lines can be connected to any qemu_irq, but the common
+ * case is connecting them to another device's inbound GPIO line, using
+ * the qemu_irq returned by qdev_get_gpio_in() or qdev_get_gpio_in_named().
+ *
+ * It is not valid to try to connect one outbound GPIO to multiple
+ * qemu_irqs at once, or to connect multiple outbound GPIOs to the
+ * same qemu_irq. (Warning: there is no assertion or other guard to
+ * catch this error: the model will just not do the right thing.)
+ * Instead, for fan-out you can use the TYPE_IRQ_SPLIT device: connect
+ * a device's outbound GPIO to the splitter's input, and connect each
+ * of the splitter's outputs to a different device.  For fan-in you
+ * can use the TYPE_OR_IRQ device, which is a model of a logical OR
+ * gate with multiple inputs and one output.
+ *
+ * For named output GPIO lines, use qdev_connect_gpio_out_named().
+ */
 void qdev_connect_gpio_out(DeviceState *dev, int n, qemu_irq pin);
+/**
+ * qdev_connect_gpio_out: Connect one of a device's anonymous output GPIO lines
+ * @dev: Device whose GPIO to connect
+ * @name: Name of the output GPIO array
+ * @n: Number of the anonymous output GPIO line (which must be in range)
+ * @pin: qemu_irq to connect the output line to
+ *
+ * This function connects an anonymous output GPIO line on a device
+ * up to an arbitrary qemu_irq, so that when the device asserts that
+ * output GPIO line, the qemu_irq's callback is invoked.
+ * The @name string must correspond to an output GPIO array which exists on
+ * the device, and the index @n of the GPIO line must be valid (i.e.
+ * be at least 0 and less than the total number of input GPIOs in that
+ * array); this function will assert() if passed an invalid name or index.
+ *
+ * Outbound GPIO lines can be connected to any qemu_irq, but the common
+ * case is connecting them to another device's inbound GPIO line, using
+ * the qemu_irq returned by qdev_get_gpio_in() or qdev_get_gpio_in_named().
+ *
+ * It is not valid to try to connect one outbound GPIO to multiple
+ * qemu_irqs at once, or to connect multiple outbound GPIOs to the
+ * same qemu_irq; see qdev_connect_gpio_out() for details.
+ *
+ * For named output GPIO lines, use qdev_connect_gpio_out_named().
+ */
 void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
                                  qemu_irq pin);
+/**
+ * qdev_get_gpio_out_connector: Get the qemu_irq connected to an output GPIO
+ * @dev: Device whose output GPIO we are interested in
+ * @name: Name of the output GPIO array
+ * @n: Number of the output GPIO line within that array
+ *
+ * Returns whatever qemu_irq is currently connected to the specified
+ * output GPIO line of @dev. This will be NULL if the output GPIO line
+ * has never been wired up to the anything.  Note that the qemu_irq
+ * returned does not belong to @dev -- it will be the input GPIO or
+ * IRQ of whichever device the board code has connected up to @dev's
+ * output GPIO.
+ *
+ * You probably don't need to use this function -- it is used only
+ * by the platform-bus subsystem.
+ */
 qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n);
+/**
+ * qdev_intercept_gpio_out: Intercept an existing GPIO connection
+ * @dev: Device to intercept the outbound GPIO line from
+ * @icpt: New qemu_irq to connect instead
+ * @name: Name of the output GPIO array
+ * @n: Number of the GPIO line in the array
+ *
+ * This function is provided only for use by the qtest testing framework
+ * and is not suitable for use in non-testing parts of QEMU.
+ *
+ * This function breaks an existing connection of an outbound GPIO
+ * line from @dev, and replaces it with the new qemu_irq @icpt, as if
+ * ``qdev_connect_gpio_out_named(dev, icpt, name, n)`` had been called.
+ * The previously connected qemu_irq is returned, so it can be restored
+ * by a second call to qdev_intercept_gpio_out() if desired.
+ */
 qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
                                  const char *name, int n);
 
@@ -438,10 +557,59 @@ BusState *qdev_get_child_bus(DeviceState *dev, const char *name);
 
 /*** Device API.  ***/
 
-/* Register device properties.  */
-/* GPIO inputs also double as IRQ sinks.  */
+/**
+ * qdev_init_gpio_in: create an array of anonymous input GPIO lines
+ * @dev: Device to create input GPIOs for
+ * @handler: Function to call when GPIO line value is set
+ * @n: Number of GPIO lines to create
+ *
+ * Devices should use functions in the qdev_init_gpio_in* family in
+ * their instance_init or realize methods to create any input GPIO
+ * lines they need. There is no functional difference between
+ * anonymous and named GPIO lines. Stylistically, named GPIOs are
+ * preferable (easier to understand at callsites) unless a device
+ * has exactly one uniform kind of GPIO input whose purpose is obvious.
+ * Note that input GPIO lines can serve as 'sinks' for IRQ lines.
+ *
+ * See qdev_get_gpio_in() for how code that uses such a device can get
+ * hold of an input GPIO line to manipulate it.
+ */
 void qdev_init_gpio_in(DeviceState *dev, qemu_irq_handler handler, int n);
+/**
+ * qdev_init_gpio_out: create an array of anonymous output GPIO lines
+ * @dev: Device to create output GPIOs for
+ * @pins: Pointer to qemu_irq or qemu_irq array for the GPIO lines
+ * @n: Number of GPIO lines to create
+ *
+ * Devices should use functions in the qdev_init_gpio_out* family
+ * in their instance_init or realize methods to create any output
+ * GPIO lines they need. There is no functional difference between
+ * anonymous and named GPIO lines. Stylistically, named GPIOs are
+ * preferable (easier to understand at callsites) unless a device
+ * has exactly one uniform kind of GPIO output whose purpose is obvious.
+ *
+ * The @pins argument should be a pointer to either a "qemu_irq"
+ * (if @n == 1) or a "qemu_irq []" array (if @n > 1) in the device's
+ * state structure. The device implementation can then raise and
+ * lower the GPIO line by calling qemu_set_irq(). (If anything is
+ * connected to the other end of the GPIO this will cause the handler
+ * function for that input GPIO to be called.)
+ *
+ * See qdev_connect_gpio_out() for how code that uses such a device
+ * can connect to one of its output GPIO lines.
+ */
 void qdev_init_gpio_out(DeviceState *dev, qemu_irq *pins, int n);
+/**
+ * qdev_init_gpio_out: create an array of named output GPIO lines
+ * @dev: Device to create output GPIOs for
+ * @pins: Pointer to qemu_irq or qemu_irq array for the GPIO lines
+ * @name: Name to give this array of GPIO lines
+ * @n: Number of GPIO lines to create
+ *
+ * Like qdev_init_gpio_out(), but creates an array of GPIO output lines
+ * with a name. Code using the device can then connect these GPIO lines
+ * using qdev_connect_gpio_out_named().
+ */
 void qdev_init_gpio_out_named(DeviceState *dev, qemu_irq *pins,
                               const char *name, int n);
 /**
@@ -473,6 +641,25 @@ static inline void qdev_init_gpio_in_named(DeviceState *dev,
     qdev_init_gpio_in_named_with_opaque(dev, handler, dev, name, n);
 }
 
+/**
+ * qdev_pass_gpios: create GPIO lines on container which pass through to device
+ * @dev: Device which has GPIO lines
+ * @container: Container device which needs to expose them
+ * @name: Name of GPIO array to pass through (NULL for the anonymous GPIO array)
+ *
+ * In QEMU, complicated devices like SoCs are often modelled with a
+ * "container" QOM device which itself contains other QOM devices and
+ * which wires them up appropriately. This function allows the container
+ * to create GPIO arrays on itself which simply pass through to a GPIO
+ * array of one of its internal devices.
+ *
+ * If @dev has both input and output GPIOs named @name then both will
+ * be passed through. It is not possible to pass a subset of the array
+ * with this function.
+ *
+ * To users of the container device, the GPIO array created on @container
+ * behaves exactly like any other.
+ */
 void qdev_pass_gpios(DeviceState *dev, DeviceState *container,
                      const char *name);
 
-- 
2.20.1


