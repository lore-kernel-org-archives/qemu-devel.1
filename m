Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E65C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 05:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042C62086A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 05:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN8JPeR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042C62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3v1i-0004Ta-3a
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 01:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1k3v0n-0003el-RK
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 01:33:49 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1k3v0m-00084f-7t
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 01:33:49 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mt12so351804pjb.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 22:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=oiiscSXSEBzfDLEUuNO0uvItF27KOcNkiWo8CT4jTl4=;
 b=VN8JPeR8NGiT8cL+GicDtI/deQ/S7mbJn/T6xVOGji4G3akeMdC0mu2LXWo5cx4xzF
 zHle98Ag+MO8b+iQM40NgzuKK2UJtl25IhaNM2kpGwqlmAlZvUTT2Zl/c+xruo5hDzVu
 QCmpIdqZF5R98LQ9UZQ2NYRuYhDISwRXZCk/Ft0ELqnbexVkxocnicBtBet3o6dAp+PG
 XT5Z22TkjTHIvP4qtl6DJy5HM5cqUr9rTi+eYke920D8stMcoAwsNSXYdXIdYUsruynY
 wHYBVuP4GVznrMN03jpuw08nhkISiPKxQ5k+DXjvCRXIecIcXpfTmOzzedyUHnb2L4VT
 U6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=oiiscSXSEBzfDLEUuNO0uvItF27KOcNkiWo8CT4jTl4=;
 b=owFzmYyzS/IHdd1R9b0sDWMmHoK5VrD8DgVUmlipg+6osEc3ea3v8fxLwt/r0fhs7T
 9CBC6EPS6jIJRVDqBXPmtnHsQk+/FT/iIhrQqBKH9WUe+ZUpIiAgVI1D7QhgJ57ysYbg
 JK2xCbi+DCikgkikI6gdpGNnqf7V/1G6y7qPx5goyL/wJJ19d2CJKsYpoidajC1z4wy6
 I7eBgPvLEz8OYyfd0jlC7p4LnGV5GVf7/qZ2/OhBTPoyhrGGEFUtSe4bA3JHQtnBYwnj
 +bsd1XzqMj0ks+QlptCOTWgtz7oz0RjI4JMy8e57f9yovRYQtZgvs0FfNRCajO4ce23s
 NHpg==
X-Gm-Message-State: AOAM531dIJ8mSrxnB2vjST6ctBG2nKjd08aHCRc/7mLSMoKCAAS9BB5c
 fC2V/4f2dYsaNo3s4/Jt6n+FA3Co/XU+mA==
X-Google-Smtp-Source: ABdhPJxYn9lEIf0PWpvGWzFppOgz0pQH0B4lf5PB4pGn12j6swf2yhqypuBlsEfs6Y4CuArLuv06ag==
X-Received: by 2002:a17:902:a50e:: with SMTP id
 s14mr10293638plq.164.1596778426825; 
 Thu, 06 Aug 2020 22:33:46 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id s8sm11641592pfc.122.2020.08.06.22.33.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Aug 2020 22:33:46 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.2] hw/null-machine: Add the kvm_type() hook for MIPS
Date: Fri,  7 Aug 2020 13:36:38 +0800
Message-Id: <1596778598-19177-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
libvirt uses a null-machine to detect the kvm capability. In the MIPS
case, it will return "KVM not supported" on a VZ platform by default.
So, add the kvm_type() hook to the null-machine.

This seems not a very good solution, but I cannot do it better now.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/core/Makefile.objs  | 2 +-
 hw/core/null-machine.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index d8fee8e..2daba3f 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
 common-obj-$(CONFIG_SOFTMMU) += machine.o
-common-obj-$(CONFIG_SOFTMMU) += null-machine.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
 common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
 common-obj-$(CONFIG_SOFTMMU) += numa.o
 common-obj-$(CONFIG_SOFTMMU) += clock-vmstate.o
+obj-$(CONFIG_SOFTMMU) += null-machine.o
 obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
 
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index cb47d9d..1adba5d 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -17,6 +17,9 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/core/cpu.h"
+#ifdef TARGET_MIPS
+#include "kvm_mips.h"
+#endif
 
 static void machine_none_init(MachineState *mch)
 {
@@ -50,6 +53,9 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_sdcard = 1;
+#ifdef TARGET_MIPS
+    mc->kvm_type = mips_kvm_type;
+#endif
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
-- 
2.7.0


