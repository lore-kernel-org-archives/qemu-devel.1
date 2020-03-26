Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CDBC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09EA8206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZ/tHUYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EA8206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYpt-0006Bs-7d
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL0-0007YX-DS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKy-00020n-Ha
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:46 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKy-00020V-DZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:44 -0400
Received: by mail-qk1-x743.google.com with SMTP id o10so8129723qki.10
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V+COCY1tch1+h8AFER7aKTPV6Dtrz1h9iyiTM5X9pZo=;
 b=UZ/tHUYuZJcG4QN+Up3UcXS7s3NnhwffMRiF8DJri/BZgkWstZbv4UWUVdUawdgKVV
 j4FsMgYwQkcXJdVZ0ncDo1IUyITkxGpeuEx7v4ogFtAGl29oWnwvFdu1Pimn9tu/3Ldu
 4Nzk3uvhnz5ED06pgSFKHi+3VD6Xg6mhytjIzMFI6/6+BH+4QB4+X1Wr8PWmmV9NTIxv
 IkFFWAHUaKDIpwxb38FlJNrOBu493dA8fmci0tDKHKkLrv995ZkLKbK+kjMgxY39VxGU
 NXUonOnupkBzk4maFQgw01UFu+vuYqL6hK2xU4Wr0wfbmUqlSwzJu3Sj84W9YaP2gQ22
 YC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V+COCY1tch1+h8AFER7aKTPV6Dtrz1h9iyiTM5X9pZo=;
 b=sTE/7pdU0oRuQcqSV3UJkH6INr5QHyBy1ZiHNaGFu9MDMQeBVutyZROZkRLJrJvSp/
 x1yUrLBxvA9fvcdWA9RgPsG7ypdeUKY5cxgwioIk4rKPlbdqL2S9fLtXZc36lCb1RymO
 UtWV/PVU9wUuSU15ssuwZxcYeHO6B10mcxCOlBih8lE+ucNEZCPJWzEfo99fSpOSwWep
 tJCJfvWOddI0gbnVMK31pqX7zLIS8CNstc8xxZsTOmpH+VG4/FuvJbqa8o1muzjYHO/a
 S1tTVqPyWHMrUc2JbyEAPejtHq1CO4XRYGSpl1Uq6iYlKRfLWVYtIc0b/q5L+EK9JiY/
 mk+w==
X-Gm-Message-State: ANhLgQ1k2mcJGdjVxokgHtWOK/5ODnLxf27zuL3FDIn+BJHOcC/cD7pv
 xeks0A728nMurgG7wlPdGT9wf0xaQzan3w==
X-Google-Smtp-Source: ADFU+vvIOpXqi6sB8dw0TcDGNsjLpUhrwvW2eeU6Qc9Yx+8CmVExCeAIDsrRahTlpXKpA7WenF4uog==
X-Received: by 2002:a37:844:: with SMTP id 65mr9459076qki.15.1585251523644;
 Thu, 26 Mar 2020 12:38:43 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:43 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 51/74] mips: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:33 -0400
Message-Id: <20200326193156.4322-52-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/mips/cpu.c | 7 ++++---
 target/mips/kvm.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e86cd06548..761d8aaa54 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -56,13 +56,14 @@ static bool mips_cpu_has_work(CPUState *cs)
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
     bool has_work = false;
+    uint32_t interrupt_request = cpu_interrupt_request(cs);
 
     /*
      * Prior to MIPS Release 6 it is implementation dependent if non-enabled
      * interrupts wake-up the CPU, however most of the implementations only
      * check for interrupts that can be taken.
      */
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((interrupt_request & CPU_INTERRUPT_HARD) &&
         cpu_mips_hw_interrupts_pending(env)) {
         if (cpu_mips_hw_interrupts_enabled(env) ||
             (env->insn_flags & ISA_MIPS32R6)) {
@@ -76,7 +77,7 @@ static bool mips_cpu_has_work(CPUState *cs)
          * The QEMU model will issue an _WAKE request whenever the CPUs
          * should be woken up.
          */
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (interrupt_request & CPU_INTERRUPT_WAKE) {
             has_work = true;
         }
 
@@ -86,7 +87,7 @@ static bool mips_cpu_has_work(CPUState *cs)
     }
     /* MIPS Release 6 has the ability to halt the CPU.  */
     if (env->CP0_Config5 & (1 << CP0C5_VP)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (interrupt_request & CPU_INTERRUPT_WAKE) {
             has_work = true;
         }
         if (!mips_vp_active(env)) {
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 2b7d680547..e9b7a9f2ad 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -141,7 +141,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 
     qemu_mutex_lock_iothread();
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
             cpu_mips_io_interrupts_pending(cpu)) {
         intr.cpu = -1;
         intr.irq = 2;
-- 
2.17.1


