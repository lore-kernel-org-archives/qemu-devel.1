Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B655C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387B4207F9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDCq0Qlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387B4207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalv3-0002RK-9H
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaler-000392-DL
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:42 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleq-0004ea-LF
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:41 -0400
Received: by mail-lf1-x144.google.com with SMTP id w15so1790521lfe.11
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=16A5CwI2EnCxArSchxjBGvCjmT9+XlV8j9LlMxMq0GU=;
 b=nDCq0QlxF64TGbe+i8iUAm22ImkMXPf02rPhsyDjqrgVTpqi6zqeYapK3LbHKoANP2
 DdfouF1spoEbsr+VTOBCo/gL9HN9NpyBUHue6LAF3JsYPJqQa+Jesv76+BNLxN+g+2/P
 Vl4ZILcfkKWZwsjACgZJf59wh4qrbXAA9y+P1JBYxPKK4pA+X/9wCWza+YzJem24JORc
 9snXpXTXwWV+QUkNMc7YIDPNOpYU2k4MlgBPrfbe1cwzYpIMx7Vhd9qv9NHGVgZKRrqZ
 ot6ULLlwscGmJ/kXST1Xeue9pCLfefE7xQbObsxWKB6zNRVA1bt5nBIAHqjbijjpeowS
 rCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=16A5CwI2EnCxArSchxjBGvCjmT9+XlV8j9LlMxMq0GU=;
 b=rQmmzZmaMS4MPa5ujPpLzchpA2CcL9h4AyMA2CL0qEzKP3Z8l2vMheRKZ2a0kfI/ei
 G+FzvBtrxIha+NF6Jo8QFiuBx4J18i/l5es38cBBtwObULmlkKpI0CEfWNXMEH/iJkQp
 CzX6OqpnkhNvtkVagYHRLe7raSqBegYKn1D/BINKiJffZ9thzH2SPin/lBfP6dXK/4um
 o1hpsfKQ4U2PgFfKwB34Rbz/b1DFQUK0x71NXX84cqQw6ORO4KlpYvWJI96LFCT4V2IV
 mcFx+61Y7ffNIs/BwxSN9sV+b6WVViq9+n+zgcp/8zfAZQgsf/9PoF0G1FecmlAM6S/U
 i5jQ==
X-Gm-Message-State: AOAM530FHQB1MyYk/gSEpJSBcitH/Wd6KgD8D2+GOsokixlzKbDUBkEQ
 8+3hpBfHmaRlF0vRI36hepYF/EXMZVc=
X-Google-Smtp-Source: ABdhPJzfWPV9HxQ6rd3cFBj/EFh0JCkxsoWJsRIGENIu4EehFHsl4wox9zumHlfs9h6WiZzw2mQH0g==
X-Received: by 2002:ac2:4823:: with SMTP id 3mr12567630lft.194.1589830958972; 
 Mon, 18 May 2020 12:42:38 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:38 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 22/22] hw/mips: Rename malta/mipssim/r4k/jazz files in
 hw/mips
Date: Mon, 18 May 2020 21:41:49 +0200
Message-Id: <20200518194149.16281-23-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x144.google.com
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


