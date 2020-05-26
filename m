Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D865FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F91A2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btjLmU0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F91A2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZq4-0004nZ-St
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhe-0006i3-2m
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:10 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:40648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhb-0005pn-O2
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:09 -0400
Received: by mail-ed1-x533.google.com with SMTP id l5so17661205edn.7
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CA4dl2WNChH9j4MQdjSr57dN4nPG4AfEzYEDKDaDKgY=;
 b=btjLmU0uSArdKppVIyvzEevXcZOL6OEvNqMT8vK0+odOBHsgeNcV/tzq4oJl6+f6qb
 IZJ+9JUB/iwMWVtxUA+Mw7RMaj5TPRF1n1URMNrz4AFiblpAZGJGsJYWvvO0/3KvK6bP
 Gyg2+5yBmsSJRrs7Ph7nCBgtWpS+tGWNzD3wJtYeBDw1Ud6TOw7bxwGbOcfOvGcFGF/o
 cJOtmYksa7+A10EjFqS9NiUiJM4Ruizj13X7H216EWT1B4Q5IlQGfxvdUiT3MUHxfFEZ
 m03IK+bK0mmaWkq/SYTbo6NJ0A6BpSdp8sloZJp0kAHk3iDkqWdoX0DgAeLm3BOcPX2c
 BBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CA4dl2WNChH9j4MQdjSr57dN4nPG4AfEzYEDKDaDKgY=;
 b=lrGm3M/G2Wtn4u2AmKIFHiq/q83X6HqCMcl2XWucd6FpK9FX4arNerc6EMDw60X3Wz
 hRDC2nQjFYN0d3m8FkH2+hHWUy1zVymkZF7tEksNdKEejc5RGxTcj1864KEaILDjnzFn
 3tPBSKSpATUJq70YeGq3QThelS8zWCozBorj/FXwAbpOyc3n4m+DdIRPTcZwoXlidoWZ
 4zVWq2HGlwlSpGSmm0LxzIn4SWg9U4kkF6fILOZF/K4V5qm9FIV9zDTBCJz8fbyTYs63
 7o9WTMSmEFahATZ1dY7PTZOwtLRiOhYd1Ze2H7/KIIuj/YPQqwMv3YpHspTEHulLGhn6
 va/g==
X-Gm-Message-State: AOAM533i4iRHqEaU6Ry2nyr6YMZERv6wCrn/fWS8Mxc8zdWrJd5D1sCW
 NKIOBoNNamt9wwK13+PSExX63IwPKZ8=
X-Google-Smtp-Source: ABdhPJx7avSR9b0IO/bFYQNE/KO1XlTDYcp0o/zU7LDoy5ZTkcF4YTwp0Ln+48NWn2gBdmgXI0iSFg==
X-Received: by 2002:a50:abe3:: with SMTP id u90mr20016260edc.278.1590499986220; 
 Tue, 26 May 2020 06:33:06 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:33:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/14] hw/mips: Rename malta/mipssim/r4k/jazz files
Date: Tue, 26 May 2020 15:32:44 +0200
Message-Id: <20200526133247.13066-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x533.google.com
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

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Machine file names should not have prefix "mips_".

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-id: <20200518200920.17344-22-aleksandar.qemu.devel@gmail.com>
[PMD: Fixed Fuloong line conflict due to rebase]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/{mips_jazz.c => jazz.c}       | 0
 hw/mips/{mips_malta.c => malta.c}     | 0
 hw/mips/{mips_mipssim.c => mipssim.c} | 0
 hw/mips/{mips_r4k.c => r4k.c}         | 0
 MAINTAINERS                           | 8 ++++----
 hw/mips/Makefile.objs                 | 8 ++++----
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename hw/mips/{mips_jazz.c => jazz.c} (100%)
 rename hw/mips/{mips_malta.c => malta.c} (100%)
 rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
 rename hw/mips/{mips_r4k.c => r4k.c} (100%)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/jazz.c
similarity index 100%
rename from hw/mips/mips_jazz.c
rename to hw/mips/jazz.c
diff --git a/hw/mips/mips_malta.c b/hw/mips/malta.c
similarity index 100%
rename from hw/mips/mips_malta.c
rename to hw/mips/malta.c
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mipssim.c
similarity index 100%
rename from hw/mips/mips_mipssim.c
rename to hw/mips/mipssim.c
diff --git a/hw/mips/mips_r4k.c b/hw/mips/r4k.c
similarity index 100%
rename from hw/mips/mips_r4k.c
rename to hw/mips/r4k.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 8136a0e56c..f46ab150dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1050,7 +1050,7 @@ Jazz
 M: Hervé Poussineau <hpoussin@reactos.org>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
 S: Maintained
-F: hw/mips/mips_jazz.c
+F: hw/mips/jazz.c
 F: hw/display/jazz_led.c
 F: hw/dma/rc4030.c
 
@@ -1061,7 +1061,7 @@ R: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
 F: hw/isa/piix4.c
 F: hw/acpi/piix4.c
-F: hw/mips/mips_malta.c
+F: hw/mips/malta.c
 F: hw/mips/gt64xxx_pci.c
 F: include/hw/southbridge/piix.h
 F: tests/acceptance/linux_ssh_mips_malta.py
@@ -1071,7 +1071,7 @@ Mipssim
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
 S: Odd Fixes
-F: hw/mips/mips_mipssim.c
+F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
 
 R4000
@@ -1079,7 +1079,7 @@ M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
 S: Obsolete
-F: hw/mips/mips_r4k.c
+F: hw/mips/r4k.c
 
 Fuloong 2E
 M: Huacai Chen <chenhc@lemote.com>
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 8ab41edc3f..739e2b7b40 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,8 +1,8 @@
 obj-y += addr.o mips_int.o
-obj-$(CONFIG_R4K) += mips_r4k.o
-obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
-obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
-obj-$(CONFIG_JAZZ) += mips_jazz.o
+obj-$(CONFIG_R4K) += r4k.o
+obj-$(CONFIG_MALTA) += gt64xxx_pci.o malta.o
+obj-$(CONFIG_MIPSSIM) += mipssim.o
+obj-$(CONFIG_JAZZ) += jazz.o
 obj-$(CONFIG_FULOONG) += fuloong2e.o
 obj-$(CONFIG_MIPS_CPS) += cps.o
 obj-$(CONFIG_MIPS_BOSTON) += boston.o
-- 
2.21.3


