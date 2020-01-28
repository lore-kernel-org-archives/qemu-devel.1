Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342FEC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0769A2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKNujtlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0769A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVjK-0005eN-7J
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6e-000240-Ho
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6d-0005NI-60
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:56 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:36289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6c-0005Lo-UZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id p17so3582101wma.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d1gNPf5h8wDJ7z8q1b9EXIql8UIepdaFwczKd5fqkxg=;
 b=hKNujtlREdaMy/qtlJ8sEgqiS+W0UCO7UokDNzAcy2C+oVzOI3QX3AQVQNG7BFEhoA
 kGPWgn3T4a/0FrLXctyXxlLxkucXTq6M9l/Tc6XXSZM13ZtYmaklLooiPAW60+OF6zFi
 nW8LM1G3SrgsVj8mLrbZzXY2Z1L2JdOMas/8ZBW5L0TXYxz2U0JUS1GN4UkXqdrW5WBW
 dIKMOMUEpOdgwBsOGZKn2YVZ2i9cbRjI9NnjrSY3pMTmmRcrBusF1dwXGnZf0oaZXcTs
 I99f5s429rpUt5gmiGV2EjrlROwIo/9C4G+8ERVcCLgfSTWV6LmrX5fKvkKgKiXjGlzF
 gz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=d1gNPf5h8wDJ7z8q1b9EXIql8UIepdaFwczKd5fqkxg=;
 b=M2iaDtDU+DBs1v3YvS2cv5vYufziD+dzmDavFLlMR/yF+geq/oxCG9ClHEzvrlTQVh
 Qgqsu94Ft08J9AuSSOuhflEMouih6G3KKtpTsQ0Tyu0moC6im6bHPA1dCZt4UzOTyEww
 XYnqg2e1G0q4cSZPDp950SKw9fBv0+fT5SCcQ7LV29ffbUmDAgqBBZ9jFrPp9SdlX5cN
 0tAfdMWWK+0de/IXe+jUAQgDCyrcWfPY7T1KlefbVvEEg0ztFLY44k+SXjKdRc64cka7
 G1UtKSTfjvcZXP4n8Ni0x9mwJtVzlVOSfjqW8NqHmwhmi+9dGGN/3qKlik0gNoohuCUT
 K0ZA==
X-Gm-Message-State: APjAAAVLWOY/yUmbD7qY10OJOXAL2Ze1+qN1CQhg1CSRQvSWvYhXJCtf
 7cKvmCE44He04jjycWV7QPXLN01Q
X-Google-Smtp-Source: APXvYqyH7trQ1KHvw1Sv4zuUpN5Zl+5bZv/DoDppa6Etv8p4W5u7+pLHZlH4BZxogWlf1joZGHNNrg==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr6193364wme.53.1580234213477; 
 Tue, 28 Jan 2020 09:56:53 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 078/142] meson: convert hw/usb
Date: Tue, 28 Jan 2020 18:52:38 +0100
Message-Id: <20200128175342.9066-79-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
 Makefile.target    |  1 +
 hw/Makefile.objs   |  1 -
 hw/meson.build     |  1 +
 hw/usb/meson.build | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 meson.build        | 15 +++++++++++++
 5 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 hw/usb/meson.build

diff --git a/Makefile.target b/Makefile.target
index 15e7c861f2..ea6f485675 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -169,6 +169,7 @@ endif
 LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
+LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index cbd4e07fe5..72f808f8ec 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -30,7 +30,6 @@ devices-dirs-y += sd/
 devices-dirs-y += ssi/
 devices-dirs-y += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
-devices-dirs-y += usb/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 4dafc8a08e..89bd6adb70 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,6 +3,7 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('usb')
 subdir('vfio')
 subdir('virtio')
 subdir('watchdog')
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
new file mode 100644
index 0000000000..0cf91bea45
--- /dev/null
+++ b/hw/usb/meson.build
@@ -0,0 +1,53 @@
+# usb subsystem core
+softmmu_ss.add(files(
+  'bus.c',
+  'combined-packet.c',
+  'core.c',
+  'libhw.c'
+))
+
+softmmu_ss.add(when: 'CONFIG_USB', if_true: files(
+  'desc.c',
+  'desc-msos.c',
+))
+
+# usb host adapters
+softmmu_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_OHCI', if_true: files('hcd-ohci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_EHCI', if_true: files('hcd-ehci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci.c', 'hcd-ehci-sysbus.c'))
+softmmu_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
+softmmu_ss.add(when: 'CONFIG_USB_MUSB', if_true: files('hcd-musb.c'))
+
+specific_ss.add(when: 'CONFIG_TUSB6010', if_true: files('tusb6010.c'))
+specific_ss.add(when: 'CONFIG_IMX', if_true: files('chipidea.c'))
+
+# emulated usb devices
+softmmu_ss.add(when: 'CONFIG_USB', if_true: files('dev-hub.c'))
+softmmu_ss.add(when: 'CONFIG_USB', if_true: files('dev-hid.c'))
+softmmu_ss.add(when: 'CONFIG_USB_TABLET_WACOM', if_true: files('dev-wacom.c'))
+softmmu_ss.add(when: 'CONFIG_USB_STORAGE_BOT', if_true: files('dev-storage.c'))
+softmmu_ss.add(when: 'CONFIG_USB_STORAGE_UAS', if_true: files('dev-uas.c'))
+softmmu_ss.add(when: 'CONFIG_USB_AUDIO', if_true: files('dev-audio.c'))
+softmmu_ss.add(when: 'CONFIG_USB_SERIAL', if_true: files('dev-serial.c'))
+softmmu_ss.add(when: 'CONFIG_USB_NETWORK', if_true: files('dev-network.c'))
+
+softmmu_ss.add(when: 'CONFIG_USB_SMARTCARD', if_true: files('dev-smartcard-reader.c'))
+softmmu_ss.add(when: ['CONFIG_USB_SMARTCARD', 'CONFIG_SMARTCARD', cacard], if_true: files(
+  'ccid-card-emulated.c',
+  'ccid-card-passthru.c',
+))
+
+softmmu_ss.add(when: ['CONFIG_POSIX', 'CONFIG_USB_STORAGE_MTP'], if_true: files('dev-mtp.c'))
+
+# usb redirect
+softmmu_ss.add(when: [usbredir, 'CONFIG_USB_REDIR'], if_true: files('redirect.c', 'quirks.c'))
+
+# usb pass-through
+softmmu_ss.add(when: [libusb, 'CONFIG_USB_LIBUSB'], if_true: files('host-libusb.c'), if_false: files('host-stub.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('host-stub.c'))
+
+softmmu_ss.add(when: [libusb, 'CONFIG_XEN'], if_true: files('xen-usb.c'))
diff --git a/meson.build b/meson.build
index 583c42ccf5..0c61aa5cd4 100644
--- a/meson.build
+++ b/meson.build
@@ -299,6 +299,21 @@ if 'CONFIG_XEN_BACKEND' in config_host
   xen = declare_dependency(compile_args: config_host['XEN_CFLAGS'].split(),
                            link_args: config_host['XEN_LIBS'].split())
 endif
+cacard = declare_dependency()
+if 'CONFIG_SMARTCARD' in config_host
+  cacard = declare_dependency(compile_args: config_host['SMARTCARD_CFLAGS'].split(),
+                              link_args: config_host['SMARTCARD_LIBS'].split())
+endif
+usbredir = declare_dependency()
+if 'CONFIG_USB_REDIR' in config_host
+  usbredir = declare_dependency(compile_args: config_host['USB_REDIR_CFLAGS'].split(),
+                                link_args: config_host['USB_REDIR_LIBS'].split())
+endif
+libusb = declare_dependency()
+if 'CONFIG_USB_LIBUSB' in config_host
+  libusb = declare_dependency(compile_args: config_host['LIBUSB_CFLAGS'].split(),
+                              link_args: config_host['LIBUSB_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
-- 
2.21.0



