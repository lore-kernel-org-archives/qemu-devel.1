Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2952BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FA12081A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcJh4wwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FA12081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamOh-0006O6-Vp
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam65-0006vN-Vm
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:50 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam64-0002NE-V2
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:49 -0400
Received: by mail-lj1-x244.google.com with SMTP id b6so11272562ljj.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=16A5CwI2EnCxArSchxjBGvCjmT9+XlV8j9LlMxMq0GU=;
 b=IcJh4wwOhCV6rEm9+OiXI0+dMfdx2j/YPyNW7UdHzbIw9+QR37GM8wqccD0uTAIDpL
 106Un3Ep0xn0LlLLkio7wzvGLN8lxoodqhhqAseyox4Cpt6EQq/j9bYw1CMWdGofrFIa
 WZJtBZFFwchG4S8BPjwUa+/gleSuW20AclqCuoi76jdNQDK+YPMMjxLT6lKEBKUoXrEt
 i8IsdZ2rpw4JIxB86z2L30ti87lBZCPH8/2n3T79xW6pW54RfxdYMy+DWgFxwdtXUXId
 Zr5Lg0oK46u23mr9ZCokgYz0lbypEWO4Mfj+m0m3ct8Z84ccqMPpiG+uCJpK6UTEhoGC
 iOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=16A5CwI2EnCxArSchxjBGvCjmT9+XlV8j9LlMxMq0GU=;
 b=X6DHmtvmiV1GJr62e8nXFZ+dgomi/PLNxB7uEck1b+15u8nq0BOHzBc63I+Q7GkOin
 RLG+Xg3WF5NCdQDFInF0k6/q+Fq6uiSsUdUQ7Sa0X9N5hokVj5qC6Fv2ANebqLC6Fv+7
 dfFAVQ72J8TWG/gTBU9jl/0A9+NoV1Cnuz8ws+GcXOAYZfq6/HOwM7QxCTuMQq8uhXmC
 J44zlo6QoH2xLlXl4Y6zTek34hRxrVpDTLZCKtrR/ZMMX21X1ETp60tDWgGYIx6UxWXs
 NHsEAQ5f57E7Xh9M8YkTH2jsgVRTRDWcOiXX1RIzyUjosa34PwA63pBM36ARLqAMw0V/
 vzuA==
X-Gm-Message-State: AOAM531E5EvYFLo03+WsvCklnnb+CzSiktrj/82g45iTSHMnO96wKjd2
 hL2X6tly8A4gY0/TIVr8VnQ+nT9wrI0=
X-Google-Smtp-Source: ABdhPJzsizc49LD9OpCnKiFlaV4olTPSvt2AODV4K//cdHhgTI2tGQzID47myTWhx5oAX5VZJupLrA==
X-Received: by 2002:a2e:870d:: with SMTP id m13mr11274949lji.64.1589832647058; 
 Mon, 18 May 2020 13:10:47 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:46 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 21/21] hw/mips: Rename malta/mipssim/r4k/jazz files in
 hw/mips
Date: Mon, 18 May 2020 22:09:20 +0200
Message-Id: <20200518200920.17344-22-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Machine file names should not have prefix "mips_".

Fuloong2e machine source file will be handled in a separate patch,
to avoid conflicts. That patch is pending integration into the
main tree.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 MAINTAINERS                           | 9 ++++-----
 hw/mips/Makefile.objs                 | 8 ++++----
 hw/mips/{mips_jazz.c => jazz.c}       | 0
 hw/mips/{mips_malta.c => malta.c}     | 0
 hw/mips/{mips_mipssim.c => mipssim.c} | 0
 hw/mips/{mips_r4k.c => r4k.c}         | 0
 6 files changed, 8 insertions(+), 9 deletions(-)
 rename hw/mips/{mips_jazz.c => jazz.c} (100%)
 rename hw/mips/{mips_malta.c => malta.c} (100%)
 rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
 rename hw/mips/{mips_r4k.c => r4k.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5562c5c7..883d15c9d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11,7 +11,6 @@ consult qemu-devel and not any specific individual privately.
 
 Descriptions of section entries:
 
-	M: Mail patches to: FullName <address@domain>
 	   Maintainers are looking after a certain area and must be CCed on
 	   patches. They are considered the main contact point.
 	R: Designated reviewer: FullName <address@domain>
@@ -1043,7 +1042,7 @@ Jazz
 M: Hervé Poussineau <hpoussin@reactos.org>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
-F: hw/mips/mips_jazz.c
+F: hw/mips/jazz.c
 F: hw/display/jazz_led.c
 F: hw/dma/rc4030.c
 
@@ -1054,7 +1053,7 @@ R: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
 F: hw/isa/piix4.c
 F: hw/acpi/piix4.c
-F: hw/mips/mips_malta.c
+F: hw/mips/malta.c
 F: hw/mips/gt64xxx_pci.c
 F: include/hw/southbridge/piix.h
 F: tests/acceptance/linux_ssh_mips_malta.py
@@ -1064,7 +1063,7 @@ Mipssim
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Odd Fixes
-F: hw/mips/mips_mipssim.c
+F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
 
 R4000
@@ -1072,7 +1071,7 @@ M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
-F: hw/mips/mips_r4k.c
+F: hw/mips/r4k.c
 
 Fulong 2E
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 525809af07..1d767ed9a8 100644
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
 obj-$(CONFIG_FULONG) += mips_fulong2e.o
 obj-$(CONFIG_MIPS_CPS) += cps.o
 obj-$(CONFIG_MIPS_BOSTON) += boston.o
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
-- 
2.20.1


