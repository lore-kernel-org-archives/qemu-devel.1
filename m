Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8ADC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB79120673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ehnx9x3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB79120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipx0l-0005Ax-QP
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipwxc-0002Mz-VM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipwxb-0007eO-IS
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:16:32 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipwxb-0007bQ-Ab
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:16:31 -0500
Received: by mail-wr1-x444.google.com with SMTP id d16so2337381wre.10
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 08:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/2rz7VQka3qxbrkZEEttqfVPhw4gsf0iHRHcpHx8kNI=;
 b=Ehnx9x3ov/ICYOB9vYRNMy59Q4C2tK6xC6G9R2bPyYWbLWtO0QinyB0+2ZsGDGdj8J
 47QRfcOyF5EKE7voQQ/zh2vsqYmLz5BKquxObbKWebKL6ksNBWhApCR2sXKWhjKYOZPz
 39LeJlUvulT4vUGiJD2s8fhg5gWZHw5vfmL/JWNjUi3rsjHSnHGTzsqw4367Q/0seXqz
 qryFJ4b5k72nJ+Gt9/Z1kz5QD4R+V8+7s8juqmGfcSpQEBKbNifZN6xlFSfPCj3PcNe7
 HqlQ/hEK//xHNeNpj0+Ow0BMflsz7cwVHOe+ZExrn2lpf8IpX1CsP2E3jxlOnDsL/1Kc
 MClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/2rz7VQka3qxbrkZEEttqfVPhw4gsf0iHRHcpHx8kNI=;
 b=YhyZNOO7Ef9jraNNKuQor39ymNm5GaJmzjdWEeiKoh1GBKT2MYUZViQh0FvjHInBs3
 nKSHRplZzcy/Y4DzNE/57fbKziM7dxxhyxDaKj6Op3SBRvqoIXfXsLls5BBpvnElfpyW
 uVe35RicyhgsJZkUROhLzzf0YfbyBFC6upkBdh3n/dCuttufhKJZpBhHZHLrf7uyIdw1
 /n9gLb/kmmhdZNpzikQbcMCqpxbz+MGmqgSospN5cKt9HavdHy9IxDJK9qtymQvfkOK4
 Pu4iKEbSCX0Y0hH/RU3nYNvVzz34Bo6QIBsNOm6AkmexoWaCfXyM2/QclybhMcH4rrY5
 NZ5Q==
X-Gm-Message-State: APjAAAVRODjAurf0CgNAzvwic/nk660Xuohll8mFvhl3bvkrcHME7tm2
 7w9q9ImIUd8e0XsqYIbgyvxOuA==
X-Google-Smtp-Source: APXvYqzBosUUlpCfqU5QqQmbDKPFIHn37l0LH+W7eqXbmoPsW6eir9mHjl5xs3JLZZLTVcuESB0Fbw==
X-Received: by 2002:adf:f885:: with SMTP id u5mr4478652wrp.359.1578672990296; 
 Fri, 10 Jan 2020 08:16:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n189sm2823804wme.33.2020.01.10.08.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 08:16:28 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 769031FF8F;
 Fri, 10 Jan 2020 16:16:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/2] tests/tcg: add a vtimer test for aarch64
Date: Fri, 10 Jan 2020 16:16:26 +0000
Message-Id: <20200110161626.31943-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110161626.31943-1-alex.bennee@linaro.org>
References: <20200110161626.31943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bug: https://bugs.launchpad.net/bugs/1859021

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/vtimer.c         | 80 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  4 ++
 2 files changed, 84 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/vtimer.c

diff --git a/tests/tcg/aarch64/system/vtimer.c b/tests/tcg/aarch64/system/vtimer.c
new file mode 100644
index 00000000000..2f6299b5d2c
--- /dev/null
+++ b/tests/tcg/aarch64/system/vtimer.c
@@ -0,0 +1,80 @@
+/*
+ * Simple Virtual Timer Tests
+ *
+ * Note: kvm-unit-tests has a much more comprehensive exercising of
+ * the timer sub-system. However this test case can tweak _EL2 values
+ * to trigger bugs which can't be done with that.
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <inttypes.h>
+#include <minilib.h>
+
+/* grabbed from Linux */
+#define __stringify_1(x...) #x
+#define __stringify(x...)   __stringify_1(x)
+
+#define read_sysreg(r) ({                                           \
+            uint64_t __val;                                         \
+            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
+            __val;                                                  \
+})
+
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " __stringify(r) ", %x0"  \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+/* Physical Counter */
+static uint64_t last_pct;
+/* Timer Values */
+static uint32_t last_phys_tval;
+static uint32_t last_virt_tval;
+
+static void dump_status(void)
+{
+    uint64_t pct = read_sysreg(cntpct_el0);
+    uint32_t phys_tval = read_sysreg(cntp_tval_el0);
+    uint32_t virt_tval = read_sysreg(cntv_tval_el0);
+
+    ml_printf("timer values:\n");
+    /* the physical timer monotonically increments */
+    ml_printf("cntpct_el0=%ld (+%ld)\n", pct, pct - last_pct);
+    /* the various tvals decrement based on cval */
+    ml_printf("cntp_tval_el0=%ld (-%ld)\n", phys_tval,
+              last_phys_tval - phys_tval);
+    ml_printf("cntv_tval_el0=%ld (-%ld)\n", virt_tval,
+              last_virt_tval - virt_tval);
+
+    last_pct = pct;
+    last_phys_tval = phys_tval;
+    last_virt_tval = virt_tval;
+}
+
+int main(void)
+{
+    int i;
+
+    ml_printf("VTimer Tests\n");
+
+    dump_status();
+
+    ml_printf("Tweaking voff_el2 and cval\n");
+    write_sysreg(cntvoff_el2, 1);
+    write_sysreg(cntv_cval_el0, -1);
+
+    dump_status();
+
+    ml_printf("Enabling timer IRQs\n");
+    write_sysreg(cntv_ctl_el0, 1);
+    /* for bug 1859021 we hang here */
+
+    dump_status();
+
+    ml_printf("End of Vtimer test\n");
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 7b4eede3f07..62cdddbb215 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -62,3 +62,7 @@ run-memory-replay: memory-replay run-memory-record
 	  "$< on $(TARGET_NAME)")
 
 EXTRA_TESTS+=memory-record memory-replay
+
+# vtimer test
+QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
+run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_SEMIHOST)  -kernel
-- 
2.20.1


