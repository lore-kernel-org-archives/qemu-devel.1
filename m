Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE95BC54E8E
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF98F2080C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkhvGcaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF98F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXt6d-0001Do-Sn
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4x-0007FI-W4
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:44 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4x-00016G-9h
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:43 -0400
Received: by mail-ed1-x541.google.com with SMTP id h15so3897782edv.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+8JRvFNRcXTIFmUjOpwGkhhocKvXrzubaGtLH/+phWc=;
 b=UkhvGcafC1WLA02XEgfJwZaDnXKTne00koNyzc+xMEbN8enfImt8rE9jv+NWE8Zqgp
 bIZAxNlYfRxGNotOpEK5zut0hhorXZUUiVtrEvwlA3xxYwJVC2FeKzIwsUzj9eYvnQSf
 OalBe3zDrNIz0fTkjSD4MDP3mRf8vrlq1DkiEck+5areTakJLzUcMwd5qy08N9S3y/7B
 OszKaJbQc11xsikJrj8hLZGhyaD9zQh/JT1l1vBvCmty0PR1jLwYQrQnY+QzC/22rNfZ
 FsVGOcInzu5FelFTbOGkfzOWv0+/9kMXM+uVP9NxR0ZBVmWPFRKzankKbfJWx/PFH7H+
 3Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+8JRvFNRcXTIFmUjOpwGkhhocKvXrzubaGtLH/+phWc=;
 b=rinDKnazgqHpfQBjv1/vJ1uzFcbgstswFOSicvYivC7IlptiHPeiICWvZacKTm9d1X
 GwpsY2ursJYshpYPyOHNTSjoL6QvzTY9m1p39/SuCHsACSG9Icxcv1BIh3BQ89txfahw
 wtuMbDUC5cfJ5e750oDpIYmoq1tR3PmIuDzCUBebsuNARFIQNVb3zCDk2xgr3UirMdgC
 8SIOw3o+wU8l4pUMwvHjTlRhWcPB6dpFLPYnK0hq5iUBdI7Jx/zcj9x9U5JP22IXiP6a
 VgefZ79VoCxbasNagutvw546qd/8gNYQVThLKNYFjdxKP8nkpKYf3TDkQ4Ep9j5aIc8w
 vAQA==
X-Gm-Message-State: AGi0PuaMvXzK5w7zewWdN9witGyE3vDRyNv89o3prPmYzIycTzd69Uh+
 owNlmObbL1ca+mwGlK/Xo6ffH33M1Jg=
X-Google-Smtp-Source: APiQypIsdAbUhiN+KoO/9H7cEVcnhsqu+LzqhQZvQrMQ5bfNUC6Gvz6cvQDpev7Q/gf5SWkKJcY24Q==
X-Received: by 2002:a50:8b42:: with SMTP id l60mr10567401edl.55.1589144501743; 
 Sun, 10 May 2020 14:01:41 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/12] hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito
 North Bridge
Date: Sun, 10 May 2020 23:01:21 +0200
Message-Id: <20200510210128.18343-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Ease the kconfig selection by introducing CONFIG_PCI_BONITO to select
the Bonito North Bridge.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/mips/Kconfig           | 1 +
 hw/pci-host/Kconfig       | 4 ++++
 hw/pci-host/Makefile.objs | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index cd38546689..67d39c56a4 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -43,6 +43,7 @@ config JAZZ
 
 config FULOONG
     bool
+    select PCI_BONITO
 
 config MIPS_CPS
     bool
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 9642c77e98..8db41edc7e 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -55,3 +55,7 @@ config PCI_EXPRESS_DESIGNWARE
     bool
     select PCI_EXPRESS
     select MSI_NONBROKEN
+
+config PCI_BONITO
+    select PCI
+    bool
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 8c87e8494d..e422e0aca0 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -12,7 +12,7 @@ common-obj-$(CONFIG_PPCE500_PCI) += ppce500.o
 common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
 
 common-obj-$(CONFIG_PCI_SABRE) += sabre.o
-common-obj-$(CONFIG_FULONG) += bonito.o
+common-obj-$(CONFIG_PCI_BONITO) += bonito.o
 common-obj-$(CONFIG_PCI_I440FX) += i440fx.o
 common-obj-$(CONFIG_XEN_IGD_PASSTHROUGH) += xen_igd_pt.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
-- 
2.21.3


