Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9E8C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19B9206DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/poudOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19B9206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbuMb-000411-Ih
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuKg-0002O6-Of
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:42:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuKe-0002Ei-To
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:42:50 -0500
Received: by mail-wm1-x343.google.com with SMTP id c9so6430981wml.5
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MxQ+pwW2m0VYMWrMPbB6LNqF9/H+1tHtQq2Dtg175Wo=;
 b=I/poudOctBmDkEHg4dD0EKUZ7wv8ti6n9O0DPgCgLDfOpw7UtDnmxpSfIdC2rtunVv
 AVrLP2oK6KaFUY9RimyvjHP59C6P9PImP3XLuPxM7DwDKx9GmzA3eKSpLVmuhUwkiWUf
 cjwyKekPristMZi8BmYVRT4xjLd/eLxYBd1XBIWdwidNm1fKNADwGatpnvzh6gGZmbMn
 knXsR3SAF1XE61j2umOctIv41LtD2RDkvj3/7+783l27NoGEEMo36yDDpyaaNXJBL3hi
 CP8jjQHPr9DLyOeCtw5wp6C/gz2G1F4IqTp+fX8AAtFtTO1FoyMVwvPL44q3MpfHmPLP
 768A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MxQ+pwW2m0VYMWrMPbB6LNqF9/H+1tHtQq2Dtg175Wo=;
 b=gzoaNhfsQzu8ADPxVtb+vcr39W/kYexek/GiPyeEy5Tzw+1INU/wzd7FTEM3n1ZEL9
 w2GPNi8slyMn66BMQ+jnAaPadq1z26ZCUVFpK3PTXr/w182Dl869u0r9kAJ8NmDvtFHV
 L7X9cHoEjjUr1nYW1orOJREK1wpSDPDZCoEzwELjuq7r1EgzBF0nKfkYRpq3bI6qzOeN
 e5bQ1gMcmmBBWekzl8y1ELAW6BYy04Zprh6l2V6oM17aI7jK2Z75vRJpJPoRq9qjYqe9
 lEndAZjei9nAZNBynQfRicty0p1mv9FJaYtB/7/siETAWf2Y8Zv5UypH8Ej11LVT87C5
 Cv6Q==
X-Gm-Message-State: AOAM533DNsjAhripN9bQlqT5H/IZKj5jdacddwPOzZJkCkvaF1Jaricg
 6/xBxREnoOImyNb649kIu6PmspWyMvE=
X-Google-Smtp-Source: ABdhPJwqyXrN/wAAMFgOHJ4GtWCk2RGhFfzTnNsn6e5rlp9WoW8UTQNAfVfPVuKKEuytU2XTkjDa3A==
X-Received: by 2002:a1c:98cd:: with SMTP id a196mr10942949wme.42.1604878967195; 
 Sun, 08 Nov 2020 15:42:47 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x18sm12028207wrg.4.2020.11.08.15.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 15:42:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] target/mips: Deprecate nanoMIPS ISA
Date: Mon,  9 Nov 2020 00:42:32 +0100
Message-Id: <20201108234234.2389789-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108234234.2389789-1-f4bug@amsat.org>
References: <20201108234234.2389789-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
 Paul Burton <paulburton@kernel.org>, libvir-list@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20201102202710.2224691-1-f4bug@amsat.org>
---
 docs/system/deprecated.rst | 23 +++++++++++++++++++++++
 MAINTAINERS                |  6 +++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 8c1dc7645d7..bbaae0d97c3 100644
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
 
@@ -407,6 +414,13 @@ The ``ppc64abi32`` architecture has a number of issues which regularly
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
 
@@ -471,6 +485,15 @@ versions, aliases will point to newer CPU model versions
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
index 63223e1183d..16aace05624 100644
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


