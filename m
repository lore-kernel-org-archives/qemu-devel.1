Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B3C43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 00:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB6720873
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 00:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXz5eCQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB6720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKBbN-0006DO-QD
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 20:54:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hKBZs-0005He-1T
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hKBYv-0000zx-9C
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:51:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hKBYv-0000zY-2X
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:51:29 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so2494108pfd.1
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=yR3SBCBXYUmKX63niTZceDYrt1W/+HQOJtz/bKyhTGI=;
	b=LXz5eCQtDQIJUGDa1TZ4LI5N5lpwRVeXEwyAdwmnaWnx8+JEaexsoQQtlDJPZRErp7
	ZQyYYvBVwdE4TUjOMkufgS80A/pju5hY908Oy9agv9M44KPODu9GgWJN6gHtqPyhI5O0
	VTOt13063mLlb5k46KYGQ4iBP+Yb10rfsev+jwhK2aEhWb9emYBx36qOvZk8Hw5KZRlm
	31Ze6W8YJHxe4ZoJUopbnBCiElHSEQ9rGRP9JzX4dwPwMUtxTSz/HPDHGii3gtw/VkOp
	M3uvM1+5L783RjmpUan+I6LuRs9xDh1+Rka8onEFxEyfNZPKyi/rLvGOIEoF8JMxj57J
	IFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=yR3SBCBXYUmKX63niTZceDYrt1W/+HQOJtz/bKyhTGI=;
	b=bng0EB9nMxLDgAMzo/EeisNkmNqjSmsa4AJbLXRssdhL1ys+ecfq5ZiPJWGpxOq69n
	MBe4A+Kzdqao6CWZ7N6QP8L2wys/eoIxAc2Wq3bo215HsDRb548/WMzKD1UmYPsfEs0i
	9gmvXbCC21gNQQ31k/BDt4ZNYVKRJGW+eGcf1nBODS/3KY+WgclBOh0cBEQh0b22xmbQ
	f5QZ1Rh0fg7hCGiGeRy3BO5AtIcFxnVKTKq6zDl5jKLGPLvCvK9sZzzvswH6qj3PH3o5
	X4agTriP1E+Ui9yRq0MXx1Cz2AB8swTJAYT6H0M1EswH+EGH5m65fa6vQDp1qaBgL5aK
	lJXQ==
X-Gm-Message-State: APjAAAVciusX5c92zjoSkbHyCyOM6u/2LcAQ4wCPpsRr5rJGPHsz4VdS
	b+pHuX3jPruJqeYabirQ+cSFow6LmXI=
X-Google-Smtp-Source: APXvYqy+v8+g3XgYrUNjmI9PD+v3+ueopiowWLRTtOnGBt5YtyBfrUprsdDF5TTzNUEodPlCDvlOSg==
X-Received: by 2002:aa7:938b:: with SMTP id t11mr50145807pfe.67.1556326287334; 
	Fri, 26 Apr 2019 17:51:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	b20sm5301745pff.118.2019.04.26.17.51.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 17:51:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 17:51:23 -0700
Message-Id: <20190427005124.12756-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190427005124.12756-1-richard.henderson@linaro.org>
References: <20190427005124.12756-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 1/2] target/alpha: Clean up alpha_cpu_dump_state
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190427005123._vPcXMQDHMQIZcS_ts1__xlEr2f1udpyn7TA4ifRUPc@z>

Drop the "RI" and "FIR" prefixes; use only the normal linux names.
Add the FPCR to the dump.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 7201576aae..31de9593b6 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -429,32 +429,33 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    static const char *linux_reg_names[] = {
-        "v0 ", "t0 ", "t1 ", "t2 ", "t3 ", "t4 ", "t5 ", "t6 ",
-        "t7 ", "s0 ", "s1 ", "s2 ", "s3 ", "s4 ", "s5 ", "fp ",
-        "a0 ", "a1 ", "a2 ", "a3 ", "a4 ", "a5 ", "t8 ", "t9 ",
-        "t10", "t11", "ra ", "t12", "at ", "gp ", "sp ", "zero",
+    static const char linux_reg_names[31][4] = {
+        "v0",  "t0",  "t1", "t2",  "t3", "t4", "t5", "t6",
+        "t7",  "s0",  "s1", "s2",  "s3", "s4", "s5", "fp",
+        "a0",  "a1",  "a2", "a3",  "a4", "a5", "t8", "t9",
+        "t10", "t11", "ra", "t12", "at", "gp", "sp"
     };
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
     int i;
 
-    qemu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
+    qemu_fprintf(f, "PC      " TARGET_FMT_lx " PS      %02x\n",
                  env->pc, extract32(env->flags, ENV_FLAG_PS_SHIFT, 8));
     for (i = 0; i < 31; i++) {
-        qemu_fprintf(f, "IR%02d %s " TARGET_FMT_lx "%c", i,
+        qemu_fprintf(f, "%-8s" TARGET_FMT_lx "%c",
                      linux_reg_names[i], cpu_alpha_load_gr(env, i),
                      (i % 3) == 2 ? '\n' : ' ');
     }
 
-    qemu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
+    qemu_fprintf(f, "lock_a  " TARGET_FMT_lx " lock_v  " TARGET_FMT_lx "\n",
                  env->lock_addr, env->lock_value);
 
     if (flags & CPU_DUMP_FPU) {
         for (i = 0; i < 31; i++) {
-            qemu_fprintf(f, "FIR%02d    %016" PRIx64 "%c", i, env->fir[i],
+            qemu_fprintf(f, "f%-7d%016" PRIx64 "%c", i, env->fir[i],
                          (i % 3) == 2 ? '\n' : ' ');
         }
+        qemu_fprintf(f, "fpcr    %016" PRIx64 "\n", cpu_alpha_load_fpcr(env));
     }
     qemu_fprintf(f, "\n");
 }
-- 
2.17.1


