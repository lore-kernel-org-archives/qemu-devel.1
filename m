Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E37C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991B9207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6btbjtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991B9207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVga-00028Q-R0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6d-000236-0w
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6b-0005KM-KI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:54 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6b-0005IO-5o
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id f129so3582589wmf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vp0ZbOZIEBGYBbtolu8tVtbusC0ujkh32S2sGuGwqEE=;
 b=V6btbjtQiz5SCLOXDG2NjSlvBzVw2MjJQ7I/lHfOO9cWPDJVGmwqVicxBIT/ReYfZH
 wdudF2DZHvgYN+0jl196MmLo1VpZH+qjbTWMEOFIA8K11cRKOw3uXqOmnF6FgTTwRKte
 tCDuGzYrBxEn092WZMK1w3ncMWqw+eyZvqOQiTQWCTKhR01g/C6XDnEBSnZ3TvBud0D0
 nmiPNDViJLAkhcMFgLEMcFqhQ3wmYRv/UaYy1eX8wRtEuHRoA3myTUuu3/WocRpZwGnB
 8SnuXvDfF7keVfvgTP1MgqAfe3NYncjO01G26oicxKNDAOewPXzmX7bEcFIPEyGT3TDo
 e6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Vp0ZbOZIEBGYBbtolu8tVtbusC0ujkh32S2sGuGwqEE=;
 b=GxlIHTYqaWQG539I4O0dTDCs/Z/mBkGHVLfn3x2gDebrXHR0p1uDsq8NwpxPTWOL+a
 vmdnjTEeUAQ1+JXpZfodMaq/JlpV2ZMp8Jrx/3Tp599+0PLpu9MJCLmjqGyMrsgIulnq
 j1IwuNTwV1gWtPo8x1ILnkKYDPDW6xwc0znRnbZsRh8ZChxwgJxOAxE9aATA3+/7UHHz
 1g7zLGFvMpSvxisW0GmqDJbsFTitvE0hxGWufmT9JuT8kNKHXOB+lNKuJghQK8Jmt4E/
 57deApHmWb0zNVo6ReE92B12egQ3Dow17c8fNrOyY1jTPAEMA1aMuMyRLgHd4yDXOh7o
 DFMg==
X-Gm-Message-State: APjAAAWjBfghynTyk9RLhjPJ6xSfXBlEnlQbwnuO+CRvfn8K8Z6vDa1P
 Ys9ww+AeHNhTriUnNubrxonEAdmG
X-Google-Smtp-Source: APXvYqx/VCS61MXEM/fKKGJ1L7steaHjvnWBglhcwCi/nbHH9QZLlNHkDUye1Fm0ckgbwnUEsTMuBQ==
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr6264037wmd.10.1580234211486; 
 Tue, 28 Jan 2020 09:56:51 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 077/142] meson: convert hw/vfio
Date: Tue, 28 Jan 2020 18:52:37 +0100
Message-Id: <20200128175342.9066-78-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
 hw/Makefile.objs      |  1 -
 hw/meson.build        |  1 +
 hw/vfio/Makefile.objs |  7 -------
 hw/vfio/meson.build   | 17 +++++++++++++++++
 4 files changed, 18 insertions(+), 8 deletions(-)
 delete mode 100644 hw/vfio/Makefile.objs
 create mode 100644 hw/vfio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 742b310f13..cbd4e07fe5 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -31,7 +31,6 @@ devices-dirs-y += ssi/
 devices-dirs-y += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-y += usb/
-devices-dirs-$(CONFIG_VFIO) += vfio/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 8338fc4408..4dafc8a08e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,6 +3,7 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('vfio')
 subdir('virtio')
 subdir('watchdog')
 subdir('xen')
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
deleted file mode 100644
index abad8b818c..0000000000
--- a/hw/vfio/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-obj-y += common.o spapr.o
-obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
-obj-$(CONFIG_VFIO_CCW) += ccw.o
-obj-$(CONFIG_VFIO_PLATFORM) += platform.o
-obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
-obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
-obj-$(CONFIG_VFIO_AP) += ap.o
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
new file mode 100644
index 0000000000..b9a31caf74
--- /dev/null
+++ b/hw/vfio/meson.build
@@ -0,0 +1,17 @@
+vfio_ss = ss.source_set()
+vfio_ss.add(files(
+  'common.c',
+  'spapr.c',
+))
+vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
+  'display.c',
+  'pci-quirks.c',
+  'pci.c',
+))
+vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
+
+specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
-- 
2.21.0



