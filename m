Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E56C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263E720760
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u95uiL95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263E720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQGF7-00042I-TR
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 16:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBs-0000Py-Cm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBp-0000fa-Fr
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id j136so4021440wmj.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q9wQO0osdeQtCs33krShubakXkt+tCeOq3L5AqH27oA=;
 b=u95uiL95h383zFaawDkzwDM7yDxgoYBtr7YT+ML7SI/a3EzDPKdMWLSJYzUI3fHIb8
 PHRrOZqzQ5tGQTKnA5hHBth4Xd4mtNXnPhqKd0pUy+Y0ujavN2iId/ZUGXI/jbeoTue1
 z4dYH7p/WgdyAp07IA2NcY4KmnIIqJ+LAp5Y7nXeZlEoppgsWJwo28aWxYO2A4wbZ9WQ
 3PxE6cNNPCZTOuq3TdDDBmFBHh9n5/3kizmg2HGdma/MaFKBty/4oeqq/XwVeIqwrzst
 7WXH2bKhowv5qX115n8k1t82SbEP18vNcg2d/+stqCebjbSRChY74qKHEphePFXvbCm3
 k8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9wQO0osdeQtCs33krShubakXkt+tCeOq3L5AqH27oA=;
 b=HJw5AjTpLQUTc0LGMXtn4DCsNUkmbqNXBEkS5dzO16oPQtqPYjcKZpWkIhRvczFmEy
 Kfw/wB493ddhsjbKEyNpeELKMnQICerPZ+OUQ/OWl6oWChcWWhuUrYIBR9Ny798njVTo
 0iU95vwGuypaaMa8RqGU2nMbSttxDmkCltlJWyG29HY+wXWcrE/9YlCYlaE0VPzw4sZz
 Lk5YcMpjxoNKMxXmVE7PXHePUFvugPplRXWrtRzIV8zZXpRFpp1y919vLKwJgxI3wd4S
 W5UNGK9/zXgwHph/P37DxxtkbYjbM9TF/p9JkdsxeF1US4J7GD7+vWGbH1zQga5vxMPC
 +APw==
X-Gm-Message-State: AOAM533VhF+E9T8R7hjil+3ezTjPlWPIibrVmyLKn4W4xp7l7aEap0RS
 RreX6NOpcGCPUZ1MHdGUF4oWbD9LlQU=
X-Google-Smtp-Source: ABdhPJwg0V6F9PeCR+95cscN5bC0WPTjtTwx9qtPCZUUvEwp57Qa5wRngv/tdzF9HUBxx5fM/1onvA==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr5030265wme.27.1602103052106; 
 Wed, 07 Oct 2020 13:37:32 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id d2sm4359083wro.34.2020.10.07.13.37.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 13:37:31 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] MAINTAINERS: Remove myself
Date: Wed,  7 Oct 2020 22:37:21 +0200
Message-Id: <1602103041-32017-6-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@syrmia.com, f4bug@amsat.org,
 jiaxun.yang@flygoat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 hpoussin@reactos.org, chenhc@lemote.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have been working on project other than QEMU for some time, and would
like to devote myself to that project. It is imposible for me to find
enough time to perform maintainer's duties with needed meticulousness
and patience.

I wish prosperous future to QEMU and all colegues in QEMU community.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 MAINTAINERS | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9d85cc..426f52c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -221,11 +221,10 @@ F: hw/microblaze/
 F: disas/microblaze.c
 
 MIPS TCG CPUs
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Maintained
+S: Orphaned
 F: target/mips/
 F: default-configs/*mips*
 F: disas/*mips*
@@ -387,7 +386,6 @@ F: target/arm/kvm.c
 
 MIPS KVM CPUs
 M: Huacai Chen <chenhc@lemote.com>
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 S: Odd Fixes
 F: target/mips/kvm.c
 
@@ -1124,10 +1122,9 @@ F: hw/display/jazz_led.c
 F: hw/dma/rc4030.c
 
 Malta
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
-S: Maintained
+S: Odd Fixes
 F: hw/isa/piix4.c
 F: hw/acpi/piix4.c
 F: hw/mips/malta.c
@@ -1137,14 +1134,12 @@ F: tests/acceptance/linux_ssh_mips_malta.py
 F: tests/acceptance/machine_mips_malta.py
 
 Mipssim
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Odd Fixes
+S: Orphaned
 F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
 
 R4000
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
@@ -1153,7 +1148,6 @@ F: hw/mips/r4k.c
 Fuloong 2E
 M: Huacai Chen <chenhc@lemote.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 F: hw/mips/fuloong2e.c
@@ -2821,12 +2815,11 @@ F: tcg/i386/
 F: disas/i386.c
 
 MIPS TCG target
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Huacai Chen <chenhc@lemote.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Maintained
+S: Orphaned
 F: tcg/mips/
 
 PPC TCG target
@@ -3167,7 +3160,7 @@ S: Odd Fixes
 F: scripts/git-submodule.sh
 
 UI translations
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+S: Orphaned
 F: po/*.po
 
 Sphinx documentation configuration and build machinery
-- 
2.7.4


