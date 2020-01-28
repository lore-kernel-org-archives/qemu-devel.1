Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29677C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF4D207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOG8gFL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF4D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVlt-00012V-3K
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6p-00027q-6r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6n-0005eo-2R
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:07 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6l-0005aP-Rt
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id f129so3583030wmf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d8v5bRzec34yfkf1QOj74f3k3RNnmyYBfKj/VWRJGh0=;
 b=AOG8gFL2aUs+0fmtmQCWVOuKUsR7Rd8LFFBIKLnPDFdAsEnQ3IZwWnSiVULiQxTeKy
 TprEzk2n24K6SmMfKoYnmCmua089DHptLbX10OMSRbZm1uoGrZAng/iO4UFZlkToF4VW
 LccfrQ8xt8otlGqFvg78CQeLNLEwgxHHsvpEe+pdltI7W6D+T2DW+B4i3p1kiDqRsOKM
 /uSHe4qnFlpZ60Ov3Elz0F+7H3/0yCYc+Oje0fOTAmgfwk4ItDbI6W98AoX6Mnpvf7gh
 olNfl4GKgBgoAoI5p6qkPTPKT+ZrtVc388Ob8dNaZIOQ7bD5+NBqnvSZiJKFaK6LLpcT
 4lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=d8v5bRzec34yfkf1QOj74f3k3RNnmyYBfKj/VWRJGh0=;
 b=jYoxenCrLkAfyO3b31DweWLh/7Rl+O1H1CD3v6K1Wt6zhEO7cuhGi3pVjJ7Gq90gp7
 E8slbRusVHE0lMA3sUI6jYIdEC7dkxROKsCPqYmBpl3drG3M3zPcitTlpNAm++A9upAG
 DWBEb39ntPTYFbQEbEo2JZ4ccOdR7xzgntfgRFIdH/uCXvp4bYPTr16+K241UCIbRRil
 4+xZkgNOlCXDVwYzzFCeNV6MxvibDP3G+6ZSRXZ9qnWTwGSIo3kuugaEnQAcHvryTzoq
 1v0uHhSapk/PU8a2Tgoo2lpNmBEA7fLyoahhiRKKY7F1pqebgi1d0qJen2pa0zIZ7OHu
 +9Mw==
X-Gm-Message-State: APjAAAWOk/3XxQHXMFYkaQWHL4UHl74rW1rGJc/aJfCTVNsLYDfASu5r
 Ve+0l/xC5Z4mf1SC1p0CTnqQNDOb
X-Google-Smtp-Source: APXvYqzC3+/UX5xBMv0XUbQd0XWBkGSjTvttFXlRVi4lUd69+CH6WANvmkk7t223JzUextwJNtgpTQ==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr6504771wmc.126.1580234220762; 
 Tue, 28 Jan 2020 09:57:00 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 081/142] meson: convert hw/rtc
Date: Tue, 28 Jan 2020 18:52:41 +0100
Message-Id: <20200128175342.9066-82-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/rtc/Makefile.objs | 13 -------------
 hw/rtc/meson.build   | 14 ++++++++++++++
 4 files changed, 15 insertions(+), 14 deletions(-)
 delete mode 100644 hw/rtc/Makefile.objs
 create mode 100644 hw/rtc/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 9df81ac96e..6152f8074b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -24,7 +24,6 @@ devices-dirs-y += nvram/
 devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
-devices-dirs-y += rtc/
 devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
 devices-dirs-y += ssi/
diff --git a/hw/meson.build b/hw/meson.build
index 50b26db852..1fb1687e1e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('rtc')
 subdir('semihosting')
 subdir('smbios')
 subdir('timer')
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
deleted file mode 100644
index 8dc9fcd3a9..0000000000
--- a/hw/rtc/Makefile.objs
+++ /dev/null
@@ -1,13 +0,0 @@
-common-obj-$(CONFIG_DS1338) += ds1338.o
-common-obj-$(CONFIG_M41T80) += m41t80.o
-common-obj-$(CONFIG_M48T59) += m48t59.o
-ifeq ($(CONFIG_ISA_BUS),y)
-common-obj-$(CONFIG_M48T59) += m48t59-isa.o
-endif
-common-obj-$(CONFIG_PL031) += pl031.o
-common-obj-$(CONFIG_TWL92230) += twl92230.o
-common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
-common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
-obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
-common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_rtc.o
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
new file mode 100644
index 0000000000..665a539a37
--- /dev/null
+++ b/hw/rtc/meson.build
@@ -0,0 +1,14 @@
+
+softmmu_ss.add(when: 'CONFIG_DS1338', if_true: files('ds1338.c'))
+softmmu_ss.add(when: 'CONFIG_M41T80', if_true: files('m41t80.c'))
+softmmu_ss.add(when: 'CONFIG_M48T59', if_true: files('m48t59.c'))
+softmmu_ss.add(when: 'CONFIG_PL031', if_true: files('pl031.c'))
+softmmu_ss.add(when: 'CONFIG_TWL92230', if_true: files('twl92230.c'))
+softmmu_ss.add(when: ['CONFIG_ISA_BUS', 'CONFIG_M48T59'], if_true: files('m48t59-isa.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-rtc.c'))
+
+softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_rtc.c'))
+softmmu_ss.add(when: 'CONFIG_SUN4V_RTC', if_true: files('sun4v-rtc.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_rtc.c'))
+
+specific_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
-- 
2.21.0



