Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A737C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236B4204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1mfZZSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236B4204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZlE-0005yg-Bj
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhh-0006q3-82
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:13 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:46722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhg-0005qy-8O
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:12 -0400
Received: by mail-ej1-x62d.google.com with SMTP id e2so23773812eje.13
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pPV3t0ciHdfu4yziGudCLa1nZMiogySec4g5RazN6FY=;
 b=W1mfZZSFWow35xwNsVIdReKxgBP3yyskiyFSYhIimtM3idRn7OTYuov7YAxyJMFcbt
 qy8CEuiLxo1JgT5vbtlGVHg3fzHlYH7Nh7tI2KhOByAXKuXBbbvwmfZs86azK2WO64Jp
 zw3lpPe7LzRsJV+uozP/yea5/Wey1ZDfziScfO2X4pW5WdY3rG1IYL3/RpYRckjqJ5PH
 IXATvGV6driLpV2vnkivt05CEVrTukqcezBMnhRQQqCAhq8Y7R6EmvHMISHYqPD2dMJB
 /EhLyiUP+GWdq5SZSBtkRj9Mxmj/S2WaElDR5/cmqK2/k4iBXH8Zb02f5obRlC76EUPd
 BFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pPV3t0ciHdfu4yziGudCLa1nZMiogySec4g5RazN6FY=;
 b=XKuAxg/puMbhb5+0jJqY2sxLa3mSbfEvASXGHLecVoBMozn8LXKpNanNGuRFutBxkP
 TTs4AvmOE2WSJpGQ5VQDh+zkFFwWMuq1H0qd7D6oIAvyxu4TO0kt8K/xStaeOkZNiUy4
 6DRDkQYizP6nDkxURytq8JYfVGqb6MCv7M137z7PwS9I6B6Ebcy3We1DQxMZAVNTXKmh
 JRQ74BJxCK2FS71FSBbSnQUXxnMrXgws/LVCJ12j5hJ8HnkaWgcyxc/Bcv32q2py4HFm
 j9XQGVamsr/C2bUvX4AzLxn7jWyFNJ5dwlPlcJELWwYMBUEeImiEGdl4RQfhSk5P7xWg
 Jz3w==
X-Gm-Message-State: AOAM532wAVMPeMIIpCnBG4T9FoTcHOMhfbTCTAWx7Z+WrDZB7q58QYPh
 JkkF+g4cvVow4rv50kOpDSkE/0UAjDY=
X-Google-Smtp-Source: ABdhPJxZQ3xrejlUHBn6UZjExFOrdzOzBr3xqGngyOSsnoUpEWmtvMLtz2AmdpSlStqjzl+MjhOlIA==
X-Received: by 2002:a17:906:edb5:: with SMTP id
 sa21mr1161894ejb.78.1590499990526; 
 Tue, 26 May 2020 06:33:10 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:33:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] MAINTAINERS: Change Aleksandar Rikalo's email address
Date: Tue, 26 May 2020 15:32:47 +0200
Message-Id: <20200526133247.13066-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62d.google.com
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

Aleksandar Rikalo wants to use a different email address from
now on.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-id: <20200518200920.17344-18-aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap    |  3 ++-
 MAINTAINERS | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6412067bde..e3628c7a66 100644
--- a/.mailmap
+++ b/.mailmap
@@ -42,7 +42,8 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgtec.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
-Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
+Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
+Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index f46ab150dc..a209b5d8ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,7 +213,7 @@ F: disas/microblaze.c
 MIPS TCG CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: target/mips/
 F: default-configs/*mips*
@@ -1048,7 +1048,7 @@ MIPS Machines
 -------------
 Jazz
 M: Hervé Poussineau <hpoussin@reactos.org>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/mips/jazz.c
 F: hw/display/jazz_led.c
@@ -1069,7 +1069,7 @@ F: tests/acceptance/machine_mips_malta.py
 
 Mipssim
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Odd Fixes
 F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
@@ -1077,7 +1077,7 @@ F: hw/net/mipsnet.c
 R4000
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
 F: hw/mips/r4k.c
 
@@ -1094,7 +1094,7 @@ F: include/hw/isa/vt82c686.h
 
 Boston
 M: Paul Burton <pburton@wavecomp.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
@@ -2608,7 +2608,7 @@ F: disas/i386.c
 MIPS TCG target
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: tcg/mips/
 
-- 
2.21.3


