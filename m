Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF1EC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525BB21851
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXJ09l0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525BB21851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49559 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSMxb-0005Iy-Fp
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 10:38:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSMw1-0004S8-LN
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSMw0-0007Oc-MM
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:37:09 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSMw0-0007OG-Gu
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:37:08 -0400
Received: by mail-pg1-x541.google.com with SMTP id z3so5518119pgp.8
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zc/iSoe4ODkWO8R1MW7Fj6+3lk6oMXZxFHKtVAZiynY=;
	b=TXJ09l0PhWcmXIfrcwEgstKzcTd2UbAnBrqU76+LdL8vyVy2RDtMRtxySgMgOg6XI9
	FOW+hjahChJuIdLwEPRNuz9S1YnjPZ4G0FVVXfFVrnnHypqROsxhrZJeWLnNyH23CVrG
	lL8hgo6YGezLkWlNzDRy5jAqWezqq3kCDZvHgKp6oxVa201EVnT+jnqmaDbKJUPgQ/oi
	FV40Dr0XcqwUbhhfuFx4F9CRCv0f1KEt3eT6C366x22/nw3XmMYXhd0BVKIEtLu096D/
	jjc2Nt6LGqEC5E0f175mmiAkhvNCW3eDTlqAEZm8PWuNBrS/zdq2lxUOMDZD6mEbBlqK
	oNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zc/iSoe4ODkWO8R1MW7Fj6+3lk6oMXZxFHKtVAZiynY=;
	b=jyiVKSu8JvJYt0VokuiXHpoGOGhBcX9xL9XbG+pTdCKnaRKRpKT7AYdImCw6ReO6jN
	nBVXkI/SWeNZAYkuQTJr00Tpx9bekwRR/b0WOP6PgXeIJh6hM8SOb301oBK8mAzyocUe
	bezOx6QyuzHVjyeIdokAAaiVPWXp+jcXSBuWj/fsndak60Nu9O6EuZTjRjSLzeuBscdV
	xl0kH0BLvbAUVerxo4lJoeQttG+rmPDmSZl8eCYHDtBuMSqgvsTMimO/23LpH03WHzAc
	vP7gsoOWilyS58dKMFmJZhutnUdmuST17LIYpSzkxH5KWQq/6TDxXDaMEQM1EIvcut6n
	ecoQ==
X-Gm-Message-State: APjAAAWvbc/mdFc3TNdX1+bJToFgQ6/gsFMvjzkkY/IGD/C2etcP+Yd4
	4uCuhDfo8gVsoRzkxe9q3f85z3wmWzU=
X-Google-Smtp-Source: APXvYqz/96GAs/2VPCnS0QsPTeorQ64Ik3pabssW8SovEH9zfPNa9XLgOIWcfjAdeAYD4RUeZWWE9g==
X-Received: by 2002:a63:754b:: with SMTP id f11mr70093830pgn.32.1558276627170; 
	Sun, 19 May 2019 07:37:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	184sm18248195pfa.48.2019.05.19.07.37.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 07:37:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 07:37:01 -0700
Message-Id: <20190519143702.5587-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519143702.5587-1-richard.henderson@linaro.org>
References: <20190519143702.5587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PULL 1/2] target/alpha: Clean up alpha_cpu_dump_state
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop the "RI" and "FIR" prefixes; use only the normal linux names.
Add the FPCR to the dump.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 5fe9c87912..74a62c3d7b 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -435,32 +435,33 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
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


