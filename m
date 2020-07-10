Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E513C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298A920657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB74423o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298A920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwTV-0008EH-Ez
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtwSS-00071Q-Lq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:05:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtwSL-0003ez-MP
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:05:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id j18so6892101wmi.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4SQM+TSx1zwKLLgaqEJ8qxtzreujv3kbM3P4eogqrJs=;
 b=RB74423oMQOAcHCa1LdPhRZXm8FWQyihSnIWUdKa38mLAnNHena9gk5uEFadm9IwzX
 RmH4a9cvff5oKov3C96lxgZg+nsmDpcHYl3ILA8y3JumTENQn22ekn9E4YZG3luE8OTu
 g4EiGlUijBaMNOOcFKNdHM5cfkNnjsNU+sFrfqnbPvblCPIF/nHUwwqzNcFaGHhorwS0
 GW4lEG38J2KXpx7OvEdVjxTAbQQGIOt7Xm+fLtwzwWDmXTC4bzZh62SAN30RgoL7pE0P
 ghG1VbeTHbpXtn8kqF0zNnASzhE9OKwxWa7HY4bIcxBUOcJbojfIvBN9bS1VitCHnp1y
 qDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4SQM+TSx1zwKLLgaqEJ8qxtzreujv3kbM3P4eogqrJs=;
 b=k6gqiICtmMCUMv9vVuZWZuMSow6wxw6lqdvBgCPYJgVuPJp4MhBWHClVPbRnTd46ZG
 eT7rTN/8kedKOaG3eLH3lhcxKSA58/7WH3BJa3gmWzDUIIA9L+j+X7MZPyQCNkcOkPh1
 4sILKbgNrXbaHBSCDW7PlhqXxC5OSTZXLEldiyCX769dmBaSx9+ttE1Bfl/N5zrN81nK
 uWqyzmTzr9uTtCPLHO5ipqEDOhziDGFQe3uyHIsBU4lcCD5ZtqSKUKewxVH+Du9vZigN
 ciIi6Sd8txqdSxMCocrYliqy5ctwnTWOc/hfU72gVDX8HG9fQHJP+KW04wzzecuzKlt0
 31sw==
X-Gm-Message-State: AOAM5338SsrQh/USDyiMOC6CYjrbPKXk6nuYBklj2otnug/04Qz5FE2I
 ioaWwsiVsVqomVTB9beEbvNH+PWa0Lk=
X-Google-Smtp-Source: ABdhPJzgUzss89NE6nCaAaYuuf33JdclBvTcfWX+4ylBN7bFJfyKxa1MiJRrsmX9jG8uRXkJn1TQXQ==
X-Received: by 2002:a05:600c:414f:: with SMTP id
 h15mr6529329wmm.82.1594400699596; 
 Fri, 10 Jul 2020 10:04:59 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f17sm11449477wme.14.2020.07.10.10.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 10:04:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/32] target/avr: Add instruction helpers
Date: Fri, 10 Jul 2020 19:04:47 +0200
Message-Id: <20200710170447.23412-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200710170447.23412-1-f4bug@amsat.org>
References: <20200710170447.23412-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Add helpers for instructions that need to interact with QEMU. Also,
add stubs for unimplemented instructions. Instructions SPM and WDR
are left unimplemented because they require emulation of complex
peripherals. The implementation of instruction SLEEP is very limited
due to the lack of peripherals to generate wake interrupts. Memory
access instructions are implemented here because some address ranges
actually refer to CPU registers.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-10-huth@tuxfamily.org>
[PMD: Replace cpu_physical_memory() API by address_space_ldst()
      API to fix running on big-endian host,
      reported and suggested by Peter Maydell]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/helper.h |  29 ++++++
 target/avr/helper.c | 209 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 target/avr/helper.h

diff --git a/target/avr/helper.h b/target/avr/helper.h
new file mode 100644
index 0000000000..8e1ae7fda0
--- /dev/null
+++ b/target/avr/helper.h
@@ -0,0 +1,29 @@
+/*
+ * QEMU AVR CPU helpers
+ *
+ * Copyright (c) 2016-2020 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+DEF_HELPER_1(wdr, void, env)
+DEF_HELPER_1(debug, void, env)
+DEF_HELPER_1(break, void, env)
+DEF_HELPER_1(sleep, void, env)
+DEF_HELPER_1(unsupported, void, env)
+DEF_HELPER_3(outb, void, env, i32, i32)
+DEF_HELPER_2(inb, tl, env, i32)
+DEF_HELPER_3(fullwr, void, env, i32, i32)
+DEF_HELPER_2(fullrd, tl, env, i32)
diff --git a/target/avr/helper.c b/target/avr/helper.c
index d6985ff3f4..77bd9bc050 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -137,3 +138,211 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     return true;
 }
+
+/*
+ *  helpers
+ */
+
+void helper_sleep(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = EXCP_HLT;
+    cpu_loop_exit(cs);
+}
+
+void helper_unsupported(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    /*
+     *  I count not find what happens on the real platform, so
+     *  it's EXCP_DEBUG for meanwhile
+     */
+    cs->exception_index = EXCP_DEBUG;
+    if (qemu_loglevel_mask(LOG_UNIMP)) {
+        qemu_log("UNSUPPORTED\n");
+        cpu_dump_state(cs, stderr, 0);
+    }
+    cpu_loop_exit(cs);
+}
+
+void helper_debug(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+void helper_break(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+void helper_wdr(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    /* WD is not implemented yet, placeholder */
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+/*
+ * This function implements IN instruction
+ *
+ * It does the following
+ * a.  if an IO register belongs to CPU, its value is read and returned
+ * b.  otherwise io address is translated to mem address and physical memory
+ *     is read.
+ * c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
+ *
+ */
+target_ulong helper_inb(CPUAVRState *env, uint32_t port)
+{
+    target_ulong data = 0;
+
+    switch (port) {
+    case 0x38: /* RAMPD */
+        data = 0xff & (env->rampD >> 16);
+        break;
+    case 0x39: /* RAMPX */
+        data = 0xff & (env->rampX >> 16);
+        break;
+    case 0x3a: /* RAMPY */
+        data = 0xff & (env->rampY >> 16);
+        break;
+    case 0x3b: /* RAMPZ */
+        data = 0xff & (env->rampZ >> 16);
+        break;
+    case 0x3c: /* EIND */
+        data = 0xff & (env->eind >> 16);
+        break;
+    case 0x3d: /* SPL */
+        data = env->sp & 0x00ff;
+        break;
+    case 0x3e: /* SPH */
+        data = env->sp >> 8;
+        break;
+    case 0x3f: /* SREG */
+        data = cpu_get_sreg(env);
+        break;
+    default:
+        /* not a special register, pass to normal memory access */
+        data = address_space_ldub(&address_space_memory,
+                                  OFFSET_IO_REGISTERS + port,
+                                  MEMTXATTRS_UNSPECIFIED, NULL);
+    }
+
+    return data;
+}
+
+/*
+ *  This function implements OUT instruction
+ *
+ *  It does the following
+ *  a.  if an IO register belongs to CPU, its value is written into the register
+ *  b.  otherwise io address is translated to mem address and physical memory
+ *      is written.
+ *  c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
+ *
+ */
+void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
+{
+    data &= 0x000000ff;
+
+    switch (port) {
+    case 0x38: /* RAMPD */
+        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
+            env->rampD = (data & 0xff) << 16;
+        }
+        break;
+    case 0x39: /* RAMPX */
+        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
+            env->rampX = (data & 0xff) << 16;
+        }
+        break;
+    case 0x3a: /* RAMPY */
+        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
+            env->rampY = (data & 0xff) << 16;
+        }
+        break;
+    case 0x3b: /* RAMPZ */
+        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
+            env->rampZ = (data & 0xff) << 16;
+        }
+        break;
+    case 0x3c: /* EIDN */
+        env->eind = (data & 0xff) << 16;
+        break;
+    case 0x3d: /* SPL */
+        env->sp = (env->sp & 0xff00) | (data);
+        break;
+    case 0x3e: /* SPH */
+        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
+            env->sp = (env->sp & 0x00ff) | (data << 8);
+        }
+        break;
+    case 0x3f: /* SREG */
+        cpu_set_sreg(env, data);
+        break;
+    default:
+        /* not a special register, pass to normal memory access */
+        address_space_stb(&address_space_memory, OFFSET_IO_REGISTERS + port,
+                          data, MEMTXATTRS_UNSPECIFIED, NULL);
+    }
+}
+
+/*
+ *  this function implements LD instruction when there is a posibility to read
+ *  from a CPU register
+ */
+target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
+{
+    uint8_t data;
+
+    env->fullacc = false;
+
+    if (addr < NUMBER_OF_CPU_REGISTERS) {
+        /* CPU registers */
+        data = cpu_to_le32(env->r[addr]);
+    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
+        /* IO registers */
+        data = helper_inb(env, addr - NUMBER_OF_CPU_REGISTERS);
+    } else {
+        /* memory */
+        data = address_space_ldub(&address_space_memory, OFFSET_DATA + addr,
+                                  MEMTXATTRS_UNSPECIFIED, NULL);
+    }
+    return data;
+}
+
+/*
+ *  this function implements ST instruction when there is a posibility to write
+ *  into a CPU register
+ */
+void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
+{
+    env->fullacc = false;
+
+    /* Following logic assumes this: */
+    assert(OFFSET_CPU_REGISTERS == OFFSET_DATA);
+    assert(OFFSET_IO_REGISTERS == OFFSET_CPU_REGISTERS +
+                                  NUMBER_OF_CPU_REGISTERS);
+
+    if (addr < NUMBER_OF_CPU_REGISTERS) {
+        /* CPU registers */
+        env->r[addr] = data;
+    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
+        /* IO registers */
+        helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
+    } else {
+        /* memory */
+        address_space_stb(&address_space_memory, OFFSET_DATA + addr, data,
+                          MEMTXATTRS_UNSPECIFIED, NULL);
+    }
+}
-- 
2.21.3


