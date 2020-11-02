Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE13C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8766920719
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnNfx/11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8766920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZgRD-00030G-Jf
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 15:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZgQA-0002Fz-87
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:27:18 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZgQ6-0006Ep-Cn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:27:17 -0500
Received: by mail-wr1-x444.google.com with SMTP id 33so5307866wrl.7
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uqHENuL4QJbfUEuOBxABwE/aayi9/vXG1LiDAXkWbaA=;
 b=ZnNfx/11NvuV2dUksK4uEjaBptqr8qcrWGd6CQjp32bXAg5rpMzIwQ8njZq64xmXMw
 FqFwcqwoPE70AcN/19srB4FSHNljn3q9tsWE/5KlvOh9z2i3t6Aohvwr+ITZ03aQXVRI
 tdXv/ybPFJkS89Fe+joMCFDl0tqZvJKQdYvQyEQ/ajtZzZ52xoynmqLNINtzhVuON0hN
 6Op4AGS0S9zSVCZL46jmSK6pc1A6wiP5i9pQjuXUOPK8e1PQhu2jZvZafEQWnOPRF0MU
 BmngoRSIilW9Ql70RLid9PjINaueebbPmEfnjVbIL/+I39KChB4iOXP9DUJfEk8v1QpX
 fZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=uqHENuL4QJbfUEuOBxABwE/aayi9/vXG1LiDAXkWbaA=;
 b=rNVZOUfEUSojjvSJEL0upr7L05rz474Hwoa/l1+5BK+HHF/FIyBx1efTfbIrG9w3oi
 JKBP297GbSzyr5Eo6wJIub0yqW+T4QERyN7WSorVDkWjMBvM1amvRISMkM4KifUrIuEo
 FCH3cl7bXvOkXu6THWUoVwrGBpE9Ljn3NNC6KNTUeJ3KvmGzzxWWzToYbCw1Wk2+HAXG
 3CvIjiqBAfHWzrXL2kNnHujwbwDn58sWe/gIdU0E01j6M/IbQS7yzvWGEc00p8J9icFy
 /Oh5snKYR0jVdR4yNSg6Cp+2AsIMv35fUXTY9J6vaWdeJ5kHU86EGv2qSe1id1y1bAz9
 TCrA==
X-Gm-Message-State: AOAM5335ZdiZXO7s3HEqwRB8gAC60W71yQfLfh3XmeGH7fxvOmJ5ITVT
 B/bDc8vc4zXXF7OX3ZL9MIGc8I+dBlw=
X-Google-Smtp-Source: ABdhPJwq/h5xiSMNaHM9qshSLqkxVJeyuFcbM6/z8CCE+J83T7LmIwt6TpIGa1aDzUDy7GFYW5iNCw==
X-Received: by 2002:adf:a553:: with SMTP id j19mr22069442wrb.349.1604348832482; 
 Mon, 02 Nov 2020 12:27:12 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id k22sm587400wmi.34.2020.11.02.12.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 12:27:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] target/mips: Deprecate nanoMIPS ISA
Date: Mon,  2 Nov 2020 21:27:10 +0100
Message-Id: <20201102202710.2224691-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
 Paul Burton <paulburton@kernel.org>, libvir-list@redhat.com,
 James Hogan <jhogan@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The nanoMIPS ISA has been announced in 2018 for various projects:

GCC:   https://gcc.gnu.org/legacy-ml/gcc/2018-05/msg00012.html
Linux: https://lwn.net/Articles/753605/
QEMU:  https://www.mail-archive.com/qemu-devel@nongnu.org/msg530721.html

Unfortunately the links referenced doesn't work anymore (www.mips.com).

From this Wayback machine link [1] we can get to a working place to
download a toolchain (a more recent release than the one referenced
in the announcement mails):
http://codescape.mips.com/components/toolchain/nanomips/2018.04-02/downloads.html

The toolchain page mention LLVM but simply links http://llvm.org/
where there is no reference on nanoMIPS.

The only reference in the GCC mailing list, is the nanoMIPS
announcement: https://gcc.gnu.org/pipermail/gcc/2018-May.txt

The developer who authored the announcements have been emailed [2]
to ask for more information but all their emails are now bouncing:

- Your message to Stefan.Markovic@mips.com couldn't be delivered.

- Your message to smarkovic@wavecomp.com couldn't be delivered.

- Couldn't deliver the message to the following recipients:
    Robert.Suchanek@mips.com, matthew.fortune@mips.com,
    marcin.nowakowski@mips.com

Our deprecation policy do not allow feature removal before 2 release,
therefore declare the nanoMIPS ISA code deprecated as of QEMU 5.2.
This gives time to developers to update the QEMU community, or
interested parties to step in to maintain this code.

[1] https://web.archive.org/web/20180904044530/https://www.mips.com/develop/tools/compilers/
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg756392.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/deprecated.rst | 23 +++++++++++++++++++++++
 MAINTAINERS                |  6 +++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 32a0e620dbb..a26af200c73 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -310,6 +310,13 @@ to build binaries for it.
 ``Icelake-Client`` CPU Models are deprecated. Use ``Icelake-Server`` CPU
 Models instead.
 
+MIPS ``I7200`` CPU Model (since 5.2)
+''''''''''''''''''''''''''''''''''''
+
+The ``I7200`` guest CPU relies on the nanoMIPS ISA, which is deprecated
+(the ISA has never been upstreamed to a compiler toolchain). Therefore
+this CPU is also deprecated.
+
 System emulator devices
 -----------------------
 
@@ -413,6 +420,13 @@ The ``ppc64abi32`` architecture has a number of issues which regularly
 trip up our CI testing and is suspected to be quite broken. For that
 reason the maintainers strongly suspect no one actually uses it.
 
+MIPS ``I7200`` CPU (since 5.2)
+''''''''''''''''''''''''''''''
+
+The ``I7200`` guest CPU relies on the nanoMIPS ISA, which is deprecated
+(the ISA has never been upstreamed to a compiler toolchain). Therefore
+this CPU is also deprecated.
+
 Related binaries
 ----------------
 
@@ -477,6 +491,15 @@ versions, aliases will point to newer CPU model versions
 depending on the machine type, so management software must
 resolve CPU model aliases before starting a virtual machine.
 
+Guest Emulator ISAs
+-------------------
+
+nanoMIPS ISA
+''''''''''''
+
+The ``nanoMIPS`` ISA has never been upstreamed to any compiler toolchain.
+As it is hard to generate binaries for it, declare it deprecated.
+
 
 Recently removed features
 =========================
diff --git a/MAINTAINERS b/MAINTAINERS
index 2c22bbca5ac..4f701012eea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -227,7 +227,7 @@ R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Odd Fixes
 F: target/mips/
 F: default-configs/*mips*
-F: disas/*mips*
+F: disas/mips.c
 F: docs/system/cpu-models-mips.rst.inc
 F: hw/intc/mips_gic.c
 F: hw/mips/
@@ -240,6 +240,10 @@ F: include/hw/timer/mips_gictimer.h
 F: tests/tcg/mips/
 K: ^Subject:.*(?i)mips
 
+MIPS TCG CPUs (nanoMIPS ISA)
+S: Orphan
+F: disas/nanomips.*
+
 Moxie TCG CPUs
 M: Anthony Green <green@moxielogic.com>
 S: Maintained
-- 
2.26.2


