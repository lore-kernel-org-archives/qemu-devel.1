Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43756C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E31C2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3eRDAxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E31C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOl7-00009Y-P3
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyu-0004M9-Iv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNys-0007oG-NN
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:12 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNys-0007ma-DA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:10 -0500
Received: by mail-wr1-x432.google.com with SMTP id z7so2570167wrl.13
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yg3Elyi3GPZ8zbUi+6JN6FhWHgdSQqQQaYWdguPJkKE=;
 b=u3eRDAxsXGtI7/3t2JhiWO88FGpBTaOIz+yGvErCQqyb8KFEpvOWAjNJjq61ye94CH
 eXk6gdmp+oBE0APzDqsCeaLFwn8z65IxKDSV2V4+mYbpiH5jTwiCoj+VvC1UknHB+bsN
 HavnEiQYlkYdMMbbtjA154OwEeGHuAP+CMkFtxRGS4GPUALQYPa4f0iWls4m0q3j6iNt
 Y/Nn5eGG9YC0a96uInPUPYiNCkxrelN3KwEr6p9OnA37DpINBtY03cf7B8pP9vDFLFs1
 /4wLSiZoj4DgZL54BiVQuMxUxBycOeokd7F1maGDjfezuK8c3OmgsFEA/hUNiJ5zcVU9
 +M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Yg3Elyi3GPZ8zbUi+6JN6FhWHgdSQqQQaYWdguPJkKE=;
 b=LA3iMVX/cPk8XIJ4t6zoIHTuC7uVBmTeG/5+KgY5Z4awsXX+6s1/Kj+U0w/tj0ZMjW
 6lmsowCv1RbUKU0PUpJLINwMkUdkXl7Fq+CglE57LHnbgFyx7dpX7chbHBvi8i97g7HL
 HH4Or1pWDspVS9dyX6zMvsx9lcn+xTLBqaFgTBjAZ2ojzo6FBP3FimF9UoBfVNdJ6DTK
 YkDXdEHJKStAjkN1yB6mmHQv8dZ3yh3rMobDUBYF5PwGXatZzyy3RtRLg2UdYnz2MGV+
 QgfPRWNtlEahEdQx3h+u0BUkCTrA9c5YPbOXBisN9NVk5k4e+FkQmyOHGXHpT9SADW9/
 1B3w==
X-Gm-Message-State: APjAAAXf9iX5g7Pzyjvhl2/Cpa68OjfH0foqSb1s/qgFuMdXLKsS/bkh
 ygnYg61ZOs+RMFZzNZ0rORqdYWhz
X-Google-Smtp-Source: APXvYqwl93pb8GFvX9aN9s+30WXVX7tFKBfAD4UW80VndjO24scT3hxO+u0BEU59W+T8mBLOBCvt7g==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr6276768wrc.175.1576155249143; 
 Thu, 12 Dec 2019 04:54:09 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 071/132] meson: convert hw/usb
Date: Thu, 12 Dec 2019 13:51:55 +0100
Message-Id: <1576155176-2464-72-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
 Makefile.target      |  1 +
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/usb/Makefile.objs | 62 ----------------------------------------------------
 hw/usb/meson.build   | 54 +++++++++++++++++++++++++++++++++++++++++++++
 meson.build          | 15 +++++++++++++
 6 files changed, 71 insertions(+), 63 deletions(-)
 delete mode 100644 hw/usb/Makefile.objs
 create mode 100644 hw/usb/meson.build

diff --git a/Makefile.target b/Makefile.target
index c2fcb22..a41e4e5 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -167,6 +167,7 @@ endif
 LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
+LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index d0c817b..df804a0 100644
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
index 16c0abd..43797f9 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,6 +2,7 @@ subdir('core')
 subdir('mem')
 subdir('semihosting')
 subdir('smbios')
+subdir('usb')
 subdir('vfio')
 subdir('virtio')
 subdir('watchdog')
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
deleted file mode 100644
index 303ac08..0000000
--- a/hw/usb/Makefile.objs
+++ /dev/null
@@ -1,62 +0,0 @@
-# usb subsystem core
-common-obj-y += core.o combined-packet.o bus.o libhw.o
-common-obj-$(CONFIG_USB) += desc.o desc-msos.o
-
-# usb host adapters
-common-obj-$(CONFIG_USB_UHCI) += hcd-uhci.o
-common-obj-$(CONFIG_USB_OHCI) += hcd-ohci.o
-common-obj-$(CONFIG_USB_OHCI_PCI) += hcd-ohci-pci.o
-common-obj-$(CONFIG_USB_EHCI) += hcd-ehci.o
-common-obj-$(CONFIG_USB_EHCI_PCI) += hcd-ehci-pci.o
-common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
-common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
-common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
-common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
-
-obj-$(CONFIG_TUSB6010) += tusb6010.o
-obj-$(CONFIG_IMX)      += chipidea.o
-
-# emulated usb devices
-common-obj-$(CONFIG_USB) += dev-hub.o
-common-obj-$(CONFIG_USB) += dev-hid.o
-common-obj-$(CONFIG_USB_TABLET_WACOM) += dev-wacom.o
-common-obj-$(CONFIG_USB_STORAGE_BOT)  += dev-storage.o
-common-obj-$(CONFIG_USB_STORAGE_UAS)  += dev-uas.o
-common-obj-$(CONFIG_USB_AUDIO)        += dev-audio.o
-common-obj-$(CONFIG_USB_SERIAL)       += dev-serial.o
-common-obj-$(CONFIG_USB_NETWORK)      += dev-network.o
-common-obj-$(CONFIG_USB_BLUETOOTH)    += dev-bluetooth.o
-
-ifeq ($(CONFIG_USB_SMARTCARD),y)
-common-obj-y                          += dev-smartcard-reader.o
-common-obj-$(CONFIG_SMARTCARD)        += smartcard.mo
-smartcard.mo-objs := ccid-card-passthru.o ccid-card-emulated.o
-smartcard.mo-cflags := $(SMARTCARD_CFLAGS)
-smartcard.mo-libs := $(SMARTCARD_LIBS)
-endif
-
-ifeq ($(CONFIG_POSIX),y)
-common-obj-$(CONFIG_USB_STORAGE_MTP)  += dev-mtp.o
-endif
-
-# usb redirection
-common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
-redirect.o-cflags = $(USB_REDIR_CFLAGS)
-redirect.o-libs = $(USB_REDIR_LIBS)
-
-# usb pass-through
-ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
-common-obj-y += host-libusb.o
-else
-common-obj-y += host-stub.o
-endif
-common-obj-$(CONFIG_ALL) += host-stub.o
-
-host-libusb.o-cflags := $(LIBUSB_CFLAGS)
-host-libusb.o-libs := $(LIBUSB_LIBS)
-
-ifeq ($(CONFIG_USB_LIBUSB),y)
-common-obj-$(CONFIG_XEN) += xen-usb.o
-xen-usb.o-cflags := $(LIBUSB_CFLAGS)
-xen-usb.o-libs := $(LIBUSB_LIBS)
-endif
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
new file mode 100644
index 0000000..8292256
--- /dev/null
+++ b/hw/usb/meson.build
@@ -0,0 +1,54 @@
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
+softmmu_ss.add(when: 'CONFIG_USB_BLUETOOTH', if_true: files('dev-bluetooth.c'))
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
index f1c5e7a..58bc25c 100644
--- a/meson.build
+++ b/meson.build
@@ -300,6 +300,21 @@ if 'CONFIG_XEN_BACKEND' in config_host
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
1.8.3.1



