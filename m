Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206EBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB788204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB788204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZt2M-0002hT-J3
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 03:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1iZsx3-0005gm-Sx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1iZsum-0002nY-Gy
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:43:13 -0500
Received: from xavier.telenet-ops.be ([2a02:1800:120:4::f00:14]:36340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1iZsum-0002lC-9U
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:43:12 -0500
Received: from ramsan ([84.195.182.253]) by xavier.telenet-ops.be with bizsmtp
 id Wwiu2100X5USYZQ01wiuc6; Wed, 27 Nov 2019 09:43:07 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iZsuU-0000xl-Oj; Wed, 27 Nov 2019 09:42:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iZsuU-0004Or-Ld; Wed, 27 Nov 2019 09:42:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v3 4/7] dt-bindings: gpio: Add gpio-repeater bindings
Date: Wed, 27 Nov 2019 09:42:50 +0100
Message-Id: <20191127084253.16356-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127084253.16356-1-geert+renesas@glider.be>
References: <20191127084253.16356-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:120:4::f00:14
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add Device Tree bindings for a GPIO repeater, with optional translation
of physical signal properties.  This is useful for describing explicitly
the presence of e.g. an inverter on a GPIO line, and was inspired by the
non-YAML gpio-inverter bindings by Harish Jenny K N
<harish_kandiga@mentor.com>[1].

Note that this is different from a GPIO Nexus Node[2], which cannot do
physical signal property translation.

While an inverter can be described implicitly by exchanging the
GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags, this has its limitations.
Each GPIO line has only a single GPIO_ACTIVE_* flag, but applies to both
th provider and consumer sides:
  1. The GPIO provider (controller) looks at the flags to know the
     polarity, so it can translate between logical (active/not active)
     and physical (high/low) signal levels.
  2. While the signal polarity is usually fixed on the GPIO consumer
     side (e.g. an LED is tied to either the supply voltage or GND),
     it may be configurable on some devices, and both sides need to
     agree.  Hence the GPIO_ACTIVE_* flag as seen by the consumer must
     match the actual polarity.
     There exists a similar issue with interrupt flags, where both the
     interrupt controller and the device generating the interrupt need
     to agree, which breaks in the presence of a physical inverter not
     described in DT (see e.g. [3]).

[1] "[PATCH V4 2/2] gpio: inverter: document the inverter bindings"
    https://lore.kernel.org/linux-gpio/1561699236-18620-3-git-send-email-harish_kandiga@mentor.com/

[2] Devicetree Specification v0.3-rc2, Section 2.5
    https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3-rc2

[3] "[PATCH] wlcore/wl18xx: Add invert-irq OF property for physically
    inverted IRQ"
    https://lore.kernel.org/linux-renesas-soc/20190607172958.20745-1-erosca@de.adit-jv.com/

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 .../bindings/gpio/gpio-repeater.yaml          | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-repeater.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-repeater.yaml b/Documentation/devicetree/bindings/gpio/gpio-repeater.yaml
new file mode 100644
index 0000000000000000..efdee0c3be43f731
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-repeater.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-repeater.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO Repeater
+
+maintainers:
+  - Harish Jenny K N <harish_kandiga@mentor.com>
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+description:
+  This represents a repeater for one or more GPIOs, possibly including physical
+  signal property translation (e.g. polarity inversion).
+
+properties:
+  compatible:
+    const: gpio-repeater
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpios:
+    description:
+      Phandle and specifier, one for each repeated GPIO.
+
+  gpio-line-names:
+    description:
+      Strings defining the names of the GPIO lines going out of the GPIO
+      controller.
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+  - gpios
+
+additionalProperties: false
+
+examples:
+  # Device node describing a polarity inverter for a single GPIO
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    inverter: gpio-repeater {
+        compatible = "gpio-repeater";
+        #gpio-cells = <2>;
+        gpio-controller;
+        gpios = <&gpio 95 GPIO_ACTIVE_LOW>;
+    };
-- 
2.17.1


