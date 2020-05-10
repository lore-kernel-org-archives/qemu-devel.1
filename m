Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C84DC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3234A206F5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtZzbUXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3234A206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXt8C-00041G-7d
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt54-0007Pn-2z
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:51 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt53-00016h-61
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:49 -0400
Received: by mail-ej1-x643.google.com with SMTP id nv1so6204151ejb.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RQF0AIKv5jY/IdYIv+ZhyhMOTflQHjTZ2jYUwkEq1vA=;
 b=XtZzbUXx2u9LILr4KkET2BaOdIk2n+4GvRBfzhOUapPMkFvAUAZ+Q/v/hSnS8hssZt
 kSDj6HArDA30ZTzwa83gfqWFuYpwqHgrBFx9fLwLx6IK8uERZbcvnb6oMJSsnEBfuAGk
 4ieeazU62TuCN0CyKPR2K987s9bQoJW9Jf1xmQXPgCXURy30yPpGb0zdCh2moloBNknj
 bGh5w/FhEUNZEOam1p1E2k5j0RY3bsz0iowWNKKc6XUjF5ecw0A8IXkgIy9mA8qAcuQ8
 vLypSHhirXUbYk9drPBQPj8N0bNjKjvi8TrKTtnrrX+YEQqxypBwu8Zljkc7dG1CO3zy
 ydxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RQF0AIKv5jY/IdYIv+ZhyhMOTflQHjTZ2jYUwkEq1vA=;
 b=T+jSP9pFAkl7yJ3l5dgMD3pIOHZ0HyC5gzcJndOaceqBZt9z/5JHpuSuckkV6wOCnX
 pncRuXz9cEdz9TjC6KhKvcSWSeHxBdCUG3PCFv4c/KPTMAeVvBBmvyXqzlZ+ZxlsJZ+f
 S72jNyoj25SJke05bu5xtT2Zb2hPdtCSTdmgo7lQqgF6dRIRsady+OW3sV1o6oq9kswi
 N0CuNf6929dq7Koreol69ZsmaxJxz2c+bBjYGAgOqhotNTqOi3CbT/vIEA0FtdflpDLq
 Mtbme3eFy7SPOKaGVZBz/OSVRhrp3dAbzbAFVa81iGbYhc7slpqqiy4rdNNbXDmOfZMx
 todQ==
X-Gm-Message-State: AGi0PuZayO3H1ffEFf+jCVDZlZnqcpK/aG7N9jJkvD2qyKuSXzMPuZat
 z9R0HPsmZ1BpUXsbz2DfxOZ0WhfQ1ok=
X-Google-Smtp-Source: APiQypJguef/0Wk97lVqhjPJ6X9mmKks1nlVC2PgMFmVNjT43chokAFJDyJn+ITMrPnnrodUzMBVlg==
X-Received: by 2002:a17:906:4147:: with SMTP id
 l7mr9861603ejk.360.1589144507366; 
 Sun, 10 May 2020 14:01:47 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/12] hw/pci-host/bonito: Map all the Bonito64 I/O range
Date: Sun, 10 May 2020 23:01:24 +0200
Message-Id: <20200510210128.18343-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To ease following guest accesses to the Bonito64 chipset,
map its I/O range as UnimplementedDevice.
We can now see the accesses to unimplemented peripheral
using the '-d unimp' command line option.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 3 +++
 hw/pci-host/Kconfig  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 7ed462ffb5..9761780f44 100644
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


