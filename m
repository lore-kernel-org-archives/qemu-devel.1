Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1261C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E52A2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdeyUl7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E52A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOqn-0004oY-Bt
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz3-0004a6-GB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz2-00084X-9D
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:21 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNz2-00083V-2F
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id w15so2627654wru.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f04wqxzvz6vmNitqs9qCctC0F90gACS660EYcjH2fbc=;
 b=gdeyUl7YImDpzWo98PSMUMyXIpGxpXGjRLEwx2k9VAYwQ+g0TRoAMjYUVWi9w+K9kU
 hcxKEdDJEY38r4QliP+bIah0YWI/Rt/Xt5pf6i8v7oVF91gnCIoRZwF3SRMNyb76HKK0
 hu2y+vhg85F9JqEDyjPoarNIzFRQ7XH4rmRCTCTMIVzIAu/E2bQIuo9j0Glq98xzLzLA
 ZKuHRqUcj8LaLq5jtDcxp7SS2XJP+J1/LavfsBpOpbxd0FhgK5KMQZyfHWGZE6kEZNoz
 QlfDcjZrrZy/uDRkRe/knL/4/4WRWwEnD9/B+UjxwT/sBFQrn+K8dxb+5S+jY5nQaNqc
 iB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f04wqxzvz6vmNitqs9qCctC0F90gACS660EYcjH2fbc=;
 b=nkRQqOants11kkv6NMc8yi3kcGBN0fOjBC56r4lT8ix4ukoh5wkEiYI5wbAtwI7vEe
 0bZkWx6P2/IOmznlg3QsX/Piqslcy+DfpLrEtaoO/HiCFuN5QpB0+BwGlJ73+2ETWAm3
 DtWTm3r55hprQwwnvb+Avf5rQB/SROY8GtrGud+bRxFT41OH4RUDKWZa36HyrCuChkBL
 m6A1PdpqGHGFoGqcsSE4XY2nvi15QIwEnjU7G0H1qREV3uIbZI4oaMU3GEEpJ+ss7GYV
 VQxp0CFIwVd+2IamDcDdOffi1rIeLC7a1tsphmxv9obE+zQ4P0RT+w8IFEWKo372e3fk
 L2yQ==
X-Gm-Message-State: APjAAAW7+7Ikjj2lQsIUrD4Yo8pzWa41M+1tFdjLLkRcxHZiFFTbMv5+
 G8d2T/x8EyB0Wq9DXhEFcneST4lT
X-Google-Smtp-Source: APXvYqyU1gG4AULMpjCycLbtI+LYlPgT0Ysencj90hR2OFBJv0MK1HbCVdtoxwaIBbhkc2+n1zTnww==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr6067114wrx.393.1576155258893; 
 Thu, 12 Dec 2019 04:54:18 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 081/132] meson: convert hw/nvram
Date: Thu, 12 Dec 2019 13:52:05 +0100
Message-Id: <1576155176-2464-82-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 hw/Makefile.objs       |  1 -
 hw/meson.build         |  1 +
 hw/nvram/Makefile.objs |  8 --------
 hw/nvram/meson.build   | 11 +++++++++++
 4 files changed, 12 insertions(+), 9 deletions(-)
 delete mode 100644 hw/nvram/Makefile.objs
 create mode 100644 hw/nvram/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 512d10d..6ce70d5 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -21,7 +21,6 @@ devices-dirs-y += isa/
 devices-dirs-y += misc/
 devices-dirs-y += net/
 devices-dirs-y += rdma/
-devices-dirs-y += nvram/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 1fd9eb5..0c528e5 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('nvram')
 subdir('pci')
 subdir('pci-bridge')
 subdir('pci-host')
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
deleted file mode 100644
index 26f7b4c..0000000
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
index 0000000..75fca7b
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
1.8.3.1



