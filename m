Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA749C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B414B20661
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3mLT85+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B414B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSau-0003uN-0Z
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 11:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTSYf-0000Xi-7N
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTSUs-0007AL-6n
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTSUr-00079l-Nn; Tue, 28 Apr 2020 11:50:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id g13so25229641wrb.8;
 Tue, 28 Apr 2020 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sf14oS2GltqACboZYW3TtfGDUWMhQH2NEauPtmLwgGs=;
 b=h3mLT85+GgkHeVuaeMyDP4n/XAZpk5EE6+Be0FyldMekdacH6/eE2Av9Z+U8UbyY9K
 A+Qd+Zi+Q83+AR6HROs0bgdtwjFFKybzak4Q/BYWSfoN95GgfvI1R87x7IWi0wqygVr6
 JwoprFL0u1WEWh4QWmfMiHtmXSXl97q+PKyfJbMBbTCmFmd9C2qUsWhwwqaRrLZua+Kp
 sYQtJ1JkI7AIsqt8KRSoglvVMLdOF2q6k1HGibRCq+B0e8vU33WZuEM1uz2t6fdHrYRf
 8kJtQDZGtc3v+MD520JZAN0N1nY6Ap9Tyboo9aunKUUypIXzd85viLhh9YvB3smnahf4
 PfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=sf14oS2GltqACboZYW3TtfGDUWMhQH2NEauPtmLwgGs=;
 b=AMFZGDUVmm/Yv59W0kCl9KDLE4fb6A9awWZH/RVetw4cFUiSJsJ9PSiA4yULv12eLr
 G0M54dVkAbxFGJ70NwCpMzaN7ixwNcK3Wje8c+J5xdq4dx6kfE4SajK1DB4POMwSH3wS
 C0Tp1aZoS/22+/x8kcahfePKQsJREqzaLN9iErPp1AlVTcGFRoQ/HaXZVBp3yCgo9/06
 QYvFguDP7i73m376J7SJSWhOZkkKrLb0DZB/IwxHaHJKLJxW+lVv9t+pzkryGoq2XCsk
 526hqYZX6Fbtnb7W38sktf/YrHk2g4RxRIaPhBei7NSbJrttRnNuOKr5BXKqavbG6Ze3
 EpRw==
X-Gm-Message-State: AGi0PuZHCv+VOVXBk3NeUjr9srXFHIO54Xm0I2+kAuldSEW+NiAXx9qW
 6NEbYy0TkbMcSPXhD49rovTJNpYXlFk=
X-Google-Smtp-Source: APiQypIhPK+mLhTzhYDqmusZbnyzer1aZHJCzZP1wyFp2X8g+W1pp/4fB8TUwAPaWmjDRgD6fExLag==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr32597974wrn.176.1588089007248; 
 Tue, 28 Apr 2020 08:50:07 -0700 (PDT)
Received: from x1w.redhat.com (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id t8sm25983160wrq.88.2020.04.28.08.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 08:50:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] target/arm: Use correct variable for setting 'max' cpu's
 MIDR_EL1
Date: Tue, 28 Apr 2020 17:50:05 +0200
Message-Id: <20200428155005.25537-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIDR_EL1 a 64-bit system register with the top 32-bit being RES0.

This fixes when compiling with -Werror=conversion:

  target/arm/cpu64.c: In function ‘aarch64_max_initfn’:
  target/arm/cpu64.c:628:21: error: conversion from ‘uint64_t’ {aka ‘long unsigned int’} to ‘uint32_t’ {aka ‘unsigned int’} may change value [-Werror=conversion]
    628 |         cpu->midr = t;
        |                     ^

Suggested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I suppose cp15.c0_cpuid register in target/arm/cpu.h as uint32_t is OK.

Since v1: Follow Laurent and Peter suggestion.
---
 target/arm/cpu.h | 3 ++-
 target/arm/cpu.c | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8b9f2961ba..4d1be56df9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -894,7 +894,7 @@ struct ARMCPU {
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
     } isar;
-    uint32_t midr;
+    uint64_t midr;
     uint32_t revidr;
     uint32_t reset_fpsid;
     uint32_t ctr;
@@ -1685,6 +1685,7 @@ FIELD(MIDR_EL1, PARTNUM, 4, 12)
 FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
 FIELD(MIDR_EL1, VARIANT, 20, 4)
 FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
+FIELD(MIDR_EL1, RESERVED, 32, 32)
 
 FIELD(ID_ISAR0, SWAP, 0, 4)
 FIELD(ID_ISAR0, BITCOUNT, 4, 4)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a79f233b17..aaa48e06ac 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1182,6 +1182,8 @@ void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
+    assert(FIELD_EX64(cpu->midr, MIDR_EL1, RESERVED) == 0);
+
     /* M profile implies PMSA. We have to do this here rather than
      * in realize with the other feature-implication checks because
      * we look at the PMSA bit to see if we should add some properties.
@@ -2757,7 +2759,7 @@ static const ARMCPUInfo arm_cpus[] = {
 static Property arm_cpu_properties[] = {
     DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, false),
     DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
-    DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
+    DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
-- 
2.21.1


