Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96755C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FE020714
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7XiCO+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FE020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn3q-0008Sj-BK
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqJ-000537-Ub
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqI-00047W-Ap
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id b127so8382777wmb.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iuO8xvBpXep6eLb/F7St0rc68Indv4ZsZQ0L+M/FNuI=;
 b=P7XiCO+Oetyfs+aDoX6OecYt24LulPbyceXndHiTY11Mdg6H2DnGpYcELidRXH4+Y+
 7N+TbKu0NFoCkVYVNWbvNlrGd2RfpG9rI4vHv1j53lx1Ts7KsNzY3d14ABLVbk2/+YxC
 cNPLAs0PP4X7cbRecK2aWDVg0WzGUyBtclJTQ44jneI2IA+E645sMxye0pkTOn/4Io6M
 NbjFDFU0tbQRVf8WO1XaScl8NWExdkLZPyhBTSkxPmaRlYoqKxo+wTf0aysCktAobQSo
 G3PfYbsPg/L/lHrILoQgv9yPUzkMR3wmkd7HZ73VUaPWPSW0wH2TMkRBWJ7RXNpWT7Vj
 cYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iuO8xvBpXep6eLb/F7St0rc68Indv4ZsZQ0L+M/FNuI=;
 b=OiQxYJ+VdarLUiZRCATAmv3sUElOCI7EMK1jfFkyCZu75LMmnJpZG2GPgDNzo0WcaK
 bD5kVugl1WR1wkj1NT7nCFPs9NHkekljO/6jWBpvLcZaTerGjckP5DfH+w4xJ74jrskm
 qgxy/X2on/LcWWYS60gLLQnnixYF/YJvt1G7t3JFrYbqe++yVhFSYJ9n4SoVOQJ4/XNh
 3x42ZHW26R4iW34S+hpstCaK2mFln1f2Tt2uY8O+pdeE3O/1RRB+YdF/2pyMjHvzUyVq
 29INkc3szfqIz+qBmSCxHgGrUfPV6wI3+GWFZfEFZkYJjIxfbyPpi8NyjXt2AypuOUsC
 exlg==
X-Gm-Message-State: AOAM532UCJsGo/5oPSLyJi1/IE2NHicqr8/wiaX3U4CxdyEsZ/5lYCaV
 Ilw/tfDMkiy65tJJiW7DESgkn+33QaE=
X-Google-Smtp-Source: ABdhPJxykTBXGwmq/YYhM5dLoMcVfRHRm4PsTDJT3jMl89PfESvOBCH29BIUSv144QGxxtKYuUSQ4Q==
X-Received: by 2002:a05:600c:2905:: with SMTP id
 i5mr8712893wmd.9.1602943552836; 
 Sat, 17 Oct 2020 07:05:52 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id g125sm2890034wme.33.2020.10.17.07.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/44] MAINTAINERS: Remove myself
Date: Sat, 17 Oct 2020 16:02:39 +0200
Message-Id: <20201017140243.1078718-41-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

I have been working on project other than QEMU for some time, and would
like to devote myself to that project. It is impossible for me to find
enough time to perform maintainer's duties with needed meticulousness
and patience.

I wish prosperous future to QEMU and all colleagues in QEMU community.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1602103041-32017-6-git-send-email-aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 99ab02bbab3..b91bd754d16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -220,11 +220,10 @@ F: hw/microblaze/
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
@@ -386,7 +385,6 @@ F: target/arm/kvm.c
 
 MIPS KVM CPUs
 M: Huacai Chen <chenhc@lemote.com>
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 S: Odd Fixes
 F: target/mips/kvm.c
 
@@ -1123,10 +1121,9 @@ F: hw/display/jazz_led.c
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
@@ -1136,14 +1133,12 @@ F: tests/acceptance/linux_ssh_mips_malta.py
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
@@ -1152,7 +1147,6 @@ F: hw/mips/r4k.c
 Fuloong 2E
 M: Huacai Chen <chenhc@lemote.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 F: hw/mips/fuloong2e.c
@@ -2823,12 +2817,11 @@ F: tcg/i386/
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
@@ -3169,7 +3162,7 @@ S: Odd Fixes
 F: scripts/git-submodule.sh
 
 UI translations
-M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+S: Orphaned
 F: po/*.po
 
 Sphinx documentation configuration and build machinery
-- 
2.26.2


