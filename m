Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACFAC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A42D2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aA0pRjpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A42D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43247 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTulD-0007IE-R7
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:56:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTuf4-0001nz-Lm
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTuf3-00082u-55
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:50:02 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:44740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTuf3-000825-0u
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:50:01 -0400
Received: by mail-yw1-xc44.google.com with SMTP id e74so2785574ywe.11
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=89c0fdelMOQBOKzPc2d58OosG314dIUv3FUhe7nqhm8=;
	b=aA0pRjpqVZMtJL8Z2wvJolEqrod/Dl90UG7CBd47S8m1/5GbSnZxWqwGB1oXrZYNDz
	dvdsiIW3Q1YfS6cRQ7zRvhjYjmtn7GC8vYDBTVdzq2b4+ns9i1ZMajOe8mTE3ZliWa1U
	82Dz1Bdq7fQ1fY51t4ogTjBcCzC7hJr8RIroXzf/FsFD24+g2kC6z/u7xT2Flp31gTcg
	RtEilqK8J79u4Kr8S/ujjaTQ9QjsG7HOnokrXCsAmrk3SqO1jLl4RQP1mvG0LDh43YvX
	PGC9yBm+uEUmP72SuMArlPiSqxkC/ZnfNdj1YIkILulobNzHnj8S/u1g/ohkydgO+OCy
	HkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=89c0fdelMOQBOKzPc2d58OosG314dIUv3FUhe7nqhm8=;
	b=syvWo8iGg+VwfVjKftULosfZKk0LIEkx5inLt36+L3aU4jl6fnc3V2eKSF748BLxbc
	44n4Xu60V45hLglhOMvfsMzyHOQ6CBTGMbOV8CWt4I6eWNdveWTB9EQ0pATmZt2IE/7o
	k0u4aJ6wT6HrITp67EORDbuTI8Ca4y0ckx6kJrCb1BqVhIkTp77NJ6aB6RB6fgosOYFK
	5n3VuVFpwvJGHG5s8Sldsw8uJfxL5IIWneugux5s3qJN2b5DFkDKiZsEPXCRcJ7QIkE8
	5ymXOVmCb/lb4Nd1iaojSSvL3gJnBT6WK/Zj8t9WiAkKH3kqasjg7za/Vuqtx3mFuW3c
	xthQ==
X-Gm-Message-State: APjAAAXCuA3Yc6PiUZQjeXYGDyX/BRNPGELynfJSFaNnowW0Xh8xIHFP
	IFG+hm1rTKYO1h91ZFuNw8Xuwm2fTTs=
X-Google-Smtp-Source: APXvYqxH2b/xewhhMf01bxnxag4avY/U7MJWVD1kLNUJp5oWqP/bgUd5DW2oegZm/39nDWrvUoKilA==
X-Received: by 2002:a81:2f45:: with SMTP id v66mr34573570ywv.491.1558644599247;
	Thu, 23 May 2019 13:49:59 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.19])
	by smtp.gmail.com with ESMTPSA id j187sm98341ywj.32.2019.05.23.13.49.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:49:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:49:54 -0400
Message-Id: <20190523204954.13122-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523204954.13122-1-richard.henderson@linaro.org>
References: <20190523204954.13122-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [PATCH v2 2/2] capstone: Enable disassembly for s390x
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable s390x, aka SYSZ, in the git submodule build.
Set the capstone parameters for both s390x host and guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile           | 1 +
 disas.c            | 3 +++
 target/s390x/cpu.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index e02b88bcb1..3b49eed664 100644
--- a/Makefile
+++ b/Makefile
@@ -478,6 +478,7 @@ CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
 CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
+CAP_CFLAGS += -DCAPSTONE_HAS_SYSZ
 CAP_CFLAGS += -DCAPSTONE_HAS_X86
 
 subdir-capstone: .git-submodule-status
diff --git a/disas.c b/disas.c
index 41ad0102e2..4a63586af0 100644
--- a/disas.c
+++ b/disas.c
@@ -551,6 +551,9 @@ void disas(FILE *out, void *code, unsigned long size)
     print_insn = print_insn_m68k;
 #elif defined(__s390__)
     print_insn = print_insn_s390;
+    s.info.cap_arch = CS_ARCH_SYSZ;
+    s.info.cap_insn_unit = 2;
+    s.info.cap_insn_split = 6;
 #elif defined(__hppa__)
     print_insn = print_insn_hppa;
 #endif
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index b1df63d82c..553571d86b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -41,6 +41,7 @@
 #include "sysemu/sysemu.h"
 #endif
 #include "fpu/softfloat.h"
+#include "disas/capstone.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -175,6 +176,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->print_insn = print_insn_s390;
+    info->cap_arch = CS_ARCH_SYSZ;
+    info->cap_insn_unit = 2;
+    info->cap_insn_split = 6;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1


