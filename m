Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F65C55193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205CB2098B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNCYiAY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205CB2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfLU-00088B-4w
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIf-0000yi-4g
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIe-0005Ul-H4
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIe-0005TY-3p
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id k1so7728570wrx.4
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zg2dR+/RlCjvNQhC4AT2xzR1UuuQk7HaGZ9Y5groXFk=;
 b=pNCYiAY00eT6Apf7e5j30GROa+d8kski7hPFKxOATF3bumu1NIEVn4DsiEXLq4TJoI
 oR4AoEJWoxk2mKt1+30SaBLO+oXNzRMefh9OddYie9ipFJNSOHC/RcY24cIZRFQ+XCC0
 yHZhAhArqLosynIsJP+jg0vOtLiol2h0iUkVTxEklirzXYYZIQVdx2WdM1wmT3zHdTh5
 4Z/Z3n0FYMGXSlCuRvPlg18wcT9P89MXqBViOGfA9Bgrc/gGk+PccaPPdNZhYVeo08fQ
 36GfUsVfMGcSDKCLBkHzrJuhTqG0ltNWkvUhER2YXh5JO96EytVudziMtpf3C3VMdrx+
 bYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zg2dR+/RlCjvNQhC4AT2xzR1UuuQk7HaGZ9Y5groXFk=;
 b=D6dQfQfiHhiuNNJ4P/pxhX5VuklshFatDqh8/z4eZrRobgBJIUe55msV+hcG87cPlg
 VbZGXGxwKFm9RaC3qcwL6RW4hkO6rvWLYa5G6ESp5gbhInI63EfHNub8bpnlwf70rep0
 +fLHxWVV0DvqdwMOQsnWB2o1xz+QwcY4RVG+4b1L68KVaEJ3tpwYiZcZKiim2Hvqu4pw
 kpo+SDM4TJdcDE5pVy+MyOvyaT/prC++mi/IfPodR4AuzJ68IPq1lup108d4sulB6R2Y
 Ezf+XICoku39x/B7O8F3VT2BWqL2ZoxFlnRX2dqMgKozc7rCYIuFxz+1MJNuARW6fH7h
 HBPw==
X-Gm-Message-State: AGi0PuYPJZZWcVCHphGxn3K2v90rRrJwnKSWfTx7vWEPZ76yDyWqpUrt
 fQU/jmMJ4kIgVBN3LZnMIEtLXA==
X-Google-Smtp-Source: APiQypJrQcq3yP9hrTkwIkZ7MP7B8mIwkQReH7h5u2/WQZnB1GT3u1JmgLLrOH1SvSFl3oZfrdMvbQ==
X-Received: by 2002:adf:9d8d:: with SMTP id p13mr5874329wre.17.1587661566668; 
 Thu, 23 Apr 2020 10:06:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w11sm4369417wmi.32.2020.04.23.10.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:06:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CADAE1FF92;
 Thu, 23 Apr 2020 18:05:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/14] gdbstub: Introduce gdb_get_float64() to get 64-bit
 float registers
Date: Thu, 23 Apr 2020 18:05:49 +0100
Message-Id: <20200423170557.31106-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::432
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
Cc: "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When converted to use GByteArray in commits 462474d760c and
a010bdbe719, the call to stfq_p() was removed. This call
serialize a float.
Since we now use a GByteArray, we can not use stfq_p() directly.
Introduce the gdb_get_float64() helper to load a float64 register.

Fixes: 462474d760c ("target/m68k: use gdb_get_reg helpers")
Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200414163853.12164-3-philmd@redhat.com>
---
 include/exec/gdbstub.h          | 11 +++++++++++
 target/m68k/helper.c            |  3 ++-
 target/ppc/gdbstub.c            |  4 ++--
 target/ppc/translate_init.inc.c |  2 +-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 20e1072692..4a2b8e3089 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -134,6 +134,17 @@ static inline int gdb_get_float32(GByteArray *array, float32 val)
 
     return sizeof(buf);
 }
+
+static inline int gdb_get_float64(GByteArray *array, float64 val)
+{
+    uint8_t buf[sizeof(CPU_DoubleU)];
+
+    stfq_p(buf, val);
+    g_byte_array_append(array, buf, sizeof(buf));
+
+    return sizeof(buf);
+}
+
 static inline int gdb_get_zeroes(GByteArray *array, size_t len)
 {
     guint oldlen = array->len;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index cad4083895..79b0b10ea9 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -72,7 +72,8 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
-        return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
+        return gdb_get_float64(mem_buf,
+                               floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
     case 8: /* fpcontrol */
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index eb362dd9ae..5c11c88b2a 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -130,7 +130,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
         gdb_get_regl(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
@@ -184,7 +184,7 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
         gdb_get_reg64(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n - 32));
     } else if (n < 96) {
         /* Altivec */
         gdb_get_reg64(buf, n - 64);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index e853164a86..d825cb5975 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9881,7 +9881,7 @@ static int gdb_get_float_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
     uint8_t *mem_buf;
     if (n < 32) {
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n));
         mem_buf = gdb_get_reg_ptr(buf, 8);
         ppc_maybe_bswap_register(env, mem_buf, 8);
         return 8;
-- 
2.20.1


