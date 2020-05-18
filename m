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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F11DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DB320657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPYWizxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DB320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalsX-0007ok-At
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jalem-00036S-Ts
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:36 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:45678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jalek-0004dP-R4
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:36 -0400
Received: by mail-lf1-x131.google.com with SMTP id a4so9129597lfh.12
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ITjMgpxMDXhLrKll92k92Sf+OWlp5gufeGg5gaD7lw=;
 b=bPYWizxeol3qNe6vy1pQAkiUlapi3s8Lxy/ocPLMgF9CxIuKkayl7QTJibJFCILlZ6
 n4Thj8boZJe5/3tvv55N4stmB8pzQahB16V1KXaC5cj1Y8rSxdTLD7biaCPt8QfoIcKc
 Yudr3P8tysrSG7vQaowvTpJDaU7/84Jd0imIbdn8ZEivKa76JR4atINVBLB1cJMw9h9o
 H7TcBw5yYXEf7c1JEXCBrS1GZznDxqqa3ozkiuKHf52LT3XrJ6QIA4wmspTgBx78eKcW
 wzERVN0rbJv1DKxh7C++ireU6tH98qfUEwUImpJYwwQlTArP/letAmBV2qVwp0wD0DEn
 jLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ITjMgpxMDXhLrKll92k92Sf+OWlp5gufeGg5gaD7lw=;
 b=eDLixE+rhLsGzXm3J2LRpwi7fB5Wvk0Y/2xziqzwiuSamcrnG8NRDS7g88q4TJszWO
 eHJXKKVfPoL/qaKROTyET95hdG5kcoSDkaS85jOw3gTKYzETcHrKxSistarRoy8LfJNt
 UDJ5XjWRRlwMGg1nzwr9T3kewslrD+bqLV95TtS8OR8LZbFJ8FlEeU4+TvlUMlXF0M1z
 Z30bsCk0GkJaZHh78YakqXYj8rwsCDOlUaamWWH9KBfCinzWX4FrSlVaGnmzjicxQuYm
 DoTIzKZfE+8Eq/L2Vu9uhGU/WOdZdKvihZtu/xFinsizqP5FuI9zOpVPYzTZONAvhPua
 Jdpg==
X-Gm-Message-State: AOAM533NeI/3NMnmey5GCPuJIIV8PZZgiO3IgDY2FxqpTtWCXdEmNDFc
 QlPb3Py1CZkPWcabSZVYGbL/uWCc9Z8=
X-Google-Smtp-Source: ABdhPJzWPJ/BIDHK0lU8YMsKhZfQE7sXQvMlqiafDwWJziTrxKXmuglt+USh1+B8cgd8WyBBIl/9Mg==
X-Received: by 2002:ac2:490f:: with SMTP id n15mr110316lfi.39.1589830953138;
 Mon, 18 May 2020 12:42:33 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:32 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 18/22] MAINTAINERS: Change Aleksandar Rikalo's email address
Date: Mon, 18 May 2020 21:41:45 +0200
Message-Id: <20200518194149.16281-19-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x131.google.com
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

Aleksandar Rikalo wants to use a different email address from
now on.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
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
index 1f84e3ae2c..8d5562c5c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -212,7 +212,7 @@ F: disas/microblaze.c
 MIPS TCG CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: target/mips/
 F: default-configs/*mips*
@@ -1041,7 +1041,7 @@ MIPS Machines
 -------------
 Jazz
 M: Hervé Poussineau <hpoussin@reactos.org>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/mips/mips_jazz.c
 F: hw/display/jazz_led.c
@@ -1062,7 +1062,7 @@ F: tests/acceptance/machine_mips_malta.py
 
 Mipssim
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
@@ -1070,7 +1070,7 @@ F: hw/net/mipsnet.c
 R4000
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
 F: hw/mips/mips_r4k.c
 
@@ -1085,7 +1085,7 @@ F: include/hw/isa/vt82c686.h
 
 Boston
 M: Paul Burton <pburton@wavecomp.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
@@ -2582,7 +2582,7 @@ F: disas/i386.c
 MIPS TCG target
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: tcg/mips/
 
-- 
2.20.1


