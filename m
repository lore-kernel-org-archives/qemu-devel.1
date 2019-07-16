Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75DEC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996542145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxNAqCLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996542145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIbt-0005QO-4n
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60093)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYk-0000HV-1p
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYi-0003M0-Iy
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYi-0003Kp-Ap
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id f17so17655287wme.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tYkWxfQocQcN4T6E1ktela7goxtlWdSVxpbi0ybM8Vc=;
 b=ZxNAqCLSLenzrnbhdYFkfhEVqNVdYP93iRmmJPABl34bIqqWbc8IuCIOBq0PEtAUIG
 rM8t0knCQSUtOYAAfX30UEA/tSCXpN1kfBXgqpB+ub5Tts3w6pUnfrY/3/vkc7XghbTU
 7ddnGbCLj6nQQJW088/1h+TzSZeRnY/M9tPaL5bKSoLwNR1HD8yYG7bz/chiLhg/WmvZ
 sgfRikyejospHBFaOhRNmz7FR699dcYYxRFIJI890G+psCBG7dcY79aK+1L7X9pme0Lw
 txy5IP3A86liJM3kAsvjhfrT6iZKIkC93/LfJgCNDZyZdxSjJDbUt0OyRcOlgDw8oZfA
 IYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tYkWxfQocQcN4T6E1ktela7goxtlWdSVxpbi0ybM8Vc=;
 b=tj3+B/KE44LHk061y4MSXfL14wg9K5eHAkeT21amZx6a4hRLMqz6IlJDMyKxKp2Cc2
 SxoN/DW85uOl0fvtT032/lR0/tcN0+Kv6jl6n7wfEiNIWX/3no+8WWE3kiN0whSno67L
 JOKl8wbgJX3GAUDAUhk4WhsGy2Hwf1tZCWg4wbD2URehPyFWSugS7mTEIpegtbYlaEoy
 BknG6tT2vA44R+86ZJYJGWViuUeYrCwiWWrx1eBEnkyIyCCJ62hnx1KPju7Hy/BaxER8
 VhQp3JQvL3l2/eGAdu/DC0DjfRfSvlXMkDnkqkiiTiSExtrzwNFOx1t0FMBnJcR1uGlU
 ISGA==
X-Gm-Message-State: APjAAAUhL+9Ln2HDaHhb7xR5ldO7gREpTePmm0XiDNWu7Fchd1bx4f87
 seIlxZ/lUsl/J98r0iBUezkaK8nhUEw=
X-Google-Smtp-Source: APXvYqx+qJp+GwXKxpc/EQlA8LVrkxXJqC8kmmig1xa65GIDldhueeG6+VlxB5n8uPzEMOZVjyuPwQ==
X-Received: by 2002:a1c:a5c2:: with SMTP id
 o185mr28528112wme.172.1563264695019; 
 Tue, 16 Jul 2019 01:11:35 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:13 +0200
Message-Id: <1563264677-39718-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 15/19] hw/usb/Kconfig: Add CONFIG_USB_EHCI_PCI
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The USB_EHCI entry currently include PCI code. Since the EHCI
implementation is already split in sysbus/PCI, add a new
USB_EHCI_PCI. There are no logical changes, but the Kconfig
dependencies tree is cleaner.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/Kconfig       | 9 ++++++---
 hw/usb/Makefile.objs | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 564305e..495c6f2 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -19,13 +19,16 @@ config USB_OHCI_PCI
 
 config USB_EHCI
     bool
-    default y if PCI_DEVICES
-    depends on PCI
     select USB
 
+config USB_EHCI_PCI
+    bool
+    default y if PCI_DEVICES
+    select USB_EHCI
+
 config USB_EHCI_SYSBUS
     bool
-    select USB
+    select USB_EHCI
 
 config USB_XHCI
     bool
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 81688f6..303ac08 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -6,8 +6,9 @@ common-obj-$(CONFIG_USB) += desc.o desc-msos.o
 common-obj-$(CONFIG_USB_UHCI) += hcd-uhci.o
 common-obj-$(CONFIG_USB_OHCI) += hcd-ohci.o
 common-obj-$(CONFIG_USB_OHCI_PCI) += hcd-ohci-pci.o
-common-obj-$(CONFIG_USB_EHCI) += hcd-ehci.o hcd-ehci-pci.o
-common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci.o hcd-ehci-sysbus.o
+common-obj-$(CONFIG_USB_EHCI) += hcd-ehci.o
+common-obj-$(CONFIG_USB_EHCI_PCI) += hcd-ehci-pci.o
+common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
 common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
-- 
1.8.3.1



