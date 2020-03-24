Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535D5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2933D205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2933D205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGk6G-0004yY-9k
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jGk3K-000062-VS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1jGk3J-0006Gt-8H
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:10 -0400
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a]:55114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1jGk3I-0006CU-It
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:08 -0400
Received: from ramsan ([84.195.182.253]) by albert.telenet-ops.be with bizsmtp
 id JDwu2200T5USYZQ06DwuaB; Tue, 24 Mar 2020 14:57:06 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGk34-0006Ot-OI; Tue, 24 Mar 2020 14:56:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGk34-0001ko-MP; Tue, 24 Mar 2020 14:56:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v6 7/8] docs: gpio: Add GPIO Aggregator documentation
Date: Tue, 24 Mar 2020 14:56:52 +0100
Message-Id: <20200324135653.6676-7-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324135653.6676-1-geert+renesas@glider.be>
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:110:4::f00:1a
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document the GPIO Aggregator, and the two typical use-cases.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
v6:
  - Fix "allows" without object:
      -> provides a mechanism to aggregate GPIOs,
      -> provides access control for a set of one or more GPIOs,
      -> allows the user to communicate,
  - Drop "gpiochipN" support,
  - Extend example,

v5:
  - Add Reviewed-by, Tested-by,
  - Fix inconsistent indentation,

v4:
  - Add Reviewed-by,
  - Drop controversial GPIO repeater,
  - Clarify industrial control use case,
  - Fix typo s/communicated/communicate/,
  - Replace abstract frobnicator example by concrete door example with
    gpio-line-names,

v3:
  - New.
---
 .../admin-guide/gpio/gpio-aggregator.rst      | 111 ++++++++++++++++++
 Documentation/admin-guide/gpio/index.rst      |   1 +
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/admin-guide/gpio/gpio-aggregator.rst

diff --git a/Documentation/admin-guide/gpio/gpio-aggregator.rst b/Documentation/admin-guide/gpio/gpio-aggregator.rst
new file mode 100644
index 0000000000000000..5cd1e7221756504c
--- /dev/null
+++ b/Documentation/admin-guide/gpio/gpio-aggregator.rst
@@ -0,0 +1,111 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+GPIO Aggregator
+===============
+
+The GPIO Aggregator provides a mechanism to aggregate GPIOs, and expose them as
+a new gpio_chip.  This supports the following use cases.
+
+
+Aggregating GPIOs using Sysfs
+-----------------------------
+
+GPIO controllers are exported to userspace using /dev/gpiochip* character
+devices.  Access control to these devices is provided by standard UNIX file
+system permissions, on an all-or-nothing basis: either a GPIO controller is
+accessible for a user, or it is not.
+
+The GPIO Aggregator provides access control for a set of one or more GPIOs, by
+aggregating them into a new gpio_chip, which can be assigned to a group or user
+using standard UNIX file ownership and permissions.  Furthermore, this
+simplifies and hardens exporting GPIOs to a virtual machine, as the VM can just
+grab the full GPIO controller, and no longer needs to care about which GPIOs to
+grab and which not, reducing the attack surface.
+
+Aggregated GPIO controllers are instantiated and destroyed by writing to
+write-only attribute files in sysfs.
+
+    /sys/bus/platform/drivers/gpio-aggregator/
+
+	"new_device" ...
+		Userspace may ask the kernel to instantiate an aggregated GPIO
+		controller by writing a string describing the GPIOs to
+		aggregate to the "new_device" file, using the format
+
+		.. code-block:: none
+
+		    [<gpioA>] [<gpiochipB> <offsets>] ...
+
+		Where:
+
+		    "<gpioA>" ...
+			    is a GPIO line name,
+
+		    "<gpiochipB>" ...
+			    is a GPIO chip label, and
+
+		    "<offsets>" ...
+			    is a comma-separated list of GPIO offsets and/or
+			    GPIO offset ranges denoted by dashes.
+
+		Example: Instantiate a new GPIO aggregator by aggregating GPIO
+		line 19 of "e6052000.gpio" and GPIO lines 20-21 of
+		"e6050000.gpio" into a new gpio_chip:
+
+		.. code-block:: sh
+
+		    $ echo 'e6052000.gpio 19 e6050000.gpio 20-21' > new_device
+
+	"delete_device" ...
+		Userspace may ask the kernel to destroy an aggregated GPIO
+		controller after use by writing its device name to the
+		"delete_device" file.
+
+		Example: Destroy the previously-created aggregated GPIO
+		controller, assumed to be "gpio-aggregator.0":
+
+		.. code-block:: sh
+
+		    $ echo gpio-aggregator.0 > delete_device
+
+
+Generic GPIO Driver
+-------------------
+
+The GPIO Aggregator can also be used as a generic driver for a simple
+GPIO-operated device described in DT, without a dedicated in-kernel driver.
+This is useful in industrial control, and is not unlike e.g. spidev, which
+allows the user to communicate with an SPI device from userspace.
+
+Binding a device to the GPIO Aggregator is performed either by modifying the
+gpio-aggregator driver, or by writing to the "driver_override" file in Sysfs.
+
+Example: If "door" is a GPIO-operated device described in DT, using its own
+compatible value::
+
+	door {
+		compatible = "myvendor,mydoor";
+
+		gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>,
+			<&gpio2 20 GPIO_ACTIVE_LOW>;
+		gpio-line-names = "open", "lock";
+	};
+
+it can be bound to the GPIO Aggregator by either:
+
+1. Adding its compatible value to ``gpio_aggregator_dt_ids[]``,
+2. Binding manually using "driver_override":
+
+.. code-block:: sh
+
+    $ echo gpio-aggregator > /sys/bus/platform/devices/door/driver_override
+    $ echo door > /sys/bus/platform/drivers/gpio-aggregator/bind
+
+After that, a new gpiochip "door" has been created:
+
+.. code-block:: sh
+
+    $ gpioinfo door
+    gpiochip12 - 2 lines:
+	    line   0:       "open"       unused   input  active-high
+	    line   1:       "lock"       unused   input  active-high
diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
index a244ba4e87d5398a..ef2838638e967777 100644
--- a/Documentation/admin-guide/gpio/index.rst
+++ b/Documentation/admin-guide/gpio/index.rst
@@ -7,6 +7,7 @@ gpio
 .. toctree::
     :maxdepth: 1
 
+    gpio-aggregator
     sysfs
 
 .. only::  subproject and html
-- 
2.17.1


