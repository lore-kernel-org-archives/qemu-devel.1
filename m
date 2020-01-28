Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0683C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF2F2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrrTjGT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF2F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWQR-00077v-UB
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV73-0002c5-KI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV72-0006P4-Ea
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:21 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV72-0006KH-6S
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:20 -0500
Received: by mail-wr1-x434.google.com with SMTP id y11so17092615wrt.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W41DdWEFwizuRfaoKAqL7nttmrqY2CyAtnYYue+m/GY=;
 b=KrrTjGT9eU4oH43XKk9ZzthUuNF7JVKJ1LFUnbee0UtHnSQCf38rTi0yNqAYNRxqSD
 am2jePWa7GV8NFwBvuq7yLI80CwTboasqzcRQ45M/TGajBJTLaBKygePtj044zUM9uPv
 AY3y4U85Jxfpe5bqfHV6E2BXGXGKZnaMiAp+MD3hnzbPd1U1imPjfl09RgMHOo8R4pAA
 0Y1pdQlNFbxmmHm/YzUG9OITVTR/bhQExvH2+WUhphtdC5isaLkLj8FuHWVL07A6qOIt
 jTkqQv4tXrf0Dg+MvaOspnGS/IUu+wNUWxvosHFmKBIXWC6r/dJNi9eYUT7ckRhJlE7A
 HloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W41DdWEFwizuRfaoKAqL7nttmrqY2CyAtnYYue+m/GY=;
 b=YhgWe+y5xa4f12MxGeNKHya5b8Ei1AmJOt88ZVF7UXrN5Lrn4yC0pL8DTgoC9II6lV
 OGcvwv89YGO/j7S8Pnp95H9CTZx+euQRF8JUGbhU3y1qofYFzb9HA3wQSeqHm5QfcBPu
 MFyEvQS9nl1Ug7eQMY4wf/lp33eKO8Foels2fv28V28or5S4w+16mBHppP68M2o4Cm/B
 Fs4qWrrs2/yGEFPMYNoSJdzQWlNbhk8yPFIUaYSK36J+0ZapASB7yvoyCVMDoPV/Y77/
 ljCFbD/zGYxr8HUhaoUdvJlMHB1rQzyBd8V/XhND5F0G8fPafDgIc1fT6nSEC9wrJt4Q
 e5Zg==
X-Gm-Message-State: APjAAAUyOesLeONkt/9jcYcPVfWC7zJi6HvOxpjT0SgnsJBDgcb3KUnW
 e3CaP8SSQg2Ne2s32bemU1MEk4BW
X-Google-Smtp-Source: APXvYqws3eTp7z63cFjtZZ0cFdItWcsTbI4LTJjeRZUCWyl46yKMyFK212C6EPnEHrTZiT8DuO9smQ==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr32015320wrv.0.1580234238077;
 Tue, 28 Jan 2020 09:57:18 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 089/142] meson: convert hw/nvram
Date: Tue, 28 Jan 2020 18:52:49 +0100
Message-Id: <20200128175342.9066-90-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 hw/Makefile.objs       |  1 -
 hw/meson.build         |  1 +
 hw/nvram/Makefile.objs |  8 --------
 hw/nvram/meson.build   | 11 +++++++++++
 4 files changed, 12 insertions(+), 9 deletions(-)
 delete mode 100644 hw/nvram/Makefile.objs
 create mode 100644 hw/nvram/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index cad6354eae..951d451b77 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -20,7 +20,6 @@ devices-dirs-y += isa/
 devices-dirs-y += misc/
 devices-dirs-y += net/
 devices-dirs-y += rdma/
-devices-dirs-y += nvram/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 53c347c395..0bdd6a2613 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('nvram')
 subdir('pci')
 subdir('pci-bridge')
 subdir('pci-host')
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
deleted file mode 100644
index 26f7b4ca35..0000000000
--- a/hw/nvram/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-common-obj-$(CONFIG_DS1225Y) += ds1225y.o
-common-obj-y += eeprom93xx.o
-common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
-common-obj-y += fw_cfg.o
-common-obj-y += chrp_nvram.o
-common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
-obj-$(CONFIG_PSERIES) += spapr_nvram.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
new file mode 100644
index 0000000000..75fca7b939
--- /dev/null
+++ b/hw/nvram/meson.build
@@ -0,0 +1,11 @@
+softmmu_ss.add(files(
+  'chrp_nvram.c',
+  'eeprom93xx.c',
+  'fw_cfg.c',
+))
+softmmu_ss.add(when: 'CONFIG_AT24C', if_true: files('eeprom_at24c.c'))
+softmmu_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
+softmmu_ss.add(when: 'CONFIG_MAC_NVRAM', if_true: files('mac_nvram.c'))
+
+specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
+specific_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_nvm.c'))
-- 
2.21.0



