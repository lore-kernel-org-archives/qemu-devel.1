Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E177C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313A02173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JepssEAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313A02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVoL-0004pU-9b
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6u-0002J7-7B
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6t-0005wZ-67
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:12 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6s-0005uS-UF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:11 -0500
Received: by mail-wr1-x433.google.com with SMTP id z3so17132973wru.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F/PAqzC8fvG09GNhUD1J7jPvNTp6Zihw4cXDH9Xi1cU=;
 b=JepssEAd4uaIKJKgeG/nL+R8Rh2Qi9x9ku6hqZrk1gf+udd7DZDc/7Nsvf37HNLzCM
 Q3IRFs7vUKUMSbnUOvSebvk8LkJm1d/W7YvbcFMWrDPwdBKVEbYH2XX3103ZpUPOzZkZ
 o/bOufXm5D7OK2BoSucja2gEC13fr7BGwXf19c7j9skt23+r84wl0tZ1eNRQR1020Eee
 DKPN/l5JWkoHjES5YxIcPslKEm7nw/adgipPFEUgdztM8vmg3MzsH0BSUSh1mZoOaIuh
 tyQYLD0ctm5NNdwcybvGV0cItOId3C5YOKLSBu3+TlLNLstUWoXZ5cxcX0pkyb9wWLrs
 m40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=F/PAqzC8fvG09GNhUD1J7jPvNTp6Zihw4cXDH9Xi1cU=;
 b=moMjoezN489KQNsxeN6V38wNpYaZ6gi0ZZnDfNuAzGeyPw1w9XIPRTVneJJC2oOczA
 wuCxQamFG7GGGRLU15HscdmIChoVaaEs9a2ZEhONPT3FFTcpzJrOBEy2dDvGB3EuIBcS
 FeiVQ96Jk2VS+Ckh8E7mBkehDlgso8WNhJ70PGc6mlSn0pXvhC/ugw7gOef6CcjQeYp7
 7FVyENIKoV7AHJ9ivJodmRxtraRVYKUMK7rjE6Xuy3vfgUnDk5sGhsjIOTLELJ1UDAK+
 DTfHO97sHK79tVgbsHOAd5yKQvFnDBIqrTokYIVAWefZQHeyLDd1aqcpaMO/B8u8wWJ1
 GAoA==
X-Gm-Message-State: APjAAAV3+5kByD0uszbH8Ll+rYvQDETL2sC5cLJUZ1D7FK9HmorBH+Gx
 8+ZvIQOBCMHEigw9O35/2fxiGYtN
X-Google-Smtp-Source: APXvYqyCJjYaY6Rl6tmHrC+BMMiVBfgpoJeQ3++j1Iys3O0cxjOKxEm0yvV6Ek0Y1DDnRPJ/0yAJJQ==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr30136582wrn.83.1580234229686; 
 Tue, 28 Jan 2020 09:57:09 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 085/142] meson: convert hw/pcmcia
Date: Tue, 28 Jan 2020 18:52:45 +0100
Message-Id: <20200128175342.9066-86-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 hw/Makefile.objs        | 1 -
 hw/meson.build          | 1 +
 hw/pcmcia/Makefile.objs | 2 --
 hw/pcmcia/meson.build   | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 100644 hw/pcmcia/Makefile.objs
 create mode 100644 hw/pcmcia/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 027ae24c29..21d3f6045c 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -23,7 +23,6 @@ devices-dirs-y += rdma/
 devices-dirs-y += nvram/
 devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
-devices-dirs-y += pcmcia/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index d4abb67715..ed25644237 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('pcmcia')
 subdir('rtc')
 subdir('scsi')
 subdir('sd')
diff --git a/hw/pcmcia/Makefile.objs b/hw/pcmcia/Makefile.objs
deleted file mode 100644
index 4eac060c93..0000000000
--- a/hw/pcmcia/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-common-obj-y += pcmcia.o
-obj-$(CONFIG_PXA2XX) += pxa2xx.o
diff --git a/hw/pcmcia/meson.build b/hw/pcmcia/meson.build
new file mode 100644
index 0000000000..48ece810a7
--- /dev/null
+++ b/hw/pcmcia/meson.build
@@ -0,0 +1,2 @@
+softmmu_ss.add(files('pcmcia.c'))
+specific_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx.c'))
-- 
2.21.0



