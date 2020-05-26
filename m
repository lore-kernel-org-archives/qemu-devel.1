Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C9C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97662073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq7+a5RO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97662073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdX8d-0008Pa-Uk
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7N-0006ao-Ii
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:33 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7M-00028L-QL
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:33 -0400
Received: by mail-ed1-x544.google.com with SMTP id l5so17244643edn.7
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZxmLzjQ4bUorljqYuWr6VmTgXnIbg6am868WkyxH1FQ=;
 b=Hq7+a5ROzfKV7uz3FSsLHHmm2WPhIdUCq/MCNdaKbGTg/MndNp1iJbfpf5RiGipAMo
 Up3x6Jv3WG5iC1Vtvm2e0kA8fqZT1PJY20Y1cAV0LGoJk8k5orqtKnwFqe7vV2fuRyCi
 yn3rd8pChnZIShdhjK+DRlT8c0ak80QI6zd/eUqIpO0xDzin6ChpY+7crYMO+uzm3SR9
 50QmsnJ2ujRnXWFlPEzql1LQSSdVt3OFpmHnKFm+uUfiS5yjzutXHL3Yl27WghkniwaZ
 HcEuc9DfWrohzczNsaCqXNaDq56uNd++9WFxxTCsX9IwyEPo0PD3DFI6pkVwnAXzSbLN
 o3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZxmLzjQ4bUorljqYuWr6VmTgXnIbg6am868WkyxH1FQ=;
 b=JBUL9L5deO3Z8MbDVUv5IOU35v3nXm1/jkR2xsfaDl8+xNPM4EiyUsYdUEQXsXyPX6
 iQJQ9nG4TZcePF5w60CZg6Ke37m28o/cwUnIOTWwlSki4o1CBYK4MQcsLtCkFi1LUcc+
 FBCwy3o8YgZZsJNAc+ZsoVkoneAJJkZJWXYPFWT62vGvt3TvRJKAyZp3FCO0uxXUcg4a
 eImwNFlX0AmSfJsxUIwZPTP++8RX7i0nC3zTRDNZI+g+3sHViNcZc1/G7NtRbRIfznKW
 pVe5ZtifkNOoR5YIf4jxYwXwiWnyzROUrWWLgnJr9NMerIb71+19I8X0E3hKPUxTyQOL
 Wxrg==
X-Gm-Message-State: AOAM533h0xd68PVQ/PTdf7aN2IUbbi4btjEpPpd/IipQDHol2x0A3dyj
 NdZOxQLd/72fE4esbJ8deTTf3WV7u38=
X-Google-Smtp-Source: ABdhPJz3y81pWZAN2QDwX69MSEFuoyy3UyT/3VQZ7FbsGVsTwTvx9TXWg8Kiq5ikqCx8oF1YY0wNMA==
X-Received: by 2002:a50:b2a1:: with SMTP id p30mr3467675edd.199.1590490051075; 
 Tue, 26 May 2020 03:47:31 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/14] hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito
 North Bridge
Date: Tue, 26 May 2020 12:47:14 +0200
Message-Id: <20200526104726.11273-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526104726.11273-1-f4bug@amsat.org>
References: <20200526104726.11273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
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
 Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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
Message-id: <20200510210128.18343-6-f4bug@amsat.org>
Reviewed-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/Kconfig           | 1 +
 hw/pci-host/Kconfig       | 4 ++++
 hw/pci-host/Makefile.objs | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 2c2adbc42a..2240504dff 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -43,6 +43,7 @@ config JAZZ
 
 config FULONG
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


