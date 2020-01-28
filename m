Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E35C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A054920716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaryJFVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A054920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVbk-0003DO-Rk
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6S-0001sk-6n
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6Q-00052s-Ud
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:44 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6Q-00051V-My
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:42 -0500
Received: by mail-wr1-x42d.google.com with SMTP id y11so17090386wrt.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m7Nsga+Walc3wf9WsUPgz6Xx/oHfn5CXHBfyicPoSug=;
 b=GaryJFVCYh3abT/plMozp5d3iB5PSaSM2E+IrbGa9K8fCnxSqjCwtL+llqdqJWX01J
 D2awxRfaWVenApPSnYluTZ7pS9La09lEA51D80QBl9J2HTHaNTzwAK1wCFMMk3wPwPNY
 adBTy1AJnjBq2sPn1U2hvUh9iQyDqEiL48qAdsjXIw2EefX4nl1owxo2kjQVZDAtLL+E
 iJ6p4SApHCc6cAxOe0pwEWD3mvg4DueNGDrYqM9dSj53D7yzBlXlF1N5qMHaVNzyI5Xf
 aUNnQzoeMYheCrGatTj5h97t1xTH0F5psARwTFeQoTI3JREX0q1osrStCCXOx6K9Cnix
 0I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=m7Nsga+Walc3wf9WsUPgz6Xx/oHfn5CXHBfyicPoSug=;
 b=c33uvkZzswpgYH8iMkrEvySvXXq1tOFekVcdk/9k3OQynQmBPOF0/c1Fb98tUeR3MQ
 gB+NCzFnQdpK3vS5ywrwQ5M5nFj+o1pMwyzFC2kKpw+EslNUY7PHmtGZbckR2+0fsEhN
 NQvj00Nfo8TJrBRHMNiB9fBw0d9+37HyDgqkDETt9MIPyrzm2X1tF8+UvtMIW/tUG23i
 Cwo5xZhg1h9AHeaydnqzv3OxKWmRnGOM275CBK85ohRKD8U4XaaaK7G4sPikcBSqtgsx
 567ZGQaj9XPwqBaVHKvsNkV4z7aTAyOb2qjHh0qLOgqDiV6XacbUnusgy3YxMAzDPT2p
 sWLg==
X-Gm-Message-State: APjAAAXJ73k59iZt9PQS3nYs+iH64gk1+BRxVS5X5CtNkIwBfZ0NOWBf
 uLJr3KGqNSxt1uIWyxtwEXnUIc6V
X-Google-Smtp-Source: APXvYqyoEeevhXZgsj1swi2uQFap8gCnTL/8nHjyKsij4zANkqvyynyafjaLNNgMgCztIS0uwifDtw==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr31549607wrp.12.1580234201606; 
 Tue, 28 Jan 2020 09:56:41 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 073/142] meson: convert hw/smbios
Date: Tue, 28 Jan 2020 18:52:33 +0100
Message-Id: <20200128175342.9066-74-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
 hw/Makefile.objs        |  1 -
 hw/meson.build          |  1 +
 hw/smbios/Makefile.objs | 10 ----------
 hw/smbios/meson.build   | 13 +++++++++++++
 4 files changed, 14 insertions(+), 11 deletions(-)
 delete mode 100644 hw/smbios/Makefile.objs
 create mode 100644 hw/smbios/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 29c4aa20b7..546da511a6 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
-devices-dirs-y += smbios/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 03ef30212e..dccc2d19a6 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
 subdir('nubus')
 subdir('semihosting')
+subdir('smbios')
 subdir('xen')
diff --git a/hw/smbios/Makefile.objs b/hw/smbios/Makefile.objs
deleted file mode 100644
index 23bb2bac07..0000000000
--- a/hw/smbios/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-ifeq ($(CONFIG_SMBIOS),y)
-common-obj-y += smbios.o
-common-obj-$(CONFIG_IPMI) += smbios_type_38.o
-common-obj-$(call lnot,$(CONFIG_IPMI)) += smbios_type_38-stub.o
-else
-common-obj-y += smbios-stub.o
-endif
-
-common-obj-$(CONFIG_ALL) += smbios-stub.o
-common-obj-$(CONFIG_ALL) += smbios_type_38-stub.o
diff --git a/hw/smbios/meson.build b/hw/smbios/meson.build
new file mode 100644
index 0000000000..9e762c7108
--- /dev/null
+++ b/hw/smbios/meson.build
@@ -0,0 +1,13 @@
+smbios_ss = ss.source_set()
+smbios_ss.add(files('smbios.c'))
+smbios_ss.add(when: 'CONFIG_IPMI',
+              if_true: files('smbios_type_38.c'),
+              if_false: files('smbios_type_38-stub.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_SMBIOS', if_true: smbios_ss)
+softmmu_ss.add(when: 'CONFIG_SMBIOS', if_false: files('smbios-stub.c'))
+
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files(
+  'smbios-stub.c',
+  'smbios_type_38-stub.c',
+))
-- 
2.21.0



