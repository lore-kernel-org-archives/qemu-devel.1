Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F74C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDFA2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsluURyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDFA2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWQ6-0006Js-By
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7k-0003Xa-R2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7j-00080n-PX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:04 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7j-0007zi-IZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:03 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so17147810wru.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=khzoAJC6EispDWMXJwbaG8Z6znk5PthJmXlB3/jTBZo=;
 b=BsluURyuEg/SXDrxK5nrN+EQWg/bhHsHUKiFGTPsXE476blrlkj15qRC64oO5CqiXN
 9NZfg8hKi/5HGU2j2N4Fjuibohtd+8O1DXuwSE+7XElGIhVzw8b8xTXkMg7sdEfPldHq
 kZbZsMSIt28xH6ezumlbOQg46+ZCULmb+dpkKfqEvJtF3EscYBNRDIv33SWxpJss6wtF
 c7Xc5jkUyQ7RZrla+kRsYXG1aXziNjU7NltYo9xoLrGUBjv+jPlXVvczeqm38lxjl9P4
 qDApqo/C+LVm8+lvFdoeUIW+ZABqrJkL81fcws04XbG7N0vs3XLCxNwdbnZA/Jn24vJA
 J16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=khzoAJC6EispDWMXJwbaG8Z6znk5PthJmXlB3/jTBZo=;
 b=bRWx8NFIMzWf3g/t9Aondqe3x+qQPWF4s8yknAZ6cbkE4DCbxs3bobVY/Gy0+WSvf4
 Ze2IMTeRVx7KSirVCHjyF3VwARPHBJU6ub5P8g3H43qyvt9vDeQnW7+c4wCvyh17KDGr
 E500LRy4NA2adMpIJrWHHxtJhIn4nwMFrO/Pe3EcE47xFxfJj0S5u2hc6T4AB8tYl4Lh
 ILYBQz4rfzkOIgYvar+r0xiSYBZsOxGlZWhYrgRsumUSbTV318TASKRUZgyIzdEwpLRX
 LEvjHAu4AnkGmL3SMRF1+IeMTfNegLNw9C6alFZZHmAoUPhnsRYInYa0/oesEWQCEEfE
 MnLA==
X-Gm-Message-State: APjAAAUSZSXwBMam61JrPuM2sBvgqQuahw1VPRLpFjp55ZHChDk+Az0J
 1fyyQ5Lgtaz4N6rTp/bjDfVrhuaD
X-Google-Smtp-Source: APXvYqwBuyNdf7CcZkt6WZDb94/hZpPXkxD0GV3HLK+sHrmsvPZC5KB5ewOkt6Wm4K89Vfj9xH7q2g==
X-Received: by 2002:adf:b193:: with SMTP id q19mr29575709wra.78.1580234282338; 
 Tue, 28 Jan 2020 09:58:02 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 108/142] meson: convert hw/adc
Date: Tue, 28 Jan 2020 18:53:08 +0100
Message-Id: <20200128175342.9066-109-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs     | 1 -
 hw/adc/Makefile.objs | 1 -
 hw/adc/meson.build   | 1 +
 hw/meson.build       | 1 +
 4 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 hw/adc/Makefile.objs
 create mode 100644 hw/adc/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index c69c3aa4c5..5823867997 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,7 +1,6 @@
 ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
 devices-dirs-y += acpi/
-devices-dirs-y += adc/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/adc/Makefile.objs b/hw/adc/Makefile.objs
deleted file mode 100644
index 3f6dfdedae..0000000000
--- a/hw/adc/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_STM32F2XX_ADC) += stm32f2xx_adc.o
diff --git a/hw/adc/meson.build b/hw/adc/meson.build
new file mode 100644
index 0000000000..2e7fea906e
--- /dev/null
+++ b/hw/adc/meson.build
@@ -0,0 +1 @@
+specific_ss.add(when: 'CONFIG_STM32F2XX_ADC', if_true: files('stm32f2xx_adc.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 624335be90..ffa3f06dc0 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('adc')
 subdir('audio')
 subdir('block')
 subdir('char')
-- 
2.21.0



