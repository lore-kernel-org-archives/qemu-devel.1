Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B949C3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6862469D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xytwpTq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6862469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7s7b-0008VU-E9
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 21:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6d-00076R-4D
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6b-00031j-MZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:54 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:43915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7s6b-0002z9-Fo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:53 -0500
Received: by mail-pl1-x631.google.com with SMTP id p11so1946346plq.10
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 18:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y86kGv51d7MIe9EUA91Ip3mHFnX72SJuw4wm5LrzN7Y=;
 b=xytwpTq9ApDp6icUVBSMnHhllCuXLfMChXfGzk7TPNxyid+H95ZLPTCaqkxBUiJgFR
 k8ai6yM16ObljfzrME1n1FJk//F1twlIx6HcVqXYKYfdep2k1InR1elaePvhKFBquOdY
 IzhsO/YBe8gWP6eANg2wqL8efAqwiKf8PYOxdGqB6vZT7q5lakTksIzl2QM+ZhF2oVFy
 G7Km9toE+Ib+JOv9UXnO4Kauct60xSxHgOJCo5L40XsHFARvrZDxM/Iem0U4o8nkzADl
 zCiQkuXMYx1uR/X+LhAgG5KaJzhZsvPJfOKri8Qz13B0o9V6we9VnA/eZV0O0RVhbNCA
 idgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y86kGv51d7MIe9EUA91Ip3mHFnX72SJuw4wm5LrzN7Y=;
 b=VVQSGqYcVGEdRPiFmb7zwG8xAAqtXrKgFXRcx49j3qzhZSxIelilKX5bQf6Z0Vdf03
 8a8bg1JpVugAQwekDLtEvG2hB9DbmeQorzRfga5caEbPzM/uU1vy97g6Xu1VfA8mwDCn
 LIwZUc2QTxP/dRWYQXU6U69jXGBQ9Nu9K/QPkfqylCo+f7jRA0fml7vQDloldUQ5P2yM
 kodqK1eCgPX5BCMrCNZiEwccuQtgjJ0XmoC14Swo8Mqniek4+pOkfnLkfVUi/kBYLG4y
 dlORqjBkhg3DVHUB1yWd5r9O0kAzF9MxPx2JTw2yWLG0pYAzSu18ysCjnypTF3KVc0I+
 6x7Q==
X-Gm-Message-State: APjAAAXomwCB456ttZ9dnTGwOsRX8qRdX9TosjV+Zw57yv0lY+6kl6Mo
 GwM3852WYT0fs0YRx8ebzEgpQhls74I=
X-Google-Smtp-Source: APXvYqw2a+1OjvyxVOmqitVYLB6RQH/0wCl4Rk2yL2UwZrNwTLdeldHHkZio6n3PXIQ7tBOQm60vlg==
X-Received: by 2002:a17:902:b498:: with SMTP id
 y24mr6817446plr.343.1582944231603; 
 Fri, 28 Feb 2020 18:43:51 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id k9sm3649321pjo.19.2020.02.28.18.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 18:43:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] accel/tcg: fix race in cpu_exec_step_atomic (bug 1863025)
Date: Fri, 28 Feb 2020 18:43:40 -0800
Message-Id: <20200229024347.22826-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229024347.22826-1-richard.henderson@linaro.org>
References: <20200229024347.22826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::631
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yifan <me@yifanlu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

The bug describes a race whereby cpu_exec_step_atomic can acquire a TB
which is invalidated by a tb_flush before we execute it. This doesn't
affect the other cpu_exec modes as a tb_flush by it's nature can only
occur on a quiescent system. The race was described as:

  B2. tcg_cpu_exec => cpu_exec => tb_find => tb_gen_code
  B3. tcg_tb_alloc obtains a new TB

      C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
          (same TB as B2)

          A3. start_exclusive critical section entered
          A4. do_tb_flush is called, TB memory freed/re-allocated
          A5. end_exclusive exits critical section

  B2. tcg_cpu_exec => cpu_exec => tb_find => tb_gen_code
  B3. tcg_tb_alloc reallocates TB from B2

      C4. start_exclusive critical section entered
      C5. cpu_tb_exec executes the TB code that was free in A4

The simplest fix is to widen the exclusive period to include the TB
lookup. As a result we can drop the complication of checking we are in
the exclusive region before we end it.

Cc: Yifan <me@yifanlu.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1863025
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200214144952.15502-1-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2560c90eec..d95c4848a4 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -240,6 +240,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t cf_mask = cflags & CF_HASH_MASK;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+        start_exclusive();
+
         tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
         if (tb == NULL) {
             mmap_lock();
@@ -247,8 +249,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
             mmap_unlock();
         }
 
-        start_exclusive();
-
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus = false;
         cc->cpu_exec_enter(cpu);
@@ -271,14 +271,15 @@ void cpu_exec_step_atomic(CPUState *cpu)
         qemu_plugin_disable_mem_helpers(cpu);
     }
 
-    if (cpu_in_exclusive_context(cpu)) {
-        /* We might longjump out of either the codegen or the
-         * execution, so must make sure we only end the exclusive
-         * region if we started it.
-         */
-        parallel_cpus = true;
-        end_exclusive();
-    }
+
+    /*
+     * As we start the exclusive region before codegen we must still
+     * be in the region if we longjump out of either the codegen or
+     * the execution.
+     */
+    g_assert(cpu_in_exclusive_context(cpu));
+    parallel_cpus = true;
+    end_exclusive();
 }
 
 struct tb_desc {
-- 
2.20.1


