Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CFBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1171D2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi+C0EfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1171D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifP0D-000152-So
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNzF-0004wZ-C5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNzE-0008PQ-5S
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:35184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNzD-0008NA-Up
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id p17so2394576wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BCzU6I2Xtbzw4y1h1eJ8RPM0tsmyA1ceqiw1bsOdQC8=;
 b=Vi+C0EfXbengYmqn9RP3O/TyjFZupQWSX3JdTZXO3fPV8oAIZcVQnVQwT8FG+AGwmZ
 5YLwAQJCJaHu3+w6ecyQCWjCtk8jvr7YkBMLKHuSnVM/3nkWx8QRd7ss/cWFtWtLQ4RI
 /b6jVv3NTtU68nphmTUw2BQysSsxYmxN1SsYaQJ/fxiYbMGstkFYFOazkt9d3vv6WA8S
 w76Wldy1YnxsdRhkqLVpYa5R8tiXO6sMR32YiLrFO/0TVDuQIbFwr1zMDlU2H31S30i9
 SxOfMdkcO5ap3KHW6Y0wQYKBdagfUwEFieU4y2V1ipr0uCwni0w2bt4EYITYOhmQA3CM
 GQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BCzU6I2Xtbzw4y1h1eJ8RPM0tsmyA1ceqiw1bsOdQC8=;
 b=LE+UaYELn+NY9HEdfPZsq2ZbxG1xRv82GV8fgdxF+kWuJ+FLxpVcUUZTaLgGyfbEet
 f6D0lDl/DnOf8HOd9WPce2UHOXGeaDFmjxo2OB9WlNxTc0W+ko+vlBC+00P1OEpsllC/
 nPX/Et56b4YvXYa2fwb/f7UFiIFl5mhKt5gwU9KwiDBBUzCDZusJGA9wAykKGt6OptWM
 kfE9dc4OVLNDdNn2rpoUo/B5RjJOnsYxzhdoAh0Q7A2KfZjZKNMnyzG1RqXC+n+i4Agg
 VkVKGz6mwecl9EOHigNuG+8i795O3Rkqh5X65ZoCAhorQwTZs0ByGxxSKAN0kmJvbqfI
 /xkg==
X-Gm-Message-State: APjAAAVWGlF7xlJ6umX872BswNW7u4rdwzreBRti5PjzvFMolPYuAoNR
 +Ri1isdsVzzMZJVpoA5BbnvgUELN
X-Google-Smtp-Source: APXvYqx0kK5hTTcuYptbb3qaw1moBG34cLpSfB1DWkCGakFv+2hrLqZVLs6FpalBYXGxRyOZ36J3oQ==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr6833666wmh.30.1576155270659; 
 Thu, 12 Dec 2019 04:54:30 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 093/132] meson: convert hw/gpio
Date: Thu, 12 Dec 2019 13:52:17 +0100
Message-Id: <1576155176-2464-94-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs      |  1 -
 hw/gpio/Makefile.objs | 11 -----------
 hw/gpio/meson.build   | 11 +++++++++++
 hw/meson.build        |  1 +
 4 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 hw/gpio/Makefile.objs
 create mode 100644 hw/gpio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 2ca159e..084bfc6 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -9,7 +9,6 @@ devices-dirs-y += char/
 devices-dirs-y += cpu/
 devices-dirs-y += display/
 devices-dirs-y += dma/
-devices-dirs-y += gpio/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
deleted file mode 100644
index e5da0cb..0000000
--- a/hw/gpio/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-common-obj-$(CONFIG_MAX7310) += max7310.o
-common-obj-$(CONFIG_PL061) += pl061.o
-common-obj-$(CONFIG_PUV3) += puv3_gpio.o
-common-obj-$(CONFIG_ZAURUS) += zaurus.o
-common-obj-$(CONFIG_E500) += mpc8xxx.o
-common-obj-$(CONFIG_GPIO_KEY) += gpio_key.o
-
-obj-$(CONFIG_OMAP) += omap_gpio.o
-obj-$(CONFIG_IMX) += imx_gpio.o
-obj-$(CONFIG_RASPI) += bcm2835_gpio.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_gpio.o
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
new file mode 100644
index 0000000..1d24a2d
--- /dev/null
+++ b/hw/gpio/meson.build
@@ -0,0 +1,11 @@
+softmmu_ss.add(when: 'CONFIG_E500', if_true: files('mpc8xxx.c'))
+softmmu_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
+softmmu_ss.add(when: 'CONFIG_MAX7310', if_true: files('max7310.c'))
+softmmu_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_ZAURUS', if_true: files('zaurus.c'))
+
+specific_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
+specific_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
diff --git a/hw/meson.build b/hw/meson.build
index bfd4d59..a61aeaf 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('gpio')
 subdir('hyperv')
 subdir('i2c')
 subdir('ide')
-- 
1.8.3.1



