Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A2FC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15612206F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy188HPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15612206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhsv-00058R-1G
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQJ-0002yd-Fg
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQH-0001T3-Kr
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id w5so12225513wrp.8
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tgn9X5Mgui13Q+dtY55MzZygmKQubhoFj4bw4p092H0=;
 b=hy188HPhkYVS2OOefQzrhKPFfpS799eBb4iLxp6A3Yaxkwv3HFlNk8vNUBEDSp469o
 7vE8IJwKW8yBe8LJGNWNX8LA+H/+XxUtG06J2vsYqRXr4KyK+y/2ATTEIedp2L79bsr9
 AGsl4c9wZzIVvskbTg7ILjbTsaAcMZtoQ2voDkQWpgnoDt6eAucs+JEC4q/srKEjNeQN
 2hpwvpgGX4FLj2gQX2oeZowsUMG+I7T2i2AgN9xBzJUDVREILGwVFtOjgaL6zIDAp+Sn
 FXG09LkDhs99BZTiSfv9QZbuvrx1mI1m1Zsf7oJv0svyvCjhr4qp4kNxEHI5tJ1ymzHO
 5ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tgn9X5Mgui13Q+dtY55MzZygmKQubhoFj4bw4p092H0=;
 b=J7Q1j6kK0ldv8hkdNjG4npnSvQsK8LQbIJnn24cQunfydt5pQMvRWKLy0AlZnCn7yX
 Q0FwU1vzVgBkqZt9py67qPDjBj/mc+Rm3tlhd5bylBmytzS514wciR9fqm7mV8fY8Vhf
 txB3fvALX7Rw8YrrMfuJs1oj0Q0lagBJZME7Rb0HSS4UZfUOHfsNDWlHwHxEHiT+YI9k
 l832FfSt6OBYuR2pt7rv8q8OfbE0EkduE3M2LJuU957ByKPHkkn4xpOzSFPqX2LNC+DQ
 Juk7G249aBsCtrFri1hBMj2cq/0RveaAvaESzSp1+Zo+9CgOYEaoEEijzoMhdV23pBKI
 km/A==
X-Gm-Message-State: AOAM532BWFlKEPC/6D7m59zTdgjkUfFcDT0O3JHnKvoSPHDWCv5FZs+M
 cCLWUFQ6EL+V7RblLfE5Yf06CDOoiPg=
X-Google-Smtp-Source: ABdhPJxAk1CYIrx2ddZyo8Y37CV26h9DSy3VHODQf/GiBVnAG77heCVDo7JC2wphp50ANmSuEH/pYA==
X-Received: by 2002:adf:d18c:: with SMTP id v12mr3241864wrc.131.1601969407980; 
 Tue, 06 Oct 2020 00:30:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/37] replay: don't record interrupt poll
Date: Tue,  6 Oct 2020 09:29:34 +0200
Message-Id: <20201006072947.487729-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

Interrupt poll is not a real interrupt event. It is needed only for
thread safety. This interrupt is used for i386 and converted
to hardware interrupt by cpu_handle_interrupt function.
Therefore it is not needed to be recorded, because hardware
interrupt will be recorded after converting.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

--

v4 changes:
 - Condition check refactoring (suggested by Alex Bennée)
Message-Id: <160174517124.12451.12983410242461131737.stgit@pasha-ThinkPad-X280>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0dbe67acf5..58aea605d8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -436,8 +436,7 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 {
     if (cpu->halted) {
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
-        if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
-            && replay_interrupt()) {
+        if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
             X86CPU *x86_cpu = X86_CPU(cpu);
             qemu_mutex_lock_iothread();
             apic_poll_irq(x86_cpu->apic_state);
@@ -533,6 +532,20 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
+/*
+ * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
+ * "real" interrupt event later. It does not need to be recorded for
+ * replay purposes.
+ */
+static inline bool need_replay_interrupt(int interrupt_request)
+{
+#if defined(TARGET_I386)
+    return !(interrupt_request & CPU_INTERRUPT_POLL);
+#else
+    return true;
+#endif
+}
+
 static inline bool cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
@@ -594,7 +607,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
            and via longjmp via cpu_loop_exit.  */
         else {
             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
-                replay_interrupt();
+                if (need_replay_interrupt(interrupt_request)) {
+                    replay_interrupt();
+                }
                 /*
                  * After processing the interrupt, ensure an EXCP_DEBUG is
                  * raised when single-stepping so that GDB doesn't miss the
-- 
2.26.2



