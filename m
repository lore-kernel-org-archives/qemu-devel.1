Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC95C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504252467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrsHSgFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504252467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVvp-0000NU-Fi
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6r-0002CQ-1W
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6p-0005lK-S3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:08 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6p-0005f1-Kb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:07 -0500
Received: by mail-wr1-x444.google.com with SMTP id j104so1202229wrj.7
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AcA80Oa9glsB9Xn7cH9me7kaQhwthAOTPazgC6s1fw8=;
 b=NrsHSgFa8uoc5/W3Uv3nq2HJk6pB4f/1Oehf8qGn4vbDzk1EaV1qIqKMIG+XaEj6hy
 LQ3yq/jo3hOlDoVDBeAXbc2H4hFQf0YqZ5n7mBn8iHteNFbVRqGtLzNIUWJarYLwJxR+
 bmEfwtcaBgdowW8+3ykHHTpsLeq2bt6jGNTEjGUNVt3EN0SQzZE+sRrUZoZhdfg88YYV
 N8EDXTsiTb7MXfFokdbnUb8+0yqOtd+228qdMiAK1a1aClW1Ss9vu4xr88UtAWc9jC16
 0W161G95mjjibc7lXaHpTKcgRVnSploFOEBxnDx6cca6Baj/MPP0h+pXeei97ANOvvom
 h3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AcA80Oa9glsB9Xn7cH9me7kaQhwthAOTPazgC6s1fw8=;
 b=Y8crLzuBrRtutxbW7rMa4R2I9YokqvqDg/Wq3mXay+sUmzavFA0JZjWIUZfkHLWcWx
 lfnahk5VABSyfW32upx6O2G9MdqCsMjXBkWqbkq9I+QCjSk1Af8P08kj9lnYzYGdv73A
 Tx7WkF5I5SVDHRikTHfacn64s0EPAmC730oPFwDlgEZ/uv9SKYEotn0lvLhOR0DJAqH4
 /GCMb9AbW3m1bHB+SV2Il0cZwxoWNcqd+ljw6Hb6/OKbX5TJWHUMDjk7kHEXFdbU4Xv7
 f0BwAKqca8vLsTpVyWot+1JubrI/ZgHloRrR59HRjNhCcjFwaL7pI0kldUEVo3Uj6BAQ
 2rVg==
X-Gm-Message-State: APjAAAUtavtUFvTaP2r29gnJWyZwGvN2CRpDWQKAewqyGc2Qt1V+ULpU
 8applrUneUsWr7YUsjcMBabH73bD
X-Google-Smtp-Source: APXvYqy1aWzC2bbJf0FDKmIZq6RqPs0kcF9JkTHAKpoOt+KZ5Imhtw+bWsW3IU4jedxP4+sMMlDIbw==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr28549602wri.47.1580234225001; 
 Tue, 28 Jan 2020 09:57:05 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 083/142] meson: convert hw/sd
Date: Tue, 28 Jan 2020 18:52:43 +0100
Message-Id: <20200128175342.9066-84-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 hw/Makefile.objs    |  1 -
 hw/meson.build      |  1 +
 hw/sd/Makefile.objs | 11 -----------
 hw/sd/meson.build   | 11 +++++++++++
 4 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 hw/sd/Makefile.objs
 create mode 100644 hw/sd/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 55433f352e..a72fa7895c 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -25,7 +25,6 @@ devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
 devices-dirs-$(CONFIG_SCSI) += scsi/
-devices-dirs-y += sd/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 75644266f2..a73f4aebde 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,6 +2,7 @@ subdir('core')
 subdir('mem')
 subdir('nubus')
 subdir('rtc')
+subdir('sd')
 subdir('semihosting')
 subdir('smbios')
 subdir('ssi')
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
deleted file mode 100644
index a884c238df..0000000000
--- a/hw/sd/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-common-obj-$(CONFIG_PL181) += pl181.o
-common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
-common-obj-$(CONFIG_SD) += sd.o core.o sdmmc-internal.o
-common-obj-$(CONFIG_SDHCI) += sdhci.o
-common-obj-$(CONFIG_SDHCI_PCI) += sdhci-pci.o
-
-obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
-obj-$(CONFIG_OMAP) += omap_mmc.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
-obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_sdhci.o
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
new file mode 100644
index 0000000000..2b88a956d6
--- /dev/null
+++ b/hw/sd/meson.build
@@ -0,0 +1,11 @@
+softmmu_ss.add(when: 'CONFIG_PL181', if_true: files('pl181.c'))
+softmmu_ss.add(when: 'CONFIG_SD', if_true: files('sd.c', 'core.c', 'sdmmc-internal.c'))
+softmmu_ss.add(when: 'CONFIG_SDHCI', if_true: files('sdhci.c'))
+softmmu_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
+softmmu_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))
+
+specific_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-memcard.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_mmc.c'))
+specific_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_mmci.c'))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_sdhost.c'))
+specific_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
-- 
2.21.0



