Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C126C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA8D207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBIVJCzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA8D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVeC-000730-B6
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6W-00021G-IK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6V-0005AZ-DR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:48 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:56067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6V-00058y-5z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id q9so3491722wmj.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rMmxgyGCK3HTQI8GNZelCdY94AvBq67a6Ic8G295BbI=;
 b=jBIVJCzVxlFpbCThx7EQusHzGrC8XMgT8OWIlH+7LgUifljkqTtwo7DOunYX0XY9N+
 uFfniTOsU9EnH9Solj+S99bPP0cZSS5HY4IZBOa769+AtGnwpU8lSNr7PNv69SvM84TP
 SVuPPXd8Gtuu/MenFa1Lo1HIeKC5NuVUW5zJ90GfnnJZY8HXs8xyl+/yIaJtPibMIkzi
 5i9P6nA7YH8aThX8WodtqssKRCBenOz8HXbAnJXxJYcv+WjQdsTH3MiYb5UjPy33z8SR
 eQyUPNs5Jzglnr0DRHSBwpfc/VFrgdEy9sIk7ZCSwPV0x7gToR3ufdwfwo9nk1ATdtKs
 ggZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rMmxgyGCK3HTQI8GNZelCdY94AvBq67a6Ic8G295BbI=;
 b=lRl2B4ATnSzSQGtpGXXRXiKJhpxuMlT0euE1Mnz2RVDyfvxs1zzzP6EYErx4+3ICOc
 FK7XGUQZnSpyjapo48JrFeDDMw7OfNHqb3YM9SL2XfK2PjZ7SRexkLQ02lTEix0PZJ3L
 IufvSszuQjB3HkW4V/Vlr89TQzQ7KNbYLJa5W2JAiNQVWYOiGML5Jatzmc8so8Z57EHX
 wXl606hxatxgu36m7ZMrCJaEme2KYSvk38Ny18r8vNlOYyJxvu7QHQ7HqddKlD+jON8B
 kb3PiwBeVdA7w9BQOg9F8K6KQcMShPR05qjImGuyeTOwSk8sAJKYlb2MjoS6oSiJJX2p
 whFg==
X-Gm-Message-State: APjAAAWFbO27zE5maJZNw+lcraG4MIaWo0hxM8DHIUAZ+3PUIJNAMeTU
 jiV7btDrNXUuelyeouMt4pqiC/tu
X-Google-Smtp-Source: APXvYqzHe0A5aBEegu+iLx5cr2qa/F3G7SddwRO9t77Le2dq6khpj4oFPIAIBjTwvGeEjd4Z1fhW7Q==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr6186224wmi.14.1580234206084;
 Tue, 28 Jan 2020 09:56:46 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 075/142] meson: convert hw/watchdog
Date: Tue, 28 Jan 2020 18:52:35 +0100
Message-Id: <20200128175342.9066-76-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs          | 1 -
 hw/meson.build            | 1 +
 hw/watchdog/Makefile.objs | 6 ------
 hw/watchdog/meson.build   | 6 ++++++
 4 files changed, 7 insertions(+), 7 deletions(-)
 delete mode 100644 hw/watchdog/Makefile.objs
 create mode 100644 hw/watchdog/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 636c4f1fed..9232919ac3 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -33,7 +33,6 @@ devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
-devices-dirs-y += watchdog/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 542d675618..f2209d900c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,4 +3,5 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('watchdog')
 subdir('xen')
diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
deleted file mode 100644
index 3f536d1cad..0000000000
--- a/hw/watchdog/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-common-obj-y += watchdog.o
-common-obj-$(CONFIG_CMSDK_APB_WATCHDOG) += cmsdk-apb-watchdog.o
-common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
-common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
-common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
-common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
new file mode 100644
index 0000000000..eafb57b6a9
--- /dev/null
+++ b/hw/watchdog/meson.build
@@ -0,0 +1,6 @@
+softmmu_ss.add(files('watchdog.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_WATCHDOG', if_true: files('cmsdk-apb-watchdog.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_IB6300ESB', if_true: files('wdt_i6300esb.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
-- 
2.21.0



