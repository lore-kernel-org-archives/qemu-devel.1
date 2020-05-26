Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5233320776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2biI6F5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5233320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXAg-0003tL-IA
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7R-0006kt-FD
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:37 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7Q-00028r-Pe
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:37 -0400
Received: by mail-ej1-x643.google.com with SMTP id e2so23233262eje.13
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QG/Ao1FLrrqA3qiyJ5oTk9vVoadIo9/g3miLYRH/cTM=;
 b=C2biI6F5tauTNWAKpodEppwGET3Oo1lW6hnW1Q1YvizkdKWGlfOYaUHzR2GDMGChdp
 nEg+YD61KFzXPAReQyjrdoWA5znOMYp5BYg4eGD4nzutlgALy1ptZUnt3LlH9TmvKN0D
 oq4TctufDbhmkcF9Lf245gEmmgop+qRXl4DeMnDN7FqxA88tDPgwjE6KwW9dQaAan5Wl
 tJRQswKKS4+6fptHwgkSSO7twCyjTFlvXiOLVS3Gx4uxtkXJ4hy2XVhSiqPM9lqUxf+M
 YiI/lIN6FER6y0rbraJSFdi4Ilczuvx0vEvuEKZ2nLNTq83yGOQN2I5LYFmbAEEIPdFT
 gbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QG/Ao1FLrrqA3qiyJ5oTk9vVoadIo9/g3miLYRH/cTM=;
 b=W2yRZWQsnmjjZ+DpuIjjMplhiknhlz0zK1+xXLTdy9D2ceOqRhD2NyUnvQE+l74BmQ
 qr2mm0hHAiVZxRu82jpWMi4m3suN41rnljIntm5g6K4J7u5OZs9XsOIPYV0b9KpJJdZc
 G/JxgYt2oOEn2y/RjNIpUmbMK2AjXihMbj30c3N7ixsG57Tn2j8eToQyz03Qz/T3NWXB
 U8K7bjA1CEnlrqKMjNgfVuHOQcsb0yiHc0MpIKiF4b1vPCW8uz4awKyOL+uNFYhnf3Kv
 dfdZyyfjMkJxl7zeFWb7xQMfGRD8xus691rUWPi+BJW8V5WZzCZC5ZP4kEilIfcYn1z2
 27Gw==
X-Gm-Message-State: AOAM5337wjtC1M1u4jmmbdzz2r+9WGZNsJh8NlaQHEi50JCFP86P2n5y
 bGtXVSi/LQZYZms9SUc7JJdkdz1+ljY=
X-Google-Smtp-Source: ABdhPJyoo+VtWtbHcSdXGZfsOYXDOW8z0e8hYTZTEy6Nhtq3mdrhXEUSSjZ4eLADOLWtHCCFNGEY3w==
X-Received: by 2002:a17:906:81ce:: with SMTP id
 e14mr553124ejx.76.1590490055287; 
 Tue, 26 May 2020 03:47:35 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/14] hw/pci-host/bonito: Map all the Bonito64 I/O range
Date: Tue, 26 May 2020 12:47:17 +0200
Message-Id: <20200526104726.11273-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526104726.11273-1-f4bug@amsat.org>
References: <20200526104726.11273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To ease following guest accesses to the Bonito64 chipset,
map its I/O range as UnimplementedDevice.
We can now see the accesses to unimplemented peripheral
using the '-d unimp' command line option.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-id: <20200510210128.18343-9-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 3 +++
 hw/pci-host/Kconfig  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index b90e5a636d..f09bb1c6a8 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -48,6 +48,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
+#include "hw/misc/unimp.h"
 
 /* #define DEBUG_BONITO */
 
@@ -644,6 +645,8 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     sysbus_init_mmio(sysbus, &phb->data_mem);
     sysbus_mmio_map(sysbus, 2, BONITO_SPCICONFIG_BASE);
 
+    create_unimplemented_device("bonito", BONITO_REG_BASE, BONITO_REG_SIZE);
+
     memory_region_init_io(&s->iomem_ldma, OBJECT(s), &bonito_ldma_ops, s,
                           "ldma", 0x100);
     sysbus_init_mmio(sysbus, &s->iomem_ldma);
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 8db41edc7e..036a61877a 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -58,4 +58,5 @@ config PCI_EXPRESS_DESIGNWARE
 
 config PCI_BONITO
     select PCI
+    select UNIMP
     bool
-- 
2.21.3


