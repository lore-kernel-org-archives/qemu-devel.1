Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0876FC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3515206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZP+Xcmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3515206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmfy-0006Lz-Uw
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJk-00076A-Bm
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJj-00018x-8z
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:24 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJf-00015C-F4
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id e13so725763pga.7
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mbGjA7d6AQiFvZB5+xEjn3eOcLNF0/a+vXYuP56z9BY=;
 b=nZP+XcmwTKiIjP+VQdUQS35Akek47LhX0vjgUdvW9MBW8veUyAwEYWWyEtVBfTpTVz
 KYtFL/+amHtfr0PHG0WD12tF4E9ojPviuGwNGeBJQlJDQZkdNAFXGHXUhEXjzP9mt4lw
 1nEtGGcVM7w4s6gzXNr46b+pSFmNueNRB9evbUTXb4jiltB2Ak3jbER4aR1GZqQO3Wzf
 ir3KVN4o1hBC7miFEC6B5hQ8apPEaW9V5CSAn39J5Uqv8de6PAS9XTpLp4hvWRAK7T5z
 uPMe4g494P5q6CVfxcrSZ4EK2lnZUJ8XMTRYnRV9trvoFQ+ba+/M0S08H3JrPct5ZW0C
 PjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mbGjA7d6AQiFvZB5+xEjn3eOcLNF0/a+vXYuP56z9BY=;
 b=Ppa2EMDuNe0t6xkAcSgduBUmp6bjtj7w/DWhtN6iFr8CdhvJF4UBuT2SZKlsVQt2no
 m+A90i2rDD1dc1+v7jk5iTtMJEIbIHjh03Okooho92JYEHsstQPDGH4OS0DW7/on0Owa
 rK8eb+gU79zvV39jXiUr8aw1hQwCNZS/bGKVr64mYjbp0zcNkpZH2iz/VX99qiVpkEwM
 ystlC4lGjxRk7Ww3S8aFrpG+L625gBePKA5H4ATsMp2TL/uX3ftuRix/+tLRTA+qNukY
 040SR8bMRDzVaHoeownntIKmBRAtEgv3tBGo5EPEo9Q2RqpDVudakUKCZonqLmk/dPVF
 z8bw==
X-Gm-Message-State: APjAAAWJ6zLmQCeqV/rhSiNUgNS97MEJejlzIpe4O1Vs95tN6oPC2VZb
 lSWq64PYQQWrR7r7k/LP/+m8hFRRY/4=
X-Google-Smtp-Source: APXvYqz3pFKflABq/EceH36FtATsW8NW30Ah8592YNPKBPXxx9yWu56q8xeeDM7Uz60qyEKwl9JbTg==
X-Received: by 2002:aa7:9157:: with SMTP id 23mr30094311pfi.61.1571005576666; 
 Sun, 13 Oct 2019 15:26:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/23] cpus: kick all vCPUs when running thread=single
Date: Sun, 13 Oct 2019 15:25:44 -0700
Message-Id: <20191013222544.3679-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

qemu_cpu_kick is used for a number of reasons including to indicate
there is work to be done. However when thread=single the old
qemu_cpu_kick_rr_cpu only advanced the vCPU to the next executing one
which can lead to a hang in the case that:

  a) the kick is from outside the vCPUs (e.g. iothread)
  b) the timers are paused (i.e. iothread calling run_on_cpu)

To avoid this lets split qemu_cpu_kick_rr into two functions. One for
the timer which continues to advance to the next timeslice and another
for all other kicks.

Message-Id: <20191001160426.26644-1-alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpus.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/cpus.c b/cpus.c
index d2c61ff155..bee7209134 100644
--- a/cpus.c
+++ b/cpus.c
@@ -949,8 +949,8 @@ static inline int64_t qemu_tcg_next_kick(void)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
 }
 
-/* Kick the currently round-robin scheduled vCPU */
-static void qemu_cpu_kick_rr_cpu(void)
+/* Kick the currently round-robin scheduled vCPU to next */
+static void qemu_cpu_kick_rr_next_cpu(void)
 {
     CPUState *cpu;
     do {
@@ -961,6 +961,16 @@ static void qemu_cpu_kick_rr_cpu(void)
     } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
 }
 
+/* Kick all RR vCPUs */
+static void qemu_cpu_kick_rr_cpus(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        cpu_exit(cpu);
+    };
+}
+
 static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
 {
 }
@@ -993,7 +1003,7 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
 static void kick_tcg_thread(void *opaque)
 {
     timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
-    qemu_cpu_kick_rr_cpu();
+    qemu_cpu_kick_rr_next_cpu();
 }
 
 static void start_tcg_kick_timer(void)
@@ -1828,9 +1838,11 @@ void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
     if (tcg_enabled()) {
-        cpu_exit(cpu);
-        /* NOP unless doing single-thread RR */
-        qemu_cpu_kick_rr_cpu();
+        if (qemu_tcg_mttcg_enabled()) {
+            cpu_exit(cpu);
+        } else {
+            qemu_cpu_kick_rr_cpus();
+        }
     } else {
         if (hax_enabled()) {
             /*
-- 
2.17.1


